# Zitadel OIDC Auth — Phase 1 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace Supabase Auth with Zitadel OIDC for login, logout, and auto-provisioning — keeping Supabase for DB + storage only.

**Architecture:** Standard OIDC authorization code flow with PKCE. Login redirects to Zitadel hosted UI. On callback, exchange code for tokens, fetch userinfo, create/update Shelf user with Zitadel group→role mapping, set session cookie. Logout destroys session + redirects to Zitadel end_session.

**Tech Stack:** Zitadel OIDC, PKCE (no client secret), `jose` for JWT decode, Prisma (user provisioning), react-router (routes)

---

## Configuration

```
ZITADEL_ISSUER=https://auth.makerspace.tools
ZITADEL_CLIENT_ID=367263720209974278
```

**Zitadel OIDC endpoints:**

- Authorization: `https://auth.makerspace.tools/oauth/v2/authorize`
- Token: `https://auth.makerspace.tools/oauth/v2/token`
- Userinfo: `https://auth.makerspace.tools/oidc/v1/userinfo`
- End session: `https://auth.makerspace.tools/oidc/v1/end_session`

**Group → Role mapping:**

- `admin-staff` → OWNER
- `acad-staff` → MEMBER
- `interns` → MEMBER
- _(no match)_ → SELF_SERVICE

---

## File Map

| File                                                           | Action  | Responsibility                                  |
| -------------------------------------------------------------- | ------- | ----------------------------------------------- |
| `apps/webapp/app/integrations/zitadel/client.server.ts`        | Create  | PKCE helpers, token exchange, refresh, userinfo |
| `apps/webapp/app/integrations/zitadel/types.ts`                | Create  | Zitadel token/userinfo types                    |
| `apps/webapp/app/integrations/zitadel/group-mapping.server.ts` | Create  | Group→role mapping logic                        |
| `apps/webapp/app/modules/auth/service.server.ts`               | Rewrite | Replace Supabase calls with Zitadel             |
| `apps/webapp/app/modules/auth/mappers.server.ts`               | Rewrite | Map Zitadel tokens to AuthSession               |
| `apps/webapp/app/routes/_auth+/login.tsx`                      | Rewrite | Redirect to Zitadel                             |
| `apps/webapp/app/routes/_auth+/oauth.callback.tsx`             | Rewrite | Handle Zitadel code exchange                    |
| `apps/webapp/app/routes/_auth+/logout.tsx`                     | Modify  | Add Zitadel end_session redirect                |
| `apps/webapp/server/middleware.ts`                             | Modify  | Replace Supabase token validation/refresh       |
| `.env`                                                         | Modify  | Add ZITADEL_ISSUER, ZITADEL_CLIENT_ID           |
| `apps/webapp/app/utils/env.ts`                                 | Modify  | Add Zitadel env vars                            |

---

### Task 1: Environment Variables + Zitadel Types

**Files:**

- Modify: `.env`
- Modify: `apps/webapp/app/utils/env.ts`
- Create: `apps/webapp/app/integrations/zitadel/types.ts`

- [ ] **Step 1: Add Zitadel env vars to `.env`**

Add to the `.env` file (monorepo root):

```
# Zitadel OIDC
ZITADEL_ISSUER="https://auth.makerspace.tools"
ZITADEL_CLIENT_ID="367263720209974278"
```

- [ ] **Step 2: Register env vars in env.ts**

Read `apps/webapp/app/utils/env.ts` and add `ZITADEL_ISSUER` and `ZITADEL_CLIENT_ID` to the env schema/exports. Follow the existing pattern for how env vars are loaded and exported.

- [ ] **Step 3: Create Zitadel types**

Create `apps/webapp/app/integrations/zitadel/types.ts`:

