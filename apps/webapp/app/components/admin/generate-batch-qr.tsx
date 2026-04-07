import type { ChangeEvent } from "react";
import { useState } from "react";
import { useDisabled } from "~/hooks/use-disabled";
import type { QrSizePreset, QrStyle } from "~/modules/qr/types";
import { QR_SIZE_PRESETS } from "~/modules/qr/types";
import Input from "../forms/input";
import { QrStyleToggle } from "../qr/qr-style-toggle";
import { Button } from "../shared/button";

export function GenerateBatchQr() {
  const [amount, setAmount] = useState<number>(1000);
  const [batchName, setBatchName] = useState<string>("");
  const [qrStyle, setQrStyle] = useState<QrStyle>("square");
  const [sizePreset, setSizePreset] = useState<QrSizePreset>("medium");
  const [customSizeMm, setCustomSizeMm] = useState<number>(50);
  const disabled = useDisabled();

  function handleChange(e: ChangeEvent<HTMLInputElement>) {
    const value = Number(e.target.value);
    if (value < 1) {
      setAmount(1);
    } else if (value > 1000) {
      setAmount(1000);
    } else {
      setAmount(value);
    }
  }

  const sizeMm =
    sizePreset === "custom" ? customSizeMm : QR_SIZE_PRESETS[sizePreset].mm;

  const downloadUrl = `/admin-dashboard/qrs/codes.zip?${new URLSearchParams({
    amount: String(amount),
    batchName,
    style: qrStyle,
    sizeMm: String(sizeMm),
  })}-${new Date().getTime()}`;

  return (
    <div className="flex w-[400px] flex-col gap-2 bg-gray-200 p-4">
      <h3>Generate Batch</h3>
      <Input
        type="name"
        value={batchName}
        onChange={(e) => setBatchName(e.target.value)}
        placeholder="Dank batch"
        disabled={disabled}
        label={"Batch name"}
      />
      <Input
        type="number"
        min={10}
        max={1000}
        value={amount}
        onChange={handleChange}
        placeholder="Amount"
        disabled={disabled}
        label="Amount"
      />

      {/* QR Style */}
      <div>
        <span className="mb-[6px] block text-text-sm font-medium text-gray-700">
          Style
        </span>
        <QrStyleToggle
          value={qrStyle}
          onChange={setQrStyle}
          disabled={disabled}
        />
      </div>

      {/* QR Size */}
      <div>
        <label
          htmlFor="qr-size-preset"
          className="mb-[6px] block text-text-sm font-medium text-gray-700"
        >
          Size
        </label>
        <select
          id="qr-size-preset"
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

      <div>
        <Button
          to={downloadUrl}
          reloadDocument
          download
          variant="secondary"
          name="intent"
          value="createOrphans"
          disabled={disabled}
        >
          Generate & Download batch
        </Button>
        <p className="mt-2 text-sm text-gray-500">
          Generates and downloads a batch of unclaimed QR codes. Min 1, Max 1000
        </p>
      </div>
    </div>
  );
}
