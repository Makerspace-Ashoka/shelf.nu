/**
 * Cricut Sheet Generator
 *
 * Admin UI for generating a single merged SVG containing multiple
 * QR code stickers packed into a Cricut Print Then Cut mat area.
 * Auto-calculates how many stickers fit based on size and gap settings.
 *
 * @see {@link file://../../routes/_layout+/admin-dashboard+/qrs.cricut[.svg].ts}
 * @see {@link file://../../modules/qr/svg-generator.server.ts}
 */

import type { ChangeEvent } from "react";
import { useMemo, useState } from "react";
import { useNavigation } from "react-router";
import type { QrSizePreset, QrStyle } from "~/modules/qr/types";
import { QR_SIZE_PRESETS } from "~/modules/qr/types";
import { isFormProcessing } from "~/utils/form";
import { tw } from "~/utils/tw";
import Input from "../forms/input";
import { Button } from "../shared/button";

/** Cricut Print Then Cut mat dimensions in mm. */
const MAT_WIDTH_MM = 150;
const MAT_HEIGHT_MM = 250;

/**
 * Client-side capacity calculation matching the server-side logic.
 * Determines how many stickers fit on the Cricut mat.
 */
function calculateCapacity(stickerMm: number, gapMm: number) {
  // First sticker takes stickerMm, each additional takes stickerMm + gapMm
  const cols = Math.max(
    1,
    Math.floor((MAT_WIDTH_MM - stickerMm) / (stickerMm + gapMm)) + 1
  );
  let rows = Math.max(
    1,
    Math.floor((MAT_HEIGHT_MM - stickerMm) / (stickerMm + gapMm)) + 1
  );

  // When Cricut scales width to fill the mat, height scales proportionally.
  // Reduce rows if the scaled height would exceed the mat.
  const contentW = cols * stickerMm + (cols - 1) * gapMm;
  const scale = MAT_WIDTH_MM / contentW;
  const contentH = rows * stickerMm + (rows - 1) * gapMm;
  if (contentH * scale > MAT_HEIGHT_MM) {
    const maxContentH = MAT_HEIGHT_MM / scale;
    rows = Math.max(
      1,
      Math.floor((maxContentH - stickerMm) / (stickerMm + gapMm)) + 1
    );
  }

  return { cols, rows, total: cols * rows };
}

/**
 * GenerateCricutSheet component
 *
 * Renders a form that lets admins configure and download a single merged SVG
 * file containing QR codes packed edge-to-edge for Cricut cutting.
 */
export const GenerateCricutSheet = () => {
  const [batchName, setBatchName] = useState<string>("");
  const [qrStyle, setQrStyle] = useState<QrStyle>("square");
  const [sizePreset, setSizePreset] = useState<QrSizePreset>("small");
  const [customSizeMm, setCustomSizeMm] = useState<number>(25);
  const [gapMm, setGapMm] = useState<number>(1);
  const navigation = useNavigation();
  const disabled = isFormProcessing(navigation.state);

  const sizeMm =
    sizePreset === "custom" ? customSizeMm : QR_SIZE_PRESETS[sizePreset].mm;

  const capacity = useMemo(
    () => calculateCapacity(sizeMm, gapMm),
    [sizeMm, gapMm]
  );

  const downloadUrl = `/admin-dashboard/qrs/cricut.svg?${new URLSearchParams({
    amount: String(capacity.total),
    batchName: batchName || "cricut",
    style: qrStyle,
    sizeMm: String(sizeMm),
    gapMm: String(gapMm),
  })}-${new Date().getTime()}`;

  return (
    <div className="flex w-[400px] flex-col gap-2 bg-blue-50 p-4">
      <h3>Cricut Sheet</h3>
      <p className="text-xs text-gray-500">
        Generates a single SVG packed for Cricut Print Then Cut ({MAT_WIDTH_MM}
        mm &times; {MAT_HEIGHT_MM}mm mat).
      </p>

      <Input
        type="name"
        value={batchName}
        onChange={(e: ChangeEvent<HTMLInputElement>) =>
          setBatchName(e.target.value)
        }
        placeholder="cricut-batch"
        disabled={disabled}
        label="Batch name"
      />

      {/* Style toggle */}
      <div>
        <span className="mb-[6px] block text-text-sm font-medium text-gray-700">
          Style
        </span>
        <div className="flex rounded-md border border-gray-300">
          <button
            type="button"
            onClick={() => setQrStyle("square")}
            className={tw(
              "flex-1 px-3 py-1.5 text-sm",
              qrStyle === "square"
                ? "bg-gray-100 font-medium text-gray-900"
                : "text-gray-500 hover:text-gray-700"
            )}
          >
            Square
          </button>
          <button
            type="button"
            onClick={() => setQrStyle("circular")}
            className={tw(
              "flex-1 px-3 py-1.5 text-sm",
              qrStyle === "circular"
                ? "bg-gray-100 font-medium text-gray-900"
                : "text-gray-500 hover:text-gray-700"
            )}
          >
            Circle
          </button>
        </div>
      </div>

      {/* Size */}
      <div>
        <label
          htmlFor="cricut-size-preset"
          className="mb-[6px] block text-text-sm font-medium text-gray-700"
        >
          Sticker size
        </label>
        <select
          id="cricut-size-preset"
          value={sizePreset}
          onChange={(e) => setSizePreset(e.target.value as QrSizePreset)}
          disabled={disabled}
          className="w-full rounded border border-gray-300 px-3 py-2 text-sm text-gray-700"
        >
          {Object.entries(QR_SIZE_PRESETS).map(([key, val]) => (
            <option key={key} value={key}>
              {val.label}
            </option>
          ))}
          <option value="custom">Custom</option>
        </select>
        {sizePreset === "custom" ? (
          <div className="mt-2 flex items-center gap-2">
            <input
              type="number"
              min={10}
              max={200}
              value={customSizeMm}
              onChange={(e) => setCustomSizeMm(Number(e.target.value))}
              disabled={disabled}
              className="w-20 rounded border border-gray-300 px-2 py-1.5 text-sm"
            />
            <span className="text-sm text-gray-500">mm</span>
          </div>
        ) : null}
      </div>

      {/* Gap */}
      <div>
        <label
          htmlFor="cricut-gap"
          className="mb-[6px] block text-text-sm font-medium text-gray-700"
        >
          Gap between stickers
        </label>
        <div className="flex items-center gap-2">
          <input
            id="cricut-gap"
            type="number"
            min={0}
            max={10}
            step={0.5}
            value={gapMm}
            onChange={(e) => setGapMm(Number(e.target.value))}
            disabled={disabled}
            className="w-20 rounded border border-gray-300 px-2 py-1.5 text-sm"
          />
          <span className="text-sm text-gray-500">mm (0 = edge-to-edge)</span>
        </div>
      </div>

      {/* Capacity info */}
      <div className="rounded border border-blue-200 bg-blue-100 px-3 py-2 text-sm">
        <span className="font-medium">{capacity.total} stickers</span>
        <span className="text-gray-600">
          {" "}
          ({capacity.cols} &times; {capacity.rows} grid, {sizeMm}mm each)
        </span>
      </div>

      <div>
        <Button
          to={downloadUrl}
          reloadDocument
          download
          variant="secondary"
          disabled={disabled}
        >
          Download Cricut SVG ({capacity.total} codes)
        </Button>
        <p className="mt-2 text-xs text-gray-500">
          Single SVG file. Import → Ungroup → Print Then Cut.
        </p>
      </div>
    </div>
  );
};