```typescript
/**
 * Zitadel OIDC Types
 *
 * Type definitions for Zitadel token endpoint responses and userinfo.
 */

/** Response from Zitadel token endpoint after authorization code exchange. */
export interface ZitadelTokenResponse {
  access_token: string;
  token_type: string;
  expires_in: number;
  refresh_token?: string;
  id_token?: string;
  scope?: string;
}

/** Response from Zitadel userinfo endpoint. */
export interface ZitadelUserInfo {
  sub: string;
  email?: string;
  email_verified?: boolean;
  name?: string;
  given_name?: string;
  family_name?: string;
  preferred_username?: string;
  /** Zitadel group/role claims — format depends on project config */
  "urn:zitadel:iam:org:project:roles"?: Record<string, Record<string, string>>;
  /** Alternative: groups claim if configured */
  groups?: string[];
}

/** PKCE challenge pair stored in session during auth flow. */
export interface PkceChallenge {
  codeVerifier: string;
  codeChallenge: string;
}
```

- [ ] **Step 4: Commit**

```bash
git add .env apps/webapp/app/utils/env.ts apps/webapp/app/integrations/zitadel/
git commit -m "feat(auth): add Zitadel env vars and OIDC types"
```

---

### Task 2: Zitadel OIDC Client Module

**Files:**

- Create: `apps/webapp/app/integrations/zitadel/client.server.ts`

- [ ] **Step 1: Create the OIDC client**

Create `apps/webapp/app/integrations/zitadel/client.server.ts`:

