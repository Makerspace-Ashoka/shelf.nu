/**
 * PartDB to Shelf.nu Migration Script
 *
 * Reads a MariaDB SQL backup from PartDB and inserts the data into the local
 * Shelf.nu PostgreSQL database using Prisma.
 *
 * Tables migrated: categories, storelocations, manufacturers, parts, part_lots
 *
 * Run with: npx tsx scripts/migrate-partdb.ts
 */

import fs from "fs";
import path from "path";
import { createId } from "@paralleldrive/cuid2";
import { PrismaClient } from "@prisma/client";

// ---------------------------------------------------------------------------
// Configuration
// ---------------------------------------------------------------------------

const DB_URL = "postgresql://postgres:postgres@127.0.0.1:54322/postgres";
const SQL_FILE = path.resolve(
  __dirname,
  "../partdb_backup_2025-07-24_16-54-04.sql"
);
const USER_ID = "11438b69-6887-4ad5-926b-75fc18eb32e7";
const ORG_ID = "org-admin-personal";

/** Categories whose parts (when qty=1) should be treated as INDIVIDUAL assets */
const INDIVIDUAL_CATEGORIES = new Set([
  "Sewing machines",
  "Printers",
  "Mac Minis/Studios",
  "Short Throw",
]);

/** Random hex color palette used to assign colors to categories */
const CATEGORY_COLORS = [
  "#4f46e5",
  "#0891b2",
  "#059669",
  "#d97706",
  "#dc2626",
  "#7c3aed",
  "#db2777",
  "#2563eb",
  "#16a34a",
  "#ea580c",
];

// ---------------------------------------------------------------------------
// SQL Value Parser (state machine)
// ---------------------------------------------------------------------------

/**
 * Parses the VALUES portion of a MariaDB INSERT statement into an array of
 * row arrays.  Handles single-quoted strings with escaped quotes (\' and ''),
 * NULL literals, and numeric values.
 */
function parseInsertValues(sql: string): string[][] {
  const rows: string[][] = [];

  // Find the VALUES keyword
  const valuesIdx = sql.indexOf(" VALUES ");
  if (valuesIdx === -1) return rows;

  const data = sql.slice(valuesIdx + 8); // skip " VALUES "
  let i = 0;
  const len = data.length;

  function skipWhitespace() {
    while (i < len && /\s/.test(data[i])) i++;
  }

  /** Parse a single row "(val1,val2,...)" */
  function parseRow(): string[] {
    const fields: string[] = [];
    // Expect opening paren
    if (data[i] !== "(") throw new Error(`Expected '(' at pos ${i}`);
    i++; // skip '('

    while (i < len && data[i] !== ")") {
      skipWhitespace();
      if (data[i] === "'") {
        // Quoted string
        i++; // skip opening quote
        let val = "";
        while (i < len) {
          if (data[i] === "\\") {
            // Escaped character
            i++;
            if (i < len) {
              val += data[i];
              i++;
            }
          } else if (data[i] === "'") {
            // Check for doubled quote ''
            if (i + 1 < len && data[i + 1] === "'") {
              val += "'";
              i += 2;
            } else {
              i++; // skip closing quote
              break;
            }
          } else {
            val += data[i];
            i++;
          }
        }
        fields.push(val);
      } else {
        // Unquoted value (number or NULL)
        let val = "";
        while (i < len && data[i] !== "," && data[i] !== ")") {
          val += data[i];
          i++;
        }
        fields.push(val.trim());
      }

      skipWhitespace();
      if (data[i] === ",") {
        i++; // skip comma between fields
      }
    }
    if (data[i] === ")") i++; // skip closing paren
    return fields;
  }

  skipWhitespace();
  while (i < len) {
    if (data[i] === "(") {
      rows.push(parseRow());
    } else if (data[i] === ",") {
      i++;
    } else if (data[i] === ";") {
      break;
    } else {
      i++;
    }
  }

  return rows;
}

/**
 * Extracts the INSERT line for a given table from the full SQL dump,
 * then parses its VALUES into row arrays.
 */
