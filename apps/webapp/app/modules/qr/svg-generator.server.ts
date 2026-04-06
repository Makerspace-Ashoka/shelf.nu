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