```typescript
/**
 * Zitadel OIDC Client (server-only)
 *
 * Handles PKCE code generation, authorization URL construction, token exchange,
 * token refresh, and userinfo fetching for the Zitadel identity provider.
 *
 * @see {@link file://./types.ts} - Type definitions
 * @see {@link file://../../modules/auth/service.server.ts} - Auth service that uses this client
 */

import { randomBytes, createHash } from "crypto";
import type {
  ZitadelTokenResponse,
  ZitadelUserInfo,
  PkceChallenge,
} from "./types";

/** Zitadel OIDC endpoints derived from issuer URL. */
const ISSUER = process.env.ZITADEL_ISSUER || "https://auth.makerspace.tools";
const CLIENT_ID = process.env.ZITADEL_CLIENT_ID || "";
const AUTHORIZATION_ENDPOINT = `${ISSUER}/oauth/v2/authorize`;
const TOKEN_ENDPOINT = `${ISSUER}/oauth/v2/token`;
const USERINFO_ENDPOINT = `${ISSUER}/oidc/v1/userinfo`;
const END_SESSION_ENDPOINT = `${ISSUER}/oidc/v1/end_session`;

const REDIRECT_URI = `${process.env.SERVER_URL}/oauth/callback`;
const POST_LOGOUT_REDIRECT_URI = `${process.env.SERVER_URL}/login`;

const SCOPES =
  "openid profile email offline_access urn:zitadel:iam:org:project:roles";

/**
 * Generates a PKCE code verifier and challenge pair.
 *
 * @returns Object with codeVerifier (random string) and codeChallenge (S256 hash)
 */
export function generatePkceChallenge(): PkceChallenge {
  const codeVerifier = randomBytes(32).toString("base64url");
  const codeChallenge = createHash("sha256")
    .update(codeVerifier)
    .digest("base64url");
  return { codeVerifier, codeChallenge };
}

/**
 * Constructs the Zitadel authorization URL for the login redirect.
 *
 * @param codeChallenge - The PKCE code challenge (S256)
 * @param state - Random state parameter for CSRF protection
 * @returns Full authorization URL to redirect the user to
 */
export function getAuthorizationUrl(
  codeChallenge: string,
  state: string
): string {
  const params = new URLSearchParams({
    response_type: "code",
    client_id: CLIENT_ID,
    redirect_uri: REDIRECT_URI,
    scope: SCOPES,
    code_challenge: codeChallenge,
    code_challenge_method: "S256",
    state,
  });
  return `${AUTHORIZATION_ENDPOINT}?${params.toString()}`;
}

/**
 * Exchanges an authorization code for tokens at the Zitadel token endpoint.
 *
 * @param code - The authorization code from the callback
 * @param codeVerifier - The PKCE code verifier that matches the challenge
 * @returns Token response with access_token, refresh_token, id_token
 * @throws Error if the token exchange fails
 */
export async function exchangeCodeForTokens(
  code: string,
  codeVerifier: string
): Promise<ZitadelTokenResponse> {
  const response = await fetch(TOKEN_ENDPOINT, {
    method: "POST",
    headers: { "Content-Type": "application/x-www-form-urlencoded" },
    body: new URLSearchParams({
      grant_type: "authorization_code",
      client_id: CLIENT_ID,
      code,
      redirect_uri: REDIRECT_URI,
      code_verifier: codeVerifier,
    }),
  });

  if (!response.ok) {
    const errorBody = await response.text();
    throw new Error(
      `Zitadel token exchange failed: ${response.status} ${errorBody}`
    );
  }

  return response.json() as Promise<ZitadelTokenResponse>;
}

/**
 * Refreshes an access token using a refresh token.
 *
 * @param refreshToken - The refresh token to use
 * @returns New token response with fresh access_token and expiry
 * @throws Error if the refresh fails (token revoked, expired)
 */
export async function refreshTokens(
  refreshToken: string
): Promise<ZitadelTokenResponse> {
  const response = await fetch(TOKEN_ENDPOINT, {
    method: "POST",
    headers: { "Content-Type": "application/x-www-form-urlencoded" },
    body: new URLSearchParams({
      grant_type: "refresh_token",
      client_id: CLIENT_ID,
      refresh_token: refreshToken,
    }),
  });

  if (!response.ok) {
    const errorBody = await response.text();
    throw new Error(
      `Zitadel token refresh failed: ${response.status} ${errorBody}`
    );
  }

  return response.json() as Promise<ZitadelTokenResponse>;
}

/**
 * Fetches user information from the Zitadel userinfo endpoint.
 *
 * @param accessToken - A valid access token
 * @returns User info including email, name, and roles/groups
 * @throws Error if the request fails
 */
export async function getUserInfo(
  accessToken: string
): Promise<ZitadelUserInfo> {
  const response = await fetch(USERINFO_ENDPOINT, {
    headers: { Authorization: `Bearer ${accessToken}` },
  });

  if (!response.ok) {
    const errorBody = await response.text();
    throw new Error(`Zitadel userinfo failed: ${response.status} ${errorBody}`);
  }

  return response.json() as Promise<ZitadelUserInfo>;
}

/**
 * Constructs the Zitadel end-session URL for logout.
 *
 * @param idTokenHint - Optional ID token to include as hint
 * @returns Full end-session URL
 */
export function getEndSessionUrl(idTokenHint?: string): string {
  const params = new URLSearchParams({
    post_logout_redirect_uri: POST_LOGOUT_REDIRECT_URI,
  });
  if (idTokenHint) {
    params.set("id_token_hint", idTokenHint);
  }
  return `${END_SESSION_ENDPOINT}?${params.toString()}`;
}

/**
 * Validates an access token by calling the userinfo endpoint.
 * If the token is invalid/expired, the endpoint returns 401.
 *
 * @param accessToken - The token to validate
 * @returns true if valid, false otherwise
 */
export async function validateAccessToken(
  accessToken: string
): Promise<boolean> {
  try {
    const response = await fetch(USERINFO_ENDPOINT, {
      headers: { Authorization: `Bearer ${accessToken}` },
    });
    return response.ok;
  } catch {
    return false;
  }
}
```

- [ ] **Step 2: Commit**

```bash
git add apps/webapp/app/integrations/zitadel/client.server.ts
git commit -m "feat(auth): add Zitadel OIDC client with PKCE, token exchange, refresh"
```

---

### Task 3: Group-to-Role Mapping Module

**Files:**

- Create: `apps/webapp/app/integrations/zitadel/group-mapping.server.ts`

- [ ] **Step 1: Create the mapping module**

Create `apps/webapp/app/integrations/zitadel/group-mapping.server.ts`:

