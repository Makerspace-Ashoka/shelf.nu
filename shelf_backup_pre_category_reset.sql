--
-- PostgreSQL database dump
--

\restrict 3hk7Jg5jgtuJUCFstuYn2s27Mcwd8FQ8HaPS2qm6jIxtxhMixiCf4t9GhX5ppPM

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: _realtime; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA _realtime;


--
-- Name: auth; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA auth;


--
-- Name: extensions; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA extensions;


--
-- Name: graphql; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA graphql;


--
-- Name: graphql_public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA graphql_public;


--
-- Name: pg_net; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_net WITH SCHEMA extensions;


--
-- Name: EXTENSION pg_net; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_net IS 'Async HTTP';


--
-- Name: pgboss; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA pgboss;


--
-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA pgbouncer;


--
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA realtime;


--
-- Name: storage; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA storage;


--
-- Name: supabase_functions; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA supabase_functions;


--
-- Name: vault; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA vault;


--
-- Name: pg_graphql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_graphql WITH SCHEMA graphql;


--
-- Name: EXTENSION pg_graphql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_graphql IS 'pg_graphql: GraphQL support';


--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA extensions;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: supabase_vault; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS supabase_vault WITH SCHEMA vault;


--
-- Name: EXTENSION supabase_vault; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION supabase_vault IS 'Supabase Vault Extension';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.aal_level AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


--
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.code_challenge_method AS ENUM (
    's256',
    'plain'
);


--
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.factor_status AS ENUM (
    'unverified',
    'verified'
);


--
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.factor_type AS ENUM (
    'totp',
    'webauthn',
    'phone'
);


--
-- Name: oauth_authorization_status; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.oauth_authorization_status AS ENUM (
    'pending',
    'approved',
    'denied',
    'expired'
);


--
-- Name: oauth_client_type; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.oauth_client_type AS ENUM (
    'public',
    'confidential'
);


--
-- Name: oauth_registration_type; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.oauth_registration_type AS ENUM (
    'dynamic',
    'manual'
);


--
-- Name: oauth_response_type; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.oauth_response_type AS ENUM (
    'code'
);


--
-- Name: one_time_token_type; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.one_time_token_type AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);


--
-- Name: job_state; Type: TYPE; Schema: pgboss; Owner: -
--

CREATE TYPE pgboss.job_state AS ENUM (
    'created',
    'retry',
    'active',
    'completed',
    'expired',
    'cancelled',
    'failed'
);


--
-- Name: AssetIndexMode; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."AssetIndexMode" AS ENUM (
    'SIMPLE',
    'ADVANCED'
);


--
-- Name: AssetStatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."AssetStatus" AS ENUM (
    'AVAILABLE',
    'IN_CUSTODY',
    'CHECKED_OUT'
);


--
-- Name: AssetType; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."AssetType" AS ENUM (
    'INDIVIDUAL',
    'QUANTITY_TRACKED'
);


--
-- Name: AuditAssetStatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."AuditAssetStatus" AS ENUM (
    'PENDING',
    'FOUND',
    'MISSING',
    'UNEXPECTED'
);


--
-- Name: AuditAssignmentRole; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."AuditAssignmentRole" AS ENUM (
    'LEAD',
    'PARTICIPANT'
);


--
-- Name: AuditStatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."AuditStatus" AS ENUM (
    'PENDING',
    'ACTIVE',
    'COMPLETED',
    'CANCELLED'
);


--
-- Name: BarcodeType; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."BarcodeType" AS ENUM (
    'Code128',
    'DataMatrix',
    'Code39',
    'ExternalQR',
    'EAN13'
);


--
-- Name: BookingStatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."BookingStatus" AS ENUM (
    'DRAFT',
    'RESERVED',
    'ONGOING',
    'OVERDUE',
    'COMPLETE',
    'ARCHIVED',
    'CANCELLED'
);


--
-- Name: ConsumptionCategory; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."ConsumptionCategory" AS ENUM (
    'CHECKOUT',
    'RETURN',
    'RESTOCK',
    'ADJUSTMENT',
    'LOSS'
);


--
-- Name: ConsumptionType; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."ConsumptionType" AS ENUM (
    'ONE_WAY',
    'TWO_WAY'
);


--
-- Name: Currency; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."Currency" AS ENUM (
    'USD',
    'EUR',
    'GBP',
    'JPY',
    'AUD',
    'CAD',
    'CHF',
    'CNY',
    'INR',
    'ZAR',
    'BRL',
    'MXN',
    'SGD',
    'NZD',
    'SEK',
    'NOK',
    'KRW',
    'RUB',
    'HKD',
    'SAR',
    'AED',
    'DKK',
    'PLN',
    'MYR',
    'IDR',
    'CZK',
    'LKR',
    'PHP',
    'PKR',
    'UGX',
    'BGN',
    'TWD',
    'RON',
    'AFN',
    'ALL',
    'AMD',
    'ANG',
    'AOA',
    'ARS',
    'AWG',
    'AZN',
    'BAM',
    'BBD',
    'BDT',
    'BHD',
    'BIF',
    'BMD',
    'BND',
    'BOB',
    'BSD',
    'BTN',
    'BWP',
    'BYN',
    'BZD',
    'CDF',
    'CLP',
    'COP',
    'CRC',
    'CUP',
    'CVE',
    'DJF',
    'DOP',
    'DZD',
    'EGP',
    'ERN',
    'ETB',
    'FJD',
    'FKP',
    'GEL',
    'GHS',
    'GIP',
    'GMD',
    'GNF',
    'GTQ',
    'GYD',
    'HNL',
    'HTG',
    'HUF',
    'ILS',
    'IQD',
    'IRR',
    'ISK',
    'JMD',
    'JOD',
    'KES',
    'KGS',
    'KHR',
    'KMF',
    'KPW',
    'KWD',
    'KYD',
    'KZT',
    'LAK',
    'LBP',
    'LRD',
    'LSL',
    'LYD',
    'MAD',
    'MDL',
    'MGA',
    'MKD',
    'MMK',
    'MNT',
    'MOP',
    'MRU',
    'MUR',
    'MVR',
    'MWK',
    'MZN',
    'NAD',
    'NGN',
    'NIO',
    'NPR',
    'OMR',
    'PAB',
    'PEN',
    'PGK',
    'PYG',
    'QAR',
    'RSD',
    'RWF',
    'SBD',
    'SCR',
    'SDG',
    'SHP',
    'SLE',
    'SOS',
    'SRD',
    'SSP',
    'STN',
    'SVC',
    'SYP',
    'SZL',
    'THB',
    'TJS',
    'TMT',
    'TND',
    'TOP',
    'TRY',
    'TTD',
    'TZS',
    'UAH',
    'UYU',
    'UZS',
    'VES',
    'VND',
    'VUV',
    'WST',
    'XAF',
    'XCD',
    'XOF',
    'XPF',
    'YER',
    'ZMW',
    'ZWL'
);


--
-- Name: CustomFieldType; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."CustomFieldType" AS ENUM (
    'TEXT',
    'OPTION',
    'BOOLEAN',
    'DATE',
    'MULTILINE_TEXT',
    'AMOUNT',
    'NUMBER'
);


--
-- Name: ErrorCorrection; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."ErrorCorrection" AS ENUM (
    'L',
    'M',
    'Q',
    'H'
);


--
-- Name: InviteStatuses; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."InviteStatuses" AS ENUM (
    'PENDING',
    'ACCEPTED',
    'REJECTED',
    'INVALIDATED'
);


--
-- Name: KitStatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."KitStatus" AS ENUM (
    'AVAILABLE',
    'IN_CUSTODY',
    'CHECKED_OUT'
);


--
-- Name: NoteType; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."NoteType" AS ENUM (
    'COMMENT',
    'UPDATE'
);


--
-- Name: OrganizationRoles; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."OrganizationRoles" AS ENUM (
    'ADMIN',
    'OWNER',
    'SELF_SERVICE',
    'BASE'
);


--
-- Name: OrganizationType; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."OrganizationType" AS ENUM (
    'PERSONAL',
    'TEAM'
);


--
-- Name: QrIdDisplayPreference; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."QrIdDisplayPreference" AS ENUM (
    'QR_ID',
    'SAM_ID'
);


--
-- Name: Roles; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."Roles" AS ENUM (
    'USER',
    'ADMIN'
);


--
-- Name: TagUseFor; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."TagUseFor" AS ENUM (
    'ASSET',
    'BOOKING'
);


--
-- Name: TierId; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."TierId" AS ENUM (
    'free',
    'tier_1',
    'tier_2',
    'custom'
);


--
-- Name: UnitOfMeasure; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."UnitOfMeasure" AS ENUM (
    'PCS',
    'MG',
    'G',
    'KG',
    'MM',
    'M',
    'ML',
    'L'
);


--
-- Name: UpdateStatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."UpdateStatus" AS ENUM (
    'DRAFT',
    'PUBLISHED'
);


--
-- Name: action; Type: TYPE; Schema: realtime; Owner: -
--

CREATE TYPE realtime.action AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'ERROR'
);


--
-- Name: equality_op; Type: TYPE; Schema: realtime; Owner: -
--

CREATE TYPE realtime.equality_op AS ENUM (
    'eq',
    'neq',
    'lt',
    'lte',
    'gt',
    'gte',
    'in'
);


--
-- Name: user_defined_filter; Type: TYPE; Schema: realtime; Owner: -
--

CREATE TYPE realtime.user_defined_filter AS (
	column_name text,
	op realtime.equality_op,
	value text
);


--
-- Name: wal_column; Type: TYPE; Schema: realtime; Owner: -
--

CREATE TYPE realtime.wal_column AS (
	name text,
	type_name text,
	type_oid oid,
	value jsonb,
	is_pkey boolean,
	is_selectable boolean
);


--
-- Name: wal_rls; Type: TYPE; Schema: realtime; Owner: -
--

CREATE TYPE realtime.wal_rls AS (
	wal jsonb,
	is_rls_enabled boolean,
	subscription_ids uuid[],
	errors text[]
);


--
-- Name: buckettype; Type: TYPE; Schema: storage; Owner: -
--

CREATE TYPE storage.buckettype AS ENUM (
    'STANDARD',
    'ANALYTICS',
    'VECTOR'
);


--
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: -
--

CREATE FUNCTION auth.email() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;


--
-- Name: FUNCTION email(); Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON FUNCTION auth.email() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';


--
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: -
--

CREATE FUNCTION auth.jwt() RETURNS jsonb
    LANGUAGE sql STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;


--
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: -
--

CREATE FUNCTION auth.role() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;


--
-- Name: FUNCTION role(); Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON FUNCTION auth.role() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';


--
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: -
--

CREATE FUNCTION auth.uid() RETURNS uuid
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;


--
-- Name: FUNCTION uid(); Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON FUNCTION auth.uid() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';


--
-- Name: grant_pg_cron_access(); Type: FUNCTION; Schema: extensions; Owner: -
--

CREATE FUNCTION extensions.grant_pg_cron_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_cron'
  )
  THEN
    grant usage on schema cron to postgres with grant option;

    alter default privileges in schema cron grant all on tables to postgres with grant option;
    alter default privileges in schema cron grant all on functions to postgres with grant option;
    alter default privileges in schema cron grant all on sequences to postgres with grant option;

    alter default privileges for user supabase_admin in schema cron grant all
        on sequences to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on tables to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on functions to postgres with grant option;

    grant all privileges on all tables in schema cron to postgres with grant option;
    revoke all on table cron.job from postgres;
    grant select on table cron.job to postgres with grant option;
  END IF;
END;
$$;


--
-- Name: FUNCTION grant_pg_cron_access(); Type: COMMENT; Schema: extensions; Owner: -
--

COMMENT ON FUNCTION extensions.grant_pg_cron_access() IS 'Grants access to pg_cron';


--
-- Name: grant_pg_graphql_access(); Type: FUNCTION; Schema: extensions; Owner: -
--

CREATE FUNCTION extensions.grant_pg_graphql_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
DECLARE
    func_is_graphql_resolve bool;
BEGIN
    func_is_graphql_resolve = (
        SELECT n.proname = 'resolve'
        FROM pg_event_trigger_ddl_commands() AS ev
        LEFT JOIN pg_catalog.pg_proc AS n
        ON ev.objid = n.oid
    );

    IF func_is_graphql_resolve
    THEN
        -- Update public wrapper to pass all arguments through to the pg_graphql resolve func
        DROP FUNCTION IF EXISTS graphql_public.graphql;
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language sql
        as $$
            select graphql.resolve(
                query := query,
                variables := coalesce(variables, '{}'),
                "operationName" := "operationName",
                extensions := extensions
            );
        $$;

        -- This hook executes when `graphql.resolve` is created. That is not necessarily the last
        -- function in the extension so we need to grant permissions on existing entities AND
        -- update default permissions to any others that are created after `graphql.resolve`
        grant usage on schema graphql to postgres, anon, authenticated, service_role;
        grant select on all tables in schema graphql to postgres, anon, authenticated, service_role;
        grant execute on all functions in schema graphql to postgres, anon, authenticated, service_role;
        grant all on all sequences in schema graphql to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on tables to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on functions to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on sequences to postgres, anon, authenticated, service_role;

        -- Allow postgres role to allow granting usage on graphql and graphql_public schemas to custom roles
        grant usage on schema graphql_public to postgres with grant option;
        grant usage on schema graphql to postgres with grant option;
    END IF;

END;
$_$;


--
-- Name: FUNCTION grant_pg_graphql_access(); Type: COMMENT; Schema: extensions; Owner: -
--

COMMENT ON FUNCTION extensions.grant_pg_graphql_access() IS 'Grants access to pg_graphql';


--
-- Name: grant_pg_net_access(); Type: FUNCTION; Schema: extensions; Owner: -
--

CREATE FUNCTION extensions.grant_pg_net_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_net'
  )
  THEN
    GRANT USAGE ON SCHEMA net TO supabase_functions_admin, postgres, anon, authenticated, service_role;

    ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;
    ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;

    ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;
    ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;

    REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
    REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;

    GRANT EXECUTE ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
    GRANT EXECUTE ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
  END IF;
END;
$$;


--
-- Name: FUNCTION grant_pg_net_access(); Type: COMMENT; Schema: extensions; Owner: -
--

COMMENT ON FUNCTION extensions.grant_pg_net_access() IS 'Grants access to pg_net';


--
-- Name: pgrst_ddl_watch(); Type: FUNCTION; Schema: extensions; Owner: -
--

CREATE FUNCTION extensions.pgrst_ddl_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    IF cmd.command_tag IN (
      'CREATE SCHEMA', 'ALTER SCHEMA'
    , 'CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO', 'ALTER TABLE'
    , 'CREATE FOREIGN TABLE', 'ALTER FOREIGN TABLE'
    , 'CREATE VIEW', 'ALTER VIEW'
    , 'CREATE MATERIALIZED VIEW', 'ALTER MATERIALIZED VIEW'
    , 'CREATE FUNCTION', 'ALTER FUNCTION'
    , 'CREATE TRIGGER'
    , 'CREATE TYPE', 'ALTER TYPE'
    , 'CREATE RULE'
    , 'COMMENT'
    )
    -- don't notify in case of CREATE TEMP table or other objects created on pg_temp
    AND cmd.schema_name is distinct from 'pg_temp'
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


--
-- Name: pgrst_drop_watch(); Type: FUNCTION; Schema: extensions; Owner: -
--

CREATE FUNCTION extensions.pgrst_drop_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  obj record;
BEGIN
  FOR obj IN SELECT * FROM pg_event_trigger_dropped_objects()
  LOOP
    IF obj.object_type IN (
      'schema'
    , 'table'
    , 'foreign table'
    , 'view'
    , 'materialized view'
    , 'function'
    , 'trigger'
    , 'type'
    , 'rule'
    )
    AND obj.is_temporary IS false -- no pg_temp objects
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


--
-- Name: set_graphql_placeholder(); Type: FUNCTION; Schema: extensions; Owner: -
--

CREATE FUNCTION extensions.set_graphql_placeholder() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
    DECLARE
    graphql_is_dropped bool;
    BEGIN
    graphql_is_dropped = (
        SELECT ev.schema_name = 'graphql_public'
        FROM pg_event_trigger_dropped_objects() AS ev
        WHERE ev.schema_name = 'graphql_public'
    );

    IF graphql_is_dropped
    THEN
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language plpgsql
        as $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;
    END IF;

    END;
$_$;


--
-- Name: FUNCTION set_graphql_placeholder(); Type: COMMENT; Schema: extensions; Owner: -
--

COMMENT ON FUNCTION extensions.set_graphql_placeholder() IS 'Reintroduces placeholder function for graphql_public.graphql';


--
-- Name: get_auth(text); Type: FUNCTION; Schema: pgbouncer; Owner: -
--

CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO ''
    AS $_$
begin
    raise debug 'PgBouncer auth request: %', p_usename;

    return query
    select 
        rolname::text, 
        case when rolvaliduntil < now() 
            then null 
            else rolpassword::text 
        end 
    from pg_authid 
    where rolname=$1 and rolcanlogin;
end;
$_$;


--
-- Name: create_asset_sequence_for_org(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.create_asset_sequence_for_org(org_id text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    sequence_name TEXT;
BEGIN
    sequence_name := 'org_' || org_id || '_asset_sequence';
    
    -- Check if sequence already exists
    IF NOT EXISTS (
        SELECT 1 FROM pg_sequences 
        WHERE schemaname = 'public' 
        AND sequencename = sequence_name
    ) THEN
        -- Create the sequence starting at 1
        EXECUTE format('CREATE SEQUENCE %I START 1', sequence_name);
    END IF;
END;
$$;


--
-- Name: create_user_contact_on_user_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.create_user_contact_on_user_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO "UserContact" (
        id,
        "userId",
        "createdAt",
        "updatedAt"
    ) VALUES (
        gen_random_uuid()::text, 
        NEW.id,
        NOW(),
        NOW()
    );
    RETURN NEW;
END;
$$;


--
-- Name: get_next_sequential_id(text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.get_next_sequential_id(org_id text, prefix text DEFAULT 'SAM'::text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
    sequence_name TEXT;
    next_val BIGINT;
BEGIN
    sequence_name := 'org_' || org_id || '_asset_sequence';
    
    -- Ensure sequence exists
    PERFORM create_asset_sequence_for_org(org_id);
    
    -- Get next value
    EXECUTE format('SELECT nextval(%L)', sequence_name) INTO next_val;
    
    -- Return formatted sequential ID with proper padding
    -- Use GREATEST to ensure at least 4 digits but allow growth beyond 9999
    RETURN prefix || '-' || LPAD(next_val::text, GREATEST(4, LENGTH(next_val::text)), '0');
END;
$$;


--
-- Name: reset_asset_sequence_for_org(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.reset_asset_sequence_for_org(org_id text) RETURNS void
    LANGUAGE plpgsql
    AS $_$
DECLARE
    sequence_name TEXT;
    max_seq_num BIGINT;
BEGIN
    sequence_name := 'org_' || org_id || '_asset_sequence';
    
    -- Ensure sequence exists
    PERFORM create_asset_sequence_for_org(org_id);
    
    -- Find the highest sequence number for this organization
    SELECT COALESCE(
        MAX(
            CASE 
                WHEN "sequentialId" ~ '^[A-Z]+-\d+$' 
                THEN CAST(SPLIT_PART("sequentialId", '-', 2) AS BIGINT)
                ELSE 0
            END
        ), 0
    ) INTO max_seq_num
    FROM "Asset" 
    WHERE "organizationId" = org_id 
    AND "sequentialId" IS NOT NULL;
    
    -- Reset sequence to max + 1
    EXECUTE format('SELECT setval(%L, %s)', sequence_name, max_seq_num + 1);
END;
$_$;


--
-- Name: apply_rls(jsonb, integer); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer DEFAULT (1024 * 1024)) RETURNS SETOF realtime.wal_rls
    LANGUAGE plpgsql
    AS $$
declare
-- Regclass of the table e.g. public.notes
entity_ regclass = (quote_ident(wal ->> 'schema') || '.' || quote_ident(wal ->> 'table'))::regclass;

-- I, U, D, T: insert, update ...
action realtime.action = (
    case wal ->> 'action'
        when 'I' then 'INSERT'
        when 'U' then 'UPDATE'
        when 'D' then 'DELETE'
        else 'ERROR'
    end
);

-- Is row level security enabled for the table
is_rls_enabled bool = relrowsecurity from pg_class where oid = entity_;

subscriptions realtime.subscription[] = array_agg(subs)
    from
        realtime.subscription subs
    where
        subs.entity = entity_;

-- Subscription vars
roles regrole[] = array_agg(distinct us.claims_role::text)
    from
        unnest(subscriptions) us;

working_role regrole;
claimed_role regrole;
claims jsonb;

subscription_id uuid;
subscription_has_access bool;
visible_to_subscription_ids uuid[] = '{}';

-- structured info for wal's columns
columns realtime.wal_column[];
-- previous identity values for update/delete
old_columns realtime.wal_column[];

error_record_exceeds_max_size boolean = octet_length(wal::text) > max_record_bytes;

-- Primary jsonb output for record
output jsonb;

begin
perform set_config('role', null, true);

columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'columns') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

old_columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'identity') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

for working_role in select * from unnest(roles) loop

    -- Update `is_selectable` for columns and old_columns
    columns =
        array_agg(
            (
                c.name,
                c.type_name,
                c.type_oid,
                c.value,
                c.is_pkey,
                pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
            )::realtime.wal_column
        )
        from
            unnest(columns) c;

    old_columns =
            array_agg(
                (
                    c.name,
                    c.type_name,
                    c.type_oid,
                    c.value,
                    c.is_pkey,
                    pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                )::realtime.wal_column
            )
            from
                unnest(old_columns) c;

    if action <> 'DELETE' and count(1) = 0 from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            -- subscriptions is already filtered by entity
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 400: Bad Request, no primary key']
        )::realtime.wal_rls;

    -- The claims role does not have SELECT permission to the primary key of entity
    elsif action <> 'DELETE' and sum(c.is_selectable::int) <> count(1) from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 401: Unauthorized']
        )::realtime.wal_rls;

    else
        output = jsonb_build_object(
            'schema', wal ->> 'schema',
            'table', wal ->> 'table',
            'type', action,
            'commit_timestamp', to_char(
                ((wal ->> 'timestamp')::timestamptz at time zone 'utc'),
                'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"'
            ),
            'columns', (
                select
                    jsonb_agg(
                        jsonb_build_object(
                            'name', pa.attname,
                            'type', pt.typname
                        )
                        order by pa.attnum asc
                    )
                from
                    pg_attribute pa
                    join pg_type pt
                        on pa.atttypid = pt.oid
                where
                    attrelid = entity_
                    and attnum > 0
                    and pg_catalog.has_column_privilege(working_role, entity_, pa.attname, 'SELECT')
            )
        )
        -- Add "record" key for insert and update
        || case
            when action in ('INSERT', 'UPDATE') then
                jsonb_build_object(
                    'record',
                    (
                        select
                            jsonb_object_agg(
                                -- if unchanged toast, get column name and value from old record
                                coalesce((c).name, (oc).name),
                                case
                                    when (c).name is null then (oc).value
                                    else (c).value
                                end
                            )
                        from
                            unnest(columns) c
                            full outer join unnest(old_columns) oc
                                on (c).name = (oc).name
                        where
                            coalesce((c).is_selectable, (oc).is_selectable)
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                    )
                )
            else '{}'::jsonb
        end
        -- Add "old_record" key for update and delete
        || case
            when action = 'UPDATE' then
                jsonb_build_object(
                        'old_record',
                        (
                            select jsonb_object_agg((c).name, (c).value)
                            from unnest(old_columns) c
                            where
                                (c).is_selectable
                                and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                        )
                    )
            when action = 'DELETE' then
                jsonb_build_object(
                    'old_record',
                    (
                        select jsonb_object_agg((c).name, (c).value)
                        from unnest(old_columns) c
                        where
                            (c).is_selectable
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                            and ( not is_rls_enabled or (c).is_pkey ) -- if RLS enabled, we can't secure deletes so filter to pkey
                    )
                )
            else '{}'::jsonb
        end;

        -- Create the prepared statement
        if is_rls_enabled and action <> 'DELETE' then
            if (select 1 from pg_prepared_statements where name = 'walrus_rls_stmt' limit 1) > 0 then
                deallocate walrus_rls_stmt;
            end if;
            execute realtime.build_prepared_statement_sql('walrus_rls_stmt', entity_, columns);
        end if;

        visible_to_subscription_ids = '{}';

        for subscription_id, claims in (
                select
                    subs.subscription_id,
                    subs.claims
                from
                    unnest(subscriptions) subs
                where
                    subs.entity = entity_
                    and subs.claims_role = working_role
                    and (
                        realtime.is_visible_through_filters(columns, subs.filters)
                        or (
                          action = 'DELETE'
                          and realtime.is_visible_through_filters(old_columns, subs.filters)
                        )
                    )
        ) loop

            if not is_rls_enabled or action = 'DELETE' then
                visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
            else
                -- Check if RLS allows the role to see the record
                perform
                    -- Trim leading and trailing quotes from working_role because set_config
                    -- doesn't recognize the role as valid if they are included
                    set_config('role', trim(both '"' from working_role::text), true),
                    set_config('request.jwt.claims', claims::text, true);

                execute 'execute walrus_rls_stmt' into subscription_has_access;

                if subscription_has_access then
                    visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
                end if;
            end if;
        end loop;

        perform set_config('role', null, true);

        return next (
            output,
            is_rls_enabled,
            visible_to_subscription_ids,
            case
                when error_record_exceeds_max_size then array['Error 413: Payload Too Large']
                else '{}'
            end
        )::realtime.wal_rls;

    end if;
end loop;

perform set_config('role', null, true);
end;
$$;


--
-- Name: broadcast_changes(text, text, text, text, text, record, record, text); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text DEFAULT 'ROW'::text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    -- Declare a variable to hold the JSONB representation of the row
    row_data jsonb := '{}'::jsonb;
BEGIN
    IF level = 'STATEMENT' THEN
        RAISE EXCEPTION 'function can only be triggered for each row, not for each statement';
    END IF;
    -- Check the operation type and handle accordingly
    IF operation = 'INSERT' OR operation = 'UPDATE' OR operation = 'DELETE' THEN
        row_data := jsonb_build_object('old_record', OLD, 'record', NEW, 'operation', operation, 'table', table_name, 'schema', table_schema);
        PERFORM realtime.send (row_data, event_name, topic_name);
    ELSE
        RAISE EXCEPTION 'Unexpected operation type: %', operation;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Failed to process the row: %', SQLERRM;
END;

$$;


--
-- Name: build_prepared_statement_sql(text, regclass, realtime.wal_column[]); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) RETURNS text
    LANGUAGE sql
    AS $$
      /*
      Builds a sql string that, if executed, creates a prepared statement to
      tests retrive a row from *entity* by its primary key columns.
      Example
          select realtime.build_prepared_statement_sql('public.notes', '{"id"}'::text[], '{"bigint"}'::text[])
      */
          select
      'prepare ' || prepared_statement_name || ' as
          select
              exists(
                  select
                      1
                  from
                      ' || entity || '
                  where
                      ' || string_agg(quote_ident(pkc.name) || '=' || quote_nullable(pkc.value #>> '{}') , ' and ') || '
              )'
          from
              unnest(columns) pkc
          where
              pkc.is_pkey
          group by
              entity
      $$;


--
-- Name: cast(text, regtype); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime."cast"(val text, type_ regtype) RETURNS jsonb
    LANGUAGE plpgsql IMMUTABLE
    AS $$
    declare
      res jsonb;
    begin
      execute format('select to_jsonb(%L::'|| type_::text || ')', val)  into res;
      return res;
    end
    $$;


--
-- Name: check_equality_op(realtime.equality_op, regtype, text, text); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$
      /*
      Casts *val_1* and *val_2* as type *type_* and check the *op* condition for truthiness
      */
      declare
          op_symbol text = (
              case
                  when op = 'eq' then '='
                  when op = 'neq' then '!='
                  when op = 'lt' then '<'
                  when op = 'lte' then '<='
                  when op = 'gt' then '>'
                  when op = 'gte' then '>='
                  when op = 'in' then '= any'
                  else 'UNKNOWN OP'
              end
          );
          res boolean;
      begin
          execute format(
              'select %L::'|| type_::text || ' ' || op_symbol
              || ' ( %L::'
              || (
                  case
                      when op = 'in' then type_::text || '[]'
                      else type_::text end
              )
              || ')', val_1, val_2) into res;
          return res;
      end;
      $$;


--
-- Name: is_visible_through_filters(realtime.wal_column[], realtime.user_defined_filter[]); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$
    /*
    Should the record be visible (true) or filtered out (false) after *filters* are applied
    */
        select
            -- Default to allowed when no filters present
            $2 is null -- no filters. this should not happen because subscriptions has a default
            or array_length($2, 1) is null -- array length of an empty array is null
            or bool_and(
                coalesce(
                    realtime.check_equality_op(
                        op:=f.op,
                        type_:=coalesce(
                            col.type_oid::regtype, -- null when wal2json version <= 2.4
                            col.type_name::regtype
                        ),
                        -- cast jsonb to text
                        val_1:=col.value #>> '{}',
                        val_2:=f.value
                    ),
                    false -- if null, filter does not match
                )
            )
        from
            unnest(filters) f
            join unnest(columns) col
                on f.column_name = col.name;
    $_$;


--
-- Name: list_changes(name, name, integer, integer); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) RETURNS SETOF realtime.wal_rls
    LANGUAGE sql
    SET log_min_messages TO 'fatal'
    AS $$
      with pub as (
        select
          concat_ws(
            ',',
            case when bool_or(pubinsert) then 'insert' else null end,
            case when bool_or(pubupdate) then 'update' else null end,
            case when bool_or(pubdelete) then 'delete' else null end
          ) as w2j_actions,
          coalesce(
            string_agg(
              realtime.quote_wal2json(format('%I.%I', schemaname, tablename)::regclass),
              ','
            ) filter (where ppt.tablename is not null and ppt.tablename not like '% %'),
            ''
          ) w2j_add_tables
        from
          pg_publication pp
          left join pg_publication_tables ppt
            on pp.pubname = ppt.pubname
        where
          pp.pubname = publication
        group by
          pp.pubname
        limit 1
      ),
      w2j as (
        select
          x.*, pub.w2j_add_tables
        from
          pub,
          pg_logical_slot_get_changes(
            slot_name, null, max_changes,
            'include-pk', 'true',
            'include-transaction', 'false',
            'include-timestamp', 'true',
            'include-type-oids', 'true',
            'format-version', '2',
            'actions', pub.w2j_actions,
            'add-tables', pub.w2j_add_tables
          ) x
      )
      select
        xyz.wal,
        xyz.is_rls_enabled,
        xyz.subscription_ids,
        xyz.errors
      from
        w2j,
        realtime.apply_rls(
          wal := w2j.data::jsonb,
          max_record_bytes := max_record_bytes
        ) xyz(wal, is_rls_enabled, subscription_ids, errors)
      where
        w2j.w2j_add_tables <> ''
        and xyz.subscription_ids[1] is not null
    $$;


--
-- Name: quote_wal2json(regclass); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.quote_wal2json(entity regclass) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
      select
        (
          select string_agg('' || ch,'')
          from unnest(string_to_array(nsp.nspname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
        )
        || '.'
        || (
          select string_agg('' || ch,'')
          from unnest(string_to_array(pc.relname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
          )
      from
        pg_class pc
        join pg_namespace nsp
          on pc.relnamespace = nsp.oid
      where
        pc.oid = entity
    $$;


--
-- Name: send(jsonb, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean DEFAULT true) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
  generated_id uuid;
  final_payload jsonb;
BEGIN
  BEGIN
    -- Generate a new UUID for the id
    generated_id := gen_random_uuid();

    -- Check if payload has an 'id' key, if not, add the generated UUID
    IF payload ? 'id' THEN
      final_payload := payload;
    ELSE
      final_payload := jsonb_set(payload, '{id}', to_jsonb(generated_id));
    END IF;

    -- Set the topic configuration
    EXECUTE format('SET LOCAL realtime.topic TO %L', topic);

    -- Attempt to insert the message
    INSERT INTO realtime.messages (id, payload, event, topic, private, extension)
    VALUES (generated_id, final_payload, event, topic, private, 'broadcast');
  EXCEPTION
    WHEN OTHERS THEN
      -- Capture and notify the error
      RAISE WARNING 'ErrorSendingBroadcastMessage: %', SQLERRM;
  END;
END;
$$;


--
-- Name: subscription_check_filters(); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.subscription_check_filters() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    /*
    Validates that the user defined filters for a subscription:
    - refer to valid columns that the claimed role may access
    - values are coercable to the correct column type
    */
    declare
        col_names text[] = coalesce(
                array_agg(c.column_name order by c.ordinal_position),
                '{}'::text[]
            )
            from
                information_schema.columns c
            where
                format('%I.%I', c.table_schema, c.table_name)::regclass = new.entity
                and pg_catalog.has_column_privilege(
                    (new.claims ->> 'role'),
                    format('%I.%I', c.table_schema, c.table_name)::regclass,
                    c.column_name,
                    'SELECT'
                );
        filter realtime.user_defined_filter;
        col_type regtype;

        in_val jsonb;
    begin
        for filter in select * from unnest(new.filters) loop
            -- Filtered column is valid
            if not filter.column_name = any(col_names) then
                raise exception 'invalid column for filter %', filter.column_name;
            end if;

            -- Type is sanitized and safe for string interpolation
            col_type = (
                select atttypid::regtype
                from pg_catalog.pg_attribute
                where attrelid = new.entity
                      and attname = filter.column_name
            );
            if col_type is null then
                raise exception 'failed to lookup type for column %', filter.column_name;
            end if;

            -- Set maximum number of entries for in filter
            if filter.op = 'in'::realtime.equality_op then
                in_val = realtime.cast(filter.value, (col_type::text || '[]')::regtype);
                if coalesce(jsonb_array_length(in_val), 0) > 100 then
                    raise exception 'too many values for `in` filter. Maximum 100';
                end if;
            else
                -- raises an exception if value is not coercable to type
                perform realtime.cast(filter.value, col_type);
            end if;

        end loop;

        -- Apply consistent order to filters so the unique constraint on
        -- (subscription_id, entity, filters) can't be tricked by a different filter order
        new.filters = coalesce(
            array_agg(f order by f.column_name, f.op, f.value),
            '{}'
        ) from unnest(new.filters) f;

        return new;
    end;
    $$;


--
-- Name: to_regrole(text); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.to_regrole(role_name text) RETURNS regrole
    LANGUAGE sql IMMUTABLE
    AS $$ select role_name::regrole $$;


--
-- Name: topic(); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.topic() RETURNS text
    LANGUAGE sql STABLE
    AS $$
select nullif(current_setting('realtime.topic', true), '')::text;
$$;


--
-- Name: can_insert_object(text, text, uuid, jsonb); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);
  -- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';
END
$$;


--
-- Name: enforce_bucket_name_length(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.enforce_bucket_name_length() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
    if length(new.name) > 100 then
        raise exception 'bucket name "%" is too long (% characters). Max is 100.', new.name, length(new.name);
    end if;
    return new;
end;
$$;


--
-- Name: extension(text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.extension(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
_filename text;
BEGIN
	select string_to_array(name, '/') into _parts;
	select _parts[array_length(_parts,1)] into _filename;
	-- @todo return the last part instead of 2
	return reverse(split_part(reverse(_filename), '.', 1));
END
$$;


--
-- Name: filename(text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.filename(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[array_length(_parts,1)];
END
$$;


--
-- Name: foldername(text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.foldername(name text) RETURNS text[]
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[1:array_length(_parts,1)-1];
END
$$;


--
-- Name: get_common_prefix(text, text, text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.get_common_prefix(p_key text, p_prefix text, p_delimiter text) RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $$
SELECT CASE
    WHEN position(p_delimiter IN substring(p_key FROM length(p_prefix) + 1)) > 0
    THEN left(p_key, length(p_prefix) + position(p_delimiter IN substring(p_key FROM length(p_prefix) + 1)))
    ELSE NULL
END;
$$;


--
-- Name: get_size_by_bucket(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.get_size_by_bucket() RETURNS TABLE(size bigint, bucket_id text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::int) as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;


--
-- Name: list_multipart_uploads_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, next_key_token text DEFAULT ''::text, next_upload_token text DEFAULT ''::text) RETURNS TABLE(key text, id text, created_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(key COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                        substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1)))
                    ELSE
                        key
                END AS key, id, created_at
            FROM
                storage.s3_multipart_uploads
            WHERE
                bucket_id = $5 AND
                key ILIKE $1 || ''%'' AND
                CASE
                    WHEN $4 != '''' AND $6 = '''' THEN
                        CASE
                            WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                                substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                key COLLATE "C" > $4
                            END
                    ELSE
                        true
                END AND
                CASE
                    WHEN $6 != '''' THEN
                        id COLLATE "C" > $6
                    ELSE
                        true
                    END
            ORDER BY
                key COLLATE "C" ASC, created_at ASC) as e order by key COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_key_token, bucket_id, next_upload_token;
END;
$_$;


--
-- Name: list_objects_with_delimiter(text, text, text, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.list_objects_with_delimiter(_bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, start_after text DEFAULT ''::text, next_token text DEFAULT ''::text, sort_order text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, metadata jsonb, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    v_peek_name TEXT;
    v_current RECORD;
    v_common_prefix TEXT;

    -- Configuration
    v_is_asc BOOLEAN;
    v_prefix TEXT;
    v_start TEXT;
    v_upper_bound TEXT;
    v_file_batch_size INT;

    -- Seek state
    v_next_seek TEXT;
    v_count INT := 0;

    -- Dynamic SQL for batch query only
    v_batch_query TEXT;

BEGIN
    -- ========================================================================
    -- INITIALIZATION
    -- ========================================================================
    v_is_asc := lower(coalesce(sort_order, 'asc')) = 'asc';
    v_prefix := coalesce(prefix_param, '');
    v_start := CASE WHEN coalesce(next_token, '') <> '' THEN next_token ELSE coalesce(start_after, '') END;
    v_file_batch_size := LEAST(GREATEST(max_keys * 2, 100), 1000);

    -- Calculate upper bound for prefix filtering (bytewise, using COLLATE "C")
    IF v_prefix = '' THEN
        v_upper_bound := NULL;
    ELSIF right(v_prefix, 1) = delimiter_param THEN
        v_upper_bound := left(v_prefix, -1) || chr(ascii(delimiter_param) + 1);
    ELSE
        v_upper_bound := left(v_prefix, -1) || chr(ascii(right(v_prefix, 1)) + 1);
    END IF;

    -- Build batch query (dynamic SQL - called infrequently, amortized over many rows)
    IF v_is_asc THEN
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" >= $2 ' ||
                'AND o.name COLLATE "C" < $3 ORDER BY o.name COLLATE "C" ASC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" >= $2 ' ||
                'ORDER BY o.name COLLATE "C" ASC LIMIT $4';
        END IF;
    ELSE
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" < $2 ' ||
                'AND o.name COLLATE "C" >= $3 ORDER BY o.name COLLATE "C" DESC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" < $2 ' ||
                'ORDER BY o.name COLLATE "C" DESC LIMIT $4';
        END IF;
    END IF;

    -- ========================================================================
    -- SEEK INITIALIZATION: Determine starting position
    -- ========================================================================
    IF v_start = '' THEN
        IF v_is_asc THEN
            v_next_seek := v_prefix;
        ELSE
            -- DESC without cursor: find the last item in range
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_next_seek FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_prefix AND o.name COLLATE "C" < v_upper_bound
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSIF v_prefix <> '' THEN
                SELECT o.name INTO v_next_seek FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_prefix
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSE
                SELECT o.name INTO v_next_seek FROM storage.objects o
                WHERE o.bucket_id = _bucket_id
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            END IF;

            IF v_next_seek IS NOT NULL THEN
                v_next_seek := v_next_seek || delimiter_param;
            ELSE
                RETURN;
            END IF;
        END IF;
    ELSE
        -- Cursor provided: determine if it refers to a folder or leaf
        IF EXISTS (
            SELECT 1 FROM storage.objects o
            WHERE o.bucket_id = _bucket_id
              AND o.name COLLATE "C" LIKE v_start || delimiter_param || '%'
            LIMIT 1
        ) THEN
            -- Cursor refers to a folder
            IF v_is_asc THEN
                v_next_seek := v_start || chr(ascii(delimiter_param) + 1);
            ELSE
                v_next_seek := v_start || delimiter_param;
            END IF;
        ELSE
            -- Cursor refers to a leaf object
            IF v_is_asc THEN
                v_next_seek := v_start || delimiter_param;
            ELSE
                v_next_seek := v_start;
            END IF;
        END IF;
    END IF;

    -- ========================================================================
    -- MAIN LOOP: Hybrid peek-then-batch algorithm
    -- Uses STATIC SQL for peek (hot path) and DYNAMIC SQL for batch
    -- ========================================================================
    LOOP
        EXIT WHEN v_count >= max_keys;

        -- STEP 1: PEEK using STATIC SQL (plan cached, very fast)
        IF v_is_asc THEN
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_next_seek AND o.name COLLATE "C" < v_upper_bound
                ORDER BY o.name COLLATE "C" ASC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_next_seek
                ORDER BY o.name COLLATE "C" ASC LIMIT 1;
            END IF;
        ELSE
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" < v_next_seek AND o.name COLLATE "C" >= v_prefix
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSIF v_prefix <> '' THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" < v_next_seek AND o.name COLLATE "C" >= v_prefix
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" < v_next_seek
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            END IF;
        END IF;

        EXIT WHEN v_peek_name IS NULL;

        -- STEP 2: Check if this is a FOLDER or FILE
        v_common_prefix := storage.get_common_prefix(v_peek_name, v_prefix, delimiter_param);

        IF v_common_prefix IS NOT NULL THEN
            -- FOLDER: Emit and skip to next folder (no heap access needed)
            name := rtrim(v_common_prefix, delimiter_param);
            id := NULL;
            updated_at := NULL;
            created_at := NULL;
            last_accessed_at := NULL;
            metadata := NULL;
            RETURN NEXT;
            v_count := v_count + 1;

            -- Advance seek past the folder range
            IF v_is_asc THEN
                v_next_seek := left(v_common_prefix, -1) || chr(ascii(delimiter_param) + 1);
            ELSE
                v_next_seek := v_common_prefix;
            END IF;
        ELSE
            -- FILE: Batch fetch using DYNAMIC SQL (overhead amortized over many rows)
            -- For ASC: upper_bound is the exclusive upper limit (< condition)
            -- For DESC: prefix is the inclusive lower limit (>= condition)
            FOR v_current IN EXECUTE v_batch_query USING _bucket_id, v_next_seek,
                CASE WHEN v_is_asc THEN COALESCE(v_upper_bound, v_prefix) ELSE v_prefix END, v_file_batch_size
            LOOP
                v_common_prefix := storage.get_common_prefix(v_current.name, v_prefix, delimiter_param);

                IF v_common_prefix IS NOT NULL THEN
                    -- Hit a folder: exit batch, let peek handle it
                    v_next_seek := v_current.name;
                    EXIT;
                END IF;

                -- Emit file
                name := v_current.name;
                id := v_current.id;
                updated_at := v_current.updated_at;
                created_at := v_current.created_at;
                last_accessed_at := v_current.last_accessed_at;
                metadata := v_current.metadata;
                RETURN NEXT;
                v_count := v_count + 1;

                -- Advance seek past this file
                IF v_is_asc THEN
                    v_next_seek := v_current.name || delimiter_param;
                ELSE
                    v_next_seek := v_current.name;
                END IF;

                EXIT WHEN v_count >= max_keys;
            END LOOP;
        END IF;
    END LOOP;
END;
$_$;


--
-- Name: operation(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.operation() RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN current_setting('storage.operation', true);
END;
$$;


--
-- Name: protect_delete(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.protect_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Check if storage.allow_delete_query is set to 'true'
    IF COALESCE(current_setting('storage.allow_delete_query', true), 'false') != 'true' THEN
        RAISE EXCEPTION 'Direct deletion from storage tables is not allowed. Use the Storage API instead.'
            USING HINT = 'This prevents accidental data loss from orphaned objects.',
                  ERRCODE = '42501';
    END IF;
    RETURN NULL;
END;
$$;


--
-- Name: search(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.search(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    v_peek_name TEXT;
    v_current RECORD;
    v_common_prefix TEXT;
    v_delimiter CONSTANT TEXT := '/';

    -- Configuration
    v_limit INT;
    v_prefix TEXT;
    v_prefix_lower TEXT;
    v_is_asc BOOLEAN;
    v_order_by TEXT;
    v_sort_order TEXT;
    v_upper_bound TEXT;
    v_file_batch_size INT;

    -- Dynamic SQL for batch query only
    v_batch_query TEXT;

    -- Seek state
    v_next_seek TEXT;
    v_count INT := 0;
    v_skipped INT := 0;
BEGIN
    -- ========================================================================
    -- INITIALIZATION
    -- ========================================================================
    v_limit := LEAST(coalesce(limits, 100), 1500);
    v_prefix := coalesce(prefix, '') || coalesce(search, '');
    v_prefix_lower := lower(v_prefix);
    v_is_asc := lower(coalesce(sortorder, 'asc')) = 'asc';
    v_file_batch_size := LEAST(GREATEST(v_limit * 2, 100), 1000);

    -- Validate sort column
    CASE lower(coalesce(sortcolumn, 'name'))
        WHEN 'name' THEN v_order_by := 'name';
        WHEN 'updated_at' THEN v_order_by := 'updated_at';
        WHEN 'created_at' THEN v_order_by := 'created_at';
        WHEN 'last_accessed_at' THEN v_order_by := 'last_accessed_at';
        ELSE v_order_by := 'name';
    END CASE;

    v_sort_order := CASE WHEN v_is_asc THEN 'asc' ELSE 'desc' END;

    -- ========================================================================
    -- NON-NAME SORTING: Use path_tokens approach (unchanged)
    -- ========================================================================
    IF v_order_by != 'name' THEN
        RETURN QUERY EXECUTE format(
            $sql$
            WITH folders AS (
                SELECT path_tokens[$1] AS folder
                FROM storage.objects
                WHERE objects.name ILIKE $2 || '%%'
                  AND bucket_id = $3
                  AND array_length(objects.path_tokens, 1) <> $1
                GROUP BY folder
                ORDER BY folder %s
            )
            (SELECT folder AS "name",
                   NULL::uuid AS id,
                   NULL::timestamptz AS updated_at,
                   NULL::timestamptz AS created_at,
                   NULL::timestamptz AS last_accessed_at,
                   NULL::jsonb AS metadata FROM folders)
            UNION ALL
            (SELECT path_tokens[$1] AS "name",
                   id, updated_at, created_at, last_accessed_at, metadata
             FROM storage.objects
             WHERE objects.name ILIKE $2 || '%%'
               AND bucket_id = $3
               AND array_length(objects.path_tokens, 1) = $1
             ORDER BY %I %s)
            LIMIT $4 OFFSET $5
            $sql$, v_sort_order, v_order_by, v_sort_order
        ) USING levels, v_prefix, bucketname, v_limit, offsets;
        RETURN;
    END IF;

    -- ========================================================================
    -- NAME SORTING: Hybrid skip-scan with batch optimization
    -- ========================================================================

    -- Calculate upper bound for prefix filtering
    IF v_prefix_lower = '' THEN
        v_upper_bound := NULL;
    ELSIF right(v_prefix_lower, 1) = v_delimiter THEN
        v_upper_bound := left(v_prefix_lower, -1) || chr(ascii(v_delimiter) + 1);
    ELSE
        v_upper_bound := left(v_prefix_lower, -1) || chr(ascii(right(v_prefix_lower, 1)) + 1);
    END IF;

    -- Build batch query (dynamic SQL - called infrequently, amortized over many rows)
    IF v_is_asc THEN
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" >= $2 ' ||
                'AND lower(o.name) COLLATE "C" < $3 ORDER BY lower(o.name) COLLATE "C" ASC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" >= $2 ' ||
                'ORDER BY lower(o.name) COLLATE "C" ASC LIMIT $4';
        END IF;
    ELSE
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" < $2 ' ||
                'AND lower(o.name) COLLATE "C" >= $3 ORDER BY lower(o.name) COLLATE "C" DESC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" < $2 ' ||
                'ORDER BY lower(o.name) COLLATE "C" DESC LIMIT $4';
        END IF;
    END IF;

    -- Initialize seek position
    IF v_is_asc THEN
        v_next_seek := v_prefix_lower;
    ELSE
        -- DESC: find the last item in range first (static SQL)
        IF v_upper_bound IS NOT NULL THEN
            SELECT o.name INTO v_peek_name FROM storage.objects o
            WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_prefix_lower AND lower(o.name) COLLATE "C" < v_upper_bound
            ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
        ELSIF v_prefix_lower <> '' THEN
            SELECT o.name INTO v_peek_name FROM storage.objects o
            WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_prefix_lower
            ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
        ELSE
            SELECT o.name INTO v_peek_name FROM storage.objects o
            WHERE o.bucket_id = bucketname
            ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
        END IF;

        IF v_peek_name IS NOT NULL THEN
            v_next_seek := lower(v_peek_name) || v_delimiter;
        ELSE
            RETURN;
        END IF;
    END IF;

    -- ========================================================================
    -- MAIN LOOP: Hybrid peek-then-batch algorithm
    -- Uses STATIC SQL for peek (hot path) and DYNAMIC SQL for batch
    -- ========================================================================
    LOOP
        EXIT WHEN v_count >= v_limit;

        -- STEP 1: PEEK using STATIC SQL (plan cached, very fast)
        IF v_is_asc THEN
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_next_seek AND lower(o.name) COLLATE "C" < v_upper_bound
                ORDER BY lower(o.name) COLLATE "C" ASC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_next_seek
                ORDER BY lower(o.name) COLLATE "C" ASC LIMIT 1;
            END IF;
        ELSE
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" < v_next_seek AND lower(o.name) COLLATE "C" >= v_prefix_lower
                ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
            ELSIF v_prefix_lower <> '' THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" < v_next_seek AND lower(o.name) COLLATE "C" >= v_prefix_lower
                ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" < v_next_seek
                ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
            END IF;
        END IF;

        EXIT WHEN v_peek_name IS NULL;

        -- STEP 2: Check if this is a FOLDER or FILE
        v_common_prefix := storage.get_common_prefix(lower(v_peek_name), v_prefix_lower, v_delimiter);

        IF v_common_prefix IS NOT NULL THEN
            -- FOLDER: Handle offset, emit if needed, skip to next folder
            IF v_skipped < offsets THEN
                v_skipped := v_skipped + 1;
            ELSE
                name := split_part(rtrim(v_common_prefix, v_delimiter), v_delimiter, levels);
                id := NULL;
                updated_at := NULL;
                created_at := NULL;
                last_accessed_at := NULL;
                metadata := NULL;
                RETURN NEXT;
                v_count := v_count + 1;
            END IF;

            -- Advance seek past the folder range
            IF v_is_asc THEN
                v_next_seek := lower(left(v_common_prefix, -1)) || chr(ascii(v_delimiter) + 1);
            ELSE
                v_next_seek := lower(v_common_prefix);
            END IF;
        ELSE
            -- FILE: Batch fetch using DYNAMIC SQL (overhead amortized over many rows)
            -- For ASC: upper_bound is the exclusive upper limit (< condition)
            -- For DESC: prefix_lower is the inclusive lower limit (>= condition)
            FOR v_current IN EXECUTE v_batch_query
                USING bucketname, v_next_seek,
                    CASE WHEN v_is_asc THEN COALESCE(v_upper_bound, v_prefix_lower) ELSE v_prefix_lower END, v_file_batch_size
            LOOP
                v_common_prefix := storage.get_common_prefix(lower(v_current.name), v_prefix_lower, v_delimiter);

                IF v_common_prefix IS NOT NULL THEN
                    -- Hit a folder: exit batch, let peek handle it
                    v_next_seek := lower(v_current.name);
                    EXIT;
                END IF;

                -- Handle offset skipping
                IF v_skipped < offsets THEN
                    v_skipped := v_skipped + 1;
                ELSE
                    -- Emit file
                    name := split_part(v_current.name, v_delimiter, levels);
                    id := v_current.id;
                    updated_at := v_current.updated_at;
                    created_at := v_current.created_at;
                    last_accessed_at := v_current.last_accessed_at;
                    metadata := v_current.metadata;
                    RETURN NEXT;
                    v_count := v_count + 1;
                END IF;

                -- Advance seek past this file
                IF v_is_asc THEN
                    v_next_seek := lower(v_current.name) || v_delimiter;
                ELSE
                    v_next_seek := lower(v_current.name);
                END IF;

                EXIT WHEN v_count >= v_limit;
            END LOOP;
        END IF;
    END LOOP;
END;
$_$;


--
-- Name: search_by_timestamp(text, text, integer, integer, text, text, text, text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.search_by_timestamp(p_prefix text, p_bucket_id text, p_limit integer, p_level integer, p_start_after text, p_sort_order text, p_sort_column text, p_sort_column_after text) RETURNS TABLE(key text, name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    v_cursor_op text;
    v_query text;
    v_prefix text;
BEGIN
    v_prefix := coalesce(p_prefix, '');

    IF p_sort_order = 'asc' THEN
        v_cursor_op := '>';
    ELSE
        v_cursor_op := '<';
    END IF;

    v_query := format($sql$
        WITH raw_objects AS (
            SELECT
                o.name AS obj_name,
                o.id AS obj_id,
                o.updated_at AS obj_updated_at,
                o.created_at AS obj_created_at,
                o.last_accessed_at AS obj_last_accessed_at,
                o.metadata AS obj_metadata,
                storage.get_common_prefix(o.name, $1, '/') AS common_prefix
            FROM storage.objects o
            WHERE o.bucket_id = $2
              AND o.name COLLATE "C" LIKE $1 || '%%'
        ),
        -- Aggregate common prefixes (folders)
        -- Both created_at and updated_at use MIN(obj_created_at) to match the old prefixes table behavior
        aggregated_prefixes AS (
            SELECT
                rtrim(common_prefix, '/') AS name,
                NULL::uuid AS id,
                MIN(obj_created_at) AS updated_at,
                MIN(obj_created_at) AS created_at,
                NULL::timestamptz AS last_accessed_at,
                NULL::jsonb AS metadata,
                TRUE AS is_prefix
            FROM raw_objects
            WHERE common_prefix IS NOT NULL
            GROUP BY common_prefix
        ),
        leaf_objects AS (
            SELECT
                obj_name AS name,
                obj_id AS id,
                obj_updated_at AS updated_at,
                obj_created_at AS created_at,
                obj_last_accessed_at AS last_accessed_at,
                obj_metadata AS metadata,
                FALSE AS is_prefix
            FROM raw_objects
            WHERE common_prefix IS NULL
        ),
        combined AS (
            SELECT * FROM aggregated_prefixes
            UNION ALL
            SELECT * FROM leaf_objects
        ),
        filtered AS (
            SELECT *
            FROM combined
            WHERE (
                $5 = ''
                OR ROW(
                    date_trunc('milliseconds', %I),
                    name COLLATE "C"
                ) %s ROW(
                    COALESCE(NULLIF($6, '')::timestamptz, 'epoch'::timestamptz),
                    $5
                )
            )
        )
        SELECT
            split_part(name, '/', $3) AS key,
            name,
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
        FROM filtered
        ORDER BY
            COALESCE(date_trunc('milliseconds', %I), 'epoch'::timestamptz) %s,
            name COLLATE "C" %s
        LIMIT $4
    $sql$,
        p_sort_column,
        v_cursor_op,
        p_sort_column,
        p_sort_order,
        p_sort_order
    );

    RETURN QUERY EXECUTE v_query
    USING v_prefix, p_bucket_id, p_level, p_limit, p_start_after, p_sort_column_after;
END;
$_$;


--
-- Name: search_v2(text, text, integer, integer, text, text, text, text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer DEFAULT 100, levels integer DEFAULT 1, start_after text DEFAULT ''::text, sort_order text DEFAULT 'asc'::text, sort_column text DEFAULT 'name'::text, sort_column_after text DEFAULT ''::text) RETURNS TABLE(key text, name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $$
DECLARE
    v_sort_col text;
    v_sort_ord text;
    v_limit int;
BEGIN
    -- Cap limit to maximum of 1500 records
    v_limit := LEAST(coalesce(limits, 100), 1500);

    -- Validate and normalize sort_order
    v_sort_ord := lower(coalesce(sort_order, 'asc'));
    IF v_sort_ord NOT IN ('asc', 'desc') THEN
        v_sort_ord := 'asc';
    END IF;

    -- Validate and normalize sort_column
    v_sort_col := lower(coalesce(sort_column, 'name'));
    IF v_sort_col NOT IN ('name', 'updated_at', 'created_at') THEN
        v_sort_col := 'name';
    END IF;

    -- Route to appropriate implementation
    IF v_sort_col = 'name' THEN
        -- Use list_objects_with_delimiter for name sorting (most efficient: O(k * log n))
        RETURN QUERY
        SELECT
            split_part(l.name, '/', levels) AS key,
            l.name AS name,
            l.id,
            l.updated_at,
            l.created_at,
            l.last_accessed_at,
            l.metadata
        FROM storage.list_objects_with_delimiter(
            bucket_name,
            coalesce(prefix, ''),
            '/',
            v_limit,
            start_after,
            '',
            v_sort_ord
        ) l;
    ELSE
        -- Use aggregation approach for timestamp sorting
        -- Not efficient for large datasets but supports correct pagination
        RETURN QUERY SELECT * FROM storage.search_by_timestamp(
            prefix, bucket_name, v_limit, levels, start_after,
            v_sort_ord, v_sort_col, sort_column_after
        );
    END IF;
END;
$$;


--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$$;


--
-- Name: http_request(); Type: FUNCTION; Schema: supabase_functions; Owner: -
--

CREATE FUNCTION supabase_functions.http_request() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'supabase_functions'
    AS $$
  DECLARE
    request_id bigint;
    payload jsonb;
    url text := TG_ARGV[0]::text;
    method text := TG_ARGV[1]::text;
    headers jsonb DEFAULT '{}'::jsonb;
    params jsonb DEFAULT '{}'::jsonb;
    timeout_ms integer DEFAULT 1000;
  BEGIN
    IF url IS NULL OR url = 'null' THEN
      RAISE EXCEPTION 'url argument is missing';
    END IF;

    IF method IS NULL OR method = 'null' THEN
      RAISE EXCEPTION 'method argument is missing';
    END IF;

    IF TG_ARGV[2] IS NULL OR TG_ARGV[2] = 'null' THEN
      headers = '{"Content-Type": "application/json"}'::jsonb;
    ELSE
      headers = TG_ARGV[2]::jsonb;
    END IF;

    IF TG_ARGV[3] IS NULL OR TG_ARGV[3] = 'null' THEN
      params = '{}'::jsonb;
    ELSE
      params = TG_ARGV[3]::jsonb;
    END IF;

    IF TG_ARGV[4] IS NULL OR TG_ARGV[4] = 'null' THEN
      timeout_ms = 1000;
    ELSE
      timeout_ms = TG_ARGV[4]::integer;
    END IF;

    CASE
      WHEN method = 'GET' THEN
        SELECT http_get INTO request_id FROM net.http_get(
          url,
          params,
          headers,
          timeout_ms
        );
      WHEN method = 'POST' THEN
        payload = jsonb_build_object(
          'old_record', OLD,
          'record', NEW,
          'type', TG_OP,
          'table', TG_TABLE_NAME,
          'schema', TG_TABLE_SCHEMA
        );

        SELECT http_post INTO request_id FROM net.http_post(
          url,
          payload,
          params,
          headers,
          timeout_ms
        );
      ELSE
        RAISE EXCEPTION 'method argument % is invalid', method;
    END CASE;

    INSERT INTO supabase_functions.hooks
      (hook_table_id, hook_name, request_id)
    VALUES
      (TG_RELID, TG_NAME, request_id);

    RETURN NEW;
  END
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: extensions; Type: TABLE; Schema: _realtime; Owner: -
--

CREATE TABLE _realtime.extensions (
    id uuid NOT NULL,
    type text,
    settings jsonb,
    tenant_external_id text,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


--
-- Name: schema_migrations; Type: TABLE; Schema: _realtime; Owner: -
--

CREATE TABLE _realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


--
-- Name: tenants; Type: TABLE; Schema: _realtime; Owner: -
--

CREATE TABLE _realtime.tenants (
    id uuid NOT NULL,
    name text,
    external_id text,
    jwt_secret text,
    max_concurrent_users integer DEFAULT 200 NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    max_events_per_second integer DEFAULT 100 NOT NULL,
    postgres_cdc_default text DEFAULT 'postgres_cdc_rls'::text,
    max_bytes_per_second integer DEFAULT 100000 NOT NULL,
    max_channels_per_client integer DEFAULT 100 NOT NULL,
    max_joins_per_second integer DEFAULT 500 NOT NULL,
    suspend boolean DEFAULT false,
    jwt_jwks jsonb,
    notify_private_alpha boolean DEFAULT false,
    private_only boolean DEFAULT false NOT NULL,
    migrations_ran integer DEFAULT 0,
    broadcast_adapter character varying(255) DEFAULT 'gen_rpc'::character varying,
    max_presence_events_per_second integer DEFAULT 1000,
    max_payload_size_in_kb integer DEFAULT 3000,
    CONSTRAINT jwt_secret_or_jwt_jwks_required CHECK (((jwt_secret IS NOT NULL) OR (jwt_jwks IS NOT NULL)))
);


--
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.audit_log_entries (
    instance_id uuid,
    id uuid NOT NULL,
    payload json,
    created_at timestamp with time zone,
    ip_address character varying(64) DEFAULT ''::character varying NOT NULL
);


--
-- Name: TABLE audit_log_entries; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.audit_log_entries IS 'Auth: Audit trail for user actions.';


--
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.flow_state (
    id uuid NOT NULL,
    user_id uuid,
    auth_code text,
    code_challenge_method auth.code_challenge_method,
    code_challenge text,
    provider_type text NOT NULL,
    provider_access_token text,
    provider_refresh_token text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    authentication_method text NOT NULL,
    auth_code_issued_at timestamp with time zone,
    invite_token text,
    referrer text,
    oauth_client_state_id uuid,
    linking_target_id uuid,
    email_optional boolean DEFAULT false NOT NULL
);


--
-- Name: TABLE flow_state; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.flow_state IS 'Stores metadata for all OAuth/SSO login flows';


--
-- Name: identities; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.identities (
    provider_id text NOT NULL,
    user_id uuid NOT NULL,
    identity_data jsonb NOT NULL,
    provider text NOT NULL,
    last_sign_in_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    email text GENERATED ALWAYS AS (lower((identity_data ->> 'email'::text))) STORED,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


--
-- Name: TABLE identities; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.identities IS 'Auth: Stores identities associated to a user.';


--
-- Name: COLUMN identities.email; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON COLUMN auth.identities.email IS 'Auth: Email is a generated column that references the optional email property in the identity_data';


--
-- Name: instances; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.instances (
    id uuid NOT NULL,
    uuid uuid,
    raw_base_config text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: TABLE instances; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.instances IS 'Auth: Manages users across multiple sites.';


--
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.mfa_amr_claims (
    session_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    authentication_method text NOT NULL,
    id uuid NOT NULL
);


--
-- Name: TABLE mfa_amr_claims; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.mfa_amr_claims IS 'auth: stores authenticator method reference claims for multi factor authentication';


--
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.mfa_challenges (
    id uuid NOT NULL,
    factor_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    verified_at timestamp with time zone,
    ip_address inet NOT NULL,
    otp_code text,
    web_authn_session_data jsonb
);


--
-- Name: TABLE mfa_challenges; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.mfa_challenges IS 'auth: stores metadata about challenge requests made';


--
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.mfa_factors (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    friendly_name text,
    factor_type auth.factor_type NOT NULL,
    status auth.factor_status NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    secret text,
    phone text,
    last_challenged_at timestamp with time zone,
    web_authn_credential jsonb,
    web_authn_aaguid uuid,
    last_webauthn_challenge_data jsonb
);


--
-- Name: TABLE mfa_factors; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.mfa_factors IS 'auth: stores metadata about factors';


--
-- Name: COLUMN mfa_factors.last_webauthn_challenge_data; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON COLUMN auth.mfa_factors.last_webauthn_challenge_data IS 'Stores the latest WebAuthn challenge data including attestation/assertion for customer verification';


--
-- Name: oauth_authorizations; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.oauth_authorizations (
    id uuid NOT NULL,
    authorization_id text NOT NULL,
    client_id uuid NOT NULL,
    user_id uuid,
    redirect_uri text NOT NULL,
    scope text NOT NULL,
    state text,
    resource text,
    code_challenge text,
    code_challenge_method auth.code_challenge_method,
    response_type auth.oauth_response_type DEFAULT 'code'::auth.oauth_response_type NOT NULL,
    status auth.oauth_authorization_status DEFAULT 'pending'::auth.oauth_authorization_status NOT NULL,
    authorization_code text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    expires_at timestamp with time zone DEFAULT (now() + '00:03:00'::interval) NOT NULL,
    approved_at timestamp with time zone,
    nonce text,
    CONSTRAINT oauth_authorizations_authorization_code_length CHECK ((char_length(authorization_code) <= 255)),
    CONSTRAINT oauth_authorizations_code_challenge_length CHECK ((char_length(code_challenge) <= 128)),
    CONSTRAINT oauth_authorizations_expires_at_future CHECK ((expires_at > created_at)),
    CONSTRAINT oauth_authorizations_nonce_length CHECK ((char_length(nonce) <= 255)),
    CONSTRAINT oauth_authorizations_redirect_uri_length CHECK ((char_length(redirect_uri) <= 2048)),
    CONSTRAINT oauth_authorizations_resource_length CHECK ((char_length(resource) <= 2048)),
    CONSTRAINT oauth_authorizations_scope_length CHECK ((char_length(scope) <= 4096)),
    CONSTRAINT oauth_authorizations_state_length CHECK ((char_length(state) <= 4096))
);


--
-- Name: oauth_client_states; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.oauth_client_states (
    id uuid NOT NULL,
    provider_type text NOT NULL,
    code_verifier text,
    created_at timestamp with time zone NOT NULL
);


--
-- Name: TABLE oauth_client_states; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.oauth_client_states IS 'Stores OAuth states for third-party provider authentication flows where Supabase acts as the OAuth client.';


--
-- Name: oauth_clients; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.oauth_clients (
    id uuid NOT NULL,
    client_secret_hash text,
    registration_type auth.oauth_registration_type NOT NULL,
    redirect_uris text NOT NULL,
    grant_types text NOT NULL,
    client_name text,
    client_uri text,
    logo_uri text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    client_type auth.oauth_client_type DEFAULT 'confidential'::auth.oauth_client_type NOT NULL,
    token_endpoint_auth_method text NOT NULL,
    CONSTRAINT oauth_clients_client_name_length CHECK ((char_length(client_name) <= 1024)),
    CONSTRAINT oauth_clients_client_uri_length CHECK ((char_length(client_uri) <= 2048)),
    CONSTRAINT oauth_clients_logo_uri_length CHECK ((char_length(logo_uri) <= 2048)),
    CONSTRAINT oauth_clients_token_endpoint_auth_method_check CHECK ((token_endpoint_auth_method = ANY (ARRAY['client_secret_basic'::text, 'client_secret_post'::text, 'none'::text])))
);


--
-- Name: oauth_consents; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.oauth_consents (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    client_id uuid NOT NULL,
    scopes text NOT NULL,
    granted_at timestamp with time zone DEFAULT now() NOT NULL,
    revoked_at timestamp with time zone,
    CONSTRAINT oauth_consents_revoked_after_granted CHECK (((revoked_at IS NULL) OR (revoked_at >= granted_at))),
    CONSTRAINT oauth_consents_scopes_length CHECK ((char_length(scopes) <= 2048)),
    CONSTRAINT oauth_consents_scopes_not_empty CHECK ((char_length(TRIM(BOTH FROM scopes)) > 0))
);


--
-- Name: one_time_tokens; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.one_time_tokens (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    token_type auth.one_time_token_type NOT NULL,
    token_hash text NOT NULL,
    relates_to text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT one_time_tokens_token_hash_check CHECK ((char_length(token_hash) > 0))
);


--
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.refresh_tokens (
    instance_id uuid,
    id bigint NOT NULL,
    token character varying(255),
    user_id character varying(255),
    revoked boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    parent character varying(255),
    session_id uuid
);


--
-- Name: TABLE refresh_tokens; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.refresh_tokens IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: -
--

CREATE SEQUENCE auth.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: -
--

ALTER SEQUENCE auth.refresh_tokens_id_seq OWNED BY auth.refresh_tokens.id;


--
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.saml_providers (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    entity_id text NOT NULL,
    metadata_xml text NOT NULL,
    metadata_url text,
    attribute_mapping jsonb,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name_id_format text,
    CONSTRAINT "entity_id not empty" CHECK ((char_length(entity_id) > 0)),
    CONSTRAINT "metadata_url not empty" CHECK (((metadata_url = NULL::text) OR (char_length(metadata_url) > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK ((char_length(metadata_xml) > 0))
);


--
-- Name: TABLE saml_providers; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.saml_providers IS 'Auth: Manages SAML Identity Provider connections.';


--
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.saml_relay_states (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    request_id text NOT NULL,
    for_email text,
    redirect_to text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    flow_state_id uuid,
    CONSTRAINT "request_id not empty" CHECK ((char_length(request_id) > 0))
);


--
-- Name: TABLE saml_relay_states; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.saml_relay_states IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';


--
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: TABLE schema_migrations; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.schema_migrations IS 'Auth: Manages updates to the auth system.';


--
-- Name: sessions; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.sessions (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    factor_id uuid,
    aal auth.aal_level,
    not_after timestamp with time zone,
    refreshed_at timestamp without time zone,
    user_agent text,
    ip inet,
    tag text,
    oauth_client_id uuid,
    refresh_token_hmac_key text,
    refresh_token_counter bigint,
    scopes text,
    CONSTRAINT sessions_scopes_length CHECK ((char_length(scopes) <= 4096))
);


--
-- Name: TABLE sessions; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.sessions IS 'Auth: Stores session data associated to a user.';


--
-- Name: COLUMN sessions.not_after; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON COLUMN auth.sessions.not_after IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';


--
-- Name: COLUMN sessions.refresh_token_hmac_key; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON COLUMN auth.sessions.refresh_token_hmac_key IS 'Holds a HMAC-SHA256 key used to sign refresh tokens for this session.';


--
-- Name: COLUMN sessions.refresh_token_counter; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON COLUMN auth.sessions.refresh_token_counter IS 'Holds the ID (counter) of the last issued refresh token.';


--
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.sso_domains (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    domain text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK ((char_length(domain) > 0))
);


--
-- Name: TABLE sso_domains; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.sso_domains IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';


--
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.sso_providers (
    id uuid NOT NULL,
    resource_id text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    disabled boolean,
    CONSTRAINT "resource_id not empty" CHECK (((resource_id = NULL::text) OR (char_length(resource_id) > 0)))
);


--
-- Name: TABLE sso_providers; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.sso_providers IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';


--
-- Name: COLUMN sso_providers.resource_id; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON COLUMN auth.sso_providers.resource_id IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';


--
-- Name: users; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.users (
    instance_id uuid,
    id uuid NOT NULL,
    aud character varying(255),
    role character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    email_confirmed_at timestamp with time zone,
    invited_at timestamp with time zone,
    confirmation_token character varying(255),
    confirmation_sent_at timestamp with time zone,
    recovery_token character varying(255),
    recovery_sent_at timestamp with time zone,
    email_change_token_new character varying(255),
    email_change character varying(255),
    email_change_sent_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    raw_app_meta_data jsonb,
    raw_user_meta_data jsonb,
    is_super_admin boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    phone text DEFAULT NULL::character varying,
    phone_confirmed_at timestamp with time zone,
    phone_change text DEFAULT ''::character varying,
    phone_change_token character varying(255) DEFAULT ''::character varying,
    phone_change_sent_at timestamp with time zone,
    confirmed_at timestamp with time zone GENERATED ALWAYS AS (LEAST(email_confirmed_at, phone_confirmed_at)) STORED,
    email_change_token_current character varying(255) DEFAULT ''::character varying,
    email_change_confirm_status smallint DEFAULT 0,
    banned_until timestamp with time zone,
    reauthentication_token character varying(255) DEFAULT ''::character varying,
    reauthentication_sent_at timestamp with time zone,
    is_sso_user boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    is_anonymous boolean DEFAULT false NOT NULL,
    CONSTRAINT users_email_change_confirm_status_check CHECK (((email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)))
);


--
-- Name: TABLE users; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';


--
-- Name: COLUMN users.is_sso_user; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';


--
-- Name: archive; Type: TABLE; Schema: pgboss; Owner: -
--

CREATE TABLE pgboss.archive (
    id uuid NOT NULL,
    name text NOT NULL,
    priority integer NOT NULL,
    data jsonb,
    state pgboss.job_state NOT NULL,
    retrylimit integer NOT NULL,
    retrycount integer NOT NULL,
    retrydelay integer NOT NULL,
    retrybackoff boolean NOT NULL,
    startafter timestamp with time zone NOT NULL,
    startedon timestamp with time zone,
    singletonkey text,
    singletonon timestamp without time zone,
    expirein interval NOT NULL,
    createdon timestamp with time zone NOT NULL,
    completedon timestamp with time zone,
    keepuntil timestamp with time zone NOT NULL,
    on_complete boolean NOT NULL,
    output jsonb,
    archivedon timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: job; Type: TABLE; Schema: pgboss; Owner: -
--

CREATE TABLE pgboss.job (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    priority integer DEFAULT 0 NOT NULL,
    data jsonb,
    state pgboss.job_state DEFAULT 'created'::pgboss.job_state NOT NULL,
    retrylimit integer DEFAULT 0 NOT NULL,
    retrycount integer DEFAULT 0 NOT NULL,
    retrydelay integer DEFAULT 0 NOT NULL,
    retrybackoff boolean DEFAULT false NOT NULL,
    startafter timestamp with time zone DEFAULT now() NOT NULL,
    startedon timestamp with time zone,
    singletonkey text,
    singletonon timestamp without time zone,
    expirein interval DEFAULT '00:15:00'::interval NOT NULL,
    createdon timestamp with time zone DEFAULT now() NOT NULL,
    completedon timestamp with time zone,
    keepuntil timestamp with time zone DEFAULT (now() + '14 days'::interval) NOT NULL,
    on_complete boolean DEFAULT false NOT NULL,
    output jsonb
);


--
-- Name: schedule; Type: TABLE; Schema: pgboss; Owner: -
--

CREATE TABLE pgboss.schedule (
    name text NOT NULL,
    cron text NOT NULL,
    timezone text,
    data jsonb,
    options jsonb,
    created_on timestamp with time zone DEFAULT now() NOT NULL,
    updated_on timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: subscription; Type: TABLE; Schema: pgboss; Owner: -
--

CREATE TABLE pgboss.subscription (
    event text NOT NULL,
    name text NOT NULL,
    created_on timestamp with time zone DEFAULT now() NOT NULL,
    updated_on timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: version; Type: TABLE; Schema: pgboss; Owner: -
--

CREATE TABLE pgboss.version (
    version integer NOT NULL,
    maintained_on timestamp with time zone,
    cron_on timestamp with time zone
);


--
-- Name: Announcement; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Announcement" (
    id text NOT NULL,
    name text NOT NULL,
    content text NOT NULL,
    link text,
    "linkText" text,
    published boolean DEFAULT false NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: Asset; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Asset" (
    id text NOT NULL,
    title text NOT NULL,
    description text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "userId" text NOT NULL,
    "mainImage" text,
    "mainImageExpiration" timestamp(3) without time zone,
    "categoryId" text,
    "locationId" text,
    "organizationId" text NOT NULL,
    status public."AssetStatus" DEFAULT 'AVAILABLE'::public."AssetStatus" NOT NULL,
    value double precision,
    "availableToBook" boolean DEFAULT true NOT NULL,
    "kitId" text,
    "thumbnailImage" text,
    "sequentialId" text,
    "assetModelId" text,
    "consumptionType" public."ConsumptionType",
    "minQuantity" integer,
    quantity integer,
    type public."AssetType" DEFAULT 'INDIVIDUAL'::public."AssetType" NOT NULL,
    "unitOfMeasure" public."UnitOfMeasure"
);


--
-- Name: AssetCustomFieldValue; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."AssetCustomFieldValue" (
    id text NOT NULL,
    "assetId" text NOT NULL,
    "customFieldId" text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    value jsonb NOT NULL,
    CONSTRAINT ensure_value_structure_and_types CHECK ((((value ->> 'raw'::text) IS NOT NULL) AND ((((value ->> 'valueText'::text) IS NOT NULL) AND (jsonb_typeof((value -> 'valueText'::text)) = 'string'::text)) OR (((value ->> 'valueMultiLineText'::text) IS NOT NULL) AND (jsonb_typeof((value -> 'valueMultiLineText'::text)) = 'string'::text)) OR (((value ->> 'valueBoolean'::text) IS NOT NULL) AND (jsonb_typeof((value -> 'valueBoolean'::text)) = 'boolean'::text)) OR (((value ->> 'valueOption'::text) IS NOT NULL) AND (jsonb_typeof((value -> 'valueOption'::text)) = 'string'::text)) OR (((value ->> 'valueDate'::text) IS NOT NULL) AND ((value ->> 'valueDate'::text) ~ '^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(\.\d+)?Z?$'::text)))))
);


--
-- Name: AssetFilterPreset; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."AssetFilterPreset" (
    id text NOT NULL,
    "organizationId" text NOT NULL,
    "ownerId" text NOT NULL,
    name text NOT NULL,
    query text NOT NULL,
    starred boolean DEFAULT false NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: AssetIndexSettings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."AssetIndexSettings" (
    id text NOT NULL,
    "userId" text NOT NULL,
    "organizationId" text NOT NULL,
    mode public."AssetIndexMode" DEFAULT 'SIMPLE'::public."AssetIndexMode" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    columns jsonb DEFAULT '[{"name": "id", "visible": true, "position": 0}, {"name": "status", "visible": true, "position": 1}, {"name": "description", "visible": true, "position": 2}, {"name": "valuation", "visible": true, "position": 3}, {"name": "createdAt", "visible": true, "position": 4}, {"name": "category", "visible": true, "position": 5}, {"name": "tags", "visible": true, "position": 6}, {"name": "location", "visible": true, "position": 7}, {"name": "kit", "visible": true, "position": 8}, {"name": "custody", "visible": true, "position": 9}]'::jsonb NOT NULL,
    "freezeColumn" boolean DEFAULT true NOT NULL,
    "showAssetImage" boolean DEFAULT true NOT NULL
);


--
-- Name: AssetModel; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."AssetModel" (
    id text NOT NULL,
    name text NOT NULL,
    description text,
    image text,
    "imageExpiration" timestamp(3) without time zone,
    "defaultCategoryId" text,
    "defaultValuation" double precision,
    "organizationId" text NOT NULL,
    "userId" text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: AssetReminder; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."AssetReminder" (
    id text NOT NULL,
    name text NOT NULL,
    message text NOT NULL,
    "alertDateTime" timestamp(3) without time zone NOT NULL,
    "assetId" text NOT NULL,
    "createdById" text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "organizationId" text NOT NULL,
    "activeSchedulerReference" text
);


--
-- Name: AuditAsset; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."AuditAsset" (
    id text NOT NULL,
    "auditSessionId" text NOT NULL,
    "assetId" text NOT NULL,
    expected boolean DEFAULT true NOT NULL,
    status public."AuditAssetStatus" DEFAULT 'PENDING'::public."AuditAssetStatus" NOT NULL,
    "scannedById" text,
    "scannedAt" timestamp(3) without time zone,
    metadata jsonb,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: AuditAssignment; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."AuditAssignment" (
    id text NOT NULL,
    "auditSessionId" text NOT NULL,
    "userId" text NOT NULL,
    role public."AuditAssignmentRole",
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: AuditImage; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."AuditImage" (
    id text NOT NULL,
    "imageUrl" text NOT NULL,
    "thumbnailUrl" text,
    description text,
    "auditSessionId" text NOT NULL,
    "auditAssetId" text,
    "uploadedById" text,
    "organizationId" text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: AuditNote; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."AuditNote" (
    id text NOT NULL,
    content text NOT NULL,
    type public."NoteType" DEFAULT 'COMMENT'::public."NoteType" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "userId" text,
    "auditSessionId" text NOT NULL,
    "auditAssetId" text
);


--
-- Name: AuditScan; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."AuditScan" (
    id text NOT NULL,
    "auditSessionId" text NOT NULL,
    "auditAssetId" text,
    "assetId" text,
    "scannedById" text,
    code text,
    metadata jsonb,
    "scannedAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: AuditSession; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."AuditSession" (
    id text NOT NULL,
    name text NOT NULL,
    description text,
    "targetId" text,
    status public."AuditStatus" DEFAULT 'PENDING'::public."AuditStatus" NOT NULL,
    "scopeMeta" jsonb,
    "expectedAssetCount" integer DEFAULT 0 NOT NULL,
    "foundAssetCount" integer DEFAULT 0 NOT NULL,
    "missingAssetCount" integer DEFAULT 0 NOT NULL,
    "unexpectedAssetCount" integer DEFAULT 0 NOT NULL,
    "startedAt" timestamp(3) without time zone,
    "completedAt" timestamp(3) without time zone,
    "cancelledAt" timestamp(3) without time zone,
    "createdById" text NOT NULL,
    "organizationId" text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "dueDate" timestamp(3) without time zone,
    "activeSchedulerReference" text
);


--
-- Name: Barcode; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Barcode" (
    id text NOT NULL,
    value text NOT NULL,
    type public."BarcodeType" DEFAULT 'Code128'::public."BarcodeType" NOT NULL,
    "assetId" text,
    "kitId" text,
    "organizationId" text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: Booking; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Booking" (
    id text NOT NULL,
    name text NOT NULL,
    status public."BookingStatus" DEFAULT 'DRAFT'::public."BookingStatus" NOT NULL,
    "creatorId" text NOT NULL,
    "organizationId" text NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) with time zone NOT NULL,
    "from" timestamp(3) with time zone NOT NULL,
    "to" timestamp(3) with time zone NOT NULL,
    "custodianTeamMemberId" text,
    "custodianUserId" text,
    "activeSchedulerReference" text,
    description text DEFAULT ''::text,
    "originalFrom" timestamp(3) with time zone,
    "originalTo" timestamp(3) with time zone,
    "cancellationReason" text,
    "autoArchivedAt" timestamp(3) with time zone
);


--
-- Name: BookingAsset; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."BookingAsset" (
    id text NOT NULL,
    "bookingId" text NOT NULL,
    "assetId" text NOT NULL,
    quantity integer DEFAULT 1 NOT NULL
);


--
-- Name: BookingNote; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."BookingNote" (
    id text NOT NULL,
    content text NOT NULL,
    type public."NoteType" DEFAULT 'COMMENT'::public."NoteType" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "userId" text,
    "bookingId" text NOT NULL
);


--
-- Name: BookingSettings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."BookingSettings" (
    id text NOT NULL,
    "bufferStartTime" integer DEFAULT 0 NOT NULL,
    "organizationId" text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "tagsRequired" boolean DEFAULT false NOT NULL,
    "maxBookingLength" integer,
    "maxBookingLengthSkipClosedDays" boolean DEFAULT false NOT NULL,
    "requireExplicitCheckinForAdmin" boolean DEFAULT false NOT NULL,
    "requireExplicitCheckinForSelfService" boolean DEFAULT false NOT NULL,
    "autoArchiveBookings" boolean DEFAULT false NOT NULL,
    "autoArchiveDays" integer DEFAULT 2 NOT NULL,
    "notifyAdminsOnNewBooking" boolean DEFAULT true NOT NULL,
    "notifyBookingCreator" boolean DEFAULT true NOT NULL
);


--
-- Name: Category; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Category" (
    id text NOT NULL,
    name text NOT NULL,
    description text,
    color text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "userId" text NOT NULL,
    "organizationId" text NOT NULL
);


--
-- Name: ConsumptionLog; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."ConsumptionLog" (
    id text NOT NULL,
    "assetId" text NOT NULL,
    category public."ConsumptionCategory" NOT NULL,
    quantity integer NOT NULL,
    note text,
    "userId" text NOT NULL,
    "bookingId" text,
    "custodianId" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: Custody; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Custody" (
    id text NOT NULL,
    "teamMemberId" text NOT NULL,
    "assetId" text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: CustomField; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."CustomField" (
    id text NOT NULL,
    name text NOT NULL,
    "helpText" text,
    required boolean DEFAULT false NOT NULL,
    type public."CustomFieldType" DEFAULT 'TEXT'::public."CustomFieldType" NOT NULL,
    "organizationId" text NOT NULL,
    "userId" text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    active boolean DEFAULT true NOT NULL,
    options text[],
    "deletedAt" timestamp(3) without time zone
);


--
-- Name: CustomTierLimit; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."CustomTierLimit" (
    id text NOT NULL,
    "userId" text,
    "canImportAssets" boolean DEFAULT true NOT NULL,
    "canExportAssets" boolean DEFAULT true NOT NULL,
    "maxCustomFields" integer DEFAULT 1000 NOT NULL,
    "maxOrganizations" integer DEFAULT 1 NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "canImportNRM" boolean DEFAULT true NOT NULL,
    "isEnterprise" boolean DEFAULT false NOT NULL,
    "canHideShelfBranding" boolean DEFAULT true NOT NULL
);


--
-- Name: Image; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Image" (
    id text NOT NULL,
    "contentType" text NOT NULL,
    "altText" text,
    blob bytea NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "userId" text NOT NULL,
    "ownerOrgId" text NOT NULL
);


--
-- Name: Invite; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Invite" (
    id text NOT NULL,
    "inviterId" text NOT NULL,
    "organizationId" text NOT NULL,
    "inviteeUserId" text,
    "teamMemberId" text NOT NULL,
    "inviteeEmail" text NOT NULL,
    status public."InviteStatuses" DEFAULT 'PENDING'::public."InviteStatuses" NOT NULL,
    "inviteCode" text NOT NULL,
    roles public."OrganizationRoles"[],
    "expiresAt" timestamp(3) without time zone NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "inviteMessage" character varying(1000)
);


--
-- Name: Kit; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Kit" (
    id text NOT NULL,
    name text NOT NULL,
    description text,
    status public."KitStatus" DEFAULT 'AVAILABLE'::public."KitStatus" NOT NULL,
    image text,
    "imageExpiration" timestamp(3) without time zone,
    "organizationId" text NOT NULL,
    "createdById" text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "categoryId" text,
    "locationId" text
);


--
-- Name: KitCustody; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."KitCustody" (
    id text NOT NULL,
    "custodianId" text NOT NULL,
    "kitId" text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: Location; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Location" (
    id text NOT NULL,
    name text NOT NULL,
    description text,
    address text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "userId" text NOT NULL,
    "imageId" text,
    "organizationId" text NOT NULL,
    "imageUrl" text,
    "thumbnailUrl" text,
    latitude double precision,
    longitude double precision,
    "parentId" text
);


--
-- Name: LocationNote; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."LocationNote" (
    id text NOT NULL,
    content text NOT NULL,
    type public."NoteType" DEFAULT 'COMMENT'::public."NoteType" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "userId" text,
    "locationId" text NOT NULL
);


--
-- Name: Note; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Note" (
    id text NOT NULL,
    content text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "userId" text,
    "assetId" text NOT NULL,
    type public."NoteType" DEFAULT 'COMMENT'::public."NoteType" NOT NULL
);


--
-- Name: Organization; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Organization" (
    id text NOT NULL,
    name text DEFAULT 'Personal'::text NOT NULL,
    type public."OrganizationType" DEFAULT 'PERSONAL'::public."OrganizationType" NOT NULL,
    "userId" text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "imageId" text,
    currency public."Currency" DEFAULT 'USD'::public."Currency" NOT NULL,
    "enabledSso" boolean DEFAULT false NOT NULL,
    "ssoDetailsId" text,
    "workspaceDisabled" boolean DEFAULT false NOT NULL,
    "baseUserCanSeeBookings" boolean DEFAULT false NOT NULL,
    "baseUserCanSeeCustody" boolean DEFAULT false NOT NULL,
    "selfServiceCanSeeBookings" boolean DEFAULT false NOT NULL,
    "selfServiceCanSeeCustody" boolean DEFAULT false NOT NULL,
    "barcodesEnabled" boolean DEFAULT false NOT NULL,
    "barcodesEnabledAt" timestamp(3) without time zone,
    "hasSequentialIdsMigrated" boolean DEFAULT false NOT NULL,
    "qrIdDisplayPreference" public."QrIdDisplayPreference" DEFAULT 'QR_ID'::public."QrIdDisplayPreference" NOT NULL,
    "showShelfBranding" boolean DEFAULT true NOT NULL,
    "auditsEnabled" boolean DEFAULT false NOT NULL,
    "auditsEnabledAt" timestamp(3) without time zone,
    "usedAuditTrial" boolean DEFAULT false NOT NULL,
    "customEmailFooter" character varying(500),
    "usedBarcodeTrial" boolean DEFAULT false NOT NULL
);


--
-- Name: PartialBookingCheckin; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."PartialBookingCheckin" (
    id text NOT NULL,
    "assetIds" text[],
    "checkinCount" integer NOT NULL,
    "checkinTimestamp" timestamp(3) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "bookingId" text NOT NULL,
    "checkedInById" text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: PrintBatch; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."PrintBatch" (
    id text NOT NULL,
    name text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    printed boolean DEFAULT false NOT NULL
);


--
-- Name: Qr; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Qr" (
    id text NOT NULL,
    version integer DEFAULT 0 NOT NULL,
    "errorCorrection" public."ErrorCorrection" DEFAULT 'L'::public."ErrorCorrection" NOT NULL,
    "userId" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "assetId" text,
    "organizationId" text,
    "batchId" text,
    "kitId" text
);


--
-- Name: ReportFound; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."ReportFound" (
    id text NOT NULL,
    content text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    email text NOT NULL,
    "assetId" text,
    "kitId" text
);


--
-- Name: Role; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Role" (
    id text NOT NULL,
    name public."Roles" DEFAULT 'USER'::public."Roles" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: RoleChangeLog; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."RoleChangeLog" (
    id text NOT NULL,
    "previousRole" public."OrganizationRoles" NOT NULL,
    "newRole" public."OrganizationRoles" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "userId" text NOT NULL,
    "changedById" text NOT NULL,
    "organizationId" text NOT NULL
);


--
-- Name: Scan; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Scan" (
    id text NOT NULL,
    latitude text,
    longitude text,
    "userAgent" text,
    "userId" text,
    "qrId" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "rawQrId" text NOT NULL,
    "manuallyGenerated" boolean DEFAULT false NOT NULL
);


--
-- Name: SsoDetails; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."SsoDetails" (
    id text NOT NULL,
    domain text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "adminGroupId" text,
    "selfServiceGroupId" text,
    "baseUserGroupId" text
);


--
-- Name: Tag; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Tag" (
    id text NOT NULL,
    name text NOT NULL,
    description text,
    "userId" text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "organizationId" text NOT NULL,
    "useFor" public."TagUseFor"[] DEFAULT ARRAY['ASSET'::public."TagUseFor"],
    color text
);


--
-- Name: TeamMember; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."TeamMember" (
    id text NOT NULL,
    name text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "userId" text,
    "deletedAt" timestamp(3) without time zone,
    "organizationId" text NOT NULL
);


--
-- Name: TeamMemberNote; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."TeamMemberNote" (
    id text NOT NULL,
    content text NOT NULL,
    type public."NoteType" DEFAULT 'COMMENT'::public."NoteType" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "userId" text,
    "teamMemberId" text NOT NULL,
    "organizationId" text NOT NULL
);


--
-- Name: Tier; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Tier" (
    id public."TierId" NOT NULL,
    name text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "tierLimitId" public."TierId"
);


--
-- Name: TierLimit; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."TierLimit" (
    id public."TierId" NOT NULL,
    "canImportAssets" boolean DEFAULT false NOT NULL,
    "canExportAssets" boolean DEFAULT false NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "maxCustomFields" integer DEFAULT 0 NOT NULL,
    "maxOrganizations" integer DEFAULT 1 NOT NULL,
    "canImportNRM" boolean DEFAULT false NOT NULL,
    "canHideShelfBranding" boolean DEFAULT false NOT NULL
);


--
-- Name: Update; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Update" (
    id text NOT NULL,
    title text NOT NULL,
    content text NOT NULL,
    url text,
    "publishDate" timestamp(3) without time zone NOT NULL,
    status public."UpdateStatus" DEFAULT 'DRAFT'::public."UpdateStatus" NOT NULL,
    "targetRoles" public."OrganizationRoles"[],
    "clickCount" integer DEFAULT 0 NOT NULL,
    "viewCount" integer DEFAULT 0 NOT NULL,
    "createdById" text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "imageUrl" text
);


--
-- Name: User; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."User" (
    id text NOT NULL,
    email text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "profilePicture" text,
    "firstName" text,
    "lastName" text,
    username text NOT NULL,
    onboarded boolean DEFAULT false NOT NULL,
    "customerId" text,
    "tierId" public."TierId" DEFAULT 'free'::public."TierId" NOT NULL,
    "usedFreeTrial" boolean DEFAULT false NOT NULL,
    sso boolean DEFAULT false NOT NULL,
    "createdWithInvite" boolean DEFAULT false NOT NULL,
    "deletedAt" timestamp(3) without time zone,
    "referralSource" text,
    "skipSubscriptionCheck" boolean DEFAULT false NOT NULL,
    "hasUnpaidInvoice" boolean DEFAULT false NOT NULL,
    "warnForNoPaymentMethod" boolean DEFAULT false NOT NULL,
    "lastSelectedOrganizationId" text,
    "displayName" text
);


--
-- Name: UserBusinessIntel; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."UserBusinessIntel" (
    id text NOT NULL,
    "howDidYouHearAboutUs" text,
    "jobTitle" text,
    "teamSize" text,
    "companyName" text,
    "primaryUseCase" text,
    "currentSolution" text,
    timeline text,
    "userId" text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: UserContact; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."UserContact" (
    id text NOT NULL,
    phone text,
    street text,
    city text,
    "stateProvince" text,
    "zipPostalCode" text,
    "countryRegion" text,
    "userId" text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: UserOrganization; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."UserOrganization" (
    id text NOT NULL,
    "userId" text NOT NULL,
    "organizationId" text NOT NULL,
    roles public."OrganizationRoles"[],
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: UserUpdateRead; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."UserUpdateRead" (
    id text NOT NULL,
    "userId" text NOT NULL,
    "updateId" text NOT NULL,
    "readAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: WorkingHours; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."WorkingHours" (
    id text NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    "weeklySchedule" jsonb DEFAULT '{"0": {"isOpen": false}, "1": {"isOpen": true, "openTime": "09:00", "closeTime": "17:00"}, "2": {"isOpen": true, "openTime": "09:00", "closeTime": "17:00"}, "3": {"isOpen": true, "openTime": "09:00", "closeTime": "17:00"}, "4": {"isOpen": true, "openTime": "09:00", "closeTime": "17:00"}, "5": {"isOpen": true, "openTime": "09:00", "closeTime": "17:00"}, "6": {"isOpen": false}}'::jsonb NOT NULL,
    "organizationId" text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: WorkingHoursOverride; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."WorkingHoursOverride" (
    id text NOT NULL,
    date date NOT NULL,
    "isOpen" boolean DEFAULT false NOT NULL,
    "openTime" text,
    "closeTime" text,
    reason text,
    "workingHoursId" text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: _AssetReminderToTeamMember; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."_AssetReminderToTeamMember" (
    "A" text NOT NULL,
    "B" text NOT NULL
);


--
-- Name: _AssetToBooking; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."_AssetToBooking" (
    "A" text NOT NULL,
    "B" text NOT NULL
);


--
-- Name: _AssetToTag; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."_AssetToTag" (
    "A" text NOT NULL,
    "B" text NOT NULL
);


--
-- Name: _BookingNotificationRecipients; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."_BookingNotificationRecipients" (
    "A" text NOT NULL,
    "B" text NOT NULL
);


--
-- Name: _BookingSettingsAlwaysNotify; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."_BookingSettingsAlwaysNotify" (
    "A" text NOT NULL,
    "B" text NOT NULL
);


--
-- Name: _BookingToTag; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."_BookingToTag" (
    "A" text NOT NULL,
    "B" text NOT NULL
);


--
-- Name: _CategoryToCustomField; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."_CategoryToCustomField" (
    "A" text NOT NULL,
    "B" text NOT NULL
);


--
-- Name: _RoleToUser; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."_RoleToUser" (
    "A" text NOT NULL,
    "B" text NOT NULL
);


--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


--
-- Name: org_org-admin-personal_asset_sequence; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."org_org-admin-personal_asset_sequence"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: messages; Type: TABLE; Schema: realtime; Owner: -
--

CREATE TABLE realtime.messages (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
)
PARTITION BY RANGE (inserted_at);


--
-- Name: messages_2026_04_01; Type: TABLE; Schema: realtime; Owner: -
--

CREATE TABLE realtime.messages_2026_04_01 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


--
-- Name: messages_2026_04_02; Type: TABLE; Schema: realtime; Owner: -
--

CREATE TABLE realtime.messages_2026_04_02 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


--
-- Name: messages_2026_04_03; Type: TABLE; Schema: realtime; Owner: -
--

CREATE TABLE realtime.messages_2026_04_03 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


--
-- Name: messages_2026_04_04; Type: TABLE; Schema: realtime; Owner: -
--

CREATE TABLE realtime.messages_2026_04_04 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


--
-- Name: messages_2026_04_05; Type: TABLE; Schema: realtime; Owner: -
--

CREATE TABLE realtime.messages_2026_04_05 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


--
-- Name: messages_2026_04_06; Type: TABLE; Schema: realtime; Owner: -
--

CREATE TABLE realtime.messages_2026_04_06 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


--
-- Name: schema_migrations; Type: TABLE; Schema: realtime; Owner: -
--

CREATE TABLE realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


--
-- Name: subscription; Type: TABLE; Schema: realtime; Owner: -
--

CREATE TABLE realtime.subscription (
    id bigint NOT NULL,
    subscription_id uuid NOT NULL,
    entity regclass NOT NULL,
    filters realtime.user_defined_filter[] DEFAULT '{}'::realtime.user_defined_filter[] NOT NULL,
    claims jsonb NOT NULL,
    claims_role regrole GENERATED ALWAYS AS (realtime.to_regrole((claims ->> 'role'::text))) STORED NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


--
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: realtime; Owner: -
--

ALTER TABLE realtime.subscription ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME realtime.subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: buckets; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.buckets (
    id text NOT NULL,
    name text NOT NULL,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    public boolean DEFAULT false,
    avif_autodetection boolean DEFAULT false,
    file_size_limit bigint,
    allowed_mime_types text[],
    owner_id text,
    type storage.buckettype DEFAULT 'STANDARD'::storage.buckettype NOT NULL
);


--
-- Name: COLUMN buckets.owner; Type: COMMENT; Schema: storage; Owner: -
--

COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: buckets_analytics; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.buckets_analytics (
    name text NOT NULL,
    type storage.buckettype DEFAULT 'ANALYTICS'::storage.buckettype NOT NULL,
    format text DEFAULT 'ICEBERG'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: buckets_vectors; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.buckets_vectors (
    id text NOT NULL,
    type storage.buckettype DEFAULT 'VECTOR'::storage.buckettype NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: iceberg_namespaces; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.iceberg_namespaces (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_name text NOT NULL,
    name text NOT NULL COLLATE pg_catalog."C",
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    catalog_id uuid NOT NULL
);


--
-- Name: iceberg_tables; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.iceberg_tables (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    namespace_id uuid NOT NULL,
    bucket_name text NOT NULL,
    name text NOT NULL COLLATE pg_catalog."C",
    location text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    remote_table_id text,
    shard_key text,
    shard_id text,
    catalog_id uuid NOT NULL
);


--
-- Name: migrations; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.migrations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    hash character varying(40) NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: objects; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.objects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id text,
    name text,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    last_accessed_at timestamp with time zone DEFAULT now(),
    metadata jsonb,
    path_tokens text[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    version text,
    owner_id text,
    user_metadata jsonb
);


--
-- Name: COLUMN objects.owner; Type: COMMENT; Schema: storage; Owner: -
--

COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: s3_multipart_uploads; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.s3_multipart_uploads (
    id text NOT NULL,
    in_progress_size bigint DEFAULT 0 NOT NULL,
    upload_signature text NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    version text NOT NULL,
    owner_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_metadata jsonb
);


--
-- Name: s3_multipart_uploads_parts; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.s3_multipart_uploads_parts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    upload_id text NOT NULL,
    size bigint DEFAULT 0 NOT NULL,
    part_number integer NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    etag text NOT NULL,
    owner_id text,
    version text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: vector_indexes; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.vector_indexes (
    id text DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL COLLATE pg_catalog."C",
    bucket_id text NOT NULL,
    data_type text NOT NULL,
    dimension integer NOT NULL,
    distance_metric text NOT NULL,
    metadata_configuration jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: hooks; Type: TABLE; Schema: supabase_functions; Owner: -
--

CREATE TABLE supabase_functions.hooks (
    id bigint NOT NULL,
    hook_table_id integer NOT NULL,
    hook_name text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    request_id bigint
);


--
-- Name: TABLE hooks; Type: COMMENT; Schema: supabase_functions; Owner: -
--

COMMENT ON TABLE supabase_functions.hooks IS 'Supabase Functions Hooks: Audit trail for triggered hooks.';


--
-- Name: hooks_id_seq; Type: SEQUENCE; Schema: supabase_functions; Owner: -
--

CREATE SEQUENCE supabase_functions.hooks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: hooks_id_seq; Type: SEQUENCE OWNED BY; Schema: supabase_functions; Owner: -
--

ALTER SEQUENCE supabase_functions.hooks_id_seq OWNED BY supabase_functions.hooks.id;


--
-- Name: migrations; Type: TABLE; Schema: supabase_functions; Owner: -
--

CREATE TABLE supabase_functions.migrations (
    version text NOT NULL,
    inserted_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: messages_2026_04_01; Type: TABLE ATTACH; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_04_01 FOR VALUES FROM ('2026-04-01 00:00:00') TO ('2026-04-02 00:00:00');


--
-- Name: messages_2026_04_02; Type: TABLE ATTACH; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_04_02 FOR VALUES FROM ('2026-04-02 00:00:00') TO ('2026-04-03 00:00:00');


--
-- Name: messages_2026_04_03; Type: TABLE ATTACH; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_04_03 FOR VALUES FROM ('2026-04-03 00:00:00') TO ('2026-04-04 00:00:00');


--
-- Name: messages_2026_04_04; Type: TABLE ATTACH; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_04_04 FOR VALUES FROM ('2026-04-04 00:00:00') TO ('2026-04-05 00:00:00');


--
-- Name: messages_2026_04_05; Type: TABLE ATTACH; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_04_05 FOR VALUES FROM ('2026-04-05 00:00:00') TO ('2026-04-06 00:00:00');


--
-- Name: messages_2026_04_06; Type: TABLE ATTACH; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_04_06 FOR VALUES FROM ('2026-04-06 00:00:00') TO ('2026-04-07 00:00:00');


--
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);


--
-- Name: hooks id; Type: DEFAULT; Schema: supabase_functions; Owner: -
--

ALTER TABLE ONLY supabase_functions.hooks ALTER COLUMN id SET DEFAULT nextval('supabase_functions.hooks_id_seq'::regclass);


--
-- Data for Name: extensions; Type: TABLE DATA; Schema: _realtime; Owner: -
--

COPY _realtime.extensions (id, type, settings, tenant_external_id, inserted_at, updated_at) FROM stdin;
9b9d41a0-3345-447d-9c6e-006bc4315d1b	postgres_cdc_rls	{"region": "us-east-1", "db_host": "snq/bLu1HIDCSHs0mDsQ1q1y0g0qOyAe8EVqo/ote/U=", "db_name": "sWBpZNdjggEPTQVlI52Zfw==", "db_port": "+enMDFi1J/3IrrquHHwUmA==", "db_user": "uxbEq/zz8DXVD53TOI1zmw==", "slot_name": "supabase_realtime_replication_slot", "db_password": "sWBpZNdjggEPTQVlI52Zfw==", "publication": "supabase_realtime", "ssl_enforced": false, "poll_interval_ms": 100, "poll_max_changes": 100, "poll_max_record_bytes": 1048576}	realtime-dev	2026-04-03 09:28:40	2026-04-03 09:28:40
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: _realtime; Owner: -
--

COPY _realtime.schema_migrations (version, inserted_at) FROM stdin;
20210706140551	2026-04-02 13:48:26
20220329161857	2026-04-02 13:48:26
20220410212326	2026-04-02 13:48:26
20220506102948	2026-04-02 13:48:26
20220527210857	2026-04-02 13:48:26
20220815211129	2026-04-02 13:48:26
20220815215024	2026-04-02 13:48:26
20220818141501	2026-04-02 13:48:26
20221018173709	2026-04-02 13:48:26
20221102172703	2026-04-02 13:48:26
20221223010058	2026-04-02 13:48:26
20230110180046	2026-04-02 13:48:26
20230810220907	2026-04-02 13:48:26
20230810220924	2026-04-02 13:48:26
20231024094642	2026-04-02 13:48:26
20240306114423	2026-04-02 13:48:26
20240418082835	2026-04-02 13:48:26
20240625211759	2026-04-02 13:48:26
20240704172020	2026-04-02 13:48:26
20240902173232	2026-04-02 13:48:26
20241106103258	2026-04-02 13:48:26
20250424203323	2026-04-02 13:48:26
20250613072131	2026-04-02 13:48:26
20250711044927	2026-04-02 13:48:26
20250811121559	2026-04-02 13:48:26
20250926223044	2026-04-02 13:48:26
20251204170944	2026-04-02 13:48:26
20251218000543	2026-04-02 13:48:26
\.


--
-- Data for Name: tenants; Type: TABLE DATA; Schema: _realtime; Owner: -
--

COPY _realtime.tenants (id, name, external_id, jwt_secret, max_concurrent_users, inserted_at, updated_at, max_events_per_second, postgres_cdc_default, max_bytes_per_second, max_channels_per_client, max_joins_per_second, suspend, jwt_jwks, notify_private_alpha, private_only, migrations_ran, broadcast_adapter, max_presence_events_per_second, max_payload_size_in_kb) FROM stdin;
a6d770dc-366d-4e43-90fe-a5538c2b3057	realtime-dev	realtime-dev	iNjicxc4+llvc9wovDvqymwfnj9teWMlyOIbJ8Fh6j2WNU8CIJ2ZgjR6MUIKqSmeDmvpsKLsZ9jgXJmQPpwL8w==	200	2026-04-03 09:28:40	2026-04-03 09:28:40	100	postgres_cdc_rls	100000	100	100	f	{"keys": [{"x": "M5Sjqn5zwC9Kl1zVfUUGvv9boQjCGd45G8sdopBExB4", "y": "P6IXMvA2WYXSHSOMTBH2jsw_9rrzGy89FjPf6oOsIxQ", "alg": "ES256", "crv": "P-256", "ext": true, "kid": "b81269f1-21d8-4f2e-b719-c2240a840d90", "kty": "EC", "use": "sig", "key_ops": ["verify"]}, {"k": "c3VwZXItc2VjcmV0LWp3dC10b2tlbi13aXRoLWF0LWxlYXN0LTMyLWNoYXJhY3RlcnMtbG9uZw", "kty": "oct"}]}	f	f	65	gen_rpc	1000	3000
\.


--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) FROM stdin;
00000000-0000-0000-0000-000000000000	c5d3ea85-b7f6-4124-aaaa-dc2a8d5ea64b	{"action":"user_signedup","actor_id":"f557abc0-85b2-431d-92d8-b9d4288629a4","actor_username":"ojas.tripathi@ashoka.edu.in","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-04-02 13:55:26.664308+00	
00000000-0000-0000-0000-000000000000	dda5ddf3-34be-424b-8631-37a35dcc502c	{"action":"login","actor_id":"f557abc0-85b2-431d-92d8-b9d4288629a4","actor_username":"ojas.tripathi@ashoka.edu.in","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-04-02 13:55:26.671642+00	
00000000-0000-0000-0000-000000000000	e3d7b534-ee0a-4e4a-92a9-2c4418821bd2	{"action":"user_signedup","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-04-02 13:56:49.764846+00	
00000000-0000-0000-0000-000000000000	87ee1548-4bb8-4657-9609-7c50603862d4	{"action":"login","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-04-02 13:56:49.769751+00	
00000000-0000-0000-0000-000000000000	0b840f16-1492-4c75-b324-e42ae416fd37	{"action":"login","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-04-02 13:57:18.170731+00	
00000000-0000-0000-0000-000000000000	ad680419-a4d2-46a4-888a-a174310dca5b	{"action":"login","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-04-02 13:59:44.490657+00	
00000000-0000-0000-0000-000000000000	fabb0b3a-1032-4c3c-975a-8ef1f77da57d	{"action":"token_refreshed","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-02 15:01:50.554468+00	
00000000-0000-0000-0000-000000000000	4c2c5012-46ec-4474-96be-428ecc906357	{"action":"token_revoked","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-02 15:01:50.554942+00	
00000000-0000-0000-0000-000000000000	873eb0f0-248f-4000-bf8d-3889d0e72711	{"action":"token_refreshed","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-02 16:19:03.727884+00	
00000000-0000-0000-0000-000000000000	a7ea4cfb-cc14-4981-a994-9fe7ddb14273	{"action":"token_revoked","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-02 16:19:03.728499+00	
00000000-0000-0000-0000-000000000000	208d7add-ed30-4886-9e4a-933a0ae5747f	{"action":"token_refreshed","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-02 17:23:12.056786+00	
00000000-0000-0000-0000-000000000000	bddffee8-b423-4cc9-b307-e32ac9273d63	{"action":"token_revoked","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-02 17:23:12.057345+00	
00000000-0000-0000-0000-000000000000	e479a900-6d62-4918-a5bf-a1f23d635d0c	{"action":"token_refreshed","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-02 17:46:56.805002+00	
00000000-0000-0000-0000-000000000000	96424bfa-87e1-46b9-a0f9-0f151ad3afc7	{"action":"token_revoked","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-02 17:46:56.8056+00	
00000000-0000-0000-0000-000000000000	341d5d58-fa1a-4970-a977-1a4db8adabb1	{"action":"token_refreshed","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-02 19:24:12.148336+00	
00000000-0000-0000-0000-000000000000	73433d96-d8c9-4406-b579-9e69c0f9ab5b	{"action":"token_revoked","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-02 19:24:12.148677+00	
00000000-0000-0000-0000-000000000000	3e1e8702-2924-47d3-a31c-6a4e198daf23	{"action":"token_refreshed","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-03 01:52:55.904573+00	
00000000-0000-0000-0000-000000000000	ca9219e8-9bce-4aa5-96b6-8fa5e7027af9	{"action":"token_revoked","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-03 01:52:55.905074+00	
00000000-0000-0000-0000-000000000000	00c0a9a0-732f-4ec3-a108-d42d862cbfdf	{"action":"token_refreshed","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-03 08:33:24.958536+00	
00000000-0000-0000-0000-000000000000	7d7e24f3-3c44-43a7-857d-e10a4c51a653	{"action":"token_revoked","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-03 08:33:24.958895+00	
00000000-0000-0000-0000-000000000000	00bb7954-9db1-4a3b-acfa-a411134c8dee	{"action":"token_refreshed","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-03 09:38:18.608175+00	
00000000-0000-0000-0000-000000000000	ce9e6aef-33f2-4371-9e7d-0890db96eaf4	{"action":"token_revoked","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-03 09:38:18.609367+00	
00000000-0000-0000-0000-000000000000	5b7b2e11-037a-4c93-8feb-0d53b6c994ae	{"action":"token_refreshed","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-03 10:52:25.358704+00	
00000000-0000-0000-0000-000000000000	66a82451-fcf4-4f84-86c0-c23bebde8033	{"action":"token_revoked","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-03 10:52:25.359126+00	
00000000-0000-0000-0000-000000000000	e0a286f8-d63b-4f98-9c3e-25ec07727133	{"action":"token_refreshed","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-03 16:19:25.373061+00	
00000000-0000-0000-0000-000000000000	58bd35fa-5c9f-4af4-a640-c3a8d1f30caf	{"action":"token_revoked","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-03 16:19:25.373746+00	
00000000-0000-0000-0000-000000000000	100481a7-eff5-46e5-a0ea-ab42d1544be4	{"action":"token_refreshed","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-03 17:11:01.739802+00	
00000000-0000-0000-0000-000000000000	339c6875-baa4-4083-9c59-25873d89aee0	{"action":"token_revoked","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-03 17:11:01.740332+00	
00000000-0000-0000-0000-000000000000	1393b55e-9242-4339-aef3-8cc88481aecd	{"action":"token_refreshed","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-03 17:11:01.773412+00	
00000000-0000-0000-0000-000000000000	d01ed019-76f3-471f-9478-fe078390f7ee	{"action":"token_refreshed","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-03 18:01:20.999584+00	
00000000-0000-0000-0000-000000000000	c6151461-43e7-4b32-b4e1-2cbce90da130	{"action":"token_revoked","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-03 18:01:21.000055+00	
00000000-0000-0000-0000-000000000000	f888c997-a86e-4a7e-9b15-fdba54c010db	{"action":"token_refreshed","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-03 18:01:21.0414+00	
00000000-0000-0000-0000-000000000000	8cb911dc-aa09-4bcc-9013-58fd20e3687e	{"action":"token_refreshed","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-03 19:28:40.926844+00	
00000000-0000-0000-0000-000000000000	e2c86609-f2f4-4c2b-b027-3af0201ee8ff	{"action":"token_revoked","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-03 19:28:40.927221+00	
00000000-0000-0000-0000-000000000000	7e965195-b072-4948-9e14-0a6b01a9375c	{"action":"token_refreshed","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-03 19:28:40.970311+00	
00000000-0000-0000-0000-000000000000	2304d4ab-f52e-4bc3-83c2-138fc9f0ba8a	{"action":"token_refreshed","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-04 01:41:36.363133+00	
00000000-0000-0000-0000-000000000000	6d4f5d6f-c17b-4ef0-ae04-69771b97bb6b	{"action":"token_revoked","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-04 01:41:36.363714+00	
00000000-0000-0000-0000-000000000000	10d667fd-cec9-42d0-a726-5b45d2697635	{"action":"token_refreshed","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-04 10:18:19.745521+00	
00000000-0000-0000-0000-000000000000	2fd056dd-5cde-4494-8939-13f58a1f4664	{"action":"token_revoked","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-04 10:18:19.745991+00	
00000000-0000-0000-0000-000000000000	d4fa6877-3d0b-48cb-9a3e-20e54dbb201a	{"action":"login","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-04-04 11:05:46.22513+00	
00000000-0000-0000-0000-000000000000	59a06d0b-fda9-4088-8b23-2e7741b276c1	{"action":"token_refreshed","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-04 15:30:48.311897+00	
00000000-0000-0000-0000-000000000000	e5f71da8-4ff9-4fa1-baae-66811c6c6c53	{"action":"token_revoked","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-04 15:30:48.312468+00	
00000000-0000-0000-0000-000000000000	24074c8b-3e86-46ae-aeb1-8e6a4ed6e452	{"action":"token_refreshed","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-04 17:33:58.947421+00	
00000000-0000-0000-0000-000000000000	355ebe30-0ca5-4fb8-bcb7-f177a2a5aef9	{"action":"token_revoked","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-04 17:33:58.947939+00	
00000000-0000-0000-0000-000000000000	5bded86e-6f81-4ca2-af05-d3761c0d281c	{"action":"token_refreshed","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-04 18:15:34.26803+00	
00000000-0000-0000-0000-000000000000	ff475db9-bfa1-4cda-9255-aa35c87aa9db	{"action":"token_revoked","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-04 18:15:34.26856+00	
00000000-0000-0000-0000-000000000000	37811560-03ab-48d7-ad3c-1ad7280c87af	{"action":"token_refreshed","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-04 18:53:43.016409+00	
00000000-0000-0000-0000-000000000000	7b21aaaf-569d-4375-abe3-491c62694ceb	{"action":"token_revoked","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-04 18:53:43.01682+00	
00000000-0000-0000-0000-000000000000	bfc03ff0-e2a5-4519-9ddf-898d73fc26c3	{"action":"token_refreshed","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-05 03:33:55.343624+00	
00000000-0000-0000-0000-000000000000	d47e2ecb-0709-47a8-b577-fc932db67d9d	{"action":"token_revoked","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-05 03:33:55.344345+00	
00000000-0000-0000-0000-000000000000	cdc07438-83a0-4a65-80b7-247d9330a1be	{"action":"token_refreshed","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-05 04:08:31.661346+00	
00000000-0000-0000-0000-000000000000	3ce01ebe-7496-43f3-ad34-e7e769f7e365	{"action":"token_revoked","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-05 04:08:31.661913+00	
00000000-0000-0000-0000-000000000000	e478b688-a50a-4d91-b063-ad5aa325dcb1	{"action":"token_refreshed","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-05 04:31:33.140526+00	
00000000-0000-0000-0000-000000000000	64dfd110-501d-4b7f-bebe-54e9a3010594	{"action":"token_revoked","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-05 04:31:33.140989+00	
00000000-0000-0000-0000-000000000000	b63eaab0-cde3-4bfc-90ae-55067cddb463	{"action":"token_refreshed","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-05 05:03:19.130404+00	
00000000-0000-0000-0000-000000000000	ead9c5de-9841-49ef-b7f3-fde4f4e193d6	{"action":"token_revoked","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-05 05:03:19.130792+00	
00000000-0000-0000-0000-000000000000	a83b60ef-8fbd-4883-b79c-e8a0dc951105	{"action":"token_refreshed","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-05 06:32:38.598509+00	
00000000-0000-0000-0000-000000000000	414b3c39-f377-4abd-9463-823c63636810	{"action":"token_revoked","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-05 06:32:38.598943+00	
00000000-0000-0000-0000-000000000000	b761bf92-7487-4945-9547-233b46c9454f	{"action":"token_refreshed","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-05 07:32:28.470088+00	
00000000-0000-0000-0000-000000000000	c1405bec-2d15-497b-85bc-5b7ab9575e5e	{"action":"token_revoked","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-05 07:32:28.470656+00	
00000000-0000-0000-0000-000000000000	725b07c6-a72f-4d22-9b30-a8f6f91afd11	{"action":"token_refreshed","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-05 08:41:19.225243+00	
00000000-0000-0000-0000-000000000000	ea45b028-1d43-4e19-9972-fdd0225451a4	{"action":"token_revoked","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-05 08:41:19.225888+00	
00000000-0000-0000-0000-000000000000	38bc62a8-d913-46db-9602-7e201803cef3	{"action":"token_refreshed","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-05 08:41:19.237815+00	
00000000-0000-0000-0000-000000000000	c9739252-1404-4901-ba6f-66b3f94dd7f3	{"action":"token_revoked","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-05 08:41:19.238162+00	
00000000-0000-0000-0000-000000000000	7abb0850-3d8a-4d02-b731-565c3a6ae3c5	{"action":"token_refreshed","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-05 10:23:55.641106+00	
00000000-0000-0000-0000-000000000000	5b86184b-2b02-4972-89c9-3b0306b0de90	{"action":"token_revoked","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-05 10:23:55.641712+00	
00000000-0000-0000-0000-000000000000	8b408722-637c-4209-8528-7460cd2395d6	{"action":"token_refreshed","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-05 10:23:55.653093+00	
00000000-0000-0000-0000-000000000000	daf80fd9-1fd8-4247-b4fc-95d9da6315d7	{"action":"token_revoked","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-05 10:23:55.653433+00	
00000000-0000-0000-0000-000000000000	0bb015a0-153a-4a59-9526-a390ceededf2	{"action":"token_refreshed","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-05 12:42:37.318791+00	
00000000-0000-0000-0000-000000000000	c9981782-fd4a-40ec-939f-efcd6fc6478f	{"action":"token_revoked","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-05 12:42:37.319559+00	
00000000-0000-0000-0000-000000000000	006cbc7e-6c9f-4c8c-9ad9-833142724b2f	{"action":"token_refreshed","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-05 12:42:37.324025+00	
00000000-0000-0000-0000-000000000000	ad86c497-9b89-4f10-a639-cd61aaf34eb2	{"action":"token_revoked","actor_id":"11438b69-6887-4ad5-926b-75fc18eb32e7","actor_username":"admin@shelf.local","actor_via_sso":false,"log_type":"token"}	2026-04-05 12:42:37.324442+00	
\.


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.flow_state (id, user_id, auth_code, code_challenge_method, code_challenge, provider_type, provider_access_token, provider_refresh_token, created_at, updated_at, authentication_method, auth_code_issued_at, invite_token, referrer, oauth_client_state_id, linking_target_id, email_optional) FROM stdin;
\.


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) FROM stdin;
f557abc0-85b2-431d-92d8-b9d4288629a4	f557abc0-85b2-431d-92d8-b9d4288629a4	{"sub": "f557abc0-85b2-431d-92d8-b9d4288629a4", "email": "ojas.tripathi@ashoka.edu.in", "signup_method": "email-password", "email_verified": false, "phone_verified": false}	email	2026-04-02 13:55:26.661075+00	2026-04-02 13:55:26.661091+00	2026-04-02 13:55:26.661091+00	b76312c1-23fa-42c0-aade-3995a092dd62
11438b69-6887-4ad5-926b-75fc18eb32e7	11438b69-6887-4ad5-926b-75fc18eb32e7	{"sub": "11438b69-6887-4ad5-926b-75fc18eb32e7", "email": "admin@shelf.local", "email_verified": false, "phone_verified": false}	email	2026-04-02 13:56:49.763945+00	2026-04-02 13:56:49.763962+00	2026-04-02 13:56:49.763962+00	38f09a0e-cf17-4e6e-9819-a99b1963c595
\.


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.instances (id, uuid, raw_base_config, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.mfa_amr_claims (session_id, created_at, updated_at, authentication_method, id) FROM stdin;
9cb86e3b-c3cb-4564-adf0-88a4b4c85008	2026-04-02 13:55:26.673956+00	2026-04-02 13:55:26.673956+00	password	4a109fbf-acac-4f8a-8ba0-827e84a17749
1433f017-3853-47e0-97fb-440bdb4d836e	2026-04-02 13:56:49.771701+00	2026-04-02 13:56:49.771701+00	password	42421483-63b4-4a78-9809-c55e919f2bff
af08ce07-d7fe-45ce-b2ba-b78ea21b4b24	2026-04-02 13:57:18.174223+00	2026-04-02 13:57:18.174223+00	password	f7043084-ae96-4427-a305-e8aadc49b04d
3f6e515a-aefe-445e-9974-143a0a0b5e30	2026-04-02 13:59:44.492681+00	2026-04-02 13:59:44.492681+00	password	4290e379-e5dd-4da7-ab20-18da871ad323
bf6555ae-84bb-465f-b985-a9fdfa202668	2026-04-04 11:05:46.227676+00	2026-04-04 11:05:46.227676+00	password	42c898b2-796d-47d2-8755-6c6c9ead6b61
\.


--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.mfa_challenges (id, factor_id, created_at, verified_at, ip_address, otp_code, web_authn_session_data) FROM stdin;
\.


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.mfa_factors (id, user_id, friendly_name, factor_type, status, created_at, updated_at, secret, phone, last_challenged_at, web_authn_credential, web_authn_aaguid, last_webauthn_challenge_data) FROM stdin;
\.


--
-- Data for Name: oauth_authorizations; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.oauth_authorizations (id, authorization_id, client_id, user_id, redirect_uri, scope, state, resource, code_challenge, code_challenge_method, response_type, status, authorization_code, created_at, expires_at, approved_at, nonce) FROM stdin;
\.


--
-- Data for Name: oauth_client_states; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.oauth_client_states (id, provider_type, code_verifier, created_at) FROM stdin;
\.


--
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.oauth_clients (id, client_secret_hash, registration_type, redirect_uris, grant_types, client_name, client_uri, logo_uri, created_at, updated_at, deleted_at, client_type, token_endpoint_auth_method) FROM stdin;
\.


--
-- Data for Name: oauth_consents; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.oauth_consents (id, user_id, client_id, scopes, granted_at, revoked_at) FROM stdin;
\.


--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.one_time_tokens (id, user_id, token_type, token_hash, relates_to, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) FROM stdin;
00000000-0000-0000-0000-000000000000	1	2cog3rathf3h	f557abc0-85b2-431d-92d8-b9d4288629a4	f	2026-04-02 13:55:26.673111+00	2026-04-02 13:55:26.673111+00	\N	9cb86e3b-c3cb-4564-adf0-88a4b4c85008
00000000-0000-0000-0000-000000000000	2	2b3hkslik6ii	11438b69-6887-4ad5-926b-75fc18eb32e7	f	2026-04-02 13:56:49.771058+00	2026-04-02 13:56:49.771058+00	\N	1433f017-3853-47e0-97fb-440bdb4d836e
00000000-0000-0000-0000-000000000000	3	hpwihpkwxzvp	11438b69-6887-4ad5-926b-75fc18eb32e7	f	2026-04-02 13:57:18.173561+00	2026-04-02 13:57:18.173561+00	\N	af08ce07-d7fe-45ce-b2ba-b78ea21b4b24
00000000-0000-0000-0000-000000000000	4	q7tpcbnopdum	11438b69-6887-4ad5-926b-75fc18eb32e7	t	2026-04-02 13:59:44.492037+00	2026-04-02 15:01:50.555258+00	\N	3f6e515a-aefe-445e-9974-143a0a0b5e30
00000000-0000-0000-0000-000000000000	5	r3givuniorvu	11438b69-6887-4ad5-926b-75fc18eb32e7	t	2026-04-02 15:01:50.555624+00	2026-04-02 16:19:03.728816+00	q7tpcbnopdum	3f6e515a-aefe-445e-9974-143a0a0b5e30
00000000-0000-0000-0000-000000000000	6	ode2fpjioa6m	11438b69-6887-4ad5-926b-75fc18eb32e7	t	2026-04-02 16:19:03.729272+00	2026-04-02 17:23:12.057663+00	r3givuniorvu	3f6e515a-aefe-445e-9974-143a0a0b5e30
00000000-0000-0000-0000-000000000000	7	qjgqfboc5cub	11438b69-6887-4ad5-926b-75fc18eb32e7	t	2026-04-02 17:23:12.058023+00	2026-04-02 17:46:56.805949+00	ode2fpjioa6m	3f6e515a-aefe-445e-9974-143a0a0b5e30
00000000-0000-0000-0000-000000000000	8	udrjvwds2suc	11438b69-6887-4ad5-926b-75fc18eb32e7	t	2026-04-02 17:46:56.80659+00	2026-04-02 19:24:12.149026+00	qjgqfboc5cub	3f6e515a-aefe-445e-9974-143a0a0b5e30
00000000-0000-0000-0000-000000000000	9	v26kh4eyvc55	11438b69-6887-4ad5-926b-75fc18eb32e7	t	2026-04-02 19:24:12.149394+00	2026-04-03 01:52:55.905365+00	udrjvwds2suc	3f6e515a-aefe-445e-9974-143a0a0b5e30
00000000-0000-0000-0000-000000000000	10	4djtrztuy7xg	11438b69-6887-4ad5-926b-75fc18eb32e7	t	2026-04-03 01:52:55.905795+00	2026-04-03 08:33:24.959206+00	v26kh4eyvc55	3f6e515a-aefe-445e-9974-143a0a0b5e30
00000000-0000-0000-0000-000000000000	11	anmwc5tvim46	11438b69-6887-4ad5-926b-75fc18eb32e7	t	2026-04-03 08:33:24.95961+00	2026-04-03 09:38:18.609628+00	4djtrztuy7xg	3f6e515a-aefe-445e-9974-143a0a0b5e30
00000000-0000-0000-0000-000000000000	12	trdf3zgmlsmt	11438b69-6887-4ad5-926b-75fc18eb32e7	t	2026-04-03 09:38:18.609989+00	2026-04-03 10:52:25.359536+00	anmwc5tvim46	3f6e515a-aefe-445e-9974-143a0a0b5e30
00000000-0000-0000-0000-000000000000	13	b5pwcnierxbw	11438b69-6887-4ad5-926b-75fc18eb32e7	t	2026-04-03 10:52:25.359852+00	2026-04-03 16:19:25.374224+00	trdf3zgmlsmt	3f6e515a-aefe-445e-9974-143a0a0b5e30
00000000-0000-0000-0000-000000000000	14	xlxjhwmxylew	11438b69-6887-4ad5-926b-75fc18eb32e7	t	2026-04-03 16:19:25.374687+00	2026-04-03 17:11:01.740657+00	b5pwcnierxbw	3f6e515a-aefe-445e-9974-143a0a0b5e30
00000000-0000-0000-0000-000000000000	15	dqxwzclpvefj	11438b69-6887-4ad5-926b-75fc18eb32e7	t	2026-04-03 17:11:01.741079+00	2026-04-03 18:01:21.000388+00	xlxjhwmxylew	3f6e515a-aefe-445e-9974-143a0a0b5e30
00000000-0000-0000-0000-000000000000	16	pkpjm6d5k3tc	11438b69-6887-4ad5-926b-75fc18eb32e7	t	2026-04-03 18:01:21.000812+00	2026-04-03 19:28:40.927646+00	dqxwzclpvefj	3f6e515a-aefe-445e-9974-143a0a0b5e30
00000000-0000-0000-0000-000000000000	17	wwjmlfmb5ra7	11438b69-6887-4ad5-926b-75fc18eb32e7	t	2026-04-03 19:28:40.927924+00	2026-04-04 01:41:36.364048+00	pkpjm6d5k3tc	3f6e515a-aefe-445e-9974-143a0a0b5e30
00000000-0000-0000-0000-000000000000	18	47jjarxdhyf7	11438b69-6887-4ad5-926b-75fc18eb32e7	t	2026-04-04 01:41:36.364476+00	2026-04-04 10:18:19.746368+00	wwjmlfmb5ra7	3f6e515a-aefe-445e-9974-143a0a0b5e30
00000000-0000-0000-0000-000000000000	19	ibs3skqu32be	11438b69-6887-4ad5-926b-75fc18eb32e7	t	2026-04-04 10:18:19.746736+00	2026-04-04 15:30:48.312881+00	47jjarxdhyf7	3f6e515a-aefe-445e-9974-143a0a0b5e30
00000000-0000-0000-0000-000000000000	21	out5244nnk3i	11438b69-6887-4ad5-926b-75fc18eb32e7	t	2026-04-04 15:30:48.313293+00	2026-04-04 17:33:58.94828+00	ibs3skqu32be	3f6e515a-aefe-445e-9974-143a0a0b5e30
00000000-0000-0000-0000-000000000000	20	62o3j4vgdx7n	11438b69-6887-4ad5-926b-75fc18eb32e7	t	2026-04-04 11:05:46.226838+00	2026-04-04 18:15:34.268865+00	\N	bf6555ae-84bb-465f-b985-a9fdfa202668
00000000-0000-0000-0000-000000000000	22	tdre4qnt4hrw	11438b69-6887-4ad5-926b-75fc18eb32e7	t	2026-04-04 17:33:58.948786+00	2026-04-04 18:53:43.017155+00	out5244nnk3i	3f6e515a-aefe-445e-9974-143a0a0b5e30
00000000-0000-0000-0000-000000000000	23	eo6apy2w4fa5	11438b69-6887-4ad5-926b-75fc18eb32e7	t	2026-04-04 18:15:34.269286+00	2026-04-05 03:33:55.344567+00	62o3j4vgdx7n	bf6555ae-84bb-465f-b985-a9fdfa202668
00000000-0000-0000-0000-000000000000	24	4bgzb2ilqbvx	11438b69-6887-4ad5-926b-75fc18eb32e7	t	2026-04-04 18:53:43.017427+00	2026-04-05 04:08:31.662355+00	tdre4qnt4hrw	3f6e515a-aefe-445e-9974-143a0a0b5e30
00000000-0000-0000-0000-000000000000	25	rde7hiaaztir	11438b69-6887-4ad5-926b-75fc18eb32e7	t	2026-04-05 03:33:55.344948+00	2026-04-05 04:31:33.1413+00	eo6apy2w4fa5	bf6555ae-84bb-465f-b985-a9fdfa202668
00000000-0000-0000-0000-000000000000	26	czlowfwutoak	11438b69-6887-4ad5-926b-75fc18eb32e7	t	2026-04-05 04:08:31.662778+00	2026-04-05 05:03:19.131079+00	4bgzb2ilqbvx	3f6e515a-aefe-445e-9974-143a0a0b5e30
00000000-0000-0000-0000-000000000000	27	e5yifulg4fb2	11438b69-6887-4ad5-926b-75fc18eb32e7	t	2026-04-05 04:31:33.141669+00	2026-04-05 06:32:38.59927+00	rde7hiaaztir	bf6555ae-84bb-465f-b985-a9fdfa202668
00000000-0000-0000-0000-000000000000	28	22u6jsjxootd	11438b69-6887-4ad5-926b-75fc18eb32e7	t	2026-04-05 05:03:19.131447+00	2026-04-05 07:32:28.470949+00	czlowfwutoak	3f6e515a-aefe-445e-9974-143a0a0b5e30
00000000-0000-0000-0000-000000000000	29	ku2xxwvoa34x	11438b69-6887-4ad5-926b-75fc18eb32e7	t	2026-04-05 06:32:38.59956+00	2026-04-05 08:41:19.226255+00	e5yifulg4fb2	bf6555ae-84bb-465f-b985-a9fdfa202668
00000000-0000-0000-0000-000000000000	30	rklltapaokfc	11438b69-6887-4ad5-926b-75fc18eb32e7	t	2026-04-05 07:32:28.471427+00	2026-04-05 08:41:19.238393+00	22u6jsjxootd	3f6e515a-aefe-445e-9974-143a0a0b5e30
00000000-0000-0000-0000-000000000000	31	5hoarxp2cotk	11438b69-6887-4ad5-926b-75fc18eb32e7	t	2026-04-05 08:41:19.226696+00	2026-04-05 10:23:55.642049+00	ku2xxwvoa34x	bf6555ae-84bb-465f-b985-a9fdfa202668
00000000-0000-0000-0000-000000000000	32	6accrokbvbp6	11438b69-6887-4ad5-926b-75fc18eb32e7	t	2026-04-05 08:41:19.238616+00	2026-04-05 10:23:55.65374+00	rklltapaokfc	3f6e515a-aefe-445e-9974-143a0a0b5e30
00000000-0000-0000-0000-000000000000	33	no7h63in56af	11438b69-6887-4ad5-926b-75fc18eb32e7	t	2026-04-05 10:23:55.642594+00	2026-04-05 12:42:37.319878+00	5hoarxp2cotk	bf6555ae-84bb-465f-b985-a9fdfa202668
00000000-0000-0000-0000-000000000000	35	2ap2y35bcidm	11438b69-6887-4ad5-926b-75fc18eb32e7	f	2026-04-05 12:42:37.320331+00	2026-04-05 12:42:37.320331+00	no7h63in56af	bf6555ae-84bb-465f-b985-a9fdfa202668
00000000-0000-0000-0000-000000000000	34	ndayz3xqszev	11438b69-6887-4ad5-926b-75fc18eb32e7	t	2026-04-05 10:23:55.653967+00	2026-04-05 12:42:37.32474+00	6accrokbvbp6	3f6e515a-aefe-445e-9974-143a0a0b5e30
00000000-0000-0000-0000-000000000000	36	qvjakug673lr	11438b69-6887-4ad5-926b-75fc18eb32e7	f	2026-04-05 12:42:37.325059+00	2026-04-05 12:42:37.325059+00	ndayz3xqszev	3f6e515a-aefe-445e-9974-143a0a0b5e30
\.


--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.saml_providers (id, sso_provider_id, entity_id, metadata_xml, metadata_url, attribute_mapping, created_at, updated_at, name_id_format) FROM stdin;
\.


--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.saml_relay_states (id, sso_provider_id, request_id, for_email, redirect_to, created_at, updated_at, flow_state_id) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.schema_migrations (version) FROM stdin;
20171026211738
20171026211808
20171026211834
20180103212743
20180108183307
20180119214651
20180125194653
00
20210710035447
20210722035447
20210730183235
20210909172000
20210927181326
20211122151130
20211124214934
20211202183645
20220114185221
20220114185340
20220224000811
20220323170000
20220429102000
20220531120530
20220614074223
20220811173540
20221003041349
20221003041400
20221011041400
20221020193600
20221021073300
20221021082433
20221027105023
20221114143122
20221114143410
20221125140132
20221208132122
20221215195500
20221215195800
20221215195900
20230116124310
20230116124412
20230131181311
20230322519590
20230402418590
20230411005111
20230508135423
20230523124323
20230818113222
20230914180801
20231027141322
20231114161723
20231117164230
20240115144230
20240214120130
20240306115329
20240314092811
20240427152123
20240612123726
20240729123726
20240802193726
20240806073726
20241009103726
20250717082212
20250731150234
20250804100000
20250901200500
20250903112500
20250904133000
20250925093508
20251007112900
20251104100000
20251111201300
20251201000000
20260115000000
20260121000000
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.sessions (id, user_id, created_at, updated_at, factor_id, aal, not_after, refreshed_at, user_agent, ip, tag, oauth_client_id, refresh_token_hmac_key, refresh_token_counter, scopes) FROM stdin;
9cb86e3b-c3cb-4564-adf0-88a4b4c85008	f557abc0-85b2-431d-92d8-b9d4288629a4	2026-04-02 13:55:26.672173+00	2026-04-02 13:55:26.672173+00	\N	aal1	\N	\N	node	192.168.65.1	\N	\N	\N	\N	\N
1433f017-3853-47e0-97fb-440bdb4d836e	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-02 13:56:49.77026+00	2026-04-02 13:56:49.77026+00	\N	aal1	\N	\N	curl/8.7.1	192.168.65.1	\N	\N	\N	\N	\N
af08ce07-d7fe-45ce-b2ba-b78ea21b4b24	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-02 13:57:18.171252+00	2026-04-02 13:57:18.171252+00	\N	aal1	\N	\N	node	192.168.65.1	\N	\N	\N	\N	\N
bf6555ae-84bb-465f-b985-a9fdfa202668	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-04 11:05:46.225827+00	2026-04-05 12:42:37.321513+00	\N	aal1	\N	2026-04-05 12:42:37.321484	node	172.18.0.1	\N	\N	\N	\N	\N
3f6e515a-aefe-445e-9974-143a0a0b5e30	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-02 13:59:44.491241+00	2026-04-05 12:42:37.326048+00	\N	aal1	\N	2026-04-05 12:42:37.326018	node	172.18.0.1	\N	\N	\N	\N	\N
\.


--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.sso_domains (id, sso_provider_id, domain, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.sso_providers (id, resource_id, created_at, updated_at, disabled) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) FROM stdin;
00000000-0000-0000-0000-000000000000	f557abc0-85b2-431d-92d8-b9d4288629a4	authenticated	authenticated	ojas.tripathi@ashoka.edu.in	$2a$10$xRVIaIziCk.9aKbh8zGNb.ctDFPOQAtSrn5jd7x1q0A/hfV5.jvpa	2026-04-02 13:55:26.665021+00	\N		\N		\N			\N	2026-04-02 13:55:26.67214+00	{"provider": "email", "providers": ["email"]}	{"sub": "f557abc0-85b2-431d-92d8-b9d4288629a4", "email": "ojas.tripathi@ashoka.edu.in", "signup_method": "email-password", "email_verified": true, "phone_verified": false}	\N	2026-04-02 13:55:26.656851+00	2026-04-02 13:55:26.673728+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	11438b69-6887-4ad5-926b-75fc18eb32e7	authenticated	authenticated	admin@shelf.local	$2a$10$BzcFfD3Pn.wC.zSfHw3Ro.gyX5Zfo3TFdgh5kU/UlzVZ5wfqxE.Ta	2026-04-02 13:56:49.765259+00	\N		\N		\N			\N	2026-04-04 11:05:46.225773+00	{"provider": "email", "providers": ["email"]}	{"sub": "11438b69-6887-4ad5-926b-75fc18eb32e7", "email": "admin@shelf.local", "email_verified": true, "phone_verified": false}	\N	2026-04-02 13:56:49.75816+00	2026-04-05 12:42:37.325532+00	\N	\N			\N		0	\N		\N	f	\N	f
\.


--
-- Data for Name: archive; Type: TABLE DATA; Schema: pgboss; Owner: -
--

COPY pgboss.archive (id, name, priority, data, state, retrylimit, retrycount, retrydelay, retrybackoff, startafter, startedon, singletonkey, singletonon, expirein, createdon, completedon, keepuntil, on_complete, output, archivedon) FROM stdin;
21aa2e49-b60e-4d04-8b94-bb13ca7176b3	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-02 13:51:20.259004+00	2026-04-02 13:51:20.260548+00	__pgboss__maintenance	\N	00:15:00	2026-04-02 13:51:20.259004+00	2026-04-02 13:51:20.265654+00	2026-04-02 13:59:20.259004+00	f	\N	2026-04-03 01:52:55.873446+00
a04c3279-ac7c-4a8a-920d-46ee0aa6e698	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-02 13:53:20.266623+00	2026-04-02 13:53:20.272579+00	__pgboss__maintenance	\N	00:15:00	2026-04-02 13:51:20.266623+00	2026-04-02 13:53:20.281485+00	2026-04-02 14:01:20.266623+00	f	\N	2026-04-03 03:03:38.912056+00
69355cfb-e7aa-4238-8327-4faad0e4586b	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-02 13:55:20.283153+00	2026-04-02 13:56:20.316585+00	__pgboss__maintenance	\N	00:15:00	2026-04-02 13:53:20.283153+00	2026-04-02 13:56:20.323407+00	2026-04-02 14:03:20.283153+00	f	\N	2026-04-03 03:03:38.912056+00
c84b1f89-0529-413c-9ff7-bb6327ac8a02	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-02 13:58:20.324723+00	2026-04-02 13:59:20.313039+00	__pgboss__maintenance	\N	00:15:00	2026-04-02 13:56:20.324723+00	2026-04-02 13:59:20.321453+00	2026-04-02 14:06:20.324723+00	f	\N	2026-04-03 03:03:38.912056+00
0bb04374-ef84-4572-a776-e36b0149980c	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-02 14:01:20.32323+00	2026-04-02 14:02:20.321997+00	__pgboss__maintenance	\N	00:15:00	2026-04-02 13:59:20.32323+00	2026-04-02 14:02:20.333343+00	2026-04-02 14:09:20.32323+00	f	\N	2026-04-03 03:03:38.912056+00
46a1a48f-ef9b-4ea5-8050-7300825e73fa	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-02 14:04:20.335101+00	2026-04-02 14:05:20.326559+00	__pgboss__maintenance	\N	00:15:00	2026-04-02 14:02:20.335101+00	2026-04-02 14:05:20.336922+00	2026-04-02 14:12:20.335101+00	f	\N	2026-04-03 03:03:38.912056+00
08adf65d-a819-49ac-bb58-996bb08c2b1c	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-02 14:07:20.338365+00	2026-04-02 14:08:20.329748+00	__pgboss__maintenance	\N	00:15:00	2026-04-02 14:05:20.338365+00	2026-04-02 14:08:20.339889+00	2026-04-02 14:15:20.338365+00	f	\N	2026-04-03 03:03:38.912056+00
f7e80c7a-10b7-4f7c-afc6-4aff39ebe69e	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-02 14:10:20.341573+00	2026-04-02 14:11:20.313523+00	__pgboss__maintenance	\N	00:15:00	2026-04-02 14:08:20.341573+00	2026-04-02 14:11:20.317864+00	2026-04-02 14:18:20.341573+00	f	\N	2026-04-03 03:03:38.912056+00
f51aef66-7aae-4ffb-84ad-132ea9043a54	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-02 14:13:20.319104+00	2026-04-02 14:14:20.301757+00	__pgboss__maintenance	\N	00:15:00	2026-04-02 14:11:20.319104+00	2026-04-02 14:14:20.310839+00	2026-04-02 14:21:20.319104+00	f	\N	2026-04-03 03:03:38.912056+00
81e5947f-d59f-41de-bfab-867eecde247d	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-02 14:16:20.313152+00	2026-04-02 14:17:20.308904+00	__pgboss__maintenance	\N	00:15:00	2026-04-02 14:14:20.313152+00	2026-04-02 14:17:20.318214+00	2026-04-02 14:24:20.313152+00	f	\N	2026-04-03 03:03:38.912056+00
d0fb0b33-4095-43ee-b98d-83d18db4b1a2	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-02 14:19:20.319835+00	2026-04-02 14:20:20.307542+00	__pgboss__maintenance	\N	00:15:00	2026-04-02 14:17:20.319835+00	2026-04-02 14:20:20.316214+00	2026-04-02 14:27:20.319835+00	f	\N	2026-04-03 03:03:38.912056+00
41fa1641-78f6-4eac-82f8-0b072d09d711	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-02 14:22:20.318275+00	2026-04-02 14:23:20.299219+00	__pgboss__maintenance	\N	00:15:00	2026-04-02 14:20:20.318275+00	2026-04-02 14:23:20.308053+00	2026-04-02 14:30:20.318275+00	f	\N	2026-04-03 03:03:38.912056+00
39c7810c-dd23-4b08-8504-bccf23425487	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-02 14:25:20.310171+00	2026-04-02 14:25:20.312694+00	__pgboss__maintenance	\N	00:15:00	2026-04-02 14:23:20.310171+00	2026-04-02 14:25:20.320386+00	2026-04-02 14:33:20.310171+00	f	\N	2026-04-03 03:03:38.912056+00
2bcc82aa-c07b-4a26-832e-0fe4bd526d2f	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-02 14:27:20.32136+00	2026-04-02 14:27:59.635801+00	__pgboss__maintenance	\N	00:15:00	2026-04-02 14:25:20.32136+00	2026-04-02 14:27:59.645607+00	2026-04-02 14:35:20.32136+00	f	\N	2026-04-03 03:03:38.912056+00
1850f4e4-3b7d-4a5b-8f36-a6033a232bd4	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-02 15:01:42.914775+00	2026-04-02 15:01:50.51585+00	__pgboss__maintenance	\N	00:15:00	2026-04-02 15:01:42.914775+00	2026-04-02 15:01:50.800689+00	2026-04-02 15:09:42.914775+00	f	\N	2026-04-03 03:03:38.912056+00
3376a228-51e2-40fb-85e1-25ed27b5c9ec	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-02 16:13:12.287721+00	2026-04-02 16:14:12.275325+00	__pgboss__maintenance	\N	00:15:00	2026-04-02 16:11:12.287721+00	2026-04-02 16:14:12.284295+00	2026-04-02 16:21:12.287721+00	f	\N	2026-04-03 04:25:03.123819+00
64d8c8e2-8ace-485a-a9db-f18798d0b291	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-02 16:16:12.286462+00	2026-04-02 16:17:12.274947+00	__pgboss__maintenance	\N	00:15:00	2026-04-02 16:14:12.286462+00	2026-04-02 16:17:12.287351+00	2026-04-02 16:24:12.286462+00	f	\N	2026-04-03 04:25:03.123819+00
3c93da47-b6cd-4cec-9987-c8db050fe603	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-02 16:19:12.288867+00	2026-04-02 16:20:12.278208+00	__pgboss__maintenance	\N	00:15:00	2026-04-02 16:17:12.288867+00	2026-04-02 16:20:12.285378+00	2026-04-02 16:27:12.288867+00	f	\N	2026-04-03 04:25:03.123819+00
f76cf595-16a2-4b9f-bb37-8acbd8c35623	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-02 16:22:12.286922+00	2026-04-02 16:23:12.276445+00	__pgboss__maintenance	\N	00:15:00	2026-04-02 16:20:12.286922+00	2026-04-02 16:23:12.287841+00	2026-04-02 16:30:12.286922+00	f	\N	2026-04-03 04:25:03.123819+00
9207b564-b8df-4323-9f6f-5fbda48ac225	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-02 15:03:50.802386+00	2026-04-02 15:34:59.549962+00	__pgboss__maintenance	\N	00:15:00	2026-04-02 15:01:50.802386+00	2026-04-02 15:34:59.79811+00	2026-04-02 15:11:50.802386+00	f	\N	2026-04-03 04:25:03.123819+00
93198e62-8fb1-4125-8033-f8e55e428a34	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-02 15:36:59.799218+00	2026-04-02 15:38:38.999597+00	__pgboss__maintenance	\N	00:15:00	2026-04-02 15:34:59.799218+00	2026-04-02 15:38:39.006177+00	2026-04-02 15:44:59.799218+00	f	\N	2026-04-03 04:25:03.123819+00
5206d070-98fb-42c6-a085-37eb3361bc9e	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-02 15:43:02.321583+00	2026-04-02 15:43:05.859133+00	__pgboss__maintenance	\N	00:15:00	2026-04-02 15:43:02.321583+00	2026-04-02 15:43:05.868791+00	2026-04-02 15:51:02.321583+00	f	\N	2026-04-03 04:25:03.123819+00
b27659fb-fc8b-4758-9b78-990c45fc36bd	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-02 15:45:05.870579+00	2026-04-02 15:46:05.870776+00	__pgboss__maintenance	\N	00:15:00	2026-04-02 15:43:05.870579+00	2026-04-02 15:46:05.88247+00	2026-04-02 15:53:05.870579+00	f	\N	2026-04-03 04:25:03.123819+00
dc1a11de-56b5-4a73-bf4d-24de80ae531d	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-02 15:48:05.88406+00	2026-04-02 15:49:05.871736+00	__pgboss__maintenance	\N	00:15:00	2026-04-02 15:46:05.88406+00	2026-04-02 15:49:05.880721+00	2026-04-02 15:56:05.88406+00	f	\N	2026-04-03 04:25:03.123819+00
47e1f59f-f33a-44d7-a12c-765c3113c4d7	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-02 15:51:05.883223+00	2026-04-02 15:52:05.874475+00	__pgboss__maintenance	\N	00:15:00	2026-04-02 15:49:05.883223+00	2026-04-02 15:52:05.881855+00	2026-04-02 15:59:05.883223+00	f	\N	2026-04-03 04:25:03.123819+00
313cf347-563f-488e-8039-8816df04496e	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-02 15:54:05.883563+00	2026-04-02 15:55:05.865696+00	__pgboss__maintenance	\N	00:15:00	2026-04-02 15:52:05.883563+00	2026-04-02 15:55:05.878234+00	2026-04-02 16:02:05.883563+00	f	\N	2026-04-03 04:25:03.123819+00
d2aeeeeb-30a7-43b3-8220-7d78e99f0483	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-02 15:57:05.880901+00	2026-04-02 15:58:05.878326+00	__pgboss__maintenance	\N	00:15:00	2026-04-02 15:55:05.880901+00	2026-04-02 15:58:05.889702+00	2026-04-02 16:05:05.880901+00	f	\N	2026-04-03 04:25:03.123819+00
eec08706-d995-435b-bf4c-13e691c39e7b	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-02 16:00:05.891166+00	2026-04-02 16:01:05.879128+00	__pgboss__maintenance	\N	00:15:00	2026-04-02 15:58:05.891166+00	2026-04-02 16:01:05.886983+00	2026-04-02 16:08:05.891166+00	f	\N	2026-04-03 04:25:03.123819+00
129cc69e-d450-4865-ac15-354fc62c2881	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-02 16:03:05.888453+00	2026-04-02 16:04:05.879962+00	__pgboss__maintenance	\N	00:15:00	2026-04-02 16:01:05.888453+00	2026-04-02 16:04:05.885137+00	2026-04-02 16:11:05.888453+00	f	\N	2026-04-03 04:25:03.123819+00
98508483-38a5-4875-959c-8be6b0b1086f	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-02 16:06:05.886644+00	2026-04-02 16:11:12.273189+00	__pgboss__maintenance	\N	00:15:00	2026-04-02 16:04:05.886644+00	2026-04-02 16:11:12.286068+00	2026-04-02 16:14:05.886644+00	f	\N	2026-04-03 04:25:03.123819+00
53807146-7ecf-4866-9ae4-4f8f8ae3e904	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-02 16:25:12.289416+00	2026-04-02 16:26:12.276382+00	__pgboss__maintenance	\N	00:15:00	2026-04-02 16:23:12.289416+00	2026-04-02 16:26:12.283219+00	2026-04-02 16:33:12.289416+00	f	\N	2026-04-03 05:06:43.188144+00
a25ec71d-0f63-4eb3-8eb2-15d070badaf1	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-02 16:28:12.285532+00	2026-04-02 16:29:10.093766+00	__pgboss__maintenance	\N	00:15:00	2026-04-02 16:26:12.285532+00	2026-04-02 16:29:10.106417+00	2026-04-02 16:36:12.285532+00	f	\N	2026-04-03 05:06:43.188144+00
9f8ec178-b901-4713-aa28-d415dcc93864	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-02 16:33:14.213158+00	2026-04-02 16:33:22.945658+00	__pgboss__maintenance	\N	00:15:00	2026-04-02 16:33:14.213158+00	2026-04-02 16:33:22.952727+00	2026-04-02 16:41:14.213158+00	f	\N	2026-04-03 05:06:43.188144+00
c25d3260-a286-44a3-b4d1-263d64e4188e	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-02 16:47:28.084324+00	2026-04-02 16:53:53.210261+00	__pgboss__maintenance	\N	00:15:00	2026-04-02 16:47:28.084324+00	2026-04-02 16:53:53.398488+00	2026-04-02 16:55:28.084324+00	f	\N	2026-04-03 05:06:43.188144+00
0cefb51b-623b-4595-8330-f3a83d0dc2c7	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-02 17:00:17.665374+00	2026-04-02 17:07:24.069427+00	__pgboss__maintenance	\N	00:15:00	2026-04-02 17:00:17.665374+00	2026-04-02 17:07:24.103124+00	2026-04-02 17:08:17.665374+00	f	\N	2026-04-03 05:35:07.349632+00
5a456642-62ed-4daf-8fa2-4e9689104736	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-02 17:23:12.300555+00	2026-04-02 17:30:02.995893+00	__pgboss__maintenance	\N	00:15:00	2026-04-02 17:23:12.300555+00	2026-04-02 17:30:03.004463+00	2026-04-02 17:31:12.300555+00	f	\N	2026-04-03 05:35:07.349632+00
8ed185e9-f5b2-46d0-a90e-adec46d73e38	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-02 17:46:46.470002+00	2026-04-02 17:46:52.207426+00	__pgboss__maintenance	\N	00:15:00	2026-04-02 17:46:46.470002+00	2026-04-02 17:46:52.22161+00	2026-04-02 17:54:46.470002+00	f	\N	2026-04-03 05:50:47.725805+00
268e90c4-55ba-420d-b705-045777c3ad77	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-02 18:38:55.533594+00	2026-04-02 18:39:00.538539+00	__pgboss__maintenance	\N	00:15:00	2026-04-02 18:38:55.533594+00	2026-04-02 18:39:00.55925+00	2026-04-02 18:46:55.533594+00	f	\N	2026-04-03 06:46:31.854857+00
744062e3-1c38-4398-8305-ec2a70f5be93	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-02 18:41:00.560976+00	2026-04-02 19:18:44.496033+00	__pgboss__maintenance	\N	00:15:00	2026-04-02 18:39:00.560976+00	2026-04-02 19:18:44.506677+00	2026-04-02 18:49:00.560976+00	f	\N	2026-04-03 07:24:20.090728+00
79639786-3b45-4d9c-8a73-172bb0d381fc	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-02 19:24:12.387985+00	2026-04-02 19:24:17.480065+00	__pgboss__maintenance	\N	00:15:00	2026-04-02 19:24:12.387985+00	2026-04-02 19:24:17.737618+00	2026-04-02 19:32:12.387985+00	f	\N	2026-04-03 07:24:20.090728+00
1e8aa6c9-e8c3-4f2d-958f-abb5fec8a417	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-02 19:52:38.102201+00	2026-04-02 19:52:45.111571+00	__pgboss__maintenance	\N	00:15:00	2026-04-02 19:52:38.102201+00	2026-04-02 19:52:45.365786+00	2026-04-02 20:00:38.102201+00	f	\N	2026-04-03 07:58:23.584736+00
25e3749b-c340-4c0c-a127-2b6e78c4946e	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-02 20:08:18.960438+00	2026-04-02 20:08:40.026994+00	__pgboss__maintenance	\N	00:15:00	2026-04-02 20:08:18.960438+00	2026-04-02 20:08:40.293541+00	2026-04-02 20:16:18.960438+00	f	\N	2026-04-03 08:33:12.778565+00
96a48235-54e9-4700-a84e-41ddaa98e766	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-02 20:35:55.461298+00	2026-04-02 20:36:02.455609+00	__pgboss__maintenance	\N	00:15:00	2026-04-02 20:35:55.461298+00	2026-04-02 20:36:02.709017+00	2026-04-02 20:43:55.461298+00	f	\N	2026-04-03 08:38:59.241332+00
ca720a58-47df-4efd-a919-c66789709aaa	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-02 20:56:47.87935+00	2026-04-02 20:56:54.881492+00	__pgboss__maintenance	\N	00:15:00	2026-04-02 20:56:47.87935+00	2026-04-02 20:56:54.893988+00	2026-04-02 21:04:47.87935+00	f	\N	2026-04-03 08:58:59.288051+00
8e66be27-0079-498d-87a3-047f04f6accc	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-02 21:33:16.017242+00	2026-04-02 21:33:23.019281+00	__pgboss__maintenance	\N	00:15:00	2026-04-02 21:33:16.017242+00	2026-04-02 21:33:23.025518+00	2026-04-02 21:41:16.017242+00	f	\N	2026-04-03 09:38:15.45649+00
13f35432-f3bb-42ac-93f1-b4d84e25c90b	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-02 21:17:34.996973+00	2026-04-02 21:17:42.007278+00	__pgboss__maintenance	\N	00:15:00	2026-04-02 21:17:34.996973+00	2026-04-02 21:17:42.209416+00	2026-04-02 21:25:34.996973+00	f	\N	2026-04-03 09:38:15.45649+00
cf5a8fc6-ee1c-42a0-afe2-6eb4dc0c84e1	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-02 21:54:06.479316+00	2026-04-02 21:54:13.482039+00	__pgboss__maintenance	\N	00:15:00	2026-04-02 21:54:06.479316+00	2026-04-02 21:54:13.494154+00	2026-04-02 22:02:06.479316+00	f	\N	2026-04-03 09:55:15.523065+00
c56eb91c-fc79-4d7e-a6c1-dd4f5d4f9a5c	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-02 22:14:36.336442+00	2026-04-02 22:14:43.338078+00	__pgboss__maintenance	\N	00:15:00	2026-04-02 22:14:36.336442+00	2026-04-02 22:14:43.349849+00	2026-04-02 22:22:36.336442+00	f	\N	2026-04-03 10:15:15.545247+00
cd4b4d39-36da-49af-960c-85360737e0b3	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-02 22:35:33.85116+00	2026-04-02 22:35:38.856449+00	__pgboss__maintenance	\N	00:15:00	2026-04-02 22:35:33.85116+00	2026-04-02 22:35:38.907948+00	2026-04-02 22:43:33.85116+00	f	\N	2026-04-03 10:52:15.009914+00
05a8263e-5ff6-4b21-938c-9ee61ec12333	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-02 23:01:44.011884+00	2026-04-02 23:01:51.024199+00	__pgboss__maintenance	\N	00:15:00	2026-04-02 23:01:44.011884+00	2026-04-02 23:01:51.03303+00	2026-04-02 23:09:44.011884+00	f	\N	2026-04-03 11:06:24.10611+00
3ce7f421-8a07-4544-8064-bce9664dfcbd	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-02 23:22:47.56492+00	2026-04-02 23:22:53.302019+00	__pgboss__maintenance	\N	00:15:00	2026-04-02 23:22:47.56492+00	2026-04-02 23:22:53.314141+00	2026-04-02 23:30:47.56492+00	f	\N	2026-04-03 11:23:50.009741+00
c77cb1c5-3d4e-4715-b33e-79a4a53f9cf9	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-02 23:44:23.406467+00	2026-04-02 23:44:30.405133+00	__pgboss__maintenance	\N	00:15:00	2026-04-02 23:44:23.406467+00	2026-04-02 23:44:30.424488+00	2026-04-02 23:52:23.406467+00	f	\N	2026-04-03 11:45:38.542966+00
d7ec9d78-b82a-4ded-a4c2-609b8ddba7f0	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 00:05:10.96098+00	2026-04-03 00:05:17.885069+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 00:05:10.96098+00	2026-04-03 00:05:18.1635+00	2026-04-03 00:13:10.96098+00	f	\N	2026-04-03 12:05:52.491126+00
ffa445f4-3ce2-4164-ba58-df2e054aa92c	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 00:07:18.165772+00	2026-04-03 00:26:17.192002+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 00:05:18.165772+00	2026-04-03 00:26:17.279647+00	2026-04-03 00:15:18.165772+00	f	\N	2026-04-03 12:26:52.480978+00
da7d95ac-5525-475c-bc86-4a9e094ae066	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 00:28:17.280807+00	2026-04-03 00:29:10.469421+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 00:26:17.280807+00	2026-04-03 00:29:10.477984+00	2026-04-03 00:36:17.280807+00	f	\N	2026-04-03 12:29:52.50121+00
4492a4c7-a399-4583-ac46-ad33c4210d19	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 00:31:10.480444+00	2026-04-03 00:56:42.818105+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 00:29:10.480444+00	2026-04-03 00:56:42.822423+00	2026-04-03 00:39:10.480444+00	f	\N	2026-04-03 13:06:02.150895+00
3deaf4e3-0202-4e9c-ba76-8048d988d186	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 00:58:42.823544+00	2026-04-03 01:02:02.586248+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 00:56:42.823544+00	2026-04-03 01:02:02.591412+00	2026-04-03 01:06:42.823544+00	f	\N	2026-04-03 13:06:02.150895+00
a239a821-1339-4fed-b8b3-e42a3d0f7fdf	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 01:52:55.875172+00	2026-04-03 01:53:00.975981+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 01:52:55.875172+00	2026-04-03 01:53:01.227032+00	2026-04-03 02:00:55.875172+00	f	\N	2026-04-03 14:29:15.953439+00
9710971c-18ea-4576-aa56-d3ea5e24d38d	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 03:03:38.912815+00	2026-04-03 03:03:44.649449+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 03:03:38.912815+00	2026-04-03 03:03:44.662809+00	2026-04-03 03:11:38.912815+00	f	\N	2026-04-03 15:43:52.942624+00
adf0f1b1-e288-4b18-8074-e1ff8192d078	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 04:25:03.1248+00	2026-04-03 04:25:10.130152+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 04:25:03.1248+00	2026-04-03 04:25:10.332077+00	2026-04-03 04:33:03.1248+00	f	\N	2026-04-03 16:25:58.823839+00
11829216-6138-44ad-a07a-f79e7699b9f9	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 05:06:43.189461+00	2026-04-03 05:06:48.177846+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 05:06:43.189461+00	2026-04-03 05:06:48.185505+00	2026-04-03 05:14:43.189461+00	f	\N	2026-04-03 17:08:35.325447+00
762abf0f-4213-4ba8-b39b-5ae6f65966e8	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 05:35:07.350258+00	2026-04-03 05:35:18.371451+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 05:35:07.350258+00	2026-04-03 05:35:18.38573+00	2026-04-03 05:43:07.350258+00	f	\N	2026-04-03 17:37:21.203307+00
9c68eb74-1cb0-4175-bc14-1caccce4e3b4	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 05:50:47.726947+00	2026-04-03 05:50:55.474126+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 05:50:47.726947+00	2026-04-03 05:50:55.487333+00	2026-04-03 05:58:47.726947+00	f	\N	2026-04-03 17:52:21.233243+00
c34b0670-9a87-4d72-98c6-cf0a94c3b588	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 06:11:37.354535+00	2026-04-03 06:11:45.364456+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 06:11:37.354535+00	2026-04-03 06:11:45.375016+00	2026-04-03 06:19:37.354535+00	f	\N	2026-04-03 18:52:29.350601+00
1603252e-63ef-40c6-977e-2765dadf2f6d	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 06:46:31.855701+00	2026-04-03 06:46:39.59007+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 06:46:31.855701+00	2026-04-03 06:46:39.598177+00	2026-04-03 06:54:31.855701+00	f	\N	2026-04-03 18:52:29.350601+00
21f42bd5-3b5d-4e5b-940f-a914fbe3e237	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 07:02:25.535139+00	2026-04-03 07:02:30.53281+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 07:02:25.535139+00	2026-04-03 07:02:30.770134+00	2026-04-03 07:10:25.535139+00	f	\N	2026-04-03 19:28:23.41783+00
bc00283a-ae87-4b6d-9043-fc54571c0eb3	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 07:24:20.091455+00	2026-04-03 07:24:27.065891+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 07:24:20.091455+00	2026-04-03 07:24:27.328655+00	2026-04-03 07:32:20.091455+00	f	\N	2026-04-03 19:28:23.41783+00
4f7e0e48-196c-413f-bb39-1d5d01306d24	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 07:42:18.20352+00	2026-04-03 07:42:25.163669+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 07:42:18.20352+00	2026-04-03 07:42:25.439658+00	2026-04-03 07:50:18.20352+00	f	\N	2026-04-03 20:22:03.378494+00
e3e00f18-1685-45bd-93db-b9f635e0c39e	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 08:00:23.587774+00	2026-04-03 08:03:41.820209+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 07:58:23.587774+00	2026-04-03 08:03:41.830459+00	2026-04-03 08:08:23.587774+00	f	\N	2026-04-03 20:22:03.378494+00
fb14dad1-477b-4818-afea-e8c5d23a96f3	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 07:44:25.440596+00	2026-04-03 07:58:23.580657+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 07:42:25.440596+00	2026-04-03 07:58:23.586877+00	2026-04-03 07:52:25.440596+00	f	\N	2026-04-03 20:22:03.378494+00
2c4b6c7d-e6dc-4e74-8700-e21ba9c1175e	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 08:05:41.831937+00	2026-04-03 08:06:35.163377+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 08:03:41.831937+00	2026-04-03 08:06:35.168701+00	2026-04-03 08:13:41.831937+00	f	\N	2026-04-03 20:22:03.378494+00
fc641da7-041c-4c77-8b65-04134671a07f	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 08:08:35.169485+00	2026-04-03 08:33:12.503035+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 08:06:35.169485+00	2026-04-03 08:33:12.784963+00	2026-04-03 08:16:35.169485+00	f	\N	2026-04-03 20:48:01.006443+00
449db05b-6584-4b66-8d1c-6571c7d47240	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 08:40:59.245962+00	2026-04-03 08:41:59.230395+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 08:38:59.245962+00	2026-04-03 08:41:59.238416+00	2026-04-03 08:48:59.245962+00	f	\N	2026-04-03 20:48:01.006443+00
37b277d3-74c4-44b7-98f5-0f0261b98584	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 08:46:59.23425+00	2026-04-03 08:47:59.231839+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 08:44:59.23425+00	2026-04-03 08:47:59.237541+00	2026-04-03 08:54:59.23425+00	f	\N	2026-04-03 20:48:01.006443+00
6dd42b2d-3563-4818-9b47-c604b6c0c568	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 08:35:12.786282+00	2026-04-03 08:38:59.233567+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 08:33:12.786282+00	2026-04-03 08:38:59.244407+00	2026-04-03 08:43:12.786282+00	f	\N	2026-04-03 20:48:01.006443+00
f929558c-e59a-46ef-b3dc-0cbae3eca5ff	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 08:43:59.239889+00	2026-04-03 08:44:59.228756+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 08:41:59.239889+00	2026-04-03 08:44:59.233347+00	2026-04-03 08:51:59.239889+00	f	\N	2026-04-03 20:48:01.006443+00
dc8e4f1a-c72e-4043-a1b9-eaaa3b8251d6	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 08:57:59.28996+00	2026-04-03 08:58:59.286361+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 08:55:59.28996+00	2026-04-03 08:58:59.290605+00	2026-04-03 09:05:59.28996+00	f	\N	2026-04-03 21:03:43.765241+00
6495c9af-674f-46fa-a03c-8d8e5c85b0f0	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 08:52:59.240265+00	2026-04-03 08:52:59.291319+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 08:50:59.240265+00	2026-04-03 08:52:59.300007+00	2026-04-03 09:00:59.240265+00	f	\N	2026-04-03 21:03:43.765241+00
1f82fc8f-fb18-4ac0-8ae0-70a64b664868	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 08:54:59.302167+00	2026-04-03 08:55:59.28642+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 08:52:59.302167+00	2026-04-03 08:55:59.289245+00	2026-04-03 09:02:59.302167+00	f	\N	2026-04-03 21:03:43.765241+00
de623089-cdf4-4536-b225-ced3c7bcf7cd	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 09:00:59.2915+00	2026-04-03 09:01:59.289756+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 08:58:59.2915+00	2026-04-03 09:01:59.294607+00	2026-04-03 09:08:59.2915+00	f	\N	2026-04-03 21:03:43.765241+00
3eacd9a2-4716-4f1d-9a78-46b7118569ab	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 08:49:59.238918+00	2026-04-03 08:50:59.229638+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 08:47:59.238918+00	2026-04-03 08:50:59.238123+00	2026-04-03 08:57:59.238918+00	f	\N	2026-04-03 21:03:43.765241+00
a9fe6281-5a4c-4de6-80d9-764c8d14effd	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 09:03:59.29553+00	2026-04-03 09:04:59.299471+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 09:01:59.29553+00	2026-04-03 09:04:59.305251+00	2026-04-03 09:11:59.29553+00	f	\N	2026-04-03 21:34:52.5478+00
a7cee8c5-2125-4d6e-a8f6-a8048bad5849	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 09:06:59.306884+00	2026-04-03 09:07:59.295166+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 09:04:59.306884+00	2026-04-03 09:07:59.30253+00	2026-04-03 09:14:59.306884+00	f	\N	2026-04-03 21:34:52.5478+00
e5f5152a-ebb4-49fe-b74e-6179677f8063	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 09:42:15.490887+00	2026-04-03 09:42:15.495353+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 09:40:15.490887+00	2026-04-03 09:42:15.504342+00	2026-04-03 09:50:15.490887+00	f	\N	2026-04-03 22:05:49.509639+00
53c056c9-6fac-479b-9d95-db9ebfaa24cd	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 09:46:15.518318+00	2026-04-03 09:47:15.50885+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 09:44:15.518318+00	2026-04-03 09:47:15.517447+00	2026-04-03 09:54:15.518318+00	f	\N	2026-04-03 22:05:49.509639+00
ee99fd6e-60fb-4c40-8e98-6a80ee621862	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 09:52:15.510434+00	2026-04-03 09:52:15.513189+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 09:50:15.510434+00	2026-04-03 09:52:15.522109+00	2026-04-03 10:00:15.510434+00	f	\N	2026-04-03 22:05:49.509639+00
3ec0f8aa-d655-4c15-8d57-590bc47267cf	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 09:57:15.528618+00	2026-04-03 09:58:15.505788+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 09:55:15.528618+00	2026-04-03 09:58:15.513937+00	2026-04-03 10:05:15.528618+00	f	\N	2026-04-03 22:05:49.509639+00
26d5035b-2674-40b9-8d71-775b8559d13a	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 10:02:15.530432+00	2026-04-03 10:03:15.515514+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 10:00:15.530432+00	2026-04-03 10:03:15.524499+00	2026-04-03 10:10:15.530432+00	f	\N	2026-04-03 22:05:49.509639+00
23e3c69c-134e-465a-b89e-955e28f94c8b	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 09:38:15.447044+00	2026-04-03 09:38:15.450143+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 09:38:15.447044+00	2026-04-03 09:38:15.45983+00	2026-04-03 09:46:15.447044+00	f	\N	2026-04-03 22:05:49.509639+00
fdec4050-d91e-4984-a9b5-f7abe76a313a	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 09:40:15.46112+00	2026-04-03 09:40:15.479906+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 09:38:15.46112+00	2026-04-03 09:40:15.489345+00	2026-04-03 09:48:15.46112+00	f	\N	2026-04-03 22:05:49.509639+00
af1edb05-a623-481b-8d4c-7f0d9ade3146	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 09:44:15.505726+00	2026-04-03 09:44:15.506371+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 09:42:15.505726+00	2026-04-03 09:44:15.516802+00	2026-04-03 09:52:15.505726+00	f	\N	2026-04-03 22:05:49.509639+00
2aabd7c0-6761-4d06-83ba-2478fe461d92	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 09:49:15.520302+00	2026-04-03 09:50:15.5019+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 09:47:15.520302+00	2026-04-03 09:50:15.508922+00	2026-04-03 09:57:15.520302+00	f	\N	2026-04-03 22:05:49.509639+00
b6c90fae-eadf-4ec8-8726-7dade5996a90	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 09:54:15.52482+00	2026-04-03 09:55:15.514599+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 09:52:15.52482+00	2026-04-03 09:55:15.526866+00	2026-04-03 10:02:15.52482+00	f	\N	2026-04-03 22:05:49.509639+00
1b0e8207-02dd-4775-b552-31c88e42b821	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 10:00:15.515518+00	2026-04-03 10:00:15.518198+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 09:58:15.515518+00	2026-04-03 10:00:15.528805+00	2026-04-03 10:08:15.515518+00	f	\N	2026-04-03 22:05:49.509639+00
287f7add-14a0-4183-9cd9-4e7246c5ef4c	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 10:08:15.527131+00	2026-04-03 10:09:15.532081+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 10:06:15.527131+00	2026-04-03 10:09:15.545147+00	2026-04-03 10:16:15.527131+00	f	\N	2026-04-03 22:31:43.468779+00
9bf760dc-cba4-45db-9642-be0bca2b0252	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 10:14:15.547611+00	2026-04-03 10:15:15.537999+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 10:12:15.547611+00	2026-04-03 10:15:15.548644+00	2026-04-03 10:22:15.547611+00	f	\N	2026-04-03 22:31:43.468779+00
468ef4bf-68a0-4b13-bc56-0236d1c62354	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 10:20:15.54097+00	2026-04-03 10:21:15.545186+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 10:18:15.54097+00	2026-04-03 10:21:15.55608+00	2026-04-03 10:28:15.54097+00	f	\N	2026-04-03 22:31:43.468779+00
3583dc02-239f-402c-b410-6004372fcb5c	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 10:26:15.563359+00	2026-04-03 10:31:19.019528+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 10:24:15.563359+00	2026-04-03 10:31:19.024195+00	2026-04-03 10:34:15.563359+00	f	\N	2026-04-03 22:31:43.468779+00
c74cd95a-5633-4921-8c58-e765c46a04fa	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 10:05:15.526108+00	2026-04-03 10:06:15.514206+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 10:03:15.526108+00	2026-04-03 10:06:15.525724+00	2026-04-03 10:13:15.526108+00	f	\N	2026-04-03 22:31:43.468779+00
4325702d-dddd-4f2e-8f05-45236000ec59	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 10:11:15.546836+00	2026-04-03 10:12:15.53534+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 10:09:15.546836+00	2026-04-03 10:12:15.54597+00	2026-04-03 10:19:15.546836+00	f	\N	2026-04-03 22:31:43.468779+00
9dbea92d-3d67-4aad-8e27-f50082658776	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 10:17:15.550864+00	2026-04-03 10:18:15.532292+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 10:15:15.550864+00	2026-04-03 10:18:15.539427+00	2026-04-03 10:25:15.550864+00	f	\N	2026-04-03 22:31:43.468779+00
fe8c0608-4af8-49f0-ab55-3a7ae3313bdb	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 10:23:15.557705+00	2026-04-03 10:24:15.549985+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 10:21:15.557705+00	2026-04-03 10:24:15.561707+00	2026-04-03 10:31:15.557705+00	f	\N	2026-04-03 22:31:43.468779+00
9952ae36-39ed-4161-ba14-23029eb586a5	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 10:33:19.025043+00	2026-04-03 10:33:44.199141+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 10:31:19.025043+00	2026-04-03 10:33:44.206837+00	2026-04-03 10:41:19.025043+00	f	\N	2026-04-03 22:47:30.611711+00
d6ff003d-85b0-4018-8dfa-e6330c1e84ce	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 11:13:50.002061+00	2026-04-03 11:14:49.992252+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 11:11:50.002061+00	2026-04-03 11:14:50.001621+00	2026-04-03 11:21:50.002061+00	f	\N	2026-04-03 23:26:19.662972+00
c18b9e32-505e-4bcd-9346-b95a94f5a719	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 11:19:50.011317+00	2026-04-03 11:20:50.000921+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 11:17:50.011317+00	2026-04-03 11:20:50.009743+00	2026-04-03 11:27:50.011317+00	f	\N	2026-04-03 23:26:19.662972+00
f945b58c-f8b3-46bf-b8fe-0ea019d02d44	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 11:06:24.11265+00	2026-04-03 11:11:49.989329+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 11:06:24.11265+00	2026-04-03 11:11:50.000255+00	2026-04-03 11:14:24.11265+00	f	\N	2026-04-03 23:26:19.662972+00
471a0d41-b7a9-4128-81f3-6042d143e1e3	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 11:16:50.003257+00	2026-04-03 11:17:49.998779+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 11:14:50.003257+00	2026-04-03 11:17:50.00951+00	2026-04-03 11:24:50.003257+00	f	\N	2026-04-03 23:26:19.662972+00
a794b15d-b415-43e8-a911-68c87f32841d	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 11:22:50.011772+00	2026-04-03 11:23:50.003693+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 11:20:50.011772+00	2026-04-03 11:23:50.014625+00	2026-04-03 11:30:50.011772+00	f	\N	2026-04-03 23:26:19.662972+00
4dee3631-a87c-4f96-91fd-f76583da32bf	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 10:52:15.009205+00	2026-04-03 10:56:32.486062+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 10:52:15.009205+00	2026-04-03 10:56:32.653432+00	2026-04-03 11:00:15.009205+00	f	\N	2026-04-03 23:26:19.662972+00
8c8416df-d7c1-467c-8bb0-1791561dde19	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 11:25:50.016425+00	2026-04-03 11:30:38.520586+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 11:23:50.016425+00	2026-04-03 11:30:38.529697+00	2026-04-03 11:33:50.016425+00	f	\N	2026-04-03 23:53:13.43316+00
60c3619c-3801-42ae-a332-d3e391c21ea0	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 11:35:38.540123+00	2026-04-03 11:36:38.530126+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 11:33:38.540123+00	2026-04-03 11:36:38.541493+00	2026-04-03 11:43:38.540123+00	f	\N	2026-04-03 23:53:13.43316+00
df7ecc11-999e-4c96-bf9b-20e7cd1a2d00	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 11:41:38.545798+00	2026-04-03 11:42:38.537014+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 11:39:38.545798+00	2026-04-03 11:42:38.54864+00	2026-04-03 11:49:38.545798+00	f	\N	2026-04-03 23:53:13.43316+00
3a05bcbe-6755-4b1c-bc01-cccb00116a16	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 11:47:38.548715+00	2026-04-03 11:48:27.974079+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 11:45:38.548715+00	2026-04-03 11:48:27.994073+00	2026-04-03 11:55:38.548715+00	f	\N	2026-04-03 23:53:13.43316+00
ac8ce3c8-03c2-4c2d-a199-74b16dcaa4b9	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 11:32:38.531086+00	2026-04-03 11:33:38.52877+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 11:30:38.531086+00	2026-04-03 11:33:38.538095+00	2026-04-03 11:40:38.531086+00	f	\N	2026-04-03 23:53:13.43316+00
819b1715-7a24-4140-a039-fe2c865afe3f	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 11:38:38.543114+00	2026-04-03 11:39:38.534029+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 11:36:38.543114+00	2026-04-03 11:39:38.543305+00	2026-04-03 11:46:38.543114+00	f	\N	2026-04-03 23:53:13.43316+00
45a7a3df-85bf-457c-8d48-dc2aad728eb7	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 11:44:38.5504+00	2026-04-03 11:45:38.537106+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 11:42:38.5504+00	2026-04-03 11:45:38.546923+00	2026-04-03 11:52:38.5504+00	f	\N	2026-04-03 23:53:13.43316+00
7e86085b-d33d-45a7-9301-5be7bfbeb061	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 12:01:52.494495+00	2026-04-03 12:02:52.490105+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 11:59:52.494495+00	2026-04-03 12:02:52.495681+00	2026-04-03 12:09:52.494495+00	f	\N	2026-04-04 00:09:38.679252+00
49aec4fa-4f74-44fe-b664-f6779e3f5112	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 12:07:52.494647+00	2026-04-03 12:07:52.501659+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 12:05:52.494647+00	2026-04-03 12:07:52.506762+00	2026-04-03 12:15:52.494647+00	f	\N	2026-04-04 00:09:38.679252+00
bd48867b-5c88-48b9-94df-98eb22d84e71	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 11:50:27.995929+00	2026-04-03 11:59:52.485996+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 11:48:27.995929+00	2026-04-03 11:59:52.492868+00	2026-04-03 11:58:27.995929+00	f	\N	2026-04-04 00:09:38.679252+00
6ed65a74-1518-422b-81e8-f9d375878490	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 12:04:52.496894+00	2026-04-03 12:05:52.488373+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 12:02:52.496894+00	2026-04-03 12:05:52.493798+00	2026-04-03 12:12:52.496894+00	f	\N	2026-04-04 00:09:38.679252+00
f5764996-56b0-4d09-9579-84ddb4e67c6b	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 12:11:52.521163+00	2026-04-03 12:12:52.519736+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 12:09:52.521163+00	2026-04-03 12:12:52.529406+00	2026-04-03 12:19:52.521163+00	f	\N	2026-04-04 00:31:06.882058+00
70eaf7b6-8cb5-4cef-b9fc-399166b30064	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 12:17:52.485511+00	2026-04-03 12:18:52.471951+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 12:15:52.485511+00	2026-04-03 12:18:52.476687+00	2026-04-03 12:25:52.485511+00	f	\N	2026-04-04 00:31:06.882058+00
2702f10d-0812-4f27-93c2-cad870f3b9a7	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 12:22:52.488818+00	2026-04-03 12:23:52.476094+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 12:20:52.488818+00	2026-04-03 12:23:52.480311+00	2026-04-03 12:30:52.488818+00	f	\N	2026-04-04 00:31:06.882058+00
cff560d6-eecc-4c6b-8b44-57e11bc77423	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 12:28:52.485367+00	2026-04-03 12:29:52.496177+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 12:26:52.485367+00	2026-04-03 12:29:52.503553+00	2026-04-03 12:36:52.485367+00	f	\N	2026-04-04 00:31:06.882058+00
c9c85e78-20cd-47f4-a659-04676f740458	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 12:09:52.508124+00	2026-04-03 12:09:52.51114+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 12:07:52.508124+00	2026-04-03 12:09:52.519709+00	2026-04-03 12:17:52.508124+00	f	\N	2026-04-04 00:31:06.882058+00
45785669-d5c7-448d-a453-78ac85435b4b	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 12:14:52.530974+00	2026-04-03 12:15:52.479058+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 12:12:52.530974+00	2026-04-03 12:15:52.484486+00	2026-04-03 12:22:52.530974+00	f	\N	2026-04-04 00:31:06.882058+00
a4173736-9cad-42e0-88e5-d4355d06764f	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 12:20:52.477961+00	2026-04-03 12:20:52.481158+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 12:18:52.477961+00	2026-04-03 12:20:52.487665+00	2026-04-03 12:28:52.477961+00	f	\N	2026-04-04 00:31:06.882058+00
c27484fb-6f7f-44ea-a42c-350675ada7a4	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 12:25:52.481416+00	2026-04-03 12:26:52.477508+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 12:23:52.481416+00	2026-04-03 12:26:52.483424+00	2026-04-03 12:33:52.481416+00	f	\N	2026-04-04 00:31:06.882058+00
b946f10f-98f5-4614-a8ff-8422a075d25f	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 12:34:52.506235+00	2026-04-03 12:35:52.50204+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 12:32:52.506235+00	2026-04-03 12:35:52.507911+00	2026-04-03 12:42:52.506235+00	f	\N	2026-04-04 00:51:57.828668+00
a46df173-7457-4c2d-ad79-81b28408ff83	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 12:40:52.508388+00	2026-04-03 12:41:52.50866+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 12:38:52.508388+00	2026-04-03 12:41:52.614501+00	2026-04-03 12:48:52.508388+00	f	\N	2026-04-04 00:51:57.828668+00
4d656ac8-adc6-49d6-bf09-f9695ae11f0c	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 12:31:52.504801+00	2026-04-03 12:32:52.497967+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 12:29:52.504801+00	2026-04-03 12:32:52.505023+00	2026-04-03 12:39:52.504801+00	f	\N	2026-04-04 00:51:57.828668+00
8fcedeba-72f8-43f4-9029-cab65d4a9406	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 12:37:52.509039+00	2026-04-03 12:38:52.500326+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 12:35:52.509039+00	2026-04-03 12:38:52.506264+00	2026-04-03 12:45:52.509039+00	f	\N	2026-04-04 00:51:57.828668+00
df2a5513-b888-472f-8626-8a2a34a7db14	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 12:43:52.617047+00	2026-04-03 12:45:21.881342+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 12:41:52.617047+00	2026-04-03 12:45:21.88735+00	2026-04-03 12:51:52.617047+00	f	\N	2026-04-04 00:51:57.828668+00
54ce37a1-d966-4bcd-a9a3-66ffdbe9e708	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 13:06:02.151804+00	2026-04-03 13:06:07.159313+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 13:06:02.151804+00	2026-04-03 13:06:07.20662+00	2026-04-03 13:14:02.151804+00	f	\N	2026-04-04 01:25:24.081944+00
74d7269c-abed-42ae-b940-5d3fc62ed8c1	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 14:29:15.955762+00	2026-04-03 14:29:22.950265+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 14:29:15.955762+00	2026-04-03 14:29:23.246728+00	2026-04-03 14:37:15.955762+00	f	\N	2026-04-04 02:32:15.4618+00
1bf6e142-aa5a-4a74-b273-d2c3e15498a7	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 15:43:52.944543+00	2026-04-03 15:43:58.665304+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 15:43:52.944543+00	2026-04-03 15:43:58.677333+00	2026-04-03 15:51:52.944543+00	f	\N	2026-04-04 03:46:18.612754+00
f08109a4-4852-4b52-a01b-5d10da9913cb	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 15:45:58.67868+00	2026-04-03 16:10:58.867934+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 15:43:58.67868+00	2026-04-03 16:10:58.878142+00	2026-04-03 15:53:58.67868+00	f	\N	2026-04-04 04:13:18.589987+00
df92f021-172b-4645-8479-550dbc2a4e9d	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 16:12:58.879842+00	2026-04-03 16:13:58.806066+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 16:10:58.879842+00	2026-04-03 16:13:58.815364+00	2026-04-03 16:20:58.879842+00	f	\N	2026-04-04 04:16:18.592568+00
b806cab9-8b67-4946-a036-e4c427562ec1	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 16:15:58.817371+00	2026-04-03 16:16:58.805568+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 16:13:58.817371+00	2026-04-03 16:16:58.818263+00	2026-04-03 16:23:58.817371+00	f	\N	2026-04-04 04:19:17.589004+00
8165ffbd-5bea-4734-9982-ed9f5c27687e	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 16:18:58.819944+00	2026-04-03 16:19:58.811097+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 16:16:58.819944+00	2026-04-03 16:19:58.818097+00	2026-04-03 16:26:58.819944+00	f	\N	2026-04-04 04:21:18.58797+00
5dbca5d6-9177-41fa-97ae-b32f43236dbf	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 16:21:58.819521+00	2026-04-03 16:22:58.822389+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 16:19:58.819521+00	2026-04-03 16:22:58.836215+00	2026-04-03 16:29:58.819521+00	f	\N	2026-04-04 04:24:18.598643+00
8c3b8146-faa1-4e38-9384-82f4c0f5d2c6	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 16:24:58.838183+00	2026-04-03 16:25:58.81948+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 16:22:58.838183+00	2026-04-03 16:25:58.826776+00	2026-04-03 16:32:58.838183+00	f	\N	2026-04-04 04:27:17.584089+00
78c3163e-c31d-46ba-abf8-f4adc5c851c1	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 16:27:58.828041+00	2026-04-03 16:28:58.825476+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 16:25:58.828041+00	2026-04-03 16:28:58.834559+00	2026-04-03 16:35:58.828041+00	f	\N	2026-04-04 04:29:18.605331+00
a055dde9-950d-42d2-a6aa-d8c88052fffb	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 16:30:58.835897+00	2026-04-03 16:44:35.308229+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 16:28:58.835897+00	2026-04-03 16:44:35.31577+00	2026-04-03 16:38:58.835897+00	f	\N	2026-04-04 04:46:19.420744+00
a02f727f-e09f-45d0-8320-05c85f348624	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 16:46:35.316661+00	2026-04-03 16:47:35.312886+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 16:44:35.316661+00	2026-04-03 16:47:35.323871+00	2026-04-03 16:54:35.316661+00	f	\N	2026-04-04 04:49:19.424805+00
ffc9941e-77cd-4d36-979e-0c62601d3c17	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 16:49:35.325614+00	2026-04-03 16:50:35.311082+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 16:47:35.325614+00	2026-04-03 16:50:35.323449+00	2026-04-03 16:57:35.325614+00	f	\N	2026-04-04 04:52:19.421797+00
b9451d7f-e1c0-4915-8177-d0bfa1df7efd	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 16:52:35.324941+00	2026-04-03 16:53:35.309028+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 16:50:35.324941+00	2026-04-03 16:53:35.313254+00	2026-04-03 17:00:35.324941+00	f	\N	2026-04-04 04:55:19.418986+00
be91b458-72bc-4657-b9b7-6df164db0e92	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 16:55:35.314302+00	2026-04-03 16:56:35.309478+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 16:53:35.314302+00	2026-04-03 16:56:35.316884+00	2026-04-03 17:03:35.314302+00	f	\N	2026-04-04 04:58:19.419923+00
fea1866c-305b-4366-af5d-1fecca490185	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 16:58:35.317747+00	2026-04-03 16:59:35.308474+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 16:56:35.317747+00	2026-04-03 16:59:35.313068+00	2026-04-03 17:06:35.317747+00	f	\N	2026-04-04 05:01:19.424019+00
cd579f65-044d-412a-97af-7371a3b71614	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 17:01:35.313916+00	2026-04-03 17:02:35.313562+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 16:59:35.313916+00	2026-04-03 17:02:35.321238+00	2026-04-03 17:09:35.313916+00	f	\N	2026-04-04 05:04:19.425294+00
01d563c4-8511-4e2c-806a-ad0cf904ffeb	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 17:04:35.322467+00	2026-04-03 17:05:35.318713+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 17:02:35.322467+00	2026-04-03 17:05:35.331214+00	2026-04-03 17:12:35.322467+00	f	\N	2026-04-04 05:07:19.41333+00
af3dcf8b-dfbf-4986-8ebc-e6442465fb99	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 17:07:35.333227+00	2026-04-03 17:08:35.318176+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 17:05:35.333227+00	2026-04-03 17:08:35.328588+00	2026-04-03 17:15:35.333227+00	f	\N	2026-04-04 05:09:19.435256+00
e9f2e038-6412-49f7-a402-ac9cb9228780	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 17:10:35.330124+00	2026-04-03 17:10:58.660798+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 17:08:35.330124+00	2026-04-03 17:10:58.667017+00	2026-04-03 17:18:35.330124+00	f	\N	2026-04-04 05:11:19.450266+00
4f2d01ad-5aef-4adf-be0f-36a68b606fda	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 17:48:21.233129+00	2026-04-03 17:49:21.222315+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 17:46:21.233129+00	2026-04-03 17:49:21.229444+00	2026-04-03 17:56:21.233129+00	f	\N	2026-04-04 10:18:15.739798+00
6a10cd2f-b449-40b2-b41a-4dbf01f590ce	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 17:57:21.245759+00	2026-04-03 17:58:21.235152+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 17:55:21.245759+00	2026-04-03 17:58:21.244639+00	2026-04-03 18:05:21.245759+00	f	\N	2026-04-04 10:18:15.739798+00
71d7fca6-e1f0-421a-b767-661860a79014	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 20:22:03.379337+00	2026-04-03 20:22:18.506179+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 20:22:03.379337+00	2026-04-03 20:22:18.524885+00	2026-04-03 20:30:03.379337+00	f	\N	2026-04-04 10:18:15.739798+00
77df4998-5b0d-4f04-ae8b-a6c5fdc07ce9	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 21:34:52.553926+00	2026-04-03 21:34:59.572101+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 21:34:52.553926+00	2026-04-03 21:34:59.840563+00	2026-04-03 21:42:52.553926+00	f	\N	2026-04-04 10:18:15.739798+00
ed97c64a-3aab-435d-a7fd-33568ea29a00	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 21:03:43.766564+00	2026-04-03 21:03:49.497639+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 21:03:43.766564+00	2026-04-03 21:03:49.504831+00	2026-04-03 21:11:43.766564+00	f	\N	2026-04-04 10:18:15.739798+00
8553a5bd-e27c-4f35-af85-74d0fbce91d4	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 17:45:21.23251+00	2026-04-03 17:46:21.221371+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 17:43:21.23251+00	2026-04-03 17:46:21.231205+00	2026-04-03 17:53:21.23251+00	f	\N	2026-04-04 10:18:15.739798+00
e6d4634d-4641-4c3e-95c2-b2327344fcf5	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 17:51:21.231223+00	2026-04-03 17:52:21.226918+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 17:49:21.231223+00	2026-04-03 17:52:21.238343+00	2026-04-03 17:59:21.231223+00	f	\N	2026-04-04 10:18:15.739798+00
a51cc398-26ed-46d6-87ee-73407da34cf3	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 17:54:21.240463+00	2026-04-03 17:55:21.230972+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 17:52:21.240463+00	2026-04-03 17:55:21.24429+00	2026-04-03 18:02:21.240463+00	f	\N	2026-04-04 10:18:15.739798+00
d1aa8e6c-100d-413f-bfab-37616324325d	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 18:00:21.245498+00	2026-04-03 18:01:17.940206+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 17:58:21.245498+00	2026-04-03 18:01:17.950676+00	2026-04-03 18:08:21.245498+00	f	\N	2026-04-04 10:18:15.739798+00
6a203e0e-1d3c-4308-bca4-89c9f0554d81	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 18:03:17.951587+00	2026-04-03 18:52:29.343838+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 18:01:17.951587+00	2026-04-03 18:52:29.355779+00	2026-04-03 18:11:17.951587+00	f	\N	2026-04-04 10:18:15.739798+00
b7008c23-0246-41b7-ac89-d50a84b2a6b1	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 19:28:23.418955+00	2026-04-03 19:28:28.407279+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 19:28:23.418955+00	2026-04-03 19:28:28.41871+00	2026-04-03 19:36:23.418955+00	f	\N	2026-04-04 10:18:15.739798+00
a84a9c99-b9c2-4a02-a912-7c832a4072d5	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 20:48:01.007461+00	2026-04-03 20:48:08.014826+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 20:48:01.007461+00	2026-04-03 20:48:08.030964+00	2026-04-03 20:56:01.007461+00	f	\N	2026-04-04 10:18:15.739798+00
4c04f078-9877-4ab3-ba52-3d4e48864ea0	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 17:12:58.667769+00	2026-04-03 17:22:55.518657+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 17:10:58.667769+00	2026-04-03 17:22:55.530103+00	2026-04-03 17:20:58.667769+00	f	\N	2026-04-04 10:18:15.739798+00
74f91ba0-2f23-45de-831f-7c6ae1657bbf	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 22:05:49.510725+00	2026-04-03 22:05:56.518544+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 22:05:49.510725+00	2026-04-03 22:05:56.685532+00	2026-04-03 22:13:49.510725+00	f	\N	2026-04-04 10:18:15.739798+00
ca69a676-2535-4a98-8b06-92f239e50ac6	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 17:24:55.531677+00	2026-04-03 17:25:21.18394+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 17:22:55.531677+00	2026-04-03 17:25:21.192695+00	2026-04-03 17:32:55.531677+00	f	\N	2026-04-04 10:18:15.739798+00
62f25a8b-5d35-4e14-b4e4-15cebc0d0798	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 17:27:21.194311+00	2026-04-03 17:28:21.186302+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 17:25:21.194311+00	2026-04-03 17:28:21.197212+00	2026-04-03 17:35:21.194311+00	f	\N	2026-04-04 10:18:15.739798+00
c10b9089-1316-48b5-98fe-d71b945eebfd	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 17:30:21.198876+00	2026-04-03 17:31:21.195209+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 17:28:21.198876+00	2026-04-03 17:31:21.206879+00	2026-04-03 17:38:21.198876+00	f	\N	2026-04-04 10:18:15.739798+00
fc17a0aa-2e26-47cd-b1c0-b08af544235b	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 17:33:21.20812+00	2026-04-03 17:34:21.191032+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 17:31:21.20812+00	2026-04-03 17:34:21.198576+00	2026-04-03 17:41:21.20812+00	f	\N	2026-04-04 10:18:15.739798+00
b129e587-7911-4e9c-9e01-bc1b8cdaf94d	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 17:36:21.200029+00	2026-04-03 17:37:21.196759+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 17:34:21.200029+00	2026-04-03 17:37:21.207003+00	2026-04-03 17:44:21.200029+00	f	\N	2026-04-04 10:18:15.739798+00
44893d79-863b-4eea-b404-c0b8ba7bfc10	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 17:39:21.209208+00	2026-04-03 17:40:21.207383+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 17:37:21.209208+00	2026-04-03 17:40:21.219449+00	2026-04-03 17:47:21.209208+00	f	\N	2026-04-04 10:18:15.739798+00
b5f717c6-e924-45f5-b78c-05fbeadc9643	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 17:42:21.221465+00	2026-04-03 17:43:21.220211+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 17:40:21.221465+00	2026-04-03 17:43:21.230812+00	2026-04-03 17:50:21.221465+00	f	\N	2026-04-04 10:18:15.739798+00
cab69b30-0646-473b-ad53-8d7972d42bf0	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 22:31:43.46944+00	2026-04-03 22:31:50.488375+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 22:31:43.46944+00	2026-04-03 22:31:50.549539+00	2026-04-03 22:39:43.46944+00	f	\N	2026-04-04 10:39:21.29645+00
37cd637a-dba0-4ddb-867a-c9e4aa59e384	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 22:47:30.612983+00	2026-04-03 22:47:37.614357+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 22:47:30.612983+00	2026-04-03 22:47:37.723963+00	2026-04-03 22:55:30.612983+00	f	\N	2026-04-04 10:48:21.283699+00
ae7f2d27-a523-49b1-98f5-bde5f40d575c	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 23:26:19.664751+00	2026-04-03 23:26:33.866373+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 23:26:19.664751+00	2026-04-03 23:26:34.152295+00	2026-04-03 23:34:19.664751+00	f	\N	2026-04-04 11:28:21.385321+00
d09e650a-d633-47b2-9b9d-457189c3a5b3	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-03 23:53:13.434607+00	2026-04-03 23:53:27.595908+00	__pgboss__maintenance	\N	00:15:00	2026-04-03 23:53:13.434607+00	2026-04-03 23:53:27.879585+00	2026-04-04 00:01:13.434607+00	f	\N	2026-04-04 12:13:55.340296+00
4a0a95c2-7ff5-4981-abb7-19dd3ea95468	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 00:09:38.680024+00	2026-04-04 00:09:43.683332+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 00:09:38.680024+00	2026-04-04 00:09:43.899853+00	2026-04-04 00:17:38.680024+00	f	\N	2026-04-04 12:13:55.340296+00
b14aae14-4b94-4b61-a64b-6adf90576e1b	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 00:31:06.885676+00	2026-04-04 00:31:15.625044+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 00:31:06.885676+00	2026-04-04 00:31:15.638293+00	2026-04-04 00:39:06.885676+00	f	\N	2026-04-04 12:33:55.3681+00
d204960c-7075-4b8f-aff9-9a7e0b7890f8	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 00:51:57.830739+00	2026-04-04 00:52:03.567672+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 00:51:57.830739+00	2026-04-04 00:52:03.576276+00	2026-04-04 00:59:57.830739+00	f	\N	2026-04-04 12:54:02.38603+00
c683233c-cf11-49d9-bb05-c063609c5393	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 01:25:24.082898+00	2026-04-04 01:25:31.825692+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 01:25:24.082898+00	2026-04-04 01:25:31.835515+00	2026-04-04 01:33:24.082898+00	f	\N	2026-04-04 13:28:15.204499+00
9a360d8b-47b8-442f-8f9d-b718e65f53f9	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 01:27:31.836468+00	2026-04-04 01:38:17.259804+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 01:25:31.836468+00	2026-04-04 01:38:17.272192+00	2026-04-04 01:35:31.836468+00	f	\N	2026-04-04 13:38:33.644539+00
80aeda52-3bb4-4640-9ac1-3b23a44c113c	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 01:40:17.273876+00	2026-04-04 01:41:17.230811+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 01:38:17.273876+00	2026-04-04 01:41:17.241176+00	2026-04-04 01:48:17.273876+00	f	\N	2026-04-04 13:41:26.551894+00
1b496ccc-9804-41d7-8051-dd8891f345d4	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 01:43:17.243599+00	2026-04-04 01:43:17.252998+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 01:41:17.243599+00	2026-04-04 01:43:17.261799+00	2026-04-04 01:51:17.243599+00	f	\N	2026-04-04 14:04:22.427295+00
fa4034b7-5422-4f43-9dd9-2cd3840288c4	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 01:51:16.037305+00	2026-04-04 01:51:17.989953+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 01:49:16.037305+00	2026-04-04 01:51:18.00106+00	2026-04-04 01:59:16.037305+00	f	\N	2026-04-04 14:04:22.427295+00
9f06f9d5-a685-457a-bdd8-da5cc1f8ee50	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 01:59:18.008452+00	2026-04-04 02:00:17.997256+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 01:57:18.008452+00	2026-04-04 02:00:18.00832+00	2026-04-04 02:07:18.008452+00	f	\N	2026-04-04 14:04:22.427295+00
76bc55d0-ad0e-4041-9396-631aab78033c	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 01:45:17.264332+00	2026-04-04 01:46:17.254492+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 01:43:17.264332+00	2026-04-04 01:46:17.266707+00	2026-04-04 01:53:17.264332+00	f	\N	2026-04-04 14:04:22.427295+00
d0ff82f6-f285-4df7-93f4-7657e72e4e74	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 01:53:18.00259+00	2026-04-04 01:54:17.99054+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 01:51:18.00259+00	2026-04-04 01:54:17.997977+00	2026-04-04 02:01:18.00259+00	f	\N	2026-04-04 14:04:22.427295+00
569c1777-1e92-4317-a467-81c17a409502	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 02:02:18.009832+00	2026-04-04 02:03:17.999724+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 02:00:18.009832+00	2026-04-04 02:03:18.011776+00	2026-04-04 02:10:18.009832+00	f	\N	2026-04-04 14:04:22.427295+00
14a4bdea-eca3-43ac-a935-06896bef9780	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 01:48:17.268226+00	2026-04-04 01:49:16.027189+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 01:46:17.268226+00	2026-04-04 01:49:16.036045+00	2026-04-04 01:56:17.268226+00	f	\N	2026-04-04 14:04:22.427295+00
0fe358bb-e671-419c-aade-56b35ba318d4	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 01:56:17.999134+00	2026-04-04 01:57:17.994572+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 01:54:17.999134+00	2026-04-04 01:57:18.006969+00	2026-04-04 02:04:17.999134+00	f	\N	2026-04-04 14:04:22.427295+00
7d89e9e2-97ac-4607-b28e-34261e0e7b97	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 02:05:18.013464+00	2026-04-04 02:06:17.986607+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 02:03:18.013464+00	2026-04-04 02:06:17.99772+00	2026-04-04 02:13:18.013464+00	f	\N	2026-04-04 14:07:22.425084+00
3bc42e73-ac74-40ad-a9af-913759926f6c	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 02:08:17.999417+00	2026-04-04 02:09:17.987784+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 02:06:17.999417+00	2026-04-04 02:09:17.996496+00	2026-04-04 02:16:17.999417+00	f	\N	2026-04-04 14:10:22.407139+00
f6e95988-6fdc-4179-abc3-38a6fff0ab4a	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 02:11:17.998938+00	2026-04-04 02:12:17.988845+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 02:09:17.998938+00	2026-04-04 02:12:18.001163+00	2026-04-04 02:19:17.998938+00	f	\N	2026-04-04 14:13:22.413336+00
1b802576-94e4-4245-8ca2-dc5ad9bda226	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 02:14:18.002773+00	2026-04-04 02:15:17.987349+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 02:12:18.002773+00	2026-04-04 02:15:17.997693+00	2026-04-04 02:22:18.002773+00	f	\N	2026-04-04 14:15:59.074833+00
60f0d23c-51c0-4987-80f9-c46aefca4788	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 02:17:17.999509+00	2026-04-04 02:18:17.988375+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 02:15:17.999509+00	2026-04-04 02:18:17.997989+00	2026-04-04 02:25:17.999509+00	f	\N	2026-04-04 14:18:59.08121+00
e6002df2-b38b-45c6-889e-d5bf7fe69dc0	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 02:20:18.000058+00	2026-04-04 02:21:17.989307+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 02:18:18.000058+00	2026-04-04 02:21:18.001146+00	2026-04-04 02:28:18.000058+00	f	\N	2026-04-04 14:21:59.07662+00
ec27268c-d99f-48e7-b996-9bd892461a6c	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 02:23:18.002656+00	2026-04-04 02:24:17.993742+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 02:21:18.002656+00	2026-04-04 02:24:18.003885+00	2026-04-04 02:31:18.002656+00	f	\N	2026-04-04 14:25:09.647079+00
c328b737-e05b-4f3b-8330-bec75deddd3e	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 02:26:18.005484+00	2026-04-04 02:27:17.992889+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 02:24:18.005484+00	2026-04-04 02:27:18.00222+00	2026-04-04 02:34:18.005484+00	f	\N	2026-04-04 14:40:54.004949+00
c0eee05c-fd68-4eff-b160-125a190d81ce	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 02:34:15.465186+00	2026-04-04 02:34:16.536736+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 02:32:15.465186+00	2026-04-04 02:34:16.542218+00	2026-04-04 02:42:15.465186+00	f	\N	2026-04-04 14:40:54.004949+00
46e3fe34-0e9d-4ba6-91ca-74c1dcff42c9	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 02:29:18.004805+00	2026-04-04 02:29:18.023606+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 02:27:18.004805+00	2026-04-04 02:29:18.033389+00	2026-04-04 02:37:18.004805+00	f	\N	2026-04-04 14:40:54.004949+00
622e6086-2ecf-4f96-95c0-22018d26f5db	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 02:36:16.543394+00	2026-04-04 02:37:15.52598+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 02:34:16.543394+00	2026-04-04 02:37:15.533074+00	2026-04-04 02:44:16.543394+00	f	\N	2026-04-04 14:40:54.004949+00
6d188c3b-cdd3-4a57-9ed1-4e0e1e980316	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 02:31:18.035355+00	2026-04-04 02:32:15.458729+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 02:29:18.035355+00	2026-04-04 02:32:15.4642+00	2026-04-04 02:39:18.035355+00	f	\N	2026-04-04 14:40:54.004949+00
78d99525-3446-4a63-9200-949ee68c877c	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 02:39:15.534419+00	2026-04-04 02:39:18.490958+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 02:37:15.534419+00	2026-04-04 02:39:18.49959+00	2026-04-04 02:47:15.534419+00	f	\N	2026-04-04 14:40:54.004949+00
ee2d413d-dcea-4af0-9c99-dfa655f108cf	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 02:41:18.50073+00	2026-04-04 02:42:18.490538+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 02:39:18.50073+00	2026-04-04 02:42:18.500471+00	2026-04-04 02:49:18.50073+00	f	\N	2026-04-04 14:43:53.993167+00
e8f8f445-7506-43c8-9a14-b18ef0ecd5be	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 02:44:18.501854+00	2026-04-04 02:45:18.497842+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 02:42:18.501854+00	2026-04-04 02:45:18.50738+00	2026-04-04 02:52:18.501854+00	f	\N	2026-04-04 14:45:54.002636+00
01a2ab0a-3980-47a7-8270-194a792f8030	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 02:47:18.509937+00	2026-04-04 02:48:18.506869+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 02:45:18.509937+00	2026-04-04 02:48:18.516834+00	2026-04-04 02:55:18.509937+00	f	\N	2026-04-04 14:49:57.379743+00
b5e1fcae-ee21-4c86-a5fd-f5c854228ab0	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 02:50:18.518751+00	2026-04-04 02:51:18.512538+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 02:48:18.518751+00	2026-04-04 02:51:18.522507+00	2026-04-04 02:58:18.518751+00	f	\N	2026-04-04 14:52:57.39144+00
1cf81459-4e0a-4382-be5d-d2f49f248243	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 02:53:18.524186+00	2026-04-04 02:54:18.508628+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 02:51:18.524186+00	2026-04-04 02:54:18.513417+00	2026-04-04 03:01:18.524186+00	f	\N	2026-04-04 14:55:57.384847+00
ef3df861-ad5d-445d-a289-3723a0ecb1d4	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 02:56:18.514426+00	2026-04-04 02:56:18.516702+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 02:54:18.514426+00	2026-04-04 02:56:18.528439+00	2026-04-04 03:04:18.514426+00	f	\N	2026-04-04 14:58:57.388717+00
f8c5823b-338d-4609-9e1b-18cf88fb87cd	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 02:58:18.529987+00	2026-04-04 02:59:18.519174+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 02:56:18.529987+00	2026-04-04 02:59:18.528424+00	2026-04-04 03:06:18.529987+00	f	\N	2026-04-04 15:01:09.813745+00
08b0de88-2c2a-4660-a697-15c239e13cbc	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 03:01:18.529762+00	2026-04-04 03:02:18.519783+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 02:59:18.529762+00	2026-04-04 03:02:18.525753+00	2026-04-04 03:09:18.529762+00	f	\N	2026-04-04 15:03:12.090072+00
c171d623-fc6c-49cb-afe9-1651b8c08cbb	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 03:06:18.544352+00	2026-04-04 03:07:18.544503+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 03:04:18.544352+00	2026-04-04 03:07:18.550258+00	2026-04-04 03:14:18.544352+00	f	\N	2026-04-04 15:07:56.091844+00
82be8a80-c278-4101-9ce6-e6c651ee22fb	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 03:04:18.526752+00	2026-04-04 03:04:18.53784+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 03:02:18.526752+00	2026-04-04 03:04:18.543437+00	2026-04-04 03:12:18.526752+00	f	\N	2026-04-04 15:07:56.091844+00
d65b189f-c0af-4892-92aa-392beed9d461	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 03:09:18.551565+00	2026-04-04 03:10:18.550708+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 03:07:18.551565+00	2026-04-04 03:10:18.558336+00	2026-04-04 03:17:18.551565+00	f	\N	2026-04-04 15:10:56.093759+00
da2ebe30-256e-4e1a-be16-5b99a6b8e212	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 03:12:18.560029+00	2026-04-04 03:13:18.55429+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 03:10:18.560029+00	2026-04-04 03:13:18.566687+00	2026-04-04 03:20:18.560029+00	f	\N	2026-04-04 15:13:56.08817+00
6158057e-c884-4caf-8df8-89405f06686a	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 03:15:18.568209+00	2026-04-04 03:16:18.560115+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 03:13:18.568209+00	2026-04-04 03:16:18.571364+00	2026-04-04 03:23:18.568209+00	f	\N	2026-04-04 15:17:00.149332+00
a550551f-f930-4c94-85d3-1857fc3fa2ab	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 03:18:18.573493+00	2026-04-04 03:19:18.5692+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 03:16:18.573493+00	2026-04-04 03:19:18.57979+00	2026-04-04 03:26:18.573493+00	f	\N	2026-04-04 15:22:00.158006+00
9f5f0962-1ecd-4802-b2e7-675b076367e1	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 03:21:18.581574+00	2026-04-04 03:22:18.578467+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 03:19:18.581574+00	2026-04-04 03:22:18.593193+00	2026-04-04 03:29:18.581574+00	f	\N	2026-04-04 15:25:00.170458+00
1fd0121e-0ec6-4410-9131-730f9397ae2a	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 03:24:18.594669+00	2026-04-04 03:25:18.584032+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 03:22:18.594669+00	2026-04-04 03:25:18.594016+00	2026-04-04 03:32:18.594669+00	f	\N	2026-04-04 15:28:00.16906+00
4325507a-c229-4fb0-a920-c7557904f09b	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 03:27:18.595339+00	2026-04-04 03:28:18.587472+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 03:25:18.595339+00	2026-04-04 03:28:18.602396+00	2026-04-04 03:35:18.595339+00	f	\N	2026-04-04 15:31:00.175308+00
cb0db009-03bc-4794-8921-0df6093fc6d8	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 03:30:18.604032+00	2026-04-04 03:31:18.589666+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 03:28:18.604032+00	2026-04-04 03:31:18.599661+00	2026-04-04 03:38:18.604032+00	f	\N	2026-04-04 15:33:00.200678+00
2b19850a-ee38-4db4-bbca-1f13de8d1a12	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 03:33:18.601161+00	2026-04-04 03:34:18.596159+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 03:31:18.601161+00	2026-04-04 03:34:18.607702+00	2026-04-04 03:41:18.601161+00	f	\N	2026-04-04 15:36:00.191533+00
92511ce4-c276-4522-8919-ae7aa06fed21	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 03:36:18.609243+00	2026-04-04 03:37:18.593781+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 03:34:18.609243+00	2026-04-04 03:37:18.60706+00	2026-04-04 03:44:18.609243+00	f	\N	2026-04-04 15:39:00.202313+00
25e38222-4011-461c-bb5b-cd7c08dbd0cb	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 03:39:18.608472+00	2026-04-04 03:40:18.596074+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 03:37:18.608472+00	2026-04-04 03:40:18.608948+00	2026-04-04 03:47:18.608472+00	f	\N	2026-04-04 15:42:00.196306+00
0ca4b073-a3ae-45c4-9161-1aa86ed8745b	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 03:42:18.611178+00	2026-04-04 03:43:18.602057+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 03:40:18.611178+00	2026-04-04 03:43:18.614538+00	2026-04-04 03:50:18.611178+00	f	\N	2026-04-04 15:45:00.205893+00
066af196-6f35-44de-b742-0114afa08729	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 03:45:18.616382+00	2026-04-04 03:46:18.606648+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 03:43:18.616382+00	2026-04-04 03:46:18.617528+00	2026-04-04 03:53:18.616382+00	f	\N	2026-04-04 15:48:00.204382+00
ccbc574d-6d2b-4c25-bea2-4cce15270148	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 03:48:18.619223+00	2026-04-04 03:49:18.605312+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 03:46:18.619223+00	2026-04-04 03:49:18.612083+00	2026-04-04 03:56:18.619223+00	f	\N	2026-04-04 15:51:00.183378+00
26b8c9a1-7a61-49bc-990a-285d856be8da	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 03:51:18.613056+00	2026-04-04 03:52:18.576176+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 03:49:18.613056+00	2026-04-04 03:52:18.585383+00	2026-04-04 03:59:18.613056+00	f	\N	2026-04-04 15:54:00.185313+00
68187e21-59ec-4353-bec0-5ea3df62d728	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 03:54:18.586706+00	2026-04-04 03:55:18.579853+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 03:52:18.586706+00	2026-04-04 03:55:18.589209+00	2026-04-04 04:02:18.586706+00	f	\N	2026-04-04 15:57:00.176511+00
58aa0267-3b2a-4f9d-bbc7-b65299698a04	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 03:57:18.591411+00	2026-04-04 03:58:18.583012+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 03:55:18.591411+00	2026-04-04 03:58:18.593108+00	2026-04-04 04:05:18.591411+00	f	\N	2026-04-04 15:59:00.191409+00
549338a6-e990-4a9a-a857-9282f3fcf6e3	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 04:00:18.595137+00	2026-04-04 04:01:18.584504+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 03:58:18.595137+00	2026-04-04 04:01:18.594243+00	2026-04-04 04:08:18.595137+00	f	\N	2026-04-04 16:02:00.180234+00
94a13a01-bace-4ffb-9c9f-961395e0cf8f	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 04:03:18.596362+00	2026-04-04 04:04:18.589866+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 04:01:18.596362+00	2026-04-04 04:04:18.601349+00	2026-04-04 04:11:18.596362+00	f	\N	2026-04-04 16:05:00.214595+00
44e1f728-41c8-46c5-9094-1450902fa3af	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 04:06:18.603329+00	2026-04-04 04:07:18.58762+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 04:04:18.603329+00	2026-04-04 04:07:18.598062+00	2026-04-04 04:14:18.603329+00	f	\N	2026-04-04 16:08:00.21315+00
4744eef5-e96e-4bfd-a25f-7437b292bbab	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 04:09:18.599938+00	2026-04-04 04:10:18.579045+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 04:07:18.599938+00	2026-04-04 04:10:18.590844+00	2026-04-04 04:17:18.599938+00	f	\N	2026-04-04 16:11:00.225355+00
41fba3a1-2840-4f1c-ae96-5d6bec87b0b9	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 04:12:18.593003+00	2026-04-04 04:13:18.583059+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 04:10:18.593003+00	2026-04-04 04:13:18.595171+00	2026-04-04 04:20:18.593003+00	f	\N	2026-04-04 16:14:00.227349+00
52127d6b-4057-4bf7-9ebb-8750209badd8	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 04:15:18.596673+00	2026-04-04 04:16:18.587119+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 04:13:18.596673+00	2026-04-04 04:16:18.595783+00	2026-04-04 04:23:18.596673+00	f	\N	2026-04-04 16:17:00.220603+00
179769f2-629a-42e9-acf8-0426deb4812b	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 04:18:18.596861+00	2026-04-04 04:19:17.580857+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 04:16:18.596861+00	2026-04-04 04:19:17.591962+00	2026-04-04 04:26:18.596861+00	f	\N	2026-04-04 16:20:00.224851+00
5eaae2fa-8fb0-4fb4-a350-6361ed6b66e7	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 04:21:17.593327+00	2026-04-04 04:21:18.581711+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 04:19:17.593327+00	2026-04-04 04:21:18.59135+00	2026-04-04 04:29:17.593327+00	f	\N	2026-04-04 16:23:00.238211+00
7c0ed298-f37d-431d-86c3-c374c41aa74e	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 04:23:18.593088+00	2026-04-04 04:24:18.589086+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 04:21:18.593088+00	2026-04-04 04:24:18.602218+00	2026-04-04 04:31:18.593088+00	f	\N	2026-04-04 16:26:00.242927+00
26b14b44-30dc-40ee-b64e-a115ab7584eb	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 04:26:18.603816+00	2026-04-04 04:27:17.57759+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 04:24:18.603816+00	2026-04-04 04:27:17.587003+00	2026-04-04 04:34:18.603816+00	f	\N	2026-04-04 16:29:00.247421+00
e42e982e-1a77-4b40-ae3b-0cacd36afc09	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 04:29:17.588961+00	2026-04-04 04:29:18.596425+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 04:27:17.588961+00	2026-04-04 04:29:18.608725+00	2026-04-04 04:37:17.588961+00	f	\N	2026-04-04 16:32:00.239338+00
19775134-6bc8-4d42-8bf8-863917684883	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 04:31:18.610187+00	2026-04-04 04:32:18.444031+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 04:29:18.610187+00	2026-04-04 04:32:18.454478+00	2026-04-04 04:39:18.610187+00	f	\N	2026-04-04 16:35:00.253006+00
b12a4f3d-d8a8-4ee9-92c2-9eba22bcbab7	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 04:34:18.457004+00	2026-04-04 04:34:19.405475+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 04:32:18.457004+00	2026-04-04 04:34:19.417362+00	2026-04-04 04:42:18.457004+00	f	\N	2026-04-04 16:35:00.253006+00
4902dab4-1857-45a4-8ba7-4e670337e0e6	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 04:36:19.418837+00	2026-04-04 04:37:19.403266+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 04:34:19.418837+00	2026-04-04 04:37:19.412124+00	2026-04-04 04:44:19.418837+00	f	\N	2026-04-04 16:38:00.230418+00
d994341b-4b89-47fa-92c1-97d53cfabe98	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 04:39:19.414192+00	2026-04-04 04:40:19.404185+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 04:37:19.414192+00	2026-04-04 04:40:19.413101+00	2026-04-04 04:47:19.414192+00	f	\N	2026-04-04 16:41:00.208478+00
38ccc28d-14e0-44c2-b45d-a605cdcebb6c	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 04:42:19.41477+00	2026-04-04 04:43:19.411256+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 04:40:19.41477+00	2026-04-04 04:43:19.421499+00	2026-04-04 04:50:19.41477+00	f	\N	2026-04-04 16:44:00.201822+00
f3cbf1d0-5240-46db-88e2-9115ae462fc1	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 04:45:19.423106+00	2026-04-04 04:46:19.413829+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 04:43:19.423106+00	2026-04-04 04:46:19.424288+00	2026-04-04 04:53:19.423106+00	f	\N	2026-04-04 16:47:00.20537+00
0005a71c-dac8-42ff-bade-fdbda810ad1b	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 04:48:19.426168+00	2026-04-04 04:49:19.415845+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 04:46:19.426168+00	2026-04-04 04:49:19.428145+00	2026-04-04 04:56:19.426168+00	f	\N	2026-04-04 16:50:00.216572+00
0101fb02-b1a8-425d-8be4-b59336b5cad7	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 04:51:19.429568+00	2026-04-04 04:52:19.412967+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 04:49:19.429568+00	2026-04-04 04:52:19.424939+00	2026-04-04 04:59:19.429568+00	f	\N	2026-04-04 16:53:00.220696+00
b7e901c1-a13d-497a-a569-d4a996cc2edb	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 04:54:19.426308+00	2026-04-04 04:55:19.410033+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 04:52:19.426308+00	2026-04-04 04:55:19.422208+00	2026-04-04 05:02:19.426308+00	f	\N	2026-04-04 16:58:00.245752+00
3535c5e1-30f3-4e0d-8945-6a9a637ee7b5	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 04:57:19.423581+00	2026-04-04 04:58:19.415055+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 04:55:19.423581+00	2026-04-04 04:58:19.422909+00	2026-04-04 05:05:19.423581+00	f	\N	2026-04-04 17:01:00.247806+00
62e5e236-76ec-4c38-bda6-ab3e89f587fd	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 05:00:19.430008+00	2026-04-04 05:01:19.416683+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 04:58:19.430008+00	2026-04-04 05:01:19.428626+00	2026-04-04 05:08:19.430008+00	f	\N	2026-04-04 17:03:00.261409+00
8ef986b2-ba70-4d07-aa4d-5b7f5dd00833	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 05:03:19.430567+00	2026-04-04 05:04:19.416596+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 05:01:19.430567+00	2026-04-04 05:04:19.428917+00	2026-04-04 05:11:19.430567+00	f	\N	2026-04-04 17:06:00.272591+00
5fd810f0-236b-4804-a347-dcc183890777	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 05:06:19.430322+00	2026-04-04 05:07:19.410231+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 05:04:19.430322+00	2026-04-04 05:07:19.415146+00	2026-04-04 05:14:19.430322+00	f	\N	2026-04-04 17:09:00.269439+00
1f7b2c40-2ffa-4bed-bb47-b859efec6b7d	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 05:11:19.4389+00	2026-04-04 05:11:19.444711+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 05:09:19.4389+00	2026-04-04 05:11:19.453381+00	2026-04-04 05:19:19.4389+00	f	\N	2026-04-04 17:12:00.234391+00
59677b7d-cc29-487d-97bb-88280da68c3d	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 05:09:19.416021+00	2026-04-04 05:09:19.429063+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 05:07:19.416021+00	2026-04-04 05:09:19.437783+00	2026-04-04 05:17:19.416021+00	f	\N	2026-04-04 17:12:00.234391+00
40a9846b-0aeb-4a31-96ca-4985986dc997	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 05:13:19.454947+00	2026-04-04 05:14:19.447003+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 05:11:19.454947+00	2026-04-04 05:14:19.460224+00	2026-04-04 05:21:19.454947+00	f	\N	2026-04-04 17:15:00.249736+00
2c005710-1edf-4ac8-9de9-3e8612d1bdc4	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 05:16:19.461843+00	2026-04-04 05:17:19.446115+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 05:14:19.461843+00	2026-04-04 05:17:19.456811+00	2026-04-04 05:24:19.461843+00	f	\N	2026-04-04 17:18:00.252476+00
e49f579a-4553-461b-a6cb-a4a3519ed43c	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 10:26:15.74542+00	2026-04-04 10:27:15.72414+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 10:24:15.74542+00	2026-04-04 10:27:15.729836+00	2026-04-04 10:34:15.74542+00	f	\N	2026-04-04 22:30:03.019088+00
624e136c-60ff-4f3a-88b7-f2904d4ab0fe	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 10:18:15.72825+00	2026-04-04 10:18:15.732176+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 10:18:15.72825+00	2026-04-04 10:18:15.744274+00	2026-04-04 10:26:15.72825+00	f	\N	2026-04-04 22:30:03.019088+00
04a5b503-1de4-49f4-93a4-24df3fe0a858	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 10:20:15.745552+00	2026-04-04 10:21:15.732183+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 10:18:15.745552+00	2026-04-04 10:21:15.741098+00	2026-04-04 10:28:15.745552+00	f	\N	2026-04-04 22:30:03.019088+00
f5015d7b-fa88-40c2-81da-c49b9b3129a7	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 10:23:15.742949+00	2026-04-04 10:24:15.733646+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 10:21:15.742949+00	2026-04-04 10:24:15.743846+00	2026-04-04 10:31:15.742949+00	f	\N	2026-04-04 22:30:03.019088+00
572a09b0-dd64-47ab-88ce-9f684de66cec	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 10:47:21.299929+00	2026-04-04 10:48:21.280332+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 10:45:21.299929+00	2026-04-04 10:48:21.286497+00	2026-04-04 10:55:21.299929+00	f	\N	2026-04-04 23:52:03.908417+00
46be8049-d9b4-494d-a5f0-0e37c28bd2cc	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 10:55:21.347057+00	2026-04-04 10:56:21.338366+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 10:53:21.347057+00	2026-04-04 10:56:21.347074+00	2026-04-04 11:03:21.347057+00	f	\N	2026-04-04 23:52:03.908417+00
1dbaeaf8-a5bf-4c52-acc3-2a56ff6a8ad9	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 11:04:21.34069+00	2026-04-04 11:05:21.335434+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 11:02:21.34069+00	2026-04-04 11:05:21.342243+00	2026-04-04 11:12:21.34069+00	f	\N	2026-04-04 23:52:03.908417+00
c0d31008-b495-4e2f-b024-a759b74d6457	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 11:12:21.381244+00	2026-04-04 11:13:21.374806+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 11:10:21.381244+00	2026-04-04 11:13:21.383121+00	2026-04-04 11:20:21.381244+00	f	\N	2026-04-04 23:52:03.908417+00
605aeb31-ea30-4a84-8cee-182206d63811	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 10:41:21.307314+00	2026-04-04 10:42:21.28452+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 10:39:21.307314+00	2026-04-04 10:42:21.294057+00	2026-04-04 10:49:21.307314+00	f	\N	2026-04-04 23:52:03.908417+00
a843be63-9670-4764-9934-c49e4be08411	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 10:44:21.295985+00	2026-04-04 10:45:21.284845+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 10:42:21.295985+00	2026-04-04 10:45:21.297982+00	2026-04-04 10:52:21.295985+00	f	\N	2026-04-04 23:52:03.908417+00
d378579a-d92f-4ece-9ae8-92e62a791f0d	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 10:50:21.287578+00	2026-04-04 10:50:21.337884+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 10:48:21.287578+00	2026-04-04 10:50:21.348363+00	2026-04-04 10:58:21.287578+00	f	\N	2026-04-04 23:52:03.908417+00
f9ba885c-8381-4cc6-bba8-ebe6a836946b	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 10:58:21.349279+00	2026-04-04 10:59:21.341091+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 10:56:21.349279+00	2026-04-04 10:59:21.351313+00	2026-04-04 11:06:21.349279+00	f	\N	2026-04-04 23:52:03.908417+00
573ffbff-d822-4664-a1cd-4a519ac9ca4a	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 11:07:21.34311+00	2026-04-04 11:07:21.371052+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 11:05:21.34311+00	2026-04-04 11:07:21.37803+00	2026-04-04 11:15:21.34311+00	f	\N	2026-04-04 23:52:03.908417+00
552875d5-0852-4470-b0db-68c2bc3abb39	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 11:15:21.384748+00	2026-04-04 11:16:21.37872+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 11:13:21.384748+00	2026-04-04 11:16:21.389167+00	2026-04-04 11:23:21.384748+00	f	\N	2026-04-04 23:52:03.908417+00
6c8bb932-238d-4b9a-a2b2-409a7e833492	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 11:21:21.385978+00	2026-04-04 11:22:21.378964+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 11:19:21.385978+00	2026-04-04 11:22:21.391594+00	2026-04-04 11:29:21.385978+00	f	\N	2026-04-04 23:52:03.908417+00
bf00652f-0316-4dff-88eb-b95c77bc6ba7	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 10:29:15.731129+00	2026-04-04 10:30:15.717704+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 10:27:15.731129+00	2026-04-04 10:30:15.726701+00	2026-04-04 10:37:15.731129+00	f	\N	2026-04-04 23:52:03.908417+00
c59c97e4-abde-4802-b52d-781b2053cc42	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 11:24:21.393793+00	2026-04-04 11:25:21.387345+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 11:22:21.393793+00	2026-04-04 11:25:21.399048+00	2026-04-04 11:32:21.393793+00	f	\N	2026-04-04 23:52:03.908417+00
85a02995-ef69-4d4f-a6e2-c2cfb7e610de	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 11:30:21.390386+00	2026-04-04 11:31:21.390482+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 11:28:21.390386+00	2026-04-04 11:31:21.403705+00	2026-04-04 11:38:21.390386+00	f	\N	2026-04-04 23:52:03.908417+00
45b5265e-0dd0-466f-9be3-7d3e89b88622	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 11:33:21.405529+00	2026-04-04 11:34:21.383147+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 11:31:21.405529+00	2026-04-04 11:34:21.394515+00	2026-04-04 11:41:21.405529+00	f	\N	2026-04-04 23:52:03.908417+00
0b1abf40-254c-40d9-aa24-bdb8a2f0e12c	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 11:39:21.40634+00	2026-04-04 11:40:21.391202+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 11:37:21.40634+00	2026-04-04 11:40:21.406203+00	2026-04-04 11:47:21.40634+00	f	\N	2026-04-04 23:52:03.908417+00
118bb215-3aea-4ccd-93f2-5a3720e7f0fc	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 11:42:21.408574+00	2026-04-04 11:43:21.378647+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 11:40:21.408574+00	2026-04-04 11:43:21.386628+00	2026-04-04 11:50:21.408574+00	f	\N	2026-04-04 23:52:03.908417+00
8039533d-6d28-435f-9555-1e92c993e009	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 11:48:21.391264+00	2026-04-04 11:49:21.594916+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 11:46:21.391264+00	2026-04-04 11:49:21.601143+00	2026-04-04 11:56:21.391264+00	f	\N	2026-04-04 23:52:03.908417+00
53cea0db-5eca-466c-972b-e0fe7d349e4d	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 10:52:21.350039+00	2026-04-04 10:53:21.337139+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 10:50:21.350039+00	2026-04-04 10:53:21.345382+00	2026-04-04 11:00:21.350039+00	f	\N	2026-04-04 23:52:03.908417+00
406031f8-d356-444f-9d7a-c1567670155b	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 11:01:21.353166+00	2026-04-04 11:02:21.332897+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 10:59:21.353166+00	2026-04-04 11:02:21.338798+00	2026-04-04 11:09:21.353166+00	f	\N	2026-04-04 23:52:03.908417+00
9dfa4a44-14a0-43a3-9555-6c2169c2ff8b	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 11:09:21.379162+00	2026-04-04 11:10:21.37204+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 11:07:21.379162+00	2026-04-04 11:10:21.379627+00	2026-04-04 11:17:21.379162+00	f	\N	2026-04-04 23:52:03.908417+00
e061400a-5085-453b-9170-a7514aa5d174	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 11:18:21.390752+00	2026-04-04 11:19:21.376604+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 11:16:21.390752+00	2026-04-04 11:19:21.385078+00	2026-04-04 11:26:21.390752+00	f	\N	2026-04-04 23:52:03.908417+00
087fe3f7-6e4b-4804-bc69-cfcaf57736ac	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 11:27:21.401219+00	2026-04-04 11:28:21.379645+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 11:25:21.401219+00	2026-04-04 11:28:21.389026+00	2026-04-04 11:35:21.401219+00	f	\N	2026-04-04 23:52:03.908417+00
649e218a-6578-46d0-86ad-e0d9d82d208a	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 11:36:21.396297+00	2026-04-04 11:37:21.394249+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 11:34:21.396297+00	2026-04-04 11:37:21.404587+00	2026-04-04 11:44:21.396297+00	f	\N	2026-04-04 23:52:03.908417+00
36be8623-2ee4-4cb9-9189-fd3f0d4dd829	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 11:45:21.388458+00	2026-04-04 11:46:21.376849+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 11:43:21.388458+00	2026-04-04 11:46:21.38912+00	2026-04-04 11:53:21.388458+00	f	\N	2026-04-04 23:52:03.908417+00
7ac062d6-39f6-4ecc-ba1d-6be7122b5628	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 11:51:21.602356+00	2026-04-04 11:52:03.118572+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 11:49:21.602356+00	2026-04-04 11:52:03.409224+00	2026-04-04 11:59:21.602356+00	f	\N	2026-04-04 23:52:03.908417+00
fe7a12c3-996d-4967-aa15-83346efdd398	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 10:32:15.728377+00	2026-04-04 10:39:21.286459+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 10:30:15.728377+00	2026-04-04 10:39:21.305586+00	2026-04-04 10:40:15.728377+00	f	\N	2026-04-04 23:52:03.908417+00
c12f2d2c-9f84-46d9-a138-ab5563ebdfe2	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 11:54:03.410982+00	2026-04-04 12:13:55.333515+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 11:52:03.410982+00	2026-04-04 12:13:55.345156+00	2026-04-04 12:02:03.410982+00	f	\N	2026-04-05 00:49:44.023623+00
e222d7d3-8fd8-4381-baf2-baf3af54dfcc	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 12:40:55.381749+00	2026-04-04 12:41:55.376213+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 12:38:55.381749+00	2026-04-04 12:41:55.38359+00	2026-04-04 12:48:55.381749+00	f	\N	2026-04-05 00:49:44.023623+00
94f9ce77-2f4b-4691-8da7-dc9f07cd8758	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 12:43:55.384559+00	2026-04-04 12:44:55.373844+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 12:41:55.384559+00	2026-04-04 12:44:55.382948+00	2026-04-04 12:51:55.384559+00	f	\N	2026-04-05 00:49:44.023623+00
1cf680c3-d3b2-4f54-931a-78db1a42277a	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 12:46:55.38474+00	2026-04-04 12:46:55.388712+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 12:44:55.38474+00	2026-04-04 12:46:55.399799+00	2026-04-04 12:54:55.38474+00	f	\N	2026-04-05 00:49:44.023623+00
ac3a289d-4ec4-425b-96c4-54217decfe44	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 12:48:55.401263+00	2026-04-04 12:49:19.040152+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 12:46:55.401263+00	2026-04-04 12:49:19.048618+00	2026-04-04 12:56:55.401263+00	f	\N	2026-04-05 00:49:44.023623+00
a544ddd2-49ce-4c32-83fd-14a018f250e9	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 12:15:55.346751+00	2026-04-04 12:16:55.331688+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 12:13:55.346751+00	2026-04-04 12:16:55.3385+00	2026-04-04 12:23:55.346751+00	f	\N	2026-04-05 00:49:44.023623+00
e1e617ed-be8a-420f-9f6c-b26f2814c7fc	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 12:18:55.339266+00	2026-04-04 12:18:55.345237+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 12:16:55.339266+00	2026-04-04 12:18:55.353295+00	2026-04-04 12:26:55.339266+00	f	\N	2026-04-05 00:49:44.023623+00
47bb168b-4083-4483-9850-f554f258daba	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 12:20:55.355098+00	2026-04-04 12:21:55.354876+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 12:18:55.355098+00	2026-04-04 12:21:55.364052+00	2026-04-04 12:28:55.355098+00	f	\N	2026-04-05 00:49:44.023623+00
7393f223-11b0-4cc1-b26f-2e22022ca090	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 12:23:55.365735+00	2026-04-04 12:24:55.356041+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 12:21:55.365735+00	2026-04-04 12:24:55.364683+00	2026-04-04 12:31:55.365735+00	f	\N	2026-04-05 00:49:44.023623+00
b6d55992-b155-48aa-b7ee-99c65e0f70f9	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 12:26:55.366821+00	2026-04-04 12:27:55.356708+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 12:24:55.366821+00	2026-04-04 12:27:55.365473+00	2026-04-04 12:34:55.366821+00	f	\N	2026-04-05 00:49:44.023623+00
d5d8ced4-ef18-4454-b3e5-26f9266b016f	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 12:29:55.367181+00	2026-04-04 12:30:55.360255+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 12:27:55.367181+00	2026-04-04 12:30:55.369059+00	2026-04-04 12:37:55.367181+00	f	\N	2026-04-05 00:49:44.023623+00
adf085f0-6e02-4693-91c4-858f4579d787	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 12:32:55.370694+00	2026-04-04 12:33:55.363552+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 12:30:55.370694+00	2026-04-04 12:33:55.372331+00	2026-04-04 12:40:55.370694+00	f	\N	2026-04-05 00:49:44.023623+00
708809b5-1895-4a65-b84b-77e942b0860d	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 12:35:55.373837+00	2026-04-04 12:36:55.364403+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 12:33:55.373837+00	2026-04-04 12:36:55.369735+00	2026-04-04 12:43:55.373837+00	f	\N	2026-04-05 00:49:44.023623+00
139f9bda-d7ac-4e12-a4d9-a4906f998cc4	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 12:38:55.371109+00	2026-04-04 12:38:55.374298+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 12:36:55.371109+00	2026-04-04 12:38:55.38055+00	2026-04-04 12:46:55.371109+00	f	\N	2026-04-05 00:49:44.023623+00
59dec74d-56bd-4fe9-8204-dc08c990d5c0	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 12:51:19.049811+00	2026-04-04 12:52:02.367249+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 12:49:19.049811+00	2026-04-04 12:52:02.375077+00	2026-04-04 12:59:19.049811+00	f	\N	2026-04-05 01:10:32.934293+00
c5dcbda2-6458-4d83-aeea-ac5275f8731f	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 12:54:02.376785+00	2026-04-04 12:54:02.3795+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 12:52:02.376785+00	2026-04-04 12:54:02.391627+00	2026-04-04 13:02:02.376785+00	f	\N	2026-04-05 01:10:32.934293+00
f2b93a14-f4ef-4e7b-92a1-478a40f767bb	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 12:56:02.39344+00	2026-04-04 12:56:52.28086+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 12:54:02.39344+00	2026-04-04 12:56:52.294781+00	2026-04-04 13:04:02.39344+00	f	\N	2026-04-05 01:10:32.934293+00
76a10716-6fc0-451d-b135-2eba9eb28018	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 12:58:52.296703+00	2026-04-04 12:59:02.382418+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 12:56:52.296703+00	2026-04-04 12:59:02.387859+00	2026-04-04 13:06:52.296703+00	f	\N	2026-04-05 01:10:32.934293+00
30d3f02f-7db3-4e7e-ab69-12da977b230c	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 13:01:02.389049+00	2026-04-04 13:04:49.639335+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 12:59:02.389049+00	2026-04-04 13:04:49.652207+00	2026-04-04 13:09:02.389049+00	f	\N	2026-04-05 01:10:32.934293+00
5389d3a7-b0c7-4983-811a-e50332181fa2	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 13:06:49.653865+00	2026-04-04 13:07:49.644456+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 13:04:49.653865+00	2026-04-04 13:07:49.655014+00	2026-04-04 13:14:49.653865+00	f	\N	2026-04-05 01:10:32.934293+00
ae4d9d16-568d-46fd-abbb-495e30fab710	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 13:09:49.656292+00	2026-04-04 13:10:49.645409+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 13:07:49.656292+00	2026-04-04 13:10:49.657036+00	2026-04-04 13:17:49.656292+00	f	\N	2026-04-05 01:31:21.838545+00
9e9282cb-cd2c-40a3-87ea-593e453d5a14	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 13:12:49.658597+00	2026-04-04 13:13:49.620836+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 13:10:49.658597+00	2026-04-04 13:13:49.625566+00	2026-04-04 13:20:49.658597+00	f	\N	2026-04-05 01:31:21.838545+00
72e4c560-c5c8-4d2c-8c8c-65ca07d0db09	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 13:15:49.626651+00	2026-04-04 13:15:49.634987+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 13:13:49.626651+00	2026-04-04 13:15:49.6458+00	2026-04-04 13:23:49.626651+00	f	\N	2026-04-05 01:31:21.838545+00
701a1b83-a075-4673-994c-dd139bfb4e86	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 13:17:49.648376+00	2026-04-04 13:18:49.629438+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 13:15:49.648376+00	2026-04-04 13:18:49.635746+00	2026-04-04 13:25:49.648376+00	f	\N	2026-04-05 01:31:21.838545+00
935890eb-1f67-4b37-b31e-31159191d30a	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 13:20:49.637039+00	2026-04-04 13:21:49.634149+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 13:18:49.637039+00	2026-04-04 13:21:49.646414+00	2026-04-04 13:28:49.637039+00	f	\N	2026-04-05 01:31:21.838545+00
f44ab686-24e8-4c62-9bb3-15e67a5df774	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 13:23:49.647853+00	2026-04-04 13:24:49.640327+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 13:21:49.647853+00	2026-04-04 13:24:49.649242+00	2026-04-04 13:31:49.647853+00	f	\N	2026-04-05 01:31:21.838545+00
2d0eb4ea-e1f7-427b-90a1-24739f170979	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 13:26:49.650852+00	2026-04-04 13:28:15.197229+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 13:24:49.650852+00	2026-04-04 13:28:15.209859+00	2026-04-04 13:34:49.650852+00	f	\N	2026-04-05 01:31:21.838545+00
35f81b7e-0ca7-469b-aaf6-31cee328232e	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 13:30:15.211388+00	2026-04-04 13:31:15.201604+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 13:28:15.211388+00	2026-04-04 13:31:15.212639+00	2026-04-04 13:38:15.211388+00	f	\N	2026-04-05 01:31:21.838545+00
c738b883-0e3d-4938-8417-7f289b07b2fc	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 13:33:15.214688+00	2026-04-04 13:35:33.632066+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 13:31:15.214688+00	2026-04-04 13:35:33.640349+00	2026-04-04 13:41:15.214688+00	f	\N	2026-04-05 01:47:14.235213+00
b6fc8563-1643-4037-b972-79b358fd4686	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 13:37:33.641869+00	2026-04-04 13:38:33.637272+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 13:35:33.641869+00	2026-04-04 13:38:33.649651+00	2026-04-04 13:45:33.641869+00	f	\N	2026-04-05 01:47:14.235213+00
d24ee4ab-06a2-41dd-98dc-3f82fefa0236	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 13:40:33.651372+00	2026-04-04 13:41:26.273392+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 13:38:33.651372+00	2026-04-04 13:41:26.55748+00	2026-04-04 13:48:33.651372+00	f	\N	2026-04-05 01:47:14.235213+00
f7b48671-3a8e-40a8-8272-333f95a38a23	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 13:43:26.559343+00	2026-04-04 14:04:22.42006+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 13:41:26.559343+00	2026-04-04 14:04:22.432448+00	2026-04-04 13:51:26.559343+00	f	\N	2026-04-05 02:20:01.148656+00
6f9c53be-c92e-4c3e-8241-5ea396d450a3	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 14:06:22.434173+00	2026-04-04 14:07:22.416697+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 14:04:22.434173+00	2026-04-04 14:07:22.42833+00	2026-04-04 14:14:22.434173+00	f	\N	2026-04-05 02:20:01.148656+00
2064ef0c-5bde-49c3-b050-c2d6b1f4d1c6	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 14:09:22.429627+00	2026-04-04 14:10:22.403095+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 14:07:22.429627+00	2026-04-04 14:10:22.409889+00	2026-04-04 14:17:22.429627+00	f	\N	2026-04-05 02:20:01.148656+00
a534dd04-a0ee-4068-a919-ab9d8d57dcd0	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 14:12:22.410923+00	2026-04-04 14:13:22.406608+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 14:10:22.410923+00	2026-04-04 14:13:22.417765+00	2026-04-04 14:20:22.410923+00	f	\N	2026-04-05 02:20:01.148656+00
c992a972-fafa-48ef-ba44-350401486cf9	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 14:15:22.420084+00	2026-04-04 14:15:59.069776+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 14:13:22.420084+00	2026-04-04 14:15:59.078883+00	2026-04-04 14:23:22.420084+00	f	\N	2026-04-05 02:20:01.148656+00
422e67ff-a211-4183-8da6-8ddbda8587c7	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 14:17:59.080745+00	2026-04-04 14:18:59.0744+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 14:15:59.080745+00	2026-04-04 14:18:59.084636+00	2026-04-04 14:25:59.080745+00	f	\N	2026-04-05 02:20:01.148656+00
376ef594-7705-4112-ae72-f1ccba96885c	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 14:20:59.08593+00	2026-04-04 14:21:59.071175+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 14:18:59.08593+00	2026-04-04 14:21:59.080119+00	2026-04-04 14:28:59.08593+00	f	\N	2026-04-05 02:37:19.140787+00
eb7dfbbd-6a0e-4487-b08b-b0670dd23b01	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 14:23:59.08167+00	2026-04-04 14:25:09.35941+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 14:21:59.08167+00	2026-04-04 14:25:09.655993+00	2026-04-04 14:31:59.08167+00	f	\N	2026-04-05 02:37:19.140787+00
c68385ef-b326-472e-8c24-9e15fe485dca	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 14:42:54.010321+00	2026-04-04 14:43:53.989662+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 14:40:54.010321+00	2026-04-04 14:43:53.995632+00	2026-04-04 14:50:54.010321+00	f	\N	2026-04-05 03:08:39.006445+00
619f1f88-c33a-4432-a918-20d24a6cef39	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 14:51:57.385818+00	2026-04-04 14:52:57.382045+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 14:49:57.385818+00	2026-04-04 14:52:57.396548+00	2026-04-04 14:59:57.385818+00	f	\N	2026-04-05 03:08:39.006445+00
735b3d62-9f78-462d-a415-9883779b26a5	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 15:03:09.817522+00	2026-04-04 15:03:12.07898+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 15:01:09.817522+00	2026-04-04 15:03:12.095496+00	2026-04-04 15:11:09.817522+00	f	\N	2026-04-05 03:08:39.006445+00
976bc246-31b7-4392-bf5a-a8a789d5437b	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 14:45:53.996775+00	2026-04-04 14:45:53.999565+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 14:43:53.996775+00	2026-04-04 14:45:54.006901+00	2026-04-04 14:53:53.996775+00	f	\N	2026-04-05 03:08:39.006445+00
ad0a513c-ab71-4cca-85f0-06995da2bf9d	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 14:54:57.398056+00	2026-04-04 14:55:57.374749+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 14:52:57.398056+00	2026-04-04 14:55:57.38985+00	2026-04-04 15:02:57.398056+00	f	\N	2026-04-05 03:08:39.006445+00
a9a89ec6-a77f-4d46-a7ad-bc41367169f2	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 15:05:12.097405+00	2026-04-04 15:07:56.087832+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 15:03:12.097405+00	2026-04-04 15:07:56.094542+00	2026-04-04 15:13:12.097405+00	f	\N	2026-04-05 03:08:39.006445+00
ce26fc73-116e-45fc-b3e9-b254d76c75ba	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 14:47:54.008142+00	2026-04-04 14:47:54.648602+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 14:45:54.008142+00	2026-04-04 14:47:54.651855+00	2026-04-04 14:55:54.008142+00	f	\N	2026-04-05 03:08:39.006445+00
523e3a8a-10da-4443-8e44-45683a733e27	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 14:57:57.391507+00	2026-04-04 14:58:57.382287+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 14:55:57.391507+00	2026-04-04 14:58:57.39184+00	2026-04-04 15:05:57.391507+00	f	\N	2026-04-05 03:08:39.006445+00
4deca52c-b1d5-40cb-9e29-5ebe6a5ba2ae	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 14:27:09.657748+00	2026-04-04 14:40:53.995318+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 14:25:09.657748+00	2026-04-04 14:40:54.008787+00	2026-04-04 14:35:09.657748+00	f	\N	2026-04-05 03:08:39.006445+00
06a1060f-d59e-46db-83d3-42788716c7e7	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 14:49:54.652664+00	2026-04-04 14:49:57.373818+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 14:47:54.652664+00	2026-04-04 14:49:57.383816+00	2026-04-04 14:57:54.652664+00	f	\N	2026-04-05 03:08:39.006445+00
1b08f391-b318-4154-88d6-1884791801db	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 15:00:57.394595+00	2026-04-04 15:01:09.811135+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 14:58:57.394595+00	2026-04-04 15:01:09.816383+00	2026-04-04 15:08:57.394595+00	f	\N	2026-04-05 03:08:39.006445+00
90390ac7-6874-404d-8760-f990cfa9e3aa	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 15:15:56.091667+00	2026-04-04 15:17:00.140871+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 15:13:56.091667+00	2026-04-04 15:17:00.152601+00	2026-04-04 15:23:56.091667+00	f	\N	2026-04-05 03:21:12.896893+00
c56c1944-ff3a-4c17-8abb-36112adf3f2e	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 15:19:00.154479+00	2026-04-04 15:19:00.158201+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 15:17:00.154479+00	2026-04-04 15:19:00.165195+00	2026-04-04 15:27:00.154479+00	f	\N	2026-04-05 03:21:12.896893+00
6d5be1e6-3767-4159-b04f-7bc6bcb0bc81	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 15:09:56.095671+00	2026-04-04 15:10:56.089841+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 15:07:56.095671+00	2026-04-04 15:10:56.096152+00	2026-04-04 15:17:56.095671+00	f	\N	2026-04-05 03:21:12.896893+00
b8cb8033-a707-4e1f-9329-0be2e33d95c3	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 15:12:56.097152+00	2026-04-04 15:13:56.085598+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 15:10:56.097152+00	2026-04-04 15:13:56.090915+00	2026-04-04 15:20:56.097152+00	f	\N	2026-04-05 03:21:12.896893+00
96ea3108-842d-472d-b141-a2f14062473c	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 15:21:00.167025+00	2026-04-04 15:22:00.152201+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 15:19:00.167025+00	2026-04-04 15:22:00.162242+00	2026-04-04 15:29:00.167025+00	f	\N	2026-04-05 03:24:12.885272+00
0772fdb6-e573-49a5-8c67-73393ee96c16	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 15:24:00.164484+00	2026-04-04 15:25:00.165863+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 15:22:00.164484+00	2026-04-04 15:25:00.174079+00	2026-04-04 15:32:00.164484+00	f	\N	2026-04-05 03:27:12.857489+00
93c70a37-4c43-49a2-93de-79b2ac8a241e	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 15:27:00.175643+00	2026-04-04 15:28:00.162022+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 15:25:00.175643+00	2026-04-04 15:28:00.173411+00	2026-04-04 15:35:00.175643+00	f	\N	2026-04-05 03:30:12.850057+00
47f9f17b-c7a4-4773-ae4e-5f836065aef1	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 15:30:00.175059+00	2026-04-04 15:31:00.170794+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 15:28:00.175059+00	2026-04-04 15:31:00.180378+00	2026-04-04 15:38:00.175059+00	f	\N	2026-04-05 03:33:12.853908+00
9b7b77e3-80be-4a26-98f3-ed90fec2638c	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 15:33:00.181942+00	2026-04-04 15:33:00.191429+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 15:31:00.181942+00	2026-04-04 15:33:00.204261+00	2026-04-04 15:41:00.181942+00	f	\N	2026-04-05 03:33:12.853908+00
6e1085f9-6749-49f9-928a-02e781fd0de6	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 15:35:00.20585+00	2026-04-04 15:36:00.185304+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 15:33:00.20585+00	2026-04-04 15:36:00.194014+00	2026-04-04 15:43:00.20585+00	f	\N	2026-04-05 03:38:12.871164+00
15a411f7-7487-46ea-96a7-02bd7442c336	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 15:38:00.195341+00	2026-04-04 15:39:00.196554+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 15:36:00.195341+00	2026-04-04 15:39:00.204765+00	2026-04-04 15:46:00.195341+00	f	\N	2026-04-05 03:41:12.867968+00
28db73ff-488a-4f67-b409-789e76781e78	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 15:41:00.205792+00	2026-04-04 15:42:00.193465+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 15:39:00.205792+00	2026-04-04 15:42:00.198656+00	2026-04-04 15:49:00.205792+00	f	\N	2026-04-05 03:44:12.855451+00
9f06ebc7-1446-401e-9308-e967be212f76	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 15:44:00.199517+00	2026-04-04 15:45:00.202473+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 15:42:00.199517+00	2026-04-04 15:45:00.208878+00	2026-04-04 15:52:00.199517+00	f	\N	2026-04-05 03:47:12.856846+00
c8256d79-3013-49ba-ad6c-28c8436d285a	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 15:47:00.209855+00	2026-04-04 15:48:00.198233+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 15:45:00.209855+00	2026-04-04 15:48:00.209651+00	2026-04-04 15:55:00.209855+00	f	\N	2026-04-05 03:49:12.867581+00
8cf7a6b4-ec95-4217-91f1-eb0bde394f3b	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 15:50:00.211702+00	2026-04-04 15:51:00.176385+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 15:48:00.211702+00	2026-04-04 15:51:00.187174+00	2026-04-04 15:58:00.211702+00	f	\N	2026-04-05 03:52:12.888153+00
a7c8078c-f90f-4416-b692-4db53b2e4c9f	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 15:53:00.18872+00	2026-04-04 15:54:00.178354+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 15:51:00.18872+00	2026-04-04 15:54:00.190049+00	2026-04-04 16:01:00.18872+00	f	\N	2026-04-05 03:54:12.902469+00
565ba8c7-717e-4a14-b900-24a707f61c04	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 15:56:00.191737+00	2026-04-04 15:57:00.170016+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 15:54:00.191737+00	2026-04-04 15:57:00.180527+00	2026-04-04 16:04:00.191737+00	f	\N	2026-04-05 03:57:12.902679+00
fefe395f-51c3-488e-80ba-4c74518d0328	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 15:59:00.182135+00	2026-04-04 15:59:00.183452+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 15:57:00.182135+00	2026-04-04 15:59:00.194714+00	2026-04-04 16:07:00.182135+00	f	\N	2026-04-05 04:00:12.897138+00
5de17ca7-64e0-4554-9ef5-8f2a99754d5f	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 16:01:00.196328+00	2026-04-04 16:02:00.174379+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 15:59:00.196328+00	2026-04-04 16:02:00.184068+00	2026-04-04 16:09:00.196328+00	f	\N	2026-04-05 04:03:12.9074+00
59555a52-f0a2-411c-b4d0-5ab8e012018b	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 16:04:00.185778+00	2026-04-04 16:05:00.207853+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 16:02:00.185778+00	2026-04-04 16:05:00.218667+00	2026-04-04 16:12:00.185778+00	f	\N	2026-04-05 04:06:52.062155+00
74a23c3d-d00f-42c2-8b70-0f09b40b1e7e	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 16:07:00.221016+00	2026-04-04 16:08:00.204221+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 16:05:00.221016+00	2026-04-04 16:08:00.216268+00	2026-04-04 16:15:00.221016+00	f	\N	2026-04-05 04:09:52.062833+00
353f7c1f-7ab3-43ad-85c7-4b6b67fb2527	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 16:10:00.217751+00	2026-04-04 16:11:00.217388+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 16:08:00.217751+00	2026-04-04 16:11:00.22862+00	2026-04-04 16:18:00.217751+00	f	\N	2026-04-05 04:12:52.064793+00
51897c8b-214e-45ef-ae3f-1f90aef64e58	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 16:13:00.230352+00	2026-04-04 16:14:00.219771+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 16:11:00.230352+00	2026-04-04 16:14:00.231361+00	2026-04-04 16:21:00.230352+00	f	\N	2026-04-05 04:15:52.064723+00
f910ed99-b831-4af0-b1f5-472c3f6aa40b	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 16:16:00.233659+00	2026-04-04 16:17:00.21449+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 16:14:00.233659+00	2026-04-04 16:17:00.22534+00	2026-04-04 16:24:00.233659+00	f	\N	2026-04-05 04:18:52.063757+00
c6605389-e29c-47e5-9fdb-1380f2f7ff80	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 16:19:00.227436+00	2026-04-04 16:20:00.217303+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 16:17:00.227436+00	2026-04-04 16:20:00.228801+00	2026-04-04 16:27:00.227436+00	f	\N	2026-04-05 04:25:24.370638+00
54a76cc5-ee53-4096-85d8-c2c79755887a	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 16:22:00.231021+00	2026-04-04 16:23:00.230857+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 16:20:00.231021+00	2026-04-04 16:23:00.242162+00	2026-04-04 16:30:00.231021+00	f	\N	2026-04-05 04:25:24.370638+00
e458b930-275a-4e46-9297-59f271fe61aa	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 16:25:00.243718+00	2026-04-04 16:26:00.235088+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 16:23:00.243718+00	2026-04-04 16:26:00.245992+00	2026-04-04 16:33:00.243718+00	f	\N	2026-04-05 04:26:11.565079+00
94d5e162-cb67-49c4-9460-3eeb88151dce	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 16:28:00.247446+00	2026-04-04 16:29:00.238019+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 16:26:00.247446+00	2026-04-04 16:29:00.250837+00	2026-04-04 16:36:00.247446+00	f	\N	2026-04-05 04:29:42.918404+00
7d658d0c-2986-4d56-91c3-d595c7952436	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 16:37:00.258406+00	2026-04-04 16:38:00.219558+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 16:35:00.258406+00	2026-04-04 16:38:00.234221+00	2026-04-04 16:45:00.258406+00	f	\N	2026-04-05 04:46:05.406515+00
b7469b06-2005-4837-91c2-c135debd23b2	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 16:40:00.235941+00	2026-04-04 16:41:00.202313+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 16:38:00.235941+00	2026-04-04 16:41:00.211968+00	2026-04-04 16:48:00.235941+00	f	\N	2026-04-05 04:46:05.406515+00
353adbe8-4325-461c-8346-37a71cbf1dab	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 16:31:00.253484+00	2026-04-04 16:32:00.232123+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 16:29:00.253484+00	2026-04-04 16:32:00.242811+00	2026-04-04 16:39:00.253484+00	f	\N	2026-04-05 04:46:05.406515+00
097df5b1-15f9-4bd7-a186-ac6727f301a0	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 16:43:00.213406+00	2026-04-04 16:44:00.19459+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 16:41:00.213406+00	2026-04-04 16:44:00.20502+00	2026-04-04 16:51:00.213406+00	f	\N	2026-04-05 04:46:05.406515+00
6cb7479e-c72d-4267-a868-4e675f0d466d	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 16:34:00.244928+00	2026-04-04 16:35:00.245646+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 16:32:00.244928+00	2026-04-04 16:35:00.256955+00	2026-04-04 16:42:00.244928+00	f	\N	2026-04-05 04:46:05.406515+00
8fe6980f-139b-4335-8b4f-e6f5cc2c59b1	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 16:49:00.211562+00	2026-04-04 16:50:00.209297+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 16:47:00.211562+00	2026-04-04 16:50:00.221052+00	2026-04-04 16:57:00.211562+00	f	\N	2026-04-05 05:03:07.003739+00
4f629d60-3b8a-4846-a8bd-f7067adcd8cb	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 17:00:00.252163+00	2026-04-04 17:01:00.243066+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 16:58:00.252163+00	2026-04-04 17:01:00.251128+00	2026-04-04 17:08:00.252163+00	f	\N	2026-04-05 05:03:07.003739+00
a337d417-22d7-4535-b98d-e613b650f315	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 17:03:00.252145+00	2026-04-04 17:03:00.254229+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 17:01:00.252145+00	2026-04-04 17:03:00.265151+00	2026-04-04 17:11:00.252145+00	f	\N	2026-04-05 05:03:07.003739+00
433aa0f7-597e-4a82-89a6-edf8458f6a50	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 16:52:00.222647+00	2026-04-04 16:53:00.212622+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 16:50:00.222647+00	2026-04-04 16:53:00.224699+00	2026-04-04 17:00:00.222647+00	f	\N	2026-04-05 05:03:07.003739+00
b1775b76-4de6-407f-99f8-82d3ab109ec0	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 16:55:00.226671+00	2026-04-04 16:55:00.235765+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 16:53:00.226671+00	2026-04-04 16:55:00.244064+00	2026-04-04 17:03:00.226671+00	f	\N	2026-04-05 05:03:07.003739+00
2ef93e49-baaf-46a5-b98a-b4525bc8acf6	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 16:46:00.207549+00	2026-04-04 16:47:00.197505+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 16:44:00.207549+00	2026-04-04 16:47:00.209033+00	2026-04-04 16:54:00.207549+00	f	\N	2026-04-05 05:03:07.003739+00
a2043d14-c119-40ea-9b19-763f61da5cdb	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 16:57:00.246447+00	2026-04-04 16:58:00.239674+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 16:55:00.246447+00	2026-04-04 16:58:00.250022+00	2026-04-04 17:05:00.246447+00	f	\N	2026-04-05 05:03:07.003739+00
c0b6a4c2-d3e3-4834-9180-958a649a9055	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 17:05:00.266727+00	2026-04-04 17:06:00.26312+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 17:03:00.266727+00	2026-04-04 17:06:00.277174+00	2026-04-04 17:13:00.266727+00	f	\N	2026-04-05 05:36:50.422666+00
24dbb58f-41ec-4ce9-b0e2-7c200a1aa3cb	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 17:17:00.256193+00	2026-04-04 17:18:00.242807+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 17:15:00.256193+00	2026-04-04 17:18:00.25661+00	2026-04-04 17:25:00.256193+00	f	\N	2026-04-05 05:36:50.422666+00
63e79df4-27d0-495f-a4b0-53e19079e959	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 17:29:00.279266+00	2026-04-04 17:29:00.282444+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 17:27:00.279266+00	2026-04-04 17:29:00.290259+00	2026-04-04 17:37:00.279266+00	f	\N	2026-04-05 05:36:50.422666+00
e72c2a65-0bf7-43c6-a3d7-a7c2d3daae45	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 17:08:00.279271+00	2026-04-04 17:09:00.260173+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 17:06:00.279271+00	2026-04-04 17:09:00.272959+00	2026-04-04 17:16:00.279271+00	f	\N	2026-04-05 05:36:50.422666+00
91017d90-b622-4a5c-9ba3-aae2c5e012d5	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 17:20:00.258491+00	2026-04-04 17:21:00.243449+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 17:18:00.258491+00	2026-04-04 17:21:00.252425+00	2026-04-04 17:28:00.258491+00	f	\N	2026-04-05 05:36:50.422666+00
e96f7219-2e9c-4d29-a3e4-9cfabf243eb2	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 17:31:00.291595+00	2026-04-04 17:32:00.277325+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 17:29:00.291595+00	2026-04-04 17:32:00.286144+00	2026-04-04 17:39:00.291595+00	f	\N	2026-04-05 05:36:50.422666+00
6ba93e7a-77b3-45c8-93e3-6c79945ef326	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 17:11:00.274409+00	2026-04-04 17:12:00.228857+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 17:09:00.274409+00	2026-04-04 17:12:00.238822+00	2026-04-04 17:19:00.274409+00	f	\N	2026-04-05 05:36:50.422666+00
a23631b9-9fbb-4cf3-893a-aa6eec636699	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 17:23:00.253956+00	2026-04-04 17:24:00.237533+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 17:21:00.253956+00	2026-04-04 17:24:00.2475+00	2026-04-04 17:31:00.253956+00	f	\N	2026-04-05 05:36:50.422666+00
e2ff2c01-87b2-42fb-bcd2-e38d7ca3eaee	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 17:34:00.287641+00	2026-04-04 17:35:00.290797+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 17:32:00.287641+00	2026-04-04 17:35:00.29868+00	2026-04-04 17:42:00.287641+00	f	\N	2026-04-05 05:36:50.422666+00
21075cbe-1663-4935-92f5-a010e0df526a	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 17:14:00.240781+00	2026-04-04 17:15:00.241533+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 17:12:00.240781+00	2026-04-04 17:15:00.254359+00	2026-04-04 17:22:00.240781+00	f	\N	2026-04-05 05:36:50.422666+00
1584150a-2b1c-4a6b-a628-d0d09f473e85	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 17:26:00.248816+00	2026-04-04 17:27:00.269968+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 17:24:00.248816+00	2026-04-04 17:27:00.277646+00	2026-04-04 17:34:00.248816+00	f	\N	2026-04-05 05:36:50.422666+00
c225cbb8-c907-4eaa-a392-96d53dea92c0	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 17:40:00.302739+00	2026-04-04 17:41:00.293857+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 17:38:00.302739+00	2026-04-04 17:41:00.298996+00	2026-04-04 17:48:00.302739+00	f	\N	2026-04-05 06:33:28.315055+00
2e1eb08f-df3c-4064-a0ca-ada83dc0e1f1	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 17:47:00.328779+00	2026-04-04 17:48:00.317401+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 17:45:00.328779+00	2026-04-04 17:48:00.326024+00	2026-04-04 17:55:00.328779+00	f	\N	2026-04-05 06:33:28.315055+00
dbec5669-bea9-4cdd-8577-e8eef6be3e81	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 17:50:00.327174+00	2026-04-04 17:50:00.328535+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 17:48:00.327174+00	2026-04-04 17:50:00.334108+00	2026-04-04 17:58:00.327174+00	f	\N	2026-04-05 06:33:28.315055+00
d5389617-b939-4801-bca3-e39e0f1de57f	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 17:58:00.335384+00	2026-04-04 17:59:00.348763+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 17:56:00.335384+00	2026-04-04 17:59:00.355521+00	2026-04-04 18:06:00.335384+00	f	\N	2026-04-05 06:33:28.315055+00
c7515da2-086c-4fe0-a165-96bedb07c20c	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 18:01:00.35668+00	2026-04-04 18:02:00.34665+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 17:59:00.35668+00	2026-04-04 18:02:00.351396+00	2026-04-04 18:09:00.35668+00	f	\N	2026-04-05 06:33:28.315055+00
5f981533-040f-44eb-8f29-3913bed9b98f	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 18:10:00.364004+00	2026-04-04 18:11:00.363741+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 18:08:00.364004+00	2026-04-04 18:11:00.369898+00	2026-04-04 18:18:00.364004+00	f	\N	2026-04-05 06:33:28.315055+00
adafad1f-c82c-416f-8242-5ef806b9e339	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 18:13:00.370848+00	2026-04-04 18:13:34.082588+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 18:11:00.370848+00	2026-04-04 18:13:34.092055+00	2026-04-04 18:21:00.370848+00	f	\N	2026-04-05 06:33:28.315055+00
e4cef5b9-d68d-4c4c-b51e-ca4bfb49fd2f	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 18:25:14.37621+00	2026-04-04 18:25:35.845835+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 18:25:14.37621+00	2026-04-04 18:25:35.857004+00	2026-04-04 18:33:14.37621+00	f	\N	2026-04-05 06:33:28.315055+00
d67509d2-969f-44f0-b5ec-34f0674e281a	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 17:43:00.299917+00	2026-04-04 17:43:00.309933+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 17:41:00.299917+00	2026-04-04 17:43:00.317482+00	2026-04-04 17:51:00.299917+00	f	\N	2026-04-05 06:33:28.315055+00
debee5fb-902b-4798-b282-25ca58fbae87	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 17:52:00.335181+00	2026-04-04 17:53:00.331677+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 17:50:00.335181+00	2026-04-04 17:53:00.338359+00	2026-04-04 18:00:00.335181+00	f	\N	2026-04-05 06:33:28.315055+00
ab2ba69f-f803-42ae-92fa-98c97ecb100c	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 18:04:00.352416+00	2026-04-04 18:05:00.358624+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 18:02:00.352416+00	2026-04-04 18:05:00.364675+00	2026-04-04 18:12:00.352416+00	f	\N	2026-04-05 06:33:28.315055+00
817d4096-cd7c-4f75-acd6-489c2037263b	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 18:15:34.094144+00	2026-04-04 18:15:39.237148+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 18:13:34.094144+00	2026-04-04 18:15:39.246211+00	2026-04-04 18:23:34.094144+00	f	\N	2026-04-05 06:33:28.315055+00
8e3126e5-22c4-4207-a026-efb4e5d1ae20	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 17:45:00.318582+00	2026-04-04 17:45:00.320816+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 17:43:00.318582+00	2026-04-04 17:45:00.327618+00	2026-04-04 17:53:00.318582+00	f	\N	2026-04-05 06:33:28.315055+00
fecea972-8c0d-4792-8041-69608c030da1	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 17:55:00.339566+00	2026-04-04 17:56:00.329296+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 17:53:00.339566+00	2026-04-04 17:56:00.334387+00	2026-04-04 18:03:00.339566+00	f	\N	2026-04-05 06:33:28.315055+00
0d51a666-220a-40eb-bb81-7060b56502f0	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 18:07:00.36572+00	2026-04-04 18:08:00.355063+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 18:05:00.36572+00	2026-04-04 18:08:00.360426+00	2026-04-04 18:15:00.36572+00	f	\N	2026-04-05 06:33:28.315055+00
1636d862-d380-41df-b549-1e6410ec40ba	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 17:37:00.299933+00	2026-04-04 17:38:00.293922+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 17:35:00.299933+00	2026-04-04 17:38:00.301414+00	2026-04-04 17:45:00.299933+00	f	\N	2026-04-05 06:33:28.315055+00
346db5ad-d8ab-473f-88a6-e1e5872fd9b7	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 18:27:35.858685+00	2026-04-04 18:53:39.74338+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 18:25:35.858685+00	2026-04-04 18:53:39.753585+00	2026-04-04 18:35:35.858685+00	f	\N	2026-04-05 06:54:28.307862+00
c2af3ff4-248e-4047-b22d-c40ea1a52570	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 19:20:52.023545+00	2026-04-04 19:20:59.027573+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 19:20:52.023545+00	2026-04-04 19:20:59.038845+00	2026-04-04 19:28:52.023545+00	f	\N	2026-04-05 07:23:04.693707+00
1c9bfcff-65f2-4844-8aeb-3609a0e3dbe8	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 19:36:29.096033+00	2026-04-04 19:36:36.096663+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 19:36:29.096033+00	2026-04-04 19:36:36.110666+00	2026-04-04 19:44:29.096033+00	f	\N	2026-04-05 07:39:04.697394+00
9e18fc42-8c91-4f94-933e-85d49868ca2e	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 19:57:17.522418+00	2026-04-04 19:57:25.261399+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 19:57:17.522418+00	2026-04-04 19:57:25.275521+00	2026-04-04 20:05:17.522418+00	f	\N	2026-04-05 07:59:04.683342+00
abe6a77b-7c97-4698-bf84-6e2243bf0b6e	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 20:14:42.514853+00	2026-04-04 20:14:47.528786+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 20:14:42.514853+00	2026-04-04 20:14:47.81877+00	2026-04-04 20:22:42.514853+00	f	\N	2026-04-05 08:16:04.663379+00
16145c4f-ec29-43c6-aab9-41a198f17253	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 20:46:08.765069+00	2026-04-04 20:46:15.900635+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 20:46:08.765069+00	2026-04-04 20:46:16.161001+00	2026-04-04 20:54:08.765069+00	f	\N	2026-04-05 08:48:04.658907+00
73fb4788-82cf-4b9f-839e-d40e0f2ab7d1	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 21:07:05.237376+00	2026-04-04 21:07:10.970311+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 21:07:05.237376+00	2026-04-04 21:07:10.987126+00	2026-04-04 21:15:05.237376+00	f	\N	2026-04-05 09:08:08.731787+00
9910ff0e-7874-4ddc-aeda-038c0f97d943	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 21:34:09.666482+00	2026-04-04 21:34:16.630214+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 21:34:09.666482+00	2026-04-04 21:34:16.906417+00	2026-04-04 21:42:09.666482+00	f	\N	2026-04-05 09:36:11.553574+00
447c02b2-bb87-4c19-b5fd-0d27958d217b	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 21:55:18.807352+00	2026-04-04 21:55:23.812328+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 21:55:18.807352+00	2026-04-04 21:55:23.821679+00	2026-04-04 22:03:18.807352+00	f	\N	2026-04-05 09:56:11.55435+00
7f1e96e3-b3ff-4e8e-9b28-9814e6e04858	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 22:30:03.020333+00	2026-04-04 22:30:08.058558+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 22:30:03.020333+00	2026-04-04 22:30:08.339806+00	2026-04-04 22:38:03.020333+00	f	\N	2026-04-05 10:30:11.608717+00
f42b9420-daf3-416b-b4ba-e54e3b16d094	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-04 23:52:03.911442+00	2026-04-04 23:52:09.637798+00	__pgboss__maintenance	\N	00:15:00	2026-04-04 23:52:03.911442+00	2026-04-04 23:52:09.648232+00	2026-04-05 00:00:03.911442+00	f	\N	2026-04-05 11:55:35.161897+00
465c2abd-e288-406f-955c-f23a8278c75f	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 00:49:44.024687+00	2026-04-05 00:49:51.765226+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 00:49:44.024687+00	2026-04-05 00:49:51.779546+00	2026-04-05 00:57:44.024687+00	f	\N	2026-04-05 12:58:44.494259+00
eee552d4-5629-48c2-825c-a25ccad69f7f	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 01:10:32.935509+00	2026-04-05 01:10:39.930665+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 01:10:32.935509+00	2026-04-05 01:10:39.93825+00	2026-04-05 01:18:32.935509+00	f	\N	2026-04-05 13:13:16.520167+00
2e85c7aa-4996-4310-9d79-b6fd4a4f8750	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 01:31:21.839357+00	2026-04-05 01:31:28.847283+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 01:31:21.839357+00	2026-04-05 01:31:28.85754+00	2026-04-05 01:39:21.839357+00	f	\N	2026-04-05 13:33:33.655445+00
6785c0e0-e914-43de-ab70-ad2e8a9e8eaa	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 01:47:14.236504+00	2026-04-05 01:47:19.940961+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 01:47:14.236504+00	2026-04-05 01:47:19.957297+00	2026-04-05 01:55:14.236504+00	f	\N	2026-04-05 13:48:33.643131+00
\.


--
-- Data for Name: job; Type: TABLE DATA; Schema: pgboss; Owner: -
--

COPY pgboss.job (id, name, priority, data, state, retrylimit, retrycount, retrydelay, retrybackoff, startafter, startedon, singletonkey, singletonon, expirein, createdon, completedon, keepuntil, on_complete, output) FROM stdin;
6ff751c3-2314-4bff-982c-691684b64bf7	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 09:08:08.733554+00	2026-04-05 09:21:11.533616+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 09:08:08.733554+00	2026-04-05 09:21:11.543621+00	2026-04-05 09:16:08.733554+00	f	\N
1fcc283e-4431-4ab3-9e22-c13ab96dd39e	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 03:40:12.876644+00	2026-04-05 03:41:12.862313+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 03:38:12.876644+00	2026-04-05 03:41:12.870943+00	2026-04-05 03:48:12.876644+00	f	\N
885b4699-ce14-416d-baca-97ab92f7ecb9	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 06:35:28.321263+00	2026-04-05 06:36:28.303577+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 06:33:28.321263+00	2026-04-05 06:36:28.309265+00	2026-04-05 06:43:28.321263+00	f	\N
b437f1c1-3853-4971-bded-c5c3b9c6898e	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 07:38:04.708724+00	2026-04-05 07:39:04.694492+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 07:36:04.708724+00	2026-04-05 07:39:04.699341+00	2026-04-05 07:46:04.708724+00	f	\N
d5d9c5a7-068b-44ff-82cd-38488969da75	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 10:59:16.879999+00	2026-04-05 11:00:16.875098+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 10:57:16.879999+00	2026-04-05 11:00:16.879042+00	2026-04-05 11:07:16.879999+00	f	\N
60f4ad11-c60e-49ee-8fc8-4781632a9d57	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 06:47:28.327106+00	2026-04-05 06:48:28.313158+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 06:45:28.327106+00	2026-04-05 06:48:28.322866+00	2026-04-05 06:55:28.327106+00	f	\N
4e481280-d2de-42c7-847f-ed702f3e49f3	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 09:23:11.545453+00	2026-04-05 09:24:11.540178+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 09:21:11.545453+00	2026-04-05 09:24:11.550161+00	2026-04-05 09:31:11.545453+00	f	\N
2876604f-8877-4c18-adb2-b0a0682dc112	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 07:49:04.705573+00	2026-04-05 07:50:04.697005+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 07:47:04.705573+00	2026-04-05 07:50:04.70469+00	2026-04-05 07:57:04.705573+00	f	\N
2aca870e-5527-4404-8804-e75b45727be5	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 03:51:12.870648+00	2026-04-05 03:52:12.883961+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 03:49:12.870648+00	2026-04-05 03:52:12.891725+00	2026-04-05 03:59:12.870648+00	f	\N
228e095d-3931-4918-a8ed-e3efe97a6498	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 06:59:28.305553+00	2026-04-05 07:00:28.291351+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 06:57:28.305553+00	2026-04-05 07:00:28.296407+00	2026-04-05 07:07:28.305553+00	f	\N
85997c42-0503-4b8a-bf55-b66212e27fa9	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 13:35:33.658642+00	2026-04-05 13:36:33.64786+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 13:33:33.658642+00	2026-04-05 13:36:33.656266+00	2026-04-05 13:43:33.658642+00	f	\N
626304a2-18ec-4562-b794-b8631c5d7102	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 09:35:11.564519+00	2026-04-05 09:36:11.545676+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 09:33:11.564519+00	2026-04-05 09:36:11.556532+00	2026-04-05 09:43:11.564519+00	f	\N
3f6d82e0-d090-4ae4-a902-95451d4f1c0d	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 07:11:06.303225+00	2026-04-05 07:11:06.303325+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 07:09:06.303225+00	2026-04-05 07:11:06.307944+00	2026-04-05 07:19:06.303225+00	f	\N
12a6511e-a1bb-44bb-911b-9e42ddd48fb0	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 02:20:01.149786+00	2026-04-05 02:20:08.88325+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 02:20:01.149786+00	2026-04-05 02:20:08.891118+00	2026-04-05 02:28:01.149786+00	f	\N
2ddfc858-c6fb-4dea-8567-7a864144602c	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 04:02:12.903087+00	2026-04-05 04:03:12.899287+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 04:00:12.903087+00	2026-04-05 04:03:12.911202+00	2026-04-05 04:10:12.903087+00	f	\N
6213e3dd-5343-4d39-9508-f971a0399c69	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 08:01:04.688786+00	2026-04-05 08:02:04.669192+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 07:59:04.688786+00	2026-04-05 08:02:04.681986+00	2026-04-05 08:09:04.688786+00	f	\N
144dc047-4b5a-4025-ac76-7918bea35f8c	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 11:11:41.359971+00	2026-04-05 11:12:41.355578+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 11:09:41.359971+00	2026-04-05 11:12:41.363983+00	2026-04-05 11:19:41.359971+00	f	\N
bb4d8e19-11d6-43a7-907f-eae1239430b5	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 07:22:04.688794+00	2026-04-05 07:23:04.69098+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 07:20:04.688794+00	2026-04-05 07:23:04.695853+00	2026-04-05 07:30:04.688794+00	f	\N
bf350fcb-0997-4e9e-a352-b82dd57b85b8	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 04:14:52.07116+00	2026-04-05 04:15:52.060521+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 04:12:52.07116+00	2026-04-05 04:15:52.067883+00	2026-04-05 04:22:52.07116+00	f	\N
88319dd9-ae59-474e-ba38-91abc5b10dd2	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 08:12:04.681185+00	2026-04-05 08:13:04.652564+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 08:10:04.681185+00	2026-04-05 08:13:04.666744+00	2026-04-05 08:20:04.681185+00	f	\N
d1d6b36c-0a7f-447d-9e20-d687dea7dba2	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 03:10:39.010153+00	2026-04-05 03:21:12.890242+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 03:08:39.010153+00	2026-04-05 03:21:12.90023+00	2026-04-05 03:18:39.010153+00	f	\N
8988227e-1679-438d-9d14-6d7d9bbf7ccf	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 09:47:11.53319+00	2026-04-05 09:48:11.520536+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 09:45:11.53319+00	2026-04-05 09:48:11.530077+00	2026-04-05 09:55:11.53319+00	f	\N
512cdbef-fbbc-4fe5-b3a2-1f86f379db39	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 07:33:04.705603+00	2026-04-05 07:34:04.69512+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 07:31:04.705603+00	2026-04-05 07:34:04.699413+00	2026-04-05 07:41:04.705603+00	f	\N
e56953ac-1212-4c7e-a152-dc67347b866c	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 11:30:22.88306+00	2026-04-05 11:39:59.505951+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 11:30:22.88306+00	2026-04-05 11:39:59.515603+00	2026-04-05 11:38:22.88306+00	f	\N
c872d638-d573-484a-906b-372cc7c5f418	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 03:32:12.852635+00	2026-04-05 03:33:12.846935+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 03:30:12.852635+00	2026-04-05 03:33:12.857291+00	2026-04-05 03:40:12.852635+00	f	\N
63edbd46-dea6-495b-85a2-89a3973f7748	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 08:24:04.660711+00	2026-04-05 08:25:04.659176+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 08:22:04.660711+00	2026-04-05 08:25:04.669164+00	2026-04-05 08:32:04.660711+00	f	\N
7733f006-855a-4916-9b0e-1401a8737f29	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 04:28:11.569766+00	2026-04-05 04:29:42.643545+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 04:26:11.569766+00	2026-04-05 04:29:42.921045+00	2026-04-05 04:36:11.569766+00	f	\N
aadfe686-3cbc-468a-afba-c34b84e99969	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 09:58:11.559993+00	2026-04-05 09:58:11.564423+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 09:56:11.559993+00	2026-04-05 09:58:11.576705+00	2026-04-05 10:06:11.559993+00	f	\N
54b10b91-3a51-4f3a-b8c5-d593e9242ec4	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 08:36:04.649213+00	2026-04-05 08:36:04.649506+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 08:34:04.649213+00	2026-04-05 08:36:04.65946+00	2026-04-05 08:44:04.649213+00	f	\N
4c2a2527-7e7f-4a4b-bbc7-9067e3e37e2d	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 12:08:49.851673+00	2026-04-05 12:09:49.847139+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 12:06:49.851673+00	2026-04-05 12:09:49.86082+00	2026-04-05 12:16:49.851673+00	f	\N
0cb8eb24-ea0a-445c-89a1-31d698ade995	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 08:47:04.666232+00	2026-04-05 08:48:04.650598+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 08:45:04.666232+00	2026-04-05 08:48:04.662729+00	2026-04-05 08:55:04.666232+00	f	\N
af05a386-4f73-4769-976e-f06a8bf6a4c9	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 10:08:11.584842+00	2026-04-05 10:09:11.582339+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 10:06:11.584842+00	2026-04-05 10:09:11.589196+00	2026-04-05 10:16:11.584842+00	f	\N
f256bbc2-b893-4240-95f1-6ed3bb8a6659	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 08:58:04.665661+00	2026-04-05 08:58:04.696149+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 08:56:04.665661+00	2026-04-05 08:58:04.706844+00	2026-04-05 09:06:04.665661+00	f	\N
433f7ed1-be93-48c3-9a1b-26a9e2db77a0	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 12:20:49.862923+00	2026-04-05 12:21:49.873253+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 12:18:49.862923+00	2026-04-05 12:21:49.882688+00	2026-04-05 12:28:49.862923+00	f	\N
1628096c-321d-463a-b6d6-25c934b660d5	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 10:20:11.609944+00	2026-04-05 10:21:11.592173+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 10:18:11.609944+00	2026-04-05 10:21:11.598862+00	2026-04-05 10:28:11.609944+00	f	\N
f466e600-43f1-4d21-8e0a-ee1b7ea5ad8d	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 12:32:49.893398+00	2026-04-05 12:33:49.883331+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 12:30:49.893398+00	2026-04-05 12:33:49.892161+00	2026-04-05 12:40:49.893398+00	f	\N
2fd75b23-6b62-4f55-9faf-88f77db55186	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 10:32:11.615267+00	2026-04-05 10:33:11.620716+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 10:30:11.615267+00	2026-04-05 10:33:11.632445+00	2026-04-05 10:40:11.615267+00	f	\N
c5647281-99a5-4e8d-8779-0e7eb533cd52	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 10:43:16.851207+00	2026-04-05 10:43:16.853915+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 10:41:16.851207+00	2026-04-05 10:43:16.861216+00	2026-04-05 10:51:16.851207+00	f	\N
c88cd3ea-f58e-4e31-acf9-29d41fd4e4f0	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 12:44:41.405209+00	2026-04-05 12:46:31.240194+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 12:42:41.405209+00	2026-04-05 12:46:31.246148+00	2026-04-05 12:52:41.405209+00	f	\N
f45257da-f27d-4954-9484-954630a0eb2b	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 10:54:16.869645+00	2026-04-05 10:54:16.87059+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 10:52:16.869645+00	2026-04-05 10:54:16.875638+00	2026-04-05 11:02:16.869645+00	f	\N
c8d0ab2d-5a88-43b2-a4b4-58e6e75acc0f	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 13:06:16.531792+00	2026-04-05 13:07:16.517535+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 13:04:16.531792+00	2026-04-05 13:07:16.525549+00	2026-04-05 13:14:16.531792+00	f	\N
c94bb2f3-3c28-4eec-b8bb-52f605b35214	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 13:17:51.450337+00	2026-04-05 13:18:08.762244+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 13:15:51.450337+00	2026-04-05 13:18:08.766616+00	2026-04-05 13:25:51.450337+00	f	\N
cade56db-399f-4354-a9f1-3dd4af852947	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 07:36:04.700294+00	2026-04-05 07:36:04.70318+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 07:34:04.700294+00	2026-04-05 07:36:04.707877+00	2026-04-05 07:44:04.700294+00	f	\N
eda84550-2aa8-49d1-b0b4-7dab6b519859	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 06:38:28.310419+00	2026-04-05 06:39:28.304497+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 06:36:28.310419+00	2026-04-05 06:39:28.312077+00	2026-04-05 06:46:28.310419+00	f	\N
a690b431-7022-4eec-b105-25e04fc14ffe	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 10:56:16.876453+00	2026-04-05 10:57:16.874414+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 10:54:16.876453+00	2026-04-05 10:57:16.879217+00	2026-04-05 11:04:16.876453+00	f	\N
7f25f821-b5ca-4b5e-8d22-4cad9af1d908	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 03:43:12.872231+00	2026-04-05 03:44:12.852826+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 03:41:12.872231+00	2026-04-05 03:44:12.857474+00	2026-04-05 03:51:12.872231+00	f	\N
60a376ca-a51e-46b9-aa4e-37fa3770c085	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 09:26:11.552959+00	2026-04-05 09:27:11.555514+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 09:24:11.552959+00	2026-04-05 09:27:11.564583+00	2026-04-05 09:34:11.552959+00	f	\N
3bcd2e8b-f432-44db-ae65-f369f82680ad	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 06:50:28.324492+00	2026-04-05 06:51:28.295714+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 06:48:28.324492+00	2026-04-05 06:51:28.306343+00	2026-04-05 06:58:28.324492+00	f	\N
3b7ed0f7-151f-48ce-8a4d-67c949c0b872	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 07:41:04.700366+00	2026-04-05 07:42:04.68924+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 07:39:04.700366+00	2026-04-05 07:42:04.693876+00	2026-04-05 07:49:04.700366+00	f	\N
fe861fb1-cc3a-4ae4-8922-0b45e2f3467f	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 13:32:33.659378+00	2026-04-05 13:33:33.652848+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 13:30:33.659378+00	2026-04-05 13:33:33.657632+00	2026-04-05 13:40:33.659378+00	f	\N
8617d257-4701-4e90-bc5d-31f9a68b1aa0	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 03:54:12.893213+00	2026-04-05 03:54:12.895532+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 03:52:12.893213+00	2026-04-05 03:54:12.906917+00	2026-04-05 04:02:12.893213+00	f	\N
5ad13ef2-a1d6-4d1e-a785-fc35d7e02392	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 07:02:28.297447+00	2026-04-05 07:02:28.299448+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 07:00:28.297447+00	2026-04-05 07:02:28.306691+00	2026-04-05 07:10:28.297447+00	f	\N
a2589a71-5c73-4953-ba27-bc81e5a313fd	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 11:02:16.879707+00	2026-04-05 11:03:16.881592+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 11:00:16.879707+00	2026-04-05 11:03:16.885734+00	2026-04-05 11:10:16.879707+00	f	\N
ec14bc7b-8187-4654-8656-77cade1b30ff	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 07:52:04.705942+00	2026-04-05 07:53:04.705071+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 07:50:04.705942+00	2026-04-05 07:53:04.710515+00	2026-04-05 08:00:04.705942+00	f	\N
0026c752-350d-4802-8e0b-5e8c7d1c6101	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 07:13:06.308856+00	2026-04-05 07:14:57.668653+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 07:11:06.308856+00	2026-04-05 07:14:57.673248+00	2026-04-05 07:21:06.308856+00	f	\N
995986d5-c879-4080-89db-b0ee2485b71c	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 04:05:12.912905+00	2026-04-05 04:06:52.052622+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 04:03:12.912905+00	2026-04-05 04:06:52.065704+00	2026-04-05 04:13:12.912905+00	f	\N
49c183ed-2d61-4d30-a539-99e5e2460ef1	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 03:23:12.901816+00	2026-04-05 03:24:12.879745+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 03:21:12.901816+00	2026-04-05 03:24:12.887896+00	2026-04-05 03:31:12.901816+00	f	\N
16f5b8c4-75e7-41fa-ae78-1813c2b29ed9	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 09:38:11.557922+00	2026-04-05 09:39:11.525846+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 09:36:11.557922+00	2026-04-05 09:39:11.535712+00	2026-04-05 09:46:11.557922+00	f	\N
b3d23021-8008-42b8-84c7-47aadd0bdacc	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 07:25:04.696755+00	2026-04-05 07:26:04.689528+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 07:23:04.696755+00	2026-04-05 07:26:04.693825+00	2026-04-05 07:33:04.696755+00	f	\N
ee9051d2-dea5-44bc-9cf1-be05bf707253	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 04:17:52.069426+00	2026-04-05 04:18:52.058538+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 04:15:52.069426+00	2026-04-05 04:18:52.066541+00	2026-04-05 04:25:52.069426+00	f	\N
6a832e96-dae6-4d7a-932e-2685a4515083	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 13:38:33.657289+00	2026-04-05 13:39:33.644756+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 13:36:33.657289+00	2026-04-05 13:39:33.648997+00	2026-04-05 13:46:33.657289+00	f	\N
01464e25-1400-4ec8-8032-876489e960e4	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 03:35:12.85889+00	2026-04-05 03:35:12.866671+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 03:33:12.85889+00	2026-04-05 03:35:12.876481+00	2026-04-05 03:43:12.85889+00	f	\N
970fb8d8-5372-4cdd-916a-23682f96108a	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 08:04:04.683706+00	2026-04-05 08:04:04.686209+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 08:02:04.683706+00	2026-04-05 08:04:04.695778+00	2026-04-05 08:12:04.683706+00	f	\N
229951bc-1cd3-463a-be7f-a7f9e0b9aac2	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 09:50:11.53159+00	2026-04-05 09:51:11.530678+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 09:48:11.53159+00	2026-04-05 09:51:11.540249+00	2026-04-05 09:58:11.53159+00	f	\N
f2e27f0a-ace0-4b44-85d9-771c2c42a193	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 11:14:41.365281+00	2026-04-05 11:17:39.177052+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 11:12:41.365281+00	2026-04-05 11:17:39.184944+00	2026-04-05 11:22:41.365281+00	f	\N
da1973e9-a0ff-4dad-b8e7-66bc78e1eb34	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 08:15:04.668892+00	2026-04-05 08:16:04.654523+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 08:13:04.668892+00	2026-04-05 08:16:04.66856+00	2026-04-05 08:23:04.668892+00	f	\N
0f601af5-fda1-402e-bac5-a304d6c17536	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 13:47:33.651741+00	2026-04-05 13:48:33.640688+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 13:45:33.651741+00	2026-04-05 13:48:33.646875+00	2026-04-05 13:55:33.651741+00	f	\N
dc156e17-aaae-4e5a-999a-806c10b8dc6f	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 10:00:11.578216+00	2026-04-05 10:01:11.564183+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 09:58:11.578216+00	2026-04-05 10:01:11.576485+00	2026-04-05 10:08:11.578216+00	f	\N
62971e1a-c2bf-47c8-801f-ba55fa598677	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 05:36:50.424808+00	2026-04-05 05:36:55.418163+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 05:36:50.424808+00	2026-04-05 05:36:55.427345+00	2026-04-05 05:44:50.424808+00	f	\N
79e39988-8961-4573-98b0-03e8adabe7ef	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 08:27:04.670725+00	2026-04-05 08:28:04.648902+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 08:25:04.670725+00	2026-04-05 08:28:04.658934+00	2026-04-05 08:35:04.670725+00	f	\N
762d858e-f3cf-4036-bbaa-7f9d5be66d36	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 08:38:04.660884+00	2026-04-05 08:39:04.649975+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 08:36:04.660884+00	2026-04-05 08:39:04.664359+00	2026-04-05 08:46:04.660884+00	f	\N
006ac0db-c891-4aa6-bcb3-7cf0c979f3b9	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 10:11:11.59032+00	2026-04-05 10:12:11.576567+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 10:09:11.59032+00	2026-04-05 10:12:11.584771+00	2026-04-05 10:19:11.59032+00	f	\N
9bcb2b2d-2c4e-4411-ab0c-dcbd66d9fcd4	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 08:50:04.664332+00	2026-04-05 08:51:04.651001+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 08:48:04.664332+00	2026-04-05 08:51:04.662872+00	2026-04-05 08:58:04.664332+00	f	\N
360429f2-5475-4ed3-a367-4ad7f1d3073e	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 12:11:49.862778+00	2026-04-05 12:12:49.848769+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 12:09:49.862778+00	2026-04-05 12:12:49.85883+00	2026-04-05 12:19:49.862778+00	f	\N
20f24fff-0a25-4c7e-aef7-8d89d5ec55e0	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 10:23:11.599616+00	2026-04-05 10:24:11.589295+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 10:21:11.599616+00	2026-04-05 10:24:11.598615+00	2026-04-05 10:31:11.599616+00	f	\N
0dcc874e-8040-48e0-9ef7-cda456e0c257	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 09:00:04.708465+00	2026-04-05 09:01:04.708927+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 08:58:04.708465+00	2026-04-05 09:01:04.719295+00	2026-04-05 09:08:04.708465+00	f	\N
9e3afcd3-e157-4e6c-913d-eee1462f74c5	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 10:35:11.634029+00	2026-04-05 10:36:11.615859+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 10:33:11.634029+00	2026-04-05 10:36:11.627248+00	2026-04-05 10:43:11.634029+00	f	\N
3e3f243c-c5d4-4c63-9568-7bf966de19ce	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 12:23:49.883955+00	2026-04-05 12:24:49.88139+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 12:21:49.883955+00	2026-04-05 12:24:49.890878+00	2026-04-05 12:31:49.883955+00	f	\N
1f4786a3-e7ec-45b3-9cd3-ba5146b3b8e1	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 10:45:16.862075+00	2026-04-05 10:46:16.859683+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 10:43:16.862075+00	2026-04-05 10:46:16.866253+00	2026-04-05 10:53:16.862075+00	f	\N
57f40cde-2c31-4a0d-a66d-66b7c06f60f8	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 12:35:49.89356+00	2026-04-05 12:36:49.891036+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 12:33:49.89356+00	2026-04-05 12:36:49.901842+00	2026-04-05 12:43:49.89356+00	f	\N
e93c8471-ad33-411f-a5fd-5780ab05b6f5	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 12:48:31.247209+00	2026-04-05 12:49:31.24222+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 12:46:31.247209+00	2026-04-05 12:49:31.247452+00	2026-04-05 12:56:31.247209+00	f	\N
ae2aebe8-9621-4c65-86f6-cdf33af20cb2	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 13:09:16.527337+00	2026-04-05 13:10:16.520025+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 13:07:16.527337+00	2026-04-05 13:10:16.529575+00	2026-04-05 13:17:16.527337+00	f	\N
019cd3ce-71c2-4ea7-8537-a0298751bce3	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 13:20:08.767468+00	2026-04-05 13:21:08.764501+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 13:18:08.767468+00	2026-04-05 13:21:08.775592+00	2026-04-05 13:28:08.767468+00	f	\N
3674dd32-c957-42d6-9ba0-ffc9990745e9	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 13:29:33.666784+00	2026-04-05 13:30:33.651466+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 13:27:33.666784+00	2026-04-05 13:30:33.65869+00	2026-04-05 13:37:33.666784+00	f	\N
44a2262f-2eb0-4924-a0b6-1c674878134a	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 03:37:12.878633+00	2026-04-05 03:38:12.865194+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 03:35:12.878633+00	2026-04-05 03:38:12.875338+00	2026-04-05 03:45:12.878633+00	f	\N
b12dad8e-d29c-40a5-8de1-d0b10e0237cb	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 05:38:55.428337+00	2026-04-05 06:33:28.305911+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 05:36:55.428337+00	2026-04-05 06:33:28.319135+00	2026-04-05 05:46:55.428337+00	f	\N
77c7fd2c-83f2-4a26-9319-56ef993919c4	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 02:37:19.14201+00	2026-04-05 02:37:24.214136+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 02:37:19.14201+00	2026-04-05 02:37:24.478313+00	2026-04-05 02:45:19.14201+00	f	\N
17d852aa-2b27-4c9a-8dbd-a2dc7e67f444	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 03:46:12.858434+00	2026-04-05 03:47:12.853936+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 03:44:12.858434+00	2026-04-05 03:47:12.858695+00	2026-04-05 03:54:12.858434+00	f	\N
12e368f7-b1e9-47c7-91d0-57f844d0d950	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 07:44:04.694758+00	2026-04-05 07:44:04.695182+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 07:42:04.694758+00	2026-04-05 07:44:04.701325+00	2026-04-05 07:52:04.694758+00	f	\N
ca66969f-c0e8-4608-8eb0-fa29e8f5344c	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 06:41:28.313372+00	2026-04-05 06:42:28.315371+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 06:39:28.313372+00	2026-04-05 06:42:28.323204+00	2026-04-05 06:49:28.313372+00	f	\N
6b83293c-7bd1-4002-adb5-695f915ef499	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 09:29:11.567897+00	2026-04-05 09:30:11.54818+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 09:27:11.567897+00	2026-04-05 09:30:11.556739+00	2026-04-05 09:37:11.567897+00	f	\N
cf41ee80-0528-4ed6-b312-bdc745be226a	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 11:05:16.886427+00	2026-04-05 11:06:41.350744+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 11:03:16.886427+00	2026-04-05 11:06:41.36129+00	2026-04-05 11:13:16.886427+00	f	\N
f505e9c5-8455-45c9-b2fa-055a3699a541	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 03:26:12.888699+00	2026-04-05 03:27:12.848027+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 03:24:12.888699+00	2026-04-05 03:27:12.862454+00	2026-04-05 03:34:12.888699+00	f	\N
79f43419-e7d0-469d-8504-6623da9ef0ce	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 03:56:12.908808+00	2026-04-05 03:57:12.896147+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 03:54:12.908808+00	2026-04-05 03:57:12.907309+00	2026-04-05 04:04:12.908808+00	f	\N
57634011-faa1-4714-b11a-4b9566e330b5	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 06:53:28.308076+00	2026-04-05 06:54:28.2985+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 06:51:28.308076+00	2026-04-05 06:54:28.311825+00	2026-04-05 07:01:28.308076+00	f	\N
b257d302-904b-4b58-8cb2-4d3ef55a32a2	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 07:55:04.711675+00	2026-04-05 07:56:04.673895+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 07:53:04.711675+00	2026-04-05 07:56:04.68091+00	2026-04-05 08:03:04.711675+00	f	\N
0a7360b9-3c97-4999-a078-487a4f9e6f4a	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 13:41:33.649675+00	2026-04-05 13:42:33.645314+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 13:39:33.649675+00	2026-04-05 13:42:33.649296+00	2026-04-05 13:49:33.649675+00	f	\N
24063126-6c7c-42bd-9452-a7f50076d43d	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 07:04:28.309586+00	2026-04-05 07:06:06.302256+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 07:02:28.309586+00	2026-04-05 07:06:06.310985+00	2026-04-05 07:12:28.309586+00	f	\N
5eca6857-c702-4694-927f-35f8aef42fab	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 09:41:11.537016+00	2026-04-05 09:42:11.526491+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 09:39:11.537016+00	2026-04-05 09:42:11.536412+00	2026-04-05 09:49:11.537016+00	f	\N
735e104a-cb2b-4620-b51c-63ca690dd917	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 04:08:52.067308+00	2026-04-05 04:09:52.057268+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 04:06:52.067308+00	2026-04-05 04:09:52.066788+00	2026-04-05 04:16:52.067308+00	f	\N
e8bb71ce-d685-45df-a117-c914fc13673d	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 08:06:04.696882+00	2026-04-05 08:07:04.68518+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 08:04:04.696882+00	2026-04-05 08:07:04.698085+00	2026-04-05 08:14:04.696882+00	f	\N
1b58d2bd-0473-400c-b276-0e7a4d76ba61	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 07:16:57.674064+00	2026-04-05 07:17:04.680642+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 07:14:57.674064+00	2026-04-05 07:17:04.685353+00	2026-04-05 07:24:57.674064+00	f	\N
cf5395e4-78ed-4b9a-aa0a-1d177d19dfe4	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 11:19:39.186978+00	2026-04-05 11:20:39.178929+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 11:17:39.186978+00	2026-04-05 11:20:39.184278+00	2026-04-05 11:27:39.186978+00	f	\N
95d452ab-e5b9-4273-b961-bcfa4999d023	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 07:28:04.694636+00	2026-04-05 07:28:04.695474+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 07:26:04.694636+00	2026-04-05 07:28:04.699739+00	2026-04-05 07:36:04.694636+00	f	\N
db588da0-6180-4b7f-ab54-53139ea6a478	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 08:18:04.670253+00	2026-04-05 08:19:04.653227+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 08:16:04.670253+00	2026-04-05 08:19:04.663479+00	2026-04-05 08:26:04.670253+00	f	\N
49e8eea8-0a80-4638-9501-ff6995c8d8eb	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 04:46:05.410128+00	2026-04-05 04:46:15.547354+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 04:46:05.410128+00	2026-04-05 04:46:15.806755+00	2026-04-05 04:54:05.410128+00	f	\N
c9590027-a69d-48f4-975e-5f2046b3fbc7	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 09:53:11.541852+00	2026-04-05 09:53:11.5494+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 09:51:11.541852+00	2026-04-05 09:53:11.557022+00	2026-04-05 10:01:11.541852+00	f	\N
63ef59b3-9528-4892-9207-623fb0e7319e	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 13:50:33.647883+00	2026-04-05 13:50:33.653525+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 13:48:33.647883+00	2026-04-05 13:50:33.666618+00	2026-04-05 13:58:33.647883+00	f	\N
79711def-5559-4c59-be25-c95e2ecf7392	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 08:30:04.660634+00	2026-04-05 08:31:04.643404+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 08:28:04.660634+00	2026-04-05 08:31:04.649853+00	2026-04-05 08:38:04.660634+00	f	\N
4b342100-5550-48d1-97e2-aee4b61b5554	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 10:03:11.578027+00	2026-04-05 10:04:11.554688+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 10:01:11.578027+00	2026-04-05 10:04:11.564125+00	2026-04-05 10:11:11.578027+00	f	\N
e087542c-0a54-4ae6-b742-b80e25b18dbd	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 08:41:04.665854+00	2026-04-05 08:42:04.6513+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 08:39:04.665854+00	2026-04-05 08:42:04.661778+00	2026-04-05 08:49:04.665854+00	f	\N
adf742d2-f1d0-473d-818c-0e05f7d148c1	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 13:52:33.667991+00	2026-04-05 13:52:33.697669+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 13:50:33.667991+00	2026-04-05 13:52:33.707998+00	2026-04-05 14:00:33.667991+00	f	\N
8d10b71e-a63f-40ca-a84b-4093100f97c8	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 08:53:04.664409+00	2026-04-05 08:54:04.641692+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 08:51:04.664409+00	2026-04-05 08:54:04.651905+00	2026-04-05 09:01:04.664409+00	f	\N
8e9254f8-7f66-401c-a117-a0e0f7c4efef	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 10:14:11.586425+00	2026-04-05 10:15:11.580021+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 10:12:11.586425+00	2026-04-05 10:15:11.591429+00	2026-04-05 10:22:11.586425+00	f	\N
df0fc7da-0f5c-412b-9a0d-b11928c33654	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 12:14:49.860458+00	2026-04-05 12:15:49.852432+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 12:12:49.860458+00	2026-04-05 12:15:49.858623+00	2026-04-05 12:22:49.860458+00	f	\N
1bd36d79-8523-4fe2-9013-b08f78d51237	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 09:03:04.720802+00	2026-04-05 09:04:04.714543+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 09:01:04.720802+00	2026-04-05 09:04:04.726313+00	2026-04-05 09:11:04.720802+00	f	\N
107274f1-adcb-42a9-868f-2e452d931fa0	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 13:57:33.704189+00	2026-04-05 13:58:33.7228+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 13:55:33.704189+00	2026-04-05 13:58:33.728684+00	2026-04-05 14:05:33.704189+00	f	\N
957cea08-d5e3-43cc-89b4-deb8b413786b	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 10:26:11.601913+00	2026-04-05 10:27:11.606198+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 10:24:11.601913+00	2026-04-05 10:27:11.613255+00	2026-04-05 10:34:11.601913+00	f	\N
696273e2-ba5a-434c-ae29-bce256b38b2e	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 12:26:49.892504+00	2026-04-05 12:27:49.879699+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 12:24:49.892504+00	2026-04-05 12:27:49.884402+00	2026-04-05 12:34:49.892504+00	f	\N
baba7a64-cc12-440d-8cf9-41e3376beb56	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 10:38:11.62918+00	2026-04-05 10:38:16.839958+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 10:36:11.62918+00	2026-04-05 10:38:16.844442+00	2026-04-05 10:46:11.62918+00	f	\N
7f1089ae-765a-41a7-865d-fb7ed935a795	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 14:00:33.729994+00	2026-04-05 14:01:33.716044+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 13:58:33.729994+00	2026-04-05 14:01:33.721635+00	2026-04-05 14:08:33.729994+00	f	\N
a71167e6-4938-4b58-8c8e-4565b3b4dd49	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 10:48:16.867512+00	2026-04-05 10:49:16.865457+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 10:46:16.867512+00	2026-04-05 10:49:16.869732+00	2026-04-05 10:56:16.867512+00	f	\N
84c67371-a8f2-45ba-96c9-0c18e100eae1	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 12:38:49.903483+00	2026-04-05 12:39:49.908032+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 12:36:49.903483+00	2026-04-05 12:39:49.920738+00	2026-04-05 12:46:49.903483+00	f	\N
990c1747-2c65-44c2-b8e4-4c2106bfb27b	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 12:51:31.248394+00	2026-04-05 12:58:44.491901+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 12:49:31.248394+00	2026-04-05 12:58:44.495786+00	2026-04-05 12:59:31.248394+00	f	\N
d7a067a5-2a04-4540-b944-00fe31e04783	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 13:12:16.530814+00	2026-04-05 13:13:16.517409+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 13:10:16.530814+00	2026-04-05 13:13:16.522676+00	2026-04-05 13:20:16.530814+00	f	\N
13942047-32fe-4176-934b-55d057c1ffa2	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 13:23:08.777141+00	2026-04-05 13:24:33.652013+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 13:21:08.777141+00	2026-04-05 13:24:33.658152+00	2026-04-05 13:31:08.777141+00	f	\N
6d31e1e2-b210-4aab-88c2-c420fbe4b415	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 03:49:12.859821+00	2026-04-05 03:49:12.864432+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 03:47:12.859821+00	2026-04-05 03:49:12.869538+00	2026-04-05 03:57:12.859821+00	f	\N
c5fe1f3e-628c-4526-9bee-4efdf0da3970	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 06:44:28.324654+00	2026-04-05 06:45:28.315622+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 06:42:28.324654+00	2026-04-05 06:45:28.325524+00	2026-04-05 06:52:28.324654+00	f	\N
68f8df79-f137-4e03-8bf1-6e73a40f41f3	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 07:46:04.702419+00	2026-04-05 07:47:04.699555+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 07:44:04.702419+00	2026-04-05 07:47:04.704539+00	2026-04-05 07:54:04.702419+00	f	\N
9195b868-bab0-4aa2-9c95-b2dd2ae41f81	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 09:32:11.558552+00	2026-04-05 09:33:11.552951+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 09:30:11.558552+00	2026-04-05 09:33:11.562895+00	2026-04-05 09:40:11.558552+00	f	\N
9acf8c14-641d-453e-97ae-f0c72c5f4f2b	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 03:59:12.909351+00	2026-04-05 04:00:12.888289+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 03:57:12.909351+00	2026-04-05 04:00:12.901582+00	2026-04-05 04:07:12.909351+00	f	\N
c09b9c8e-4c1d-46ed-ad9a-f0baf4b5c007	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 02:39:24.480032+00	2026-04-05 03:08:38.825842+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 02:37:24.480032+00	2026-04-05 03:08:39.00896+00	2026-04-05 02:47:24.480032+00	f	\N
fe2c4b68-f5ac-4612-9e3f-1138b1302808	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 06:56:28.313502+00	2026-04-05 06:57:28.297471+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 06:54:28.313502+00	2026-04-05 06:57:28.303931+00	2026-04-05 07:04:28.313502+00	f	\N
d770818b-6b52-450c-9f44-0253592eda0b	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 11:08:41.363283+00	2026-04-05 11:09:41.349268+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 11:06:41.363283+00	2026-04-05 11:09:41.358726+00	2026-04-05 11:16:41.363283+00	f	\N
e5a5a9df-2d57-4b3c-b5e7-fc0880bd990e	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 07:58:04.682242+00	2026-04-05 07:59:04.675535+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 07:56:04.682242+00	2026-04-05 07:59:04.687352+00	2026-04-05 08:06:04.682242+00	f	\N
626463b8-35c2-4cfa-9b9b-04c795cc9ad1	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 07:08:06.312874+00	2026-04-05 07:09:06.296944+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 07:06:06.312874+00	2026-04-05 07:09:06.302311+00	2026-04-05 07:16:06.312874+00	f	\N
191ff6ac-1719-42f4-9603-fc82ff82cd6b	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 04:11:52.068767+00	2026-04-05 04:12:52.057246+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 04:09:52.068767+00	2026-04-05 04:12:52.069317+00	2026-04-05 04:19:52.068767+00	f	\N
1c6d7a82-af8f-4284-9f18-44ebeb2927d7	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 03:29:12.864071+00	2026-04-05 03:30:12.843659+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 03:27:12.864071+00	2026-04-05 03:30:12.851916+00	2026-04-05 03:37:12.864071+00	f	\N
beffd213-3516-489f-b1ee-ef8cb39bf9d9	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 13:44:33.650051+00	2026-04-05 13:45:33.645017+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 13:42:33.650051+00	2026-04-05 13:45:33.650995+00	2026-04-05 13:52:33.650051+00	f	\N
13db923a-f537-4347-af65-534e91a565bc	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 09:44:11.537902+00	2026-04-05 09:45:11.522414+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 09:42:11.537902+00	2026-04-05 09:45:11.53162+00	2026-04-05 09:52:11.537902+00	f	\N
18d9679e-84ec-4a92-8fbd-893df6bc7b6d	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 04:25:24.369554+00	2026-04-05 04:26:11.347553+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 04:25:24.369554+00	2026-04-05 04:26:11.568026+00	2026-04-05 04:33:24.369554+00	f	\N
13e71e41-553a-4423-9293-802ac99dc3a2	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 07:19:04.686263+00	2026-04-05 07:20:04.683825+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 07:17:04.686263+00	2026-04-05 07:20:04.687942+00	2026-04-05 07:27:04.686263+00	f	\N
d745e8f3-3570-493c-8069-76a7d1cc9465	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 08:09:04.699471+00	2026-04-05 08:10:04.67391+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 08:07:04.699471+00	2026-04-05 08:10:04.680199+00	2026-04-05 08:17:04.699471+00	f	\N
25b45028-c21a-4313-a9ff-e040c7d88aa9	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 07:30:04.700507+00	2026-04-05 07:31:04.697997+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 07:28:04.700507+00	2026-04-05 07:31:04.704115+00	2026-04-05 07:38:04.700507+00	f	\N
5fa86ad2-69b9-45fc-b2ff-fb9256456856	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 04:48:15.809821+00	2026-04-05 05:03:06.996594+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 04:46:15.809821+00	2026-04-05 05:03:07.006491+00	2026-04-05 04:56:15.809821+00	f	\N
b60dfde4-30a1-421b-a7cc-64fa06a99b19	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 08:21:04.664903+00	2026-04-05 08:22:04.647483+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 08:19:04.664903+00	2026-04-05 08:22:04.65844+00	2026-04-05 08:29:04.664903+00	f	\N
4f3f6112-242a-40e1-a84e-71cc74251497	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 09:55:11.558705+00	2026-04-05 09:56:11.549313+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 09:53:11.558705+00	2026-04-05 09:56:11.557552+00	2026-04-05 10:03:11.558705+00	f	\N
c248e894-ef4d-476f-86e9-0af05be94180	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 13:54:33.709761+00	2026-04-05 13:55:33.693136+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 13:52:33.709761+00	2026-04-05 13:55:33.702675+00	2026-04-05 14:02:33.709761+00	f	\N
4b5dbe62-3230-44ca-a57b-2275ee849472	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 08:33:04.651042+00	2026-04-05 08:34:04.639428+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 08:31:04.651042+00	2026-04-05 08:34:04.647738+00	2026-04-05 08:41:04.651042+00	f	\N
d71a5625-3c96-4f47-8379-2ae5268db029	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 11:55:35.190815+00	2026-04-05 12:06:49.840531+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 11:55:35.190815+00	2026-04-05 12:06:49.849167+00	2026-04-05 12:03:35.190815+00	f	\N
6b1353d4-2852-4f7a-a230-db5f9dec2c1d	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 10:06:11.565592+00	2026-04-05 10:06:11.570328+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 10:04:11.565592+00	2026-04-05 10:06:11.583454+00	2026-04-05 10:14:11.565592+00	f	\N
6f5400fd-6df4-4846-8526-ac4df72b17a0	__pgboss__maintenance	0	\N	created	0	0	0	f	2026-04-05 14:03:33.722589+00	\N	__pgboss__maintenance	\N	00:15:00	2026-04-05 14:01:33.722589+00	\N	2026-04-05 14:11:33.722589+00	f	\N
8a6f38a1-76d9-41fe-8e14-0089def9e40b	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 08:44:04.665264+00	2026-04-05 08:45:04.65205+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 08:42:04.665264+00	2026-04-05 08:45:04.664212+00	2026-04-05 08:52:04.665264+00	f	\N
438360c5-2899-4bd7-8b1b-a1d92ff8f590	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 08:56:04.653762+00	2026-04-05 08:56:04.654362+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 08:54:04.653762+00	2026-04-05 08:56:04.664087+00	2026-04-05 09:04:04.653762+00	f	\N
2b10e3b3-381e-4ab6-afda-4557f21ea23a	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 10:17:11.592889+00	2026-04-05 10:18:11.596142+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 10:15:11.592889+00	2026-04-05 10:18:11.608033+00	2026-04-05 10:25:11.592889+00	f	\N
fb025d44-8df4-4734-aef8-7a7e11dc9d4a	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 12:17:49.860178+00	2026-04-05 12:18:49.851308+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 12:15:49.860178+00	2026-04-05 12:18:49.861072+00	2026-04-05 12:25:49.860178+00	f	\N
a11fd312-07cd-4c70-a409-adca303042a3	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 10:29:11.614235+00	2026-04-05 10:30:11.604602+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 10:27:11.614235+00	2026-04-05 10:30:11.613306+00	2026-04-05 10:37:11.614235+00	f	\N
9c337ece-f078-4dc7-a909-2c9127787863	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 12:29:49.885503+00	2026-04-05 12:30:49.884226+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 12:27:49.885503+00	2026-04-05 12:30:49.892041+00	2026-04-05 12:37:49.885503+00	f	\N
65e3aadc-eea5-4e19-aeaf-7aa17399e3ba	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 10:40:16.845313+00	2026-04-05 10:41:16.846563+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 10:38:16.845313+00	2026-04-05 10:41:16.850407+00	2026-04-05 10:48:16.845313+00	f	\N
63159b32-6cb6-461e-a874-2e0b2f8b0845	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 10:51:16.870683+00	2026-04-05 10:52:16.863433+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 10:49:16.870683+00	2026-04-05 10:52:16.868438+00	2026-04-05 10:59:16.870683+00	f	\N
e72e9798-879d-4a15-833a-1a4360c58546	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 12:41:49.922285+00	2026-04-05 12:42:41.335054+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 12:39:49.922285+00	2026-04-05 12:42:41.400847+00	2026-04-05 12:49:49.922285+00	f	\N
8f68840a-0c18-4672-b99a-fc07fdf2ba4e	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 13:00:44.496455+00	2026-04-05 13:04:16.516739+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 12:58:44.496455+00	2026-04-05 13:04:16.529826+00	2026-04-05 13:08:44.496455+00	f	\N
32dd235a-9c72-4f89-8acd-e2a8a90c87bc	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 13:15:16.523593+00	2026-04-05 13:15:51.398434+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 13:13:16.523593+00	2026-04-05 13:15:51.447726+00	2026-04-05 13:23:16.523593+00	f	\N
7ac19de4-2633-43d6-a195-b912f5b0cc44	__pgboss__maintenance	0	\N	completed	0	0	0	f	2026-04-05 13:26:33.659583+00	2026-04-05 13:27:33.656498+00	__pgboss__maintenance	\N	00:15:00	2026-04-05 13:24:33.659583+00	2026-04-05 13:27:33.665334+00	2026-04-05 13:34:33.659583+00	f	\N
\.


--
-- Data for Name: schedule; Type: TABLE DATA; Schema: pgboss; Owner: -
--

COPY pgboss.schedule (name, cron, timezone, data, options, created_on, updated_on) FROM stdin;
\.


--
-- Data for Name: subscription; Type: TABLE DATA; Schema: pgboss; Owner: -
--

COPY pgboss.subscription (event, name, created_on, updated_on) FROM stdin;
\.


--
-- Data for Name: version; Type: TABLE DATA; Schema: pgboss; Owner: -
--

COPY pgboss.version (version, maintained_on, cron_on) FROM stdin;
20	2026-04-05 14:01:33.720918+00	\N
\.


--
-- Data for Name: Announcement; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Announcement" (id, name, content, link, "linkText", published, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: Asset; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Asset" (id, title, description, "createdAt", "updatedAt", "userId", "mainImage", "mainImageExpiration", "categoryId", "locationId", "organizationId", status, value, "availableToBook", "kitId", "thumbnailImage", "sequentialId", "assetModelId", "consumptionType", "minQuantity", quantity, type, "unitOfMeasure") FROM stdin;
el887q5b6r9fwgrdvg28sv07	eSun PLA+ Fire Engine Red	Red coloured 3D printing PLA+ filament	2024-10-09 11:43:04	2025-07-08 08:52:47	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	h5xwujnjaj40yi5ed27n4s79	ww0q4ki2dixi9qkaz2m2g9d0	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	ONE_WAY	1	1	QUANTITY_TRACKED	KG
pf2tu0vzoilkmnifyki0drx6	Janome Dream Stitch	Sewing Machine	2025-07-07 11:52:06	2025-07-08 09:30:07	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	mo0ilfagb8vz4ovrnhd90v4a	ijy8lpy8npc9sqbq7fdhbdzm	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	\N	\N	\N	INDIVIDUAL	\N
nz7jff46pa0h5kj886858nh6	Fabric Scissors	Scissors for fabric	2025-07-07 12:34:25	2025-07-08 10:04:12	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	yckbsogctx7sndakwjsy5si8	ijy8lpy8npc9sqbq7fdhbdzm	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	TWO_WAY	1	1	QUANTITY_TRACKED	PCS
witiu7vbkkuhmnyxfcgpa4r8	Innov-is F540E Embroidery Machine	Embroidery Machine	2025-07-07 12:38:33	2025-07-08 09:29:49	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	mo0ilfagb8vz4ovrnhd90v4a	nsgdaq2w780ggj5w35vft28c	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	\N	1	\N	INDIVIDUAL	\N
nq0gwny01gztc30qkvzlrrds	64 AIRLOCK	Serger Machine	2025-07-07 12:44:19	2025-07-08 09:29:36	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	mo0ilfagb8vz4ovrnhd90v4a	nsgdaq2w780ggj5w35vft28c	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	\N	1	\N	INDIVIDUAL	\N
wbfgq2z82b0c16cgr6gwlcp8	eSun eSilk PLA 3D filament CYAN	Cyan coloured eSilk PLA 3D filament	2025-07-07 12:48:55	2025-07-08 08:52:01	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	h5xwujnjaj40yi5ed27n4s79	ww0q4ki2dixi9qkaz2m2g9d0	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	ONE_WAY	1	1	QUANTITY_TRACKED	KG
thobxz0g2vtgyw4rbo95xp9o	ePLA Silk Magic	Green Blue	2025-07-07 12:52:24	2025-07-08 08:51:29	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	h5xwujnjaj40yi5ed27n4s79	ww0q4ki2dixi9qkaz2m2g9d0	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	ONE_WAY	1	1	QUANTITY_TRACKED	KG
ttwkroqhdq2yim2seehggc0b	PLA+ 3D printer filament Olive Green	Olive Green coloured PLA+ 3D printer filament	2025-07-07 12:53:58	2025-07-08 08:53:33	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	h5xwujnjaj40yi5ed27n4s79	ww0q4ki2dixi9qkaz2m2g9d0	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	ONE_WAY	\N	1	QUANTITY_TRACKED	KG
ufgsmnbourw60ahq59sx7v0k	PLA+ 3D printer filament Beige	Beige coloured PLA+ 3D printer filament	2025-07-07 12:55:30	2025-07-08 08:53:03	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	h5xwujnjaj40yi5ed27n4s79	ww0q4ki2dixi9qkaz2m2g9d0	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	ONE_WAY	1	1	QUANTITY_TRACKED	KG
rggdo9fltmav3oscylfivi2v	ABS+ Black 3D printer filament	Black coloured ABS+ 3D printer filament	2025-07-07 12:57:49	2025-07-08 08:50:40	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	sr7r6mbqxpp2gskp6k56g64l	ww0q4ki2dixi9qkaz2m2g9d0	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	ONE_WAY	\N	1	QUANTITY_TRACKED	KG
wy3q3njeypz1p7ieeywto891	November	Voron 2.4 r-2	2025-07-07 13:17:04	2025-07-08 09:31:48	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	wx5zprzmrdfaglfc9i9frn9q	rlpq6mopy6rjygi7mi7i18d9	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	\N	1	\N	INDIVIDUAL	\N
q3wgjnz3bm9znxnpl3fabqkm	June	Voron 2.4 r-2	2025-07-07 13:17:54	2025-07-08 09:31:32	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	wx5zprzmrdfaglfc9i9frn9q	rlpq6mopy6rjygi7mi7i18d9	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	\N	1	\N	INDIVIDUAL	\N
v9a6qjap5r23ej5uxnag61jc	ePLA Silk Magic	Green Blue	2025-07-07 13:29:35	2025-07-08 08:51:44	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	h5xwujnjaj40yi5ed27n4s79	ww0q4ki2dixi9qkaz2m2g9d0	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	ONE_WAY	1	1	QUANTITY_TRACKED	KG
wsgncbo8kdqdypmrfl8hq9b0	Wire Stripper	Wire Stripper	2025-07-08 09:53:56	2025-07-08 10:07:00	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	rjpsv6s4eeq8fs92recxe7jp	o5dt5otekw9nkf46uwd42p78	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	TWO_WAY	1	2	QUANTITY_TRACKED	PCS
l8nfmfwv8uviausw755gzje1	Wire Stripper	Wire Stripper	2025-07-08 09:54:22	2025-07-08 10:12:59	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	rjpsv6s4eeq8fs92recxe7jp	h57fj92g42spzdvu8b2q92ga	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	TWO_WAY	1	2	QUANTITY_TRACKED	PCS
n6v2twwirvvm284doojmmfkl	CircutMaker3	Cricut cutting machine	2025-07-08 10:02:47	2025-07-08 10:03:21	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	cg9vfs9yt95a4jldyp5huq0g	nlvj6gb7zxol23hgcwwxjd6c	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	TWO_WAY	1	1	QUANTITY_TRACKED	PCS
zpun16bic48z19jrst7pqtxk	Fabric Scissors	Scissors for fabric	2025-07-08 10:04:51	2025-07-08 10:05:31	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	yckbsogctx7sndakwjsy5si8	ijy8lpy8npc9sqbq7fdhbdzm	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	TWO_WAY	1	1	QUANTITY_TRACKED	PCS
jy4pl2f23ntk2b04w5d0fwni	Scissors	Normal Scissors	2025-07-08 10:41:00	2025-07-08 10:42:45	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	ye34wgal7axwe6wa4kjqpp5q	c8kz0aq5kgge6clcn6z8sl6p	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	TWO_WAY	1	1	QUANTITY_TRACKED	PCS
rmnp10voacnnho6laudf7zfx	Rubber Mallet	\N	2025-07-08 10:44:46	2025-07-08 11:59:32	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	scs69jqhoxh1wle5bwfhpm8j	c8kz0aq5kgge6clcn6z8sl6p	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	TWO_WAY	1	1	QUANTITY_TRACKED	PCS
t10gf5t795c947ur1kmjibpg	Mini C Clamps	\N	2025-07-08 12:04:36	2025-07-08 12:16:01	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	icz8xs906lrnqbsrunu5wlj3	gaifhutgt667xjgmh0hh933v	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	TWO_WAY	2	5	QUANTITY_TRACKED	PCS
timy0ooiui9bv0g3t0l77kvi	Box Cutter	\N	2025-07-08 12:07:37	2025-07-08 12:07:37	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	ye34wgal7axwe6wa4kjqpp5q	c8kz0aq5kgge6clcn6z8sl6p	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	TWO_WAY	\N	1	QUANTITY_TRACKED	PCS
v3hlcfn2lh8vm8gxlmrz4saw	Pliers	Yellow/Black pliers	2025-07-08 12:11:29	2025-07-08 12:11:29	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	h6o79ty7qpyqa9dzv5utzz73	c8kz0aq5kgge6clcn6z8sl6p	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	TWO_WAY	1	1	QUANTITY_TRACKED	PCS
mtki1wf29p8mxtmk003yem4j	Vice Grip	\N	2025-07-08 12:13:20	2025-07-08 12:13:20	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	icz8xs906lrnqbsrunu5wlj3	c8kz0aq5kgge6clcn6z8sl6p	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	TWO_WAY	1	2	QUANTITY_TRACKED	PCS
f546qi7sannzlysc1m8brhnr	Mini IR thermometer	\N	2025-07-08 12:15:14	2025-07-08 12:15:45	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	hyrqwxcqht896hcfib2o9jon	c8kz0aq5kgge6clcn6z8sl6p	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	TWO_WAY	1	1	QUANTITY_TRACKED	PCS
t4iijlrss2ecgkzwxyqge898	Big C Clamps	\N	2025-07-08 12:17:37	2025-07-08 12:17:37	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	icz8xs906lrnqbsrunu5wlj3	gaifhutgt667xjgmh0hh933v	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	TWO_WAY	1	8	QUANTITY_TRACKED	PCS
xd52q140k3r1e8rqkt71isyp	F Clamps Long	\N	2025-07-08 12:20:14	2025-07-21 10:39:23	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	icz8xs906lrnqbsrunu5wlj3	mryl9dc5e37iathzm57dgszn	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	TWO_WAY	1	10	QUANTITY_TRACKED	PCS
lghf4z0rq971ur37ty5f4pwq	Big File	\N	2025-07-08 12:33:40	2025-07-08 12:33:40	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	hyrqwxcqht896hcfib2o9jon	c8kz0aq5kgge6clcn6z8sl6p	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	TWO_WAY	1	1	QUANTITY_TRACKED	PCS
xpqztk0eneqatduhb96k3uyv	Chakra-6	Feral Climpers	2025-07-08 12:41:23	2025-07-08 12:42:40	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	bkrtts928al9e8kt3rcts57x	c8kz0aq5kgge6clcn6z8sl6p	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	TWO_WAY	1	1	QUANTITY_TRACKED	PCS
rq0fku6jksvib3r1wovwx2j6	Shears	Mini Shears	2025-07-08 12:44:40	2025-07-08 12:45:08	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	ye34wgal7axwe6wa4kjqpp5q	c8kz0aq5kgge6clcn6z8sl6p	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	TWO_WAY	1	1	QUANTITY_TRACKED	PCS
hi28duluomke36y7vkdcnupc	WS2812B Testers	Led Tester	2025-07-09 12:42:31	2025-07-09 12:45:49	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	j6xdfa509nlzien80qfcf8lf	\N	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	TWO_WAY	1	1	QUANTITY_TRACKED	PCS
n8b94zl7cmb4faavli96k3tt	EL-AWS	Wire Cutter	2025-07-10 09:07:16	2025-07-10 09:07:40	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	ye34wgal7axwe6wa4kjqpp5q	c8kz0aq5kgge6clcn6z8sl6p	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	TWO_WAY	1	1	QUANTITY_TRACKED	PCS
bw14hkayqjer3b0djya6xxhs	Crimping pliers set	Crimping pliers	2025-07-10 09:08:55	2025-07-10 09:09:18	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	cg9vfs9yt95a4jldyp5huq0g	c8kz0aq5kgge6clcn6z8sl6p	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	TWO_WAY	1	2	QUANTITY_TRACKED	PCS
te7ffnlj6ufgd5kxkd8o5hip	Clip Lock	Sander	2025-07-10 09:10:05	2025-07-10 09:10:05	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	hyrqwxcqht896hcfib2o9jon	c8kz0aq5kgge6clcn6z8sl6p	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	TWO_WAY	1	1	QUANTITY_TRACKED	PCS
t53hcf9eq7ijwk4wenmko9bb	Combination Gear Spanner set	Gear Spanner set	2025-07-10 09:11:47	2025-07-10 09:12:38	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	qgrhyfjmyzy8mfsyas8b9es0	c8kz0aq5kgge6clcn6z8sl6p	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	TWO_WAY	1	1	QUANTITY_TRACKED	PCS
ot9tw46km4i3cznp7jqrqs55	Heavy Duty Wrench	Variable Crescent wrench	2025-07-10 09:14:35	2025-07-10 11:42:29	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	d5xmpc3eyovccrbu5avi9h3a	c8kz0aq5kgge6clcn6z8sl6p	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	TWO_WAY	1	1	QUANTITY_TRACKED	PCS
s4dl15kx81y110w4eysk7r9i	Steel Headed Hammer	\N	2025-07-10 09:15:59	2025-07-10 09:16:25	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	scs69jqhoxh1wle5bwfhpm8j	c8kz0aq5kgge6clcn6z8sl6p	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	TWO_WAY	1	1	QUANTITY_TRACKED	PCS
uzrsvt0g36ksdwrbeaz8zkho	18V XR	Brushless Motor Impact Driver	2025-07-10 09:21:32	2025-07-10 12:02:10	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	v4wtr5ea3ba2vjvoiuc9yerh	hung61oxqo4ho5sigk7mie9c	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	TWO_WAY	1	1	QUANTITY_TRACKED	PCS
qbeju8cq35ik262nowamp5yw	Micrometer	\N	2025-07-10 09:25:50	2025-07-10 09:39:35	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	cg07aamf6ous2e0t4nq43hlx	hung61oxqo4ho5sigk7mie9c	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	TWO_WAY	1	2	QUANTITY_TRACKED	PCS
cnvgt05mov170l9lkn7fu6g2	Drill Bits	Drill bit set	2025-07-10 09:27:28	2025-07-10 09:35:13	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	ue9d7h7vdmh4okamydymcdbg	hung61oxqo4ho5sigk7mie9c	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	TWO_WAY	1	1	QUANTITY_TRACKED	PCS
k13zsoglgs4idacpm6b8ipk8	Drill Bits	Drill bits set	2025-07-10 09:28:35	2025-07-10 09:35:30	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	ue9d7h7vdmh4okamydymcdbg	hung61oxqo4ho5sigk7mie9c	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	TWO_WAY	1	1	QUANTITY_TRACKED	PCS
acw7oaymwt94wm9cpn1baz9g	Screwdriver set	35 piece screwdriver set	2025-07-10 09:37:33	2025-07-10 09:37:57	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	klgaevfl8cy6ehlx1lfnrzqg	hung61oxqo4ho5sigk7mie9c	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	TWO_WAY	1	2	QUANTITY_TRACKED	PCS
llk70tfoare6y06p5aocbfua	Measuring tape	5m measuring tape	2025-07-10 09:40:09	2025-07-10 09:40:26	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	cg07aamf6ous2e0t4nq43hlx	hung61oxqo4ho5sigk7mie9c	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	TWO_WAY	1	2	QUANTITY_TRACKED	PCS
qj9npdcgly8qw9hzgg8xr6ye	Screwdriver set	Screwdriver set	2025-07-10 09:41:33	2025-07-10 09:41:33	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	cg9vfs9yt95a4jldyp5huq0g	hung61oxqo4ho5sigk7mie9c	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	TWO_WAY	1	1	QUANTITY_TRACKED	PCS
j9zjgtjio5vv1nf57n6m0l31	Caliper	Manual calipers	2025-07-10 11:38:13	2025-07-10 11:38:13	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	cg07aamf6ous2e0t4nq43hlx	hung61oxqo4ho5sigk7mie9c	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	TWO_WAY	1	1	QUANTITY_TRACKED	PCS
eybhlduihh0rijyue21yqbdc	Digital Caliper	\N	2025-07-10 11:39:24	2025-07-10 11:39:24	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	cg07aamf6ous2e0t4nq43hlx	hung61oxqo4ho5sigk7mie9c	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	TWO_WAY	1	3	QUANTITY_TRACKED	PCS
ky85v7c6ycdsotis8trv527u	Digital Caliper	\N	2025-07-10 11:40:42	2025-07-10 11:40:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	cg07aamf6ous2e0t4nq43hlx	hung61oxqo4ho5sigk7mie9c	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	TWO_WAY	1	1	QUANTITY_TRACKED	PCS
el5gfe00j7qafpl91anzpjyo	Chromium Spanner Set	Set of 12	2025-07-10 11:43:33	2025-07-10 11:43:56	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	qgrhyfjmyzy8mfsyas8b9es0	hung61oxqo4ho5sigk7mie9c	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	TWO_WAY	1	1	QUANTITY_TRACKED	PCS
b68rdrha9amjkqmtyewpyubv	Tube Cutter	PTFE Tube Cutter	2025-07-10 11:46:15	2025-07-10 11:46:15	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	ye34wgal7axwe6wa4kjqpp5q	hung61oxqo4ho5sigk7mie9c	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	TWO_WAY	1	1	QUANTITY_TRACKED	PCS
bus1s19avirwah9kixg5zbxk	Tweezer Set	5 Piece Tweezer Set	2025-07-10 11:47:56	2025-07-10 11:47:56	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	hyrqwxcqht896hcfib2o9jon	hung61oxqo4ho5sigk7mie9c	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	TWO_WAY	1	1	QUANTITY_TRACKED	PCS
ua39rbbxjs07a9q53h3wiss8	Drill Tap Set	6 Piece Drill Tap Set	2025-07-10 11:49:21	2025-07-10 11:49:21	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	ue9d7h7vdmh4okamydymcdbg	hung61oxqo4ho5sigk7mie9c	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	TWO_WAY	1	1	QUANTITY_TRACKED	PCS
hl3ruvdqxrqtokw355eq4lwb	T-Square	\N	2025-07-10 11:51:18	2025-07-10 11:51:18	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	cg07aamf6ous2e0t4nq43hlx	hung61oxqo4ho5sigk7mie9c	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	TWO_WAY	1	1	QUANTITY_TRACKED	PCS
epv71bariq68080fe029rjgk	Generic Wire Stripper	Universal Wire Stripper	2025-07-10 11:54:35	2025-07-10 11:54:35	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	rjpsv6s4eeq8fs92recxe7jp	c8kz0aq5kgge6clcn6z8sl6p	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	TWO_WAY	1	1	QUANTITY_TRACKED	PCS
g447lqkrqg9q7paru3devxf5	Scrapper	Deepraj Stay Away	2025-07-10 11:58:43	2025-07-10 11:58:43	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	hyrqwxcqht896hcfib2o9jon	gaifhutgt667xjgmh0hh933v	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	TWO_WAY	1	1	QUANTITY_TRACKED	PCS
wsfa4biet6h3e2s1ecmuul0f	18V XR	Brushless Motor Cordless Drill with Impact Hammer	2025-07-10 12:03:23	2025-07-10 12:03:36	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	v4wtr5ea3ba2vjvoiuc9yerh	hung61oxqo4ho5sigk7mie9c	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	TWO_WAY	1	2	QUANTITY_TRACKED	PCS
jhzemede78o9z5km8uecgbf6	18V XR	Brushless Motor Cordless Drill	2025-07-10 12:04:37	2025-07-10 12:04:37	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	v4wtr5ea3ba2vjvoiuc9yerh	hung61oxqo4ho5sigk7mie9c	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	TWO_WAY	1	1	QUANTITY_TRACKED	PCS
gsu17ldpx0as9g0g2tln2krw	XR Lithium Ion batteries	2 AH batteries	2025-07-10 12:08:20	2025-07-10 12:11:06	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	y1fpwxb9qfoeg9chs2d53rvk	mryl9dc5e37iathzm57dgszn	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	TWO_WAY	1	6	QUANTITY_TRACKED	PCS
bty92v7c5e5xefu88ysd2ta0	XR Lithium Ion Batteries	1.5 AH	2025-07-10 12:10:35	2025-07-10 12:10:35	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	y1fpwxb9qfoeg9chs2d53rvk	mryl9dc5e37iathzm57dgszn	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	TWO_WAY	1	2	QUANTITY_TRACKED	PCS
h8k7oc2okptdqy9b7j0qdigg	XR Lithium Ion Batteries	5 AH	2025-07-10 12:13:32	2025-07-10 12:13:32	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	y1fpwxb9qfoeg9chs2d53rvk	mryl9dc5e37iathzm57dgszn	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	TWO_WAY	1	2	QUANTITY_TRACKED	PCS
uosg3nxzt37vf2ijmrrzhrwb	Cordless Glue Gun	2.0 AH Cordless Glue Gun	2025-07-10 12:20:51	2025-07-10 12:21:07	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	sbpwrmv4vg3gefesk1yidnv2	hung61oxqo4ho5sigk7mie9c	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	TWO_WAY	1	1	QUANTITY_TRACKED	PCS
thx0okep4a329u4w6v7dksfs	Glue Gun (Cord)	\N	2025-07-10 12:22:53	2025-07-10 12:22:53	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	sbpwrmv4vg3gefesk1yidnv2	d8dxasjqkg5prqgbqk1micb3	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	TWO_WAY	1	1	QUANTITY_TRACKED	PCS
abrq4bml4rxdh1z40fl75hau	Dial Gauge Stand	Magnetic Stand for Dial Gauge	2025-07-10 12:25:37	2025-07-10 12:25:57	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	auqf3vp8ubnv4jkm0aqa6wxr	c8kz0aq5kgge6clcn6z8sl6p	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	TWO_WAY	1	1	QUANTITY_TRACKED	PCS
ncmecez8i9r3ecaybobzj9q4	Clamp Meter	\N	2025-07-10 12:28:02	2025-07-10 12:28:21	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	cg07aamf6ous2e0t4nq43hlx	d8dxasjqkg5prqgbqk1micb3	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	TWO_WAY	1	1	QUANTITY_TRACKED	PCS
cmjsflo1wcsrrytutvir7fx9	F Clamps Small	Shorter F Clamps	2025-07-21 10:39:03	2025-07-21 10:40:05	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	icz8xs906lrnqbsrunu5wlj3	mryl9dc5e37iathzm57dgszn	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	TWO_WAY	1	9	QUANTITY_TRACKED	PCS
dwwkzgcwqji0zvnd3csycp52	Projector	Short Throw Projector-6500 lumens	2025-07-21 12:16:01	2025-07-21 12:39:21	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	bw4h21c304a7l92hfvb0wklr	c8kz0aq5kgge6clcn6z8sl6p	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	TWO_WAY	1	1	QUANTITY_TRACKED	PCS
iqnhqt50ckmeoyz6sagqmj3k	Arduino Uno R3		2025-07-21 14:13:24	2026-04-04 10:28:18.527	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	ypstwm8vf9pbcs377ja78lwf	\N	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	TWO_WAY	0	20	QUANTITY_TRACKED	PCS
j8pgd4kjyf6a2js341z80gr7	Augustine	Ender-3 V2	2025-07-07 13:20:26	2025-07-08 09:27:03	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	\N	wx5zprzmrdfaglfc9i9frn9q	\N	org-admin-personal	AVAILABLE	\N	t	\N	\N	\N	\N	\N	1	\N	INDIVIDUAL	\N
\.


--
-- Data for Name: AssetCustomFieldValue; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."AssetCustomFieldValue" (id, "assetId", "customFieldId", "createdAt", "updatedAt", value) FROM stdin;
aini28bzwah2hjzc8q6wy9sv	el887q5b6r9fwgrdvg28sv07	g57dhkguapobaoze7cn0855z	2026-04-03 09:49:13.805	2026-04-03 09:49:13.805	{"raw": "FR123", "valueText": "FR123"}
coke8ug5xw4lj2x6kx77sx5h	el887q5b6r9fwgrdvg28sv07	g7t4divnogsc046fs0si2ftn	2026-04-03 09:49:13.806	2026-04-03 09:49:13.806	{"raw": "6922572219038", "valueText": "6922572219038"}
ww19txxxa1swfart1nl8fzg5	nz7jff46pa0h5kj886858nh6	g57dhkguapobaoze7cn0855z	2026-04-03 09:49:13.81	2026-04-03 09:49:13.81	{"raw": "FS01", "valueText": "FS01"}
gxldpeswmjyy51mees60wnrm	wsgncbo8kdqdypmrfl8hq9b0	g57dhkguapobaoze7cn0855z	2026-04-03 09:49:13.829	2026-04-03 09:49:13.829	{"raw": "WS01", "valueText": "WS01"}
w5hqxa6lh5antccj3ka5nnzt	l8nfmfwv8uviausw755gzje1	g57dhkguapobaoze7cn0855z	2026-04-03 09:49:13.832	2026-04-03 09:49:13.832	{"raw": "WS02", "valueText": "WS02"}
kffkysl5rfxa9qpa8p9yrqe0	zpun16bic48z19jrst7pqtxk	g57dhkguapobaoze7cn0855z	2026-04-03 09:49:13.837	2026-04-03 09:49:13.837	{"raw": "FS02", "valueText": "FS02"}
m3embiouikb2q66ri9k5hzrq	jy4pl2f23ntk2b04w5d0fwni	g57dhkguapobaoze7cn0855z	2026-04-03 09:49:13.84	2026-04-03 09:49:13.84	{"raw": "SC01", "valueText": "SC01"}
w9eyycdd8zp36h250m8qtwdn	t10gf5t795c947ur1kmjibpg	g57dhkguapobaoze7cn0855z	2026-04-03 09:49:13.844	2026-04-03 09:49:13.844	{"raw": "CM01", "valueText": "CM01"}
ntx20hc34suoc7um7cjacn2p	timy0ooiui9bv0g3t0l77kvi	g57dhkguapobaoze7cn0855z	2026-04-03 09:49:13.846	2026-04-03 09:49:13.846	{"raw": "BC01", "valueText": "BC01"}
net12k4v4voc33uy3m9bbtlf	v3hlcfn2lh8vm8gxlmrz4saw	g57dhkguapobaoze7cn0855z	2026-04-03 09:49:13.85	2026-04-03 09:49:13.85	{"raw": "PL01", "valueText": "PL01"}
zvvolvo6vu1ajc5k0htyhy2d	mtki1wf29p8mxtmk003yem4j	g57dhkguapobaoze7cn0855z	2026-04-03 09:49:13.854	2026-04-03 09:49:13.854	{"raw": "VG01", "valueText": "VG01"}
l6ggzwus57wrsq6fib1434r0	t4iijlrss2ecgkzwxyqge898	g57dhkguapobaoze7cn0855z	2026-04-03 09:49:13.861	2026-04-03 09:49:13.861	{"raw": "CC01", "valueText": "CC01"}
oh30a9uv3qlizwqcdam7z9zp	xd52q140k3r1e8rqkt71isyp	g57dhkguapobaoze7cn0855z	2026-04-03 09:49:13.864	2026-04-03 09:49:13.864	{"raw": "FC01", "valueText": "FC01"}
o38l28qxxzrox36a7l0tpcqz	dwwkzgcwqji0zvnd3csycp52	g57dhkguapobaoze7cn0855z	2026-04-03 09:49:13.922	2026-04-03 09:49:13.922	{"raw": "Q7L1445U01A1B0001", "valueText": "Q7L1445U01A1B0001"}
h6lbu55j4awsz8e6iobc5ju8	dwwkzgcwqji0zvnd3csycp52	g7t4divnogsc046fs0si2ftn	2026-04-03 09:49:13.923	2026-04-03 09:49:13.923	{"raw": "Q7L1445U01A1B0001", "valueText": "Q7L1445U01A1B0001"}
\.


--
-- Data for Name: AssetFilterPreset; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."AssetFilterPreset" (id, "organizationId", "ownerId", name, query, starred, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: AssetIndexSettings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."AssetIndexSettings" (id, "userId", "organizationId", mode, "createdAt", "updatedAt", columns, "freezeColumn", "showAssetImage") FROM stdin;
cmnhjk7pg0003p72n1fm1ddvm	11438b69-6887-4ad5-926b-75fc18eb32e7	org-admin-personal	ADVANCED	2026-04-02 13:59:44.644	2026-04-03 09:38:18.657	[{"name": "id", "visible": false, "position": 0}, {"name": "sequentialId", "visible": true, "position": 1}, {"name": "qrId", "visible": true, "position": 2}, {"name": "status", "visible": true, "position": 3}, {"name": "description", "visible": true, "position": 4}, {"name": "valuation", "visible": true, "position": 5}, {"name": "availableToBook", "visible": true, "position": 6}, {"name": "createdAt", "visible": true, "position": 7}, {"name": "updatedAt", "visible": true, "position": 8}, {"name": "category", "visible": true, "position": 9}, {"name": "tags", "visible": true, "position": 10}, {"name": "location", "visible": true, "position": 11}, {"name": "kit", "visible": true, "position": 12}, {"name": "custody", "visible": true, "position": 13}, {"name": "upcomingReminder", "visible": true, "position": 14}, {"name": "actions", "visible": true, "position": 15}, {"name": "upcomingBookings", "visible": true, "position": 16}, {"name": "quantity", "visible": false, "position": 17}, {"name": "type", "visible": false, "position": 18}, {"name": "assetModel", "visible": false, "position": 19}]	t	t
\.


--
-- Data for Name: AssetModel; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."AssetModel" (id, name, description, image, "imageExpiration", "defaultCategoryId", "defaultValuation", "organizationId", "userId", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: AssetReminder; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."AssetReminder" (id, name, message, "alertDateTime", "assetId", "createdById", "createdAt", "updatedAt", "organizationId", "activeSchedulerReference") FROM stdin;
\.


--
-- Data for Name: AuditAsset; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."AuditAsset" (id, "auditSessionId", "assetId", expected, status, "scannedById", "scannedAt", metadata, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: AuditAssignment; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."AuditAssignment" (id, "auditSessionId", "userId", role, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: AuditImage; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."AuditImage" (id, "imageUrl", "thumbnailUrl", description, "auditSessionId", "auditAssetId", "uploadedById", "organizationId", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: AuditNote; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."AuditNote" (id, content, type, "createdAt", "updatedAt", "userId", "auditSessionId", "auditAssetId") FROM stdin;
\.


--
-- Data for Name: AuditScan; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."AuditScan" (id, "auditSessionId", "auditAssetId", "assetId", "scannedById", code, metadata, "scannedAt", "createdAt") FROM stdin;
\.


--
-- Data for Name: AuditSession; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."AuditSession" (id, name, description, "targetId", status, "scopeMeta", "expectedAssetCount", "foundAssetCount", "missingAssetCount", "unexpectedAssetCount", "startedAt", "completedAt", "cancelledAt", "createdById", "organizationId", "createdAt", "updatedAt", "dueDate", "activeSchedulerReference") FROM stdin;
\.


--
-- Data for Name: Barcode; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Barcode" (id, value, type, "assetId", "kitId", "organizationId", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: Booking; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Booking" (id, name, status, "creatorId", "organizationId", "createdAt", "updatedAt", "from", "to", "custodianTeamMemberId", "custodianUserId", "activeSchedulerReference", description, "originalFrom", "originalTo", "cancellationReason", "autoArchivedAt") FROM stdin;
\.


--
-- Data for Name: BookingAsset; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."BookingAsset" (id, "bookingId", "assetId", quantity) FROM stdin;
\.


--
-- Data for Name: BookingNote; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."BookingNote" (id, content, type, "createdAt", "updatedAt", "userId", "bookingId") FROM stdin;
\.


--
-- Data for Name: BookingSettings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."BookingSettings" (id, "bufferStartTime", "organizationId", "createdAt", "updatedAt", "tagsRequired", "maxBookingLength", "maxBookingLengthSkipClosedDays", "requireExplicitCheckinForAdmin", "requireExplicitCheckinForSelfService", "autoArchiveBookings", "autoArchiveDays", "notifyAdminsOnNewBooking", "notifyBookingCreator") FROM stdin;
cmnhjk7pd0001p72nh4any7co	0	org-admin-personal	2026-04-02 13:59:44.642	2026-04-02 13:59:44.642	f	\N	f	f	f	f	2	t	t
\.


--
-- Data for Name: Category; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Category" (id, name, description, color, "createdAt", "updatedAt", "userId", "organizationId") FROM stdin;
j2pcxneh651zlq3hbla7ibnv	Filaments	These are all the filaments we have available for printing	#4f46e5	2024-10-09 11:38:20	2025-07-21 14:05:04	11438b69-6887-4ad5-926b-75fc18eb32e7	org-admin-personal
ckphjmn17ftcombhc72qok2m	Fabric Station	\N	#0891b2	2025-06-10 08:13:36	2025-07-21 14:05:01	11438b69-6887-4ad5-926b-75fc18eb32e7	org-admin-personal
cg9vfs9yt95a4jldyp5huq0g	Big Machines	\N	#059669	2025-07-07 13:16:41	2025-07-21 14:04:57	11438b69-6887-4ad5-926b-75fc18eb32e7	org-admin-personal
pivy9i3m971qi1yde4q7p12x	Big Machines > Mac Minis/Studios	\N	#d97706	2025-07-08 08:49:07	2025-07-08 08:49:12	11438b69-6887-4ad5-926b-75fc18eb32e7	org-admin-personal
h5xwujnjaj40yi5ed27n4s79	Filaments > PLA/PLA+	\N	#dc2626	2025-07-08 08:49:37	2025-07-08 08:49:37	11438b69-6887-4ad5-926b-75fc18eb32e7	org-admin-personal
sr7r6mbqxpp2gskp6k56g64l	Filaments > ABS/ABS+	\N	#7c3aed	2025-07-08 08:49:51	2025-07-08 08:49:51	11438b69-6887-4ad5-926b-75fc18eb32e7	org-admin-personal
qnjx7qxln4ef3l8fhj4vthtx	Filaments > TPU	\N	#db2777	2025-07-08 08:49:59	2025-07-08 08:49:59	11438b69-6887-4ad5-926b-75fc18eb32e7	org-admin-personal
rkwz7b4r51p0sxygkvpcpifa	Filaments > PETG	\N	#2563eb	2025-07-08 08:50:14	2025-07-08 08:50:14	11438b69-6887-4ad5-926b-75fc18eb32e7	org-admin-personal
wx5zprzmrdfaglfc9i9frn9q	Big Machines > Printers	\N	#16a34a	2025-07-08 09:00:15	2025-07-08 09:33:12	11438b69-6887-4ad5-926b-75fc18eb32e7	org-admin-personal
mo0ilfagb8vz4ovrnhd90v4a	Fabric Station > Sewing machines	\N	#ea580c	2025-07-08 09:28:51	2025-07-08 09:28:55	11438b69-6887-4ad5-926b-75fc18eb32e7	org-admin-personal
yckbsogctx7sndakwjsy5si8	Fabric Station > Sewing tools	\N	#4f46e5	2025-07-08 09:29:17	2025-07-08 09:29:17	11438b69-6887-4ad5-926b-75fc18eb32e7	org-admin-personal
hyrqwxcqht896hcfib2o9jon	Tools	\N	#0891b2	2025-07-08 09:56:51	2025-07-21 14:05:10	11438b69-6887-4ad5-926b-75fc18eb32e7	org-admin-personal
klgaevfl8cy6ehlx1lfnrzqg	Tools > Screwdrivers	\N	#059669	2025-07-08 09:56:51	2025-07-08 09:56:51	11438b69-6887-4ad5-926b-75fc18eb32e7	org-admin-personal
rjpsv6s4eeq8fs92recxe7jp	Tools > Wire Strippers	\N	#d97706	2025-07-08 09:56:51	2025-07-08 09:56:51	11438b69-6887-4ad5-926b-75fc18eb32e7	org-admin-personal
ye34wgal7axwe6wa4kjqpp5q	Tools > Cutters	\N	#dc2626	2025-07-08 09:56:51	2025-07-08 09:56:51	11438b69-6887-4ad5-926b-75fc18eb32e7	org-admin-personal
h6o79ty7qpyqa9dzv5utzz73	Tools > Pliers	\N	#7c3aed	2025-07-08 09:56:51	2025-07-08 09:56:51	11438b69-6887-4ad5-926b-75fc18eb32e7	org-admin-personal
scs69jqhoxh1wle5bwfhpm8j	Tools > Hammers	\N	#db2777	2025-07-08 10:44:01	2025-07-08 10:44:01	11438b69-6887-4ad5-926b-75fc18eb32e7	org-admin-personal
icz8xs906lrnqbsrunu5wlj3	Tools > Clamps	\N	#2563eb	2025-07-08 12:03:43	2025-07-08 12:03:43	11438b69-6887-4ad5-926b-75fc18eb32e7	org-admin-personal
bkrtts928al9e8kt3rcts57x	Tools > Climpers	\N	#16a34a	2025-07-08 12:40:19	2025-07-08 12:40:19	11438b69-6887-4ad5-926b-75fc18eb32e7	org-admin-personal
j6xdfa509nlzien80qfcf8lf	Tools > Test Rigs	\N	#ea580c	2025-07-09 12:44:13	2025-07-09 12:44:13	11438b69-6887-4ad5-926b-75fc18eb32e7	org-admin-personal
qgrhyfjmyzy8mfsyas8b9es0	Tools > Spanners	\N	#4f46e5	2025-07-10 09:12:06	2025-07-10 09:12:06	11438b69-6887-4ad5-926b-75fc18eb32e7	org-admin-personal
d5xmpc3eyovccrbu5avi9h3a	Tools > Wrench	\N	#0891b2	2025-07-10 09:13:50	2025-07-10 09:14:00	11438b69-6887-4ad5-926b-75fc18eb32e7	org-admin-personal
ue9d7h7vdmh4okamydymcdbg	Tools > Drills	\N	#059669	2025-07-10 09:34:31	2025-07-10 09:34:31	11438b69-6887-4ad5-926b-75fc18eb32e7	org-admin-personal
cg07aamf6ous2e0t4nq43hlx	Tools > Measuring tools	\N	#d97706	2025-07-10 09:39:13	2025-07-10 09:39:13	11438b69-6887-4ad5-926b-75fc18eb32e7	org-admin-personal
v4wtr5ea3ba2vjvoiuc9yerh	Tools > Power Tools	\N	#dc2626	2025-07-10 12:01:52	2025-07-10 12:01:52	11438b69-6887-4ad5-926b-75fc18eb32e7	org-admin-personal
y1fpwxb9qfoeg9chs2d53rvk	Batteries	\N	#7c3aed	2025-07-10 12:06:42	2025-07-10 12:06:42	11438b69-6887-4ad5-926b-75fc18eb32e7	org-admin-personal
sbpwrmv4vg3gefesk1yidnv2	Tools > Adhesives	\N	#db2777	2025-07-10 12:19:37	2025-07-10 12:19:37	11438b69-6887-4ad5-926b-75fc18eb32e7	org-admin-personal
auqf3vp8ubnv4jkm0aqa6wxr	Tools > Stands	\N	#2563eb	2025-07-10 12:25:10	2025-07-10 12:25:10	11438b69-6887-4ad5-926b-75fc18eb32e7	org-admin-personal
bw4h21c304a7l92hfvb0wklr	Projector	\N	#16a34a	2025-07-21 12:16:01	2025-07-21 14:05:07	11438b69-6887-4ad5-926b-75fc18eb32e7	org-admin-personal
d9ppf45gx0jnvmh6earwd5iz	Projector > Short Throw	\N	#ea580c	2025-07-21 12:31:16	2025-07-21 12:31:16	11438b69-6887-4ad5-926b-75fc18eb32e7	org-admin-personal
ewm4alq8x6imr4b1kb0hcdmk	Electronics	\N	#4f46e5	2025-07-21 13:31:13	2025-07-21 14:04:53	11438b69-6887-4ad5-926b-75fc18eb32e7	org-admin-personal
ypstwm8vf9pbcs377ja78lwf	Electronics > Microcontrollers	\N	#0891b2	2025-07-21 14:04:32	2025-07-21 14:04:32	11438b69-6887-4ad5-926b-75fc18eb32e7	org-admin-personal
k6ljrv5so9y7aophj94l9fta	Electronics > Sensors & Actuators	\N	#059669	2025-07-21 16:12:52	2025-07-21 16:12:52	11438b69-6887-4ad5-926b-75fc18eb32e7	org-admin-personal
shoaez83is5g0ywek60y3mai	Electronics > Breadboards & Protoboards	\N	#d97706	2025-07-21 16:13:58	2025-07-21 16:13:58	11438b69-6887-4ad5-926b-75fc18eb32e7	org-admin-personal
iaiqvnvbj6e8mbqqplrtl4h5	Electronics > Resistors, Capacitors, ICs	\N	#dc2626	2025-07-21 16:16:34	2025-07-21 16:16:34	11438b69-6887-4ad5-926b-75fc18eb32e7	org-admin-personal
t2oneebjtxutn3oxhy64fo5z	Electronics > Connectors & Cables	\N	#7c3aed	2025-07-21 16:18:07	2025-07-21 16:18:07	11438b69-6887-4ad5-926b-75fc18eb32e7	org-admin-personal
qbinvhd495frpy7wge4qhfmq	Electronics > Power Supplies	\N	#db2777	2025-07-21 16:18:56	2025-07-21 16:18:56	11438b69-6887-4ad5-926b-75fc18eb32e7	org-admin-personal
lmfhvnkujpufau58qqsrfwft	Electronics > Oscilloscopes, Multimeters + Measuring Tools	\N	#2563eb	2025-07-21 16:19:49	2025-07-21 16:21:47	11438b69-6887-4ad5-926b-75fc18eb32e7	org-admin-personal
fcd79egpzrqqlg5lure9z3g2	Electronics > Soldering Equipment	\N	#16a34a	2025-07-21 16:20:38	2025-07-21 16:20:38	11438b69-6887-4ad5-926b-75fc18eb32e7	org-admin-personal
\.


--
-- Data for Name: ConsumptionLog; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."ConsumptionLog" (id, "assetId", category, quantity, note, "userId", "bookingId", "custodianId", "createdAt") FROM stdin;
\.


--
-- Data for Name: Custody; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Custody" (id, "teamMemberId", "assetId", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: CustomField; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."CustomField" (id, name, "helpText", required, type, "organizationId", "userId", "createdAt", "updatedAt", active, options, "deletedAt") FROM stdin;
g57dhkguapobaoze7cn0855z	IPN	Internal Part Number	f	TEXT	org-admin-personal	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 09:49:13.798	2026-04-03 09:49:13.798	t	\N	\N
g7t4divnogsc046fs0si2ftn	MPN	Manufacturer Part Number	f	TEXT	org-admin-personal	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 09:49:13.799	2026-04-03 09:49:13.799	t	\N	\N
\.


--
-- Data for Name: CustomTierLimit; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."CustomTierLimit" (id, "userId", "canImportAssets", "canExportAssets", "maxCustomFields", "maxOrganizations", "createdAt", "updatedAt", "canImportNRM", "isEnterprise", "canHideShelfBranding") FROM stdin;
\.


--
-- Data for Name: Image; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Image" (id, "contentType", "altText", blob, "createdAt", "updatedAt", "userId", "ownerOrgId") FROM stdin;
\.


--
-- Data for Name: Invite; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Invite" (id, "inviterId", "organizationId", "inviteeUserId", "teamMemberId", "inviteeEmail", status, "inviteCode", roles, "expiresAt", "createdAt", "updatedAt", "inviteMessage") FROM stdin;
\.


--
-- Data for Name: Kit; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Kit" (id, name, description, status, image, "imageExpiration", "organizationId", "createdById", "createdAt", "updatedAt", "categoryId", "locationId") FROM stdin;
\.


--
-- Data for Name: KitCustody; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."KitCustody" (id, "custodianId", "kitId", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: Location; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Location" (id, name, description, address, "createdAt", "updatedAt", "userId", "imageId", "organizationId", "imageUrl", "thumbnailUrl", latitude, longitude, "parentId") FROM stdin;
kv4iio684np24bx3habn7pad	007	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	\N
rlpq6mopy6rjygi7mi7i18d9	D1 - Printer	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	kv4iio684np24bx3habn7pad
nlvj6gb7zxol23hgcwwxjd6c	D2 - Cricut Station	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	kv4iio684np24bx3habn7pad
h57fj92g42spzdvu8b2q92ga	D3 - Electronics Workstation	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	kv4iio684np24bx3habn7pad
apanxfzws7wb8gqsx7qoff85	D4 - Sai Corner	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	kv4iio684np24bx3habn7pad
wv0rty9i1g7w8cpunmb80epj	D5 - Sai Workstation	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	kv4iio684np24bx3habn7pad
ns03x0kzz9o4akcnju6zxdlf	D6 - Kanishk Workstation	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	kv4iio684np24bx3habn7pad
kjnx64c6jahf0nvj5w5mib5y	D7 - Vaanee Workstation	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	kv4iio684np24bx3habn7pad
ms1dn9gcdt0s53a3cqf4k3bl	D8 - Hexagon Corner	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	kv4iio684np24bx3habn7pad
t7rj78c62pnu859ymilge43y	D9 - Ojas Workstation	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	kv4iio684np24bx3habn7pad
q2c6w3tm2fr2989fx8b0dsc3	D10 - Deepraj Workstation	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	kv4iio684np24bx3habn7pad
gaifhutgt667xjgmh0hh933v	D11 - Printer Workstation	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	kv4iio684np24bx3habn7pad
d8dxasjqkg5prqgbqk1micb3	Whiteboard Shelf	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	kv4iio684np24bx3habn7pad
ww0q4ki2dixi9qkaz2m2g9d0	Filament Rack	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	d8dxasjqkg5prqgbqk1micb3
c8kz0aq5kgge6clcn6z8sl6p	Main Island	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	kv4iio684np24bx3habn7pad
hung61oxqo4ho5sigk7mie9c	Wall Shelf	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	kv4iio684np24bx3habn7pad
sx2efi5pwog7rj6y5q06e4vc	Array A	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	hung61oxqo4ho5sigk7mie9c
gpqrsx6l05tbx15tc44w8evr	A11 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	sx2efi5pwog7rj6y5q06e4vc
kmnl5brseexnj9gncfx4koj3	A12 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	sx2efi5pwog7rj6y5q06e4vc
kkh8ku030gkz7otghq787b6a	A13 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	sx2efi5pwog7rj6y5q06e4vc
g9faz1nivosilv90070vziw1	A14 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	sx2efi5pwog7rj6y5q06e4vc
b32t980d8xhvrso72xjjc11k	A15 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	sx2efi5pwog7rj6y5q06e4vc
hvagniuhcrqkb07dulp9wr0q	A21 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	sx2efi5pwog7rj6y5q06e4vc
k2f3au13btsxwfda7032t3hi	A22 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	sx2efi5pwog7rj6y5q06e4vc
qahrlr2z71yru9sagu17tx4z	A23 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	sx2efi5pwog7rj6y5q06e4vc
gwbsnfni36vcmvsjnni767q6	A24 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	sx2efi5pwog7rj6y5q06e4vc
fi38k9ni2igu4l6kmlks2b8z	A25 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	sx2efi5pwog7rj6y5q06e4vc
p2pakdz7l56fnxuhs1ouno06	A31 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	sx2efi5pwog7rj6y5q06e4vc
vw6b9qx28lzsse9s1umhpxr9	A32 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	sx2efi5pwog7rj6y5q06e4vc
m53jizjd9du8k7uxc9cl0crf	A33 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	sx2efi5pwog7rj6y5q06e4vc
n3h7fcjrc7fqxjxv0p65bgkn	A34 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	sx2efi5pwog7rj6y5q06e4vc
fdpnysbex2b1cy7y2pjn97lh	A35 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	sx2efi5pwog7rj6y5q06e4vc
uqykmnw4oni9g25o4jgsojmc	A41 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	sx2efi5pwog7rj6y5q06e4vc
gyhaiiaktq7ep1clj24f1cup	A42 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	sx2efi5pwog7rj6y5q06e4vc
e7dtywa7ulzg5hr7wmgykwue	A43 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	sx2efi5pwog7rj6y5q06e4vc
n4r6u1zpkiyfk043hep6sauj	A44 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	sx2efi5pwog7rj6y5q06e4vc
fq6pza6rrgkx13ggzxrh9s4s	A45 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	sx2efi5pwog7rj6y5q06e4vc
sqwebp5x463r9qkl4vqwa96s	A51 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	sx2efi5pwog7rj6y5q06e4vc
ogivtz7qpcq29r7xtc40ifvd	A52 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	sx2efi5pwog7rj6y5q06e4vc
c0w4s0wptirhl933oo32tq2l	A53 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	sx2efi5pwog7rj6y5q06e4vc
xwwjjbrwzhsyygda1a7jmjys	A54 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	sx2efi5pwog7rj6y5q06e4vc
b2j5d3wdsw7hs0w2ghu3uu02	A55 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	sx2efi5pwog7rj6y5q06e4vc
qdins633vrskhkopcwl30t6e	A61 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	sx2efi5pwog7rj6y5q06e4vc
fbji9g4xe1hftwcb4psqyr75	A62 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	sx2efi5pwog7rj6y5q06e4vc
cmi9g8457zsfxianf7td23ia	A63 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	sx2efi5pwog7rj6y5q06e4vc
fltbqefroo29goqr25svpmzc	A64 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	sx2efi5pwog7rj6y5q06e4vc
a5u1blgu0s7uabj6i7z63qp1	A65 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	sx2efi5pwog7rj6y5q06e4vc
qc1w7bqa5xuhok3az1wfira3	A71 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	sx2efi5pwog7rj6y5q06e4vc
mpxuq7v72ulnd06g4cmwovfr	A72 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	sx2efi5pwog7rj6y5q06e4vc
bb2kl1jax1tt0yews2lx4sb3	A73 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	sx2efi5pwog7rj6y5q06e4vc
kaf7iojeczt3al8swre463t9	A74 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	sx2efi5pwog7rj6y5q06e4vc
n8tfrg4lkw5a9d2n61atih19	A75 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	sx2efi5pwog7rj6y5q06e4vc
teex3by08y9xck2issft6xx2	A81 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	sx2efi5pwog7rj6y5q06e4vc
hzldhe5c1qc04ognp8h5lgeu	A82 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	sx2efi5pwog7rj6y5q06e4vc
e5afhc1iu6gzywkszgvbjq5s	A83 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	sx2efi5pwog7rj6y5q06e4vc
o5sykkm2xmhds7tmt07ju110	A84 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	sx2efi5pwog7rj6y5q06e4vc
tk000xyluv8bqhp27exjetbe	A85 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	sx2efi5pwog7rj6y5q06e4vc
eqfw1h4bcjetf9yq9erkgsv0	Array B	\N	\N	2024-10-11 13:20:42	2024-10-11 13:23:00	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	hung61oxqo4ho5sigk7mie9c
yrfn49ckxt47pd14dk3n8had	B11 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	eqfw1h4bcjetf9yq9erkgsv0
cb7lm9bexrbvav70b5k8plgq	B12 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	eqfw1h4bcjetf9yq9erkgsv0
qw8tbcnpjsrd3xhonhdy5jj6	B13 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	eqfw1h4bcjetf9yq9erkgsv0
qnnp8h215ghshel7pvzx0za0	B14 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	eqfw1h4bcjetf9yq9erkgsv0
urriqm8q9c2w6q6b7h0ztfbi	B15 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	eqfw1h4bcjetf9yq9erkgsv0
wjyktomuq5ay7ulggjrcyg1r	B21 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	eqfw1h4bcjetf9yq9erkgsv0
iwa27ehf7oepvizqt49ypksv	B22 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	eqfw1h4bcjetf9yq9erkgsv0
lwvxll9d021jxhnv5z2wnxhj	B23 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	eqfw1h4bcjetf9yq9erkgsv0
ieufbbcvrxh1wyhccxbajj3l	B24 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	eqfw1h4bcjetf9yq9erkgsv0
hdxz0q5uxkw9v58ynnrthfr2	B25 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	eqfw1h4bcjetf9yq9erkgsv0
dbirkb2t19p9sdzyus95mjra	B31 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	eqfw1h4bcjetf9yq9erkgsv0
v47l0vn1q7av7xzvm023vf8i	B32 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	eqfw1h4bcjetf9yq9erkgsv0
ivcgue1m1upoxwcdtrcevljh	B33 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	eqfw1h4bcjetf9yq9erkgsv0
lkc274adaz6umbsvuqq1syy5	B34 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	eqfw1h4bcjetf9yq9erkgsv0
ijalxn1ayah16mw67qji6pz5	B35 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	eqfw1h4bcjetf9yq9erkgsv0
dss7cyp3pjnm5dbo57aygwh8	B41 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	eqfw1h4bcjetf9yq9erkgsv0
uc33e6vwhebhbzzpwtablkxi	B42 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	eqfw1h4bcjetf9yq9erkgsv0
ne3pi0vxzggg2nio6awtpjvq	B43 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	eqfw1h4bcjetf9yq9erkgsv0
flume435b3gsrtidgp7cxy6s	B44 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	eqfw1h4bcjetf9yq9erkgsv0
n7z17ereyfpt2diqkv83d9uk	B45 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	eqfw1h4bcjetf9yq9erkgsv0
gl4n2e4j3qlnzlynwjwgr99e	B51 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	eqfw1h4bcjetf9yq9erkgsv0
xhgqka5dovlbpllxhuj45nxu	B52 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	eqfw1h4bcjetf9yq9erkgsv0
d2ew7lncx2gcp67bg0g5qgmu	B53 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	eqfw1h4bcjetf9yq9erkgsv0
i25x9i3n6bxrqikuos8ala3e	B54 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	eqfw1h4bcjetf9yq9erkgsv0
bszcddfedpw8cy1c8g74fgga	B55 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	eqfw1h4bcjetf9yq9erkgsv0
uchzlh4gh6f1gotmcj8y6t96	B61 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	eqfw1h4bcjetf9yq9erkgsv0
i23id7tyzvcbyz7ab1glnnwe	B62 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	eqfw1h4bcjetf9yq9erkgsv0
wq0sedo1xo3t81h9ikc11keg	B63 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	eqfw1h4bcjetf9yq9erkgsv0
vdxxqqm8pwetcg5z7gs9e3zo	B64 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	eqfw1h4bcjetf9yq9erkgsv0
wq1vfnw6mlscl5zar08ug7ya	B65 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	eqfw1h4bcjetf9yq9erkgsv0
njipboldd4yvow488rvv8f5c	B71 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	eqfw1h4bcjetf9yq9erkgsv0
apdnt4u6d0frz57h43evzt6v	B72 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	eqfw1h4bcjetf9yq9erkgsv0
rbppt3gfcs5fvxj5ozicacnx	B73 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	eqfw1h4bcjetf9yq9erkgsv0
aqql7nexdkdh91uf0r8nc9ai	B74 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	eqfw1h4bcjetf9yq9erkgsv0
dfgrcm5zpzbiq0vcwvfj07kv	B75 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	eqfw1h4bcjetf9yq9erkgsv0
euj2fjbupwbhr5g7o8x0l1of	B81 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	eqfw1h4bcjetf9yq9erkgsv0
jn23hbgkm9cruqh3joaskxwz	B82 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	eqfw1h4bcjetf9yq9erkgsv0
vyys7p4sfdf1kaj5m3w2w7yk	B83 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	eqfw1h4bcjetf9yq9erkgsv0
ndk3e9q4lugp63tf68rueu9c	B84 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	eqfw1h4bcjetf9yq9erkgsv0
p60ux1jcruhvdcv09z0nq738	B85 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	eqfw1h4bcjetf9yq9erkgsv0
tb51r0mrt8hlaofsa5phqc7z	Array C	\N	\N	2024-10-11 13:20:42	2024-10-11 13:23:47	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	hung61oxqo4ho5sigk7mie9c
aqu01xjfxu3aqkti6vp8b1r4	C11 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	tb51r0mrt8hlaofsa5phqc7z
gnkqa2kvgb2g1gke0lrn1h9x	C12 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	tb51r0mrt8hlaofsa5phqc7z
ijotchx1fahqrz7dssrc56oh	C13 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	tb51r0mrt8hlaofsa5phqc7z
vxwb011abqwf19m9f2ldfj76	C14 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	tb51r0mrt8hlaofsa5phqc7z
uj8k16p55nnwazf7ye3haop8	C15 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	tb51r0mrt8hlaofsa5phqc7z
oz4j9fh5srzenbkhpc5hd4qp	C21 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	tb51r0mrt8hlaofsa5phqc7z
q4d8jxxkbekktf6t8x5ydaoy	C22 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	tb51r0mrt8hlaofsa5phqc7z
jhcpjvu70vxugfbpti1nht7v	C23 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	tb51r0mrt8hlaofsa5phqc7z
emjjsr0ihywwbbhvack3rvqs	C24 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	tb51r0mrt8hlaofsa5phqc7z
s5xkjigx3zpmsupw357qk13p	C25 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	tb51r0mrt8hlaofsa5phqc7z
ierj8a4jx2v3csazpiww9i6z	C31 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	tb51r0mrt8hlaofsa5phqc7z
l1ve22p49yhc4703rwbt4eh1	C32 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	tb51r0mrt8hlaofsa5phqc7z
cy77inwb42vn2jwfplppxd30	C33 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	tb51r0mrt8hlaofsa5phqc7z
bx5gg9e94rfmljet2aove3h5	C34 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	tb51r0mrt8hlaofsa5phqc7z
hv70ya8cdh1emfueqc4ygpab	C35 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	tb51r0mrt8hlaofsa5phqc7z
a7bzx767zwruhnszqe072t6s	C41 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	tb51r0mrt8hlaofsa5phqc7z
gll1ubb70qqpflplqabcpnmw	C42 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	tb51r0mrt8hlaofsa5phqc7z
ypvsvr6yngqn0hg5g9exe30r	C43 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	tb51r0mrt8hlaofsa5phqc7z
jqjqtp2lyjxj0dhy09psnicf	C44 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	tb51r0mrt8hlaofsa5phqc7z
maypui4strgctqtbfjtpr5dg	C45 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	tb51r0mrt8hlaofsa5phqc7z
bsi8yzszvxovsqjpqchdtlae	C51 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	tb51r0mrt8hlaofsa5phqc7z
xfci5amgnf1pf5gzievljmmm	C52 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	tb51r0mrt8hlaofsa5phqc7z
bpyh8918aqbb60mxvwvr3ny6	C53 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	tb51r0mrt8hlaofsa5phqc7z
erpqi2gfku00hkeultrgrm2k	C54 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	tb51r0mrt8hlaofsa5phqc7z
lhtusmo21mcpd5wzbacxgdjl	C55 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	tb51r0mrt8hlaofsa5phqc7z
q45fdnuutqs80ezg5qv7qoos	C61 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	tb51r0mrt8hlaofsa5phqc7z
n3238394zedqfqe1f47exj8y	C62 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	tb51r0mrt8hlaofsa5phqc7z
mv3apah4qxw9c0yvr51zy3n9	C63 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	tb51r0mrt8hlaofsa5phqc7z
fupjmm4f9szi625hhbqxymd8	C64 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	tb51r0mrt8hlaofsa5phqc7z
ts1kyrlqagkkczj6w1w2ilya	C65 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	tb51r0mrt8hlaofsa5phqc7z
swi3xacc7fmubm36ttoobn1r	C71 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	tb51r0mrt8hlaofsa5phqc7z
zj091l2ldxio7qxbek6dkr0t	C72 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	tb51r0mrt8hlaofsa5phqc7z
fkj5dpm6vzgxzmnupfj4fqxd	C73 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	tb51r0mrt8hlaofsa5phqc7z
ypb8e09qm5mwl6l2ynfl3xls	C74 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	tb51r0mrt8hlaofsa5phqc7z
nclzgtb7a4g363qautx1w6y5	C75 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	tb51r0mrt8hlaofsa5phqc7z
vbaxv0glslkjv1kl19d6lfyo	C81 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	tb51r0mrt8hlaofsa5phqc7z
pvnyjj3z9gqdsli6vbxcus4w	C82 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	tb51r0mrt8hlaofsa5phqc7z
g9d8xpplrpgdun46frhuysgo	C83 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	tb51r0mrt8hlaofsa5phqc7z
mhekavt8i47tauvvqerwv5om	C84 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	tb51r0mrt8hlaofsa5phqc7z
hbc1qbjl6ghy2fpjczsub1g3	C85 - Mini Bin	\N	\N	2024-10-11 13:20:42	2024-10-11 13:20:42	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	tb51r0mrt8hlaofsa5phqc7z
o5dt5otekw9nkf46uwd42p78	006	\N	\N	2025-07-08 08:41:34	2025-07-08 08:41:34	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	\N
ijy8lpy8npc9sqbq7fdhbdzm	Fabrics workspace	\N	\N	2025-07-08 08:42:32	2025-07-08 08:47:51	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	o5dt5otekw9nkf46uwd42p78
stsxcl9niwom9gol05yvmlp9	Basement 1	\N	\N	2025-07-08 08:58:20	2025-07-08 08:58:20	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	\N
ebzfn2fcwbtbhuzzuwwvt4hb	Basement 2	\N	\N	2025-07-08 08:58:28	2025-07-08 08:58:28	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	\N
nsgdaq2w780ggj5w35vft28c	Fabric machine table	\N	\N	2025-07-08 08:59:01	2025-07-08 08:59:01	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	ebzfn2fcwbtbhuzzuwwvt4hb
ayq5fxho6pinlseeqtsq5qb6	Nikhil's Desk	\N	\N	2025-07-08 09:34:02	2025-07-08 09:34:02	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	o5dt5otekw9nkf46uwd42p78
mryl9dc5e37iathzm57dgszn	Switchboard Wall	\N	\N	2025-07-08 12:23:38	2025-07-08 12:23:38	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	kv4iio684np24bx3habn7pad
i1tetqtuzd9x5s0eeixlchds	Tool Cart	\N	\N	2025-07-08 12:46:35	2025-07-08 12:46:35	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal	\N	\N	\N	\N	o5dt5otekw9nkf46uwd42p78
\.


--
-- Data for Name: LocationNote; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."LocationNote" (id, content, type, "createdAt", "updatedAt", "userId", "locationId") FROM stdin;
\.


--
-- Data for Name: Note; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Note" (id, content, "createdAt", "updatedAt", "userId", "assetId", type) FROM stdin;
pzq3cdi664e2gr4ducq5k5r0	Has to be fixed	2025-07-08 09:06:04	2025-07-08 09:06:04	11438b69-6887-4ad5-926b-75fc18eb32e7	j8pgd4kjyf6a2js341z80gr7	COMMENT
roi8cq3miy4zgrjilqapddo7	2 (inclusive of the total stock number) are in use in the drills	2025-07-10 12:09:08	2025-07-10 12:12:00	11438b69-6887-4ad5-926b-75fc18eb32e7	gsu17ldpx0as9g0g2tln2krw	COMMENT
mhn939ulof7cofatu5pk4y7x	1(inclusive of the total stock number) is in use in the drills	2025-07-10 12:10:35	2025-07-10 12:12:27	11438b69-6887-4ad5-926b-75fc18eb32e7	bty92v7c5e5xefu88ysd2ta0	COMMENT
\.


--
-- Data for Name: Organization; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Organization" (id, name, type, "userId", "createdAt", "updatedAt", "imageId", currency, "enabledSso", "ssoDetailsId", "workspaceDisabled", "baseUserCanSeeBookings", "baseUserCanSeeCustody", "selfServiceCanSeeBookings", "selfServiceCanSeeCustody", "barcodesEnabled", "barcodesEnabledAt", "hasSequentialIdsMigrated", "qrIdDisplayPreference", "showShelfBranding", "auditsEnabled", "auditsEnabledAt", "usedAuditTrial", "customEmailFooter", "usedBarcodeTrial") FROM stdin;
org-admin-personal	Admin's Workspace	PERSONAL	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-02 13:59:01.865	2026-04-02 13:59:45.372	\N	USD	f	\N	f	f	f	f	f	f	\N	t	QR_ID	t	f	\N	f	\N	f
\.


--
-- Data for Name: PartialBookingCheckin; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."PartialBookingCheckin" (id, "assetIds", "checkinCount", "checkinTimestamp", "bookingId", "checkedInById", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: PrintBatch; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."PrintBatch" (id, name, "createdAt", "updatedAt", printed) FROM stdin;
cmnisz5r6003ip7m03zl9xyek	-1775212275516	2026-04-03 11:11:04.674	2026-04-03 11:11:04.674	f
\.


--
-- Data for Name: Qr; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Qr" (id, version, "errorCorrection", "userId", "createdAt", "updatedAt", "assetId", "organizationId", "batchId", "kitId") FROM stdin;
q8i3kd964s	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 09:52:30.917	2026-04-03 09:52:30.917	g447lqkrqg9q7paru3devxf5	org-admin-personal	\N	\N
jr35r44yn9ez4ovrb2tjf3n0	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	s4dl15kx81y110w4eysk7r9i	org-admin-personal	\N	\N
uuwe4la2qx7qx0mbiwo57u8c	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	v9a6qjap5r23ej5uxnag61jc	org-admin-personal	\N	\N
ec1zo9c0j1b79xtpg3t60c6g	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	uosg3nxzt37vf2ijmrrzhrwb	org-admin-personal	\N	\N
s972s1lzoojphtyvstiarqn4	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	ot9tw46km4i3cznp7jqrqs55	org-admin-personal	\N	\N
yuqqftiy26hw6w6j9ei0ow4l	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	wsfa4biet6h3e2s1ecmuul0f	org-admin-personal	\N	\N
n0cfhch76yfcy1wgdrkryk26	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	t10gf5t795c947ur1kmjibpg	org-admin-personal	\N	\N
bdluvfmvim8i3b27ydrdfngi	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	jy4pl2f23ntk2b04w5d0fwni	org-admin-personal	\N	\N
ke3iz2a8ugga4a6tieswz8ry	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	b68rdrha9amjkqmtyewpyubv	org-admin-personal	\N	\N
lhtnvi7g5obxnlewnf3mtfdi	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	thobxz0g2vtgyw4rbo95xp9o	org-admin-personal	\N	\N
esh5867r6gxufu5ypqtmg1gd	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	el5gfe00j7qafpl91anzpjyo	org-admin-personal	\N	\N
w4zzxoj51beuqxls5oq91cil	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	n6v2twwirvvm284doojmmfkl	org-admin-personal	\N	\N
ig33gkanemcrs566ujkqs5ep	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	qbeju8cq35ik262nowamp5yw	org-admin-personal	\N	\N
bxlcu79so0o7qy66788skg03	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	thx0okep4a329u4w6v7dksfs	org-admin-personal	\N	\N
uyvlgdrcnz9g4jr5o3knxmek	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	rggdo9fltmav3oscylfivi2v	org-admin-personal	\N	\N
ok73pxq9mzme8ka1psx1kwwj	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	ncmecez8i9r3ecaybobzj9q4	org-admin-personal	\N	\N
j87adl0ystv9qefcglwifbzi	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	wbfgq2z82b0c16cgr6gwlcp8	org-admin-personal	\N	\N
hs0efowidtmm23e10wsyn3mb	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	k13zsoglgs4idacpm6b8ipk8	org-admin-personal	\N	\N
jw2lg988mj6fqf3zwp9cym6d	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	hl3ruvdqxrqtokw355eq4lwb	org-admin-personal	\N	\N
r7l52hv3fqsfpvrgeqeefnlf	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	wsgncbo8kdqdypmrfl8hq9b0	org-admin-personal	\N	\N
ng38vqp8zoq0kocgoaty2t7l	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	qj9npdcgly8qw9hzgg8xr6ye	org-admin-personal	\N	\N
ttstiqib7j00x9e4vlvhjbxi	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	rq0fku6jksvib3r1wovwx2j6	org-admin-personal	\N	\N
tciw2bda1602ohj6fxrxsoko	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	t4iijlrss2ecgkzwxyqge898	org-admin-personal	\N	\N
ovaca98ep4093ryg1qffxr18	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	j9zjgtjio5vv1nf57n6m0l31	org-admin-personal	\N	\N
shima6nz5d6sdiwuqu83mn12	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	llk70tfoare6y06p5aocbfua	org-admin-personal	\N	\N
luhuv5s725epi5k98mrq1s7p	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	epv71bariq68080fe029rjgk	org-admin-personal	\N	\N
p2tk2jzszvny08a7fcsjinfi	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	dwwkzgcwqji0zvnd3csycp52	org-admin-personal	\N	\N
mdy2woc9tp9vt14e550an9mt	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	eybhlduihh0rijyue21yqbdc	org-admin-personal	\N	\N
wk4e0mr9leazm0557hxsn8id	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	te7ffnlj6ufgd5kxkd8o5hip	org-admin-personal	\N	\N
sdyoowx4jn4kimf4b8vk0u41	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	pf2tu0vzoilkmnifyki0drx6	org-admin-personal	\N	\N
bnktafgbkjtutl1grhxgcer1	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	jhzemede78o9z5km8uecgbf6	org-admin-personal	\N	\N
g7y3xwmvw7kc1vucnb8jsy0y	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	ky85v7c6ycdsotis8trv527u	org-admin-personal	\N	\N
y3q249l9snd9nto1bdk4jo3z	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	t53hcf9eq7ijwk4wenmko9bb	org-admin-personal	\N	\N
cfgzaki3umsq60nk7qbhxhs1	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	wy3q3njeypz1p7ieeywto891	org-admin-personal	\N	\N
j91xccjjjncteq0jtqexgjh8	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	h8k7oc2okptdqy9b7j0qdigg	org-admin-personal	\N	\N
u5rzwkms09nt9pc4ggj1az7t	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	gsu17ldpx0as9g0g2tln2krw	org-admin-personal	\N	\N
vjgfs6kpf4qtihs8qhyr5m29	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	ufgsmnbourw60ahq59sx7v0k	org-admin-personal	\N	\N
nag41u8fbceofv0tagse967u	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	xd52q140k3r1e8rqkt71isyp	org-admin-personal	\N	\N
oy4at370oukmbhldk0xlkesj	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	nq0gwny01gztc30qkvzlrrds	org-admin-personal	\N	\N
efqevxi1zd6iiffk6m66wceb	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	iqnhqt50ckmeoyz6sagqmj3k	org-admin-personal	\N	\N
icux0gj6r7ig9g6prz17dfoi	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	nz7jff46pa0h5kj886858nh6	org-admin-personal	\N	\N
qdehh6r535qhvdi9bkah3opw	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	acw7oaymwt94wm9cpn1baz9g	org-admin-personal	\N	\N
dmz9bsku9hx501vx1pjavv4h	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	el887q5b6r9fwgrdvg28sv07	org-admin-personal	\N	\N
zpqvz4m0ui4jnoxaj60ym51e	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	abrq4bml4rxdh1z40fl75hau	org-admin-personal	\N	\N
efbydyhm0j4418y8koz9fzi6	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	q3wgjnz3bm9znxnpl3fabqkm	org-admin-personal	\N	\N
y0jl177vy00gcd9qz1n7k1c2	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	witiu7vbkkuhmnyxfcgpa4r8	org-admin-personal	\N	\N
rlv7e98ogzbnancn7ay4m4o5	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	f546qi7sannzlysc1m8brhnr	org-admin-personal	\N	\N
edw92jzzh4pjqxr0d0449y1g	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	l8nfmfwv8uviausw755gzje1	org-admin-personal	\N	\N
yhpe6vc3lwd2byuuvs4xfcts	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	ua39rbbxjs07a9q53h3wiss8	org-admin-personal	\N	\N
apvlenia93938ghhn82u7mhe	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	timy0ooiui9bv0g3t0l77kvi	org-admin-personal	\N	\N
jgo5zzck55znft5osxjl1px7	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	v3hlcfn2lh8vm8gxlmrz4saw	org-admin-personal	\N	\N
m6ayslkj1l3aetokr37yzl7r	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	ttwkroqhdq2yim2seehggc0b	org-admin-personal	\N	\N
ldk9rsvcepqusfzj9qykpqek	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	rmnp10voacnnho6laudf7zfx	org-admin-personal	\N	\N
clyzksitae1aftlcfe6tf8ah	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	bw14hkayqjer3b0djya6xxhs	org-admin-personal	\N	\N
cks070tx0bixduwsbwho7po7	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	uzrsvt0g36ksdwrbeaz8zkho	org-admin-personal	\N	\N
bkasunsrvjbk89kgsw9v9iia	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	n8b94zl7cmb4faavli96k3tt	org-admin-personal	\N	\N
p6r146jqthao95owfzyx9sm1	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	zpun16bic48z19jrst7pqtxk	org-admin-personal	\N	\N
z58gscelnbs72iiqbzsz4ram	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	cmjsflo1wcsrrytutvir7fx9	org-admin-personal	\N	\N
c4ne0upvxkpn59ug6czasngr	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	lghf4z0rq971ur37ty5f4pwq	org-admin-personal	\N	\N
tpf85d9q7nge853s8buhbxui	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	cnvgt05mov170l9lkn7fu6g2	org-admin-personal	\N	\N
mk5qab2kmg61s130kt1m0xgt	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	bus1s19avirwah9kixg5zbxk	org-admin-personal	\N	\N
gaggzkulleeusjxibw34vgzc	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	xpqztk0eneqatduhb96k3uyv	org-admin-personal	\N	\N
t2f6if2im3n26p2mwxzjzxsv	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	j8pgd4kjyf6a2js341z80gr7	org-admin-personal	\N	\N
jhdyd4ess2b6j4hf55fqq9il	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	mtki1wf29p8mxtmk003yem4j	org-admin-personal	\N	\N
mjiwd8bbo9n53hr4zyy1ujwi	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	bty92v7c5e5xefu88ysd2ta0	org-admin-personal	\N	\N
lp1yj58i64bf87zojqiiuj3o	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 10:17:25.565	2026-04-03 10:17:25.565	hi28duluomke36y7vkdcnupc	org-admin-personal	\N	\N
ezyi4fwdvh	0	L	\N	2026-04-03 11:11:04.679	2026-04-03 11:11:04.679	\N	\N	cmnisz5r6003ip7m03zl9xyek	\N
wliyc49vwo	0	L	\N	2026-04-03 11:11:04.679	2026-04-03 11:11:04.679	\N	\N	cmnisz5r6003ip7m03zl9xyek	\N
ss1x185fp0	0	L	\N	2026-04-03 11:11:04.679	2026-04-03 11:11:04.679	\N	\N	cmnisz5r6003ip7m03zl9xyek	\N
wpbgrq2c2n	0	L	\N	2026-04-03 11:11:04.679	2026-04-03 11:11:04.679	\N	\N	cmnisz5r6003ip7m03zl9xyek	\N
g7200v9uh3	0	L	\N	2026-04-03 11:11:04.679	2026-04-03 11:11:04.679	\N	\N	cmnisz5r6003ip7m03zl9xyek	\N
uu0dezxj1y	0	L	\N	2026-04-03 11:11:04.679	2026-04-03 11:11:04.679	\N	\N	cmnisz5r6003ip7m03zl9xyek	\N
sp9550b6p6	0	L	\N	2026-04-03 11:11:04.679	2026-04-03 11:11:04.679	\N	\N	cmnisz5r6003ip7m03zl9xyek	\N
nrlssilzt1	0	L	\N	2026-04-03 11:11:04.679	2026-04-03 11:11:04.679	\N	\N	cmnisz5r6003ip7m03zl9xyek	\N
s44spcox9u	0	L	\N	2026-04-03 11:11:04.679	2026-04-03 11:11:04.679	\N	\N	cmnisz5r6003ip7m03zl9xyek	\N
pe5focd1g8	0	L	\N	2026-04-03 11:11:04.679	2026-04-03 11:11:04.679	\N	\N	cmnisz5r6003ip7m03zl9xyek	\N
ctzugjc2zs	0	L	\N	2026-04-03 11:11:04.679	2026-04-03 11:11:04.679	\N	\N	cmnisz5r6003ip7m03zl9xyek	\N
hyka05m5nw	0	L	\N	2026-04-03 11:11:04.679	2026-04-03 11:11:04.679	\N	\N	cmnisz5r6003ip7m03zl9xyek	\N
q4va5nwczd	0	L	\N	2026-04-03 11:11:04.679	2026-04-03 11:11:04.679	\N	\N	cmnisz5r6003ip7m03zl9xyek	\N
jjc4xw9k0x	0	L	\N	2026-04-03 11:11:04.679	2026-04-03 11:11:04.679	\N	\N	cmnisz5r6003ip7m03zl9xyek	\N
pzc196ciwa	0	L	\N	2026-04-03 11:11:04.679	2026-04-03 11:11:04.679	\N	\N	cmnisz5r6003ip7m03zl9xyek	\N
gf9boclbfk	0	L	\N	2026-04-03 11:11:04.679	2026-04-03 11:11:04.679	\N	\N	cmnisz5r6003ip7m03zl9xyek	\N
arho9n0vla	0	L	\N	2026-04-03 11:11:04.679	2026-04-03 11:11:04.679	\N	\N	cmnisz5r6003ip7m03zl9xyek	\N
ehjnr9c0si	0	L	\N	2026-04-03 11:11:04.679	2026-04-03 11:11:04.679	\N	\N	cmnisz5r6003ip7m03zl9xyek	\N
sq7pots80g	0	L	\N	2026-04-03 11:11:04.679	2026-04-03 11:11:04.679	\N	\N	cmnisz5r6003ip7m03zl9xyek	\N
l8mea8ifwc	0	L	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 11:11:04.679	2026-04-04 10:21:49.159	\N	org-admin-personal	cmnisz5r6003ip7m03zl9xyek	\N
\.


--
-- Data for Name: ReportFound; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."ReportFound" (id, content, "createdAt", "updatedAt", email, "assetId", "kitId") FROM stdin;
\.


--
-- Data for Name: Role; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Role" (id, name, "createdAt", "updatedAt") FROM stdin;
a41e29fc-6a33-47c9-a0a8-27c742ff2a99	USER	2026-04-02 13:49:19.47	2026-04-02 13:49:19.47
dd4c6e27-6276-4d1b-93a7-fb8b8fc3a07f	ADMIN	2026-04-02 13:49:19.47	2026-04-02 13:49:19.47
\.


--
-- Data for Name: RoleChangeLog; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."RoleChangeLog" (id, "previousRole", "newRole", "createdAt", "userId", "changedById", "organizationId") FROM stdin;
\.


--
-- Data for Name: Scan; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Scan" (id, latitude, longitude, "userAgent", "userId", "qrId", "createdAt", "updatedAt", "rawQrId", "manuallyGenerated") FROM stdin;
cmnk6mowm0004p7uhrbodlhoy	\N	\N	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	11438b69-6887-4ad5-926b-75fc18eb32e7	l8mea8ifwc	2026-04-04 10:21:03.766	2026-04-04 10:21:03.775	l8mea8ifwc	f
cmnk6nhsv000fp7uhjpiarqvp	28.94902188633501	77.09831205528931	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	11438b69-6887-4ad5-926b-75fc18eb32e7	l8mea8ifwc	2026-04-04 10:21:41.215	2026-04-04 10:21:41.345	l8mea8ifwc	f
cmnk6pzzg000kp7uhjtvok7az	28.948996927393146	77.09836259968691	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	11438b69-6887-4ad5-926b-75fc18eb32e7	l8mea8ifwc	2026-04-04 10:23:38.093	2026-04-04 10:23:48.591	l8mea8ifwc	f
cmnk6ta3l000rp7uht75wxoqh	28.948996927372033	77.09836259973699	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	11438b69-6887-4ad5-926b-75fc18eb32e7	l8mea8ifwc	2026-04-04 10:26:11.17	2026-04-04 10:26:11.437	l8mea8ifwc	f
\.


--
-- Data for Name: SsoDetails; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."SsoDetails" (id, domain, "createdAt", "updatedAt", "adminGroupId", "selfServiceGroupId", "baseUserGroupId") FROM stdin;
\.


--
-- Data for Name: Tag; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Tag" (id, name, description, "userId", "createdAt", "updatedAt", "organizationId", "useFor", color) FROM stdin;
le2hkub8ay3xj82x1mzq3szl	mfr:eSun	\N	11438b69-6887-4ad5-926b-75fc18eb32e7	2024-10-09 11:43:04	2024-10-09 11:43:04	org-admin-personal	{ASSET}	\N
lkk0dnakwd3jve5ybexp7xbj	mfr:Usha	\N	11438b69-6887-4ad5-926b-75fc18eb32e7	2025-06-10 08:20:28	2025-06-10 08:20:28	org-admin-personal	{ASSET}	\N
n8guvkrg73yvggaah9mbigy7	mfr:Crown	\N	11438b69-6887-4ad5-926b-75fc18eb32e7	2025-07-07 12:34:25	2025-07-07 12:34:25	org-admin-personal	{ASSET}	\N
wrwm1mmu2c901v48ihdqanua	mfr:Brother	\N	11438b69-6887-4ad5-926b-75fc18eb32e7	2025-07-07 12:38:33	2025-07-07 12:38:33	org-admin-personal	{ASSET}	\N
p8tzq8cyjg1ycvjml2z7i4uz	mfr:Bernette	\N	11438b69-6887-4ad5-926b-75fc18eb32e7	2025-07-07 12:44:19	2025-07-07 12:44:19	org-admin-personal	{ASSET}	\N
goh5g69znprkchoi8c6inlai	mfr:Voron	\N	11438b69-6887-4ad5-926b-75fc18eb32e7	2025-07-08 08:38:14	2025-07-08 08:38:14	org-admin-personal	{ASSET}	\N
xye9bqucavs1hwxnd4lbnqs9	mfr:Ender	\N	11438b69-6887-4ad5-926b-75fc18eb32e7	2025-07-08 09:02:08	2025-07-08 09:02:08	org-admin-personal	{ASSET}	\N
gcie7x0dr5386cjg4aqoxiac	mfr:Stanley	\N	11438b69-6887-4ad5-926b-75fc18eb32e7	2025-07-08 09:53:56	2025-07-08 09:53:56	org-admin-personal	{ASSET}	\N
vdj7eu0sxql4qrdls983m9ik	mfr:Cricut	\N	11438b69-6887-4ad5-926b-75fc18eb32e7	2025-07-08 10:02:47	2025-07-08 10:02:47	org-admin-personal	{ASSET}	\N
pjn1b8tq3isji5kjwtm2mlf5	mfr:Racer	\N	11438b69-6887-4ad5-926b-75fc18eb32e7	2025-07-08 10:05:31	2025-07-08 10:05:31	org-admin-personal	{ASSET}	\N
jz26gqftpogbgzyk2o0lds9n	mfr:Scotch	\N	11438b69-6887-4ad5-926b-75fc18eb32e7	2025-07-08 10:41:46	2025-07-08 10:41:46	org-admin-personal	{ASSET}	\N
bhu643eru3fex96q1cxj2eav	mfr:SDI	\N	11438b69-6887-4ad5-926b-75fc18eb32e7	2025-07-08 12:07:37	2025-07-08 12:07:37	org-admin-personal	{ASSET}	\N
iypoj2iwlhphb5tel736exms	mfr:Fluke	\N	11438b69-6887-4ad5-926b-75fc18eb32e7	2025-07-08 12:15:45	2025-07-08 12:15:45	org-admin-personal	{ASSET}	\N
ui1q7xwgcb6iapl6wb3usy1z	mfr:Irwin	\N	11438b69-6887-4ad5-926b-75fc18eb32e7	2025-07-08 12:21:31	2025-07-08 12:21:31	org-admin-personal	{ASSET}	\N
vrji8ud3f8fhrta89daeszpd	mfr:Black and Decker	\N	11438b69-6887-4ad5-926b-75fc18eb32e7	2025-07-08 12:33:40	2025-07-08 12:33:40	org-admin-personal	{ASSET}	\N
ipcu509fg3ebn2ud1kd2nf54	mfr:Jainson	\N	11438b69-6887-4ad5-926b-75fc18eb32e7	2025-07-08 12:42:40	2025-07-08 12:42:40	org-admin-personal	{ASSET}	\N
lwa6nji55vke2vskubtn7no0	mfr:R'Deer	\N	11438b69-6887-4ad5-926b-75fc18eb32e7	2025-07-08 12:45:07	2025-07-08 12:45:07	org-admin-personal	{ASSET}	\N
biebffwap53ko5rs1rtf1yzl	mfr:ezLife	\N	11438b69-6887-4ad5-926b-75fc18eb32e7	2025-07-10 09:07:40	2025-07-10 09:07:40	org-admin-personal	{ASSET}	\N
h3tclsr9ourgkoafmxaz65aq	mfr:Harden	\N	11438b69-6887-4ad5-926b-75fc18eb32e7	2025-07-10 09:12:38	2025-07-10 09:12:38	org-admin-personal	{ASSET}	\N
ux5da0inzw1ytgx46ol0t7sb	mfr:NA	\N	11438b69-6887-4ad5-926b-75fc18eb32e7	2025-07-10 09:14:53	2025-07-10 09:14:53	org-admin-personal	{ASSET}	\N
r9dwy4y5fwdn7pl7uct5qdyf	mfr:DeWALT	\N	11438b69-6887-4ad5-926b-75fc18eb32e7	2025-07-10 09:21:32	2025-07-10 09:21:32	org-admin-personal	{ASSET}	\N
hkkdu5zzx7uhcamb7qkkhq1x	mfr:Yuzuki	\N	11438b69-6887-4ad5-926b-75fc18eb32e7	2025-07-10 09:26:23	2025-07-10 09:26:23	org-admin-personal	{ASSET}	\N
a5m375b1d192i447ea06wcvs	mfr:Bosch	\N	11438b69-6887-4ad5-926b-75fc18eb32e7	2025-07-10 09:28:53	2025-07-10 09:28:53	org-admin-personal	{ASSET}	\N
bix7xqj1eg1gqmlrpwrui55y	mfr:Mitutoyo	\N	11438b69-6887-4ad5-926b-75fc18eb32e7	2025-07-10 11:38:13	2025-07-10 11:38:13	org-admin-personal	{ASSET}	\N
ld6ouepscnte5s4zsepnwfdd	mfr:Themisto	\N	11438b69-6887-4ad5-926b-75fc18eb32e7	2025-07-10 11:39:24	2025-07-10 11:39:24	org-admin-personal	{ASSET}	\N
jvymm17qhfbo8s3adgp111mu	mfr:Zhari	\N	11438b69-6887-4ad5-926b-75fc18eb32e7	2025-07-10 11:40:42	2025-07-10 11:40:42	org-admin-personal	{ASSET}	\N
enihekwgh5s6xs5fjknjz4yx	mfr:ECO	\N	11438b69-6887-4ad5-926b-75fc18eb32e7	2025-07-10 11:54:35	2025-07-10 11:54:35	org-admin-personal	{ASSET}	\N
r8hgr8uj67zojjfoh3g3hmu2	mfr:INC-CO	\N	11438b69-6887-4ad5-926b-75fc18eb32e7	2025-07-10 12:21:07	2025-07-10 12:21:07	org-admin-personal	{ASSET}	\N
zzf2hf4xi7s1eyzikr2z5a2p	mfr:Niyo	\N	11438b69-6887-4ad5-926b-75fc18eb32e7	2025-07-10 12:22:53	2025-07-10 12:22:53	org-admin-personal	{ASSET}	\N
gl64dyfuwyspwi4b0cf95wf2	mfr:Optoma	\N	11438b69-6887-4ad5-926b-75fc18eb32e7	2025-07-21 12:16:01	2025-07-21 12:16:01	org-admin-personal	{ASSET}	\N
bwhk21cswknkvl1o0mq4l5r3	mfr:Arduino	\N	11438b69-6887-4ad5-926b-75fc18eb32e7	2025-07-21 14:15:34	2025-07-21 14:15:34	org-admin-personal	{ASSET}	\N
ri0tdwqqjy93vekif75z1ap3	Coloured PLA	\N	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 09:49:13.804	2026-04-03 09:49:13.804	org-admin-personal	{ASSET}	\N
tttmpl0y3z24ijyrzlsh46yf	Tools	\N	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 09:49:13.827	2026-04-03 09:49:13.827	org-admin-personal	{ASSET}	\N
sionsm9ydmv3g8ss8qo6uxj6	Wiring	\N	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 09:49:13.828	2026-04-03 09:49:13.828	org-admin-personal	{ASSET}	\N
o6twpcwcs78qopy86aa6jvad	Fabric	\N	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 09:49:13.835	2026-04-03 09:49:13.835	org-admin-personal	{ASSET}	\N
s59551p0cmva1rcgv3t7ydlf	Scissors	\N	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 09:49:13.836	2026-04-03 09:49:13.836	org-admin-personal	{ASSET}	\N
pb9c5lgbl332vejl4wjsvd62	pliers	\N	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 09:49:13.848	2026-04-03 09:49:13.848	org-admin-personal	{ASSET}	\N
cznzis2ax9avay3ofxtq571i	clamps	\N	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 09:49:13.853	2026-04-03 09:49:13.853	org-admin-personal	{ASSET}	\N
nxra2u3vorpn8qpxx5inlckb	IR	\N	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 09:49:13.857	2026-04-03 09:49:13.857	org-admin-personal	{ASSET}	\N
ryxa5m61ffgqkuwj0xzl1re4	Thermometer	\N	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 09:49:13.858	2026-04-03 09:49:13.858	org-admin-personal	{ASSET}	\N
b592mp0h9yya3ar8rdepw6h9	files	\N	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 09:49:13.867	2026-04-03 09:49:13.867	org-admin-personal	{ASSET}	\N
jxcfrebzbccs3e7l4cc7iv5w	climpers	\N	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 09:49:13.87	2026-04-03 09:49:13.87	org-admin-personal	{ASSET}	\N
liod0krxhy05ulaqgdpadcx7	shears	\N	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 09:49:13.873	2026-04-03 09:49:13.873	org-admin-personal	{ASSET}	\N
p996aoi253xcuqgbqovt6nl9	wire cutter	\N	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 09:49:13.876	2026-04-03 09:49:13.876	org-admin-personal	{ASSET}	\N
b3k17gs0kdk2arqo3ut7nax0	crimping	\N	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 09:49:13.879	2026-04-03 09:49:13.879	org-admin-personal	{ASSET}	\N
xqvjormsr2w9lb1owcujqmqy	wrench	\N	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 09:49:13.883	2026-04-03 09:49:13.883	org-admin-personal	{ASSET}	\N
ij34p4q8cpbuelyo3h3sow2k	heavyduty	\N	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 09:49:13.884	2026-04-03 09:49:13.884	org-admin-personal	{ASSET}	\N
ihvl3kktqhqz3a1mn7n6epdc	variable	\N	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 09:49:13.885	2026-04-03 09:49:13.885	org-admin-personal	{ASSET}	\N
qdod6m650k1akll85lzw78fa	hammer	\N	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 09:49:13.887	2026-04-03 09:49:13.887	org-admin-personal	{ASSET}	\N
pf266go8z1tweorgt5zdbgx3	steel	\N	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 09:49:13.888	2026-04-03 09:49:13.888	org-admin-personal	{ASSET}	\N
zz62s9sf4qggl0o5klu6hzdh	Impact driver	\N	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 09:49:13.89	2026-04-03 09:49:13.89	org-admin-personal	{ASSET}	\N
ec7ezra84bob334wu93mnkn2	drills	\N	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 09:49:13.893	2026-04-03 09:49:13.893	org-admin-personal	{ASSET}	\N
f19r9y58j8b33k5ck9ak7skx	screwdriver	\N	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 09:49:13.896	2026-04-03 09:49:13.896	org-admin-personal	{ASSET}	\N
tkqebf5ob144b8jmbdkpudhw	set	\N	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 09:49:13.897	2026-04-03 09:49:13.897	org-admin-personal	{ASSET}	\N
ekpsakvi0azcehuo8vvpyfqk	measuring	\N	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 09:49:13.898	2026-04-03 09:49:13.898	org-admin-personal	{ASSET}	\N
r36au07cpt0xzjg0dlslzk1j	Projector	\N	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-03 09:49:13.921	2026-04-03 09:49:13.921	org-admin-personal	{ASSET}	\N
\.


--
-- Data for Name: TeamMember; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."TeamMember" (id, name, "createdAt", "updatedAt", "userId", "deletedAt", "organizationId") FROM stdin;
tm-admin-personal	Admin User	2026-04-02 13:59:01.866	2026-04-02 13:59:01.866	11438b69-6887-4ad5-926b-75fc18eb32e7	\N	org-admin-personal
\.


--
-- Data for Name: TeamMemberNote; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."TeamMemberNote" (id, content, type, "createdAt", "updatedAt", "userId", "teamMemberId", "organizationId") FROM stdin;
\.


--
-- Data for Name: Tier; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Tier" (id, name, "createdAt", "updatedAt", "tierLimitId") FROM stdin;
free	Free	2026-04-02 13:49:19.384	2026-04-02 13:49:19.384	free
tier_1	Plus	2026-04-02 13:49:19.384	2026-04-02 13:49:19.384	tier_1
tier_2	Team	2026-04-02 13:49:19.384	2026-04-02 13:49:19.384	tier_2
custom	Custom	2026-04-02 13:49:19.505	2026-04-02 13:49:19.505	\N
\.


--
-- Data for Name: TierLimit; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."TierLimit" (id, "canImportAssets", "canExportAssets", "createdAt", "updatedAt", "maxCustomFields", "maxOrganizations", "canImportNRM", "canHideShelfBranding") FROM stdin;
free	f	f	2026-04-02 13:49:19.391	2026-04-02 13:49:19.391	3	1	f	f
tier_1	t	t	2026-04-02 13:49:19.391	2026-04-02 13:49:19.391	100	1	t	t
tier_2	t	t	2026-04-02 13:49:19.391	2026-04-02 13:49:19.391	100	2	t	t
\.


--
-- Data for Name: Update; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Update" (id, title, content, url, "publishDate", status, "targetRoles", "clickCount", "viewCount", "createdById", "createdAt", "updatedAt", "imageUrl") FROM stdin;
\.


--
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."User" (id, email, "createdAt", "updatedAt", "profilePicture", "firstName", "lastName", username, onboarded, "customerId", "tierId", "usedFreeTrial", sso, "createdWithInvite", "deletedAt", "referralSource", "skipSubscriptionCheck", "hasUnpaidInvoice", "warnForNoPaymentMethod", "lastSelectedOrganizationId", "displayName") FROM stdin;
11438b69-6887-4ad5-926b-75fc18eb32e7	admin@shelf.local	2026-04-02 13:59:01.862	2026-04-02 13:59:01.862	\N	Admin	User	admin	t	\N	free	f	f	f	\N	\N	f	f	f	\N	\N
\.


--
-- Data for Name: UserBusinessIntel; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."UserBusinessIntel" (id, "howDidYouHearAboutUs", "jobTitle", "teamSize", "companyName", "primaryUseCase", "currentSolution", timeline, "userId", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: UserContact; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."UserContact" (id, phone, street, city, "stateProvince", "zipPostalCode", "countryRegion", "userId", "createdAt", "updatedAt") FROM stdin;
a6f22147-02d3-4b48-b479-3571f95c1132	\N	\N	\N	\N	\N	\N	11438b69-6887-4ad5-926b-75fc18eb32e7	2026-04-02 13:59:01.862	2026-04-02 13:59:01.862
\.


--
-- Data for Name: UserOrganization; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."UserOrganization" (id, "userId", "organizationId", roles, "createdAt", "updatedAt") FROM stdin;
uo-admin-personal	11438b69-6887-4ad5-926b-75fc18eb32e7	org-admin-personal	{OWNER}	2026-04-02 13:59:01.866	2026-04-02 13:59:01.866
\.


--
-- Data for Name: UserUpdateRead; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."UserUpdateRead" (id, "userId", "updateId", "readAt") FROM stdin;
\.


--
-- Data for Name: WorkingHours; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."WorkingHours" (id, enabled, "weeklySchedule", "organizationId", "createdAt", "updatedAt") FROM stdin;
cmnhjk7pg0005p72n6tr5qgd2	f	{"0": {"isOpen": false}, "1": {"isOpen": true, "openTime": "09:00", "closeTime": "17:00"}, "2": {"isOpen": true, "openTime": "09:00", "closeTime": "17:00"}, "3": {"isOpen": true, "openTime": "09:00", "closeTime": "17:00"}, "4": {"isOpen": true, "openTime": "09:00", "closeTime": "17:00"}, "5": {"isOpen": true, "openTime": "09:00", "closeTime": "17:00"}, "6": {"isOpen": false}}	org-admin-personal	2026-04-02 13:59:44.644	2026-04-02 13:59:44.644
\.


--
-- Data for Name: WorkingHoursOverride; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."WorkingHoursOverride" (id, date, "isOpen", "openTime", "closeTime", reason, "workingHoursId", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: _AssetReminderToTeamMember; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."_AssetReminderToTeamMember" ("A", "B") FROM stdin;
\.


--
-- Data for Name: _AssetToBooking; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."_AssetToBooking" ("A", "B") FROM stdin;
\.


--
-- Data for Name: _AssetToTag; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."_AssetToTag" ("A", "B") FROM stdin;
el887q5b6r9fwgrdvg28sv07	le2hkub8ay3xj82x1mzq3szl
el887q5b6r9fwgrdvg28sv07	ri0tdwqqjy93vekif75z1ap3
pf2tu0vzoilkmnifyki0drx6	lkk0dnakwd3jve5ybexp7xbj
nz7jff46pa0h5kj886858nh6	n8guvkrg73yvggaah9mbigy7
witiu7vbkkuhmnyxfcgpa4r8	wrwm1mmu2c901v48ihdqanua
nq0gwny01gztc30qkvzlrrds	p8tzq8cyjg1ycvjml2z7i4uz
wbfgq2z82b0c16cgr6gwlcp8	le2hkub8ay3xj82x1mzq3szl
thobxz0g2vtgyw4rbo95xp9o	le2hkub8ay3xj82x1mzq3szl
ttwkroqhdq2yim2seehggc0b	le2hkub8ay3xj82x1mzq3szl
ufgsmnbourw60ahq59sx7v0k	le2hkub8ay3xj82x1mzq3szl
rggdo9fltmav3oscylfivi2v	le2hkub8ay3xj82x1mzq3szl
wy3q3njeypz1p7ieeywto891	goh5g69znprkchoi8c6inlai
q3wgjnz3bm9znxnpl3fabqkm	goh5g69znprkchoi8c6inlai
j8pgd4kjyf6a2js341z80gr7	xye9bqucavs1hwxnd4lbnqs9
v9a6qjap5r23ej5uxnag61jc	le2hkub8ay3xj82x1mzq3szl
wsgncbo8kdqdypmrfl8hq9b0	gcie7x0dr5386cjg4aqoxiac
wsgncbo8kdqdypmrfl8hq9b0	tttmpl0y3z24ijyrzlsh46yf
wsgncbo8kdqdypmrfl8hq9b0	sionsm9ydmv3g8ss8qo6uxj6
l8nfmfwv8uviausw755gzje1	gcie7x0dr5386cjg4aqoxiac
l8nfmfwv8uviausw755gzje1	tttmpl0y3z24ijyrzlsh46yf
l8nfmfwv8uviausw755gzje1	sionsm9ydmv3g8ss8qo6uxj6
n6v2twwirvvm284doojmmfkl	vdj7eu0sxql4qrdls983m9ik
zpun16bic48z19jrst7pqtxk	pjn1b8tq3isji5kjwtm2mlf5
zpun16bic48z19jrst7pqtxk	o6twpcwcs78qopy86aa6jvad
zpun16bic48z19jrst7pqtxk	s59551p0cmva1rcgv3t7ydlf
jy4pl2f23ntk2b04w5d0fwni	jz26gqftpogbgzyk2o0lds9n
jy4pl2f23ntk2b04w5d0fwni	s59551p0cmva1rcgv3t7ydlf
jy4pl2f23ntk2b04w5d0fwni	tttmpl0y3z24ijyrzlsh46yf
rmnp10voacnnho6laudf7zfx	gcie7x0dr5386cjg4aqoxiac
t10gf5t795c947ur1kmjibpg	gcie7x0dr5386cjg4aqoxiac
timy0ooiui9bv0g3t0l77kvi	bhu643eru3fex96q1cxj2eav
v3hlcfn2lh8vm8gxlmrz4saw	gcie7x0dr5386cjg4aqoxiac
v3hlcfn2lh8vm8gxlmrz4saw	tttmpl0y3z24ijyrzlsh46yf
v3hlcfn2lh8vm8gxlmrz4saw	pb9c5lgbl332vejl4wjsvd62
mtki1wf29p8mxtmk003yem4j	gcie7x0dr5386cjg4aqoxiac
mtki1wf29p8mxtmk003yem4j	tttmpl0y3z24ijyrzlsh46yf
mtki1wf29p8mxtmk003yem4j	cznzis2ax9avay3ofxtq571i
f546qi7sannzlysc1m8brhnr	iypoj2iwlhphb5tel736exms
f546qi7sannzlysc1m8brhnr	nxra2u3vorpn8qpxx5inlckb
f546qi7sannzlysc1m8brhnr	ryxa5m61ffgqkuwj0xzl1re4
t4iijlrss2ecgkzwxyqge898	gcie7x0dr5386cjg4aqoxiac
t4iijlrss2ecgkzwxyqge898	cznzis2ax9avay3ofxtq571i
t4iijlrss2ecgkzwxyqge898	tttmpl0y3z24ijyrzlsh46yf
xd52q140k3r1e8rqkt71isyp	ui1q7xwgcb6iapl6wb3usy1z
xd52q140k3r1e8rqkt71isyp	tttmpl0y3z24ijyrzlsh46yf
xd52q140k3r1e8rqkt71isyp	cznzis2ax9avay3ofxtq571i
lghf4z0rq971ur37ty5f4pwq	vrji8ud3f8fhrta89daeszpd
lghf4z0rq971ur37ty5f4pwq	tttmpl0y3z24ijyrzlsh46yf
lghf4z0rq971ur37ty5f4pwq	b592mp0h9yya3ar8rdepw6h9
xpqztk0eneqatduhb96k3uyv	ipcu509fg3ebn2ud1kd2nf54
xpqztk0eneqatduhb96k3uyv	tttmpl0y3z24ijyrzlsh46yf
xpqztk0eneqatduhb96k3uyv	jxcfrebzbccs3e7l4cc7iv5w
rq0fku6jksvib3r1wovwx2j6	lwa6nji55vke2vskubtn7no0
rq0fku6jksvib3r1wovwx2j6	liod0krxhy05ulaqgdpadcx7
rq0fku6jksvib3r1wovwx2j6	tttmpl0y3z24ijyrzlsh46yf
n8b94zl7cmb4faavli96k3tt	biebffwap53ko5rs1rtf1yzl
n8b94zl7cmb4faavli96k3tt	p996aoi253xcuqgbqovt6nl9
bw14hkayqjer3b0djya6xxhs	gcie7x0dr5386cjg4aqoxiac
bw14hkayqjer3b0djya6xxhs	pb9c5lgbl332vejl4wjsvd62
bw14hkayqjer3b0djya6xxhs	b3k17gs0kdk2arqo3ut7nax0
bw14hkayqjer3b0djya6xxhs	tttmpl0y3z24ijyrzlsh46yf
t53hcf9eq7ijwk4wenmko9bb	h3tclsr9ourgkoafmxaz65aq
ot9tw46km4i3cznp7jqrqs55	ux5da0inzw1ytgx46ol0t7sb
ot9tw46km4i3cznp7jqrqs55	xqvjormsr2w9lb1owcujqmqy
ot9tw46km4i3cznp7jqrqs55	ij34p4q8cpbuelyo3h3sow2k
ot9tw46km4i3cznp7jqrqs55	ihvl3kktqhqz3a1mn7n6epdc
s4dl15kx81y110w4eysk7r9i	gcie7x0dr5386cjg4aqoxiac
s4dl15kx81y110w4eysk7r9i	qdod6m650k1akll85lzw78fa
s4dl15kx81y110w4eysk7r9i	pf266go8z1tweorgt5zdbgx3
uzrsvt0g36ksdwrbeaz8zkho	r9dwy4y5fwdn7pl7uct5qdyf
uzrsvt0g36ksdwrbeaz8zkho	zz62s9sf4qggl0o5klu6hzdh
qbeju8cq35ik262nowamp5yw	hkkdu5zzx7uhcamb7qkkhq1x
cnvgt05mov170l9lkn7fu6g2	gcie7x0dr5386cjg4aqoxiac
cnvgt05mov170l9lkn7fu6g2	ec7ezra84bob334wu93mnkn2
k13zsoglgs4idacpm6b8ipk8	a5m375b1d192i447ea06wcvs
k13zsoglgs4idacpm6b8ipk8	ec7ezra84bob334wu93mnkn2
acw7oaymwt94wm9cpn1baz9g	gcie7x0dr5386cjg4aqoxiac
acw7oaymwt94wm9cpn1baz9g	f19r9y58j8b33k5ck9ak7skx
acw7oaymwt94wm9cpn1baz9g	tkqebf5ob144b8jmbdkpudhw
llk70tfoare6y06p5aocbfua	gcie7x0dr5386cjg4aqoxiac
llk70tfoare6y06p5aocbfua	ekpsakvi0azcehuo8vvpyfqk
qj9npdcgly8qw9hzgg8xr6ye	f19r9y58j8b33k5ck9ak7skx
j9zjgtjio5vv1nf57n6m0l31	bix7xqj1eg1gqmlrpwrui55y
eybhlduihh0rijyue21yqbdc	ld6ouepscnte5s4zsepnwfdd
ky85v7c6ycdsotis8trv527u	jvymm17qhfbo8s3adgp111mu
el5gfe00j7qafpl91anzpjyo	gcie7x0dr5386cjg4aqoxiac
b68rdrha9amjkqmtyewpyubv	ux5da0inzw1ytgx46ol0t7sb
bus1s19avirwah9kixg5zbxk	ld6ouepscnte5s4zsepnwfdd
ua39rbbxjs07a9q53h3wiss8	ux5da0inzw1ytgx46ol0t7sb
epv71bariq68080fe029rjgk	enihekwgh5s6xs5fjknjz4yx
g447lqkrqg9q7paru3devxf5	ux5da0inzw1ytgx46ol0t7sb
wsfa4biet6h3e2s1ecmuul0f	r9dwy4y5fwdn7pl7uct5qdyf
jhzemede78o9z5km8uecgbf6	r9dwy4y5fwdn7pl7uct5qdyf
gsu17ldpx0as9g0g2tln2krw	r9dwy4y5fwdn7pl7uct5qdyf
bty92v7c5e5xefu88ysd2ta0	r9dwy4y5fwdn7pl7uct5qdyf
h8k7oc2okptdqy9b7j0qdigg	r9dwy4y5fwdn7pl7uct5qdyf
uosg3nxzt37vf2ijmrrzhrwb	r8hgr8uj67zojjfoh3g3hmu2
thx0okep4a329u4w6v7dksfs	zzf2hf4xi7s1eyzikr2z5a2p
abrq4bml4rxdh1z40fl75hau	bix7xqj1eg1gqmlrpwrui55y
ncmecez8i9r3ecaybobzj9q4	iypoj2iwlhphb5tel736exms
cmjsflo1wcsrrytutvir7fx9	ui1q7xwgcb6iapl6wb3usy1z
cmjsflo1wcsrrytutvir7fx9	cznzis2ax9avay3ofxtq571i
cmjsflo1wcsrrytutvir7fx9	tttmpl0y3z24ijyrzlsh46yf
dwwkzgcwqji0zvnd3csycp52	gl64dyfuwyspwi4b0cf95wf2
dwwkzgcwqji0zvnd3csycp52	r36au07cpt0xzjg0dlslzk1j
iqnhqt50ckmeoyz6sagqmj3k	bwhk21cswknkvl1o0mq4l5r3
\.


--
-- Data for Name: _BookingNotificationRecipients; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."_BookingNotificationRecipients" ("A", "B") FROM stdin;
\.


--
-- Data for Name: _BookingSettingsAlwaysNotify; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."_BookingSettingsAlwaysNotify" ("A", "B") FROM stdin;
\.


--
-- Data for Name: _BookingToTag; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."_BookingToTag" ("A", "B") FROM stdin;
\.


--
-- Data for Name: _CategoryToCustomField; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."_CategoryToCustomField" ("A", "B") FROM stdin;
\.


--
-- Data for Name: _RoleToUser; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."_RoleToUser" ("A", "B") FROM stdin;
dd4c6e27-6276-4d1b-93a7-fb8b8fc3a07f	11438b69-6887-4ad5-926b-75fc18eb32e7
\.


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
c0e30d84-9d4b-414d-bdaf-53c9d4edc1e7	122d743a0403e77ad7e0ed9447f5b8826f2fbdbc55612d936eff004dd13c2eec	2026-04-02 13:49:19.29234+00	20230406084526_renaming_wrong_fields_on_category	\N	\N	2026-04-02 13:49:19.291126+00	1
dd5ef8f1-1c4e-451a-ae56-7f123af7da11	4f05452184309b42ca34bed162178b2f5eed605b4513b191e3ab2f271019aa39	2026-04-02 13:49:19.266957+00	20220318181539_init	\N	\N	2026-04-02 13:49:19.263545+00	1
d62e0027-b3d3-4a3a-8bb7-9f0226737301	1415d490281cbf743ae50b9f655e17ba5fab848cfd095f32046d29a73c6a5a0e	2026-04-02 13:49:19.27062+00	20230215144241_changing_default_note_to_item	\N	\N	2026-04-02 13:49:19.267545+00	1
432b225e-3e76-4811-9227-6e2d7b1f4f80	122d743a0403e77ad7e0ed9447f5b8826f2fbdbc55612d936eff004dd13c2eec	2026-04-02 13:49:19.272282+00	20230215144401_removing_notes_and_adding_items	\N	\N	2026-04-02 13:49:19.271133+00	1
302a2184-19a5-4edd-bb5f-a15986320c34	9be766e9221592e1fadfa29902568789a7696e2cdaa2414328158618f3c8e9a0	2026-04-02 13:49:19.294308+00	20230406103448_removing_unique_constraint_for_name_for_category	\N	\N	2026-04-02 13:49:19.292822+00	1
f17f7353-43e9-4bf7-a44d-723088b00236	1ccb48a60fb11c9478bfbee052888551324325ecbb63d6acac28b068efe5bc9e	2026-04-02 13:49:19.274292+00	20230222165416_adding_name_to_user	\N	\N	2026-04-02 13:49:19.272766+00	1
c1fa2437-3184-4196-bf01-d8f579bea7eb	d9534aef04949ceac9e39269c26a702c6fecffd90be7911a79f18dd7fe32c4e7	2026-04-02 13:49:19.276486+00	20230222172557_add_profile_photo_to_user	\N	\N	2026-04-02 13:49:19.274821+00	1
58e7fbe8-46a7-4021-8fe3-a969423ef78c	122d743a0403e77ad7e0ed9447f5b8826f2fbdbc55612d936eff004dd13c2eec	2026-04-02 13:49:19.278049+00	20230222173745_add_profile_picture_to_user	\N	\N	2026-04-02 13:49:19.276984+00	1
b0da5168-24bb-424b-b6e3-1326ef324235	588cf0e2c4a13c5ec7b44494d43e212214893d70700eaf93174ec48df2a9e1ad	2026-04-02 13:49:19.296842+00	20230421134426_adding_note_model_to_db	\N	\N	2026-04-02 13:49:19.294776+00	1
ffacc39f-17af-4ae4-b240-92bc7a6e3e49	4853e44e3fbb4be0dfe34f552c969149a71ffb57785c83e87d049a41466b27f8	2026-04-02 13:49:19.280244+00	20230223205820_add_firstname_and_lastname_make_username_unique	\N	\N	2026-04-02 13:49:19.278471+00	1
46465e6d-a777-4172-80d3-9a82a5f16836	f7aca2e6d3dc2d3888350550ecf3cd567a1fd1f3553f8a139248d9deee7fecd8	2026-04-02 13:49:19.28212+00	20230224170332_add_unique_constraint_to_user	\N	\N	2026-04-02 13:49:19.280718+00	1
037dba61-bfb3-47bf-9787-4f3e61b218b1	c8cea40c583566458e3c666720fc83920fa695a88408e4c122ee9d4562156a63	2026-04-03 09:05:41.447383+00	20260331101357_add_asset_model_and_quantity_based_fields	\N	\N	2026-04-03 09:05:41.432009+00	1
0d4d8fe3-093e-4a10-9b60-dd0a2acd1b34	d912690e7d1521a5d230c1087aed339c4c512c4dd38f63af3cb8ff929e10f768	2026-04-02 13:49:19.284189+00	20230331212557_add_maing_image_to_item	\N	\N	2026-04-02 13:49:19.282578+00	1
11bd8905-7af2-4fc1-b737-8aecf16a08fe	15bf7c139c7da1c93ab17144dbb9011d89b73ba08ea9df42220aa40f2e6b2e39	2026-04-02 13:49:19.298755+00	20230421135210_adding_relationship_between_note_and_user	\N	\N	2026-04-02 13:49:19.29723+00	1
43527cce-1596-4ee1-b7ca-2586a76193e9	d2d9276c6f4e42bbee8f00018addf99551e38826477fb1c15d3f9d3fdbca4f8e	2026-04-02 13:49:19.286187+00	20230403165045_adding_main_image_expiration_to_item	\N	\N	2026-04-02 13:49:19.284666+00	1
04f8a151-9499-4625-bad8-82799891eebb	8e6e051ebbd5129106863f967b0becd3ba0c14549b594bad04056205ec5ba898	2026-04-02 13:49:19.288907+00	20230405165021_adding_category_model	\N	\N	2026-04-02 13:49:19.286622+00	1
9f5c8de9-0607-4a77-a180-4f0e6f8b6509	b93ef92cc9028fa0d2243ff90059e592a0c18e263bcfe67325c1b68afc8e990a	2026-04-02 13:49:19.290738+00	20230405165140_enable_rls_on_existing_tables	\N	\N	2026-04-02 13:49:19.289348+00	1
34c30635-84bb-4b3c-b39e-5de8b1694220	785d644bcb228a269ba301bde7a3219a11090d6d88dd8aac705319dbf509d525	2026-04-02 13:49:19.300748+00	20230425074445_add_cascade_delete_for_notes	\N	\N	2026-04-02 13:49:19.299164+00	1
ff5c47af-5394-4e30-959a-4ed498884874	079cf467f31c6cdb586f3d2b4203f4fb0f66f913dc830b2400550aea58b886c7	2026-04-03 09:05:41.450543+00	20260401113301_add_index_to_asset_models	\N	\N	2026-04-03 09:05:41.44803+00	1
9afd5f00-a21a-4e0c-92b1-7059abf86b88	c77be92a8389bd5536135ba7ffe2f2437d6a3ec1fd1a94616fdc19dbe37750f8	2026-04-02 13:49:19.303246+00	20230428075403_add_qr_to_db	\N	\N	2026-04-02 13:49:19.301158+00	1
a6ebf4c7-f02c-4f03-b5a2-1021770e5591	b2a2f3874cdf1b9c211b844a9f2cb224144ecfffb9225c5971857c565e6293da	2026-04-02 13:49:19.306601+00	20230428075645_fixing_name_or_qr_table	\N	\N	2026-04-02 13:49:19.303693+00	1
4b97fc48-9429-4068-9586-672f135becc5	fea84bbbf484ff8fc63fa99b21a2b833835c14892218ac1619abecead5bf4cc1	2026-04-02 13:49:19.308546+00	20230428080057_add_rls_to_qr	\N	\N	2026-04-02 13:49:19.307123+00	1
98081ca1-aa11-43e0-bf07-e6ceecd667eb	d4c0f61cdedba5b53ec9a92e9136eed0ee119a9853d2e45b4df0c5673d575bb5	2026-04-03 09:29:24.102105+00	20260403092908_add_unit_of_measure_enum	\N	\N	2026-04-03 09:29:24.094612+00	1
3448bea3-fdb3-463f-9475-f7ab8c68cbdf	c079787e932520f8d294c639d7563f2c0af4efea7f4b045588d1325a0a51a5c9	2026-04-02 13:49:19.310663+00	20230428101832_making_item_id_not_required_for_qr	\N	\N	2026-04-02 13:49:19.308969+00	1
c2e6736e-0035-4823-8d70-71b4e58ababc	c13446f70955e21677c97d354ab59f3d7b1512d299a1c4a6d6c32bf38b6fee69	2026-04-02 13:49:19.312873+00	20230428104507_make_qr_code_delete_on_user_delete	\N	\N	2026-04-02 13:49:19.311052+00	1
615acd3a-ea7d-4928-9eeb-80b8883abeec	9198c35ed7db2d5b3dbabe4061914f4c9f5a80f4572f36972dfac8a3569c90b1	2026-04-02 13:49:19.315292+00	20230505115144_add_report_found_model	\N	\N	2026-04-02 13:49:19.313367+00	1
2198b815-0079-4f98-8718-97fa7d85fbd4	16be85a7c602d0d2b588d2e194ed326148ccd090889fca636d1c49a04419ced2	2026-04-02 13:49:19.31729+00	20230505115249_add_email_field_to_report	\N	\N	2026-04-02 13:49:19.315711+00	1
03a07ca8-48b1-4a6e-bcc6-093248074304	fc960774c259785bdf380eacf646f250b920853e21da86ce228a58990c7d9c6d	2026-04-02 13:49:19.319922+00	20230510105314_adding_scan_model_to_db	\N	\N	2026-04-02 13:49:19.317783+00	1
a474f9c1-bce4-443a-9923-87b226894515	d07abf8f75f8b0384ed98bdd5c6bcb71ecd3f35b8b34e535deac1b7942b5893d	2026-04-02 13:49:19.32196+00	20230510123118_adding_deleted_qr_id_to_scan	\N	\N	2026-04-02 13:49:19.320352+00	1
48009145-4f77-4766-b5f9-f9775fc9a66e	122d743a0403e77ad7e0ed9447f5b8826f2fbdbc55612d936eff004dd13c2eec	2026-04-02 13:49:19.323386+00	20230510132743_addin_custom_logic_for_on_delete_on_qr	\N	\N	2026-04-02 13:49:19.322419+00	1
3359ec47-946f-4719-aef0-71136f19e0cf	39e722a69b59ea59b406ea4286b2dc59a62026f4327f5fc0c2408a37e92ed209	2026-04-02 13:49:19.325183+00	20230510134953_replace_deleted_qr_id_with_raw_qr_id	\N	\N	2026-04-02 13:49:19.323811+00	1
a4a3a4c7-2d71-4045-a4e9-f2af8d4acf34	7947ac96bd8fb462b0c67567c49d4496dea27c9439c94ddd041c681fdcbb2cff	2026-04-02 13:49:19.327409+00	20230510135044_make_raw_qr_id_required	\N	\N	2026-04-02 13:49:19.325663+00	1
5e3cb1b9-5e02-49af-a597-347d24f13063	16e68c98af1cb14cd8bac7610e93c7bd9708de492b4ea2a8423ec6e3308cf7a9	2026-04-02 13:49:19.329332+00	20230519095731_renaming_item_to_asset	\N	\N	2026-04-02 13:49:19.327841+00	1
6de6defd-a00f-4a79-b6ec-3bfa14431188	04184eeb28a43dcd964afe6f97b7dc40183b66bfb7ebabd95b8ef050531ef8bc	2026-04-02 13:49:19.332205+00	20230519100223_changing_item_to_asset_in_schema	\N	\N	2026-04-02 13:49:19.329796+00	1
5f58995b-c02c-497b-9e6c-5db42e828f29	6417397c1cee6b98bc9080a7c6c0e22ee76fdf9ba8e6b47c42bbe90b4545230d	2026-04-02 13:49:19.33417+00	20230602065858_adding_onboarding_flag_to_user	\N	\N	2026-04-02 13:49:19.332728+00	1
8aa0c892-f58d-42be-b0da-422b0417e963	0352ab23246047ac49e74b2bb5e6df5c8bff3897e4ab2a227adc71a097fb59cd	2026-04-02 13:49:19.338448+00	20230613115426_adding_tags_model_to_db	\N	\N	2026-04-02 13:49:19.334627+00	1
7cbbcdc9-2b3d-4746-a4ee-0c24386ec268	2a9dd099e13d131f0912b18956fe1a46d245ae0b4a07df3eb2006836e53cc4f8	2026-04-02 13:49:19.340253+00	20230613124646_add_rls_to_tag	\N	\N	2026-04-02 13:49:19.33894+00	1
25ac5e7e-fd25-4160-add1-17c7cb283295	cc00a5dcee5e840e1e0c1047fbb76c61e04442e33ff3982a9b527b63f8d47b20	2026-04-02 13:49:19.343009+00	20230620122326_adding_location_table	\N	\N	2026-04-02 13:49:19.340723+00	1
cdab36cb-dab3-4808-910a-d02ba766e926	e27ca4d633287ac4511ecf43e67025394bb62fcd5c96cb876bbb0bec20531beb	2026-04-02 13:49:19.345027+00	20230622110642_adding_note_type_enum_and_note_type_to_note_model	\N	\N	2026-04-02 13:49:19.343422+00	1
50bfc13c-01e6-4ccb-ba99-8fab52e90c33	4c12b9a5694a5373c6e8f4cf0da04e52585d89cd8e461a2915abaea6fe3f43e2	2026-04-02 13:49:19.346961+00	20230626154707_add_image_field_to_location	\N	\N	2026-04-02 13:49:19.345463+00	1
7fd09635-577b-491d-925f-b08d01ff60e9	ef5cad55c8c537ba658fe086696297559e83a1025195cb072bd93c1639372c21	2026-04-02 13:49:19.349617+00	20230627160243_adding_image_model_and_changing_relationship	\N	\N	2026-04-02 13:49:19.347466+00	1
2f2f1d85-d3cc-439d-8bdf-948eb904248b	ec91d5fbffa17094d8f221cd34006b2249e5eecb5847d6cb469ebcdf998f2311	2026-04-02 13:49:19.351771+00	20230627161509_making_image_id_optional_in_location	\N	\N	2026-04-02 13:49:19.350057+00	1
b73e2e51-20ee-4fd4-b490-6d62d84f3c8b	bf90bb3a1bac414c08ac6bd7923c08658c74c9c5d1a3c167234f824e1933ee93	2026-04-02 13:49:19.35352+00	20230627162904_add_rls_to_image	\N	\N	2026-04-02 13:49:19.352181+00	1
55bc8d9c-023c-4ed8-b5b9-664fe4954d3b	c96acac10b788b55a4247efb9226b8fe43797e053de4fd975339799755fd1958	2026-04-02 13:49:19.355573+00	20230627172213_adding_relationship_between_user_and_image	\N	\N	2026-04-02 13:49:19.353989+00	1
9475b735-992e-4534-a45b-7d711dc36fc7	8445b5cbcd734d2d8a01d35ddf2055bbb3beb3524653d5a123487e605fc04076	2026-04-02 13:49:19.357661+00	20230628140147_adding_destroy_dependency_between_location_and_image	\N	\N	2026-04-02 13:49:19.355964+00	1
59717e2c-c54d-4f09-990e-9256faa1ba0f	3bc29a5a7c18d968ae7f23bb2c00f3c1af1197a0306a2bc34747118fd8b1a4f5	2026-04-02 13:49:19.359722+00	20230628141128_reverting_prev_migration	\N	\N	2026-04-02 13:49:19.358156+00	1
82375922-df6d-4657-b0f0-7ec13cbdc962	4b83dceb56b7a44e38e754c7f5b72ab8ca71490c2eb3317422be1147d920a7b3	2026-04-02 13:49:19.362818+00	20230703135124_add_role_model_and_type_and_connect_to_user	\N	\N	2026-04-02 13:49:19.360161+00	1
4588f70c-8122-4e3a-abe1-c773972d332e	56ab55e6e881a35a3d59b5196f1fd68de015766db9a5bd56cc4d40007385b0a0	2026-04-02 13:49:19.364922+00	20230703135612_enable_rls_for_role	\N	\N	2026-04-02 13:49:19.363372+00	1
a0117750-e208-4490-83e4-771b3f3935ef	63efb9519f05de3cc09d36b122cc9c1677de8b9204148ffb08514a84ffe03d17	2026-04-02 13:49:19.36795+00	20230718131626_adding_team_member_and_custodu	\N	\N	2026-04-02 13:49:19.365313+00	1
3da9bbf1-3a1a-4dbb-9a56-51ce127fc823	a577a7f661bd901ab7c086934cdf8a2115f5a82c68c248547a749f2935258546	2026-04-02 13:49:19.371069+00	20230718154345_adding_organization_model_and_enum	\N	\N	2026-04-02 13:49:19.368418+00	1
b42d4921-ea0d-4ce1-a10e-6f31e06106fd	2377ea5e3a48bd4e74e3ea4b5c7551f2adf46382f580dae5abb1610273c122e7	2026-04-02 13:49:19.373046+00	20230718155504_adding_organization_model	\N	\N	2026-04-02 13:49:19.371481+00	1
6a118727-492f-458f-96e1-aedd73d2ac5d	8be26e0d5c918c304c918fec282a78a59462f33c47cdee3283a191ec37a4f11b	2026-04-02 13:49:19.374768+00	20230719093619_enable_rls_for_organization	\N	\N	2026-04-02 13:49:19.373437+00	1
f5714c22-4ee6-4b5b-a9f5-3290f791b200	df4dbcb2a73e833c0a4d78f4309a350325e9294694346e4d3c40249fbacf114e	2026-04-02 13:49:19.400668+00	20230906120138_adding_active_and_removing_cascade_delete_from_custom_field	\N	\N	2026-04-02 13:49:19.399149+00	1
a68cabc4-afab-4f13-bc9c-03847b536277	122d743a0403e77ad7e0ed9447f5b8826f2fbdbc55612d936eff004dd13c2eec	2026-04-02 13:49:19.377461+00	20230719094319_renaming_team_member_to_custodian_within_custody_model	\N	\N	2026-04-02 13:49:19.375304+00	1
77783c08-ddb0-4c71-aed3-dda80f0923fc	4fe4c3f8506ec1355450e45f41481dff4395bf5068aa6e82a6d6a8c99a8acb87	2026-04-02 13:49:19.379551+00	20230719114241_enabling_rls_on_organization_to_team_member	\N	\N	2026-04-02 13:49:19.377979+00	1
bfc03c4e-757e-4c19-a58e-62d89cee3948	cfe7bd3185a78da3aa2d96bcbd442c31e9e590b8debe96218fac9bc251098510	2026-04-02 13:49:19.419358+00	20231004133839_cat_tag_add_org_id	\N	\N	2026-04-02 13:49:19.41723+00	1
9b456be1-3457-4b0f-b0b6-dec1672712a5	9bbe8e421f4e71dab46a2feea56e0798f5e83acdb053cee1070cc4f31186324d	2026-04-02 13:49:19.381495+00	20230720120525_adding_asset_status_enum_and_field	\N	\N	2026-04-02 13:49:19.380062+00	1
f0b763aa-52c4-4360-8888-943d1bb75645	48b8e163f887294bab0ab443cb85492182516f6d45e940c9df03206bd975eca4	2026-04-02 13:49:19.403202+00	20230909001745_add_view	\N	\N	2026-04-02 13:49:19.401056+00	1
50397cbd-ba39-4c8a-b297-030947d53ecf	e5723eebd6a4ac73edf2b308b858d0f626ce29894be7fd5887e6313da4312d3d	2026-04-02 13:49:19.383616+00	20230804145414_adding_customer_id_to_user	\N	\N	2026-04-02 13:49:19.381908+00	1
c537d35b-db1d-409a-9908-5696f6f78aba	3bae01885e1911f6406f3b64dba4a3937d33e2f320fbc17f3c93d4721ac8dff9	2026-04-02 13:49:19.385935+00	20230809145513_adding_tier_table	\N	\N	2026-04-02 13:49:19.384063+00	1
00aacb19-e3bb-4b81-9519-7696d8137ba7	d819202322fd66fb7dbd9932365051dc802bd70098862e8683a20a42eddf6ab9	2026-04-02 13:49:19.388161+00	20230809145816_adding_relationship_between_user_and_tier	\N	\N	2026-04-02 13:49:19.386316+00	1
5fe7a14d-38ee-4c6c-abed-b603e75342e7	1ec4cf062a0dc884982d6380ab2aeac6c71a946f264cc69a880416f88c5ecb4d	2026-04-02 13:49:19.405529+00	20230919162512_expand_custom_fields	\N	\N	2026-04-02 13:49:19.403622+00	1
7d645ed6-a2a0-47ca-89f4-f501f0302558	9f2b6a30e9294f894cf3f8675a409307903d1dc5196345f6c1e9fefc85db71cb	2026-04-02 13:49:19.390445+00	20230811130821_adding_tier_limit_table	\N	\N	2026-04-02 13:49:19.388576+00	1
cc88a1d7-a878-4d10-a2ab-7d84c02597c3	909cabfdeaf2e594d3a906786c2ff0dc66e7262d35c50ddb2ce008708b96abd3	2026-04-02 13:49:19.392286+00	20230811132813_inserting_tier_limit_master_data	\N	\N	2026-04-02 13:49:19.390892+00	1
6dbe79f6-5bab-41c7-ae72-a6393ac024d1	c294c0487e9e6baf5e02b9d60183bda8bcea6bf677f1d2fdfde02bf4ba56e066	2026-04-02 13:49:19.428289+00	20231012130653_add_currency_type_and_valuation_field_to_asset	\N	\N	2026-04-02 13:49:19.426814+00	1
8bca9f06-cec5-4e16-a398-3fad758b462a	83326619c9ae2c296a57a9eb73d0d2265048c8a7f7d7c98667b61f28aec448a8	2026-04-02 13:49:19.395038+00	20230828143035_adding_custom_field_model	\N	\N	2026-04-02 13:49:19.392726+00	1
f67a902e-437c-4143-9d64-a3daff887ea2	71cab675e5155309a6927facccfcb312fcde43722f54acd5ae03869fdd29d8fb	2026-04-02 13:49:19.409232+00	20231002153143_org_id_assets	\N	\N	2026-04-02 13:49:19.405936+00	1
d1d904aa-a385-4bf8-91b3-af41299db0d1	a53d2690542d6d8571200550d4ea717f2a194dbb3dc5143c1a27a97df376f91e	2026-04-02 13:49:19.396568+00	20230828143546_updating_tier_limit_value_of_max_custom_fields	\N	\N	2026-04-02 13:49:19.39542+00	1
60008d39-5913-46ad-a17e-2a00b0af185c	d60eeb06c8574eb677db5b4589cbde3870c3c79a073f61dd9953cccb90a924bb	2026-04-02 13:49:19.398775+00	20230828145652_adding_asset_custom_field_values_table	\N	\N	2026-04-02 13:49:19.396921+00	1
81cd25fd-1565-445f-908f-d5add821f816	0033cbc8b750bce636c67ec7d29edef08fc275db7c565ddcd3c8c87c3bc4d088	2026-04-02 13:49:19.421043+00	20231006114453_add_max_organizations_to_tier_limit	\N	\N	2026-04-02 13:49:19.419727+00	1
d6bc2b69-f6a0-4c51-a872-32781908ab6d	2065d325d1e68b0e41fad4c44cda1e36fc4a8cab3104125181908846b0ac9729	2026-04-02 13:49:19.411228+00	20231003170230_add_image_to_organization	\N	\N	2026-04-02 13:49:19.409661+00	1
c8d78b4f-9edd-45c1-b5fe-419af918e081	a6129621aceddc08b4e4a82083e2aadd1ae691386f24b620b9487290dfd3c2d1	2026-04-02 13:49:19.412979+00	20231003171753_add_team_organization_type	\N	\N	2026-04-02 13:49:19.411618+00	1
0be3cb16-0f66-46c7-897d-2b5c90268205	71fba9facbf63b246d807b7204c42528448959c79236080f04cb7b8e1e935663	2026-04-02 13:49:19.422485+00	20231006123553_update_tier_limits_max_organizations	\N	\N	2026-04-02 13:49:19.421444+00	1
10274131-c94d-42e0-b96c-5bc2e5dc83b9	665ce96a7005724e4554d606bf7c09a3ef764865ebabbf24f752a7f819eb1c99	2026-04-02 13:49:19.414967+00	20231004120609_add_location_organization_relationship	\N	\N	2026-04-02 13:49:19.413351+00	1
a4026c6d-8ee0-46ea-aa88-f47812f7b042	ec10b5e1f0bd3d77c56e7b68776f759b9977d672645b9c040a586164f2c24d9e	2026-04-02 13:49:19.416843+00	20231004124134_make_organization_required_for_location	\N	\N	2026-04-02 13:49:19.415339+00	1
6230723d-78ba-46b5-9a4b-854078952971	3791eba3c5ea487e8888a4495e5662fa667bff092c9e7b1715b20763f7960f16	2026-04-02 13:49:19.44312+00	20231025012338_deleted_at_team_member	\N	\N	2026-04-02 13:49:19.44108+00	1
ee902b61-3263-49f1-9c2c-b4584f7f1f79	578598095dc00e4e8ab97380f535f815b6c31cc63b57e65d2a3b67af4b8528c9	2026-04-02 13:49:19.4313+00	20231013000027_invite_feat	\N	\N	2026-04-02 13:49:19.428695+00	1
69556e03-8cee-414b-9d4d-11721d6d46cf	a8f0c34a8db7991bf7b377597d27b1cbadbb26040fbb688acf99361858d5a938	2026-04-02 13:49:19.424269+00	20231006131408_org_id_custom_field	\N	\N	2026-04-02 13:49:19.42284+00	1
9984f5e8-86fe-4937-9c18-de0d180f63d3	fceb0f6d22c97930fd4a0d3d43282002cd6c07bc11e61c64e19876ef969d1120	2026-04-02 13:49:19.426431+00	20231009125120_org_id_qr	\N	\N	2026-04-02 13:49:19.42467+00	1
5917094f-1f7e-40f3-a88b-812421830cbe	b29a61c52ef616b23ee15e5b4be335eedef8a4ecc712619edf6cd1b1c145cacc	2026-04-02 13:49:19.438312+00	20231018152839_add_rls_to_invite	\N	\N	2026-04-02 13:49:19.436875+00	1
8c3bd0d3-619c-4050-8c38-bd4f2767a166	ea735ed51472c5588b21b871c93234b00564b6b8599df6332dca0bd8e87ff4d7	2026-04-02 13:49:19.43432+00	20231016163353_add_org_roles	\N	\N	2026-04-02 13:49:19.431705+00	1
b296b9e4-3418-4eba-948d-affbb15c32c0	dc90bbe9013e597906316d0bcae596cf9ae22182561fbe07a87087b119e62135	2026-04-02 13:49:19.436406+00	20231016174627_migrate_user_org_role	\N	\N	2026-04-02 13:49:19.434801+00	1
4031e020-c390-4c08-9972-384abca7c4a0	cb0c3a06b7a8f291261ab079e2c3e0941e38d6c2bcdc5b9e6fef92afc9b5eae8	2026-04-02 13:49:19.440585+00	20231024014450_org_to_img	\N	\N	2026-04-02 13:49:19.438743+00	1
81b7efa2-f3e4-43d4-a8b4-f911d8daf97d	2ab26cd7d9f41edd4cc85952d8290e8ee1de07f9a8f44dfaa82a7caa4081220f	2026-04-02 13:49:19.448998+00	20231118003409_bookings	\N	\N	2026-04-02 13:49:19.446011+00	1
348f3195-2532-4a55-b58f-7aef78c629dc	e5526ffb128668f107774bd7f2567bd691d577578eacfa140170e0cee506cdb6	2026-04-02 13:49:19.445531+00	20231114082502_create_announcement_model	\N	\N	2026-04-02 13:49:19.443663+00	1
a8208c6a-a26e-41e5-a336-a20e9ed67eb6	ff45c9c84c0c5b91039adc53aa4c548974fcd6e6f0d19c829ff9bca088a9f390	2026-04-02 13:49:19.451238+00	20231120193948_booking_custodian	\N	\N	2026-04-02 13:49:19.449434+00	1
14c0c3a1-b41a-406f-81c6-e6027f0c1fc3	a1056638a3eabedeed587969e5f25def526dbc32540eac6a1e2e9ee9c7650730	2026-04-02 13:49:19.453429+00	20231121144115_making_name_of_category_unique_within_organization	\N	\N	2026-04-02 13:49:19.451749+00	1
73a24e02-b74e-4b42-a816-1ff309345d99	c6feccedfcfa298ebc61319139623f474331e4e712aa76e0763ba7b491eef04a	2026-04-02 13:49:19.455726+00	20231121173002_make_name_unique_for_tag_asset_loc_custom	\N	\N	2026-04-02 13:49:19.453874+00	1
135b0964-cc88-4ca0-b22c-b6575c1098ce	e6a5b453bcf0d0374bc8daaefd0301a1a94cdd8e083f5737a6bc11733d7ec269	2026-04-02 13:49:19.458388+00	20231122141222_fix_team_member_organization_relation	\N	\N	2026-04-02 13:49:19.456181+00	1
a0b09047-0a1c-47e6-a19e-522ab4204041	2bd9066db1d2d3e41d70dc6955cbfad357512263adf6ff92db761d93f1bbfd4d	2026-04-02 13:49:19.487027+00	20240504033325_create_kits_schema	\N	\N	2026-04-02 13:49:19.483345+00	1
a264bd5e-e69c-4451-93c0-b1deda8d9dbf	8fbad9e4a6f6a96936bd8c0965979abb221a71df9eddb773bec6f8e74d1b14c9	2026-04-02 13:49:19.460337+00	20231204150820_enable_rls_for_booking	\N	\N	2026-04-02 13:49:19.458864+00	1
ad25d475-6ca6-43cd-89de-6e3b81061a1e	64966fe5383b75afe065d6a5a6dfcdd548431ff9ce284142ab48cd79ba35ded5	2026-04-02 13:49:19.462204+00	20231204175427_booking_name_required	\N	\N	2026-04-02 13:49:19.46082+00	1
ad2d8ff2-110f-415e-bd20-9f79b7398308	9cdf29669979d61f47984ea93145c5c4d0e55796224ea46ce25a242c4b3ed57c	2026-04-02 13:49:19.504445+00	20240620123439_add_a_new_tier_id_for_custom_tiers	\N	\N	2026-04-02 13:49:19.502928+00	1
32a0d629-2824-4f58-aa02-2553a383dba0	5eebefe1533cb34efa63d4a556293e6a3c18af458ec7695ce1a85c8b321305e6	2026-04-02 13:49:19.464132+00	20231213225815_add_self_service_org_role	\N	\N	2026-04-02 13:49:19.462646+00	1
d427f4b8-a0a0-4509-84a0-6614d4aeae0f	24a585001e85dbe1d9ca0ece4ce50e16ecc80e229ee76e841851eab83203ec54	2026-04-02 13:49:19.489069+00	20240504040102_add_rls_to_kit_and_kit_custody	\N	\N	2026-04-02 13:49:19.487483+00	1
937ec11c-fcd3-4d37-b976-645d55f1e22f	d875a15a52b5ca8fe3af529e54e548d87de47b0c06f7b3a706fd448e6a8ab49a	2026-04-02 13:49:19.466846+00	20231215142649_add_checkout_status_2_asset	\N	\N	2026-04-02 13:49:19.464549+00	1
3e900914-e536-4f1d-a8a0-33b97b8b462c	42789cdd49f17c58e9d6495b2546e19980cb12af233b5144135b04caafa5aa71	2026-04-02 13:49:19.468532+00	20240124105759_add_aed_currency	\N	\N	2026-04-02 13:49:19.467263+00	1
6ca0afcf-e5f2-4716-b026-5ebdbaf49b7c	4e70aabf85ee13915890e6a9b4d82c8a533686ea2111438ff2ec8f34f38bb859	2026-04-02 13:49:19.470246+00	20240418133119_add_free_trial_flag_to_user	\N	\N	2026-04-02 13:49:19.468901+00	1
c1b19a22-3513-4868-8119-5b9d7c5adeda	fea82cbdd29270231bab4e47c63bee74f126eae47858bf8b16fe0dacc32b4c59	2026-04-02 13:49:19.491572+00	20240508105323_remove_kit_relation_with_qr_and_note	\N	\N	2026-04-02 13:49:19.489609+00	1
25940625-88f1-40cd-ba75-9cea88ad2cf4	c5c057da92c52d303cea8b7ea42d312dde6772164089c7cbfe1f66bd2d4ed744	2026-04-02 13:49:19.472271+00	20240422181938_create_default_user_roles	\N	\N	2026-04-02 13:49:19.470733+00	1
dfff8fce-b70a-4a90-a3d4-0bca4407ed5d	a987271f8a766f581a4d384da4d34a1f3f9770210c0d5d15fc7e2f670e6bff24	2026-04-02 13:49:19.474048+00	20240423092744_add_manually_generated_flag_to_scan_model	\N	\N	2026-04-02 13:49:19.472677+00	1
0e50f91d-a45c-400b-b624-99bffa809a87	11c8df353d55c51af801862586cfb9d39c55200c315514f59a0b6709c19f8b44	2026-04-02 13:49:19.525426+00	20240718142031_remove_team_member_organization_role	\N	\N	2026-04-02 13:49:19.522714+00	1
ff12e835-2691-439d-b8f8-6c7cc750e8e4	2c6a6d40c79e5afd8477821b432a71520da707dcbd009e0f460f1e8da1ef9c91	2026-04-02 13:49:19.476531+00	20240424093819_add_category_to_custom_field	\N	\N	2026-04-02 13:49:19.474411+00	1
237391de-f25a-4015-96ca-4175b4d01ee8	74ffe6fcceee9812640d2f66124d6c872b45e655115d6171e8c8a4c84bc09b00	2026-04-02 13:49:19.493826+00	20240523150707_add_sso_flag_to_user	\N	\N	2026-04-02 13:49:19.492084+00	1
8e3c0775-710b-43f2-a2dd-0ea386882e5a	f52451e5f84d4525787dfe4c99732601f2bd58ea91786ec52df95a1ab499a5c6	2026-04-02 13:49:19.478375+00	20240425131533_make_user_id_and_organization_id_not_required_for_qr_codes	\N	\N	2026-04-02 13:49:19.476916+00	1
7eedc040-b5d9-4115-a2b8-b915ee5efb6c	d7168d933f145273350b8145aef10f85b2f4b1649b453502570d5a3d4c8bf3d9	2026-04-02 13:49:19.480811+00	20240426172829_add_print_batch_model	\N	\N	2026-04-02 13:49:19.478769+00	1
6f55a263-84f9-4f9f-91e3-4ac0bff491bd	57201d5b66fcb4759cf0dfe932ab7bff6af1c101d9d397469492ed50f97a2b4b	2026-04-02 13:49:19.507282+00	20240620133158_add_custom_tier_limit_table_and_populate_tier_table_with_custom_tier	\N	\N	2026-04-02 13:49:19.504969+00	1
f8949aaa-673b-47e0-847f-2912a5ebc46a	f2308190cbc23ae0b40eaaf276e0377fade88cebdd77dfdb1235f97786776f0e	2026-04-02 13:49:19.482847+00	20240429080434_add_rls_to_category_to_custom_field_relation	\N	\N	2026-04-02 13:49:19.481196+00	1
6d988f71-4628-42af-b525-ca442d69e9a9	7d2e84cb94cd9fce560842bcaec265d5c6bdc94701bc3f4dafacc9b17ee99bad	2026-04-02 13:49:19.496469+00	20240529142530_add_sso_table_and_sso_field_to_organization	\N	\N	2026-04-02 13:49:19.494309+00	1
88b2b124-c47f-4d06-a644-70a250e9df0e	12648e9116a5c2f7d2ca102ce730197a08ef4bd262ec3fbc36efd423f8409e18	2026-04-02 13:49:19.51117+00	20240624064115_update_tier_limits_with_can_import_nrm	\N	\N	2026-04-02 13:49:19.509928+00	1
2fb2f789-b94c-4b0c-863c-f2a41760ab60	1fa9613b46e78a9df429c3769be7825e1e02c6c473d6a80cd28d69fa7bbe7ee0	2026-04-02 13:49:19.498644+00	20240530100731_add_dkk_currency	\N	\N	2026-04-02 13:49:19.496898+00	1
ac4a681e-875c-4c8b-bb0b-5d30757f64a1	4b0f5863326f4227638e45c8437c2437e9f129b160decf692e21d324fb4008a7	2026-04-02 13:49:19.50064+00	20240606120623_add_field_for_groups_to_sso_details_table	\N	\N	2026-04-02 13:49:19.499075+00	1
2cef5342-a433-4e58-a521-98c30b0a8d47	76efe848844b9454cd575a2eb479b839bd1784541eb8a72efc62a4dc609decc7	2026-04-02 13:49:19.520084+00	20240711140019_add_created_with_invite_to_user	\N	\N	2026-04-02 13:49:19.518196+00	1
1dcf335e-a834-439d-bf50-139660507ffb	86c794821f977b17e3031bd4c0a08463633208c99a1c8441e353728d17de86fe	2026-04-02 13:49:19.502515+00	20240612125219_change_sso_domain_to_not_be_unique	\N	\N	2026-04-02 13:49:19.501071+00	1
73195657-d230-4718-87b5-f916488dc0e8	df8c75230f9c38e91b1b9c593357f6682834c61652440046dfc2e8c4a60dabb0	2026-04-02 13:49:19.513012+00	20240625083758_insert_teammembers_for_all_org_owners_without_team_member	\N	\N	2026-04-02 13:49:19.511642+00	1
69c07b10-59db-4a3d-bd0b-981e86df1a65	3c97a0f85ee40fb735b5a175deb4b145ba78e53d3795693ee6a035f0c11f0e6d	2026-04-02 13:49:19.509455+00	20240624063908_add_can_import_nrm_boolean_to_tier_limit_tables	\N	\N	2026-04-02 13:49:19.507699+00	1
60dd75ca-621d-4d5c-9e80-575cb1ccd8b1	3f556ffed142212b0eafe6b4333b7d8c8a73bfbb3819070e6b5a9dbf0e0ff815	2026-04-02 13:49:19.514969+00	20240705125333_add_qr_to_kit_relation	\N	\N	2026-04-02 13:49:19.513372+00	1
7e8be248-c542-4387-ae78-65291b233325	d3a8be4e2d007ddabc0b3b9736e3762016219b14a41ce2a514d679eb63316094	2026-04-02 13:49:19.517737+00	20240710071325_update_report_found_relations	\N	\N	2026-04-02 13:49:19.51534+00	1
3ac8030f-54e9-4061-9976-d4ec9ff71ec3	28db913fbe33c7567208ae671501e771b98553bbadc1387ae064cd80e7c7392a	2026-04-02 13:49:19.522248+00	20240712085058_add_is_enterprise_flag_to_custom_tier_limit	\N	\N	2026-04-02 13:49:19.520518+00	1
c92ccc8a-7eef-44bc-bf64-c8be9c38a1b5	68cee548e11a7e58111c182a32ceb458db93e3120b14c38745c41724b000f932	2026-04-02 13:49:19.527421+00	20240718142934_add_role_base_to_organization_roles	\N	\N	2026-04-02 13:49:19.525952+00	1
19450aa5-d4b1-4667-8506-60af8d2fc378	d558a6f0bca6d86dabde10d2ed7045dfcd949b2aff6727cb4fe30d500c9036e9	2026-04-02 13:49:19.529068+00	20240718144136_change_self_service_users_to_base	\N	\N	2026-04-02 13:49:19.527839+00	1
590b940c-db27-4442-b55c-12ae87166f59	9efc9cd1faf54160c0f44d209456feaef2f2b4b596c5a741938d8ee1d56e0bbd	2026-04-02 13:49:19.558484+00	20240920140447_add_columns_field_to_asset_index_settings_table	\N	\N	2026-04-02 13:49:19.557194+00	1
729c976b-c418-4f6d-bbaf-97a077f8768a	4315958e6d1e54a8286390a603d3e11d7da7dae2aac0550e96124d79ae842d5a	2026-04-02 13:49:19.531103+00	20240720032755_add_description_in_booking_schema	\N	\N	2026-04-02 13:49:19.529508+00	1
ea366a94-52cf-41aa-bdbc-c6f8dc0fe350	73630b464cada9f8756d0756ca3564c8f24ac7727dcb46b74f0616878d6722a6	2026-04-02 13:49:19.533146+00	20240723150555_add_base_user_group_id_to_sso_details	\N	\N	2026-04-02 13:49:19.531529+00	1
efa47ac4-ce73-403a-adf8-38c0f3811554	17c6f256418ac56901271b082d80c6bb39e9343791c0e406ff3dc974562a8a96	2026-04-02 13:49:19.60417+00	20250210115134_add_pkr_currency	\N	\N	2026-04-02 13:49:19.602908+00	1
73c214a7-236b-4a24-842d-341099c23d38	eee26828aebdfbd16f2331140f5a6e217b4cedbe07e0d8e5398c8970735fb2b7	2026-04-02 13:49:19.535255+00	20240725110645_add_pln_currency	\N	\N	2026-04-02 13:49:19.533603+00	1
4b1029c7-714d-42c6-abb3-6b69c48b01ff	28a2b0ed27e3c0898708f9473e9dd1462c5fa0a2032f4c8855c586b1bebcfa82	2026-04-02 13:49:19.560492+00	20240924110940_add_freeze_and_image_flags_to_asset_index_settings	\N	\N	2026-04-02 13:49:19.558897+00	1
b61bc275-5358-4ac8-b731-97795b4e215e	77e842224243caa0497e3dad43f4d28268c6d1d8c7f04fad0ef7dbc8432205a8	2026-04-02 13:49:19.540552+00	20240816120345_adding_cascading_deletes_for_user_and_organizations	\N	\N	2026-04-02 13:49:19.53573+00	1
b41d796e-717c-4e3b-9bab-8d936351b1ee	5e313a9819a4c59d64b377e63a44090beeb53cac199045c61d2611a3b57ee0c6	2026-04-02 13:49:19.542791+00	20240816121348_add_more_cascading_deletes_for_user	\N	\N	2026-04-02 13:49:19.540989+00	1
94bf7b43-8008-47ee-a37f-a621ead02b6c	004ef79b8adc297e7ff43c7da798c2456543e1ce043c3ce1902e208ff22ba9df	2026-04-02 13:49:19.576318+00	20241217152549_add_organization_in_asset_reminder	\N	\N	2026-04-02 13:49:19.574773+00	1
c29f04d6-b9c1-41a5-a918-ac7e5896a788	86f39a5a887def7f5b694752fbcb73bccd8a86290b404f44c93f0b97a07c4029	2026-04-02 13:49:19.546413+00	20240816131518_updating_note_user_relationship	\N	\N	2026-04-02 13:49:19.543218+00	1
642b6abd-95de-47c6-a92b-76a81ddd913f	913c7d05ab10eb820663049cfe367b2b558c11216f4ea0b085e22363d78e22ec	2026-04-02 13:49:19.562435+00	20240926131125_add_filters_field_to_asset_index_settings	\N	\N	2026-04-02 13:49:19.560985+00	1
0ce516c8-f930-457a-b980-63b75f34b7e3	37e6d90240d77cf6c39f38fdc947be983ce9f1e5728a0f73fb4982bd17f9222c	2026-04-02 13:49:19.548387+00	20240819140102_add_myr_currency	\N	\N	2026-04-02 13:49:19.546906+00	1
cc6a3c1a-9f64-468c-964f-e40d79e261c6	efe73091f9e9e261c0aa6ff4ba2202913d6014b5239d2a5f23cf3f3eabb5e480	2026-04-02 13:49:19.550339+00	20240820122636_add_deleted_at_to_user_for_soft_delete	\N	\N	2026-04-02 13:49:19.548783+00	1
38bd5adb-afe9-4488-a84f-b43497eccc8e	034a8da6e1763ef41188e75b9b7860937de2ca593f200dd9378f783b62bb6d7c	2026-04-02 13:49:19.552399+00	20240830103226_add_idr_currency	\N	\N	2026-04-02 13:49:19.550897+00	1
82f524b7-0dd2-4c36-8609-8949337e6282	59d38cf640efd543ffe2d73d1512be18c5b07370e3d5b7391360973d031e8a6b	2026-04-02 13:49:19.564217+00	20241101140740_remove_filters_column_from_asset_index_settings	\N	\N	2026-04-02 13:49:19.562864+00	1
dae78ba9-cc71-4c97-b3e1-ac808abb0524	f6d75d236943210beb7b2cfc9d8fce70848c5fe11bb54faec0e1253808a981d2	2026-04-02 13:49:19.55429+00	20240903094636_add_czk_and_lkr_currencies	\N	\N	2026-04-02 13:49:19.552862+00	1
e7aa3f39-304a-40af-b449-c0726699b1a6	2f3c39b17fc9adbad843b59bb2edaf5916c242c5d2d3a6138a8fdbb4780c4f16	2026-04-02 13:49:19.556823+00	20240919150211_add_asset_index_settings_model	\N	\N	2026-04-02 13:49:19.554732+00	1
92df2d11-05a3-4070-b565-6c19708f711b	7d64cba747f19a5a5eb8f115702751454c4d64b08a1b36cb92f2235c7f625d6a	2026-04-02 13:49:19.597822+00	20250114124237_add_reminder_indexes_for_optimization	\N	\N	2026-04-02 13:49:19.595775+00	1
792d1e24-0b66-4226-ad5f-a893e21364c3	db89be96b994867eb6931e389393b0cbf0b4d42e2a9202320b0ce8878db3a723	2026-04-02 13:49:19.589117+00	20241218134155_add_indexes_for_better_asset_search_performance	\N	\N	2026-04-02 13:49:19.576765+00	1
2695eeb1-b37c-4817-bafb-82e00255c437	aa0ee0a4c1625cdb924692250f15dc8111ac8e29440061e24aaeffd4551484dd	2026-04-02 13:49:19.566729+00	20241107105011_enhance_asset_search_view_validation	\N	\N	2026-04-02 13:49:19.564606+00	1
b6741e11-5d6c-42eb-b632-40e3ef48d6f8	827866d94d9bfb280ce7150765339bc81377765f6bb737817e488234e88c6dab	2026-04-02 13:49:19.568531+00	20241119143056_add_php_currency	\N	\N	2026-04-02 13:49:19.567105+00	1
daec8901-f628-4756-ba54-ce12383f0fcc	fd99dc14ad6d1214c0b512c9f550144efb55eea9a70cc23ddefd0cc2b01e8643	2026-04-02 13:49:19.571285+00	20241121134146_add_indexes_for_asset_query_optimization	\N	\N	2026-04-02 13:49:19.568929+00	1
a510bdef-2a8a-4b24-9829-eed0e8f4f571	f50cd8f22feed786fddb89d05e8e1da41e66f2689defd9f84c5fe70cc96f637d	2026-04-02 13:49:19.591194+00	20241218134451_remove_asset_search_view	\N	\N	2026-04-02 13:49:19.589561+00	1
6f62f214-2ca4-49b7-82a3-617ef14f8121	c76de2c79d7b1422ce419b44fba9bafcf1a6a95fc8c7c68e5f128bf01c44caa7	2026-04-02 13:49:19.574288+00	20241217150402_create_schema_for_asset_reminders	\N	\N	2026-04-02 13:49:19.571679+00	1
f929def7-db4f-43c0-b4af-b05caea07d51	863e21881d96f4d6548c26f8c3cc34fb20f2f0567f58dfe2658a8545e7c52658	2026-04-02 13:49:19.593538+00	20241220170016_add_active_scheduler_reference_in_asset_reminder	\N	\N	2026-04-02 13:49:19.591699+00	1
647c48b1-ff17-4fdb-9986-711fc6c5aa44	9bd82cc61070065476cbc5b946069d7462b669416b83b395e80ca7f3c2b602aa	2026-04-02 13:49:19.600538+00	20250127174933_upgrade_prisma	\N	\N	2026-04-02 13:49:19.598258+00	1
bf278856-5246-40ab-bf83-4fa095ac08d0	63e158c86227f2998249191520ed7b6b4977e4421a87985c9820ea3848857044	2026-04-02 13:49:19.595326+00	20250102153310_enable_row_level_security_for_asset_to_tag	\N	\N	2026-04-02 13:49:19.593992+00	1
ad40658a-9e6a-46f6-9d81-c78bd5aa837a	5d15523bf056acf7c4bd3ea16a9bfeaacd68e56535f0cc3d545fb2cc7ea4dd3a	2026-04-02 13:49:19.607863+00	20250320142911_add_field_for_original_date_in_bookings	\N	\N	2026-04-02 13:49:19.606498+00	1
b31cb815-97aa-4a7b-b5e9-91187c10757b	c998a207b1cdb3bd9ff93d5f98e55cd4737525214d735afdbb0fb535bc95ed2a	2026-04-02 13:49:19.602402+00	20250204083511_enabled_rls_for_asset_reminder_to_team_member	\N	\N	2026-04-02 13:49:19.600979+00	1
e282d04a-c5d9-4d50-a200-792fe5185da2	095fa4e852df7c32a20f28af11bcb4e9c8103a3e00630c6815403a3b02728281	2026-04-02 13:49:19.606031+00	20250228142329_add_workspace_disabled_flag_to_organization_model	\N	\N	2026-04-02 13:49:19.604641+00	1
cea2e608-587e-466f-bed7-f1ddc94c32c1	a381657d063bc798e7623700926509ae9dbc5ab1dc8f2b6865180d6605b0e60f	2026-04-02 13:49:19.611215+00	20250423133152_add_thumbnail_image_to_asset	\N	\N	2026-04-02 13:49:19.609936+00	1
6691c9e6-ff71-4328-8509-b4d3af55fee8	eb6794884955b70c16cea97287882331d418c7ef97c51008e3fef65b5b56e278	2026-04-02 13:49:19.609496+00	20250411091909_add_amount_custom_field	\N	\N	2026-04-02 13:49:19.608254+00	1
e007c045-b81a-4f9d-8296-5304da618c56	b14bc5e791fb53553d9b15550fe92e18477ebbc2aac80920e33de0f3fd199c5a	2026-04-02 13:49:19.612949+00	20250508094840_add_image_url_field_in_location	\N	\N	2026-04-02 13:49:19.611622+00	1
a5d7b01e-de6a-4331-8611-601b8a86b03d	700e166861c22513a1af0b23b5360a64f7690c62729200f9f6aac9f5b98d6632	2026-04-02 13:49:19.614767+00	20250508133404_add_permissions_settings_to_organization	\N	\N	2026-04-02 13:49:19.613318+00	1
1b2d185a-6ad6-4f57-b1c6-16b4b5f092b4	f985b96c8780c1858491535cf8d791b11c3e3bbac7838c3d60891d75f8d1d43a	2026-04-02 13:49:19.616357+00	20250509140705_add_thumbnail_url_in_location	\N	\N	2026-04-02 13:49:19.615127+00	1
8154631b-4bd1-4d76-9235-bf902b178e79	64052ad4182338d02ff9dffe3c350776a4c11ca3d8bc7239ab83974674f1af87	2026-04-02 13:49:19.618372+00	20250528102715_remove_duplicate_indexes_to_improve_performance	\N	\N	2026-04-02 13:49:19.616785+00	1
3a7c0f81-dcb6-40d8-9fb0-4e8ffa8cfb95	1592c82ff8f8df424bbfe5be1477798150f2c30c5f5ed222dda943efe504cc88	2026-04-02 13:49:19.623268+00	20250528122114_added_missing_indexes_for_foreign_keys	\N	\N	2026-04-02 13:49:19.618815+00	1
2f8a92d6-d351-4215-ad3d-4091560d2fa8	7def3c6451c637ec55d14627bfeb85a9292cd527ea1fc370dd5def78a057c349	2026-04-02 13:49:19.653861+00	20250716153532_add_kit_category_indexes	\N	\N	2026-04-02 13:49:19.65197+00	1
44d1e27a-6bae-49bc-842d-1b806c2cadce	014f24ef95c59aa290d23dc30b3f221e1140becd3f7fd78d9030f678fccc2695	2026-04-02 13:49:19.626845+00	20250529125425_add_working_hours_models	\N	\N	2026-04-02 13:49:19.623734+00	1
aa273388-7b93-4e0c-9a2f-bf548545e44e	9971b38f12ccaf84c97f0a5b0ff5e222f2f4728ea4993f0ba0a21b68590c9de1	2026-04-02 13:49:19.629327+00	20250612101114_add_booking_settings_model	\N	\N	2026-04-02 13:49:19.627306+00	1
9d88e0a8-ad72-49d6-ab17-39def607f40c	2438071fc9b30b972e3a29885eecdfd23ea318f779f0d0c8b638c247fa8370ab	2026-04-02 13:49:19.67446+00	20250806090215_add_updates_model	\N	\N	2026-04-02 13:49:19.670851+00	1
74798d6a-73d2-4992-9ff7-87c1583caf2e	afc0eade33f70640c43b3cbe8cc6d6991bcab4d453bc23416a5dbdc13e1a9866	2026-04-02 13:49:19.632062+00	20250616135659_add_tags_in_booking_schema	\N	\N	2026-04-02 13:49:19.629779+00	1
6455652b-b2c1-43ae-9b45-0ea54ea8a119	3eef2ed8c8906b34b77bb92b05bc8a8af4deff0a15d2a819effcb6e5410e8c9f	2026-04-02 13:49:19.655956+00	20250717094237_add_tags_required_flag_to_booking_settings	\N	\N	2026-04-02 13:49:19.654253+00	1
89557b69-a086-4499-a942-715caef013c7	813f49682ee6fdccfb0b2d3a72c6c5aec801c191997d5fe81e2c51cadf03cb33	2026-04-02 13:49:19.635095+00	20250616174825_add_user_contact_model	\N	\N	2026-04-02 13:49:19.632528+00	1
8937bda7-e232-4be9-a0d2-c3cad876174c	088ccc7b7e111b4a4704f22ce5e79859cfd39d774d1eea40be54724d11f00e2b	2026-04-02 13:49:19.637242+00	20250617074555_create_trigger_that_create_user_contact_on_insert_in_user_table	\N	\N	2026-04-02 13:49:19.63556+00	1
bfc17bec-464d-4722-a157-4596239cc615	e98b49f71690cba117d2b2aef0d279e1c9444b4fb16722a75b9e9f9afefab61d	2026-04-02 13:49:19.639177+00	20250618115049_add_use_for_in_tag_schema	\N	\N	2026-04-02 13:49:19.637686+00	1
4a65942e-cfca-4450-ab0f-0e4cc9cf4c9a	f32013bdafdd0167c67262373daa830db17c991fce884e0d0047feca7c905b9c	2026-04-02 13:49:19.65766+00	20250717125703_add_max_booking_length_to_booking_settings	\N	\N	2026-04-02 13:49:19.656344+00	1
720aeb8e-6e77-409c-91fb-7071a790d613	184664bb246ae44ec42cb3421e5981eea6274828d1fbba0971e2397c8afadb1f	2026-04-02 13:49:19.640995+00	20250624090558_update_all_existing_tags_with_default_value_of_use_for	\N	\N	2026-04-02 13:49:19.639656+00	1
d4211eed-bc8c-4eea-9411-e184d7e47cc0	71a225e06128fdb0fd8c88a9d42e1fd32d564fa8cdefa000d8db6eba47e6445f	2026-04-02 13:49:19.643066+00	20250625103703_add_referral_source_field_in_user_schema	\N	\N	2026-04-02 13:49:19.641505+00	1
7624171b-9580-4a6a-acd9-6cbae1552604	16d11df4441c8191be339f562f25b6035810aada88de00e68e52285c3997cf94	2026-04-02 13:49:19.685477+00	20250818111341_add_sequential_id_sequences	\N	\N	2026-04-02 13:49:19.683497+00	1
1b934390-98d9-45a7-9567-4f2c66877b8a	7e6331bf58980339fcc21d4bd85fa74f5fc374b4646203572b89e069e5bf668f	2026-04-02 13:49:19.645141+00	20250630103727_add_barcodes_enabled_flag_to_organization_table	\N	\N	2026-04-02 13:49:19.643519+00	1
185e1979-51f3-48b8-b9e0-008508cdae24	61102b99fc9ad84382a95773917cd78e1db2fbad5b1ef91b96ea5043a41df1bd	2026-04-02 13:49:19.659583+00	20250718123608_add_skip_subscription_check_flag_to_user	\N	\N	2026-04-02 13:49:19.658076+00	1
d9d8a16b-17c4-4b39-8f19-c787f6bdfc6a	f145acf50c662acf620a580b376ba6a4b5b1f02c1d752b4c8f53e0cafb375408	2026-04-02 13:49:19.648706+00	20250630123232_add_barcode_model_and_enum	\N	\N	2026-04-02 13:49:19.645579+00	1
871405f0-3255-4092-8b13-824663a6ec9e	03f5e25d236f83c73797f691e8c52cb0b6174948862ce61b50ec1a24d543b074	2026-04-02 13:49:19.651495+00	20250703121610_add_category_in_kit_schema	\N	\N	2026-04-02 13:49:19.649236+00	1
dae6df0b-b21d-4ead-80c2-567d44384aac	6c13540f5597683d913f65434810bee7116cade1405d90ff0b1346b7e303768b	2026-04-02 13:49:19.676441+00	20250808080021_make_updates_url_optional	\N	\N	2026-04-02 13:49:19.67498+00	1
60847b2e-4207-425e-addd-d01f4cf2eb9a	beaf6d900814aa32d744c567c65cda0e63c70bb8052b887a1f0d35f430651f54	2026-04-02 13:49:19.661497+00	20250721095213_add_max_booking_length_skip_closed_days_flag_to_booking_settings	\N	\N	2026-04-02 13:49:19.66008+00	1
06336967-1a26-4f87-9bc5-d39ceefaf1b4	e00928c37f43e0f42107fa83bb96c58bebeace8dd69b85147a1f71dc28d75aa6	2026-04-02 13:49:19.66473+00	20250725121218_add_table_to_store_partial_booking_checkin	\N	\N	2026-04-02 13:49:19.661956+00	1
4bf7946c-6e5a-4db9-a5ba-e31c941efdcd	1d6445adf6b413ebf1f90c47f5100a55d3d1f34d4a6a739e9221f19d01824780	2026-04-02 13:49:19.668031+00	20250726104744_add_location_in_kit	\N	\N	2026-04-02 13:49:19.665326+00	1
5404aa9a-b243-4b04-9060-aacfaf6f8994	15f4d984c81504f25e3d4938c6711b63f66ae225df1823d8763940a09dd262dd	2026-04-02 13:49:19.67855+00	20250813145657_add_custom_field_type_number	\N	\N	2026-04-02 13:49:19.676906+00	1
3cf7b0b5-7da3-4c0a-9398-83f0a4563c42	12f34684419f5f2c7c6ddbd2d67d7d3f655d2d3012b5a1b486b0636b10fc69c7	2026-04-02 13:49:19.670409+00	20250801124107_add_external_qr_barcode_type	\N	\N	2026-04-02 13:49:19.668542+00	1
9be8ce4d-3958-4c9d-9f87-8f670fd03b7d	1af2f0a8e88e54071be2ce796726c2b3db8d45b14bb35940e247fd9fd8abd8c5	2026-04-02 13:49:19.680548+00	20250815101509_add_lat_and_long_to_location_model	\N	\N	2026-04-02 13:49:19.678997+00	1
31c57472-9b7b-4ced-b72e-cd75579c8287	bf0bd67dc164c901a97f33c3a1730a17d2f3a9b7ecb96b0057c28cec2893dbf9	2026-04-02 13:49:19.687374+00	20250818152417_add_flag_to_track_sequential_ids_migration	\N	\N	2026-04-02 13:49:19.685986+00	1
3b3113a5-071c-4b3a-8a9b-69ba1c835670	4362a8cf085fb3bcea887de049d45be5a79e8af8c8ed8f93dced277172fea641	2026-04-02 13:49:19.683057+00	20250818111026_add_sequential_id_column	\N	\N	2026-04-02 13:49:19.681052+00	1
ffc55b47-ea80-4324-9349-eaac7117607d	e67c1f7c1e4693167e17302922fff4f263e69c44400fd120b591025e66cc2815	2026-04-02 13:49:19.689023+00	20250820114416_add_ugx_currency	\N	\N	2026-04-02 13:49:19.687841+00	1
b7acd319-168f-4c6d-8f51-55011ca516b3	6ceaf8f5451d745ac724e37f51466b1113e36799f25d3ce4eef6407cf6702b2c	2026-04-02 13:49:19.690639+00	20250821152852_add_ean13_barcode_type	\N	\N	2026-04-02 13:49:19.689388+00	1
64d48f56-764f-43fd-9bc0-8dd786b47c8e	7a9744eea9e0e9034044ff9f7ea2edadbe77b159bda086b178231533a28cc753	2026-04-02 13:49:19.692539+00	20250827121205_fix_sequential_id_padding	\N	\N	2026-04-02 13:49:19.691021+00	1
76a9269e-0d93-4f1f-b79b-c4dc92f8f4cf	44a38783849bc62294dfb9f33c6f3a67fff36e6bf60998c1e057d02841568ac0	2026-04-02 13:49:19.694223+00	20250910065319_add_bgn_currency	\N	\N	2026-04-02 13:49:19.692977+00	1
0d36337a-8c95-41ae-9709-1b32cb239b64	8a0610dcc562a59888b09270710e80bf197abd52e30be0e96001e5f9faec324e	2026-04-02 13:49:19.724547+00	20251120120000_add_color_to_tag	\N	\N	2026-04-02 13:49:19.722992+00	1
0019bfe3-92eb-4779-80ac-22d3a79e7bf4	b5b11cc1f4c1e0b313219a44528aa5a653e20f62056d8a2d9cb66992d6838298	2026-04-02 13:49:19.700232+00	20250916120000_add_audit_tables	\N	\N	2026-04-02 13:49:19.694665+00	1
90eeb431-0530-419d-b241-20dcde25adb3	33b446a45d8a5fa89cce0432bec8f623a19401009a37857433b1ac4e54b31b75	2026-04-02 13:49:19.702605+00	20250918141331_add_qr_id_display_preference_to_organization_model	\N	\N	2026-04-02 13:49:19.700731+00	1
5065e265-a268-4f69-bf7f-b2666f3dea83	811a60e5f4d897aef8cfeef70142cd194eea24094610625f5ac4acf74f46e99f	2026-04-02 13:49:19.73393+00	20251216080323_add_audit_image_model	\N	\N	2026-04-02 13:49:19.73104+00	1
5cdb4a72-90c7-466a-bf30-18f6bd8953e7	aa675b26ee82375dc12cc102a2d1660e712662d810eb7fcdb93847167eb37d3f	2026-04-02 13:49:19.705576+00	20250923115742_add_booking_note_model	\N	\N	2026-04-02 13:49:19.703063+00	1
5b12cfb0-0a6c-4f8f-ba4a-23aca1750338	bff6af5b2e5a3aa2a3c9d9e02f74fbc33c8d40607ac7ebb700ca62234967c6d5	2026-04-02 13:49:19.70838+00	20250930134314_add_business_intel_model	\N	\N	2026-04-02 13:49:19.705999+00	1
c842d09f-71e1-424e-898e-a744d2ecc8c8	27f693426a5323fd75d0ae793063d903541f78342e9f350b63ab142d50caf344	2026-04-02 13:49:19.752255+00	20260128103135_add_location_notes_model	\N	\N	2026-04-02 13:49:19.749437+00	1
7bddd47d-3673-4b33-a977-6bb6a8fa5e43	803d01877199e6dba1d845d2da0ac35d2b50298db4ff712f979da329e94ccb9e	2026-04-02 13:49:19.710386+00	20251014111701_add_deleted_at_to_custom_field_model	\N	\N	2026-04-02 13:49:19.708852+00	1
be55e73e-3e2b-42bc-bfee-e01380b36cf7	a2a1bb34277a14cc5f8363daa7b3902bcb04f8ba81396322c049668d1aaba7ab	2026-04-02 13:49:19.73659+00	20251216201234_add_audit_asset_id_to_audit_note	\N	\N	2026-04-02 13:49:19.734428+00	1
9fd40bd9-41cb-492b-93c6-3c3eecbf8652	c3877ac1654a674b7e9fefd523513fff75c1034acca1f09d4fcd8c3509d81471	2026-04-02 13:49:19.712428+00	20251021095151_add_shelf_branding_controls	\N	\N	2026-04-02 13:49:19.7108+00	1
5f9da051-d048-49fa-bab7-5d180af66e23	460ca95930022ca44aaeaa6cdd7852be139b13023929c4fd40838d5a8fc0b303	2026-04-02 13:49:19.71412+00	20251021111406_enable_branding_controls_for_paid_tiers	\N	\N	2026-04-02 13:49:19.712876+00	1
558bc9b5-ceb0-4109-9f56-c2b289cee8ea	a073a5e38c1ef3a937b12899dfcb86c7dbe4dbfca0c6e846634a8b83df5e4249	2026-04-02 13:49:19.715979+00	20251022120000_add_twd_currency	\N	\N	2026-04-02 13:49:19.714525+00	1
c4099c26-ec95-420b-a600-07fa3ff5a8e1	c2e48ac6b4f3b79ef1a0cf910077733e8ca81ee076993a0daa679ea69db4a862	2026-04-02 13:49:19.738531+00	20251218145702_add_update_featured_image	\N	\N	2026-04-02 13:49:19.737074+00	1
1c490228-c034-4979-8f88-a89c1fd4bbc5	7d880434777b8a02a9ea658a0fb38a6c487f239f23a7e20ff3b7306c07cc0eaa	2026-04-02 13:49:19.718542+00	20251113141031_add_parent_and_children_location_fields	\N	\N	2026-04-02 13:49:19.716398+00	1
3e7aeb6a-d03c-4d22-af20-524135e73669	69866808b3b6e1d87c852c64c3f0a524de3df722f08759433c678b27621ae819	2026-04-02 13:49:19.72039+00	20251119221127_add_ron_currency_add_ron_currency	\N	\N	2026-04-02 13:49:19.718989+00	1
c9b2e8e9-6da9-46f2-88a0-7967391ca171	9d769c4070c968b1f6465892b97edbf4b235dbb1209af34247df75bdd19ac78a	2026-04-02 13:49:19.759979+00	20260210095629_add_audit_addon_fields_to_organization	\N	\N	2026-04-02 13:49:19.758347+00	1
01ec248b-bff0-4ef0-9d6c-ee36e7dba2a3	d58b978bcd67f431f074b41d24bbf175f6f53f95ba6214ecc4eb7988acb74534	2026-04-02 13:49:19.722519+00	20251120080159_make_booking_from_and_to_required_fields	\N	\N	2026-04-02 13:49:19.720844+00	1
eea3acbf-4944-4f6b-b1e5-845c6d12d8d1	f5718c6076ed4041af23636c45a52dab18158fd9534baf46ee94621fdae5dc80	2026-04-02 13:49:19.727683+00	20251202160542_add_asset_filter_preset_model	\N	\N	2026-04-02 13:49:19.72501+00	1
aea5fe23-5bf8-4036-92c2-ebde7b58aab3	3857cc689ca549a7f5dd5b686dbb88e28885cb11a4b15ae15d69c5858f645cb7	2026-04-02 13:49:19.740234+00	20260108104220_add_due_date_to_audit_session_model	\N	\N	2026-04-02 13:49:19.738934+00	1
a689f3da-4218-489f-8930-68d59222bb14	12c6d44a47e4242fefb41390094f80ded702dcbb47798066e6eb4e7fdd690679	2026-04-02 13:49:19.730582+00	20251211074626_add_audit_note_model	\N	\N	2026-04-02 13:49:19.728161+00	1
636022ee-b7c3-4860-bbec-7638cb4dc4a0	79a5fa42ea63289582808c43995d02ebe8f762c9e2dde03031f8dc48cf04b743	2026-04-02 13:49:19.754293+00	20260130132048_add_cancellation_reason_to_booking_model	\N	\N	2026-04-02 13:49:19.752768+00	1
5d247d93-9fa0-499e-9083-f90a77642dc8	ff1a5ca50a29f4cbc26d748478f9dec6445f0f02b95ffd598bddae1697314728	2026-04-02 13:49:19.742031+00	20260108120000_add_active_scheduler_reference_to_audit_session	\N	\N	2026-04-02 13:49:19.740672+00	1
3c0d4585-bd9f-417f-a44f-44cd1fddf405	0a5b559f3e2391aa3e29b978df88c824f431a9ffdfe3fc1d3a950566a25698e0	2026-04-02 13:49:19.744023+00	20260122000000_add_invite_message	\N	\N	2026-04-02 13:49:19.742504+00	1
8bb1ec15-1200-45dd-9365-6112a60ac7ed	10573066052a7e1becd9b727c29bb4a584116ac505d08d94a96125af816b9b56	2026-04-02 13:49:19.748972+00	20260128101537_add_iso_4217_currencies	\N	\N	2026-04-02 13:49:19.744475+00	1
6790539f-a5da-46a2-a846-cbdf7e22eb74	76a9b18c29b47c67a489c5aad037cfa01f335061a29e646b4091544e41733bc9	2026-04-02 13:49:19.756115+00	20260202155915_add_has_unpaid_invoice_flag_to_user_model	\N	\N	2026-04-02 13:49:19.754709+00	1
8fdfb641-fb2d-44bb-887a-5cb272d164ce	c578bcfaf6735f56507baa278f8573dee8c15412c8b6c903f56742d59407fed1	2026-04-02 13:49:19.765969+00	20260216150917_require_explicit_checkin	\N	\N	2026-04-02 13:49:19.764434+00	1
b662f902-cdc2-4b85-85dc-cf16da672c31	434bfac96b1dc088e5b3caaf553e6c29c85609365315410942cb183870d3599e	2026-04-02 13:49:19.7579+00	20260206133908_add_warn_for_no_payment_method_flag_in_user_model	\N	\N	2026-04-02 13:49:19.756496+00	1
8e870bc3-c3ae-4647-936e-54ebeec2d3bd	545bfb87c1063a7b9e2e453e2fae6f2e6d8b8bc504aa4f98c92c2b40a33fea4d	2026-04-02 13:49:19.762245+00	20260211084408_add_last_selected_organization_id	\N	\N	2026-04-02 13:49:19.760376+00	1
91f1ebea-fb1a-4e85-8c9b-9afc33523fdb	5964d69e394bae1a21f03d9802eac388a0078da35ef4222f5b768845b8ea90db	2026-04-02 13:49:19.764039+00	20260212090311_add_custom_email_footer	\N	\N	2026-04-02 13:49:19.762691+00	1
005de7ef-da70-45ef-9370-a54256210f4e	60bdc1afb5dcd1b4e907a722738c652c90cc6614209a98a70237da1a77dd458f	2026-04-02 13:49:19.771195+00	20260223120000_make_audit_image_uploaded_by_optional	\N	\N	2026-04-02 13:49:19.769756+00	1
025f9fdd-df5c-468d-b746-079f521aa436	cc190a70e65646cc291e96b63fb6bdbf0868fac7f055e13338847a8baace5f8f	2026-04-02 13:49:19.769221+00	20260217120638_add_role_change_log_model	\N	\N	2026-04-02 13:49:19.76641+00	1
f421b283-bdf3-4f4d-bd8f-11d0045d64c5	289f09ff7ef416e069cd0479c1f3bf76289dd3ac46d5464aaceef24762aec76b	2026-04-02 13:49:19.773107+00	20260224085009_add_auto_archive_bookings	\N	\N	2026-04-02 13:49:19.771644+00	1
4210115d-4ef2-4c41-bc1f-a13f4e9b3dab	7602c96aded0230195ff4a2332b757b564897f381c5b9dda569964803da95064	2026-04-02 13:49:19.775328+00	20260306115730_add_used_barcode_trial_to_organization_model	\N	\N	2026-04-02 13:49:19.773528+00	1
1096761d-a506-45e5-847d-b7aac88507f5	1b45f531c44436bf88363a580331d4ff13abd90a20da1fc15262f55adaff5a73	2026-04-02 13:49:19.780218+00	20260320133343_add_booking_notification_settings	\N	\N	2026-04-02 13:49:19.775863+00	1
874381aa-6819-445a-9984-319c6e3c3a4a	51aeff6dd433f702f919a528f0ffe8458c4803ee9ebc29e1ba8ba6e97d1ef2e7	2026-04-02 13:49:19.783275+00	20260323134004_add_display_name_to_user_table	\N	\N	2026-04-02 13:49:19.781436+00	1
cb5aa392-eec3-482e-9cd4-93effccbf5b4	5ad77f374c3c0b41eb032cedfbb4d3a448b325188044f4f54bcd2b35d7bbe71d	2026-04-02 13:49:19.786657+00	20260324135143_add_team_member_note_model	\N	\N	2026-04-02 13:49:19.783734+00	1
\.


--
-- Data for Name: messages_2026_04_01; Type: TABLE DATA; Schema: realtime; Owner: -
--

COPY realtime.messages_2026_04_01 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2026_04_02; Type: TABLE DATA; Schema: realtime; Owner: -
--

COPY realtime.messages_2026_04_02 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2026_04_03; Type: TABLE DATA; Schema: realtime; Owner: -
--

COPY realtime.messages_2026_04_03 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2026_04_04; Type: TABLE DATA; Schema: realtime; Owner: -
--

COPY realtime.messages_2026_04_04 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2026_04_05; Type: TABLE DATA; Schema: realtime; Owner: -
--

COPY realtime.messages_2026_04_05 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2026_04_06; Type: TABLE DATA; Schema: realtime; Owner: -
--

COPY realtime.messages_2026_04_06 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: realtime; Owner: -
--

COPY realtime.schema_migrations (version, inserted_at) FROM stdin;
20211116024918	2026-04-02 13:48:27
20211116045059	2026-04-02 13:48:27
20211116050929	2026-04-02 13:48:27
20211116051442	2026-04-02 13:48:27
20211116212300	2026-04-02 13:48:27
20211116213355	2026-04-02 13:48:27
20211116213934	2026-04-02 13:48:27
20211116214523	2026-04-02 13:48:27
20211122062447	2026-04-02 13:48:27
20211124070109	2026-04-02 13:48:27
20211202204204	2026-04-02 13:48:27
20211202204605	2026-04-02 13:48:27
20211210212804	2026-04-02 13:48:27
20211228014915	2026-04-02 13:48:27
20220107221237	2026-04-02 13:48:27
20220228202821	2026-04-02 13:48:27
20220312004840	2026-04-02 13:48:27
20220603231003	2026-04-02 13:48:27
20220603232444	2026-04-02 13:48:27
20220615214548	2026-04-02 13:48:27
20220712093339	2026-04-02 13:48:27
20220908172859	2026-04-02 13:48:27
20220916233421	2026-04-02 13:48:27
20230119133233	2026-04-02 13:48:27
20230128025114	2026-04-02 13:48:27
20230128025212	2026-04-02 13:48:27
20230227211149	2026-04-02 13:48:27
20230228184745	2026-04-02 13:48:27
20230308225145	2026-04-02 13:48:27
20230328144023	2026-04-02 13:48:27
20231018144023	2026-04-02 13:48:27
20231204144023	2026-04-02 13:48:27
20231204144024	2026-04-02 13:48:27
20231204144025	2026-04-02 13:48:27
20240108234812	2026-04-02 13:48:27
20240109165339	2026-04-02 13:48:27
20240227174441	2026-04-02 13:48:27
20240311171622	2026-04-02 13:48:27
20240321100241	2026-04-02 13:48:27
20240401105812	2026-04-02 13:48:27
20240418121054	2026-04-02 13:48:27
20240523004032	2026-04-02 13:48:27
20240618124746	2026-04-02 13:48:27
20240801235015	2026-04-02 13:48:27
20240805133720	2026-04-02 13:48:27
20240827160934	2026-04-02 13:48:27
20240919163303	2026-04-02 13:48:27
20240919163305	2026-04-02 13:48:27
20241019105805	2026-04-02 13:48:27
20241030150047	2026-04-02 13:48:27
20241108114728	2026-04-02 13:48:27
20241121104152	2026-04-02 13:48:27
20241130184212	2026-04-02 13:48:27
20241220035512	2026-04-02 13:48:27
20241220123912	2026-04-02 13:48:27
20241224161212	2026-04-02 13:48:27
20250107150512	2026-04-02 13:48:27
20250110162412	2026-04-02 13:48:27
20250123174212	2026-04-02 13:48:27
20250128220012	2026-04-02 13:48:27
20250506224012	2026-04-02 13:48:27
20250523164012	2026-04-02 13:48:27
20250714121412	2026-04-02 13:48:27
20250905041441	2026-04-02 13:48:27
20251103001201	2026-04-02 13:48:27
\.


--
-- Data for Name: subscription; Type: TABLE DATA; Schema: realtime; Owner: -
--

COPY realtime.subscription (id, subscription_id, entity, filters, claims, created_at) FROM stdin;
\.


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id, type) FROM stdin;
\.


--
-- Data for Name: buckets_analytics; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.buckets_analytics (name, type, format, created_at, updated_at, id, deleted_at) FROM stdin;
\.


--
-- Data for Name: buckets_vectors; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.buckets_vectors (id, type, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: iceberg_namespaces; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.iceberg_namespaces (id, bucket_name, name, created_at, updated_at, metadata, catalog_id) FROM stdin;
\.


--
-- Data for Name: iceberg_tables; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.iceberg_tables (id, namespace_id, bucket_name, name, location, created_at, updated_at, remote_table_id, shard_key, shard_id, catalog_id) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.migrations (id, name, hash, executed_at) FROM stdin;
0	create-migrations-table	e18db593bcde2aca2a408c4d1100f6abba2195df	2026-04-02 13:48:28.976199
1	initialmigration	6ab16121fbaa08bbd11b712d05f358f9b555d777	2026-04-02 13:48:28.977746
2	storage-schema	f6a1fa2c93cbcd16d4e487b362e45fca157a8dbd	2026-04-02 13:48:28.978275
3	pathtoken-column	2cb1b0004b817b29d5b0a971af16bafeede4b70d	2026-04-02 13:48:28.980924
4	add-migrations-rls	427c5b63fe1c5937495d9c635c263ee7a5905058	2026-04-02 13:48:28.982405
5	add-size-functions	79e081a1455b63666c1294a440f8ad4b1e6a7f84	2026-04-02 13:48:28.982999
6	change-column-name-in-get-size	ded78e2f1b5d7e616117897e6443a925965b30d2	2026-04-02 13:48:28.983819
7	add-rls-to-buckets	e7e7f86adbc51049f341dfe8d30256c1abca17aa	2026-04-02 13:48:28.984496
8	add-public-to-buckets	fd670db39ed65f9d08b01db09d6202503ca2bab3	2026-04-02 13:48:28.984918
9	fix-search-function	af597a1b590c70519b464a4ab3be54490712796b	2026-04-02 13:48:28.985362
10	search-files-search-function	b595f05e92f7e91211af1bbfe9c6a13bb3391e16	2026-04-02 13:48:28.985929
11	add-trigger-to-auto-update-updated_at-column	7425bdb14366d1739fa8a18c83100636d74dcaa2	2026-04-02 13:48:28.986542
12	add-automatic-avif-detection-flag	8e92e1266eb29518b6a4c5313ab8f29dd0d08df9	2026-04-02 13:48:28.987186
13	add-bucket-custom-limits	cce962054138135cd9a8c4bcd531598684b25e7d	2026-04-02 13:48:28.987645
14	use-bytes-for-max-size	941c41b346f9802b411f06f30e972ad4744dad27	2026-04-02 13:48:28.988067
15	add-can-insert-object-function	934146bc38ead475f4ef4b555c524ee5d66799e5	2026-04-02 13:48:28.99136
16	add-version	76debf38d3fd07dcfc747ca49096457d95b1221b	2026-04-02 13:48:28.99195
17	drop-owner-foreign-key	f1cbb288f1b7a4c1eb8c38504b80ae2a0153d101	2026-04-02 13:48:28.992423
18	add_owner_id_column_deprecate_owner	e7a511b379110b08e2f214be852c35414749fe66	2026-04-02 13:48:28.992838
19	alter-default-value-objects-id	02e5e22a78626187e00d173dc45f58fa66a4f043	2026-04-02 13:48:28.993399
20	list-objects-with-delimiter	cd694ae708e51ba82bf012bba00caf4f3b6393b7	2026-04-02 13:48:28.993841
21	s3-multipart-uploads	8c804d4a566c40cd1e4cc5b3725a664a9303657f	2026-04-02 13:48:28.994545
22	s3-multipart-uploads-big-ints	9737dc258d2397953c9953d9b86920b8be0cdb73	2026-04-02 13:48:28.996407
23	optimize-search-function	9d7e604cddc4b56a5422dc68c9313f4a1b6f132c	2026-04-02 13:48:28.997766
24	operation-function	8312e37c2bf9e76bbe841aa5fda889206d2bf8aa	2026-04-02 13:48:28.998376
25	custom-metadata	d974c6057c3db1c1f847afa0e291e6165693b990	2026-04-02 13:48:28.998898
26	objects-prefixes	215cabcb7f78121892a5a2037a09fedf9a1ae322	2026-04-02 13:48:28.999387
27	search-v2	859ba38092ac96eb3964d83bf53ccc0b141663a6	2026-04-02 13:48:28.99982
28	object-bucket-name-sorting	c73a2b5b5d4041e39705814fd3a1b95502d38ce4	2026-04-02 13:48:29.000222
29	create-prefixes	ad2c1207f76703d11a9f9007f821620017a66c21	2026-04-02 13:48:29.000775
30	update-object-levels	2be814ff05c8252fdfdc7cfb4b7f5c7e17f0bed6	2026-04-02 13:48:29.001228
31	objects-level-index	b40367c14c3440ec75f19bbce2d71e914ddd3da0	2026-04-02 13:48:29.001647
32	backward-compatible-index-on-objects	e0c37182b0f7aee3efd823298fb3c76f1042c0f7	2026-04-02 13:48:29.002088
33	backward-compatible-index-on-prefixes	b480e99ed951e0900f033ec4eb34b5bdcb4e3d49	2026-04-02 13:48:29.002499
34	optimize-search-function-v1	ca80a3dc7bfef894df17108785ce29a7fc8ee456	2026-04-02 13:48:29.002884
35	add-insert-trigger-prefixes	458fe0ffd07ec53f5e3ce9df51bfdf4861929ccc	2026-04-02 13:48:29.003266
36	optimise-existing-functions	6ae5fca6af5c55abe95369cd4f93985d1814ca8f	2026-04-02 13:48:29.003688
37	add-bucket-name-length-trigger	3944135b4e3e8b22d6d4cbb568fe3b0b51df15c1	2026-04-02 13:48:29.004062
38	iceberg-catalog-flag-on-buckets	02716b81ceec9705aed84aa1501657095b32e5c5	2026-04-02 13:48:29.004803
39	add-search-v2-sort-support	6706c5f2928846abee18461279799ad12b279b78	2026-04-02 13:48:29.008371
40	fix-prefix-race-conditions-optimized	7ad69982ae2d372b21f48fc4829ae9752c518f6b	2026-04-02 13:48:29.009041
41	add-object-level-update-trigger	07fcf1a22165849b7a029deed059ffcde08d1ae0	2026-04-02 13:48:29.009482
42	rollback-prefix-triggers	771479077764adc09e2ea2043eb627503c034cd4	2026-04-02 13:48:29.009861
43	fix-object-level	84b35d6caca9d937478ad8a797491f38b8c2979f	2026-04-02 13:48:29.010248
44	vector-bucket-type	99c20c0ffd52bb1ff1f32fb992f3b351e3ef8fb3	2026-04-02 13:48:29.010607
45	vector-buckets	049e27196d77a7cb76497a85afae669d8b230953	2026-04-02 13:48:29.01112
46	buckets-objects-grants	fedeb96d60fefd8e02ab3ded9fbde05632f84aed	2026-04-02 13:48:29.012421
47	iceberg-table-metadata	649df56855c24d8b36dd4cc1aeb8251aa9ad42c2	2026-04-02 13:48:29.012925
48	iceberg-catalog-ids	e0e8b460c609b9999ccd0df9ad14294613eed939	2026-04-02 13:48:29.013515
49	buckets-objects-grants-postgres	072b1195d0d5a2f888af6b2302a1938dd94b8b3d	2026-04-02 13:48:29.019225
50	search-v2-optimised	6323ac4f850aa14e7387eb32102869578b5bd478	2026-04-02 13:48:29.019762
51	index-backward-compatible-search	2ee395d433f76e38bcd3856debaf6e0e5b674011	2026-04-02 13:48:29.022589
52	drop-not-used-indexes-and-functions	bb0cbc7f2206a5a41113363dd22556cc1afd6327	2026-04-02 13:48:29.022797
53	drop-index-lower-name	d0cb18777d9e2a98ebe0bc5cc7a42e57ebe41854	2026-04-02 13:48:29.024038
54	drop-index-object-level	6289e048b1472da17c31a7eba1ded625a6457e67	2026-04-02 13:48:29.02434
55	prevent-direct-deletes	262a4798d5e0f2e7c8970232e03ce8be695d5819	2026-04-02 13:48:29.024521
\.


--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.s3_multipart_uploads (id, in_progress_size, upload_signature, bucket_id, key, version, owner_id, created_at, user_metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.s3_multipart_uploads_parts (id, upload_id, size, part_number, bucket_id, key, etag, owner_id, version, created_at) FROM stdin;
\.


--
-- Data for Name: vector_indexes; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.vector_indexes (id, name, bucket_id, data_type, dimension, distance_metric, metadata_configuration, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: hooks; Type: TABLE DATA; Schema: supabase_functions; Owner: -
--

COPY supabase_functions.hooks (id, hook_table_id, hook_name, created_at, request_id) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: supabase_functions; Owner: -
--

COPY supabase_functions.migrations (version, inserted_at) FROM stdin;
initial	2026-04-02 13:48:17.032439+00
20210809183423_update_grants	2026-04-02 13:48:17.032439+00
\.


--
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: -
--

COPY vault.secrets (id, name, description, secret, key_id, nonce, created_at, updated_at) FROM stdin;
\.


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: -
--

SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 36, true);


--
-- Name: org_org-admin-personal_asset_sequence; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."org_org-admin-personal_asset_sequence"', 1, true);


--
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: -
--

SELECT pg_catalog.setval('realtime.subscription_id_seq', 1, false);


--
-- Name: hooks_id_seq; Type: SEQUENCE SET; Schema: supabase_functions; Owner: -
--

SELECT pg_catalog.setval('supabase_functions.hooks_id_seq', 1, false);


--
-- Name: extensions extensions_pkey; Type: CONSTRAINT; Schema: _realtime; Owner: -
--

ALTER TABLE ONLY _realtime.extensions
    ADD CONSTRAINT extensions_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: _realtime; Owner: -
--

ALTER TABLE ONLY _realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: tenants tenants_pkey; Type: CONSTRAINT; Schema: _realtime; Owner: -
--

ALTER TABLE ONLY _realtime.tenants
    ADD CONSTRAINT tenants_pkey PRIMARY KEY (id);


--
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT amr_id_pk PRIMARY KEY (id);


--
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.audit_log_entries
    ADD CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id);


--
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.flow_state
    ADD CONSTRAINT flow_state_pkey PRIMARY KEY (id);


--
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- Name: identities identities_provider_id_provider_unique; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_provider_id_provider_unique UNIQUE (provider_id, provider);


--
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.instances
    ADD CONSTRAINT instances_pkey PRIMARY KEY (id);


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey UNIQUE (session_id, authentication_method);


--
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_pkey PRIMARY KEY (id);


--
-- Name: mfa_factors mfa_factors_last_challenged_at_key; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_last_challenged_at_key UNIQUE (last_challenged_at);


--
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_pkey PRIMARY KEY (id);


--
-- Name: oauth_authorizations oauth_authorizations_authorization_code_key; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_authorization_code_key UNIQUE (authorization_code);


--
-- Name: oauth_authorizations oauth_authorizations_authorization_id_key; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_authorization_id_key UNIQUE (authorization_id);


--
-- Name: oauth_authorizations oauth_authorizations_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_pkey PRIMARY KEY (id);


--
-- Name: oauth_client_states oauth_client_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.oauth_client_states
    ADD CONSTRAINT oauth_client_states_pkey PRIMARY KEY (id);


--
-- Name: oauth_clients oauth_clients_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.oauth_clients
    ADD CONSTRAINT oauth_clients_pkey PRIMARY KEY (id);


--
-- Name: oauth_consents oauth_consents_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_pkey PRIMARY KEY (id);


--
-- Name: oauth_consents oauth_consents_user_client_unique; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_user_client_unique UNIQUE (user_id, client_id);


--
-- Name: one_time_tokens one_time_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_unique UNIQUE (token);


--
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_entity_id_key UNIQUE (entity_id);


--
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_pkey PRIMARY KEY (id);


--
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_pkey PRIMARY KEY (id);


--
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.sso_providers
    ADD CONSTRAINT sso_providers_pkey PRIMARY KEY (id);


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: job job_pkey; Type: CONSTRAINT; Schema: pgboss; Owner: -
--

ALTER TABLE ONLY pgboss.job
    ADD CONSTRAINT job_pkey PRIMARY KEY (id);


--
-- Name: schedule schedule_pkey; Type: CONSTRAINT; Schema: pgboss; Owner: -
--

ALTER TABLE ONLY pgboss.schedule
    ADD CONSTRAINT schedule_pkey PRIMARY KEY (name);


--
-- Name: subscription subscription_pkey; Type: CONSTRAINT; Schema: pgboss; Owner: -
--

ALTER TABLE ONLY pgboss.subscription
    ADD CONSTRAINT subscription_pkey PRIMARY KEY (event, name);


--
-- Name: version version_pkey; Type: CONSTRAINT; Schema: pgboss; Owner: -
--

ALTER TABLE ONLY pgboss.version
    ADD CONSTRAINT version_pkey PRIMARY KEY (version);


--
-- Name: Announcement Announcement_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Announcement"
    ADD CONSTRAINT "Announcement_pkey" PRIMARY KEY (id);


--
-- Name: AssetCustomFieldValue AssetCustomFieldValue_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AssetCustomFieldValue"
    ADD CONSTRAINT "AssetCustomFieldValue_pkey" PRIMARY KEY (id);


--
-- Name: AssetFilterPreset AssetFilterPreset_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AssetFilterPreset"
    ADD CONSTRAINT "AssetFilterPreset_pkey" PRIMARY KEY (id);


--
-- Name: AssetIndexSettings AssetIndexSettings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AssetIndexSettings"
    ADD CONSTRAINT "AssetIndexSettings_pkey" PRIMARY KEY (id);


--
-- Name: AssetModel AssetModel_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AssetModel"
    ADD CONSTRAINT "AssetModel_pkey" PRIMARY KEY (id);


--
-- Name: AssetReminder AssetReminder_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AssetReminder"
    ADD CONSTRAINT "AssetReminder_pkey" PRIMARY KEY (id);


--
-- Name: Asset Asset_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Asset"
    ADD CONSTRAINT "Asset_pkey" PRIMARY KEY (id);


--
-- Name: AuditAsset AuditAsset_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AuditAsset"
    ADD CONSTRAINT "AuditAsset_pkey" PRIMARY KEY (id);


--
-- Name: AuditAssignment AuditAssignment_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AuditAssignment"
    ADD CONSTRAINT "AuditAssignment_pkey" PRIMARY KEY (id);


--
-- Name: AuditImage AuditImage_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AuditImage"
    ADD CONSTRAINT "AuditImage_pkey" PRIMARY KEY (id);


--
-- Name: AuditNote AuditNote_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AuditNote"
    ADD CONSTRAINT "AuditNote_pkey" PRIMARY KEY (id);


--
-- Name: AuditScan AuditScan_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AuditScan"
    ADD CONSTRAINT "AuditScan_pkey" PRIMARY KEY (id);


--
-- Name: AuditSession AuditSession_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AuditSession"
    ADD CONSTRAINT "AuditSession_pkey" PRIMARY KEY (id);


--
-- Name: Barcode Barcode_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Barcode"
    ADD CONSTRAINT "Barcode_pkey" PRIMARY KEY (id);


--
-- Name: BookingAsset BookingAsset_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."BookingAsset"
    ADD CONSTRAINT "BookingAsset_pkey" PRIMARY KEY (id);


--
-- Name: BookingNote BookingNote_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."BookingNote"
    ADD CONSTRAINT "BookingNote_pkey" PRIMARY KEY (id);


--
-- Name: BookingSettings BookingSettings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."BookingSettings"
    ADD CONSTRAINT "BookingSettings_pkey" PRIMARY KEY (id);


--
-- Name: Booking Booking_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Booking"
    ADD CONSTRAINT "Booking_pkey" PRIMARY KEY (id);


--
-- Name: Category Category_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Category"
    ADD CONSTRAINT "Category_pkey" PRIMARY KEY (id);


--
-- Name: ConsumptionLog ConsumptionLog_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."ConsumptionLog"
    ADD CONSTRAINT "ConsumptionLog_pkey" PRIMARY KEY (id);


--
-- Name: Custody Custody_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Custody"
    ADD CONSTRAINT "Custody_pkey" PRIMARY KEY (id);


--
-- Name: CustomField CustomField_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CustomField"
    ADD CONSTRAINT "CustomField_pkey" PRIMARY KEY (id);


--
-- Name: CustomTierLimit CustomTierLimit_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CustomTierLimit"
    ADD CONSTRAINT "CustomTierLimit_pkey" PRIMARY KEY (id);


--
-- Name: Image Image_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Image"
    ADD CONSTRAINT "Image_pkey" PRIMARY KEY (id);


--
-- Name: Invite Invite_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Invite"
    ADD CONSTRAINT "Invite_pkey" PRIMARY KEY (id);


--
-- Name: KitCustody KitCustody_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."KitCustody"
    ADD CONSTRAINT "KitCustody_pkey" PRIMARY KEY (id);


--
-- Name: Kit Kit_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Kit"
    ADD CONSTRAINT "Kit_pkey" PRIMARY KEY (id);


--
-- Name: LocationNote LocationNote_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."LocationNote"
    ADD CONSTRAINT "LocationNote_pkey" PRIMARY KEY (id);


--
-- Name: Location Location_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Location"
    ADD CONSTRAINT "Location_pkey" PRIMARY KEY (id);


--
-- Name: Note Note_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Note"
    ADD CONSTRAINT "Note_pkey" PRIMARY KEY (id);


--
-- Name: Organization Organization_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Organization"
    ADD CONSTRAINT "Organization_pkey" PRIMARY KEY (id);


--
-- Name: PartialBookingCheckin PartialBookingCheckin_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."PartialBookingCheckin"
    ADD CONSTRAINT "PartialBookingCheckin_pkey" PRIMARY KEY (id);


--
-- Name: PrintBatch PrintBatch_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."PrintBatch"
    ADD CONSTRAINT "PrintBatch_pkey" PRIMARY KEY (id);


--
-- Name: Qr Qr_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Qr"
    ADD CONSTRAINT "Qr_pkey" PRIMARY KEY (id);


--
-- Name: ReportFound ReportFound_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."ReportFound"
    ADD CONSTRAINT "ReportFound_pkey" PRIMARY KEY (id);


--
-- Name: RoleChangeLog RoleChangeLog_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."RoleChangeLog"
    ADD CONSTRAINT "RoleChangeLog_pkey" PRIMARY KEY (id);


--
-- Name: Role Role_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Role"
    ADD CONSTRAINT "Role_pkey" PRIMARY KEY (id);


--
-- Name: Scan Scan_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Scan"
    ADD CONSTRAINT "Scan_pkey" PRIMARY KEY (id);


--
-- Name: SsoDetails SsoDetails_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."SsoDetails"
    ADD CONSTRAINT "SsoDetails_pkey" PRIMARY KEY (id);


--
-- Name: Tag Tag_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Tag"
    ADD CONSTRAINT "Tag_pkey" PRIMARY KEY (id);


--
-- Name: TeamMemberNote TeamMemberNote_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."TeamMemberNote"
    ADD CONSTRAINT "TeamMemberNote_pkey" PRIMARY KEY (id);


--
-- Name: TeamMember TeamMember_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."TeamMember"
    ADD CONSTRAINT "TeamMember_pkey" PRIMARY KEY (id);


--
-- Name: TierLimit TierLimit_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."TierLimit"
    ADD CONSTRAINT "TierLimit_pkey" PRIMARY KEY (id);


--
-- Name: Tier Tier_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Tier"
    ADD CONSTRAINT "Tier_pkey" PRIMARY KEY (id);


--
-- Name: Update Update_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Update"
    ADD CONSTRAINT "Update_pkey" PRIMARY KEY (id);


--
-- Name: UserBusinessIntel UserBusinessIntel_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."UserBusinessIntel"
    ADD CONSTRAINT "UserBusinessIntel_pkey" PRIMARY KEY (id);


--
-- Name: UserContact UserContact_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."UserContact"
    ADD CONSTRAINT "UserContact_pkey" PRIMARY KEY (id);


--
-- Name: UserOrganization UserOrganization_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."UserOrganization"
    ADD CONSTRAINT "UserOrganization_pkey" PRIMARY KEY (id);


--
-- Name: UserUpdateRead UserUpdateRead_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."UserUpdateRead"
    ADD CONSTRAINT "UserUpdateRead_pkey" PRIMARY KEY (id);


--
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- Name: WorkingHoursOverride WorkingHoursOverride_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."WorkingHoursOverride"
    ADD CONSTRAINT "WorkingHoursOverride_pkey" PRIMARY KEY (id);


--
-- Name: WorkingHours WorkingHours_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."WorkingHours"
    ADD CONSTRAINT "WorkingHours_pkey" PRIMARY KEY (id);


--
-- Name: _AssetReminderToTeamMember _AssetReminderToTeamMember_AB_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."_AssetReminderToTeamMember"
    ADD CONSTRAINT "_AssetReminderToTeamMember_AB_pkey" PRIMARY KEY ("A", "B");


--
-- Name: _AssetToBooking _AssetToBooking_AB_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."_AssetToBooking"
    ADD CONSTRAINT "_AssetToBooking_AB_pkey" PRIMARY KEY ("A", "B");


--
-- Name: _AssetToTag _AssetToTag_AB_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."_AssetToTag"
    ADD CONSTRAINT "_AssetToTag_AB_pkey" PRIMARY KEY ("A", "B");


--
-- Name: _BookingNotificationRecipients _BookingNotificationRecipients_AB_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."_BookingNotificationRecipients"
    ADD CONSTRAINT "_BookingNotificationRecipients_AB_pkey" PRIMARY KEY ("A", "B");


--
-- Name: _BookingSettingsAlwaysNotify _BookingSettingsAlwaysNotify_AB_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."_BookingSettingsAlwaysNotify"
    ADD CONSTRAINT "_BookingSettingsAlwaysNotify_AB_pkey" PRIMARY KEY ("A", "B");


--
-- Name: _BookingToTag _BookingToTag_AB_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."_BookingToTag"
    ADD CONSTRAINT "_BookingToTag_AB_pkey" PRIMARY KEY ("A", "B");


--
-- Name: _CategoryToCustomField _CategoryToCustomField_AB_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."_CategoryToCustomField"
    ADD CONSTRAINT "_CategoryToCustomField_AB_pkey" PRIMARY KEY ("A", "B");


--
-- Name: _RoleToUser _RoleToUser_AB_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."_RoleToUser"
    ADD CONSTRAINT "_RoleToUser_AB_pkey" PRIMARY KEY ("A", "B");


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2026_04_01 messages_2026_04_01_pkey; Type: CONSTRAINT; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages_2026_04_01
    ADD CONSTRAINT messages_2026_04_01_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2026_04_02 messages_2026_04_02_pkey; Type: CONSTRAINT; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages_2026_04_02
    ADD CONSTRAINT messages_2026_04_02_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2026_04_03 messages_2026_04_03_pkey; Type: CONSTRAINT; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages_2026_04_03
    ADD CONSTRAINT messages_2026_04_03_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2026_04_04 messages_2026_04_04_pkey; Type: CONSTRAINT; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages_2026_04_04
    ADD CONSTRAINT messages_2026_04_04_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2026_04_05 messages_2026_04_05_pkey; Type: CONSTRAINT; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages_2026_04_05
    ADD CONSTRAINT messages_2026_04_05_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2026_04_06 messages_2026_04_06_pkey; Type: CONSTRAINT; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages_2026_04_06
    ADD CONSTRAINT messages_2026_04_06_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: subscription pk_subscription; Type: CONSTRAINT; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.subscription
    ADD CONSTRAINT pk_subscription PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: buckets_analytics buckets_analytics_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.buckets_analytics
    ADD CONSTRAINT buckets_analytics_pkey PRIMARY KEY (id);


--
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);


--
-- Name: buckets_vectors buckets_vectors_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.buckets_vectors
    ADD CONSTRAINT buckets_vectors_pkey PRIMARY KEY (id);


--
-- Name: iceberg_namespaces iceberg_namespaces_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.iceberg_namespaces
    ADD CONSTRAINT iceberg_namespaces_pkey PRIMARY KEY (id);


--
-- Name: iceberg_tables iceberg_tables_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.iceberg_tables
    ADD CONSTRAINT iceberg_tables_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_pkey PRIMARY KEY (id);


--
-- Name: vector_indexes vector_indexes_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.vector_indexes
    ADD CONSTRAINT vector_indexes_pkey PRIMARY KEY (id);


--
-- Name: hooks hooks_pkey; Type: CONSTRAINT; Schema: supabase_functions; Owner: -
--

ALTER TABLE ONLY supabase_functions.hooks
    ADD CONSTRAINT hooks_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: supabase_functions; Owner: -
--

ALTER TABLE ONLY supabase_functions.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (version);


--
-- Name: extensions_tenant_external_id_index; Type: INDEX; Schema: _realtime; Owner: -
--

CREATE INDEX extensions_tenant_external_id_index ON _realtime.extensions USING btree (tenant_external_id);


--
-- Name: extensions_tenant_external_id_type_index; Type: INDEX; Schema: _realtime; Owner: -
--

CREATE UNIQUE INDEX extensions_tenant_external_id_type_index ON _realtime.extensions USING btree (tenant_external_id, type);


--
-- Name: tenants_external_id_index; Type: INDEX; Schema: _realtime; Owner: -
--

CREATE UNIQUE INDEX tenants_external_id_index ON _realtime.tenants USING btree (external_id);


--
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX audit_logs_instance_id_idx ON auth.audit_log_entries USING btree (instance_id);


--
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);


--
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX factor_id_created_at_idx ON auth.mfa_factors USING btree (user_id, created_at);


--
-- Name: flow_state_created_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX flow_state_created_at_idx ON auth.flow_state USING btree (created_at DESC);


--
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX identities_email_idx ON auth.identities USING btree (email text_pattern_ops);


--
-- Name: INDEX identities_email_idx; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON INDEX auth.identities_email_idx IS 'Auth: Ensures indexed queries on the email column';


--
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX identities_user_id_idx ON auth.identities USING btree (user_id);


--
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);


--
-- Name: idx_oauth_client_states_created_at; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX idx_oauth_client_states_created_at ON auth.oauth_client_states USING btree (created_at);


--
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX idx_user_id_auth_method ON auth.flow_state USING btree (user_id, authentication_method);


--
-- Name: mfa_challenge_created_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX mfa_challenge_created_at_idx ON auth.mfa_challenges USING btree (created_at DESC);


--
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX mfa_factors_user_friendly_name_unique ON auth.mfa_factors USING btree (friendly_name, user_id) WHERE (TRIM(BOTH FROM friendly_name) <> ''::text);


--
-- Name: mfa_factors_user_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX mfa_factors_user_id_idx ON auth.mfa_factors USING btree (user_id);


--
-- Name: oauth_auth_pending_exp_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX oauth_auth_pending_exp_idx ON auth.oauth_authorizations USING btree (expires_at) WHERE (status = 'pending'::auth.oauth_authorization_status);


--
-- Name: oauth_clients_deleted_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX oauth_clients_deleted_at_idx ON auth.oauth_clients USING btree (deleted_at);


--
-- Name: oauth_consents_active_client_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX oauth_consents_active_client_idx ON auth.oauth_consents USING btree (client_id) WHERE (revoked_at IS NULL);


--
-- Name: oauth_consents_active_user_client_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX oauth_consents_active_user_client_idx ON auth.oauth_consents USING btree (user_id, client_id) WHERE (revoked_at IS NULL);


--
-- Name: oauth_consents_user_order_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX oauth_consents_user_order_idx ON auth.oauth_consents USING btree (user_id, granted_at DESC);


--
-- Name: one_time_tokens_relates_to_hash_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX one_time_tokens_relates_to_hash_idx ON auth.one_time_tokens USING hash (relates_to);


--
-- Name: one_time_tokens_token_hash_hash_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX one_time_tokens_token_hash_hash_idx ON auth.one_time_tokens USING hash (token_hash);


--
-- Name: one_time_tokens_user_id_token_type_key; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX one_time_tokens_user_id_token_type_key ON auth.one_time_tokens USING btree (user_id, token_type);


--
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX refresh_tokens_instance_id_idx ON auth.refresh_tokens USING btree (instance_id);


--
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX refresh_tokens_instance_id_user_id_idx ON auth.refresh_tokens USING btree (instance_id, user_id);


--
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX refresh_tokens_parent_idx ON auth.refresh_tokens USING btree (parent);


--
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX refresh_tokens_session_id_revoked_idx ON auth.refresh_tokens USING btree (session_id, revoked);


--
-- Name: refresh_tokens_updated_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX refresh_tokens_updated_at_idx ON auth.refresh_tokens USING btree (updated_at DESC);


--
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX saml_providers_sso_provider_id_idx ON auth.saml_providers USING btree (sso_provider_id);


--
-- Name: saml_relay_states_created_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX saml_relay_states_created_at_idx ON auth.saml_relay_states USING btree (created_at DESC);


--
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX saml_relay_states_for_email_idx ON auth.saml_relay_states USING btree (for_email);


--
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX saml_relay_states_sso_provider_id_idx ON auth.saml_relay_states USING btree (sso_provider_id);


--
-- Name: sessions_not_after_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX sessions_not_after_idx ON auth.sessions USING btree (not_after DESC);


--
-- Name: sessions_oauth_client_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX sessions_oauth_client_id_idx ON auth.sessions USING btree (oauth_client_id);


--
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX sessions_user_id_idx ON auth.sessions USING btree (user_id);


--
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX sso_domains_domain_idx ON auth.sso_domains USING btree (lower(domain));


--
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX sso_domains_sso_provider_id_idx ON auth.sso_domains USING btree (sso_provider_id);


--
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX sso_providers_resource_id_idx ON auth.sso_providers USING btree (lower(resource_id));


--
-- Name: sso_providers_resource_id_pattern_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX sso_providers_resource_id_pattern_idx ON auth.sso_providers USING btree (resource_id text_pattern_ops);


--
-- Name: unique_phone_factor_per_user; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX unique_phone_factor_per_user ON auth.mfa_factors USING btree (user_id, phone);


--
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX user_id_created_at_idx ON auth.sessions USING btree (user_id, created_at);


--
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);


--
-- Name: INDEX users_email_partial_key; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';


--
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));


--
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);


--
-- Name: users_is_anonymous_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX users_is_anonymous_idx ON auth.users USING btree (is_anonymous);


--
-- Name: archive_archivedon_idx; Type: INDEX; Schema: pgboss; Owner: -
--

CREATE INDEX archive_archivedon_idx ON pgboss.archive USING btree (archivedon);


--
-- Name: archive_id_idx; Type: INDEX; Schema: pgboss; Owner: -
--

CREATE INDEX archive_id_idx ON pgboss.archive USING btree (id);


--
-- Name: job_fetch; Type: INDEX; Schema: pgboss; Owner: -
--

CREATE INDEX job_fetch ON pgboss.job USING btree (name text_pattern_ops, startafter) WHERE (state < 'active'::pgboss.job_state);


--
-- Name: job_name; Type: INDEX; Schema: pgboss; Owner: -
--

CREATE INDEX job_name ON pgboss.job USING btree (name text_pattern_ops);


--
-- Name: job_singleton_queue; Type: INDEX; Schema: pgboss; Owner: -
--

CREATE UNIQUE INDEX job_singleton_queue ON pgboss.job USING btree (name, singletonkey) WHERE ((state < 'active'::pgboss.job_state) AND (singletonon IS NULL) AND (singletonkey ~~ '\_\_pgboss\_\_singleton\_queue%'::text));


--
-- Name: job_singletonkey; Type: INDEX; Schema: pgboss; Owner: -
--

CREATE UNIQUE INDEX job_singletonkey ON pgboss.job USING btree (name, singletonkey) WHERE ((state < 'completed'::pgboss.job_state) AND (singletonon IS NULL) AND (NOT (singletonkey ~~ '\_\_pgboss\_\_singleton\_queue%'::text)));


--
-- Name: job_singletonkeyon; Type: INDEX; Schema: pgboss; Owner: -
--

CREATE UNIQUE INDEX job_singletonkeyon ON pgboss.job USING btree (name, singletonon, singletonkey) WHERE (state < 'expired'::pgboss.job_state);


--
-- Name: job_singletonon; Type: INDEX; Schema: pgboss; Owner: -
--

CREATE UNIQUE INDEX job_singletonon ON pgboss.job USING btree (name, singletonon) WHERE ((state < 'expired'::pgboss.job_state) AND (singletonkey IS NULL));


--
-- Name: AssetCustomFieldValue_customFieldId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "AssetCustomFieldValue_customFieldId_idx" ON public."AssetCustomFieldValue" USING btree ("customFieldId");


--
-- Name: AssetCustomFieldValue_lookup_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "AssetCustomFieldValue_lookup_idx" ON public."AssetCustomFieldValue" USING btree ("assetId", "customFieldId");


--
-- Name: AssetIndexSettings_organizationId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "AssetIndexSettings_organizationId_idx" ON public."AssetIndexSettings" USING btree ("organizationId");


--
-- Name: AssetIndexSettings_userId_organizationId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "AssetIndexSettings_userId_organizationId_key" ON public."AssetIndexSettings" USING btree ("userId", "organizationId");


--
-- Name: AssetModel_organizationId_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "AssetModel_organizationId_name_idx" ON public."AssetModel" USING btree ("organizationId", name);


--
-- Name: AssetModel_userId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "AssetModel_userId_idx" ON public."AssetModel" USING btree ("userId");


--
-- Name: AssetReminder_alertDateTime_activeSchedulerReference_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "AssetReminder_alertDateTime_activeSchedulerReference_idx" ON public."AssetReminder" USING btree ("alertDateTime", "activeSchedulerReference");


--
-- Name: AssetReminder_assetId_alertDateTime_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "AssetReminder_assetId_alertDateTime_idx" ON public."AssetReminder" USING btree ("assetId", "alertDateTime");


--
-- Name: AssetReminder_createdById_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "AssetReminder_createdById_idx" ON public."AssetReminder" USING btree ("createdById");


--
-- Name: AssetReminder_name_message_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "AssetReminder_name_message_idx" ON public."AssetReminder" USING gin (name public.gin_trgm_ops, message public.gin_trgm_ops);


--
-- Name: AssetReminder_organizationId_alertDateTime_assetId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "AssetReminder_organizationId_alertDateTime_assetId_idx" ON public."AssetReminder" USING btree ("organizationId", "alertDateTime", "assetId");


--
-- Name: Asset_assetModelId_organizationId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Asset_assetModelId_organizationId_idx" ON public."Asset" USING btree ("assetModelId", "organizationId");


--
-- Name: Asset_categoryId_organizationId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Asset_categoryId_organizationId_idx" ON public."Asset" USING btree ("categoryId", "organizationId");


--
-- Name: Asset_createdAt_organizationId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Asset_createdAt_organizationId_idx" ON public."Asset" USING btree ("createdAt", "organizationId");


--
-- Name: Asset_kitId_organizationId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Asset_kitId_organizationId_idx" ON public."Asset" USING btree ("kitId", "organizationId");


--
-- Name: Asset_locationId_organizationId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Asset_locationId_organizationId_idx" ON public."Asset" USING btree ("locationId", "organizationId");


--
-- Name: Asset_organizationId_compound_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Asset_organizationId_compound_idx" ON public."Asset" USING btree ("organizationId", title, status, "availableToBook");


--
-- Name: Asset_organizationId_sequentialId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "Asset_organizationId_sequentialId_key" ON public."Asset" USING btree ("organizationId", "sequentialId");


--
-- Name: Asset_sequentialId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Asset_sequentialId_idx" ON public."Asset" USING btree ("sequentialId");


--
-- Name: Asset_status_organizationId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Asset_status_organizationId_idx" ON public."Asset" USING btree (status, "organizationId");


--
-- Name: Asset_title_description_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Asset_title_description_idx" ON public."Asset" USING gin (title public.gin_trgm_ops, description public.gin_trgm_ops);


--
-- Name: Asset_userId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Asset_userId_idx" ON public."Asset" USING btree ("userId");


--
-- Name: Asset_valuation_organizationId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Asset_valuation_organizationId_idx" ON public."Asset" USING btree (value, "organizationId");


--
-- Name: AuditAsset_auditSessionId_assetId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "AuditAsset_auditSessionId_assetId_key" ON public."AuditAsset" USING btree ("auditSessionId", "assetId");


--
-- Name: AuditAsset_scannedById_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "AuditAsset_scannedById_idx" ON public."AuditAsset" USING btree ("scannedById");


--
-- Name: AuditAsset_status_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "AuditAsset_status_idx" ON public."AuditAsset" USING btree (status);


--
-- Name: AuditAssignment_auditSessionId_userId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "AuditAssignment_auditSessionId_userId_key" ON public."AuditAssignment" USING btree ("auditSessionId", "userId");


--
-- Name: AuditAssignment_userId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "AuditAssignment_userId_idx" ON public."AuditAssignment" USING btree ("userId");


--
-- Name: AuditImage_auditAssetId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "AuditImage_auditAssetId_idx" ON public."AuditImage" USING btree ("auditAssetId");


--
-- Name: AuditImage_auditSessionId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "AuditImage_auditSessionId_idx" ON public."AuditImage" USING btree ("auditSessionId");


--
-- Name: AuditImage_organizationId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "AuditImage_organizationId_idx" ON public."AuditImage" USING btree ("organizationId");


--
-- Name: AuditImage_uploadedById_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "AuditImage_uploadedById_idx" ON public."AuditImage" USING btree ("uploadedById");


--
-- Name: AuditNote_auditAssetId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "AuditNote_auditAssetId_idx" ON public."AuditNote" USING btree ("auditAssetId");


--
-- Name: AuditNote_auditSessionId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "AuditNote_auditSessionId_idx" ON public."AuditNote" USING btree ("auditSessionId");


--
-- Name: AuditNote_userId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "AuditNote_userId_idx" ON public."AuditNote" USING btree ("userId");


--
-- Name: AuditScan_assetId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "AuditScan_assetId_idx" ON public."AuditScan" USING btree ("assetId");


--
-- Name: AuditScan_auditAssetId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "AuditScan_auditAssetId_idx" ON public."AuditScan" USING btree ("auditAssetId");


--
-- Name: AuditScan_auditSessionId_scannedAt_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "AuditScan_auditSessionId_scannedAt_idx" ON public."AuditScan" USING btree ("auditSessionId", "scannedAt");


--
-- Name: AuditSession_createdById_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "AuditSession_createdById_idx" ON public."AuditSession" USING btree ("createdById");


--
-- Name: AuditSession_organizationId_status_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "AuditSession_organizationId_status_idx" ON public."AuditSession" USING btree ("organizationId", status);


--
-- Name: AuditSession_status_createdAt_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "AuditSession_status_createdAt_idx" ON public."AuditSession" USING btree (status, "createdAt");


--
-- Name: Barcode_assetId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Barcode_assetId_idx" ON public."Barcode" USING btree ("assetId");


--
-- Name: Barcode_kitId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Barcode_kitId_idx" ON public."Barcode" USING btree ("kitId");


--
-- Name: Barcode_organizationId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Barcode_organizationId_idx" ON public."Barcode" USING btree ("organizationId");


--
-- Name: Barcode_organizationId_value_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Barcode_organizationId_value_idx" ON public."Barcode" USING btree ("organizationId", value);


--
-- Name: Barcode_organizationId_value_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "Barcode_organizationId_value_key" ON public."Barcode" USING btree ("organizationId", value);


--
-- Name: BookingAsset_assetId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "BookingAsset_assetId_idx" ON public."BookingAsset" USING btree ("assetId");


--
-- Name: BookingAsset_bookingId_assetId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "BookingAsset_bookingId_assetId_key" ON public."BookingAsset" USING btree ("bookingId", "assetId");


--
-- Name: BookingNote_bookingId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "BookingNote_bookingId_idx" ON public."BookingNote" USING btree ("bookingId");


--
-- Name: BookingNote_userId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "BookingNote_userId_idx" ON public."BookingNote" USING btree ("userId");


--
-- Name: BookingSettings_organizationId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "BookingSettings_organizationId_idx" ON public."BookingSettings" USING btree ("organizationId");


--
-- Name: BookingSettings_organizationId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "BookingSettings_organizationId_key" ON public."BookingSettings" USING btree ("organizationId");


--
-- Name: Booking_creatorId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Booking_creatorId_idx" ON public."Booking" USING btree ("creatorId");


--
-- Name: Booking_custodianTeamMemberId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Booking_custodianTeamMemberId_idx" ON public."Booking" USING btree ("custodianTeamMemberId");


--
-- Name: Booking_custodianUserId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Booking_custodianUserId_idx" ON public."Booking" USING btree ("custodianUserId");


--
-- Name: Booking_organizationId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Booking_organizationId_idx" ON public."Booking" USING btree ("organizationId");


--
-- Name: Category_name_organizationId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "Category_name_organizationId_key" ON public."Category" USING btree (lower(name), "organizationId");


--
-- Name: Category_organizationId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Category_organizationId_idx" ON public."Category" USING btree ("organizationId");


--
-- Name: Category_userId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Category_userId_idx" ON public."Category" USING btree ("userId");


--
-- Name: ConsumptionLog_assetId_createdAt_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ConsumptionLog_assetId_createdAt_idx" ON public."ConsumptionLog" USING btree ("assetId", "createdAt");


--
-- Name: ConsumptionLog_bookingId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ConsumptionLog_bookingId_idx" ON public."ConsumptionLog" USING btree ("bookingId");


--
-- Name: ConsumptionLog_custodianId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ConsumptionLog_custodianId_idx" ON public."ConsumptionLog" USING btree ("custodianId");


--
-- Name: ConsumptionLog_userId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ConsumptionLog_userId_idx" ON public."ConsumptionLog" USING btree ("userId");


--
-- Name: Custody_assetId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "Custody_assetId_key" ON public."Custody" USING btree ("assetId");


--
-- Name: Custody_assetId_teamMemberId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Custody_assetId_teamMemberId_idx" ON public."Custody" USING btree ("assetId", "teamMemberId");


--
-- Name: Custody_teamMemberId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Custody_teamMemberId_idx" ON public."Custody" USING btree ("teamMemberId");


--
-- Name: CustomField_name_organizationId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "CustomField_name_organizationId_key" ON public."CustomField" USING btree (lower(name), "organizationId");


--
-- Name: CustomField_organizationId_deletedAt_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "CustomField_organizationId_deletedAt_idx" ON public."CustomField" USING btree ("organizationId", "deletedAt");


--
-- Name: CustomField_organizationId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "CustomField_organizationId_idx" ON public."CustomField" USING btree ("organizationId");


--
-- Name: CustomField_userId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "CustomField_userId_idx" ON public."CustomField" USING btree ("userId");


--
-- Name: CustomTierLimit_userId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "CustomTierLimit_userId_key" ON public."CustomTierLimit" USING btree ("userId");


--
-- Name: Image_ownerOrgId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Image_ownerOrgId_idx" ON public."Image" USING btree ("ownerOrgId");


--
-- Name: Image_userId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Image_userId_idx" ON public."Image" USING btree ("userId");


--
-- Name: Invite_inviteeUserId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Invite_inviteeUserId_idx" ON public."Invite" USING btree ("inviteeUserId");


--
-- Name: Invite_inviterId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Invite_inviterId_idx" ON public."Invite" USING btree ("inviterId");


--
-- Name: Invite_organizationId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Invite_organizationId_idx" ON public."Invite" USING btree ("organizationId");


--
-- Name: Invite_teamMemberId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Invite_teamMemberId_idx" ON public."Invite" USING btree ("teamMemberId");


--
-- Name: KitCustody_custodianId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "KitCustody_custodianId_idx" ON public."KitCustody" USING btree ("custodianId");


--
-- Name: KitCustody_kitId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "KitCustody_kitId_key" ON public."KitCustody" USING btree ("kitId");


--
-- Name: Kit_categoryId_organizationId_createdAt_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Kit_categoryId_organizationId_createdAt_idx" ON public."Kit" USING btree ("categoryId", "organizationId", "createdAt");


--
-- Name: Kit_categoryId_organizationId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Kit_categoryId_organizationId_idx" ON public."Kit" USING btree ("categoryId", "organizationId");


--
-- Name: Kit_categoryId_organizationId_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Kit_categoryId_organizationId_name_idx" ON public."Kit" USING btree ("categoryId", "organizationId", name);


--
-- Name: Kit_categoryId_organizationId_status_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Kit_categoryId_organizationId_status_idx" ON public."Kit" USING btree ("categoryId", "organizationId", status);


--
-- Name: Kit_createdById_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Kit_createdById_idx" ON public."Kit" USING btree ("createdById");


--
-- Name: Kit_organizationId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Kit_organizationId_idx" ON public."Kit" USING btree ("organizationId");


--
-- Name: LocationNote_locationId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "LocationNote_locationId_idx" ON public."LocationNote" USING btree ("locationId");


--
-- Name: LocationNote_userId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "LocationNote_userId_idx" ON public."LocationNote" USING btree ("userId");


--
-- Name: Location_imageId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "Location_imageId_key" ON public."Location" USING btree ("imageId");


--
-- Name: Location_name_organizationId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "Location_name_organizationId_key" ON public."Location" USING btree (lower(name), "organizationId");


--
-- Name: Location_organizationId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Location_organizationId_idx" ON public."Location" USING btree ("organizationId");


--
-- Name: Location_organizationId_parentId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Location_organizationId_parentId_idx" ON public."Location" USING btree ("organizationId", "parentId");


--
-- Name: Location_userId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Location_userId_idx" ON public."Location" USING btree ("userId");


--
-- Name: Note_assetId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Note_assetId_idx" ON public."Note" USING btree ("assetId");


--
-- Name: Note_userId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Note_userId_idx" ON public."Note" USING btree ("userId");


--
-- Name: Organization_imageId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "Organization_imageId_key" ON public."Organization" USING btree ("imageId");


--
-- Name: Organization_ssoDetailsId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Organization_ssoDetailsId_idx" ON public."Organization" USING btree ("ssoDetailsId");


--
-- Name: Organization_userId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Organization_userId_idx" ON public."Organization" USING btree ("userId");


--
-- Name: PartialBookingCheckin_bookingId_checkinTimestamp_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "PartialBookingCheckin_bookingId_checkinTimestamp_idx" ON public."PartialBookingCheckin" USING btree ("bookingId", "checkinTimestamp");


--
-- Name: PartialBookingCheckin_bookingId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "PartialBookingCheckin_bookingId_idx" ON public."PartialBookingCheckin" USING btree ("bookingId");


--
-- Name: PartialBookingCheckin_checkedInById_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "PartialBookingCheckin_checkedInById_idx" ON public."PartialBookingCheckin" USING btree ("checkedInById");


--
-- Name: PartialBookingCheckin_checkinTimestamp_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "PartialBookingCheckin_checkinTimestamp_idx" ON public."PartialBookingCheckin" USING btree ("checkinTimestamp");


--
-- Name: PrintBatch_name_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "PrintBatch_name_key" ON public."PrintBatch" USING btree (name);


--
-- Name: Qr_assetId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Qr_assetId_idx" ON public."Qr" USING btree ("assetId");


--
-- Name: Qr_batchId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Qr_batchId_idx" ON public."Qr" USING btree ("batchId");


--
-- Name: Qr_kitId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Qr_kitId_idx" ON public."Qr" USING btree ("kitId");


--
-- Name: Qr_organizationId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Qr_organizationId_idx" ON public."Qr" USING btree ("organizationId");


--
-- Name: Qr_userId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Qr_userId_idx" ON public."Qr" USING btree ("userId");


--
-- Name: ReportFound_assetId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ReportFound_assetId_idx" ON public."ReportFound" USING btree ("assetId");


--
-- Name: ReportFound_kitId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "ReportFound_kitId_idx" ON public."ReportFound" USING btree ("kitId");


--
-- Name: RoleChangeLog_organizationId_createdAt_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "RoleChangeLog_organizationId_createdAt_idx" ON public."RoleChangeLog" USING btree ("organizationId", "createdAt");


--
-- Name: RoleChangeLog_userId_organizationId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "RoleChangeLog_userId_organizationId_idx" ON public."RoleChangeLog" USING btree ("userId", "organizationId");


--
-- Name: Role_name_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "Role_name_key" ON public."Role" USING btree (name);


--
-- Name: Scan_qrId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Scan_qrId_idx" ON public."Scan" USING btree ("qrId");


--
-- Name: Scan_userId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Scan_userId_idx" ON public."Scan" USING btree ("userId");


--
-- Name: Tag_name_organizationId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "Tag_name_organizationId_key" ON public."Tag" USING btree (lower(name), "organizationId");


--
-- Name: Tag_organizationId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Tag_organizationId_idx" ON public."Tag" USING btree ("organizationId");


--
-- Name: Tag_userId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Tag_userId_idx" ON public."Tag" USING btree ("userId");


--
-- Name: TeamMemberNote_organizationId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "TeamMemberNote_organizationId_idx" ON public."TeamMemberNote" USING btree ("organizationId");


--
-- Name: TeamMemberNote_teamMemberId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "TeamMemberNote_teamMemberId_idx" ON public."TeamMemberNote" USING btree ("teamMemberId");


--
-- Name: TeamMemberNote_teamMemberId_organizationId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "TeamMemberNote_teamMemberId_organizationId_idx" ON public."TeamMemberNote" USING btree ("teamMemberId", "organizationId");


--
-- Name: TeamMemberNote_userId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "TeamMemberNote_userId_idx" ON public."TeamMemberNote" USING btree ("userId");


--
-- Name: TeamMember_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "TeamMember_name_idx" ON public."TeamMember" USING gin (name public.gin_trgm_ops);


--
-- Name: TeamMember_organizationId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "TeamMember_organizationId_idx" ON public."TeamMember" USING btree ("organizationId");


--
-- Name: TeamMember_userId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "TeamMember_userId_idx" ON public."TeamMember" USING btree ("userId");


--
-- Name: Tier_tierLimitId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "Tier_tierLimitId_key" ON public."Tier" USING btree ("tierLimitId");


--
-- Name: Update_createdById_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Update_createdById_idx" ON public."Update" USING btree ("createdById");


--
-- Name: Update_publishDate_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Update_publishDate_idx" ON public."Update" USING btree ("publishDate");


--
-- Name: Update_status_publishDate_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Update_status_publishDate_idx" ON public."Update" USING btree (status, "publishDate");


--
-- Name: UserBusinessIntel_companyName_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "UserBusinessIntel_companyName_idx" ON public."UserBusinessIntel" USING btree ("companyName");


--
-- Name: UserBusinessIntel_jobTitle_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "UserBusinessIntel_jobTitle_idx" ON public."UserBusinessIntel" USING btree ("jobTitle");


--
-- Name: UserBusinessIntel_teamSize_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "UserBusinessIntel_teamSize_idx" ON public."UserBusinessIntel" USING btree ("teamSize");


--
-- Name: UserBusinessIntel_userId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "UserBusinessIntel_userId_idx" ON public."UserBusinessIntel" USING btree ("userId");


--
-- Name: UserBusinessIntel_userId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "UserBusinessIntel_userId_key" ON public."UserBusinessIntel" USING btree ("userId");


--
-- Name: UserContact_city_countryRegion_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "UserContact_city_countryRegion_idx" ON public."UserContact" USING btree (city, "countryRegion");


--
-- Name: UserContact_city_stateProvince_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "UserContact_city_stateProvince_idx" ON public."UserContact" USING btree (city, "stateProvince");


--
-- Name: UserContact_countryRegion_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "UserContact_countryRegion_idx" ON public."UserContact" USING btree ("countryRegion");


--
-- Name: UserContact_phone_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "UserContact_phone_idx" ON public."UserContact" USING btree (phone);


--
-- Name: UserContact_userId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "UserContact_userId_idx" ON public."UserContact" USING btree ("userId");


--
-- Name: UserContact_userId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "UserContact_userId_key" ON public."UserContact" USING btree ("userId");


--
-- Name: UserContact_zipPostalCode_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "UserContact_zipPostalCode_idx" ON public."UserContact" USING btree ("zipPostalCode");


--
-- Name: UserOrganization_organizationId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "UserOrganization_organizationId_idx" ON public."UserOrganization" USING btree ("organizationId");


--
-- Name: UserOrganization_userId_organizationId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "UserOrganization_userId_organizationId_key" ON public."UserOrganization" USING btree ("userId", "organizationId");


--
-- Name: UserUpdateRead_readAt_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "UserUpdateRead_readAt_idx" ON public."UserUpdateRead" USING btree ("readAt");


--
-- Name: UserUpdateRead_updateId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "UserUpdateRead_updateId_idx" ON public."UserUpdateRead" USING btree ("updateId");


--
-- Name: UserUpdateRead_userId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "UserUpdateRead_userId_idx" ON public."UserUpdateRead" USING btree ("userId");


--
-- Name: UserUpdateRead_userId_updateId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "UserUpdateRead_userId_updateId_key" ON public."UserUpdateRead" USING btree ("userId", "updateId");


--
-- Name: User_customerId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "User_customerId_key" ON public."User" USING btree ("customerId");


--
-- Name: User_email_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "User_email_key" ON public."User" USING btree (email);


--
-- Name: User_email_username_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "User_email_username_key" ON public."User" USING btree (email, username);


--
-- Name: User_firstName_lastName_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "User_firstName_lastName_idx" ON public."User" USING btree ("firstName", "lastName");


--
-- Name: User_lastSelectedOrganizationId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "User_lastSelectedOrganizationId_idx" ON public."User" USING btree ("lastSelectedOrganizationId");


--
-- Name: User_tierId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "User_tierId_idx" ON public."User" USING btree ("tierId");


--
-- Name: User_username_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "User_username_key" ON public."User" USING btree (username);


--
-- Name: WorkingHoursOverride_date_isOpen_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "WorkingHoursOverride_date_isOpen_idx" ON public."WorkingHoursOverride" USING btree (date, "isOpen");


--
-- Name: WorkingHoursOverride_workingHoursId_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "WorkingHoursOverride_workingHoursId_date_idx" ON public."WorkingHoursOverride" USING btree ("workingHoursId", date);


--
-- Name: WorkingHoursOverride_workingHoursId_date_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "WorkingHoursOverride_workingHoursId_date_key" ON public."WorkingHoursOverride" USING btree ("workingHoursId", date);


--
-- Name: WorkingHours_organizationId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "WorkingHours_organizationId_idx" ON public."WorkingHours" USING btree ("organizationId");


--
-- Name: WorkingHours_organizationId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "WorkingHours_organizationId_key" ON public."WorkingHours" USING btree ("organizationId");


--
-- Name: _AssetReminderToTeamMember_B_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "_AssetReminderToTeamMember_B_index" ON public."_AssetReminderToTeamMember" USING btree ("B");


--
-- Name: _AssetToBooking_B_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "_AssetToBooking_B_index" ON public."_AssetToBooking" USING btree ("B");


--
-- Name: _AssetToTag_B_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "_AssetToTag_B_index" ON public."_AssetToTag" USING btree ("B");


--
-- Name: _BookingNotificationRecipients_B_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "_BookingNotificationRecipients_B_index" ON public."_BookingNotificationRecipients" USING btree ("B");


--
-- Name: _BookingSettingsAlwaysNotify_B_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "_BookingSettingsAlwaysNotify_B_index" ON public."_BookingSettingsAlwaysNotify" USING btree ("B");


--
-- Name: _BookingToTag_B_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "_BookingToTag_B_index" ON public."_BookingToTag" USING btree ("B");


--
-- Name: _CategoryToCustomField_B_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "_CategoryToCustomField_B_index" ON public."_CategoryToCustomField" USING btree ("B");


--
-- Name: _RoleToUser_B_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "_RoleToUser_B_index" ON public."_RoleToUser" USING btree ("B");


--
-- Name: asset_filter_presets_owner_lookup_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX asset_filter_presets_owner_lookup_idx ON public."AssetFilterPreset" USING btree ("organizationId", "ownerId");


--
-- Name: asset_filter_presets_owner_name_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX asset_filter_presets_owner_name_unique ON public."AssetFilterPreset" USING btree ("organizationId", "ownerId", name);


--
-- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: -
--

CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING btree (entity);


--
-- Name: messages_inserted_at_topic_index; Type: INDEX; Schema: realtime; Owner: -
--

CREATE INDEX messages_inserted_at_topic_index ON ONLY realtime.messages USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2026_04_01_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: -
--

CREATE INDEX messages_2026_04_01_inserted_at_topic_idx ON realtime.messages_2026_04_01 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2026_04_02_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: -
--

CREATE INDEX messages_2026_04_02_inserted_at_topic_idx ON realtime.messages_2026_04_02 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2026_04_03_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: -
--

CREATE INDEX messages_2026_04_03_inserted_at_topic_idx ON realtime.messages_2026_04_03 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2026_04_04_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: -
--

CREATE INDEX messages_2026_04_04_inserted_at_topic_idx ON realtime.messages_2026_04_04 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2026_04_05_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: -
--

CREATE INDEX messages_2026_04_05_inserted_at_topic_idx ON realtime.messages_2026_04_05 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2026_04_06_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: -
--

CREATE INDEX messages_2026_04_06_inserted_at_topic_idx ON realtime.messages_2026_04_06 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: subscription_subscription_id_entity_filters_key; Type: INDEX; Schema: realtime; Owner: -
--

CREATE UNIQUE INDEX subscription_subscription_id_entity_filters_key ON realtime.subscription USING btree (subscription_id, entity, filters);


--
-- Name: bname; Type: INDEX; Schema: storage; Owner: -
--

CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);


--
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: -
--

CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);


--
-- Name: buckets_analytics_unique_name_idx; Type: INDEX; Schema: storage; Owner: -
--

CREATE UNIQUE INDEX buckets_analytics_unique_name_idx ON storage.buckets_analytics USING btree (name) WHERE (deleted_at IS NULL);


--
-- Name: idx_iceberg_namespaces_bucket_id; Type: INDEX; Schema: storage; Owner: -
--

CREATE UNIQUE INDEX idx_iceberg_namespaces_bucket_id ON storage.iceberg_namespaces USING btree (catalog_id, name);


--
-- Name: idx_iceberg_tables_location; Type: INDEX; Schema: storage; Owner: -
--

CREATE UNIQUE INDEX idx_iceberg_tables_location ON storage.iceberg_tables USING btree (location);


--
-- Name: idx_iceberg_tables_namespace_id; Type: INDEX; Schema: storage; Owner: -
--

CREATE UNIQUE INDEX idx_iceberg_tables_namespace_id ON storage.iceberg_tables USING btree (catalog_id, namespace_id, name);


--
-- Name: idx_multipart_uploads_list; Type: INDEX; Schema: storage; Owner: -
--

CREATE INDEX idx_multipart_uploads_list ON storage.s3_multipart_uploads USING btree (bucket_id, key, created_at);


--
-- Name: idx_objects_bucket_id_name; Type: INDEX; Schema: storage; Owner: -
--

CREATE INDEX idx_objects_bucket_id_name ON storage.objects USING btree (bucket_id, name COLLATE "C");


--
-- Name: idx_objects_bucket_id_name_lower; Type: INDEX; Schema: storage; Owner: -
--

CREATE INDEX idx_objects_bucket_id_name_lower ON storage.objects USING btree (bucket_id, lower(name) COLLATE "C");


--
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: -
--

CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);


--
-- Name: vector_indexes_name_bucket_id_idx; Type: INDEX; Schema: storage; Owner: -
--

CREATE UNIQUE INDEX vector_indexes_name_bucket_id_idx ON storage.vector_indexes USING btree (name, bucket_id);


--
-- Name: supabase_functions_hooks_h_table_id_h_name_idx; Type: INDEX; Schema: supabase_functions; Owner: -
--

CREATE INDEX supabase_functions_hooks_h_table_id_h_name_idx ON supabase_functions.hooks USING btree (hook_table_id, hook_name);


--
-- Name: supabase_functions_hooks_request_id_idx; Type: INDEX; Schema: supabase_functions; Owner: -
--

CREATE INDEX supabase_functions_hooks_request_id_idx ON supabase_functions.hooks USING btree (request_id);


--
-- Name: messages_2026_04_01_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: -
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_04_01_inserted_at_topic_idx;


--
-- Name: messages_2026_04_01_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: -
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_04_01_pkey;


--
-- Name: messages_2026_04_02_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: -
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_04_02_inserted_at_topic_idx;


--
-- Name: messages_2026_04_02_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: -
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_04_02_pkey;


--
-- Name: messages_2026_04_03_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: -
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_04_03_inserted_at_topic_idx;


--
-- Name: messages_2026_04_03_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: -
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_04_03_pkey;


--
-- Name: messages_2026_04_04_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: -
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_04_04_inserted_at_topic_idx;


--
-- Name: messages_2026_04_04_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: -
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_04_04_pkey;


--
-- Name: messages_2026_04_05_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: -
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_04_05_inserted_at_topic_idx;


--
-- Name: messages_2026_04_05_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: -
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_04_05_pkey;


--
-- Name: messages_2026_04_06_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: -
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_04_06_inserted_at_topic_idx;


--
-- Name: messages_2026_04_06_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: -
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_04_06_pkey;


--
-- Name: User trigger_create_user_contact; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trigger_create_user_contact AFTER INSERT ON public."User" FOR EACH ROW EXECUTE FUNCTION public.create_user_contact_on_user_insert();


--
-- Name: subscription tr_check_filters; Type: TRIGGER; Schema: realtime; Owner: -
--

CREATE TRIGGER tr_check_filters BEFORE INSERT OR UPDATE ON realtime.subscription FOR EACH ROW EXECUTE FUNCTION realtime.subscription_check_filters();


--
-- Name: buckets enforce_bucket_name_length_trigger; Type: TRIGGER; Schema: storage; Owner: -
--

CREATE TRIGGER enforce_bucket_name_length_trigger BEFORE INSERT OR UPDATE OF name ON storage.buckets FOR EACH ROW EXECUTE FUNCTION storage.enforce_bucket_name_length();


--
-- Name: buckets protect_buckets_delete; Type: TRIGGER; Schema: storage; Owner: -
--

CREATE TRIGGER protect_buckets_delete BEFORE DELETE ON storage.buckets FOR EACH STATEMENT EXECUTE FUNCTION storage.protect_delete();


--
-- Name: objects protect_objects_delete; Type: TRIGGER; Schema: storage; Owner: -
--

CREATE TRIGGER protect_objects_delete BEFORE DELETE ON storage.objects FOR EACH STATEMENT EXECUTE FUNCTION storage.protect_delete();


--
-- Name: objects update_objects_updated_at; Type: TRIGGER; Schema: storage; Owner: -
--

CREATE TRIGGER update_objects_updated_at BEFORE UPDATE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.update_updated_at_column();


--
-- Name: extensions extensions_tenant_external_id_fkey; Type: FK CONSTRAINT; Schema: _realtime; Owner: -
--

ALTER TABLE ONLY _realtime.extensions
    ADD CONSTRAINT extensions_tenant_external_id_fkey FOREIGN KEY (tenant_external_id) REFERENCES _realtime.tenants(external_id) ON DELETE CASCADE;


--
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_auth_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES auth.mfa_factors(id) ON DELETE CASCADE;


--
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: oauth_authorizations oauth_authorizations_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_client_id_fkey FOREIGN KEY (client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: oauth_authorizations oauth_authorizations_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: oauth_consents oauth_consents_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_client_id_fkey FOREIGN KEY (client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: oauth_consents oauth_consents_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: one_time_tokens one_time_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_flow_state_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_flow_state_id_fkey FOREIGN KEY (flow_state_id) REFERENCES auth.flow_state(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_oauth_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_oauth_client_id_fkey FOREIGN KEY (oauth_client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: AssetCustomFieldValue AssetCustomFieldValue_assetId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AssetCustomFieldValue"
    ADD CONSTRAINT "AssetCustomFieldValue_assetId_fkey" FOREIGN KEY ("assetId") REFERENCES public."Asset"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: AssetCustomFieldValue AssetCustomFieldValue_customFieldId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AssetCustomFieldValue"
    ADD CONSTRAINT "AssetCustomFieldValue_customFieldId_fkey" FOREIGN KEY ("customFieldId") REFERENCES public."CustomField"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: AssetFilterPreset AssetFilterPreset_organizationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AssetFilterPreset"
    ADD CONSTRAINT "AssetFilterPreset_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES public."Organization"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: AssetFilterPreset AssetFilterPreset_ownerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AssetFilterPreset"
    ADD CONSTRAINT "AssetFilterPreset_ownerId_fkey" FOREIGN KEY ("ownerId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: AssetIndexSettings AssetIndexSettings_organizationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AssetIndexSettings"
    ADD CONSTRAINT "AssetIndexSettings_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES public."Organization"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: AssetIndexSettings AssetIndexSettings_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AssetIndexSettings"
    ADD CONSTRAINT "AssetIndexSettings_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: AssetModel AssetModel_defaultCategoryId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AssetModel"
    ADD CONSTRAINT "AssetModel_defaultCategoryId_fkey" FOREIGN KEY ("defaultCategoryId") REFERENCES public."Category"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: AssetModel AssetModel_organizationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AssetModel"
    ADD CONSTRAINT "AssetModel_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES public."Organization"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: AssetModel AssetModel_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AssetModel"
    ADD CONSTRAINT "AssetModel_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: AssetReminder AssetReminder_assetId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AssetReminder"
    ADD CONSTRAINT "AssetReminder_assetId_fkey" FOREIGN KEY ("assetId") REFERENCES public."Asset"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: AssetReminder AssetReminder_createdById_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AssetReminder"
    ADD CONSTRAINT "AssetReminder_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: AssetReminder AssetReminder_organizationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AssetReminder"
    ADD CONSTRAINT "AssetReminder_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES public."Organization"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Asset Asset_assetModelId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Asset"
    ADD CONSTRAINT "Asset_assetModelId_fkey" FOREIGN KEY ("assetModelId") REFERENCES public."AssetModel"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Asset Asset_categoryId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Asset"
    ADD CONSTRAINT "Asset_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES public."Category"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Asset Asset_kitId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Asset"
    ADD CONSTRAINT "Asset_kitId_fkey" FOREIGN KEY ("kitId") REFERENCES public."Kit"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Asset Asset_locationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Asset"
    ADD CONSTRAINT "Asset_locationId_fkey" FOREIGN KEY ("locationId") REFERENCES public."Location"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Asset Asset_organizationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Asset"
    ADD CONSTRAINT "Asset_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES public."Organization"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Asset Asset_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Asset"
    ADD CONSTRAINT "Asset_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: AuditAsset AuditAsset_assetId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AuditAsset"
    ADD CONSTRAINT "AuditAsset_assetId_fkey" FOREIGN KEY ("assetId") REFERENCES public."Asset"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: AuditAsset AuditAsset_auditSessionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AuditAsset"
    ADD CONSTRAINT "AuditAsset_auditSessionId_fkey" FOREIGN KEY ("auditSessionId") REFERENCES public."AuditSession"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: AuditAsset AuditAsset_scannedById_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AuditAsset"
    ADD CONSTRAINT "AuditAsset_scannedById_fkey" FOREIGN KEY ("scannedById") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: AuditAssignment AuditAssignment_auditSessionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AuditAssignment"
    ADD CONSTRAINT "AuditAssignment_auditSessionId_fkey" FOREIGN KEY ("auditSessionId") REFERENCES public."AuditSession"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: AuditAssignment AuditAssignment_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AuditAssignment"
    ADD CONSTRAINT "AuditAssignment_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: AuditImage AuditImage_auditAssetId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AuditImage"
    ADD CONSTRAINT "AuditImage_auditAssetId_fkey" FOREIGN KEY ("auditAssetId") REFERENCES public."AuditAsset"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: AuditImage AuditImage_auditSessionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AuditImage"
    ADD CONSTRAINT "AuditImage_auditSessionId_fkey" FOREIGN KEY ("auditSessionId") REFERENCES public."AuditSession"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: AuditImage AuditImage_organizationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AuditImage"
    ADD CONSTRAINT "AuditImage_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES public."Organization"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: AuditImage AuditImage_uploadedById_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AuditImage"
    ADD CONSTRAINT "AuditImage_uploadedById_fkey" FOREIGN KEY ("uploadedById") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: AuditNote AuditNote_auditAssetId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AuditNote"
    ADD CONSTRAINT "AuditNote_auditAssetId_fkey" FOREIGN KEY ("auditAssetId") REFERENCES public."AuditAsset"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: AuditNote AuditNote_auditSessionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AuditNote"
    ADD CONSTRAINT "AuditNote_auditSessionId_fkey" FOREIGN KEY ("auditSessionId") REFERENCES public."AuditSession"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: AuditNote AuditNote_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AuditNote"
    ADD CONSTRAINT "AuditNote_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: AuditScan AuditScan_assetId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AuditScan"
    ADD CONSTRAINT "AuditScan_assetId_fkey" FOREIGN KEY ("assetId") REFERENCES public."Asset"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: AuditScan AuditScan_auditAssetId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AuditScan"
    ADD CONSTRAINT "AuditScan_auditAssetId_fkey" FOREIGN KEY ("auditAssetId") REFERENCES public."AuditAsset"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: AuditScan AuditScan_auditSessionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AuditScan"
    ADD CONSTRAINT "AuditScan_auditSessionId_fkey" FOREIGN KEY ("auditSessionId") REFERENCES public."AuditSession"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: AuditScan AuditScan_scannedById_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AuditScan"
    ADD CONSTRAINT "AuditScan_scannedById_fkey" FOREIGN KEY ("scannedById") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: AuditSession AuditSession_createdById_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AuditSession"
    ADD CONSTRAINT "AuditSession_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: AuditSession AuditSession_organizationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AuditSession"
    ADD CONSTRAINT "AuditSession_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES public."Organization"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Barcode Barcode_assetId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Barcode"
    ADD CONSTRAINT "Barcode_assetId_fkey" FOREIGN KEY ("assetId") REFERENCES public."Asset"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Barcode Barcode_kitId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Barcode"
    ADD CONSTRAINT "Barcode_kitId_fkey" FOREIGN KEY ("kitId") REFERENCES public."Kit"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Barcode Barcode_organizationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Barcode"
    ADD CONSTRAINT "Barcode_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES public."Organization"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: BookingAsset BookingAsset_assetId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."BookingAsset"
    ADD CONSTRAINT "BookingAsset_assetId_fkey" FOREIGN KEY ("assetId") REFERENCES public."Asset"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: BookingAsset BookingAsset_bookingId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."BookingAsset"
    ADD CONSTRAINT "BookingAsset_bookingId_fkey" FOREIGN KEY ("bookingId") REFERENCES public."Booking"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: BookingNote BookingNote_bookingId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."BookingNote"
    ADD CONSTRAINT "BookingNote_bookingId_fkey" FOREIGN KEY ("bookingId") REFERENCES public."Booking"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: BookingNote BookingNote_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."BookingNote"
    ADD CONSTRAINT "BookingNote_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: BookingSettings BookingSettings_organizationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."BookingSettings"
    ADD CONSTRAINT "BookingSettings_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES public."Organization"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Booking Booking_creatorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Booking"
    ADD CONSTRAINT "Booking_creatorId_fkey" FOREIGN KEY ("creatorId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Booking Booking_custodianTeamMemberId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Booking"
    ADD CONSTRAINT "Booking_custodianTeamMemberId_fkey" FOREIGN KEY ("custodianTeamMemberId") REFERENCES public."TeamMember"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Booking Booking_custodianUserId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Booking"
    ADD CONSTRAINT "Booking_custodianUserId_fkey" FOREIGN KEY ("custodianUserId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Booking Booking_organizationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Booking"
    ADD CONSTRAINT "Booking_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES public."Organization"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Category Category_organizationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Category"
    ADD CONSTRAINT "Category_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES public."Organization"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Category Category_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Category"
    ADD CONSTRAINT "Category_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: ConsumptionLog ConsumptionLog_assetId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."ConsumptionLog"
    ADD CONSTRAINT "ConsumptionLog_assetId_fkey" FOREIGN KEY ("assetId") REFERENCES public."Asset"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ConsumptionLog ConsumptionLog_bookingId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."ConsumptionLog"
    ADD CONSTRAINT "ConsumptionLog_bookingId_fkey" FOREIGN KEY ("bookingId") REFERENCES public."Booking"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: ConsumptionLog ConsumptionLog_custodianId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."ConsumptionLog"
    ADD CONSTRAINT "ConsumptionLog_custodianId_fkey" FOREIGN KEY ("custodianId") REFERENCES public."TeamMember"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: ConsumptionLog ConsumptionLog_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."ConsumptionLog"
    ADD CONSTRAINT "ConsumptionLog_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Custody Custody_assetId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Custody"
    ADD CONSTRAINT "Custody_assetId_fkey" FOREIGN KEY ("assetId") REFERENCES public."Asset"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Custody Custody_teamMemberId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Custody"
    ADD CONSTRAINT "Custody_teamMemberId_fkey" FOREIGN KEY ("teamMemberId") REFERENCES public."TeamMember"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: CustomField CustomField_organizationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CustomField"
    ADD CONSTRAINT "CustomField_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES public."Organization"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: CustomField CustomField_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CustomField"
    ADD CONSTRAINT "CustomField_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: CustomTierLimit CustomTierLimit_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CustomTierLimit"
    ADD CONSTRAINT "CustomTierLimit_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Image Image_ownerOrgId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Image"
    ADD CONSTRAINT "Image_ownerOrgId_fkey" FOREIGN KEY ("ownerOrgId") REFERENCES public."Organization"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Image Image_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Image"
    ADD CONSTRAINT "Image_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Invite Invite_inviteeUserId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Invite"
    ADD CONSTRAINT "Invite_inviteeUserId_fkey" FOREIGN KEY ("inviteeUserId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Invite Invite_inviterId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Invite"
    ADD CONSTRAINT "Invite_inviterId_fkey" FOREIGN KEY ("inviterId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Invite Invite_organizationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Invite"
    ADD CONSTRAINT "Invite_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES public."Organization"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Invite Invite_teamMemberId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Invite"
    ADD CONSTRAINT "Invite_teamMemberId_fkey" FOREIGN KEY ("teamMemberId") REFERENCES public."TeamMember"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: KitCustody KitCustody_custodianId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."KitCustody"
    ADD CONSTRAINT "KitCustody_custodianId_fkey" FOREIGN KEY ("custodianId") REFERENCES public."TeamMember"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: KitCustody KitCustody_kitId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."KitCustody"
    ADD CONSTRAINT "KitCustody_kitId_fkey" FOREIGN KEY ("kitId") REFERENCES public."Kit"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Kit Kit_categoryId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Kit"
    ADD CONSTRAINT "Kit_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES public."Category"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Kit Kit_createdById_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Kit"
    ADD CONSTRAINT "Kit_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Kit Kit_locationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Kit"
    ADD CONSTRAINT "Kit_locationId_fkey" FOREIGN KEY ("locationId") REFERENCES public."Location"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Kit Kit_organizationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Kit"
    ADD CONSTRAINT "Kit_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES public."Organization"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: LocationNote LocationNote_locationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."LocationNote"
    ADD CONSTRAINT "LocationNote_locationId_fkey" FOREIGN KEY ("locationId") REFERENCES public."Location"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: LocationNote LocationNote_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."LocationNote"
    ADD CONSTRAINT "LocationNote_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Location Location_imageId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Location"
    ADD CONSTRAINT "Location_imageId_fkey" FOREIGN KEY ("imageId") REFERENCES public."Image"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Location Location_organizationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Location"
    ADD CONSTRAINT "Location_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES public."Organization"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Location Location_parentId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Location"
    ADD CONSTRAINT "Location_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES public."Location"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Location Location_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Location"
    ADD CONSTRAINT "Location_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Note Note_assetId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Note"
    ADD CONSTRAINT "Note_assetId_fkey" FOREIGN KEY ("assetId") REFERENCES public."Asset"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Note Note_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Note"
    ADD CONSTRAINT "Note_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Organization Organization_imageId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Organization"
    ADD CONSTRAINT "Organization_imageId_fkey" FOREIGN KEY ("imageId") REFERENCES public."Image"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Organization Organization_ssoDetailsId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Organization"
    ADD CONSTRAINT "Organization_ssoDetailsId_fkey" FOREIGN KEY ("ssoDetailsId") REFERENCES public."SsoDetails"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Organization Organization_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Organization"
    ADD CONSTRAINT "Organization_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: PartialBookingCheckin PartialBookingCheckin_bookingId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."PartialBookingCheckin"
    ADD CONSTRAINT "PartialBookingCheckin_bookingId_fkey" FOREIGN KEY ("bookingId") REFERENCES public."Booking"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: PartialBookingCheckin PartialBookingCheckin_checkedInById_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."PartialBookingCheckin"
    ADD CONSTRAINT "PartialBookingCheckin_checkedInById_fkey" FOREIGN KEY ("checkedInById") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Qr Qr_assetId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Qr"
    ADD CONSTRAINT "Qr_assetId_fkey" FOREIGN KEY ("assetId") REFERENCES public."Asset"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Qr Qr_batchId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Qr"
    ADD CONSTRAINT "Qr_batchId_fkey" FOREIGN KEY ("batchId") REFERENCES public."PrintBatch"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Qr Qr_kitId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Qr"
    ADD CONSTRAINT "Qr_kitId_fkey" FOREIGN KEY ("kitId") REFERENCES public."Kit"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Qr Qr_organizationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Qr"
    ADD CONSTRAINT "Qr_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES public."Organization"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Qr Qr_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Qr"
    ADD CONSTRAINT "Qr_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: ReportFound ReportFound_assetId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."ReportFound"
    ADD CONSTRAINT "ReportFound_assetId_fkey" FOREIGN KEY ("assetId") REFERENCES public."Asset"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ReportFound ReportFound_kitId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."ReportFound"
    ADD CONSTRAINT "ReportFound_kitId_fkey" FOREIGN KEY ("kitId") REFERENCES public."Kit"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: RoleChangeLog RoleChangeLog_changedById_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."RoleChangeLog"
    ADD CONSTRAINT "RoleChangeLog_changedById_fkey" FOREIGN KEY ("changedById") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: RoleChangeLog RoleChangeLog_organizationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."RoleChangeLog"
    ADD CONSTRAINT "RoleChangeLog_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES public."Organization"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: RoleChangeLog RoleChangeLog_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."RoleChangeLog"
    ADD CONSTRAINT "RoleChangeLog_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Scan Scan_qrId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Scan"
    ADD CONSTRAINT "Scan_qrId_fkey" FOREIGN KEY ("qrId") REFERENCES public."Qr"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Scan Scan_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Scan"
    ADD CONSTRAINT "Scan_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Tag Tag_organizationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Tag"
    ADD CONSTRAINT "Tag_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES public."Organization"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Tag Tag_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Tag"
    ADD CONSTRAINT "Tag_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: TeamMemberNote TeamMemberNote_organizationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."TeamMemberNote"
    ADD CONSTRAINT "TeamMemberNote_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES public."Organization"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: TeamMemberNote TeamMemberNote_teamMemberId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."TeamMemberNote"
    ADD CONSTRAINT "TeamMemberNote_teamMemberId_fkey" FOREIGN KEY ("teamMemberId") REFERENCES public."TeamMember"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: TeamMemberNote TeamMemberNote_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."TeamMemberNote"
    ADD CONSTRAINT "TeamMemberNote_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: TeamMember TeamMember_organizationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."TeamMember"
    ADD CONSTRAINT "TeamMember_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES public."Organization"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: TeamMember TeamMember_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."TeamMember"
    ADD CONSTRAINT "TeamMember_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Tier Tier_tierLimitId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Tier"
    ADD CONSTRAINT "Tier_tierLimitId_fkey" FOREIGN KEY ("tierLimitId") REFERENCES public."TierLimit"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Update Update_createdById_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Update"
    ADD CONSTRAINT "Update_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: UserBusinessIntel UserBusinessIntel_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."UserBusinessIntel"
    ADD CONSTRAINT "UserBusinessIntel_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: UserContact UserContact_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."UserContact"
    ADD CONSTRAINT "UserContact_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: UserOrganization UserOrganization_organizationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."UserOrganization"
    ADD CONSTRAINT "UserOrganization_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES public."Organization"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: UserOrganization UserOrganization_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."UserOrganization"
    ADD CONSTRAINT "UserOrganization_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: UserUpdateRead UserUpdateRead_updateId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."UserUpdateRead"
    ADD CONSTRAINT "UserUpdateRead_updateId_fkey" FOREIGN KEY ("updateId") REFERENCES public."Update"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: UserUpdateRead UserUpdateRead_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."UserUpdateRead"
    ADD CONSTRAINT "UserUpdateRead_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: User User_lastSelectedOrganizationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_lastSelectedOrganizationId_fkey" FOREIGN KEY ("lastSelectedOrganizationId") REFERENCES public."Organization"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: User User_tierId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_tierId_fkey" FOREIGN KEY ("tierId") REFERENCES public."Tier"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: WorkingHoursOverride WorkingHoursOverride_workingHoursId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."WorkingHoursOverride"
    ADD CONSTRAINT "WorkingHoursOverride_workingHoursId_fkey" FOREIGN KEY ("workingHoursId") REFERENCES public."WorkingHours"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: WorkingHours WorkingHours_organizationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."WorkingHours"
    ADD CONSTRAINT "WorkingHours_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES public."Organization"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _AssetReminderToTeamMember _AssetReminderToTeamMember_A_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."_AssetReminderToTeamMember"
    ADD CONSTRAINT "_AssetReminderToTeamMember_A_fkey" FOREIGN KEY ("A") REFERENCES public."AssetReminder"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _AssetReminderToTeamMember _AssetReminderToTeamMember_B_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."_AssetReminderToTeamMember"
    ADD CONSTRAINT "_AssetReminderToTeamMember_B_fkey" FOREIGN KEY ("B") REFERENCES public."TeamMember"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _AssetToBooking _AssetToBooking_A_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."_AssetToBooking"
    ADD CONSTRAINT "_AssetToBooking_A_fkey" FOREIGN KEY ("A") REFERENCES public."Asset"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _AssetToBooking _AssetToBooking_B_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."_AssetToBooking"
    ADD CONSTRAINT "_AssetToBooking_B_fkey" FOREIGN KEY ("B") REFERENCES public."Booking"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _AssetToTag _AssetToTag_A_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."_AssetToTag"
    ADD CONSTRAINT "_AssetToTag_A_fkey" FOREIGN KEY ("A") REFERENCES public."Asset"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _AssetToTag _AssetToTag_B_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."_AssetToTag"
    ADD CONSTRAINT "_AssetToTag_B_fkey" FOREIGN KEY ("B") REFERENCES public."Tag"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _BookingNotificationRecipients _BookingNotificationRecipients_A_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."_BookingNotificationRecipients"
    ADD CONSTRAINT "_BookingNotificationRecipients_A_fkey" FOREIGN KEY ("A") REFERENCES public."Booking"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _BookingNotificationRecipients _BookingNotificationRecipients_B_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."_BookingNotificationRecipients"
    ADD CONSTRAINT "_BookingNotificationRecipients_B_fkey" FOREIGN KEY ("B") REFERENCES public."TeamMember"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _BookingSettingsAlwaysNotify _BookingSettingsAlwaysNotify_A_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."_BookingSettingsAlwaysNotify"
    ADD CONSTRAINT "_BookingSettingsAlwaysNotify_A_fkey" FOREIGN KEY ("A") REFERENCES public."BookingSettings"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _BookingSettingsAlwaysNotify _BookingSettingsAlwaysNotify_B_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."_BookingSettingsAlwaysNotify"
    ADD CONSTRAINT "_BookingSettingsAlwaysNotify_B_fkey" FOREIGN KEY ("B") REFERENCES public."TeamMember"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _BookingToTag _BookingToTag_A_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."_BookingToTag"
    ADD CONSTRAINT "_BookingToTag_A_fkey" FOREIGN KEY ("A") REFERENCES public."Booking"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _BookingToTag _BookingToTag_B_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."_BookingToTag"
    ADD CONSTRAINT "_BookingToTag_B_fkey" FOREIGN KEY ("B") REFERENCES public."Tag"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _CategoryToCustomField _CategoryToCustomField_A_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."_CategoryToCustomField"
    ADD CONSTRAINT "_CategoryToCustomField_A_fkey" FOREIGN KEY ("A") REFERENCES public."Category"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _CategoryToCustomField _CategoryToCustomField_B_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."_CategoryToCustomField"
    ADD CONSTRAINT "_CategoryToCustomField_B_fkey" FOREIGN KEY ("B") REFERENCES public."CustomField"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _RoleToUser _RoleToUser_A_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."_RoleToUser"
    ADD CONSTRAINT "_RoleToUser_A_fkey" FOREIGN KEY ("A") REFERENCES public."Role"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _RoleToUser _RoleToUser_B_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."_RoleToUser"
    ADD CONSTRAINT "_RoleToUser_B_fkey" FOREIGN KEY ("B") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: iceberg_namespaces iceberg_namespaces_catalog_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.iceberg_namespaces
    ADD CONSTRAINT iceberg_namespaces_catalog_id_fkey FOREIGN KEY (catalog_id) REFERENCES storage.buckets_analytics(id) ON DELETE CASCADE;


--
-- Name: iceberg_tables iceberg_tables_catalog_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.iceberg_tables
    ADD CONSTRAINT iceberg_tables_catalog_id_fkey FOREIGN KEY (catalog_id) REFERENCES storage.buckets_analytics(id) ON DELETE CASCADE;


--
-- Name: iceberg_tables iceberg_tables_namespace_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.iceberg_tables
    ADD CONSTRAINT iceberg_tables_namespace_id_fkey FOREIGN KEY (namespace_id) REFERENCES storage.iceberg_namespaces(id) ON DELETE CASCADE;


--
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES storage.s3_multipart_uploads(id) ON DELETE CASCADE;


--
-- Name: vector_indexes vector_indexes_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.vector_indexes
    ADD CONSTRAINT vector_indexes_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets_vectors(id);


--
-- Name: audit_log_entries; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.audit_log_entries ENABLE ROW LEVEL SECURITY;

--
-- Name: flow_state; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.flow_state ENABLE ROW LEVEL SECURITY;

--
-- Name: identities; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.identities ENABLE ROW LEVEL SECURITY;

--
-- Name: instances; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.instances ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_amr_claims; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.mfa_amr_claims ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_challenges; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.mfa_challenges ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_factors; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.mfa_factors ENABLE ROW LEVEL SECURITY;

--
-- Name: one_time_tokens; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.one_time_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: refresh_tokens; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.refresh_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_providers; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.saml_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_relay_states; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.saml_relay_states ENABLE ROW LEVEL SECURITY;

--
-- Name: schema_migrations; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.schema_migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: sessions; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.sessions ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_domains; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.sso_domains ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_providers; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.sso_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: users; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.users ENABLE ROW LEVEL SECURITY;

--
-- Name: Announcement; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."Announcement" ENABLE ROW LEVEL SECURITY;

--
-- Name: Asset; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."Asset" ENABLE ROW LEVEL SECURITY;

--
-- Name: AssetCustomFieldValue; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."AssetCustomFieldValue" ENABLE ROW LEVEL SECURITY;

--
-- Name: AssetFilterPreset; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."AssetFilterPreset" ENABLE ROW LEVEL SECURITY;

--
-- Name: AssetIndexSettings; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."AssetIndexSettings" ENABLE ROW LEVEL SECURITY;

--
-- Name: AssetModel; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."AssetModel" ENABLE ROW LEVEL SECURITY;

--
-- Name: AssetReminder; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."AssetReminder" ENABLE ROW LEVEL SECURITY;

--
-- Name: AuditAsset; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."AuditAsset" ENABLE ROW LEVEL SECURITY;

--
-- Name: AuditAssignment; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."AuditAssignment" ENABLE ROW LEVEL SECURITY;

--
-- Name: AuditImage; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."AuditImage" ENABLE ROW LEVEL SECURITY;

--
-- Name: AuditNote; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."AuditNote" ENABLE ROW LEVEL SECURITY;

--
-- Name: AuditScan; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."AuditScan" ENABLE ROW LEVEL SECURITY;

--
-- Name: AuditSession; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."AuditSession" ENABLE ROW LEVEL SECURITY;

--
-- Name: Barcode; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."Barcode" ENABLE ROW LEVEL SECURITY;

--
-- Name: Booking; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."Booking" ENABLE ROW LEVEL SECURITY;

--
-- Name: BookingAsset; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."BookingAsset" ENABLE ROW LEVEL SECURITY;

--
-- Name: BookingNote; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."BookingNote" ENABLE ROW LEVEL SECURITY;

--
-- Name: BookingSettings; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."BookingSettings" ENABLE ROW LEVEL SECURITY;

--
-- Name: Category; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."Category" ENABLE ROW LEVEL SECURITY;

--
-- Name: ConsumptionLog; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."ConsumptionLog" ENABLE ROW LEVEL SECURITY;

--
-- Name: Custody; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."Custody" ENABLE ROW LEVEL SECURITY;

--
-- Name: CustomField; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."CustomField" ENABLE ROW LEVEL SECURITY;

--
-- Name: CustomTierLimit; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."CustomTierLimit" ENABLE ROW LEVEL SECURITY;

--
-- Name: Image; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."Image" ENABLE ROW LEVEL SECURITY;

--
-- Name: Invite; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."Invite" ENABLE ROW LEVEL SECURITY;

--
-- Name: Kit; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."Kit" ENABLE ROW LEVEL SECURITY;

--
-- Name: KitCustody; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."KitCustody" ENABLE ROW LEVEL SECURITY;

--
-- Name: Location; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."Location" ENABLE ROW LEVEL SECURITY;

--
-- Name: LocationNote; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."LocationNote" ENABLE ROW LEVEL SECURITY;

--
-- Name: Note; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."Note" ENABLE ROW LEVEL SECURITY;

--
-- Name: Organization; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."Organization" ENABLE ROW LEVEL SECURITY;

--
-- Name: PartialBookingCheckin; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."PartialBookingCheckin" ENABLE ROW LEVEL SECURITY;

--
-- Name: PrintBatch; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."PrintBatch" ENABLE ROW LEVEL SECURITY;

--
-- Name: Qr; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."Qr" ENABLE ROW LEVEL SECURITY;

--
-- Name: ReportFound; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."ReportFound" ENABLE ROW LEVEL SECURITY;

--
-- Name: Role; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."Role" ENABLE ROW LEVEL SECURITY;

--
-- Name: RoleChangeLog; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."RoleChangeLog" ENABLE ROW LEVEL SECURITY;

--
-- Name: Scan; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."Scan" ENABLE ROW LEVEL SECURITY;

--
-- Name: SsoDetails; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."SsoDetails" ENABLE ROW LEVEL SECURITY;

--
-- Name: Tag; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."Tag" ENABLE ROW LEVEL SECURITY;

--
-- Name: TeamMember; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."TeamMember" ENABLE ROW LEVEL SECURITY;

--
-- Name: TeamMemberNote; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."TeamMemberNote" ENABLE ROW LEVEL SECURITY;

--
-- Name: Tier; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."Tier" ENABLE ROW LEVEL SECURITY;

--
-- Name: TierLimit; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."TierLimit" ENABLE ROW LEVEL SECURITY;

--
-- Name: Update; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."Update" ENABLE ROW LEVEL SECURITY;

--
-- Name: User; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."User" ENABLE ROW LEVEL SECURITY;

--
-- Name: UserBusinessIntel; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."UserBusinessIntel" ENABLE ROW LEVEL SECURITY;

--
-- Name: UserContact; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."UserContact" ENABLE ROW LEVEL SECURITY;

--
-- Name: UserOrganization; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."UserOrganization" ENABLE ROW LEVEL SECURITY;

--
-- Name: UserUpdateRead; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."UserUpdateRead" ENABLE ROW LEVEL SECURITY;

--
-- Name: WorkingHours; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."WorkingHours" ENABLE ROW LEVEL SECURITY;

--
-- Name: WorkingHoursOverride; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."WorkingHoursOverride" ENABLE ROW LEVEL SECURITY;

--
-- Name: _AssetReminderToTeamMember; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."_AssetReminderToTeamMember" ENABLE ROW LEVEL SECURITY;

--
-- Name: _AssetToBooking; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."_AssetToBooking" ENABLE ROW LEVEL SECURITY;

--
-- Name: _AssetToTag; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."_AssetToTag" ENABLE ROW LEVEL SECURITY;

--
-- Name: _BookingNotificationRecipients; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."_BookingNotificationRecipients" ENABLE ROW LEVEL SECURITY;

--
-- Name: _BookingSettingsAlwaysNotify; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."_BookingSettingsAlwaysNotify" ENABLE ROW LEVEL SECURITY;

--
-- Name: _BookingToTag; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."_BookingToTag" ENABLE ROW LEVEL SECURITY;

--
-- Name: _CategoryToCustomField; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."_CategoryToCustomField" ENABLE ROW LEVEL SECURITY;

--
-- Name: _RoleToUser; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public."_RoleToUser" ENABLE ROW LEVEL SECURITY;

--
-- Name: messages; Type: ROW SECURITY; Schema: realtime; Owner: -
--

ALTER TABLE realtime.messages ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets_analytics; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.buckets_analytics ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets_vectors; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.buckets_vectors ENABLE ROW LEVEL SECURITY;

--
-- Name: iceberg_namespaces; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.iceberg_namespaces ENABLE ROW LEVEL SECURITY;

--
-- Name: iceberg_tables; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.iceberg_tables ENABLE ROW LEVEL SECURITY;

--
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: objects; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.s3_multipart_uploads ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads_parts; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.s3_multipart_uploads_parts ENABLE ROW LEVEL SECURITY;

--
-- Name: vector_indexes; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.vector_indexes ENABLE ROW LEVEL SECURITY;

--
-- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: -
--

CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');


--
-- Name: issue_graphql_placeholder; Type: EVENT TRIGGER; Schema: -; Owner: -
--

CREATE EVENT TRIGGER issue_graphql_placeholder ON sql_drop
         WHEN TAG IN ('DROP EXTENSION')
   EXECUTE FUNCTION extensions.set_graphql_placeholder();


--
-- Name: issue_pg_cron_access; Type: EVENT TRIGGER; Schema: -; Owner: -
--

CREATE EVENT TRIGGER issue_pg_cron_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_cron_access();


--
-- Name: issue_pg_graphql_access; Type: EVENT TRIGGER; Schema: -; Owner: -
--

CREATE EVENT TRIGGER issue_pg_graphql_access ON ddl_command_end
         WHEN TAG IN ('CREATE FUNCTION')
   EXECUTE FUNCTION extensions.grant_pg_graphql_access();


--
-- Name: issue_pg_net_access; Type: EVENT TRIGGER; Schema: -; Owner: -
--

CREATE EVENT TRIGGER issue_pg_net_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_net_access();


--
-- Name: pgrst_ddl_watch; Type: EVENT TRIGGER; Schema: -; Owner: -
--

CREATE EVENT TRIGGER pgrst_ddl_watch ON ddl_command_end
   EXECUTE FUNCTION extensions.pgrst_ddl_watch();


--
-- Name: pgrst_drop_watch; Type: EVENT TRIGGER; Schema: -; Owner: -
--

CREATE EVENT TRIGGER pgrst_drop_watch ON sql_drop
   EXECUTE FUNCTION extensions.pgrst_drop_watch();


--
-- PostgreSQL database dump complete
--

\unrestrict 3hk7Jg5jgtuJUCFstuYn2s27Mcwd8FQ8HaPS2qm6jIxtxhMixiCf4t9GhX5ppPM

