# Category Hierarchies Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add parent/child hierarchy to the Category model, mirroring the existing Location hierarchy pattern.

**Architecture:** Add `parentId` self-relation to Category, recursive CTE queries for ancestors/descendants, parent selector in category forms, tree display in category detail, and descendant-inclusive asset filtering. Every pattern is copied from the battle-tested Location implementation.

**Tech Stack:** Prisma (schema + migration), PostgreSQL recursive CTEs, React (form + tree components), Zod (validation), react-router (routes/loaders/actions)

---

## File Map

| File                                                                                 | Action | Responsibility                                |
| ------------------------------------------------------------------------------------ | ------ | --------------------------------------------- |
| `packages/database/prisma/schema.prisma`                                             | Modify | Add parentId, parent, children to Category    |
| `packages/database/prisma/migrations/TIMESTAMP_add_category_hierarchy/migration.sql` | Create | Migration SQL                                 |
| `apps/webapp/app/modules/category/service.server.ts`                                 | Modify | Add hierarchy functions, update CRUD          |
| `apps/webapp/app/modules/category/descendants.server.ts`                             | Create | Recursive CTE for descendant IDs              |
| `apps/webapp/app/components/category/new-category-form.tsx`                          | Modify | Add parentId field + category selector        |
| `apps/webapp/app/components/category/category-tree.tsx`                              | Create | Tree display component                        |
| `apps/webapp/app/routes/_layout+/categories.tsx`                                     | Modify | Show parent + child count in list             |
| `apps/webapp/app/routes/_layout+/categories.new.tsx`                                 | Modify | Pass parentId from form                       |
| `apps/webapp/app/routes/_layout+/categories.$categoryId_.edit.tsx`                   | Modify | Load/save parentId, exclude self              |
| `apps/webapp/app/routes/api+/categories.$categoryId.tree.tsx`                        | Create | Tree API endpoint                             |
| `apps/webapp/app/modules/asset/utils.server.ts`                                      | Modify | Expand category filter to include descendants |
| `apps/webapp/app/modules/category/service.server.test.ts`                            | Create | Tests for hierarchy validation                |

---

### Task 1: Schema Migration

**Files:**

- Modify: `packages/database/prisma/schema.prisma:357-383`
- Create: `packages/database/prisma/migrations/TIMESTAMP_add_category_hierarchy/migration.sql`

- [ ] **Step 1: Add hierarchy fields to Category model**

In `packages/database/prisma/schema.prisma`, replace the Category model with:

```prisma
model Category {
  id          String  @id @default(cuid())
  name        String
  description String?
  color       String

  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt

  assets Asset[]
  kits   Kit[]
  user   User    @relation(fields: [userId], references: [id], onUpdate: Cascade)
  userId String

  customFields       CustomField[]
  assetModelDefaults AssetModel[]

  organization   Organization @relation(fields: [organizationId], references: [id], onUpdate: Cascade, onDelete: Cascade)
  organizationId String

  // Self-relation for nested categories
  parentId String?
  parent   Category?  @relation("CategoryHierarchy", fields: [parentId], references: [id], onDelete: SetNull)
  children Category[] @relation("CategoryHierarchy")

  @@unique([name, organizationId], map: "Category_name_organizationId_key")
  @@index([organizationId])
  @@index([userId])
  @@index([organizationId, parentId])
}
```

- [ ] **Step 2: Generate migration**

```bash
cd packages/database
echo "add_category_hierarchy" | pnpm prisma migrate dev --create-only --skip-seed
```

Expected: Migration file created with `ALTER TABLE "Category" ADD COLUMN "parentId" TEXT` and foreign key + index.

- [ ] **Step 3: Deploy migration**

```bash
pnpm db:deploy-migration
```

Expected: Migration applied, Prisma client regenerated.

- [ ] **Step 4: Commit**

```bash
git add packages/database/prisma/schema.prisma packages/database/prisma/migrations/
git commit -m "feat(db): add parentId hierarchy to Category model"
```

---

### Task 2: Descendants Query Module

**Files:**

- Create: `apps/webapp/app/modules/category/descendants.server.ts`

- [ ] **Step 1: Create descendants query file**