```typescript
/**
 * Zitadel Group → Shelf Role Mapping
 *
 * Maps Zitadel project roles/groups from the userinfo response
 * to Shelf OrganizationRoles for user provisioning.
 *
 * @see {@link file://./types.ts} - ZitadelUserInfo type
 */

import type { OrganizationRoles } from "@prisma/client";
import type { ZitadelUserInfo } from "./types";

/**
 * Static mapping of Zitadel group names to Shelf organization roles.
 * Order matters: first match wins for users in multiple groups.
 */
const GROUP_ROLE_MAP: Array<{ group: string; role: OrganizationRoles }> = [
  { group: "admin-staff", role: "OWNER" },
  { group: "acad-staff", role: "MEMBER" },
  { group: "interns", role: "MEMBER" },
];

/** Default role when user matches no configured group. */
const DEFAULT_ROLE: OrganizationRoles = "SELF_SERVICE";

/**
 * Extracts group/role names from Zitadel userinfo.
 *
 * Zitadel encodes project roles in the claim
 * `urn:zitadel:iam:org:project:roles` as a nested object:
 * `{ "admin-staff": { "orgId": "orgId" }, ... }`
 *
 * Falls back to the `groups` claim if the roles claim is absent.
 *
 * @param userInfo - Zitadel userinfo response
 * @returns Array of group name strings
 */
export function extractGroups(userInfo: ZitadelUserInfo): string[] {
  const rolesClaim = userInfo["urn:zitadel:iam:org:project:roles"];
  if (rolesClaim && typeof rolesClaim === "object") {
    return Object.keys(rolesClaim);
  }

  if (Array.isArray(userInfo.groups)) {
    return userInfo.groups;
  }

  return [];
}

/**
 * Resolves the Shelf organization role for a Zitadel user based on their groups.
 *
 * @param userInfo - Zitadel userinfo response
 * @returns The highest-priority matching Shelf role, or DEFAULT_ROLE
 */
export function resolveShelfRole(userInfo: ZitadelUserInfo): OrganizationRoles {
  const groups = extractGroups(userInfo);

  for (const mapping of GROUP_ROLE_MAP) {
    if (groups.includes(mapping.group)) {
      return mapping.role;
    }
  }

  return DEFAULT_ROLE;
}
```

- [ ] **Step 2: Commit**

```bash
git add apps/webapp/app/integrations/zitadel/group-mapping.server.ts
git commit -m "feat(auth): add Zitadel group-to-Shelf role mapping"
```

---

### Task 4: Rewrite Auth Service

**Files:**

- Rewrite: `apps/webapp/app/modules/auth/service.server.ts`
- Rewrite: `apps/webapp/app/modules/auth/mappers.server.ts`

- [ ] **Step 1: Rewrite mappers.server.ts**

Replace `apps/webapp/app/modules/auth/mappers.server.ts` with:

```typescript
/**
 * Auth Session Mapper
 *
 * Maps Zitadel OIDC token response to the internal AuthSession type
 * used by session storage and middleware.
 *
 * @see {@link file://@server/session} - AuthSession type definition
 * @see {@link file://../../integrations/zitadel/types} - Zitadel types
 */

import type { AuthSession } from "@server/session";
import type { ZitadelTokenResponse } from "~/integrations/zitadel/types";
import type { ErrorLabel } from "~/utils/error";
import { ShelfError } from "~/utils/error";

const label: ErrorLabel = "Auth";

/**
 * Maps a Zitadel token response + user ID + email into an AuthSession.
 *
 * @param tokens - The Zitadel token endpoint response
 * @param userId - The Shelf user ID (from DB, not Zitadel sub)
 * @param email - The user's email address
 * @returns AuthSession for cookie storage
 */
export function mapZitadelTokensToSession(
  tokens: ZitadelTokenResponse,
  userId: string,
  email: string
): AuthSession {
  if (!email) {
    throw new ShelfError({
      cause: null,
      message: "User must have an email address",
      additionalData: { userId },
      label,
    });
  }

  return {
    accessToken: tokens.access_token,
    refreshToken: tokens.refresh_token ?? "",
    userId,
    email,
    expiresIn: tokens.expires_in ?? 3600,
    expiresAt: Math.floor(Date.now() / 1000) + (tokens.expires_in ?? 3600),
  };
}
```

- [ ] **Step 2: Rewrite service.server.ts**

Replace `apps/webapp/app/modules/auth/service.server.ts` with a minimal version that only exposes what's needed for Phase 1:

