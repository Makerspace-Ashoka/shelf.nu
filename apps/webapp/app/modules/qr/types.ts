/**
 * QR Code Style and Size Types
 *
 * Shared types and constants for configurable QR code generation.
 * Used across QR generation, preview, download, and export features.
 * Also contains the Cricut mat dimensions and capacity calculation so
 * both the server-side SVG generator and client-side UI can share the
 * same pure-math logic without a `.server` import barrier.
 *
 * @see {@link file://./utils.server.ts} - QR generation
 * @see {@link file://./svg-generator.server.ts} - SVG generation
 */

/** Frame shape for the QR code sticker. */
export type QrStyle = "square" | "circular";

/** Predefined size options for QR code output. */
export type QrSizePreset = "mini" | "small" | "medium" | "large" | "custom";

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
  mini: { mm: 10, label: "Mini (10mm)", px: 118 },
  small: { mm: 25, label: "Small (25mm)", px: 295 },
  medium: { mm: 50, label: "Medium (50mm)", px: 591 },
  large: { mm: 75, label: "Large (75mm)", px: 886 },
} as const;

/** Cricut Print Then Cut mat dimensions in mm. */
export const CRICUT_MAT = {
  widthMm: 150,
  heightMm: 250,
} as const;

/**
 * Calculates how many stickers fit on a Cricut mat, accounting for
 * proportional scaling when Cricut imports the SVG at full mat width.
 *
 * The initial row/column counts are based on raw geometry. Then we apply
 * the same scale factor Cricut uses (content fills mat width) and reduce
 * rows if the scaled height would exceed the mat height.
 *
 * This matches the logic in `generateCricutSheet` so the client-side
 * capacity preview is always consistent with the generated SVG.
 *
 * @param stickerMm - Sticker size in mm
 * @param gapMm - Gap between stickers in mm (default 1)
 * @param matWidthMm - Mat width in mm (default CRICUT_MAT.widthMm)
 * @param matHeightMm - Mat height in mm (default CRICUT_MAT.heightMm)
 * @returns columns, rows (after scaling adjustment), and total capacity
 */
export function calculateMatCapacity(
  stickerMm: number,
  gapMm: number = 1,
  matWidthMm: number = CRICUT_MAT.widthMm,
  matHeightMm: number = CRICUT_MAT.heightMm
): { columns: number; rows: number; total: number } {
  // First sticker takes stickerMm, each additional takes stickerMm + gapMm
  const columns = Math.max(
    1,
    Math.floor((matWidthMm - stickerMm) / (stickerMm + gapMm)) + 1
  );
  let rows = Math.max(
    1,
    Math.floor((matHeightMm - stickerMm) / (stickerMm + gapMm)) + 1
  );

  // When Cricut scales width to fill the mat, height scales proportionally.
  // Reduce rows if the scaled height would exceed the mat.
  const contentW = columns * stickerMm + (columns - 1) * gapMm;
  const scale = matWidthMm / contentW;
  const contentH = rows * stickerMm + (rows - 1) * gapMm;
  if (contentH * scale > matHeightMm) {
    const maxContentH = matHeightMm / scale;
    rows = Math.max(
      1,
      Math.floor((maxContentH - stickerMm) / (stickerMm + gapMm)) + 1
    );
  }

  return { columns, rows, total: columns * rows };
}

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
