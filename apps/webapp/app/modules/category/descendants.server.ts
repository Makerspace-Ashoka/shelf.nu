/**
 * Category Descendants Query
 *
 * Recursive CTE to fetch all descendant category IDs for a given category.
 * Used by asset filtering to include assets from child categories.
 *
 * @see {@link file://./service.server.ts} - Category service
 * @see {@link file://../../modules/location/descendants.server.ts} - Location equivalent
 */

import type { Category, Organization } from "@prisma/client";
import { db } from "~/database/db.server";

/** Raw row returned by the recursive CTE query. */
type CategoryDescendantIdRow = Pick<Category, "id" | "parentId">;

/**
 * Returns all descendant category IDs for a given category using a recursive CTE.
 *
 * @param organizationId - Scoping organization
 * @param categoryId - Root category to start from
 * @param includeSelf - Whether to include the root category ID in results
 * @returns Array of descendant category IDs
 */
export async function getCategoryDescendantIds({
  organizationId,
  categoryId,
  includeSelf = true,
}: {
  organizationId: Organization["id"];
  categoryId: Category["id"];
  includeSelf?: boolean;
}): Promise<string[]> {
  const rows = await db.$queryRaw<CategoryDescendantIdRow[]>`
    WITH RECURSIVE category_descendants AS (
      SELECT
        id,
        "parentId",
        "organizationId"
      FROM "Category"
      WHERE id = ${categoryId} AND "organizationId" = ${organizationId}
      UNION ALL
      SELECT
        c.id,
        c."parentId",
        c."organizationId"
      FROM "Category" c
      INNER JOIN category_descendants cd ON cd.id = c."parentId"
      WHERE c."organizationId" = ${organizationId}
    )
    SELECT id, "parentId"
    FROM category_descendants
  `;

  return rows
    .filter((row) => includeSelf || row.id !== categoryId)
    .map((row) => row.id);
}
