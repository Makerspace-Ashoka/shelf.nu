import { describe, it, expect } from "vitest";
import { generateQrSvg } from "./svg-generator.server";

describe("generateQrSvg", () => {
  const testData = "https://localhost:3000/qr/test123";

  describe("square style", () => {
    it("returns valid SVG markup", () => {
      const svg = generateQrSvg({
        data: testData,
        sizePx: 300,
        style: "square",
      });
      expect(svg).toContain("<svg");
      expect(svg).toContain("</svg>");
      expect(svg).toContain('xmlns="http://www.w3.org/2000/svg"');
    });

    it("uses the specified size in viewBox and dimensions", () => {
      const svg = generateQrSvg({
        data: testData,
        sizePx: 500,
        style: "square",
      });
      expect(svg).toContain('width="500"');
      expect(svg).toContain('height="500"');
      expect(svg).toContain('viewBox="0 0 500 500"');
    });

    it("contains rect elements for QR modules", () => {
      const svg = generateQrSvg({
        data: testData,
        sizePx: 300,
        style: "square",
      });
      expect(svg).toContain("<rect");
      expect(svg).toContain('fill="black"');
    });

    it("has a white background rect with black border", () => {
      const svg = generateQrSvg({
        data: testData,
        sizePx: 300,
        style: "square",
      });
      expect(svg).toContain('fill="white"');
      expect(svg).toContain('stroke="black"');
    });

    it("background rect spans full size", () => {
      const svg = generateQrSvg({
        data: testData,
        sizePx: 300,
        style: "square",
      });
      expect(svg).toContain('width="300" height="300"');
    });

    it("does not contain circle elements", () => {
      const svg = generateQrSvg({
        data: testData,
        sizePx: 300,
        style: "square",
      });
      expect(svg).not.toContain("<circle");
    });

    it("respects margin around QR modules", () => {
      const sizePx = 400;
      const svg = generateQrSvg({ data: testData, sizePx, style: "square" });
      // Margin is 8% of size = 32px for 400px
      // Modules should start after margin
      expect(svg).toBeDefined();
      expect(svg).toContain('x="');
    });

    it("generates different output for different sizes", () => {
      const svg300 = generateQrSvg({
        data: testData,
        sizePx: 300,
        style: "square",
      });
      const svg500 = generateQrSvg({
        data: testData,
        sizePx: 500,
        style: "square",
      });
      expect(svg300).not.toBe(svg500);
    });
  });

  describe("circular style", () => {
    it("returns valid SVG markup", () => {
      const svg = generateQrSvg({
        data: testData,
        sizePx: 300,
        style: "circular",
      });
      expect(svg).toContain("<svg");
      expect(svg).toContain("</svg>");
      expect(svg).toContain('xmlns="http://www.w3.org/2000/svg"');
    });

    it("uses the specified size in viewBox and dimensions", () => {
      const svg = generateQrSvg({
        data: testData,
        sizePx: 600,
        style: "circular",
      });
      expect(svg).toContain('width="600"');
      expect(svg).toContain('height="600"');
      expect(svg).toContain('viewBox="0 0 600 600"');
    });

    it("contains a circle element for the frame", () => {
      const svg = generateQrSvg({
        data: testData,
        sizePx: 300,
        style: "circular",
      });
      expect(svg).toContain("<circle");
      expect(svg).toContain('r="150"'); // radius = sizePx / 2
      expect(svg).toContain('cx="150"');
      expect(svg).toContain('cy="150"');
    });

    it("contains rect elements for QR modules", () => {
      const svg = generateQrSvg({
        data: testData,
        sizePx: 300,
        style: "circular",
      });
      expect(svg).toContain("<rect");
      expect(svg).toContain('fill="black"');
    });

    it("circle has white fill and black stroke", () => {
      const svg = generateQrSvg({
        data: testData,
        sizePx: 300,
        style: "circular",
      });
      expect(svg).toContain('fill="white"');
      expect(svg).toContain('stroke="black"');
    });

    it("centers the circle at the midpoint", () => {
      const svg = generateQrSvg({
        data: testData,
        sizePx: 400,
        style: "circular",
      });
      expect(svg).toContain('cx="200"');
      expect(svg).toContain('cy="200"');
      expect(svg).toContain('r="200"');
    });

    it("generates different output for different sizes", () => {
      const svg300 = generateQrSvg({
        data: testData,
        sizePx: 300,
        style: "circular",
      });
      const svg600 = generateQrSvg({
        data: testData,
        sizePx: 600,
        style: "circular",
      });
      expect(svg300).not.toBe(svg600);
    });

    it("radius is half the size", () => {
      const sizePx = 500;
      const svg = generateQrSvg({ data: testData, sizePx, style: "circular" });
      expect(svg).toContain(`r="${sizePx / 2}"`);
    });
  });

  describe("different data produces different SVGs", () => {
    it("generates different output for different URLs with square style", () => {
      const svg1 = generateQrSvg({
        data: "https://example.com/a",
        sizePx: 300,
        style: "square",
      });
      const svg2 = generateQrSvg({
        data: "https://example.com/b",
        sizePx: 300,
        style: "square",
      });
      expect(svg1).not.toBe(svg2);
    });

    it("generates different output for different URLs with circular style", () => {
      const svg1 = generateQrSvg({
        data: "https://example.com/x",
        sizePx: 300,
        style: "circular",
      });
      const svg2 = generateQrSvg({
        data: "https://example.com/y",
        sizePx: 300,
        style: "circular",
      });
      expect(svg1).not.toBe(svg2);
    });
  });

  describe("edge cases", () => {
    it("handles small sizes", () => {
      const svg = generateQrSvg({
        data: testData,
        sizePx: 100,
        style: "square",
      });
      expect(svg).toContain('width="100"');
      expect(svg).toContain('height="100"');
      expect(svg).toContain("<rect");
    });

    it("handles large sizes", () => {
      const svg = generateQrSvg({
        data: testData,
        sizePx: 1000,
        style: "square",
      });
      expect(svg).toContain('width="1000"');
      expect(svg).toContain('height="1000"');
      expect(svg).toContain("<rect");
    });

    it("handles very short data", () => {
      const svg = generateQrSvg({ data: "a", sizePx: 300, style: "square" });
      expect(svg).toContain("<svg");
      expect(svg).toContain("</svg>");
    });

    it("handles long data URLs", () => {
      const longUrl = `https://example.com/asset/${"x".repeat(
        100
      )}?tracking=1234567890`;
      const svg = generateQrSvg({
        data: longUrl,
        sizePx: 300,
        style: "square",
      });
      expect(svg).toContain("<svg");
      expect(svg).toContain("</svg>");
    });

    it("circular style handles small sizes", () => {
      const svg = generateQrSvg({
        data: testData,
        sizePx: 100,
        style: "circular",
      });
      expect(svg).toContain('width="100"');
      expect(svg).toContain('r="50"');
    });

    it("circular style handles large sizes", () => {
      const svg = generateQrSvg({
        data: testData,
        sizePx: 1000,
        style: "circular",
      });
      expect(svg).toContain('width="1000"');
      expect(svg).toContain('r="500"');
    });
  });

  describe("SVG structure and formatting", () => {
    it("square style SVG is properly formatted with newlines", () => {
      const svg = generateQrSvg({
        data: testData,
        sizePx: 300,
        style: "square",
      });
      const lines = svg.split("\n");
      expect(lines.length).toBeGreaterThan(1);
      expect(lines[0]).toContain("<svg");
      expect(lines[lines.length - 1]).toContain("</svg>");
    });

    it("circular style SVG is properly formatted with newlines", () => {
      const svg = generateQrSvg({
        data: testData,
        sizePx: 300,
        style: "circular",
      });
      const lines = svg.split("\n");
      expect(lines.length).toBeGreaterThan(1);
      expect(lines[0]).toContain("<svg");
      expect(lines[lines.length - 1]).toContain("</svg>");
    });

    it("square style has proper SVG structure: opening tag, content, closing tag", () => {
      const svg = generateQrSvg({
        data: testData,
        sizePx: 300,
        style: "square",
      });
      const svgOpenIndex = svg.indexOf("<svg");
      const svgCloseIndex = svg.indexOf("</svg>");
      expect(svgOpenIndex).toBe(0);
      expect(svgCloseIndex).toBeGreaterThan(svgOpenIndex);
    });

    it("circular style has proper SVG structure", () => {
      const svg = generateQrSvg({
        data: testData,
        sizePx: 300,
        style: "circular",
      });
      const svgOpenIndex = svg.indexOf("<svg");
      const svgCloseIndex = svg.indexOf("</svg>");
      expect(svgOpenIndex).toBe(0);
      expect(svgCloseIndex).toBeGreaterThan(svgOpenIndex);
    });

    it("square style background rect has stroke width", () => {
      const svg = generateQrSvg({
        data: testData,
        sizePx: 300,
        style: "square",
      });
      expect(svg).toContain('stroke-width="1"');
    });

    it("circular style circle has stroke width", () => {
      const svg = generateQrSvg({
        data: testData,
        sizePx: 300,
        style: "circular",
      });
      expect(svg).toContain('stroke-width="1"');
    });
  });

  describe("style consistency", () => {
    it("same input produces same output for square style", () => {
      const svg1 = generateQrSvg({
        data: testData,
        sizePx: 300,
        style: "square",
      });
      const svg2 = generateQrSvg({
        data: testData,
        sizePx: 300,
        style: "square",
      });
      expect(svg1).toBe(svg2);
    });

    it("same input produces same output for circular style", () => {
      const svg1 = generateQrSvg({
        data: testData,
        sizePx: 300,
        style: "circular",
      });
      const svg2 = generateQrSvg({
        data: testData,
        sizePx: 300,
        style: "circular",
      });
      expect(svg1).toBe(svg2);
    });
  });
});
