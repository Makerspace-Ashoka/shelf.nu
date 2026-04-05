/**
 * Category Service — Hierarchy Validation Tests
 *
 * Tests for `createCategory`, `updateCategory`, `getCategoryHierarchy`, and
 * `getCategoryDescendantsTree`.  The private `validateParentCategory` function
 * is exercised indirectly through the public CRUD operations.
 *
 * All database interactions are mocked: the service contains raw SQL CTEs that
 * are not executable in a unit-test environment without a live PostgreSQL
 * instance, so mocking `db` keeps tests fast and deterministic.
 *
 * @see {@link file://./service.server.ts}
 */
import { beforeEach, describe, expect, it, vi } from "vitest";

// why: the category service issues raw SQL via $queryRaw which requires a live
// PostgreSQL connection; mocking db isolates business-logic assertions from the
// infrastructure layer.
vi.mock("~/database/db.server", () => ({
  db: {
    $queryRaw: vi.fn(),
    category: {
      findFirst: vi.fn(),
      create: vi.fn(),
      update: vi.fn(),
    },
  },
}));

const { db } = await import("~/database/db.server");
const {
  createCategory,
  updateCategory,
  getCategoryHierarchy,
  getCategoryDescendantsTree,
} = await import("./service.server");

/** Convenience mocks with proper typing. */
const mockFindFirst = vi.mocked(db.category.findFirst);
const mockCreate = vi.mocked(db.category.create);
const mockUpdate = vi.mocked(db.category.update);
const mockQueryRaw = vi.mocked(db.$queryRaw);

/** Shared IDs reused across tests for clarity. */
const ORG_ID = "org-test-111";
const USER_ID = "user-test-222";
const CATEGORY_ID = "cat-aaa-333";
const PARENT_ID = "cat-parent-444";
const CHILD_ID = "cat-child-555";

/** Minimal Category shape returned by db mocks. */
const makeCategory = (overrides: Record<string, unknown> = {}) => ({
  id: CATEGORY_ID,
  name: "Test Category",
  description: null,
  color: "#ffffff",
  organizationId: ORG_ID,
  parentId: null,
  userId: USER_ID,
  createdAt: new Date("2024-01-01"),
  updatedAt: new Date("2024-01-01"),
  ...overrides,
});

// ---------------------------------------------------------------------------
// createCategory
// ---------------------------------------------------------------------------

