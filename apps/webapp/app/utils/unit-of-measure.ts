/**
 * Unit of Measure Utilities
 *
 * Maps the UnitOfMeasure enum to human-readable short labels
 * used throughout the UI (asset list, overview card, CSV export).
 *
 * @see {@link file://./../components/assets/quantity-overview-card.tsx}
 * @see {@link file://./../components/assets/assets-index/advanced-asset-columns.tsx}
 */

import type { UnitOfMeasure } from "@prisma/client";

/** Short display labels for each unit (used in tables, badges, etc.) */
const UNIT_LABELS: Record<UnitOfMeasure, string> = {
  PCS: "pcs",
  MG: "mg",
  G: "g",
  KG: "kg",
  MM: "mm",
  M: "m",
  ML: "ml",
  L: "L",
};

/**
 * Returns the short display label for a UnitOfMeasure enum value.
 *
 * @param unit - The UnitOfMeasure enum value
 * @returns Short label string (e.g. "kg", "pcs", "ml")
 */
export function unitOfMeasureLabel(unit: UnitOfMeasure): string {
  return UNIT_LABELS[unit] ?? unit;
}
