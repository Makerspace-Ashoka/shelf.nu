/**
 * Category Service (server-side)
 *
 * Handles all CRUD operations and hierarchy management for the Category model.
 * Categories are scoped to an organization and support up to MAX_CATEGORY_DEPTH
 * levels of nesting via a self-referential `parent`/`children` relation.
 *
 * Hierarchy utilities use PostgreSQL recursive CTEs to walk both up (ancestors)
 * and down (descendants) the tree without loading the entire tree into memory.
 *
 * @see {@link file://./../../routes/_layout+/categories._index.tsx}
 * @see {@link file://./../../routes/_layout+/categories.$categoryId_.edit.tsx}
 */
import type { Category, Organization, Prisma, User } from "@prisma/client";
import { db } from "~/database/db.server";

import type { ErrorLabel } from "~/utils/error";
import { ShelfError, maybeUniqueConstraintViolation } from "~/utils/error";
import { getRandomColor } from "~/utils/get-random-color";
import { ALL_SELECTED_KEY } from "~/utils/list";
import type { CreateAssetFromContentImportPayload } from "../asset/types";

const label: ErrorLabel = "Category";

/** Maximum allowed nesting depth for category hierarchies. */
const MAX_CATEGORY_DEPTH = 12;

/**
 * A single entry in a category's ancestor chain, ordered from root to leaf.
 * `depth` is 0 for the category itself and increases towards the root.
 */
export type CategoryHierarchyEntry = Pick<
  Category,
  "id" | "name" | "parentId"
> & {
  depth: number;
};

/**
 * A node in a recursive category tree, with its direct children pre-populated.
 * Used when building a nested tree representation of descendants.
 */
export type CategoryTreeNode = Pick<Category, "id" | "name"> & {
  children: CategoryTreeNode[];
};

/** Raw row returned by the descendants CTE query. @internal */
type CategoryDescendantRow = Pick<Category, "id" | "name" | "parentId">;

/** Raw row returned by the subtree depth CTE query. @internal */
type SubtreeDepthRow = { maxDepth: number | null };

/**
 * Prisma include shape used by list queries that need asset/child counts and
 * the parent category's identity. Referenced by both `getCategories` and the
 * category list route loader.
 */
export const CATEGORY_LIST_INCLUDE = {
  _count: { select: { assets: true, children: true } },
  parent: { select: { id: true, name: true } },
} satisfies Prisma.CategoryInclude;

// ---------------------------------------------------------------------------
// Hierarchy read queries
// ---------------------------------------------------------------------------

/**
 * Returns the full ancestor chain for a category, walking UP the tree via a
 * recursive CTE.  The result is ordered from the root ancestor (highest depth
 * value) down to the category itself (depth = 0).
 *
 * @param params.organizationId - Scope to this organization.
 * @param params.categoryId     - The category whose ancestors to retrieve.
 * @returns Array of {@link CategoryHierarchyEntry} ordered root → leaf.
 */
export async function getCategoryHierarchy(params: {
  organizationId: Organization["id"];
  categoryId: Category["id"];
}): Promise<CategoryHierarchyEntry[]> {
  const { organizationId, categoryId } = params;
  return db.$queryRaw<CategoryHierarchyEntry[]>`
    WITH RECURSIVE category_hierarchy AS (
      SELECT id, name, "parentId", "organizationId", 0 AS depth
      FROM "Category"
      WHERE id = ${categoryId} AND "organizationId" = ${organizationId}
      UNION ALL
      SELECT c.id, c.name, c."parentId", c."organizationId", ch.depth + 1 AS depth
      FROM "Category" c
      INNER JOIN category_hierarchy ch ON ch."parentId" = c.id
      WHERE c."organizationId" = ${organizationId}
    )
    SELECT id, name, "parentId", depth FROM category_hierarchy ORDER BY depth DESC
  `;
}

/**
 * Returns the direct children of a category as a nested tree, walking DOWN via
 * a recursive CTE.  Only descendants of the supplied `categoryId` are included;
 * the root node itself is not in the result.
 *
 * @param params.organizationId - Scope to this organization.
 * @param params.categoryId     - The category whose subtree to retrieve.
 * @returns Array of top-level {@link CategoryTreeNode} children with nested
 *          `children` populated recursively.
 */
