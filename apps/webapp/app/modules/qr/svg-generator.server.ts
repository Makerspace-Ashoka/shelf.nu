/**
 * QR Code SVG Generator
 *
 * Generates clean SVG strings for QR codes with configurable frame styles.
 * Supports square and circular frames with standard block-style modules.
 * Optimized for Cricut Design Space compatibility (minimal SVG nodes).
 *
 * @see {@link file://./types.ts} - QR style types
 * @see {@link file://./utils.server.ts} - Existing QR generation
 */

import QRCode from "qrcode-generator";

/** Options for generating a QR code SVG. */
interface GenerateQrSvgOptions {
  /** The data to encode (typically a URL). */
  data: string;
  /** Output size in pixels. */
  sizePx: number;
  /** Frame style: "square" or "circular". */
  style: "square" | "circular";
}

/**
 * Generates a self-contained SVG string for a QR code with the specified frame style.
 *
 * Square style: QR modules inside a square border with quiet zone margin.
 * Circular style: QR modules centered inside a circle. The circle circumscribes
 * the square QR area, so the full pattern is visible. Corner areas are white.
 *
 * Uses block-style modules (rect elements) for minimal SVG node count.
 *
 * @param options - Generation options
 * @returns Complete SVG markup as a string
 */
export function generateQrSvg({
  data,
  sizePx,
  style,
}: GenerateQrSvgOptions): string {
  const qr = QRCode(0, "M");
  qr.addData(data);
  qr.make();

  const moduleCount = qr.getModuleCount();

  if (style === "circular") {
    return generateCircularSvg(qr, moduleCount, sizePx);
  }
  return generateSquareSvg(qr, moduleCount, sizePx);
}

/**
 * Generates a square-framed QR code SVG.
 * The QR is centered with a quiet zone margin inside a square border.
 */
function generateSquareSvg(
  qr: ReturnType<typeof QRCode>,
  moduleCount: number,
  sizePx: number
): string {
  const margin = sizePx * 0.08;
  const qrArea = sizePx - margin * 2;
  const cellSize = qrArea / moduleCount;

  const rects: string[] = [];
  for (let row = 0; row < moduleCount; row++) {
    for (let col = 0; col < moduleCount; col++) {
      if (qr.isDark(row, col)) {
        const x = (margin + col * cellSize).toFixed(2);
        const y = (margin + row * cellSize).toFixed(2);
        const w = cellSize.toFixed(2);
        rects.push(
          `<rect x="${x}" y="${y}" width="${w}" height="${w}" fill="black"/>`
        );
      }
    }
  }

  return [
    `<svg xmlns="http://www.w3.org/2000/svg" width="${sizePx}" height="${sizePx}" viewBox="0 0 ${sizePx} ${sizePx}">`,
    `  <rect width="${sizePx}" height="${sizePx}" fill="white" stroke="black" stroke-width="1"/>`,
    `  ${rects.join("\n  ")}`,
    `</svg>`,
  ].join("\n");
}

/**
 * Generates a circular-framed QR code SVG.
 * The QR square is inscribed inside a circle: side = diameter / sqrt(2).
 * This guarantees the full QR pattern fits within the circle.
 */
function generateCircularSvg(
  qr: ReturnType<typeof QRCode>,
  moduleCount: number,
  sizePx: number
): string {
  const radius = sizePx / 2;
  const center = sizePx / 2;

  // QR square side inscribed in circle: side = diameter / sqrt(2)
  // Add padding for quiet zone
  const qrSide = (sizePx / Math.SQRT2) * 0.88;
  const cellSize = qrSide / moduleCount;
  const qrOffset = (sizePx - qrSide) / 2;

  const rects: string[] = [];
  for (let row = 0; row < moduleCount; row++) {
    for (let col = 0; col < moduleCount; col++) {
      if (qr.isDark(row, col)) {
        const x = (qrOffset + col * cellSize).toFixed(2);
        const y = (qrOffset + row * cellSize).toFixed(2);
        const w = cellSize.toFixed(2);
        rects.push(
          `<rect x="${x}" y="${y}" width="${w}" height="${w}" fill="black"/>`
        );
      }
    }
  }

  return [
    `<svg xmlns="http://www.w3.org/2000/svg" width="${sizePx}" height="${sizePx}" viewBox="0 0 ${sizePx} ${sizePx}">`,
    `  <circle cx="${center}" cy="${center}" r="${radius}" fill="white" stroke="black" stroke-width="1"/>`,
    `  ${rects.join("\n  ")}`,
    `</svg>`,
  ].join("\n");
}

