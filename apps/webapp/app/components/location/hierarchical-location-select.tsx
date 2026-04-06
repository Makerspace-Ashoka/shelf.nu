/**
 * HierarchicalLocationSelect
 *
 * A Popover-based drill-down location picker that lets users navigate a
 * parent/child location hierarchy before making a selection.
 *
 * - Root level shows all top-level locations.
 * - Clicking a location that has children drills into it (updates breadcrumbs).
 * - Clicking a location with no children selects it and closes the popover.
 * - For locations WITH children, a small "select" button on the far right
 *   lets the user select that parent location without drilling in.
 * - A "Back" button appears whenever the user has drilled in.
 * - The selected location is emitted via `onChange` and stored in a hidden
 *   `<input name="newLocationId">` for standard Remix form submission.
 * - `extraContent` can be a ReactNode or a render-prop that receives
 *   `{ currentParentId, closePopover }` — useful for an inline creation dialog.
 *
 * Data is fetched from `/api/locations-by-parent?parentId=<id>` via
 * `useApiQuery`.  The query re-runs whenever `currentParentId` changes.
 *
 * @see {@link file://../../routes/api+/locations-by-parent.ts}
 * @see {@link file://../../hooks/use-api-query.ts}
 * @see {@link file://../category/hierarchical-category-select.tsx} for the original pattern
 */

import type { ReactNode } from "react";
import { useMemo, useRef, useState } from "react";
import {
  Popover,
  PopoverContent,
  PopoverPortal,
  PopoverTrigger,
} from "@radix-ui/react-popover";
import { ChevronLeft, ChevronRight, Check } from "lucide-react";
import useApiQuery from "~/hooks/use-api-query";
import type { LocationsByParentPayload } from "~/routes/api+/locations-by-parent";
import { tw } from "~/utils/tw";
import { Button } from "../shared/button";
import { Spinner } from "../shared/spinner";

// ---------------------------------------------------------------------------
// Types
// ---------------------------------------------------------------------------

/** A single breadcrumb entry used for back-navigation. */
type Breadcrumb = {
  id: string;
  name: string;
};

/**
 * Helpers passed to the `extraContent` render-prop so callers can react to
 * the current drill-down state and close the popover programmatically.
 */
type ExtraContentHelpers = {
  currentParentId: string | null;
  closePopover: () => void;
};

/** Public props for {@link HierarchicalLocationSelect}. */
type HierarchicalLocationSelectProps = {
  /** Pre-selected location ID. */
  defaultValue?: string;
  /** Pre-selected location name (used for the initial trigger label). */
  defaultValueName?: string;
  /**
   * The name of the hidden input submitted with the form.
   * @default "newLocationId"
   */
  fieldName?: string;
  /** Whether the trigger button is disabled. */
  disabled?: boolean;
  /**
   * Called whenever the selection changes.
   * `undefined` means the selection was cleared.
   */
  onChange?: (locationId: string | undefined) => void;
  /**
   * Extra content rendered at the bottom of the popover.
   * Can be a static ReactNode or a render-prop that receives drill-down
   * helpers so it can, e.g., pre-fill a creation form with the current parent.
   */
  extraContent?: ReactNode | ((helpers: ExtraContentHelpers) => ReactNode);
};

// ---------------------------------------------------------------------------
// Component
// ---------------------------------------------------------------------------

/**
 * Drill-down location selector backed by the `/api/locations-by-parent`
 * endpoint.
 *
 * @param props.defaultValue     - Pre-selected location ID
 * @param props.defaultValueName - Pre-selected location display name
 * @param props.fieldName        - Hidden input name (defaults to "newLocationId")
 * @param props.disabled         - Disables the trigger button
 * @param props.onChange         - Selection-change callback
 * @param props.extraContent     - Additional content rendered at popover bottom
 */