Create `apps/webapp/app/modules/category/descendants.server.ts`:

```typescript
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
```

- [ ] **Step 2: Commit**

```bash
git add apps/webapp/app/modules/category/descendants.server.ts
git commit -m "feat(category): add recursive descendant IDs query"
```

---

### Task 3: Service Layer — Hierarchy Functions

**Files:**

- Modify: `apps/webapp/app/modules/category/service.server.ts`

- [ ] **Step 1: Add hierarchy types and constants**

Add after the existing imports in `service.server.ts`:

```typescript
const MAX_CATEGORY_DEPTH = 12;

/** Represents one entry in the ancestor chain returned by getCategoryHierarchy. */
export type CategoryHierarchyEntry = Pick<
  Category,
  "id" | "name" | "parentId"
> & {
  depth: number;
};

/** Represents a node in the descendant tree rendered on category pages. */
export type CategoryTreeNode = Pick<Category, "id" | "name"> & {
  children: CategoryTreeNode[];
};

/** Raw row returned when querying descendants via recursive CTE. */
type CategoryDescendantRow = Pick<Category, "id" | "name" | "parentId">;

/** Aggregate row holding the maximum depth returned from subtree depth query. */
type SubtreeDepthRow = { maxDepth: number | null };
```

- [ ] **Step 2: Add getCategoryHierarchy function**

```typescript
/**
 * Returns the ancestor chain for a given category, ordered from root down to the node.
 *
 * @param organizationId - Scoping organization
 * @param categoryId - The category to get ancestors for
 * @returns Ancestor chain ordered root-first (depth DESC)
 */
export async function getCategoryHierarchy(params: {
  organizationId: Organization["id"];
  categoryId: Category["id"];
}): Promise<CategoryHierarchyEntry[]> {
  const { organizationId, categoryId } = params;

  return db.$queryRaw<CategoryHierarchyEntry[]>`
    WITH RECURSIVE category_hierarchy AS (
      SELECT
        id,
        name,
        "parentId",
        "organizationId",
        0 AS depth
      FROM "Category"
      WHERE id = ${categoryId} AND "organizationId" = ${organizationId}
      UNION ALL
      SELECT
        c.id,
        c.name,
        c."parentId",
        c."organizationId",
        ch.depth + 1 AS depth
      FROM "Category" c
      INNER JOIN category_hierarchy ch ON ch."parentId" = c.id
      WHERE c."organizationId" = ${organizationId}
    )
    SELECT id, name, "parentId", depth
    FROM category_hierarchy
    ORDER BY depth DESC
  `;
}
```

- [ ] **Step 3: Add getCategoryDescendantsTree function**

```typescript
/**
 * Fetches a nested tree of all descendants for the provided category.
 *
 * @param organizationId - Scoping organization
 * @param categoryId - Root category
 * @returns Array of root-level tree nodes with nested children
 */
export async function getCategoryDescendantsTree(params: {
  organizationId: Organization["id"];
  categoryId: Category["id"];
}): Promise<CategoryTreeNode[]> {
  const { organizationId, categoryId } = params;

  const descendants = await db.$queryRaw<CategoryDescendantRow[]>`
    WITH RECURSIVE category_descendants AS (
      SELECT
        id,
        name,
        "parentId",
        "organizationId"
      FROM "Category"
      WHERE "parentId" = ${categoryId} AND "organizationId" = ${organizationId}
      UNION ALL
      SELECT
        c.id,
        c.name,
        c."parentId",
        c."organizationId"
      FROM "Category" c
      INNER JOIN category_descendants cd ON cd.id = c."parentId"
      WHERE c."organizationId" = ${organizationId}
    )
    SELECT id, name, "parentId"
    FROM category_descendants
  `;

  const nodes = new Map<string, CategoryTreeNode>();
  const rootNodes: CategoryTreeNode[] = [];

  for (const row of descendants) {
    nodes.set(row.id, { id: row.id, name: row.name, children: [] });
  }

  for (const row of descendants) {
    const node = nodes.get(row.id);
    if (!node) continue;

    if (row.parentId === categoryId) {
      rootNodes.push(node);
    }

    const parentNode = row.parentId ? nodes.get(row.parentId) : null;
    if (parentNode) {
      parentNode.children.push(node);
    }
  }

  return rootNodes;
}
```

