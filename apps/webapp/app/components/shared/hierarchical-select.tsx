/**
 * HierarchicalSelect
 *
 * A generic Popover-based drill-down picker for any entity with parent/child
 * hierarchy. Renders one level at a time with breadcrumb navigation.
 *
 * Used as the base for HierarchicalCategorySelect and
 * HierarchicalLocationSelect. Entity-specific behavior (colors, labels,
 * API endpoint) is injected via props.
 *
 * @see {@link file://../../components/category/hierarchical-category-select.tsx}
 * @see {@link file://../../components/location/hierarchical-location-select.tsx}
 */

import type { ReactNode } from "react";
import { useMemo, useRef, useState } from "react";
import {
  Popover,
  PopoverContent,
  PopoverPortal,
  PopoverTrigger,
} from "@radix-ui/react-popover";
import { Check, ChevronLeft, ChevronRight } from "lucide-react";
import useApiQuery from "~/hooks/use-api-query";
import { tw } from "~/utils/tw";
import { Button } from "./button";
import { Spinner } from "./spinner";

// ---------------------------------------------------------------------------
// Types
// ---------------------------------------------------------------------------

/** Shape of each item returned by the drill-down API endpoint. */
export type HierarchicalSelectItem = {
  id: string;
  name: string;
  color?: string;
  hasChildren: boolean;
};

/** Breadcrumb entry for back-navigation. */
type Breadcrumb = { id: string; name: string };

/** Helpers passed to the `extraContent` render-prop. */
export type HierarchicalSelectHelpers = {
  currentParentId: string | null;
  closePopover: () => void;
};

/** Props for {@link HierarchicalSelect}. */
export type HierarchicalSelectProps = {
  /** API base path (e.g. "/api/categories-by-parent"). parentId is appended. */
  apiEndpoint: string;
  /** Key in the API response that contains the items array. */
  dataKey: string;
  /** Name for the hidden form input. */
  fieldName: string;
  /** Label used in placeholders and back-button text (e.g. "category"). */
  entityLabel: string;
  /** Plural form for level headers (e.g. "categories"). */
  entityLabelPlural: string;
  /** Whether items have a color dot. */
  showColorDot?: boolean;

  /** Pre-selected item ID. */
  defaultValue?: string;
  /** Pre-selected item display name. */
  defaultValueName?: string;
  /** Pre-selected item color (only used when showColorDot is true). */
  defaultValueColor?: string;
  /** Whether the trigger is disabled. */
  disabled?: boolean;
  /** Called when selection changes. */
  onChange?: (id: string | undefined) => void;
  /** Extra content at the bottom of the popover. */
  extraContent?:
    | ReactNode
    | ((helpers: HierarchicalSelectHelpers) => ReactNode);
};

// ---------------------------------------------------------------------------
// Component
// ---------------------------------------------------------------------------

/**
 * Generic drill-down selector for hierarchical entities.
 *
 * @param props - See {@link HierarchicalSelectProps}
 */