export async function getCategoryDescendantsTree(params: {
  organizationId: Organization["id"];
  categoryId: Category["id"];
}): Promise<CategoryTreeNode[]> {
  const { organizationId, categoryId } = params;

  const descendants = await db.$queryRaw<CategoryDescendantRow[]>`
    WITH RECURSIVE category_descendants AS (
      SELECT id, name, "parentId", "organizationId"
      FROM "Category"
      WHERE "parentId" = ${categoryId} AND "organizationId" = ${organizationId}
      UNION ALL
      SELECT c.id, c.name, c."parentId", c."organizationId"
      FROM "Category" c
      INNER JOIN category_descendants cd ON cd.id = c."parentId"
      WHERE c."organizationId" = ${organizationId}
    )
    SELECT id, name, "parentId" FROM category_descendants
  `;

  /** Build a lookup map so we can attach children in O(n). */
  const nodes = new Map<string, CategoryTreeNode>();
  const rootNodes: CategoryTreeNode[] = [];

  for (const row of descendants) {
    nodes.set(row.id, { id: row.id, name: row.name, children: [] });
  }

  for (const row of descendants) {
    const node = nodes.get(row.id);
    if (!node) continue;

    if (row.parentId === categoryId) {
      /** Direct child of the queried category — add to top-level result. */
      rootNodes.push(node);
    }

    const parentNode = row.parentId ? nodes.get(row.parentId) : null;
    if (parentNode) {
      parentNode.children.push(node);
    }
  }

  return rootNodes;
}

/**
 * Returns the maximum depth of the subtree rooted at `categoryId` (inclusive).
 * A category with no children returns 0.
 *
 * @param params.organizationId - Scope to this organization.
 * @param params.categoryId     - The root of the subtree to measure.
 * @returns Maximum depth as a non-negative integer.
 */
export async function getCategorySubtreeDepth(params: {
  organizationId: Organization["id"];
  categoryId: Category["id"];
}): Promise<number> {
  const { organizationId, categoryId } = params;

  const [result] = await db.$queryRaw<SubtreeDepthRow[]>`
    WITH RECURSIVE category_subtree AS (
      SELECT id, "parentId", "organizationId", 0 AS depth
      FROM "Category"
      WHERE id = ${categoryId} AND "organizationId" = ${organizationId}
      UNION ALL
      SELECT c.id, c."parentId", c."organizationId", cs.depth + 1 AS depth
      FROM "Category" c
      INNER JOIN category_subtree cs ON c."parentId" = cs.id
      WHERE c."organizationId" = ${organizationId}
    )
    SELECT MAX(depth) AS "maxDepth" FROM category_subtree
  `;

  return result?.maxDepth ?? 0;
}

/**
 * Fetches categories at a given hierarchy level with child indicator.
 * Used by the hierarchical category selector to show one level at a time.
 *
 * @param params.organizationId - Organization scope.
 * @param params.parentId - Parent category ID, or null for root-level categories.
 * @param params.search - Optional search filter on category name.
 * @returns Array of categories with hasChildren flag.
 */
export async function getCategoriesByParentId(params: {
  organizationId: Organization["id"];
  parentId: string | null;
  search?: string;
}) {
  const { organizationId, parentId, search } = params;

  const where: Prisma.CategoryWhereInput = {
    organizationId,
    parentId,
    ...(search && {
      name: { contains: search, mode: "insensitive" as const },
    }),
  };

  const categories = await db.category.findMany({
    where,
    include: { _count: { select: { children: true } } },
    orderBy: { name: "asc" },
  });

  return categories.map((c) => ({
    id: c.id,
    name: c.name,
    color: c.color,
    hasChildren: c._count.children > 0,
  }));
}

// ---------------------------------------------------------------------------
// Hierarchy validation (private)
// ---------------------------------------------------------------------------