describe("createCategory", () => {
  beforeEach(() => {
    vi.clearAllMocks();
  });

  it("creates a category without a parentId (existing root behaviour)", async () => {
    // No parentId supplied → validateParentCategory returns null immediately
    // without any DB look-up; only db.category.create is called.
    mockCreate.mockResolvedValue(makeCategory());

    const result = await createCategory({
      name: "Electronics",
      description: null,
      color: "#aabbcc",
      userId: USER_ID,
      organizationId: ORG_ID,
    });

    expect(mockFindFirst).not.toHaveBeenCalled();
    expect(mockCreate).toHaveBeenCalledOnce();
    expect(mockCreate).toHaveBeenCalledWith(
      expect.objectContaining({
        data: expect.objectContaining({
          name: "Electronics",
          color: "#aabbcc",
        }),
      })
    );
    expect(result).toMatchObject({ id: CATEGORY_ID });
  });

  it("trims whitespace from the category name before saving", async () => {
    mockCreate.mockResolvedValue(makeCategory({ name: "Trimmed" }));

    await createCategory({
      name: "  Trimmed  ",
      description: null,
      color: "#000000",
      userId: USER_ID,
      organizationId: ORG_ID,
    });

    expect(mockCreate).toHaveBeenCalledWith(
      expect.objectContaining({
        data: expect.objectContaining({ name: "Trimmed" }),
      })
    );
  });

  it("creates a category with a valid parentId and connects the parent", async () => {
    // validateParentCategory: findFirst returns the parent → exists check passes.
    // getCategoryHierarchy ($queryRaw) returns a single root entry with depth 0,
    // meaning parentDepth = 0 and no circular reference exists.
    mockFindFirst.mockResolvedValue(makeCategory({ id: PARENT_ID }));
    mockQueryRaw.mockResolvedValue([
      { id: PARENT_ID, name: "Parent", parentId: null, depth: 0 },
    ]);
    mockCreate.mockResolvedValue(makeCategory({ parentId: PARENT_ID }));

    const result = await createCategory({
      name: "Child Category",
      description: null,
      color: "#ff0000",
      userId: USER_ID,
      organizationId: ORG_ID,
      parentId: PARENT_ID,
    });

    expect(mockFindFirst).toHaveBeenCalledWith(
      expect.objectContaining({
        where: { id: PARENT_ID, organizationId: ORG_ID },
      })
    );
    expect(mockCreate).toHaveBeenCalledWith(
      expect.objectContaining({
        data: expect.objectContaining({
          parent: { connect: { id: PARENT_ID } },
        }),
      })
    );
    expect(result).toMatchObject({ parentId: PARENT_ID });
  });

  it("throws a 404 ShelfError when the parentId does not exist in the organisation", async () => {
    // validateParentCategory: findFirst returns null → parent not found.
    mockFindFirst.mockResolvedValue(null);

    await expect(
      createCategory({
        name: "Orphan",
        description: null,
        color: "#000000",
        userId: USER_ID,
        organizationId: ORG_ID,
        parentId: "nonexistent-parent",
      })
    ).rejects.toMatchObject({
      message: "Parent category not found.",
      status: 404,
    });

    expect(mockCreate).not.toHaveBeenCalled();
  });

  it("does not throw for self-parenting during create (no id yet — guard cannot trigger)", async () => {
    // During create, currentCategoryId is undefined so the self-reference guard
    // inside validateParentCategory is skipped.  The parent must still exist.
    mockFindFirst.mockResolvedValue(makeCategory({ id: PARENT_ID }));
    mockQueryRaw.mockResolvedValue([
      { id: PARENT_ID, name: "Parent", parentId: null, depth: 0 },
    ]);
    mockCreate.mockResolvedValue(makeCategory({ parentId: PARENT_ID }));

    // Should succeed — there is no "self" to compare against at creation time.
    await expect(
      createCategory({
        name: "New Category",
        description: null,
        color: "#aaa",
        userId: USER_ID,
        organizationId: ORG_ID,
        parentId: PARENT_ID,
      })
    ).resolves.toBeDefined();
  });
});

// ---------------------------------------------------------------------------
// updateCategory
// ---------------------------------------------------------------------------

