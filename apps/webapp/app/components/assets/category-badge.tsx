/**
 * Category Badge
 *
 * Displays a category as a colored badge. When the category has a parent
 * or children, a tree icon appears and hovering reveals the full hierarchy
 * in a hover card (parent chain + child categories).
 *
 * Mirrors the LocationBadge pattern.
 *
 * @see {@link file://../../components/location/location-badge.tsx}
 * @see {@link file://../../routes/api+/categories.$categoryId.tree.tsx}
 */

import { useEffect, useMemo, useState } from "react";
import type { Category } from "@prisma/client";
import { HoverCardPortal } from "@radix-ui/react-hover-card";
import { ListTree } from "lucide-react";
import useApiQuery from "~/hooks/use-api-query";
import { useUserRoleHelper } from "~/hooks/user-user-role-helper";
import type { CategoryTreePayload } from "~/routes/api+/categories.$categoryId.tree";
import {
  PermissionAction,
  PermissionEntity,
} from "~/utils/permissions/permission.data";
import { userHasPermission } from "~/utils/permissions/permission.validator.client";
import { CategoryTree, type CategoryTreeNode } from "../category/category-tree";
import { Badge } from "../shared/badge";
import { Button } from "../shared/button";
import {
  HoverCard,
  HoverCardContent,
  HoverCardTrigger,
} from "../shared/hover-card";

/** Minimal category shape needed for the badge. */
type CategorySummary = Pick<Category, "id" | "name" | "color"> & {
  parentId?: Category["parentId"];
  childCount?: number;
};

/** Props for the CategoryBadge component. */
type CategoryBadgeProps = {
  /** Category data. Null renders an "Uncategorized" badge. */
  category: CategorySummary | null;
  className?: string;
};

/**
 * Builds a nested tree from the ancestor array + current node,
 * so the hover card can render the full parent chain.
 */
function buildParentChainTree(
  ancestors: CategoryTreePayload["ancestors"],
  current: Pick<CategoryTreePayload["category"], "id" | "name">
): CategoryTreeNode[] {
  if (!ancestors.length) {
    return [{ id: current.id, name: current.name, children: [] }];
  }

  const root: CategoryTreeNode = {
    id: ancestors[0].id,
    name: ancestors[0].name,
    children: [],
  };

  let pointer = root;
  for (let i = 1; i < ancestors.length; i++) {
    const node: CategoryTreeNode = {
      id: ancestors[i].id,
      name: ancestors[i].name,
      children: [],
    };
    pointer.children = [node];
    pointer = node;
  }

  pointer.children = [{ id: current.id, name: current.name, children: [] }];

  return [root];
}

export function CategoryBadge({ category, className }: CategoryBadgeProps) {
  const [shouldFetch, setShouldFetch] = useState(false);

  useEffect(() => {
    setShouldFetch(false);
  }, [category?.id]);

  const apiEndpoint = useMemo(() => {
    if (!category?.id) return "";
    return `/api/categories/${category.id}/tree`;
  }, [category?.id]);

  const { roles } = useUserRoleHelper();
  const canReadCategories = userHasPermission({
    roles,
    entity: PermissionEntity.category,
    action: PermissionAction.read,
  });

  const hasHierarchy =
    Boolean(category?.parentId) || (category?.childCount ?? 0) > 0;

  const { data, isLoading, error } = useApiQuery<CategoryTreePayload>({
    api: apiEndpoint,
    enabled: shouldFetch && hasHierarchy && Boolean(category?.id),
  });

  // No category — show "Uncategorized" badge
  if (!category) {
    return (
      <Badge color="#575757" withDot={false} className={className}>
        Uncategorized
      </Badge>
    );
  }

  // No hierarchy or no permission — simple colored badge
  if (!hasHierarchy || !canReadCategories) {
    return (
      <Badge color={category.color} withDot={false} className={className}>
        {category.name}
      </Badge>
    );
  }

  const handleOpenChange = (nextOpen: boolean) => {
    if (nextOpen && !shouldFetch) {
      setShouldFetch(true);
    }
  };

  const handleMouseEnter = () => {
    if (!shouldFetch) {
      setShouldFetch(true);
    }
  };

  const content = (() => {
    if (error) {
      return (
        <p className="text-sm text-red-600">
          {error || "Unable to load category hierarchy."}
        </p>
      );
    }

    if (isLoading || !data || !data.category) {
      return <p className="text-sm text-gray-500">Loading hierarchy...</p>;
    }

    const { category: currentCategory, ancestors, descendants } = data;

    const hasChildren = descendants.length > 0;
    const hasAncestors = ancestors.length > 0;

    return (
      <div className="space-y-3 text-sm">
        <div>
          <p className="font-semibold text-gray-500">Current category</p>
          <Button
            to={`/categories/${currentCategory.id}`}
            variant="block-link"
            target="_blank"
          >
            {currentCategory.name}
          </Button>
        </div>

        {hasAncestors ? (
          <div>
            <p className="font-semibold text-gray-500">Parent chain</p>
            <div className="mt-2">
              <CategoryTree
                nodes={buildParentChainTree(ancestors, currentCategory)}
                activeId={currentCategory.id}
              />
            </div>
          </div>
        ) : null}

        <div>
          <p className="font-semibold text-gray-500">Subcategories</p>
          {hasChildren ? (
            <div className="mt-2">
              <CategoryTree nodes={descendants} />
            </div>
          ) : (
            <p className="mt-2 text-sm text-gray-600">No subcategories.</p>
          )}
        </div>
      </div>
    );
  })();

  return (
    <HoverCard onOpenChange={handleOpenChange} openDelay={0}>
      <HoverCardTrigger asChild>
        <span onMouseEnter={handleMouseEnter} className="inline-flex">
          <Badge color={category.color} withDot={false} className={className}>
            <span className="inline-flex items-center gap-1">
              <span className="max-w-[150px] truncate">{category.name}</span>
              <ListTree className="size-3.5" strokeWidth={1.75} />
            </span>
          </Badge>
        </span>
      </HoverCardTrigger>
      <HoverCardPortal>
        <HoverCardContent
          className="max-w-md"
          style={{ width: "max-content", minWidth: "18rem" }}
        >
          {content}
        </HoverCardContent>
      </HoverCardPortal>
    </HoverCard>
  );
}