/** Cricut Print Then Cut mat dimensions in mm. */
export const CRICUT_MAT = {
  widthMm: 150,
  heightMm: 250,
} as const;

/** Options for generating a Cricut-compatible merged SVG sheet. */
interface CricutSheetOptions {
  /** Array of QR data strings (URLs) to encode. */
  items: Array<{ id: string; data: string }>;
  /** Sticker size in pixels. */
  sizePx: number;
  /** Sticker size in mm (used for mat packing calculation). */
  sizeMm: number;
  /** Frame style for each sticker. */
  style: "square" | "circular";
  /** Gap between stickers in mm. 0 = edge-to-edge for clean cuts. */
  gapMm?: number;
  /** Mat width in mm. Defaults to Cricut Print Then Cut area. */
  matWidthMm?: number;
  /** Mat height in mm. Defaults to Cricut Print Then Cut area. */
  matHeightMm?: number;
}

/**
 * Calculates how many stickers fit on a Cricut mat.
 *
 * @param stickerMm - Sticker size in mm
 * @param gapMm - Gap between stickers in mm
 * @param matWidthMm - Mat width in mm
 * @param matHeightMm - Mat height in mm
 * @returns columns, rows, and total capacity
 */
export function calculateMatCapacity(
  stickerMm: number,
  gapMm: number = 1,
  matWidthMm: number = CRICUT_MAT.widthMm,
  matHeightMm: number = CRICUT_MAT.heightMm
): { columns: number; rows: number; total: number } {
  // First sticker takes stickerMm, each additional takes stickerMm + gapMm
  const columns =
    Math.floor((matWidthMm - stickerMm) / (stickerMm + gapMm)) + 1;
  const rows = Math.floor((matHeightMm - stickerMm) / (stickerMm + gapMm)) + 1;
  return {
    columns: Math.max(1, columns),
    rows: Math.max(1, rows),
    total: Math.max(1, columns) * Math.max(1, rows),
  };
}

/**
 * Generates a single merged SVG containing multiple QR code stickers
 * packed into a Cricut Print Then Cut mat area. Stickers are arranged
 * edge-to-edge (or with minimal gap) for clean cutting.
 *
 * Each sticker is a <g> group that can be ungrouped in Cricut Design
 * Space. Block-style modules, minimal SVG nodes, no CSS.
 *
 * @param options - Sheet configuration
 * @returns Complete SVG markup as a string
 */
export function generateCricutSheet({
  items,
  sizePx,
  sizeMm,
  style,
  gapMm = 1,
  matWidthMm = CRICUT_MAT.widthMm,
  matHeightMm = CRICUT_MAT.heightMm,
}: CricutSheetOptions): string {
  const { columns, rows } = calculateMatCapacity(
    sizeMm,
    gapMm,
    matWidthMm,
    matHeightMm
  );

  // Use exact mat dimensions so Cricut doesn't rescale.
  // Stickers are centered within the mat area.
  const contentWidthMm = columns * sizeMm + (columns - 1) * gapMm;
  const contentHeightMm = rows * sizeMm + (rows - 1) * gapMm;
  const padX = (matWidthMm - contentWidthMm) / 2;
  const padY = (matHeightMm - contentHeightMm) / 2;

  // Only render as many items as we have (or as many as fit)
  const maxItems = Math.min(items.length, columns * rows);

  const groups: string[] = [];

  for (let i = 0; i < maxItems; i++) {
    const item = items[i];
    const col = i % columns;
    const row = Math.floor(i / columns);
    const offsetX = padX + col * (sizeMm + gapMm);
    const offsetY = padY + row * (sizeMm + gapMm);

    // Generate using mm as the coordinate unit
    const innerSvg = generateQrSvgInner({
      data: item.data,
      sizePx: sizeMm, // use mm as the coordinate unit
      style,
      offsetX,
      offsetY,
    });

    groups.push(`  <g id="qr-${item.id}">\n${innerSvg}\n  </g>`);
  }

  return [
    `<svg xmlns="http://www.w3.org/2000/svg" width="${matWidthMm}mm" height="${matHeightMm}mm" viewBox="0 0 ${matWidthMm} ${matHeightMm}">`,
    `  <!-- Cricut QR Sheet: ${maxItems} stickers, ${columns}x${rows} grid, ${sizeMm}mm each, ${gapMm}mm gap, ${matWidthMm}x${matHeightMm}mm mat -->`,
    groups.join("\n"),
    `</svg>`,
  ].join("\n");
}