- [ ] **Step 4: Add getCategorySubtreeDepth function**

```typescript
/**
 * Returns the maximum depth of a category's subtree.
 * Used to validate re-parenting operations stay under MAX_CATEGORY_DEPTH.
 *
 * @param organizationId - Scoping organization
 * @param categoryId - Root category to measure from
 * @returns Maximum depth below this category (0 if no children)
 */
export async function getCategorySubtreeDepth(params: {
  organizationId: Organization["id"];
  categoryId: Category["id"];
}): Promise<number> {
  const { organizationId, categoryId } = params;

  const [result] = await db.$queryRaw<SubtreeDepthRow[]>`
    WITH RECURSIVE category_subtree AS (
      SELECT
        id,
        "parentId",
        "organizationId",
        0 AS depth
      FROM "Category"
      WHERE id = ${categoryId} AND "organizationId" = ${organizationId}
      UNION ALL
      SELECT
        c.id,
        c."parentId",
        c."organizationId",
        cs.depth + 1 AS depth
      FROM "Category" c
      INNER JOIN category_subtree cs ON c."parentId" = cs.id
      WHERE c."organizationId" = ${organizationId}
    )
    SELECT MAX(depth) AS "maxDepth"
    FROM category_subtree
  `;

  return result?.maxDepth ?? 0;
}
```

- [ ] **Step 5: Add validateParentCategory function**

```typescript
/**
 * Validates that a parent category belongs to the same org, does not create
 * cycles, and keeps the tree depth under MAX_CATEGORY_DEPTH.
 *
 * @param organizationId - Scoping organization
 * @param parentId - Proposed parent category ID (null to unset)
 * @param currentCategoryId - The category being edited (undefined for new)
 * @returns Validated parent ID or null
 * @throws {ShelfError} On validation failure
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
  if (!parentId) {
    return null;
  }

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

  const hierarchy = await getCategoryHierarchy({
    organizationId,
    categoryId: parentId,
  });

  const parentDepth = hierarchy.reduce(
    (maxDepth, cat) => Math.max(maxDepth, cat.depth),
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
```

- [ ] **Step 6: Update createCategory to accept parentId**

Update the `createCategory` function signature and body to accept and validate `parentId`:

```typescript
export async function createCategory({
  name,
  description,
  color,
  userId,
  organizationId,
  parentId,
}: Pick<Category, "description" | "name" | "color"> & {
  userId: User["id"];
  organizationId: Organization["id"];
  parentId?: Category["parentId"];
}) {
  try {
    const validatedParentId = await validateParentCategory({
      organizationId,
      parentId,
    });

    return await db.category.create({
      data: {
        name: name.trim(),
        description,
        color,
        user: { connect: { id: userId } },
        organization: { connect: { id: organizationId } },
        ...(validatedParentId && {
          parent: { connect: { id: validatedParentId } },
        }),
      },
    });
  } catch (cause) {
    if (isLikeShelfError(cause)) throw cause;
    throw maybeUniqueConstraintViolation(cause, "Category", {
      additionalData: { userId, organizationId },
    });
  }
}
```

- [ ] **Step 7: Update updateCategory to handle parentId**

Update the `updateCategory` function to accept and validate `parentId`:

```typescript
export async function updateCategory({
  id,
  name,
  description,
  color,
  organizationId,
  parentId,
}: Pick<Category, "id" | "description" | "name" | "color"> & {
  organizationId: Organization["id"];
  parentId?: Category["parentId"];
}) {
  try {
    const validatedParentId =
      parentId === undefined
        ? undefined
        : await validateParentCategory({
            organizationId,
            parentId,
            currentCategoryId: id,
          });

    return await db.category.update({
      where: { id },
      data: {
        name: name.trim(),
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
    if (isLikeShelfError(cause)) throw cause;
    throw maybeUniqueConstraintViolation(cause, "Category", {
      additionalData: { id, organizationId },
    });
  }
}
```

- [ ] **Step 8: Add CATEGORY_LIST_INCLUDE constant**

