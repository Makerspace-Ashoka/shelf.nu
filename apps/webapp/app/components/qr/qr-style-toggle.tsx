/**
 * QR Style Toggle
 *
 * Shared Square/Circle toggle button pair for QR code style selection.
 * Used across code preview, bulk download, batch generation, and Cricut sheet.
 *
 * @see {@link file://../code-preview/code-preview.tsx}
 * @see {@link file://../assets/bulk-download-qr-dialog.tsx}
 * @see {@link file://../admin/generate-batch-qr.tsx}
 * @see {@link file://../admin/generate-cricut-sheet.tsx}
 */

import type { QrStyle } from "~/modules/qr/types";
import { tw } from "~/utils/tw";

/** Props for the QrStyleToggle component. */
type QrStyleToggleProps = {
  /** Current selected style. */
  value: QrStyle;
  /** Callback when user selects a different style. */
  onChange: (style: QrStyle) => void;
  /** Whether the toggle is disabled. */
  disabled?: boolean;
  /** Size variant for different contexts. */
  size?: "sm" | "md";
};

/**
 * Toggle button pair for selecting QR code frame style (Square or Circle).
 *
 * @param props - Component props
 * @returns A pair of toggle buttons for style selection
 */
export function QrStyleToggle({
  value,
  onChange,
  disabled = false,
  size = "md",
}: QrStyleToggleProps) {
  const px = size === "sm" ? "px-2 py-1 text-xs" : "px-3 py-1.5 text-sm";

  return (
    <div className="flex rounded-md border border-gray-300">
      <button
        type="button"
        disabled={disabled}
        onClick={() => onChange("square")}
        className={tw(
          "flex-1",
          px,
          value === "square"
            ? "bg-gray-100 font-medium text-gray-900"
            : "text-gray-500 hover:text-gray-700"
        )}
      >
        Square
      </button>
      <button
        type="button"
        disabled={disabled}
        onClick={() => onChange("circular")}
        className={tw(
          "flex-1",
          px,
          value === "circular"
            ? "bg-gray-100 font-medium text-gray-900"
            : "text-gray-500 hover:text-gray-700"
        )}
      >
        Circle
      </button>
    </div>
  );
}