function extractTable(sql: string, tableName: string): string[][] {
  const marker = `INSERT INTO \`${tableName}\` VALUES `;
  const startIdx = sql.indexOf(marker);
  if (startIdx === -1) {
    console.warn(`  Warning: No INSERT found for table "${tableName}"`);
    return [];
  }
  // Find the end of this statement (the semicolon after the last row)
  const endIdx = sql.indexOf(";\n", startIdx);
  const line =
    endIdx === -1 ? sql.slice(startIdx) : sql.slice(startIdx, endIdx + 1);
  return parseInsertValues(line);
}

/** Returns null for SQL NULL, otherwise the string value */
function nullable(val: string): string | null {
  return val === "NULL" ? null : val;
}

/** Parses a MariaDB datetime string into a JS Date */
function parseDate(val: string): Date {
  return new Date(val.replace(" ", "T") + "Z");
}

// ---------------------------------------------------------------------------
// Main migration
// ---------------------------------------------------------------------------

async function main() {
  console.log("=== PartDB -> Shelf.nu Migration ===\n");

  // Read SQL dump
  console.log(`Reading SQL file: ${SQL_FILE}`);
  const sql = fs.readFileSync(SQL_FILE, "utf-8");

  // Parse tables
  console.log("Parsing SQL tables...");
  const catRows = extractTable(sql, "categories");
  const locRows = extractTable(sql, "storelocations");
  const mfrRows = extractTable(sql, "manufacturers");
  const partRows = extractTable(sql, "parts");
  const lotRows = extractTable(sql, "part_lots");

  console.log(
    `  categories:    ${catRows.length} rows\n` +
      `  storelocations: ${locRows.length} rows\n` +
      `  manufacturers: ${mfrRows.length} rows\n` +
      `  parts:         ${partRows.length} rows\n` +
      `  part_lots:     ${lotRows.length} rows\n`
  );

  // Connect to database
  const prisma = new PrismaClient({ datasourceUrl: DB_URL });
  await prisma.$connect();
  console.log("Connected to database.\n");

  // Counters for summary
  const summary = {
    categories: 0,
    locations: 0,
    tags: 0,
    customFields: 0,
    assets: 0,
    assetCustomFieldValues: 0,
    notes: 0,
    assetTagLinks: 0,
  };

  try {
    // ------------------------------------------------------------------
    // 1. Categories
    // ------------------------------------------------------------------
    console.log("--- Importing Categories ---");

    // Build lookup of old id -> { name, parentId, comment }
    type CatInfo = {
      id: number;
      parentId: number | null;
      name: string;
      comment: string;
      lastModified: string;
      datetimeAdded: string;
    };
    const catMap = new Map<number, CatInfo>();
    for (const row of catRows) {
      // Fields: id(0), parent_id(1), ..., comment(10), not_selectable(11), name(12),
      // last_modified(13), datetime_added(14), ...
      catMap.set(Number(row[0]), {
        id: Number(row[0]),
        parentId: nullable(row[1]) ? Number(row[1]) : null,
        name: row[12],
        comment: row[10],
        lastModified: row[13],
        datetimeAdded: row[14],
      });
    }

    /** Recursively build the flattened name "Parent > Child" */
    function flatCatName(catId: number): string {
      const cat = catMap.get(catId);
      if (!cat) return "Unknown";
      if (cat.parentId !== null) {
        return `${flatCatName(cat.parentId)} > ${cat.name}`;
      }
      return cat.name;
    }

    // oldCatId -> new Shelf Category id
    const categoryIdMap = new Map<number, string>();
    let colorIdx = 0;

    for (const cat of catMap.values()) {
      const newId = createId();
      const flatName = flatCatName(cat.id);
      await prisma.category.create({
        data: {
          id: newId,
          name: flatName,
          description: cat.comment || null,
          color: CATEGORY_COLORS[colorIdx % CATEGORY_COLORS.length],
          userId: USER_ID,
          organizationId: ORG_ID,
          createdAt: parseDate(cat.datetimeAdded),
          updatedAt: parseDate(cat.lastModified),
        },
      });
      categoryIdMap.set(cat.id, newId);
      colorIdx++;
      summary.categories++;
    }
    console.log(`  Created ${summary.categories} categories.\n`);

    // ------------------------------------------------------------------
    // 2. Locations (storelocations) — preserve hierarchy
    // ------------------------------------------------------------------
    console.log("--- Importing Locations ---");

    type LocInfo = {
      id: number;
      parentId: number | null;
      name: string;
      comment: string;
      lastModified: string;
      datetimeAdded: string;
    };
    const locMap = new Map<number, LocInfo>();
    for (const row of locRows) {
      // Fields: id(0), parent_id(1), storage_type_id(2), is_full(3),
      // only_single_part(4), limit_to_existing_parts(5), comment(6),
      // not_selectable(7), name(8), last_modified(9), datetime_added(10), ...
      locMap.set(Number(row[0]), {
        id: Number(row[0]),
        parentId: nullable(row[1]) ? Number(row[1]) : null,
        name: row[8],
        comment: row[6],
        lastModified: row[9],
        datetimeAdded: row[10],
      });
    }

    // Topological sort: insert parents before children
    const locationIdMap = new Map<number, string>();
    const locInserted = new Set<number>();

    function insertLocation(locId: number): Promise<void> {
      return (async () => {
        if (locInserted.has(locId)) return;
        const loc = locMap.get(locId);
        if (!loc) return;

        // Insert parent first if needed
        if (loc.parentId !== null && !locInserted.has(loc.parentId)) {
          await insertLocation(loc.parentId);
        }

        const newId = createId();
        const parentShelfId =
          loc.parentId !== null ? locationIdMap.get(loc.parentId) : null;

        await prisma.location.create({
          data: {
            id: newId,
            name: loc.name,
            description: loc.comment || null,
            userId: USER_ID,
            organizationId: ORG_ID,
            parentId: parentShelfId ?? null,
            createdAt: parseDate(loc.datetimeAdded),
            updatedAt: parseDate(loc.lastModified),
          },
        });
        locationIdMap.set(locId, newId);
        locInserted.add(locId);
        summary.locations++;
      })();
    }

    for (const locId of locMap.keys()) {
      await insertLocation(locId);
    }
    console.log(`  Created ${summary.locations} locations.\n`);

    // ------------------------------------------------------------------
    // 3. Manufacturers -> Tags (mfr:Name)
    // ------------------------------------------------------------------
    console.log("--- Importing Manufacturers as Tags ---");

    // oldMfrId -> new Shelf Tag id
    const mfrTagIdMap = new Map<number, string>();

    for (const row of mfrRows) {
      // Fields: id(0), parent_id(1), ..., name(10), last_modified(11),
      // datetime_added(12), ...
      const mfrId = Number(row[0]);
      const mfrName = row[10];
      const newId = createId();

      await prisma.tag.create({
        data: {
          id: newId,
          name: `mfr:${mfrName}`,
          userId: USER_ID,
          organizationId: ORG_ID,
          createdAt: parseDate(row[12]),
          updatedAt: parseDate(row[11]),
        },
      });
      mfrTagIdMap.set(mfrId, newId);
      summary.tags++;
    }
    console.log(`  Created ${summary.tags} manufacturer tags.\n`);

    // ------------------------------------------------------------------
    // 4. Custom Fields (IPN, MPN)
    // ------------------------------------------------------------------
    console.log("--- Creating Custom Fields ---");

    const ipnFieldId = createId();
    const mpnFieldId = createId();

    await prisma.customField.create({
      data: {
        id: ipnFieldId,
        name: "IPN",
        helpText: "Internal Part Number",
        type: "TEXT",
        active: true,
        userId: USER_ID,
        organizationId: ORG_ID,
      },
    });
    summary.customFields++;

    await prisma.customField.create({
      data: {
        id: mpnFieldId,
        name: "MPN",
        helpText: "Manufacturer Part Number",
        type: "TEXT",
        active: true,
        userId: USER_ID,
        organizationId: ORG_ID,
      },
    });
    summary.customFields++;
    console.log(`  Created ${summary.customFields} custom fields.\n`);

    // ------------------------------------------------------------------
    // 5. Build lot lookup (part_id -> lot data)
    // ------------------------------------------------------------------
    type LotInfo = {
      id: number;
      storeLocationId: number | null;
      partId: number;
      description: string;
      amount: number;
      lastModified: string;
      datetimeAdded: string;
    };
    // A part can have multiple lots; we aggregate
    const lotsForPart = new Map<number, LotInfo[]>();
    for (const row of lotRows) {
      // Fields: id(0), id_store_location(1), id_part(2), description(3),
      // comment(4), expiration_date(5), instock_unknown(6), amount(7),
      // needs_refill(8), last_modified(9), datetime_added(10), ...
      const lot: LotInfo = {
        id: Number(row[0]),
        storeLocationId: nullable(row[1]) ? Number(row[1]) : null,
        partId: Number(row[2]),
        description: row[3],
        amount: parseFloat(row[7]),
        lastModified: row[9],
        datetimeAdded: row[10],
      };
      const existing = lotsForPart.get(lot.partId) || [];
      existing.push(lot);
      lotsForPart.set(lot.partId, existing);
    }

    // ------------------------------------------------------------------
    // 6. Parts -> Assets
    // ------------------------------------------------------------------
    console.log("--- Importing Parts as Assets ---");

    // Tag name -> tag id (for deduplication of part tags)
    const tagNameMap = new Map<string, string>();

    /** Gets or creates a tag by name, returns its Shelf id */
    async function getOrCreateTag(name: string): Promise<string> {
      const normalised = name.trim();
      if (!normalised) return "";
      const existing = tagNameMap.get(normalised.toLowerCase());
      if (existing) return existing;

      const newId = createId();
      await prisma.tag.create({
        data: {
          id: newId,
          name: normalised,
          userId: USER_ID,
          organizationId: ORG_ID,
        },
      });
      tagNameMap.set(normalised.toLowerCase(), newId);
      summary.tags++;
      return newId;
    }

    for (const row of partRows) {
      // Parts fields (from CREATE TABLE):
      // id(0), id_category(1), id_footprint(2), id_manufacturer(3),
      // id_preview_attachment(4), order_orderdetails_id(5), id_part_unit(6),
      // datetime_added(7), last_modified(8), name(9), description(10),
      // minamount(11), comment(12), visible(13), favorite(14),
      // order_quantity(15), manual_order(16), manufacturer_product_url(17),
      // manufacturer_product_number(18), manufacturing_status(19),
      // needs_review(20), tags(21), mass(22), ipn(23), ...

      const partId = Number(row[0]);
      const catId = Number(row[1]);
      const mfrId = nullable(row[3]) ? Number(row[3]) : null;
      const datetimeAdded = row[7];
      const lastModified = row[8];
      const partName = row[9];
      const description = row[10] || null;
      const minamount = parseFloat(row[11]);
      const mpn = row[18] || null;
      const tagsStr = row[21] || "";
      const ipn = nullable(row[23]);

      // Determine the category name for asset type logic
      const catInfo = catMap.get(catId);
      const catName = catInfo?.name || "";

      // Get lots for this part
      const lots = lotsForPart.get(partId) || [];
      const totalQty = lots.reduce((sum, l) => sum + l.amount, 0);

      // Use first lot's location as asset location
      const firstLotWithLocation = lots.find((l) => l.storeLocationId !== null);
      const locationId = firstLotWithLocation?.storeLocationId
        ? locationIdMap.get(firstLotWithLocation.storeLocationId) ?? null
        : null;

      // Asset type determination
      const isIndividual = INDIVIDUAL_CATEGORIES.has(catName) && totalQty === 1;

      // Check if filament-related for consumption type
      const fullCatName = flatCatName(catId);
      const isFilament =
        fullCatName.toLowerCase().includes("filament") ||
        catName.toLowerCase().includes("pla") ||
        catName.toLowerCase().includes("abs") ||
        catName.toLowerCase().includes("tpu") ||
        catName.toLowerCase().includes("petg");

      const assetId = createId();

      const assetData: any = {
        id: assetId,
        title: partName,
        description: description || null,
        userId: USER_ID,
        organizationId: ORG_ID,
        categoryId: categoryIdMap.get(catId) ?? null,
        locationId,
        createdAt: parseDate(datetimeAdded),
        updatedAt: parseDate(lastModified),
        minQuantity: minamount > 0 ? Math.round(minamount) : null,
      };

      if (isIndividual) {
        assetData.type = "INDIVIDUAL";
      } else {
        assetData.type = "QUANTITY_TRACKED";
        assetData.quantity = Math.round(totalQty);
        assetData.consumptionType = isFilament ? "ONE_WAY" : "TWO_WAY";
        assetData.unitOfMeasure = isFilament ? "KG" : "PCS";
      }

      await prisma.asset.create({ data: assetData });
      summary.assets++;

      // Link manufacturer tag
      if (mfrId !== null && mfrTagIdMap.has(mfrId)) {
        await prisma.$executeRawUnsafe(
          `INSERT INTO "_AssetToTag" ("A", "B") VALUES ($1, $2)`,
          assetId,
          mfrTagIdMap.get(mfrId)!
        );
        summary.assetTagLinks++;
      }

      // Parse and link part tags (comma-separated)
      if (tagsStr.trim()) {
        const tagNames = tagsStr
          .split(",")
          .map((t: string) => t.trim())
          .filter(Boolean);
        for (const tagName of tagNames) {
          const tagId = await getOrCreateTag(tagName);
          if (tagId) {
            await prisma.$executeRawUnsafe(
              `INSERT INTO "_AssetToTag" ("A", "B") VALUES ($1, $2) ON CONFLICT DO NOTHING`,
              assetId,
              tagId
            );
            summary.assetTagLinks++;
          }
        }
      }

      // Create IPN custom field value if present
      if (ipn) {
        await prisma.assetCustomFieldValue.create({
          data: {
            id: createId(),
            assetId,
            customFieldId: ipnFieldId,
            value: { raw: ipn, valueText: ipn },
          },
        });
        summary.assetCustomFieldValues++;
      }

      // Create MPN custom field value if present
      if (mpn) {
        await prisma.assetCustomFieldValue.create({
          data: {
            id: createId(),
            assetId,
            customFieldId: mpnFieldId,
            value: { raw: mpn, valueText: mpn },
          },
        });
        summary.assetCustomFieldValues++;
      }

      // Create notes from lot descriptions (non-empty only)
      for (const lot of lots) {
        if (lot.description && lot.description.trim()) {
          await prisma.note.create({
            data: {
              id: createId(),
              content: lot.description.trim(),
              type: "COMMENT",
              userId: USER_ID,
              assetId,
              createdAt: parseDate(lot.datetimeAdded),
              updatedAt: parseDate(lot.lastModified),
            },
          });
          summary.notes++;
        }
      }
    }
    console.log(`  Created ${summary.assets} assets.\n`);

    // ------------------------------------------------------------------
    // Summary
    // ------------------------------------------------------------------
    console.log("=== Migration Complete ===\n");
    console.log("Summary:");
    console.log(`  Categories:              ${summary.categories}`);
    console.log(`  Locations:               ${summary.locations}`);
    console.log(`  Tags (mfr + part):       ${summary.tags}`);
    console.log(`  Custom Fields:           ${summary.customFields}`);
    console.log(`  Assets:                  ${summary.assets}`);
    console.log(`  Asset Custom Field Vals: ${summary.assetCustomFieldValues}`);
    console.log(`  Notes:                   ${summary.notes}`);
    console.log(`  Asset-Tag Links:         ${summary.assetTagLinks}`);
  } catch (error) {
    console.error("\n!!! Migration failed !!!");
    console.error(error);
    process.exit(1);
  } finally {
    await prisma.$disconnect();
  }
}

main();
