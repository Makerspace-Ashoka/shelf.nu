/**
 * Cricut SVG Download Route
 *
 * Generates unclaimed QR codes and returns a single merged SVG file
 * with all codes arranged in a grid. Each QR is a <g> group that can
 * be individually ungrouped and arranged in Cricut Design Space.
 *
 * Query params: amount, batchName, style, sizeMm, columns
 *
 * @see {@link file://../../modules/qr/svg-generator.server.ts}
 */

import { data, type LoaderFunctionArgs } from "react-router";
import { generateUnclaimedCodesForPrint } from "~/modules/qr/service.server";
import { generateCricutSheet } from "~/modules/qr/svg-generator.server";
import type { QrStyle } from "~/modules/qr/types";
import { mmToPx } from "~/modules/qr/types";
import { getQrBaseUrl } from "~/modules/qr/utils.server";
import { makeShelfError } from "~/utils/error";
import { error } from "~/utils/http.server";
import { requireAdmin } from "~/utils/roles.server";

export async function loader({ context, request }: LoaderFunctionArgs) {
  const authSession = context.getSession();
  const { userId } = authSession;

  try {
    await requireAdmin(userId);
    const url = new URL(request.url);
    const amount = Number(url.searchParams.get("amount")) || 10;
    const batchName =
      (url.searchParams.get("batchName") as string) || "cricut-batch";
    const style = (url.searchParams.get("style") || "square") as QrStyle;
    const sizeMm = Number(url.searchParams.get("sizeMm")) || 25;
    const gapMm = Number(url.searchParams.get("gapMm")) || 1;
    const sizePx = mmToPx(sizeMm);

    const codes = await generateUnclaimedCodesForPrint({
      amount,
      batchName,
    });

    const baseUrl = getQrBaseUrl();
    const items = codes.map((c) => ({
      id: c.id,
      data: `${baseUrl}/${c.id}`,
    }));

    const svg = generateCricutSheet({
      items,
      sizePx,
      sizeMm,
      style,
      gapMm,
    });

    return new Response(svg, {
      headers: {
        "content-type": "image/svg+xml",
        "Content-Disposition": `attachment; filename="cricut-qr-${batchName}.svg"`,
      },
    });
  } catch (cause) {
    const reason = makeShelfError(cause, { userId });
    return data(error(reason), { status: reason.status });
  }
}
