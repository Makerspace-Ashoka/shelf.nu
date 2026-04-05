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