export function HierarchicalLocationSelect({
  defaultValue,
  defaultValueName,
  fieldName = "newLocationId",
  disabled = false,
  onChange,
  extraContent,
}: HierarchicalLocationSelectProps) {
  // ── Popover open/close ────────────────────────────────────────────────────
  const [open, setOpen] = useState(false);

  // Ref used to match popover width to trigger width (same as DynamicSelect)
  const triggerRef = useRef<HTMLDivElement>(null);

  // ── Drill-down state ──────────────────────────────────────────────────────

  /** null = root level; string = currently-viewed parent's ID */
  const [currentParentId, setCurrentParentId] = useState<string | null>(null);

  /**
   * Breadcrumb stack.  Each entry represents a level the user has drilled
   * into.  The last entry is the currently-viewed parent.
   */
  const [breadcrumbs, setBreadcrumbs] = useState<Breadcrumb[]>([]);

  // ── Selection state ───────────────────────────────────────────────────────
  const [selectedId, setSelectedId] = useState<string | undefined>(
    defaultValue
  );
  const [selectedName, setSelectedName] = useState<string | undefined>(
    defaultValueName
  );

  // ── Data fetching ─────────────────────────────────────────────────────────

  /**
   * Build the API URL dynamically so that `useApiQuery` refetches whenever
   * `currentParentId` changes.
   */
  const apiUrl = useMemo(() => {
    if (currentParentId) {
      return `/api/locations-by-parent?parentId=${encodeURIComponent(
        currentParentId
      )}`;
    }
    return "/api/locations-by-parent";
  }, [currentParentId]);

  const { data, isLoading } = useApiQuery<LocationsByParentPayload>({
    api: apiUrl,
    enabled: open, // only fetch while the popover is open
  });

  const locations = data?.locations ?? [];

  // ── Helpers ───────────────────────────────────────────────────────────────

  /** Select a location and close the popover. */
  function selectLocation(id: string, name: string) {
    setSelectedId(id);
    setSelectedName(name);
    onChange?.(id);
    setOpen(false);
  }

  /** Drill into a location with children. */
  function drillInto(id: string, name: string) {
    setBreadcrumbs((prev) => [...prev, { id, name }]);
    setCurrentParentId(id);
  }

  /** Navigate back one level. */
  function goBack() {
    setBreadcrumbs((prev) => {
      const next = prev.slice(0, -1);
      // The new current parent is the second-to-last breadcrumb, or null (root)
      setCurrentParentId(next.length > 0 ? next[next.length - 1].id : null);
      return next;
    });
  }

  /** Reset drill-down state when the popover closes. */
  function handleOpenChange(nextOpen: boolean) {
    setOpen(nextOpen);
    if (!nextOpen) {
      // Reset navigation so re-opening always starts at root
      setCurrentParentId(null);
      setBreadcrumbs([]);
    }
  }

  // ── Derived values ────────────────────────────────────────────────────────

  /** Name of the level the user is currently viewing (for back-button label). */
  const currentLevelName =
    breadcrumbs.length > 0
      ? breadcrumbs[breadcrumbs.length - 1].name
      : "All locations";

  /** Extra content node — resolved from render-prop if needed. */
  const extraContentNode =
    typeof extraContent === "function"
      ? extraContent({ currentParentId, closePopover: () => setOpen(false) })
      : extraContent;

  // ── Render ────────────────────────────────────────────────────────────────

  return (
    <div className="relative w-full">
      {/* Hidden form field carries the selected location ID on submit */}
      <input type="hidden" name={fieldName} value={selectedId ?? ""} />

      <Popover open={open} onOpenChange={handleOpenChange}>
        {/* ── Trigger ── */}
        <PopoverTrigger
          disabled={disabled}
          asChild
          className="inline-flex w-full items-center gap-2"
        >
          <button
            type="button"
            className={tw(
              "w-full",
              disabled && "cursor-not-allowed opacity-60"
            )}
          >
            <div
              ref={triggerRef}
              className="flex w-full items-center justify-between whitespace-nowrap rounded border border-gray-300 px-[14px] py-2 text-sm hover:cursor-pointer"
            >
              {selectedId && selectedName ? (
                /* Selected state: show name */
                <span className="truncate pr-2">{selectedName}</span>
              ) : (
                <span className="truncate pr-2 text-gray-500">
                  Select location...
                </span>
              )}
              {/* Chevron down indicator */}
              <svg
                className="size-4 shrink-0 text-gray-500"
                viewBox="0 0 20 20"
                fill="currentColor"
                aria-hidden="true"
              >
                <path
                  fillRule="evenodd"
                  d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z"
                  clipRule="evenodd"
                />
              </svg>
            </div>
          </button>
        </PopoverTrigger>

        {/* ── Popover content ── */}
        <PopoverPortal>
          <PopoverContent
            className="z-[100] overflow-y-auto rounded-md border border-gray-300 bg-white shadow-md"
            style={{ width: triggerRef.current?.clientWidth ?? 280 }}
            align="center"
            sideOffset={5}
          >
            {/* Back button — only shown when drilled in */}
            {breadcrumbs.length > 0 && (
              <div className="border-b border-gray-200">
                <button
                  type="button"
                  onClick={goBack}
                  className="flex w-full items-center gap-2 px-4 py-3 text-sm text-gray-600 hover:bg-gray-50"
                  aria-label={`Back to ${
                    breadcrumbs.length > 1
                      ? breadcrumbs[breadcrumbs.length - 2].name
                      : "all locations"
                  }`}
                >
                  <ChevronLeft className="size-4 shrink-0" aria-hidden="true" />
                  <span className="truncate">
                    Back to{" "}
                    <span className="font-medium">
                      {breadcrumbs.length > 1
                        ? `"${breadcrumbs[breadcrumbs.length - 2].name}"`
                        : "All locations"}
                    </span>
                  </span>
                </button>
              </div>
            )}

            {/* Current level label */}
            <div className="px-4 py-2 text-xs font-semibold uppercase tracking-wide text-gray-500">
              {breadcrumbs.length === 0 ? "All locations" : currentLevelName}
            </div>

            {/* Location list */}
            <div className="max-h-[320px] divide-y divide-gray-100 overflow-y-auto">
              {isLoading ? (
                <div className="flex items-center justify-center p-6">
                  <Spinner className="size-5" />
                </div>
              ) : locations.length === 0 ? (
                <div className="px-4 py-6 text-center text-sm text-gray-400">
                  No locations found
                </div>
              ) : (
                locations.map((loc) => {
                  const isSelected = loc.id === selectedId;

                  return (
                    <div
                      key={loc.id}
                      className={tw(
                        "flex items-center gap-3 px-4 py-3 text-sm",
                        isSelected && "bg-gray-50"
                      )}
                      role="option"
                      aria-selected={isSelected}
                    >
                      {loc.hasChildren ? (
                        /*
                         * Location WITH children — two interaction zones:
                         *   1. Name area → drills down
                         *   2. Select button → selects without drilling
                         */
                        <>
                          <button
                            type="button"
                            className="flex flex-1 cursor-pointer items-center gap-2 truncate text-left hover:text-gray-900"
                            onClick={() => drillInto(loc.id, loc.name)}
                            aria-label={`Browse children of ${loc.name}`}
                          >
                            <span className="truncate font-medium text-gray-700">
                              {loc.name}
                            </span>
                            {isSelected && (
                              <Check
                                className="size-4 shrink-0 text-primary"
                                aria-hidden="true"
                              />
                            )}
                          </button>

                          {/* Controls on the right: select + drill chevron */}
                          <div className="ml-auto flex shrink-0 items-center gap-1">
                            <Button
                              type="button"
                              variant="secondary"
                              className="h-6 px-2 py-0 text-xs"
                              onClick={() => selectLocation(loc.id, loc.name)}
                              aria-label={`Select ${loc.name}`}
                            >
                              Select
                            </Button>
                            <button
                              type="button"
                              className="rounded p-1 text-gray-400 hover:bg-gray-100 hover:text-gray-700"
                              onClick={() => drillInto(loc.id, loc.name)}
                              aria-label={`Open children of ${loc.name}`}
                            >
                              <ChevronRight
                                className="size-4"
                                aria-hidden="true"
                              />
                            </button>
                          </div>
                        </>
                      ) : (
                        /*
                         * Location WITHOUT children — clicking anywhere selects.
                         */
                        <button
                          type="button"
                          className="flex flex-1 cursor-pointer items-center justify-between truncate text-left hover:text-gray-900"
                          onClick={() => selectLocation(loc.id, loc.name)}
                          aria-label={`Select ${loc.name}`}
                        >
                          <span className="truncate font-medium text-gray-700">
                            {loc.name}
                          </span>
                          {isSelected && (
                            <Check
                              className="ml-2 size-4 shrink-0 text-primary"
                              aria-hidden="true"
                            />
                          )}
                        </button>
                      )}
                    </div>
                  );
                })
              )}
            </div>

            {/* Extra content slot (e.g. inline location creation) */}
            {extraContentNode !== undefined && (
              <div className="border-t border-gray-200 px-3 pb-3">
                {extraContentNode}
              </div>
            )}
          </PopoverContent>
        </PopoverPortal>
      </Popover>
    </div>
  );
}