```typescript
/** Include clause for category list views — adds parent info and child/asset counts. */
export const CATEGORY_LIST_INCLUDE = {
  _count: { select: { assets: true, children: true } },
  parent: {
    select: {
      id: true,
      name: true,
    },
  },
} satisfies Prisma.CategoryInclude;
```

Update `getCategories()` to use this include.

- [ ] **Step 9: Commit**

```bash
git add apps/webapp/app/modules/category/service.server.ts
git commit -m "feat(category): add hierarchy validation, ancestors, descendants, tree queries"
```

---

### Task 4: Category Tree UI Component

**Files:**

- Create: `apps/webapp/app/components/category/category-tree.tsx`

- [ ] **Step 1: Create CategoryTree component**

Create `apps/webapp/app/components/category/category-tree.tsx`:

```typescript
/**
 * Category Tree
 *
 * Renders a nested list of child categories with indentation.
 * Mirrors the LocationTree component pattern.
 *
 * @see {@link file://../../components/location/location-tree.tsx}
 */

import type { Category } from "@prisma/client";
import { Button } from "../shared/button";

/** Minimal tree node for nested rendering. */
export type CategoryTreeNode = Pick<Category, "id" | "name"> & {
  children: CategoryTreeNode[];
};

type CategoryTreeProps = {
  /** Tree nodes to render. */
  nodes: CategoryTreeNode[];
  /** Optional node ID to highlight as active (non-clickable). */
  activeId?: string;
  /** When true, link clicks open in a new tab. */
  targetBlank?: boolean;
};

/**
 * Renders a nested category tree with indentation and left borders.
 *
 * @param props.nodes - Array of root-level tree nodes with children
 * @param props.activeId - ID of the currently active category
 * @param props.targetBlank - Whether links open in new tabs
 */
export function CategoryTree({
  nodes,
  activeId,
  targetBlank = true,
}: CategoryTreeProps) {
  if (!nodes.length) return null;

  return (
    <ul className="space-y-1">
      {nodes.map((node) => {
        const isActive = node.id === activeId;
        return (
          <li key={node.id} className="space-y-1">
            {isActive ? (
              <div className="rounded border border-gray-200 bg-gray-50 px-3 py-2 text-sm font-semibold text-gray-900">
                {node.name}
              </div>
            ) : (
              <Button
                to={`/categories/${node.id}`}
                variant="block-link"
                target={targetBlank ? "_blank" : undefined}
              >
                {node.name}
              </Button>
            )}
            {node.children.length ? (
              <div className="ml-4 border-l border-gray-200 pl-4">
                <CategoryTree
                  nodes={node.children}
                  activeId={activeId}
                  targetBlank={targetBlank}
                />
              </div>
            ) : null}
          </li>
        );
      })}
    </ul>
  );
}
```

- [ ] **Step 2: Commit**

```bash
git add apps/webapp/app/components/category/category-tree.tsx
git commit -m "feat(category): add CategoryTree display component"
```

---

### Task 5: Category Tree API Endpoint

**Files:**

- Create: `apps/webapp/app/routes/api+/categories.$categoryId.tree.tsx`

- [ ] **Step 1: Create tree API route**

Create `apps/webapp/app/routes/api+/categories.$categoryId.tree.tsx`:

