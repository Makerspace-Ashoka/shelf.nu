import { describe, it, expect } from "vitest";
import { mmToPx, resolveQrSizePx, QR_SIZE_PRESETS } from "./types";

describe("mmToPx", () => {
  it("converts 25.4mm to 300px (1 inch at 300 DPI)", () => {
    expect(mmToPx(25.4)).toBe(300);
  });

  it("converts 50mm to approximately 591px", () => {
    expect(mmToPx(50)).toBe(591);
  });

  it("converts 0mm to 0px", () => {
    expect(mmToPx(0)).toBe(0);
  });

  it("rounds to nearest integer", () => {
    // 10mm = 10/25.4 * 300 = 118.11... → 118
    expect(mmToPx(10)).toBe(118);
  });
});

describe("resolveQrSizePx", () => {
  it("returns preset size for 'small'", () => {
    expect(resolveQrSizePx("small")).toBe(QR_SIZE_PRESETS.small.px);
  });

  it("returns preset size for 'medium'", () => {
    expect(resolveQrSizePx("medium")).toBe(QR_SIZE_PRESETS.medium.px);
  });

  it("returns preset size for 'large'", () => {
    expect(resolveQrSizePx("large")).toBe(QR_SIZE_PRESETS.large.px);
  });

  it("returns custom size converted from mm when preset is 'custom'", () => {
    expect(resolveQrSizePx("custom", 50)).toBe(mmToPx(50));
  });

  it("clamps custom size to minimum 10mm", () => {
    expect(resolveQrSizePx("custom", 5)).toBe(mmToPx(10));
  });

  it("clamps custom size to maximum 200mm", () => {
    expect(resolveQrSizePx("custom", 500)).toBe(mmToPx(200));
  });

  it("falls back to medium when preset is 'custom' but no customMm given", () => {
    expect(resolveQrSizePx("custom")).toBe(QR_SIZE_PRESETS.medium.px);
  });

  it("falls back to medium when preset is 'custom' and customMm is 0", () => {
    expect(resolveQrSizePx("custom", 0)).toBe(QR_SIZE_PRESETS.medium.px);
  });
});
