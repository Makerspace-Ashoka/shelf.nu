/**
 * Tests for auth utility functions.
 *
 * Covers the `createSSOFormData` helper which extracts user metadata
 * from a Supabase SSO session and normalises it into a FormData object
 * consumed by the SSO callback route action.
 *
 * @see {@link file://./auth.ts}
 */
import { describe, it, expect } from "vitest";
import { createSSOFormData } from "./auth";

/**
 * Builds a minimal Supabase session object containing the given
 * `custom_claims` for use in unit tests.
 *
 * @param customClaims - Arbitrary claims to embed in `user.user_metadata.custom_claims`
 * @returns A partial session object that satisfies `createSSOFormData`'s expectations
 */
function makeSession(customClaims: Record<string, unknown>) {
  return {
    user: {
      user_metadata: {
        custom_claims: customClaims,
      },
    },
  };
}

describe("createSSOFormData", () => {
  describe("groups normalization", () => {
    it("passes through array-format groups unchanged", () => {
      const session = makeSession({
        firstname: "Alice",
        lastName: "Smith",
        groups: ["admin-staff", "acad-staff"],
      });

      const formData = createSSOFormData(session, "refresh-tok", "/assets");
      const groups = JSON.parse(formData.get("groups") as string);

      expect(groups).toEqual(["admin-staff", "acad-staff"]);
    });

    it("extracts keys from Zitadel object-format roles", () => {
      const session = makeSession({
        firstname: "Bob",
        lastName: "Jones",
        groups: {
          "admin-staff": { org_id: "123" },
          "acad-staff": { org_id: "123" },
        },
      });

      const formData = createSSOFormData(session, "refresh-tok", "/assets");
      const groups = JSON.parse(formData.get("groups") as string);

      expect(groups).toEqual(["admin-staff", "acad-staff"]);
    });

    it("defaults to empty array when groups is undefined", () => {
      const session = makeSession({
        firstname: "Carol",
        lastName: "Lee",
      });

      const formData = createSSOFormData(session, "refresh-tok", "/assets");
      const groups = JSON.parse(formData.get("groups") as string);

      expect(groups).toEqual([]);
    });

    it("defaults to empty array when groups is null", () => {
      const session = makeSession({
        firstname: "Dan",
        lastName: "Kim",
        groups: null,
      });

      const formData = createSSOFormData(session, "refresh-tok", "/assets");
      const groups = JSON.parse(formData.get("groups") as string);

      expect(groups).toEqual([]);
    });
  });
});
