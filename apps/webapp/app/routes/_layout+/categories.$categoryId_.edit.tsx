/**
 * Edit Category Route
 *
 * Handles loading a single category for editing and processing the update
 * action. Uses `NewCategoryFormSchema` (which includes the `parentId` field)
 * so that parent-category assignments can be updated during an edit.
 * The inline form renders a `DynamicSelect` for the parent selector,
 * mirroring what `NewCategoryForm` does for the create flow.
 *
 * @see {@link file://./../../modules/category/service.server.ts}
 * @see {@link file://./../../components/category/new-category-form.tsx}
 */
import type { LoaderFunctionArgs, MetaFunction } from "react-router";
import {
  data,
  redirect,
  useActionData,
  useLoaderData,
  useNavigation,
} from "react-router";
import { useZorm } from "react-zorm";
import { z } from "zod";
import { NewCategoryFormSchema } from "~/components/category/new-category-form";
import { Form } from "~/components/custom-form";
import DynamicSelect from "~/components/dynamic-select/dynamic-select";
import { ColorInput } from "~/components/forms/color-input";
import Input from "~/components/forms/input";

import { Button } from "~/components/shared/button";

import { getCategory, updateCategory } from "~/modules/category/service.server";
import { appendToMetaTitle } from "~/utils/append-to-meta-title";
import { sendNotification } from "~/utils/emitter/send-notification.server";
import { makeShelfError } from "~/utils/error";
import { isFormProcessing } from "~/utils/form";
import { error, getParams, payload, parseData } from "~/utils/http.server";

import {
  PermissionAction,
  PermissionEntity,
} from "~/utils/permissions/permission.data";
import { requirePermission } from "~/utils/roles.server";
import { zodFieldIsRequired } from "~/utils/zod";

const title = "Edit category";

export async function loader({ context, request, params }: LoaderFunctionArgs) {
  const authSession = context.getSession();
  const { userId } = authSession;

  const { categoryId: id } = getParams(
    params,
    z.object({ categoryId: z.string() }),
    {
      additionalData: { userId },
    }
  );

  try {
    const { organizationId } = await requirePermission({
      userId: authSession.userId,
      request,
      entity: PermissionEntity.category,
      action: PermissionAction.update,
    });

    const category = await getCategory({ id, organizationId });

    const colorFromServer = category.color;

    const header = { title };

    /** Include parentId so the form can pre-populate the parent selector. */
    return payload({ header, colorFromServer, category });
  } catch (cause) {
    const reason = makeShelfError(cause, { userId, id });
    throw data(error(reason), { status: reason.status });
  }
}

export const meta: MetaFunction<typeof loader> = ({ data }) => [
  { title: data ? appendToMetaTitle(data.header.title) : "" },
];

export async function action({ context, request, params }: LoaderFunctionArgs) {
  const authSession = context.getSession();
  const { userId } = authSession;
  const { categoryId: id } = getParams(
    params,
    z.object({ categoryId: z.string() }),
    {
      additionalData: { userId },
    }
  );

  try {
    const { organizationId } = await requirePermission({
      userId: authSession.userId,
      request,
      entity: PermissionEntity.category,
      action: PermissionAction.update,
    });

    /** Parse with NewCategoryFormSchema to include parentId in validation. */
    const { name, description, color, parentId } = parseData(
      await request.formData(),
      NewCategoryFormSchema,
      {
        additionalData: { userId, id, organizationId },
      }
    );

    await updateCategory({
      id,
      name,
      description,
      color,
      organizationId,
      parentId,
    });

    sendNotification({
      title: "Category Updated",
      message: "Your category has been updated successfully",
      icon: { name: "success", variant: "success" },
      senderId: authSession.userId,
    });

    return redirect(`/categories`);
  } catch (cause) {
    const reason = makeShelfError(cause, { userId, id });
    return data(error(reason), { status: reason.status });
  }
}

export default function EditCategory() {
  const zo = useZorm("NewQuestionWizardScreen", NewCategoryFormSchema);
  const navigation = useNavigation();
  const disabled = isFormProcessing(navigation.state);
  const { colorFromServer, category } = useLoaderData<typeof loader>();
  const actionData = useActionData<typeof action>();

  return (
    <Form
      key={category.id}
      method="post"
      className="block rounded border border-gray-200 bg-white px-6 py-5"
      ref={zo.ref}
    >
      <div className="lg:flex lg:items-end lg:justify-between lg:gap-3">
        <div className="gap-3 lg:flex lg:flex-wrap lg:items-end">
          <Input
            label="Name"
            placeholder="Category name"
            className="mb-4 lg:mb-0 lg:max-w-[180px]"
            name={zo.fields.name()}
            disabled={disabled}
            error={zo.errors.name()?.message}
            hideErrorText
            autoFocus
            required={zodFieldIsRequired(NewCategoryFormSchema.shape.name)}
            defaultValue={category.name}
          />
          <Input
            label="Description"
            placeholder="Description (optional)"
            name={zo.fields.description()}
            disabled={disabled}
            data-test-id="categoryDescription"
            className="mb-4 lg:mb-0"
            required={zodFieldIsRequired(
              NewCategoryFormSchema.shape.description
            )}
            defaultValue={category.description || undefined}
          />
          <div className="mb-6 lg:mb-0">
            <ColorInput
              name={zo.fields.color()}
              disabled={disabled}
              error={zo.errors.color()?.message}
              hideErrorText
              colorFromServer={colorFromServer}
              required={zodFieldIsRequired(NewCategoryFormSchema.shape.color)}
            />
          </div>

          {/* Parent category selector — allows changing/clearing the hierarchy assignment */}
          <div className="mb-4 lg:mb-0">
            <DynamicSelect
              disabled={disabled}
              model={{ name: "category", queryKey: "name" }}
              fieldName="parentId"
              contentLabel="Categories"
              label="Parent category"
              initialDataKey="categories"
              countKey="totalCategories"
              placeholder="No parent"
              closeOnSelect
              selectionMode="set"
              allowClear={true}
              /** Pre-populate with the current parent so the user sees existing assignment */
              defaultValue={category.parentId ?? undefined}
              /** Exclude the category itself to prevent self-parenting */
              excludeItems={[category.id]}
            />
          </div>
        </div>

        <div className="flex items-center gap-1">
          <Button variant="secondary" to="/categories" size="sm">
            Cancel
          </Button>
          <Button type="submit" size="sm">
            Update
          </Button>
        </div>
      </div>
      {actionData?.error ? (
        <div className="mt-3 text-sm text-error-500">
          {actionData?.error?.message}
        </div>
      ) : null}
    </Form>
  );
}