describe("updateCategory", () => {
  beforeEach(() => {
    vi.clearAllMocks();
  });

  it("updates a category to use a new valid parentId", async () => {
    // validateParentCategory: parent exists, hierarchy has no circular ref.
    mockFindFirst.mockResolvedValue(makeCategory({ id: PARENT_ID }));
    mockQueryRaw.mockResolvedValue([
      { id: PARENT_ID, name: "Parent", parentId: null, depth: 0 },
    ]);
    // getCategorySubtreeDepth ($queryRaw) returns maxDepth 0 for a leaf node.
    mockQueryRaw.mockResolvedValueOnce([
      { id: PARENT_ID, name: "Parent", parentId: null, depth: 0 },
    ]);
    mockQueryRaw.mockResolvedValueOnce([{ maxDepth: 0 }]);
    mockUpdate.mockResolvedValue(makeCategory({ parentId: PARENT_ID }));

    const result = await updateCategory({
      id: CATEGORY_ID,
      organizationId: ORG_ID,
      name: "Updated Name",
      description: null,
      color: "#111111",
      parentId: PARENT_ID,
    });

    expect(mockUpdate).toHaveBeenCalledWith(
      expect.objectContaining({
        where: { id: CATEGORY_ID, organizationId: ORG_ID },
        data: expect.objectContaining({
          parent: { connect: { id: PARENT_ID } },
        }),
      })
    );
    expect(result).toMatchObject({ parentId: PARENT_ID });
  });

  it("disconnects the parent when parentId is explicitly null", async () => {
    // validateParentCategory with parentId = null returns null without querying.
    mockUpdate.mockResolvedValue(makeCategory({ parentId: null }));

    const result = await updateCategory({
      id: CATEGORY_ID,
      organizationId: ORG_ID,
      name: "Top-Level Category",
      description: null,
      color: "#ffffff",
      parentId: null,
    });

    // No hierarchy DB calls needed when clearing the parent.
    expect(mockFindFirst).not.toHaveBeenCalled();
    expect(mockUpdate).toHaveBeenCalledWith(
      expect.objectContaining({
        data: expect.objectContaining({
          parent: { disconnect: true },
        }),
      })
    );
    expect(result).toMatchObject({ parentId: null });
  });

  it("leaves the parent unchanged when parentId is undefined", async () => {
    mockUpdate.mockResolvedValue(makeCategory());

    await updateCategory({
      id: CATEGORY_ID,
      organizationId: ORG_ID,
      name: "Same Parent",
      description: null,
      color: "#cccccc",
      // parentId intentionally omitted (undefined)
    });

    // No validation queries should be triggered.
    expect(mockFindFirst).not.toHaveBeenCalled();
    // The `parent` key must NOT appear in the update payload.
    expect(mockUpdate).toHaveBeenCalledWith(
      expect.objectContaining({
        data: expect.not.objectContaining({ parent: expect.anything() }),
      })
    );
  });

  it("throws a 400 ShelfError when a category is assigned as its own parent", async () => {
    // self-parenting: parentId === currentCategoryId
    await expect(
      updateCategory({
        id: CATEGORY_ID,
        organizationId: ORG_ID,
        name: "Self Parent",
        description: null,
        color: "#000",
        parentId: CATEGORY_ID, // same as id
      })
    ).rejects.toMatchObject({
      message: "A category cannot be its own parent.",
      status: 400,
    });

    expect(mockUpdate).not.toHaveBeenCalled();
  });

  it("throws a 400 ShelfError when assigning a descendant as parent (circular reference)", async () => {
    // Scenario: A → B (B is child of A).  We try to update A so its parent = B.
    // validateParentCategory fetches the hierarchy of B.  The result includes A,
    // which makes the circular-reference guard trigger.
    mockFindFirst.mockResolvedValue(makeCategory({ id: CHILD_ID }));
    mockQueryRaw
      // getCategoryHierarchy for CHILD_ID returns CHILD_ID at depth 0 and
      // CATEGORY_ID (the category being updated) as its ancestor at depth 1.
      .mockResolvedValueOnce([
        { id: CATEGORY_ID, name: "Category A", parentId: null, depth: 1 },
        { id: CHILD_ID, name: "Category B", parentId: CATEGORY_ID, depth: 0 },
      ])
      // getCategorySubtreeDepth for CATEGORY_ID (the category being updated)
      // returns maxDepth 1 (it has one child — CHILD_ID).
      .mockResolvedValueOnce([{ maxDepth: 1 }]);

    await expect(
      updateCategory({
        id: CATEGORY_ID,
        organizationId: ORG_ID,
        name: "Category A",
        description: null,
        color: "#000",
        parentId: CHILD_ID, // CHILD_ID is a descendant of CATEGORY_ID → circular
      })
    ).rejects.toMatchObject({
      message: "A category cannot be assigned to one of its descendants.",
      status: 400,
    });

    expect(mockUpdate).not.toHaveBeenCalled();
  });
});

// ---------------------------------------------------------------------------
// getCategoryHierarchy
// ---------------------------------------------------------------------------

