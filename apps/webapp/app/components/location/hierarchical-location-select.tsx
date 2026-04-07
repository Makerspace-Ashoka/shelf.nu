/**
 * HierarchicalLocationSelect
 *
 * Thin wrapper around HierarchicalSelect configured for locations.
 * No color dots, configurable field name (defaults to "newLocationId").
 *
 * @see {@link file://../shared/hierarchical-select.tsx} - Base component
 * @see {@link file://../../routes/api+/locations-by-parent.ts} - Data source
 */

import type { ReactNode } from "react";
import {
  HierarchicalSelect,
  type HierarchicalSelectHelpers,
} from "../shared/hierarchical-select";

/** Props for {@link HierarchicalLocationSelect}. */
type HierarchicalLocationSelectProps = {
  defaultValue?: string;
  defaultValueName?: string;
  /** @default "newLocationId" */
  fieldName?: string;
  disabled?: boolean;
  onChange?: (locationId: string | undefined) => void;
  extraContent?:
    | ReactNode
    | ((helpers: HierarchicalSelectHelpers) => ReactNode);
};

/**
 * Drill-down location selector.
 */
export function HierarchicalLocationSelect({
  defaultValue,
  defaultValueName,
  fieldName = "newLocationId",
  disabled,
  onChange,
  extraContent,
}: HierarchicalLocationSelectProps) {
  return (
    <HierarchicalSelect
      apiEndpoint="/api/locations-by-parent"
      dataKey="locations"
      fieldName={fieldName}
      entityLabel="location"
      entityLabelPlural="locations"
      defaultValue={defaultValue}
      defaultValueName={defaultValueName}
      disabled={disabled}
      onChange={onChange}
      extraContent={extraContent}
    />
  );
}
