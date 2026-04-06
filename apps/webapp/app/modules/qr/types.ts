/**
 * QR Code Style and Size Types
 *
 * Shared types and constants for configurable QR code generation.
 * Used across QR generation, preview, download, and export features.
 *
 * @see {@link file://./utils.server.ts} - QR generation
 * @see {@link file://./svg-generator.server.ts} - SVG generation
 */

/** Frame shape for the QR code sticker. */
export type QrStyle = "square" | "circular";

/** Predefined size options for QR code output. */
export type QrSizePreset = "small" | "medium" | "large" | "custom";

/** Configuration for QR code download/export. */
export interface QrDownloadOptions {
  /** Frame shape. */
  style: QrStyle;
  /** Size preset or "custom" for manual entry. */
  sizePreset: QrSizePreset;
  /** Custom size in mm. Only used when sizePreset === "custom". */
  customSizeMm?: number;
}

/** Size definitions mapping preset names to mm and px values. */
export const QR_SIZE_PRESETS = {
  small: { mm: 25, label: "Small (25mm)", px: 295 },
  medium: { mm: 50, label: "Medium (50mm)", px: 591 },
  large: { mm: 75, label: "Large (75mm)", px: 886 },
} as const;

/** Minimum allowed custom size in mm. */
export const QR_SIZE_MIN_MM = 10;

/** Maximum allowed custom size in mm. */
export const QR_SIZE_MAX_MM = 200;

/**
 * Converts millimeters to pixels at 300 DPI (print resolution).
 *
 * @param mm - Size in millimeters
 * @returns Size in pixels
 */
export function mmToPx(mm: number): number {
  return Math.round((mm / 25.4) * 300);
}

/**
 * Resolves a size preset and optional custom value to pixel dimensions.
 *
 * @param preset - The selected size preset
 * @param customMm - Custom size in mm (used when preset is "custom")
 * @returns Size in pixels
 */
export function resolveQrSizePx(
  preset: QrSizePreset,
  customMm?: number
): number {
  if (preset === "custom" && customMm) {
    const clamped = Math.max(
      QR_SIZE_MIN_MM,
      Math.min(QR_SIZE_MAX_MM, customMm)
    );
    return mmToPx(clamped);
  }
  return QR_SIZE_PRESETS[preset === "custom" ? "medium" : preset].px;
}
