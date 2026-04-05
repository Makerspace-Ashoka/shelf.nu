/**
 * Generate Cricut-compatible SVG with dot-style circular QR codes.
 *
 * Outputs a single SVG file where each QR sticker is a <g> group
 * containing: dot-style QR modules + circular cut line.
 * Import into Cricut Design Space, ungroup, arrange, Print Then Cut.
 */

import { PrismaClient } from "@prisma/client";
import QRCodeGenerator from "qrcode-generator";

const db = new PrismaClient({
  datasourceUrl: "postgresql://postgres:postgres@127.0.0.1:54322/postgres",
});

const BASE_URL = "https://localhost:3000/qr";

/** Sticker diameter in mm */
const STICKER_DIAMETER_MM = 38; // ~1.5 inches
const STICKER_RADIUS_MM = STICKER_DIAMETER_MM / 2;

/** Padding between QR content and cut edge in mm */
const PADDING_MM = 3;

/** QR content area diameter */
const QR_AREA_MM = STICKER_DIAMETER_MM - PADDING_MM * 2;

/**
 * Get the QR code boolean matrix from qrcode-generator.
 * Returns a 2D array where true = dark module.
 */
function getQrMatrix(data: string): boolean[][] {
  const qr = QRCodeGenerator(0, "M"); // Auto version, medium EC
  qr.addData(data);
  qr.make();

  const count = qr.getModuleCount();
  const matrix: boolean[][] = [];

  for (let row = 0; row < count; row++) {
    const rowData: boolean[] = [];
    for (let col = 0; col < count; col++) {
      rowData.push(qr.isDark(row, col));
    }
    matrix.push(rowData);
  }

  return matrix;
}

/**
 * Render a QR matrix as dot-style SVG elements (circles instead of squares).
 * Returns SVG content string (no root <svg> tag).
 */
function renderDotQr(
  matrix: boolean[][],
  offsetX: number,
  offsetY: number,
  areaSizeMm: number
): string {
  const moduleCount = matrix.length;
  const moduleSizeMm = areaSizeMm / moduleCount;
  const dotRadius = moduleSizeMm * 0.42; // Slightly smaller than half for gaps

  const circles: string[] = [];

  for (let row = 0; row < moduleCount; row++) {
    for (let col = 0; col < moduleCount; col++) {
      if (matrix[row][col]) {
        const cx = offsetX + col * moduleSizeMm + moduleSizeMm / 2;
        const cy = offsetY + row * moduleSizeMm + moduleSizeMm / 2;

        // Check if this is a finder pattern position marker (keep as rounded rect)
        if (isFinderPattern(row, col, moduleCount)) {
          circles.push(
            `<rect x="${cx - moduleSizeMm / 2}" y="${cy - moduleSizeMm / 2}" ` +
              `width="${moduleSizeMm}" height="${moduleSizeMm}" rx="${
                moduleSizeMm * 0.15
              }" ` +
              `fill="#000"/>`
          );
        } else {
          circles.push(
            `<circle cx="${cx}" cy="${cy}" r="${dotRadius}" fill="#000"/>`
          );
        }
      }
    }
  }

  return circles.join("\n    ");
}

/**
 * Check if a module position is part of a finder pattern.
 * Finder patterns are the 7x7 squares in three corners.
 */
function isFinderPattern(
  row: number,
  col: number,
  moduleCount: number
): boolean {
  // Top-left
  if (row < 7 && col < 7) return true;
  // Top-right
  if (row < 7 && col >= moduleCount - 7) return true;
  // Bottom-left
  if (row >= moduleCount - 7 && col < 7) return true;
  return false;
}

async function main() {
  // Fetch all blank (unclaimed) QR codes
  const blankQrs = await db.qr.findMany({
    where: { assetId: null, kitId: null },
    select: { id: true },
    orderBy: { createdAt: "asc" },
  });

  if (blankQrs.length === 0) {
    console.log("No blank QR codes found in database.");
    await db.$disconnect();
    process.exit(1);
  }

  console.log(`Found ${blankQrs.length} blank QR codes. Generating SVG...`);

  // Layout: arrange in a grid, well-spaced
  const cols = 5;
  const spacingMm = 5;
  const rows = Math.ceil(blankQrs.length / cols);

  const totalWidth = cols * STICKER_DIAMETER_MM + (cols - 1) * spacingMm + 20; // 10mm margin each side
  const totalHeight = rows * STICKER_DIAMETER_MM + (rows - 1) * spacingMm + 20;

  const groups: string[] = [];

  for (let i = 0; i < blankQrs.length; i++) {
    const qrId = blankQrs[i].id;
    const url = `${BASE_URL}/${qrId}`;
    const matrix = getQrMatrix(url);

    const col = i % cols;
    const row = Math.floor(i / cols);

    // Center of this sticker
    const cx = 10 + col * (STICKER_DIAMETER_MM + spacingMm) + STICKER_RADIUS_MM;
    const cy = 10 + row * (STICKER_DIAMETER_MM + spacingMm) + STICKER_RADIUS_MM;

    // QR content top-left (centered in the circle)
    const qrOffsetX = cx - QR_AREA_MM / 2;
    const qrOffsetY = cy - QR_AREA_MM / 2;

    const dotModules = renderDotQr(matrix, qrOffsetX, qrOffsetY, QR_AREA_MM);

    // Short label: last 6 chars of ID
    const label = qrId.slice(-6);
    const labelY = cy + STICKER_RADIUS_MM - PADDING_MM + 1;

    groups.push(`  <g id="qr-${qrId}">
    <!-- Cut line -->
    <circle cx="${cx}" cy="${cy}" r="${STICKER_RADIUS_MM}" fill="white" stroke="#ccc" stroke-width="0.3"/>
    <!-- QR modules -->
    ${dotModules}
    <!-- Label -->
    <text x="${cx}" y="${labelY}" text-anchor="middle" font-family="monospace" font-size="2" fill="#666">${label}</text>
  </g>`);
  }

  const svg = `<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg"
     width="${totalWidth}mm" height="${totalHeight}mm"
     viewBox="0 0 ${totalWidth} ${totalHeight}">
  <!-- Cricut QR Sticker Sheet - ${blankQrs.length} stickers -->
  <!-- Import into Cricut Design Space, Ungroup, set to Print Then Cut -->
${groups.join("\n")}
</svg>`;

  const outPath = "/Users/ojas/Desktop/shelf.nu/qr-stickers-cricut.svg";
  const { writeFileSync } = await import("fs");
  writeFileSync(outPath, svg);

  console.log(`Generated: ${outPath}`);
  console.log(`Stickers: ${blankQrs.length}`);
  console.log(`Grid: ${cols}x${rows}`);
  console.log(`Sticker diameter: ${STICKER_DIAMETER_MM}mm (~1.5")`);
  console.log(``);
  console.log(`Cricut workflow:`);
  console.log(`  1. Open Cricut Design Space`);
  console.log(`  2. Upload → SVG → select qr-stickers-cricut.svg`);
  console.log(`  3. Add to canvas`);
  console.log(`  4. Ungroup to get individual stickers`);
  console.log(`  5. Arrange on mat as desired`);
  console.log(`  6. Select all → Operation: Print Then Cut`);
  console.log(`  7. Print on sticker paper, Cricut cuts the circles`);

  await db.$disconnect();
}

main().catch(console.error);