/**
 * Validates that a `parentId` is safe to assign to a category.
 *
 * Checks performed:
 * 1. Self-referential assignment (a category cannot be its own parent).
 * 2. Parent existence within the organization.
 * 3. Total resulting depth does not exceed MAX_CATEGORY_DEPTH.
 * 4. Circular reference (assigning a descendant as parent).
 *
 * @param organizationId    - Organization scope.
 * @param parentId          - The candidate parent category id (may be null/undefined to clear).
 * @param currentCategoryId - The id of the category being created or updated.
 * @returns The validated parent category id, or `null` when no parent is set.
 * @throws {ShelfError} For any of the invalid conditions listed above.
 */
async function validateParentCategory({
  organizationId,
  parentId,
  currentCategoryId,
}: {
  organizationId: Organization["id"];
  parentId?: Category["parentId"];
  currentCategoryId?: Category["id"];
}): Promise<string | null> {
  if (!parentId) return null;

  /** Guard: a category must not be its own parent. */
  if (currentCategoryId && parentId === currentCategoryId) {
    throw new ShelfError({
      cause: null,
      message: "A category cannot be its own parent.",
      additionalData: { currentCategoryId, parentId, organizationId },
      label,
      status: 400,
      shouldBeCaptured: false,
    });
  }

  /** Guard: parent must exist within the same organization. */
  const parentCategory = await db.category.findFirst({
    where: { id: parentId, organizationId },
    select: { id: true },
  });

  if (!parentCategory) {
    throw new ShelfError({
      cause: null,
      message: "Parent category not found.",
      additionalData: { parentId, organizationId },
      label,
      status: 404,
      shouldBeCaptured: false,
    });
  }

  /**
   * Guard: the combined depth of the parent's ancestor chain plus the
   * current category's subtree must not exceed the maximum.
   */
  const hierarchy = await getCategoryHierarchy({
    organizationId,
    categoryId: parentId,
  });
  const parentDepth = hierarchy.reduce(
    (max, cat) => Math.max(max, cat.depth),
    0
  );
  const subtreeDepth =
    currentCategoryId === undefined
      ? 0
      : await getCategorySubtreeDepth({
          organizationId,
          categoryId: currentCategoryId,
        });

  if (parentDepth + 1 + subtreeDepth > MAX_CATEGORY_DEPTH) {
    throw new ShelfError({
      cause: null,
      title: "Not allowed",
      message: `Categories cannot be nested deeper than ${MAX_CATEGORY_DEPTH} levels.`,
      additionalData: { parentId, organizationId, parentDepth, subtreeDepth },
      label,
      status: 400,
      shouldBeCaptured: false,
    });
  }

  /** Guard: circular reference — parent must not be a descendant of the current category. */
  if (currentCategoryId && hierarchy.some((c) => c.id === currentCategoryId)) {
    throw new ShelfError({
      cause: null,
      message: "A category cannot be assigned to one of its descendants.",
      additionalData: { parentId, currentCategoryId, organizationId },
      label,
      status: 400,
      shouldBeCaptured: false,
    });
  }

  return parentCategory.id;
}

// ---------------------------------------------------------------------------
// CRUD operations
// ---------------------------------------------------------------------------

/**
 * Creates a new category within an organization, optionally nested under a
 * parent category.  Parent assignment is validated against circular references
 * and the maximum depth limit before the record is written.
 *
 * @param params.name           - Display name (trimmed before saving).
 * @param params.description    - Optional freeform description.
 * @param params.color          - Hex or named colour for UI display.
 * @param params.userId         - The user creating the category.
 * @param params.organizationId - The owning organization.
 * @param params.parentId       - Optional parent category id.
 * @returns The newly created {@link Category} record.
 * @throws {ShelfError} On unique-name violation or hierarchy validation failure.
 */
export async function createCategory({
  name,
  description,
  color,
  userId,
  organizationId,
  parentId,
}: Pick<Category, "description" | "name" | "color" | "organizationId"> & {
  userId: User["id"];
  parentId?: Category["parentId"];
}) {
  const validatedParentId = await validateParentCategory({
    organizationId,
    parentId,
  });

  try {
    return await db.category.create({
      data: {
        name: name.trim(),
        description,
        color,
        user: {
          connect: {
            id: userId,
          },
        },
        organization: {
          connect: {
            id: organizationId,
          },
        },
        ...(validatedParentId && {
          parent: { connect: { id: validatedParentId } },
        }),
      },
    });
  } catch (cause) {
    throw maybeUniqueConstraintViolation(cause, "Category", {
      additionalData: { userId, organizationId },
    });
  }
}