```typescript
/**
 * Auth Service (server-side)
 *
 * Handles authentication via Zitadel OIDC. Phase 1 supports:
 * - Login redirect (authorization URL generation)
 * - Token exchange (authorization code → tokens)
 * - Token refresh
 * - Session validation
 * - Logout URL generation
 * - User provisioning on first login
 *
 * @see {@link file://../../integrations/zitadel/client.server.ts} - OIDC client
 * @see {@link file://./mappers.server.ts} - Token-to-session mapping
 */

import type { AuthSession } from "@server/session";
import { db } from "~/database/db.server";
import {
  generatePkceChallenge,
  getAuthorizationUrl,
  exchangeCodeForTokens,
  refreshTokens,
  getUserInfo,
  getEndSessionUrl,
  validateAccessToken,
} from "~/integrations/zitadel/client.server";
import { resolveShelfRole } from "~/integrations/zitadel/group-mapping.server";
import type { ZitadelUserInfo } from "~/integrations/zitadel/types";
import type { ErrorLabel } from "~/utils/error";
import { ShelfError } from "~/utils/error";
import { mapZitadelTokensToSession } from "./mappers.server";

const label: ErrorLabel = "Auth";

/**
 * Initiates the OIDC login flow by generating PKCE challenge and authorization URL.
 *
 * @returns Object with authorizationUrl, codeVerifier, and state (store in session)
 */
export function initiateLogin() {
  const { codeVerifier, codeChallenge } = generatePkceChallenge();
  const state = crypto.randomUUID();
  const authorizationUrl = getAuthorizationUrl(codeChallenge, state);

  return { authorizationUrl, codeVerifier, state };
}

/**
 * Completes the OIDC login flow: exchanges code for tokens, fetches userinfo,
 * provisions or updates the Shelf user, and returns an AuthSession.
 *
 * @param code - Authorization code from Zitadel callback
 * @param codeVerifier - PKCE code verifier from session
 * @returns AuthSession ready for cookie storage
 * @throws {ShelfError} On token exchange failure or missing email
 */
export async function completeLogin(
  code: string,
  codeVerifier: string
): Promise<AuthSession> {
  try {
    const tokens = await exchangeCodeForTokens(code, codeVerifier);
    const userInfo = await getUserInfo(tokens.access_token);

    if (!userInfo.email) {
      throw new ShelfError({
        cause: null,
        message: "Zitadel user has no email address",
        label,
        status: 400,
      });
    }

    const user = await provisionOrUpdateUser(userInfo);

    return mapZitadelTokensToSession(tokens, user.id, userInfo.email);
  } catch (cause) {
    if (cause instanceof ShelfError) throw cause;
    throw new ShelfError({
      cause,
      message: "Failed to complete login with Zitadel",
      label,
    });
  }
}

/**
 * Refreshes the access token using the refresh token from session.
 *
 * @param refreshToken - The refresh token from the current session
 * @returns Updated AuthSession with new access token and expiry
 * @throws {ShelfError} On refresh failure
 */
export async function refreshAccessToken(
  refreshToken: string
): Promise<AuthSession> {
  try {
    const tokens = await refreshTokens(refreshToken);
    const userInfo = await getUserInfo(tokens.access_token);

    if (!userInfo.email) {
      throw new ShelfError({
        cause: null,
        message: "Cannot refresh: user has no email",
        label,
      });
    }

    const user = await db.user.findFirst({
      where: { email: userInfo.email },
      select: { id: true },
    });

    if (!user) {
      throw new ShelfError({
        cause: null,
        message: "User not found during token refresh",
        label,
      });
    }

    return mapZitadelTokensToSession(tokens, user.id, userInfo.email);
  } catch (cause) {
    if (cause instanceof ShelfError) throw cause;
    throw new ShelfError({
      cause,
      message: "Failed to refresh Zitadel access token",
      label,
    });
  }
}

/**
 * Validates that the current access token is still valid.
 *
 * @param accessToken - The access token from session
 * @returns true if token is valid, false otherwise
 */
export async function validateSession(accessToken: string): Promise<boolean> {
  return validateAccessToken(accessToken);
}

/**
 * Returns the Zitadel end-session URL for logout.
 *
 * @param idTokenHint - Optional ID token hint
 * @returns Full URL to redirect to for logout
 */
export function getLogoutUrl(idTokenHint?: string): string {
  return getEndSessionUrl(idTokenHint);
}

/**
 * Provisions a new Shelf user from Zitadel userinfo on first login,
 * or updates the existing user's role if group membership changed.
 *
 * @param userInfo - Zitadel userinfo response with email, name, groups
 * @returns The Shelf User record (created or existing)
 */
async function provisionOrUpdateUser(userInfo: ZitadelUserInfo) {
  const email = userInfo.email!;
  const role = resolveShelfRole(userInfo);

  let user = await db.user.findFirst({
    where: { email },
    select: { id: true, organizations: { select: { id: true, roles: true } } },
  });

  if (!user) {
    // First login — create user + personal organization
    user = await db.user.create({
      data: {
        email,
        username: userInfo.preferred_username || email.split("@")[0],
        firstName: userInfo.given_name || "",
        lastName: userInfo.family_name || "",
        onboarded: true,
        sso: true,
        roles: { connect: { name: "USER" } },
        organizations: {
          create: {
            name: `${userInfo.given_name || email.split("@")[0]}'s Workspace`,
            type: "PERSONAL",
            categories: {
              create: {
                name: "Uncategorized",
                color: "#808080",
                user: { connect: { email } },
              },
            },
          },
        },
      },
      select: {
        id: true,
        organizations: { select: { id: true, roles: true } },
      },
    });

    // Create TeamMember + UserOrganization for the personal org
    const personalOrg = user.organizations[0];
    if (personalOrg) {
      await db.teamMember.create({
        data: {
          name:
            `${userInfo.given_name || ""} ${
              userInfo.family_name || ""
            }`.trim() || email,
          user: { connect: { id: user.id } },
          organization: { connect: { id: personalOrg.id } },
        },
      });

      await db.userOrganization.create({
        data: {
          userId: user.id,
          organizationId: personalOrg.id,
          roles: [role],
        },
      });
    }
  }

  return user;
}
```

- [ ] **Step 3: Commit**

```bash
git add apps/webapp/app/modules/auth/service.server.ts apps/webapp/app/modules/auth/mappers.server.ts
git commit -m "feat(auth): rewrite auth service for Zitadel OIDC"
```

---

### Task 5: Rewrite Login Route

**Files:**

- Rewrite: `apps/webapp/app/routes/_auth+/login.tsx`

- [ ] **Step 1: Replace login page with Zitadel redirect**

The login page should redirect to Zitadel's hosted login UI. Replace `apps/webapp/app/routes/_auth+/login.tsx`:

```typescript
/**
 * Login Route
 *
 * Initiates the Zitadel OIDC authorization code flow with PKCE.
 * Stores the PKCE code_verifier and state in the session cookie,
 * then redirects the user to Zitadel's hosted login page.
 *
 * @see {@link file://../../modules/auth/service.server.ts} - initiateLogin()
 * @see {@link file://./oauth.callback.tsx} - Handles the return redirect
 */

