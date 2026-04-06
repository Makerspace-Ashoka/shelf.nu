import { data, type LoaderFunctionArgs } from "react-router";
import { generateUnclaimedCodesForPrint } from "~/modules/qr/service.server";
import type { QrStyle } from "~/modules/qr/types";
import { mmToPx } from "~/modules/qr/types";
import { makeShelfError } from "~/utils/error";
import { error } from "~/utils/http.server";
import { requireAdmin } from "~/utils/roles.server";
import { createQrCodesZip } from "~/utils/zip-qr-codes";

export async function loader({ context, request }: LoaderFunctionArgs) {
  const authSession = context.getSession();
  const { userId } = authSession;

  try {
    await requireAdmin(userId);
    const url = new URL(request.url);
    const amount = Number(url.searchParams.get("amount"));
    const batchName = url.searchParams.get("batchName") as string;
    const style = (url.searchParams.get("style") || "square") as QrStyle;
    const sizeMm = Number(url.searchParams.get("sizeMm")) || 50;
    const sizePx = mmToPx(sizeMm);

    const codes = await generateUnclaimedCodesForPrint({ amount, batchName });

    const zipBlob = await createQrCodesZip(codes, { style, sizePx });

    return new Response(zipBlob, {
      headers: {
        "content-type": "application/zip",
        "Content-Disposition": `attachment; filename="QR codes batch - ${batchName}.zip"`,
      },
    });
  } catch (cause) {
    const reason = makeShelfError(cause, { userId });
    return data(error(reason), { status: reason.status });
  }
}