```typescript
/**
 * Category Tree API
 *
 * Returns the ancestor chain and descendant tree for a category.
 * Used by category badge hover cards and detail pages.
 *
 * @see {@link file://../../modules/category/service.server.ts}
 * @see {@link file://../../routes/api+/locations.$locationId.tree.tsx} - Location equivalent
 */

import { data, type LoaderFunctionArgs } from "react-router";
import { z } from "zod";
import {
  getCategory,
  getCategoryDescendantsTree,
  getCategoryHierarchy,
} from "~/modules/category/service.server";
import { makeShelfError } from "~/utils/error";
import { error, getParams, payload } from "~/utils/http.server";
import {
  PermissionAction,
  PermissionEntity,
} from "~/utils/permissions/permission.data";
import { requirePermission } from "~/utils/roles.server";

const paramsSchema = z.object({
  categoryId: z.string(),
});

/** Payload shape for the category tree API response. */
export type CategoryTreePayload = {
  category: { id: string; name: string };
  ancestors: Array<{ id: string; name: string }>;
  descendants: Awaited<ReturnType<typeof getCategoryDescendantsTree>>;
};

/**
 * Loader that returns the ancestor chain and descendant tree for a category.
 */
export async function loader({ context, request, params }: LoaderFunctionArgs) {
  const authSession = context.getSession();
  const { userId } = authSession;
  const { categoryId } = getParams(params, paramsSchema, {
    additionalData: { userId },
  });

  try {
    const { organizationId } = await requirePermission({
      userId,
      request,
      entity: PermissionEntity.category,
      action: PermissionAction.read,
    });

    const category = await getCategory({ id: categoryId, organizationId });

    const hierarchy = await getCategoryHierarchy({
      organizationId,
      categoryId,
    });
    const ancestors =
      hierarchy.length > 1
        ? hierarchy.slice(0, -1).map(({ id, name }) => ({ id, name }))
        : [];

    const descendants = await getCategoryDescendantsTree({
      organizationId,
      categoryId,
    });

    return data(
      payload<CategoryTreePayload>({
        category: { id: category.id, name: category.name },
        ancestors,
        descendants,
      })
    );
  } catch (cause) {
    const reason = makeShelfError(cause, { userId, categoryId });
    return data(error(reason), { status: reason.status });
  }
}
```

- [ ] **Step 2: Commit**

```bash
git add apps/webapp/app/routes/api+/categories.\$categoryId.tree.tsx
git commit -m "feat(category): add tree API endpoint for hierarchy data"
```

---

### Task 6: Update Category Form — Add Parent Selector

**Files:**

- Modify: `apps/webapp/app/components/category/new-category-form.tsx`

- [ ] **Step 1: Add parentId to schema and form**

Update `NewCategoryFormSchema` to include parentId:

```typescript
export const NewCategoryFormSchema = z.object({
  name: z.string().min(3, "Name is required"),
  description: z.string(),
  color: z.string().regex(/^#[0-9a-fA-F]{6}$/),
  parentId: z
    .string()
    .optional()
    .transform((value) => (value ? value : null)),
  preventRedirect: z.string().optional(),
});
```

Add a parent category selector to the form using `DynamicSelect` (same component used for location parent selection in asset forms). Add after the color input:

```tsx
<FormRow rowLabel="Parent category" className="border-b-0">
  <DynamicSelect
    disabled={disabled}
    model={{ name: "category", queryKey: "name" }}
    fieldName="parentId"
    contentLabel="Categories"
    label="Parent category"
    hideLabel
    placeholder="No parent"
    initialDataKey="categories"
    countKey="totalCategories"
    closeOnSelect
    selectionMode="set"
    allowClear={true}
    defaultValue={parentId ?? undefined}
    excludeIds={excludeId ? [excludeId] : undefined}
  />
</FormRow>
```

Add `parentId` and `excludeId` to component props.

- [ ] **Step 2: Commit**

```bash
git add apps/webapp/app/components/category/new-category-form.tsx
git commit -m "feat(category): add parent selector to category form"
```

---

### Task 7: Update Routes — Create, Edit, List

**Files:**

- Modify: `apps/webapp/app/routes/_layout+/categories.new.tsx`
- Modify: `apps/webapp/app/routes/_layout+/categories.$categoryId_.edit.tsx`
- Modify: `apps/webapp/app/routes/_layout+/categories.tsx`

- [ ] **Step 1: Update create route to pass parentId**

In `categories.new.tsx` action, extract `parentId` from the parsed payload and pass to `createCategory`:

```typescript
const { name, description, color, parentId, preventRedirect } = payload;

await createCategory({
  name,
  description,
  color,
  userId: authSession.userId,
  organizationId,
  parentId,
});
```

- [ ] **Step 2: Update edit route to load and save parentId**

In `categories.$categoryId_.edit.tsx`:

Loader — include parent info:

```typescript
const category = await getCategory({ id: categoryId, organizationId });
// category now includes parentId from DB
```

Action — extract and pass parentId:

```typescript
const { name, description, color, parentId } = payload;

await updateCategory({
  id: categoryId,
  name,
  description,
  color,
  organizationId,
  parentId,
});
```