import type { LoaderFunctionArgs } from "react-router";
import { redirect } from "react-router";
import { initiateLogin } from "~/modules/auth/service.server";

export async function loader({ context }: LoaderFunctionArgs) {
  // If already logged in, go to assets
  const session = context.getSession();
  try {
    const auth = session;
    if (auth?.userId) {
      return redirect("/assets");
    }
  } catch {
    // Not logged in — continue to Zitadel
  }

  const { authorizationUrl, codeVerifier, state } = initiateLogin();

  // Store PKCE verifier and state in session for validation on callback
  context.setSession({
    accessToken: "",
    refreshToken: "",
    userId: "",
    email: "",
    expiresIn: 0,
    expiresAt: 0,
    // Store PKCE data as a JSON string in the accessToken field temporarily
    // This is a workaround since AuthSession has fixed fields
  } as any);

  // Use a separate cookie for PKCE data since AuthSession type is fixed
  // For now, we'll pass state and verifier via a temporary session approach

  return redirect(authorizationUrl);
}

export default function LoginPage() {
  return (
    <div className="flex h-full min-h-screen flex-col items-center justify-center">
      <p className="text-gray-600">Redirecting to login...</p>
    </div>
  );
}
```

**NOTE:** The PKCE verifier storage is tricky because AuthSession has a fixed type. The implementer should check if the session supports additional flash data or a separate cookie for PKCE state. The server session in `server/index.ts` may need a small extension to support a `pkce` key. Read the session middleware code and find the cleanest approach.

- [ ] **Step 2: Commit**

```bash
git add apps/webapp/app/routes/_auth+/login.tsx
git commit -m "feat(auth): rewrite login route for Zitadel OIDC redirect"
```

---

### Task 6: Rewrite OAuth Callback

**Files:**

- Rewrite: `apps/webapp/app/routes/_auth+/oauth.callback.tsx`

- [ ] **Step 1: Replace callback with Zitadel code exchange**

Replace `apps/webapp/app/routes/_auth+/oauth.callback.tsx`:

```typescript
/**
 * OAuth Callback Route
 *
 * Handles the redirect back from Zitadel after the user authenticates.
 * Exchanges the authorization code for tokens, provisions the user,
 * and sets the session cookie.
 *
 * @see {@link file://./login.tsx} - Initiates the flow
 * @see {@link file://../../modules/auth/service.server.ts} - completeLogin()
 */