describe("getCategoryHierarchy", () => {
  beforeEach(() => {
    vi.clearAllMocks();
  });

  it("returns an ordered ancestor chain from root to leaf", async () => {
    const hierarchyRows = [
      { id: "root-id", name: "Root", parentId: null, depth: 2 },
      { id: "mid-id", name: "Mid", parentId: "root-id", depth: 1 },
      { id: CATEGORY_ID, name: "Leaf", parentId: "mid-id", depth: 0 },
    ];
    mockQueryRaw.mockResolvedValue(hierarchyRows);

    const result = await getCategoryHierarchy({
      organizationId: ORG_ID,
      categoryId: CATEGORY_ID,
    });

    expect(mockQueryRaw).toHaveBeenCalledOnce();
    expect(result).toHaveLength(3);
    // Root should be first (highest depth), leaf last.
    expect(result[0]).toMatchObject({ id: "root-id", depth: 2 });
    expect(result[2]).toMatchObject({ id: CATEGORY_ID, depth: 0 });
  });

  it("returns a single-element array for a root category with no ancestors", async () => {
    mockQueryRaw.mockResolvedValue([
      { id: CATEGORY_ID, name: "Root Only", parentId: null, depth: 0 },
    ]);

    const result = await getCategoryHierarchy({
      organizationId: ORG_ID,
      categoryId: CATEGORY_ID,
    });

    expect(result).toHaveLength(1);
    expect(result[0]).toMatchObject({ id: CATEGORY_ID, depth: 0 });
  });

  it("returns an empty array when the category does not exist", async () => {
    mockQueryRaw.mockResolvedValue([]);

    const result = await getCategoryHierarchy({
      organizationId: ORG_ID,
      categoryId: "nonexistent-id",
    });

    expect(result).toEqual([]);
  });
});

// ---------------------------------------------------------------------------
// getCategoryDescendantsTree
// ---------------------------------------------------------------------------

describe("getCategoryDescendantsTree", () => {
  beforeEach(() => {
    vi.clearAllMocks();
  });

  it("returns an empty array when the category has no descendants", async () => {
    mockQueryRaw.mockResolvedValue([]);

    const result = await getCategoryDescendantsTree({
      organizationId: ORG_ID,
      categoryId: CATEGORY_ID,
    });

    expect(result).toEqual([]);
  });

  it("builds a nested tree from flat CTE rows", async () => {
    // Flat rows: CATEGORY_ID has two direct children, second child has one grandchild.
    const rows = [
      { id: "child-1", name: "Child 1", parentId: CATEGORY_ID },
      { id: "child-2", name: "Child 2", parentId: CATEGORY_ID },
      { id: "grandchild-1", name: "Grandchild 1", parentId: "child-2" },
    ];
    mockQueryRaw.mockResolvedValue(rows);

    const result = await getCategoryDescendantsTree({
      organizationId: ORG_ID,
      categoryId: CATEGORY_ID,
    });

    // Two top-level children should be returned.
    expect(result).toHaveLength(2);

    const child1 = result.find((n) => n.id === "child-1");
    const child2 = result.find((n) => n.id === "child-2");

    expect(child1).toBeDefined();
    expect(child1!.children).toHaveLength(0);

    expect(child2).toBeDefined();
    expect(child2!.children).toHaveLength(1);
    expect(child2!.children[0]).toMatchObject({ id: "grandchild-1" });
  });

  it("returns only top-level children at the root of the result array", async () => {
    const rows = [
      { id: "child-a", name: "A", parentId: CATEGORY_ID },
      { id: "child-b", name: "B", parentId: CATEGORY_ID },
      { id: "grandchild-a1", name: "A1", parentId: "child-a" },
    ];
    mockQueryRaw.mockResolvedValue(rows);

    const result = await getCategoryDescendantsTree({
      organizationId: ORG_ID,
      categoryId: CATEGORY_ID,
    });

    // Only direct children at root level.
    const rootIds = result.map((n) => n.id);
    expect(rootIds).toContain("child-a");
    expect(rootIds).toContain("child-b");
    expect(rootIds).not.toContain("grandchild-a1");
  });

  it("handles deeply nested single-branch trees", async () => {
    // Chain: root → A → B → C
    const rows = [
      { id: "level-1", name: "L1", parentId: CATEGORY_ID },
      { id: "level-2", name: "L2", parentId: "level-1" },
      { id: "level-3", name: "L3", parentId: "level-2" },
    ];
    mockQueryRaw.mockResolvedValue(rows);

    const result = await getCategoryDescendantsTree({
      organizationId: ORG_ID,
      categoryId: CATEGORY_ID,
    });

    expect(result).toHaveLength(1);
    expect(result[0].id).toBe("level-1");
    expect(result[0].children).toHaveLength(1);
    expect(result[0].children[0].id).toBe("level-2");
    expect(result[0].children[0].children[0].id).toBe("level-3");
  });
});