/**
 * Generates SVG content for a single QR code at a given offset,
 * WITHOUT the wrapping <svg> tag. Used internally by generateCricutSheet
 * to compose stickers into a single SVG.
 */
function generateQrSvgInner({
  data,
  sizePx,
  style,
  offsetX,
  offsetY,
}: {
  data: string;
  sizePx: number;
  style: "square" | "circular";
  offsetX: number;
  offsetY: number;
}): string {
  const qr = QRCode(0, "M");
  qr.addData(data);
  qr.make();
  const moduleCount = qr.getModuleCount();

  if (style === "circular") {
    return generateCircularSvgInner(qr, moduleCount, sizePx, offsetX, offsetY);
  }
  return generateSquareSvgInner(qr, moduleCount, sizePx, offsetX, offsetY);
}

/**
 * Builds a compound SVG path string from all dark QR modules.
 * Merges all modules into a single <path d="..."> element,
 * reducing hundreds of <rect> nodes to 1 path node.
 * Critical for Cricut Design Space which chokes on high node counts.
 */
function buildCompoundQrPath(
  qr: ReturnType<typeof QRCode>,
  moduleCount: number,
  cellSize: number,
  originX: number,
  originY: number
): string {
  const segments: string[] = [];
  for (let row = 0; row < moduleCount; row++) {
    for (let col = 0; col < moduleCount; col++) {
      if (qr.isDark(row, col)) {
        const x = (originX + col * cellSize).toFixed(2);
        const y = (originY + row * cellSize).toFixed(2);
        const w = cellSize.toFixed(2);
        // Each module as a closed rect subpath: M x,y h w v w h -w Z
        segments.push(`M${x},${y}h${w}v${w}h-${w}Z`);
      }
    }
  }
  return segments.join("");
}

/**
 * Square QR content at an offset position (no <svg> wrapper).
 * Uses compound path (2 nodes per sticker: background + QR path).
 */
function generateSquareSvgInner(
  qr: ReturnType<typeof QRCode>,
  moduleCount: number,
  sizePx: number,
  offsetX: number,
  offsetY: number
): string {
  const qrMargin = sizePx * 0.08;
  const qrArea = sizePx - qrMargin * 2;
  const cellSize = qrArea / moduleCount;

  const bg = `    <rect x="${offsetX}" y="${offsetY}" width="${sizePx}" height="${sizePx}" fill="white" stroke="black" stroke-width="0.5"/>`;
  const qrPath = buildCompoundQrPath(
    qr,
    moduleCount,
    cellSize,
    offsetX + qrMargin,
    offsetY + qrMargin
  );
  const path = `    <path d="${qrPath}" fill="black"/>`;

  return `${bg}\n${path}`;
}

/**
 * Circular QR content at an offset position (no <svg> wrapper).
 * Uses compound path (2 nodes per sticker: circle + QR path).
 */
function generateCircularSvgInner(
  qr: ReturnType<typeof QRCode>,
  moduleCount: number,
  sizePx: number,
  offsetX: number,
  offsetY: number
): string {
  const radius = sizePx / 2;
  const centerX = offsetX + sizePx / 2;
  const centerY = offsetY + sizePx / 2;
  const qrSide = (sizePx / Math.SQRT2) * 0.88;
  const cellSize = qrSide / moduleCount;
  const qrOriginX = offsetX + (sizePx - qrSide) / 2;
  const qrOriginY = offsetY + (sizePx - qrSide) / 2;

  const bg = `    <circle cx="${centerX}" cy="${centerY}" r="${radius}" fill="white" stroke="black" stroke-width="0.5"/>`;
  const qrPath = buildCompoundQrPath(
    qr,
    moduleCount,
    cellSize,
    qrOriginX,
    qrOriginY
  );
  const path = `    <path d="${qrPath}" fill="black"/>`;

  return `${bg}\n${path}`;
}
