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

/** Options for generating a Cricut-compatible merged SVG sheet. */
interface CricutSheetOptions {
  /** Array of QR data strings (URLs) to encode. */
  items: Array<{ id: string; data: string }>;
  /** Sticker size in pixels. */
  sizePx: number;
  /** Frame style for each sticker. */
  style: "square" | "circular";
  /** Number of columns in the grid layout. */
  columns: number;
  /** Spacing between stickers in pixels. */
  spacing?: number;
  /** Margin around the entire sheet in pixels. */
  margin?: number;
}

/**
 * Generates a single merged SVG containing multiple QR code stickers
 * arranged in a grid. Each sticker is a <g> group that can be
 * individually selected and arranged in Cricut Design Space after
 * ungrouping.
 *
 * Optimized for Cricut: block-style modules, minimal nodes,
 * native SVG elements (no CSS).
 *
 * @param options - Sheet configuration
 * @returns Complete SVG markup as a string
 */
export function generateCricutSheet({
  items,
  sizePx,
  style,
  columns,
  spacing = 20,
  margin = 20,
}: CricutSheetOptions): string {
  const rows = Math.ceil(items.length / columns);
  const totalWidth = margin * 2 + columns * sizePx + (columns - 1) * spacing;
  const totalHeight = margin * 2 + rows * sizePx + (rows - 1) * spacing;

  const groups: string[] = [];

  for (let i = 0; i < items.length; i++) {
    const item = items[i];
    const col = i % columns;
    const row = Math.floor(i / columns);
    const offsetX = margin + col * (sizePx + spacing);
    const offsetY = margin + row * (sizePx + spacing);

    // Generate individual QR SVG (without outer <svg> wrapper)
    const innerSvg = generateQrSvgInner({
      data: item.data,
      sizePx,
      style,
      offsetX,
      offsetY,
    });

    groups.push(`  <g id="qr-${item.id}">\n${innerSvg}\n  </g>`);
  }

  return [
    `<svg xmlns="http://www.w3.org/2000/svg" width="${totalWidth}" height="${totalHeight}" viewBox="0 0 ${totalWidth} ${totalHeight}">`,
    `  <!-- Cricut QR Sheet: ${items.length} stickers, ${columns}x${rows} grid -->`,
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

/** Square QR content at an offset position (no <svg> wrapper). */
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

  const parts: string[] = [];
  // Background
  parts.push(
    `    <rect x="${offsetX}" y="${offsetY}" width="${sizePx}" height="${sizePx}" fill="white" stroke="black" stroke-width="0.5"/>`
  );
  // QR modules
  for (let row = 0; row < moduleCount; row++) {
    for (let col = 0; col < moduleCount; col++) {
      if (qr.isDark(row, col)) {
        const x = (offsetX + qrMargin + col * cellSize).toFixed(2);
        const y = (offsetY + qrMargin + row * cellSize).toFixed(2);
        const w = cellSize.toFixed(2);
        parts.push(
          `    <rect x="${x}" y="${y}" width="${w}" height="${w}" fill="black"/>`
        );
      }
    }
  }
  return parts.join("\n");
}

/** Circular QR content at an offset position (no <svg> wrapper). */
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
  const qrOffsetX = offsetX + (sizePx - qrSide) / 2;
  const qrOffsetY = offsetY + (sizePx - qrSide) / 2;

  const parts: string[] = [];
  // Circle background
  parts.push(
    `    <circle cx="${centerX}" cy="${centerY}" r="${radius}" fill="white" stroke="black" stroke-width="0.5"/>`
  );
  // QR modules
  for (let row = 0; row < moduleCount; row++) {
    for (let col = 0; col < moduleCount; col++) {
      if (qr.isDark(row, col)) {
        const x = (qrOffsetX + col * cellSize).toFixed(2);
        const y = (qrOffsetY + row * cellSize).toFixed(2);
        const w = cellSize.toFixed(2);
        parts.push(
          `    <rect x="${x}" y="${y}" width="${w}" height="${w}" fill="black"/>`
        );
      }
    }
  }
  return parts.join("\n");
}
