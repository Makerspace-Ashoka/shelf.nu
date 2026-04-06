/**
 * Categories By Parent API
 *
 * Returns categories at a given hierarchy level with a hasChildren flag.
 * Used by the HierarchicalCategorySelect component for drill-down navigation.
 *
 * Query params:
 *   - parentId: Parent category ID (omit or empty for root-level)
 *   - search: Optional name search filter
 *
 * @see {@link file://../../modules/category/service.server.ts}
 */

import { data, type LoaderFunctionArgs } from "react-router";
import { getCategoriesByParentId } from "~/modules/category/service.server";
import { makeShelfError } from "~/utils/error";
import { error, payload } from "~/utils/http.server";
import {
  PermissionAction,
  PermissionEntity,
} from "~/utils/permissions/permission.data";
import { requirePermission } from "~/utils/roles.server";

/** Shape of each category item returned by this endpoint. */
export type CategoryByParentItem = {
  id: string;
  name: string;
  color: string;
  hasChildren: boolean;
};

/** Response payload shape for this endpoint. */
export type CategoriesByParentPayload = {
  categories: CategoryByParentItem[];
};

export async function loader({ context, request }: LoaderFunctionArgs) {
  const authSession = context.getSession();
  const { userId } = authSession;

  try {
    const { organizationId } = await requirePermission({
      userId,
      request,
      entity: PermissionEntity.category,
      action: PermissionAction.read,
    });

    const url = new URL(request.url);
    const parentId = url.searchParams.get("parentId") || null;
    const search = url.searchParams.get("search") || undefined;

    const categories = await getCategoriesByParentId({
      organizationId,
      parentId,
      search,
    });

    return data(payload<CategoriesByParentPayload>({ categories }));
  } catch (cause) {
    const reason = makeShelfError(cause, { userId });
    return data(error(reason), { status: reason.status });
  }
}