/**
 * Returns a paginated, optionally searched list of categories for an
 * organization together with a total count for pagination.
 *
 * @param params.organizationId - Scope to this organization.
 * @param params.page           - 1-based page number (defaults to 1).
 * @param params.perPage        - Items per page (defaults to 8).
 * @param params.search         - Optional name substring search (case-insensitive).
 * @returns Object with `categories` array and `totalCategories` count.
 * @throws {ShelfError} On database failure.
 */
export async function getCategories(params: {
  organizationId: Organization["id"];
  /** Page number. Starts at 1 */
  page?: number;
  /** Items to be loaded per page */
  perPage?: number;
  search?: string | null;
}) {
  const { organizationId, page = 1, perPage = 8, search } = params;

  try {
    const skip = page > 1 ? (page - 1) * perPage : 0;
    const take = perPage >= 1 ? perPage : 8; // min 1 and max 25 per page

    /** Default value of where. Takes the items belonging to current user */
    const where: Prisma.CategoryWhereInput = { organizationId };

    /** If the search string exists, add it to the where object */
    if (search) {
      where.name = {
        contains: search,
        mode: "insensitive",
      };
    }

    const [categories, totalCategories] = await Promise.all([
      /** Get the items */
      db.category.findMany({
        skip,
        take,
        where,
        orderBy: { updatedAt: "desc" },
        include: CATEGORY_LIST_INCLUDE,
      }),

      /** Count them */
      db.category.count({ where }),
    ]);

    return { categories, totalCategories };
  } catch (cause) {
    throw new ShelfError({
      cause,
      message: "Something went wrong while fetching the categories",
      additionalData: { ...params },
      label,
    });
  }
}

/**
 * Permanently deletes a single category by id within an organization.
 *
 * @param params.id             - The category to delete.
 * @param params.organizationId - Organization scope (prevents cross-org deletes).
 * @returns Prisma batch-delete result.
 * @throws {ShelfError} On database failure.
 */
export async function deleteCategory({
  id,
  organizationId,
}: Pick<Category, "id"> & { organizationId: Organization["id"] }) {
  try {
    return await db.category.deleteMany({
      where: { id, organizationId },
    });
  } catch (cause) {
    throw new ShelfError({
      cause,
      message:
        "Something went wrong while deleting the category. Please try again or contact support.",
      additionalData: { id, organizationId },
      label,
    });
  }
}

/**
 * Upserts categories from a CSV import payload, creating any that don't
 * already exist (case-insensitive match) and returning a map of
 * `categoryName → categoryId`.
 *
 * @param params.data           - Import rows to derive category names from.
 * @param params.userId         - User performing the import.
 * @param params.organizationId - Owning organization.
 * @returns Record mapping each unique category name to its database id.
 * @throws {ShelfError} On invalid CSV data or database failure.
 */
export async function createCategoriesIfNotExists({
  data,
  userId,
  organizationId,
}: {
  data: CreateAssetFromContentImportPayload[];
  userId: User["id"];
  organizationId: Organization["id"];
}): Promise<Record<string, Category["id"]>> {
  try {
    // first we get all the categories from the assets and make then into an object where the category is the key and the value is an empty string
    const categories = new Map(
      data
        .filter((asset) => asset.category)
        .map((asset) => [asset.category, ""])
    );

    // now we loop through the categories and check if they exist
    for (const [category, _] of categories) {
      const trimmedCategory = (category as string).trim();
      const existingCategory = await db.category.findFirst({
        where: {
          name: { equals: trimmedCategory, mode: "insensitive" },
          organizationId,
        },
      });

      if (!existingCategory) {
        // if the category doesn't exist, we create a new one
        const newCategory = await db.category.create({
          data: {
            name: trimmedCategory,
            color: getRandomColor(),
            user: {
              connect: {
                id: userId,
              },
            },
            organization: {
              connect: {
                id: organizationId,
              },
            },
          },
        });
        categories.set(category, newCategory.id);
      } else {
        // if the category exists, we just update the id
        categories.set(category, existingCategory.id);
      }
    }

    return Object.fromEntries(Array.from(categories));
  } catch (cause) {
    throw new ShelfError({
      cause,
      message:
        "Something went wrong while creating categories. Seems like some of the category data in your import file is invalid. Please check and try again.",
      additionalData: { userId, organizationId },
      label,
      /** No need to capture those. They are mostly related to malformed CSV data */
      shouldBeCaptured: false,
    });
  }
}