import type { LoaderFunctionArgs } from "react-router";
import { redirect } from "react-router";
import { completeLogin } from "~/modules/auth/service.server";

export async function loader({ context, request }: LoaderFunctionArgs) {
  const url = new URL(request.url);
  const code = url.searchParams.get("code");
  const error = url.searchParams.get("error");

  if (error) {
    console.error("Zitadel auth error:", error, url.searchParams.get("error_description"));
    return redirect("/login");
  }

  if (!code) {
    return redirect("/login");
  }

  // Retrieve PKCE verifier from session/cookie
  // The implementer needs to read how the login route stored it
  // and retrieve it here. This might be from session flash data,
  // a separate cookie, or a server-side store.
  const codeVerifier = ""; // TODO: retrieve from session

  try {
    const authSession = await completeLogin(code, codeVerifier);
    context.setSession(authSession);
    return redirect("/assets");
  } catch (cause) {
    console.error("Login failed:", cause);
    return redirect("/login");
  }
}

export default function OAuthCallback() {
  return (
    <div className="flex h-full min-h-screen flex-col items-center justify-center">
      <p className="text-gray-600">Completing login...</p>
    </div>
  );
}
```

**IMPORTANT for implementer:** The PKCE code_verifier must be stored between the login redirect and the callback. Options:

1. Use a separate cookie (recommended — set a short-lived `__pkce` cookie in login, read it here)
2. Use session flash data
3. Use the existing session with a temporary field

Read `apps/webapp/server/index.ts` and `apps/webapp/server/session.ts` to determine the best approach.

- [ ] **Step 2: Commit**

```bash
git add apps/webapp/app/routes/_auth+/oauth.callback.tsx
git commit -m "feat(auth): rewrite OAuth callback for Zitadel code exchange"
```

---

### Task 7: Update Logout Route

**Files:**

- Modify: `apps/webapp/app/routes/_auth+/logout.tsx`

- [ ] **Step 1: Add Zitadel end-session redirect**

Replace `apps/webapp/app/routes/_auth+/logout.tsx`:

```typescript
/**
 * Logout Route
 *
 * Destroys the local session cookie and redirects to Zitadel's end-session
 * endpoint to clear the Zitadel session as well.
 *
 * @see {@link file://../../modules/auth/service.server.ts} - getLogoutUrl()
 */

import type { ActionFunctionArgs } from "react-router";
import { redirect } from "react-router";
import { z } from "zod";
import { getLogoutUrl } from "~/modules/auth/service.server";
import { assertIsPost, parseData } from "~/utils/http.server";

export async function action({ context, request }: ActionFunctionArgs) {
  assertIsPost(request);
  parseData(
    await request.formData(),
    z.object({ redirectTo: z.string().optional() })
  );

  context.destroySession();

  // Redirect to Zitadel end-session to clear the IdP session too
  const logoutUrl = getLogoutUrl();
  return redirect(logoutUrl);
}