export function HierarchicalSelect({
  apiEndpoint,
  dataKey,
  fieldName,
  entityLabel,
  entityLabelPlural,
  showColorDot = false,
  defaultValue,
  defaultValueName,
  defaultValueColor,
  disabled = false,
  onChange,
  extraContent,
}: HierarchicalSelectProps) {
  // ── Popover state ────────────────────────────────────────────────────────
  const [open, setOpen] = useState(false);
  const triggerRef = useRef<HTMLDivElement>(null);

  // ── Drill-down state ────────────────────────────────────────────────────
  const [currentParentId, setCurrentParentId] = useState<string | null>(null);
  const [breadcrumbs, setBreadcrumbs] = useState<Breadcrumb[]>([]);

  // ── Selection state ─────────────────────────────────────────────────────
  const [selectedId, setSelectedId] = useState<string | undefined>(
    defaultValue
  );
  const [selectedName, setSelectedName] = useState<string | undefined>(
    defaultValueName
  );
  const [selectedColor, setSelectedColor] = useState<string | undefined>(
    defaultValueColor
  );

  // ── Data fetching ───────────────────────────────────────────────────────
  const apiUrl = useMemo(() => {
    if (currentParentId) {
      return `${apiEndpoint}?parentId=${encodeURIComponent(currentParentId)}`;
    }
    return apiEndpoint;
  }, [apiEndpoint, currentParentId]);

  const { data, isLoading } = useApiQuery<Record<string, unknown>>({
    api: apiUrl,
    enabled: open,
  });

  const items: HierarchicalSelectItem[] =
    (data?.[dataKey] as HierarchicalSelectItem[] | undefined) ?? [];

  // ── Helpers ─────────────────────────────────────────────────────────────

  /** Select an item and close the popover. */
  function selectItem(id: string, name: string, color?: string) {
    setSelectedId(id);
    setSelectedName(name);
    if (showColorDot) setSelectedColor(color);
    onChange?.(id);
    setOpen(false);
  }

  /** Drill into a parent item. */
  function drillInto(id: string, name: string) {
    setBreadcrumbs((prev) => [...prev, { id, name }]);
    setCurrentParentId(id);
  }

  /** Navigate back one level. */
  function goBack() {
    setBreadcrumbs((prev) => {
      const next = prev.slice(0, -1);
      setCurrentParentId(next.length > 0 ? next[next.length - 1].id : null);
      return next;
    });
  }

  /** Reset drill-down on close. */
  function handleOpenChange(nextOpen: boolean) {
    setOpen(nextOpen);
    if (!nextOpen) {
      setCurrentParentId(null);
      setBreadcrumbs([]);
    }
  }

  // ── Derived ─────────────────────────────────────────────────────────────
  const allLabel = `All ${entityLabelPlural}`;
  const currentLevelName =
    breadcrumbs.length > 0
      ? breadcrumbs[breadcrumbs.length - 1].name
      : allLabel;

  const extraContentNode =
    typeof extraContent === "function"
      ? extraContent({ currentParentId, closePopover: () => setOpen(false) })
      : extraContent;

  // ── Render ──────────────────────────────────────────────────────────────
  return (
    <div className="relative w-full">
      <input type="hidden" name={fieldName} value={selectedId ?? ""} />

      <Popover open={open} onOpenChange={handleOpenChange}>
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
                <span className="flex items-center gap-2 truncate pr-2">
                  {showColorDot && selectedColor ? (
                    <span
                      style={{ backgroundColor: selectedColor }}
                      className="inline-block size-2 shrink-0 rounded-full"
                      aria-hidden="true"
                    />
                  ) : null}
                  <span className="truncate">{selectedName}</span>
                </span>
              ) : (
                <span className="truncate pr-2 text-gray-500">
                  Select {entityLabel}...
                </span>
              )}
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

        <PopoverPortal>
          <PopoverContent
            className="z-[100] overflow-y-auto rounded-md border border-gray-300 bg-white shadow-md"
            style={{ width: triggerRef.current?.clientWidth ?? 280 }}
            align="center"
            sideOffset={5}
          >
            {/* Back button */}
            {breadcrumbs.length > 0 && (
              <div className="border-b border-gray-200">
                <button
                  type="button"
                  onClick={goBack}
                  className="flex w-full items-center gap-2 px-4 py-3 text-sm text-gray-600 hover:bg-gray-50"
                  aria-label={`Back to ${
                    breadcrumbs.length > 1
                      ? breadcrumbs[breadcrumbs.length - 2].name
                      : allLabel
                  }`}
                >
                  <ChevronLeft className="size-4 shrink-0" aria-hidden="true" />
                  <span className="truncate">
                    Back to{" "}
                    <span className="font-medium">
                      {breadcrumbs.length > 1
                        ? `"${breadcrumbs[breadcrumbs.length - 2].name}"`
                        : allLabel}
                    </span>
                  </span>
                </button>
              </div>
            )}

            {/* Current level label */}
            <div className="px-4 py-2 text-xs font-semibold uppercase tracking-wide text-gray-500">
              {breadcrumbs.length === 0 ? allLabel : currentLevelName}
            </div>

            {/* Item list */}
            <div
              className="max-h-[320px] divide-y divide-gray-100 overflow-y-auto"
              role="listbox"
              aria-label={currentLevelName}
            >
              {isLoading ? (
                <div className="flex items-center justify-center p-6">
                  <Spinner className="size-5" />
                </div>
              ) : items.length === 0 ? (
                <div className="px-4 py-6 text-center text-sm text-gray-400">
                  No {entityLabelPlural} found
                </div>
              ) : (
                items.map((item) => {
                  const isSelected = item.id === selectedId;

                  return (
                    <div
                      key={item.id}
                      className={tw(
                        "flex items-center gap-3 px-4 py-3 text-sm",
                        isSelected && "bg-gray-50"
                      )}
                      role="option"
                      aria-selected={isSelected}
                    >
                      {/* Color dot (categories only) */}
                      {showColorDot && item.color ? (
                        <span
                          style={{ backgroundColor: item.color }}
                          className="inline-block size-2 shrink-0 rounded-full"
                          aria-hidden="true"
                        />
                      ) : null}

                      {item.hasChildren ? (
                        <>
                          <button
                            type="button"
                            className="flex flex-1 cursor-pointer items-center gap-2 truncate text-left hover:text-gray-900"
                            onClick={() => drillInto(item.id, item.name)}
                            aria-label={`Browse children of ${item.name}`}
                          >
                            <span className="truncate font-medium text-gray-700">
                              {item.name}
                            </span>
                            {isSelected && (
                              <Check
                                className="size-4 shrink-0 text-primary"
                                aria-hidden="true"
                              />
                            )}
                          </button>
                          <div className="ml-auto flex shrink-0 items-center gap-1">
                            <Button
                              type="button"
                              variant="secondary"
                              className="h-6 px-2 py-0 text-xs"
                              onClick={() =>
                                selectItem(item.id, item.name, item.color)
                              }
                              aria-label={`Select ${item.name}`}
                            >
                              Select
                            </Button>
                            <button
                              type="button"
                              className="rounded p-1 text-gray-400 hover:bg-gray-100 hover:text-gray-700"
                              onClick={() => drillInto(item.id, item.name)}
                              aria-label={`Open children of ${item.name}`}
                            >
                              <ChevronRight
                                className="size-4"
                                aria-hidden="true"
                              />
                            </button>
                          </div>
                        </>
                      ) : (
                        <button
                          type="button"
                          className="flex flex-1 cursor-pointer items-center justify-between truncate text-left hover:text-gray-900"
                          onClick={() =>
                            selectItem(item.id, item.name, item.color)
                          }
                          aria-label={`Select ${item.name}`}
                        >
                          <span className="truncate font-medium text-gray-700">
                            {item.name}
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

            {/* Extra content slot */}
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