Form — pass parentId and excludeId to the form component:

```typescript
<CategoryForm
  parentId={category.parentId}
  excludeId={category.id}
  // ... other props
/>
```

- [ ] **Step 3: Update list route to show hierarchy info**

In `categories.tsx`, update the loader to use `CATEGORY_LIST_INCLUDE` so each category row shows parent name and child count:

```typescript
// In the CategoryItem component, add:
{category.parent && (
  <span className="text-sm text-gray-500">
    Parent: {category.parent.name}
  </span>
)}
{category._count.children > 0 && (
  <span className="text-sm text-gray-500">
    {category._count.children} subcategories
  </span>
)}
```

- [ ] **Step 4: Commit**

```bash
git add apps/webapp/app/routes/_layout+/categories.new.tsx \
  apps/webapp/app/routes/_layout+/categories.\$categoryId_.edit.tsx \
  apps/webapp/app/routes/_layout+/categories.tsx
git commit -m "feat(category): wire parentId through create, edit, list routes"
```

---

### Task 8: Asset Filtering — Include Descendants

**Files:**

- Modify: `apps/webapp/app/modules/asset/utils.server.ts:480-497`

- [ ] **Step 1: Expand category filter to include descendant categories**

Replace the category filtering block in `getAssetsWhereInput()` with:

```typescript
import { getCategoryDescendantIds } from "~/modules/category/descendants.server";

// Inside getAssetsWhereInput, replace the categoriesIds block:
if (categoriesIds && categoriesIds.length > 0) {
  const hasUncategorized = categoriesIds.includes("uncategorized");
  const realCategoryIds = categoriesIds.filter((id) => id !== "uncategorized");

  // Expand each selected category to include all its descendants
  const expandedIds: string[] = [];
  for (const catId of realCategoryIds) {
    const descendants = await getCategoryDescendantIds({
      organizationId,
      categoryId: catId,
      includeSelf: true,
    });
    expandedIds.push(...descendants);
  }

  // Deduplicate
  const uniqueIds = [...new Set(expandedIds)];

  if (hasUncategorized) {
    where.OR = [{ categoryId: { in: uniqueIds } }, { categoryId: null }];
  } else if (uniqueIds.length > 0) {
    where.categoryId = { in: uniqueIds };
  }
}
```

Note: `getAssetsWhereInput` needs to become async (or the caller handles the async expansion). Check if it's already async — if not, make it async and update callers.

- [ ] **Step 2: Commit**

```bash
git add apps/webapp/app/modules/asset/utils.server.ts
git commit -m "feat(category): expand asset filters to include descendant categories"
```

---

### Task 9: Tests

**Files:**

- Create: `apps/webapp/app/modules/category/service.server.test.ts`

- [ ] **Step 1: Write hierarchy validation tests**

Create `apps/webapp/app/modules/category/service.server.test.ts`:

```typescript
import { describe, it, expect, vi, beforeEach } from "vitest";

// Tests should cover:
// 1. validateParentCategory rejects self-parenting
// 2. validateParentCategory rejects cycles (A->B->A)
// 3. validateParentCategory rejects exceeding max depth
// 4. validateParentCategory accepts valid parent
// 5. validateParentCategory accepts null (no parent)
// 6. createCategory with parentId
// 7. updateCategory changing parentId
// 8. updateCategory removing parentId (disconnect)
```

Write behavior-driven tests following the project's testing patterns. Mock the database with `// why: testing validation logic, not DB`.

- [ ] **Step 2: Run tests**

```bash
pnpm --filter @shelf/webapp test -- --run app/modules/category/service.server.test.ts
```

Expected: All tests pass.

- [ ] **Step 3: Commit**

```bash
git add apps/webapp/app/modules/category/service.server.test.ts
git commit -m "test(category): add hierarchy validation tests"
```

---

### Task 10: Typecheck + Validate

- [ ] **Step 1: Run full validation**

```bash
pnpm webapp:validate
```

Expected: Prisma generate, ESLint, Prettier, TypeScript, and tests all pass.

- [ ] **Step 2: Final commit if any formatting changes**

```bash
git add -A
git commit -m "chore: fix lint and formatting from category hierarchy feature"
```
