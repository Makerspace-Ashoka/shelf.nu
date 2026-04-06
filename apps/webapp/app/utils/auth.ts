/**
 * Extracts FormData from SSO user session for cleaner code organization
 */
export function createSSOFormData(
  supabaseSession: any,
  refreshToken: string,
  redirectTo: string
): FormData {
  const user = supabaseSession?.user;
  const customClaims = user?.user_metadata?.custom_claims || {};
  const formData = new FormData();

  // Core fields
  formData.append("refreshToken", refreshToken);
  formData.append("redirectTo", redirectTo);
  formData.append(
    "firstName",
    customClaims.firstname || customClaims.firstName || ""
  );
  formData.append(
    "lastName",
    customClaims.lastname || customClaims.lastName || ""
  );

  // Groups — normalize Zitadel's object format ({"role": {"org_id": "..."}})
  // into the flat string array that getRoleFromGroupId() expects.
  const rawGroups = customClaims.groups;
  const groups = Array.isArray(rawGroups)
    ? rawGroups
    : rawGroups && typeof rawGroups === "object"
    ? Object.keys(rawGroups)
    : [];
  formData.append("groups", JSON.stringify(groups));

  // Contact information - map from SSO field names to our schema
  formData.append("phone", customClaims.mobilephone || "");
  formData.append("streetAddress", customClaims.streetAddress || "");
  formData.append("city", customClaims.city || "");
  formData.append("stateProvince", customClaims.stateProvince || "");
  formData.append("postalCode", customClaims.postalCode || "");
  formData.append("country", customClaims.country || "");

  return formData;
}
