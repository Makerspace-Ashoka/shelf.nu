import type { Qr } from "@prisma/client";
import JSZip from "jszip";
import { generateQrSvg } from "~/modules/qr/svg-generator.server";
import type { QrStyle } from "~/modules/qr/types";
import { getQrBaseUrl } from "~/modules/qr/utils.server";

export async function createQrCodesZip(
  codes: Qr[],
  options?: { style?: QrStyle; sizePx?: number }
) {
  const zip = new JSZip();
  const baseUrl = getQrBaseUrl();

  const style = options?.style ?? "square";
  const sizePx = options?.sizePx ?? 300;

  codes.forEach((c) => {
    const svg = generateQrSvg({
      data: `${baseUrl}/${c.id}`,
      sizePx,
      style,
    });

    const dateString = `${c.createdAt.getFullYear().toString()}${(
      c.createdAt.getMonth() + 1
    )
      .toString()
      .padStart(2, "0")}${c.createdAt.getDate().toString().padStart(2, "0")}`;

    zip.file(`${dateString} - ${c.id}.svg`, svg);
  });

  const zipBlob = await zip.generateAsync({ type: "blob" });
  return zipBlob;
}
