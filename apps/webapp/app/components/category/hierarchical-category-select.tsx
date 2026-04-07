/**
 * HierarchicalCategorySelect
 *
 * Thin wrapper around HierarchicalSelect configured for categories.
 * Adds color dot support and defaults to the category API endpoint.
 *
 * @see {@link file://../shared/hierarchical-select.tsx} - Base component
 * @see {@link file://../../routes/api+/categories-by-parent.ts} - Data source
 */

import type { ReactNode } from "react";
import {
  HierarchicalSelect,
  type HierarchicalSelectHelpers,
} from "../shared/hierarchical-select";

/** Props for {@link HierarchicalCategorySelect}. */
type HierarchicalCategorySelectProps = {
  defaultValue?: string;
  defaultValueName?: string;
  defaultValueColor?: string;
  disabled?: boolean;
  onChange?: (categoryId: string | undefined) => void;
  extraContent?:
    | ReactNode
    | ((helpers: HierarchicalSelectHelpers) => ReactNode);
};

/**
 * Drill-down category selector with color dots.
 */
export function HierarchicalCategorySelect({
  defaultValue,
  defaultValueName,
  defaultValueColor,
  disabled,
  onChange,
  extraContent,
}: HierarchicalCategorySelectProps) {
  return (
    <HierarchicalSelect
      apiEndpoint="/api/categories-by-parent"
      dataKey="categories"
      fieldName="category"
      entityLabel="category"
      entityLabelPlural="categories"
      showColorDot
      defaultValue={defaultValue}
      defaultValueName={defaultValueName}
      defaultValueColor={defaultValueColor}
      disabled={disabled}
      onChange={onChange}
      extraContent={extraContent}
    />
  );
}