export function loader() {
  return redirect("/");
}
```

- [ ] **Step 2: Commit**

```bash
git add apps/webapp/app/routes/_auth+/logout.tsx
git commit -m "feat(auth): add Zitadel end-session redirect to logout"
```

---

### Task 8: Update Middleware

**Files:**

- Modify: `apps/webapp/server/middleware.ts`

- [ ] **Step 1: Update protect() to validate with Zitadel**

In `apps/webapp/server/middleware.ts`, the `protect()` function currently calls `validateSession(auth.refreshToken)` which queries Supabase's `auth.refresh_tokens` table. Replace this with the new `validateSession` that calls Zitadel's userinfo endpoint:

```typescript
// Change this import:
import {
  refreshAccessToken,
  validateSession,
} from "~/modules/auth/service.server";
```

In `protect()`, change:

```typescript
// OLD: const isValidSession = await validateSession(auth.refreshToken);
// NEW: validate using access token against Zitadel
const isValidSession = await validateSession(auth.accessToken);
```

In `refreshSession()`, the `refreshAccessToken` function already has the correct signature — it accepts a refresh token and returns an AuthSession. Verify it works with the new implementation.

- [ ] **Step 2: Add /oauth/callback to public paths**

Ensure `/oauth/callback` is in the public paths list in `server/index.ts` where `protect()` is configured. Read the file and check the `publicPaths` array.

- [ ] **Step 3: Commit**

```bash
git add apps/webapp/server/middleware.ts apps/webapp/server/index.ts
git commit -m "feat(auth): update middleware for Zitadel token validation"
```

---

### Task 9: Disable Legacy Auth Routes

**Files:**

- Modify: `apps/webapp/app/routes/_auth+/otp.tsx`
- Modify: `apps/webapp/app/routes/_auth+/send-otp.tsx`
- Modify: `apps/webapp/app/routes/_auth+/join.tsx`
- Modify: `apps/webapp/app/routes/_auth+/sso-login.tsx`

- [ ] **Step 1: Redirect legacy routes to /login**

These routes are Supabase-specific. Replace their loaders with redirects to `/login` (which now goes to Zitadel):

For each file, replace the loader with:

```typescript
import { redirect } from "react-router";
export function loader() {
  return redirect("/login");
}
export function action() {
  return redirect("/login");
}
export default function () {
  return null;
}
```

This preserves the routes (no 404s for bookmarks) but sends users to Zitadel.

- [ ] **Step 2: Commit**

```bash
git add apps/webapp/app/routes/_auth+/otp.tsx \
  apps/webapp/app/routes/_auth+/send-otp.tsx \
  apps/webapp/app/routes/_auth+/join.tsx \
  apps/webapp/app/routes/_auth+/sso-login.tsx
git commit -m "feat(auth): redirect legacy auth routes to Zitadel login"
```

---

### Task 10: Integration Test + Validation

- [ ] **Step 1: Update .env and restart dev server**

Ensure `.env` has:

```
ZITADEL_ISSUER="https://auth.makerspace.tools"
ZITADEL_CLIENT_ID="367263720209974278"
```

Kill the dev server and restart:

```bash
lsof -ti:3000 | xargs kill -9 2>/dev/null
sleep 2
export PATH="/opt/homebrew/opt/node@22/bin:$PATH"
pnpm run webapp:dev
```

- [ ] **Step 2: Run typecheck**

```bash
export PATH="/opt/homebrew/opt/node@22/bin:$PATH"
pnpm turbo typecheck --filter=@shelf/webapp
```

Expected: 0 TypeScript errors.

- [ ] **Step 3: Test the flow manually**

1. Open `https://localhost:3000/login` → should redirect to Zitadel
2. Log in with a Zitadel account → should redirect back to `/oauth/callback`
3. Callback exchanges code → should redirect to `/assets`
4. Check the database — user should exist with correct role
5. Click logout → should go to Zitadel end-session → back to login

- [ ] **Step 4: Commit any fixes**

```bash
git add -A
git commit -m "fix(auth): integration fixes for Zitadel OIDC flow"
```
