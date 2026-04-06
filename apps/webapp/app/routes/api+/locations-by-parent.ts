/**
 * Locations By Parent API
 *
 * Returns locations at a given hierarchy level with a hasChildren flag.
 * Used by the HierarchicalLocationSelect component for drill-down navigation.
 *
 * Query params:
 *   - parentId: Parent location ID (omit or empty for root-level)
 *   - search: Optional name search filter
 *
 * @see {@link file://../../modules/location/service.server.ts}
 */

import { data, type LoaderFunctionArgs } from "react-router";
import { getLocationsByParentId } from "~/modules/location/service.server";
import { makeShelfError } from "~/utils/error";
import { error, payload } from "~/utils/http.server";
import {
  PermissionAction,
  PermissionEntity,
} from "~/utils/permissions/permission.data";
import { requirePermission } from "~/utils/roles.server";

/** Shape of each location item returned by this endpoint. */
export type LocationByParentItem = {
  id: string;
  name: string;
  hasChildren: boolean;
};

/** Response payload shape for this endpoint. */
export type LocationsByParentPayload = {
  locations: LocationByParentItem[];
};

export async function loader({ context, request }: LoaderFunctionArgs) {
  const authSession = context.getSession();
  const { userId } = authSession;

  try {
    const { organizationId } = await requirePermission({
      userId,
      request,
      entity: PermissionEntity.location,
      action: PermissionAction.read,
    });

    const url = new URL(request.url);
    const parentId = url.searchParams.get("parentId") || null;
    const search = url.searchParams.get("search") || undefined;

    const locations = await getLocationsByParentId({
      organizationId,
      parentId,
      search,
    });

    return data(payload<LocationsByParentPayload>({ locations }));
  } catch (cause) {
    const reason = makeShelfError(cause, { userId });
    return data(error(reason), { status: reason.status });
  }
}