/**
 * Retrieves a single category by id, scoped to the given organization.
 *
 * @param params.id             - The category id to look up.
 * @param params.organizationId - Organization scope.
 * @returns The {@link Category} record.
 * @throws {ShelfError} If the category is not found or belongs to another org.
 */
export async function getCategory({
  id,
  organizationId,
}: Pick<Category, "id" | "organizationId">) {
  try {
    return await db.category.findFirstOrThrow({
      where: { id, organizationId },
    });
  } catch (cause) {
    throw new ShelfError({
      cause,
      title: "Category not found",
      message:
        "The category you are trying to access does not exist or you do not have permission to access it.",
      additionalData: { id, organizationId },
      label,
    });
  }
}

/**
 * Updates mutable fields of an existing category.  If `parentId` is supplied
 * it is validated before being written; if `parentId` is explicitly `null` the
 * category is detached from its current parent.
 *
 * @param params.id             - The category to update.
 * @param params.organizationId - Organization scope.
 * @param params.name           - New display name (trimmed before saving).
 * @param params.description    - New description.
 * @param params.color          - New colour value.
 * @param params.parentId       - New parent id, `null` to clear, or `undefined` to leave unchanged.
 * @returns The updated {@link Category} record.
 * @throws {ShelfError} On hierarchy validation failure or unique-name violation.
 */
export async function updateCategory({
  id,
  organizationId,
  name,
  description,
  color,
  parentId,
}: Pick<
  Category,
  "id" | "organizationId" | "description" | "name" | "color"
> & {
  parentId?: Category["parentId"];
}) {
  /**
   * Only validate & resolve parentId when it is explicitly provided.
   * `undefined` means "leave the parent unchanged"; `null` means "clear parent".
   */
  const validatedParentId =
    parentId === undefined
      ? undefined
      : await validateParentCategory({
          organizationId,
          parentId,
          currentCategoryId: id,
        });

  try {
    return await db.category.update({
      where: {
        id,
        organizationId,
      },
      data: {
        name: name?.trim(),
        description,
        color,
        ...(validatedParentId !== undefined && {
          parent: validatedParentId
            ? { connect: { id: validatedParentId } }
            : { disconnect: true },
        }),
      },
    });
  } catch (cause) {
    throw maybeUniqueConstraintViolation(cause, "Category", {
      additionalData: { id, organizationId, name },
    });
  }
}

/**
 * Bulk-deletes categories by id list within an organization.  When
 * `ALL_SELECTED_KEY` is present in `categoryIds` every category in the
 * organization is deleted.
 *
 * @param params.categoryIds    - Ids to delete, or `[ALL_SELECTED_KEY]` for all.
 * @param params.organizationId - Organization scope.
 * @returns Prisma batch-delete result.
 * @throws {ShelfError} On database failure.
 */
export async function bulkDeleteCategories({
  categoryIds,
  organizationId,
}: {
  categoryIds: Category["id"][];
  organizationId: Organization["id"];
}) {
  try {
    return await db.category.deleteMany({
      where: categoryIds.includes(ALL_SELECTED_KEY)
        ? { organizationId }
        : { id: { in: categoryIds }, organizationId },
    });
  } catch (cause) {
    throw new ShelfError({
      cause,
      message: "Something went wrong while bulk deleting categories.",
      additionalData: { categoryIds, organizationId },
      label,
    });
  }
}
