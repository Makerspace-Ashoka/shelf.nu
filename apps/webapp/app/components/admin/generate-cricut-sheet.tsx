/**
 * Cricut Sheet Generator
 *
 * Admin UI for generating a single merged SVG containing multiple
 * QR code stickers in a grid layout. Designed for Cricut Design Space
 * Print Then Cut workflow.
 *
 * @see {@link file://../../routes/_layout+/admin-dashboard+/qrs.cricut[.svg].ts}
 */

import type { ChangeEvent } from "react";
import { useState } from "react";
import { useNavigation } from "react-router";
import type { QrSizePreset, QrStyle } from "~/modules/qr/types";
import { QR_SIZE_PRESETS } from "~/modules/qr/types";
import { isFormProcessing } from "~/utils/form";
import { tw } from "~/utils/tw";
import Input from "../forms/input";
import { Button } from "../shared/button";

/**
 * GenerateCricutSheet component
 *
 * Renders a form that lets admins configure and download a single merged SVG
 * file containing multiple QR code stickers arranged in a grid. The SVG is
 * optimised for Cricut Design Space's Print Then Cut workflow.
 *
 * @returns The Cricut sheet generator panel
 */
export const GenerateCricutSheet = () => {
  const [amount, setAmount] = useState<number>(20);
  const [batchName, setBatchName] = useState<string>("");
  const [qrStyle, setQrStyle] = useState<QrStyle>("square");
  const [sizePreset, setSizePreset] = useState<QrSizePreset>("medium");
  const [customSizeMm, setCustomSizeMm] = useState<number>(50);
  const [columns, setColumns] = useState<number>(5);
  const navigation = useNavigation();
  const disabled = isFormProcessing(navigation.state);

  /** Clamp the QR code count to the allowed range [1, 100]. */
  function handleAmountChange(e: ChangeEvent<HTMLInputElement>) {
    const value = Number(e.target.value);
    setAmount(Math.max(1, Math.min(100, value)));
  }

  /** Clamp the column count to the allowed range [1, 10]. */
  function handleColumnsChange(e: ChangeEvent<HTMLInputElement>) {
    const value = Number(e.target.value);
    setColumns(Math.max(1, Math.min(10, value)));
  }

  /** Resolve the effective sticker size in millimetres. */
  const sizeMm =
    sizePreset === "custom" ? customSizeMm : QR_SIZE_PRESETS[sizePreset].mm;

  /**
   * Build the download URL with all current form values as query params.
   * A timestamp suffix is appended so that repeat downloads bypass the
   * browser cache even when the params are identical.
   */
  const downloadUrl = `/admin-dashboard/qrs/cricut.svg?${new URLSearchParams({
    amount: String(amount),
    batchName: batchName || "cricut",
    style: qrStyle,
    sizeMm: String(sizeMm),
    columns: String(columns),
  })}-${new Date().getTime()}`;

  return (
    <div className="flex w-[400px] flex-col gap-2 bg-blue-50 p-4">
      <h3>Cricut Sheet</h3>
      <p className="text-xs text-gray-500">
        Generates a single SVG with all QR codes as grouped stickers. Import
        into Cricut Design Space, ungroup, and use Print Then Cut.
      </p>

      <Input
        type="name"
        value={batchName}
        onChange={(e) => setBatchName(e.target.value)}
        placeholder="cricut-batch"
        disabled={disabled}
        label="Batch name"
      />

      <div className="flex gap-2">
        <div className="flex-1">
          <Input
            type="number"
            min={1}
            max={100}
            value={amount}
            onChange={handleAmountChange}
            placeholder="20"
            disabled={disabled}
            label="QR codes"
          />
        </div>
        <div className="flex-1">
          <Input
            type="number"
            min={1}
            max={10}
            value={columns}
            onChange={handleColumnsChange}
            placeholder="5"
            disabled={disabled}
            label="Columns"
          />
        </div>
      </div>

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

      {/* Size preset selector */}
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
        {/* Show a mm input only when the user has chosen the custom preset. */}
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

      <div>
        <Button
          to={downloadUrl}
          reloadDocument
          download
          variant="secondary"
          disabled={disabled}
        >
          Download Cricut SVG
        </Button>
        <p className="mt-2 text-xs text-gray-500">
          Single SVG file. Import → Ungroup → Print Then Cut. Max 100 per sheet.
        </p>
      </div>
    </div>
  );
};
