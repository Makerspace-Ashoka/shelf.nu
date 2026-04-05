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
