--
-- PostgreSQL database dump
--

\restrict ooOVJQ9MauZvJQ45AS6Iaap1Oc1JitEOiZeh88nkiGXytukY697ckoewb90bimS

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.11 (Debian 17.11-1.pgdg12+2)

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
-- Name: auth; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA auth;


ALTER SCHEMA auth OWNER TO supabase_admin;

--
-- Name: extensions; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA extensions;


ALTER SCHEMA extensions OWNER TO postgres;

--
-- Name: graphql; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql;


ALTER SCHEMA graphql OWNER TO supabase_admin;

--
-- Name: graphql_public; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql_public;


ALTER SCHEMA graphql_public OWNER TO supabase_admin;

--
-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: pgbouncer
--

CREATE SCHEMA pgbouncer;


ALTER SCHEMA pgbouncer OWNER TO pgbouncer;

--
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA realtime;


ALTER SCHEMA realtime OWNER TO supabase_admin;

--
-- Name: storage; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA storage;


ALTER SCHEMA storage OWNER TO supabase_admin;

--
-- Name: vault; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA vault;


ALTER SCHEMA vault OWNER TO supabase_admin;

--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA extensions;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: supabase_vault; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS supabase_vault WITH SCHEMA vault;


--
-- Name: EXTENSION supabase_vault; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION supabase_vault IS 'Supabase Vault Extension';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.aal_level AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


ALTER TYPE auth.aal_level OWNER TO supabase_auth_admin;

--
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.code_challenge_method AS ENUM (
    's256',
    'plain'
);


ALTER TYPE auth.code_challenge_method OWNER TO supabase_auth_admin;

--
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_status AS ENUM (
    'unverified',
    'verified'
);


ALTER TYPE auth.factor_status OWNER TO supabase_auth_admin;

--
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_type AS ENUM (
    'totp',
    'webauthn',
    'phone'
);


ALTER TYPE auth.factor_type OWNER TO supabase_auth_admin;

--
-- Name: oauth_authorization_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_authorization_status AS ENUM (
    'pending',
    'approved',
    'denied',
    'expired'
);


ALTER TYPE auth.oauth_authorization_status OWNER TO supabase_auth_admin;

--
-- Name: oauth_client_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_client_type AS ENUM (
    'public',
    'confidential'
);


ALTER TYPE auth.oauth_client_type OWNER TO supabase_auth_admin;

--
-- Name: oauth_registration_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_registration_type AS ENUM (
    'dynamic',
    'manual'
);


ALTER TYPE auth.oauth_registration_type OWNER TO supabase_auth_admin;

--
-- Name: oauth_response_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_response_type AS ENUM (
    'code'
);


ALTER TYPE auth.oauth_response_type OWNER TO supabase_auth_admin;

--
-- Name: one_time_token_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.one_time_token_type AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);


ALTER TYPE auth.one_time_token_type OWNER TO supabase_auth_admin;

--
-- Name: action; Type: TYPE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TYPE realtime.action AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'ERROR'
);


ALTER TYPE realtime.action OWNER TO supabase_realtime_admin;

--
-- Name: equality_op; Type: TYPE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TYPE realtime.equality_op AS ENUM (
    'eq',
    'neq',
    'lt',
    'lte',
    'gt',
    'gte',
    'in',
    'like',
    'ilike',
    'is',
    'match',
    'imatch',
    'isdistinct'
);


ALTER TYPE realtime.equality_op OWNER TO supabase_realtime_admin;

--
-- Name: user_defined_filter; Type: TYPE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TYPE realtime.user_defined_filter AS (
	column_name text,
	op realtime.equality_op,
	value text,
	negate boolean
);


ALTER TYPE realtime.user_defined_filter OWNER TO supabase_realtime_admin;

--
-- Name: wal_column; Type: TYPE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TYPE realtime.wal_column AS (
	name text,
	type_name text,
	type_oid oid,
	value jsonb,
	is_pkey boolean,
	is_selectable boolean
);


ALTER TYPE realtime.wal_column OWNER TO supabase_realtime_admin;

--
-- Name: wal_rls; Type: TYPE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TYPE realtime.wal_rls AS (
	wal jsonb,
	is_rls_enabled boolean,
	subscription_ids uuid[],
	errors text[]
);


ALTER TYPE realtime.wal_rls OWNER TO supabase_realtime_admin;

--
-- Name: buckettype; Type: TYPE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TYPE storage.buckettype AS ENUM (
    'STANDARD',
    'ANALYTICS',
    'VECTOR'
);


ALTER TYPE storage.buckettype OWNER TO supabase_storage_admin;

--
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
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


ALTER FUNCTION auth.email() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION email(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.email() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';


--
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
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


ALTER FUNCTION auth.jwt() OWNER TO supabase_auth_admin;

--
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
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


ALTER FUNCTION auth.role() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION role(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.role() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';


--
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
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


ALTER FUNCTION auth.uid() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION uid(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.uid() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';


--
-- Name: grant_pg_cron_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
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


ALTER FUNCTION extensions.grant_pg_cron_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_cron_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_cron_access() IS 'Grants access to pg_cron';


--
-- Name: grant_pg_graphql_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_graphql_access() RETURNS event_trigger
    LANGUAGE plpgsql
    SET search_path TO ''
    AS $_$
begin
    if not exists (
        select 1
        from pg_catalog.pg_event_trigger_ddl_commands() ev
        join pg_catalog.pg_extension e on ev.objid = e.oid
        where e.extname = 'pg_graphql'
    ) then
        return;
    end if;

    drop function if exists graphql_public.graphql;
    create or replace function graphql_public.graphql(
        "operationName" text default null,
        query text default null,
        variables jsonb default null,
        extensions jsonb default null
    )
        returns jsonb
        language sql
        set search_path to ''
    as $$
        select graphql.resolve(
            query := query,
            variables := coalesce(variables, '{}'),
            "operationName" := "operationName",
            extensions := extensions
        );
    $$;

    -- Attach the wrapper to the extension so DROP EXTENSION cascades to it,
    -- which in turn triggers set_graphql_placeholder to reinstall the "not enabled" stub.
    alter extension pg_graphql add function graphql_public.graphql(text, text, jsonb, jsonb);

    grant usage on schema graphql to postgres, anon, authenticated, service_role;
    grant execute on function graphql.resolve to postgres, anon, authenticated, service_role;
    grant usage on schema graphql to postgres with grant option;
    grant usage on schema graphql_public to postgres with grant option;
end;
$_$;


ALTER FUNCTION extensions.grant_pg_graphql_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_graphql_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_graphql_access() IS 'Grants access to pg_graphql';


--
-- Name: grant_pg_net_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
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
    IF NOT EXISTS (
      SELECT 1
      FROM pg_roles
      WHERE rolname = 'supabase_functions_admin'
    )
    THEN
      CREATE USER supabase_functions_admin NOINHERIT CREATEROLE LOGIN NOREPLICATION;
    END IF;

    GRANT USAGE ON SCHEMA net TO supabase_functions_admin, postgres, anon, authenticated, service_role;

    IF EXISTS (
      SELECT FROM pg_extension
      WHERE extname = 'pg_net'
      -- all versions in use on existing projects as of 2025-02-20
      -- version 0.12.0 onwards don't need these applied
      AND extversion IN ('0.2', '0.6', '0.7', '0.7.1', '0.8', '0.10.0', '0.11.0')
    ) THEN
      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;

      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;

      REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
      REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;

      GRANT EXECUTE ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
      GRANT EXECUTE ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
    END IF;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_net_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_net_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_net_access() IS 'Grants access to pg_net';


--
-- Name: pgrst_ddl_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
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


ALTER FUNCTION extensions.pgrst_ddl_watch() OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
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


ALTER FUNCTION extensions.pgrst_drop_watch() OWNER TO supabase_admin;

--
-- Name: set_graphql_placeholder(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
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


ALTER FUNCTION extensions.set_graphql_placeholder() OWNER TO supabase_admin;

--
-- Name: FUNCTION set_graphql_placeholder(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.set_graphql_placeholder() IS 'Reintroduces placeholder function for graphql_public.graphql';


--
-- Name: graphql(text, text, jsonb, jsonb); Type: FUNCTION; Schema: graphql_public; Owner: supabase_admin
--

CREATE FUNCTION graphql_public.graphql("operationName" text DEFAULT NULL::text, query text DEFAULT NULL::text, variables jsonb DEFAULT NULL::jsonb, extensions jsonb DEFAULT NULL::jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
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


ALTER FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) OWNER TO supabase_admin;

--
-- Name: get_auth(text); Type: FUNCTION; Schema: pgbouncer; Owner: supabase_admin
--

CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO ''
    AS $_$
  BEGIN
      RAISE DEBUG 'PgBouncer auth request: %', p_usename;

      RETURN QUERY
      SELECT
          rolname::text,
          CASE WHEN rolvaliduntil < now()
              THEN null
              ELSE rolpassword::text
          END
      FROM pg_authid
      WHERE rolname=$1 and rolcanlogin;
  END;
  $_$;


ALTER FUNCTION pgbouncer.get_auth(p_usename text) OWNER TO supabase_admin;

--
-- Name: apply_rls(jsonb, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
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
            subs.entity = entity_
            -- Filter by action early - only get subscriptions interested in this action
            -- action_filter column can be: '*' (all), 'INSERT', 'UPDATE', or 'DELETE'
            and (subs.action_filter = '*' or subs.action_filter = action::text);

    -- Subscription vars
    working_role regrole;
    working_selected_columns text[];
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

    -- Loop record for iterating unique roles (outer loop)
    role_record record;
    -- Loop record for iterating unique selected_columns within a role (inner loop)
    cols_record record;
    -- Subscription ids visible at the role level (before fanning out by selected_columns)
    visible_role_sub_ids uuid[] = '{}';

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

    for role_record in
        select claims_role
        from (select distinct claims_role from unnest(subscriptions)) t
        order by claims_role::text
    loop
        working_role := role_record.claims_role;

        -- Update `is_selectable` for columns and old_columns (once per role)
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
            -- Fan out 400 error per distinct selected_columns for this role
            for cols_record in
                select selected_columns
                from (select distinct selected_columns from unnest(subscriptions) s where s.claims_role = working_role) t
                order by coalesce(array_to_string(selected_columns, ','), '')
            loop
                working_selected_columns := cols_record.selected_columns;
                return next (
                    jsonb_build_object(
                        'schema', wal ->> 'schema',
                        'table', wal ->> 'table',
                        'type', action
                    ),
                    is_rls_enabled,
                    (select array_agg(s.subscription_id) from unnest(subscriptions) as s where s.claims_role = working_role and (s.selected_columns is not distinct from working_selected_columns)),
                    array['Error 400: Bad Request, no primary key']
                )::realtime.wal_rls;
            end loop;

        -- The claims role does not have SELECT permission to the primary key of entity
        elsif action <> 'DELETE' and sum(c.is_selectable::int) <> count(1) from unnest(columns) c where c.is_pkey then
            -- Fan out 401 error per distinct selected_columns for this role
            for cols_record in
                select selected_columns
                from (select distinct selected_columns from unnest(subscriptions) s where s.claims_role = working_role) t
                order by coalesce(array_to_string(selected_columns, ','), '')
            loop
                working_selected_columns := cols_record.selected_columns;
                return next (
                    jsonb_build_object(
                        'schema', wal ->> 'schema',
                        'table', wal ->> 'table',
                        'type', action
                    ),
                    is_rls_enabled,
                    (select array_agg(s.subscription_id) from unnest(subscriptions) as s where s.claims_role = working_role and (s.selected_columns is not distinct from working_selected_columns)),
                    array['Error 401: Unauthorized']
                )::realtime.wal_rls;
            end loop;

        else
            -- Create the prepared statement (once per role)
            if is_rls_enabled and action <> 'DELETE' then
                if (select 1 from pg_prepared_statements where name = 'walrus_rls_stmt' limit 1) > 0 then
                    deallocate walrus_rls_stmt;
                end if;
                execute realtime.build_prepared_statement_sql('walrus_rls_stmt', entity_, columns);
            end if;

            -- Collect all visible subscription IDs for this role (filter check + RLS check)
            visible_role_sub_ids = '{}';

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
                    visible_role_sub_ids = visible_role_sub_ids || subscription_id;
                else
                    -- Check if RLS allows the role to see the record
                    perform
                        -- Trim leading and trailing quotes from working_role because set_config
                        -- doesn't recognize the role as valid if they are included
                        set_config('role', trim(both '"' from working_role::text), true),
                        set_config('request.jwt.claims', claims::text, true);

                    execute 'execute walrus_rls_stmt' into subscription_has_access;

                    -- Reset the role on every FOR..LOOP batch execution.
                    -- The first batch of 10 rows is pre-fetched using the current connection role (PG internal behaviour)
                    -- then we have to reset it again otherwise it would use the role defined in the `set_config` above
                    -- to fetch the remaining rows when rows>10, which could be a user-defined role that lacks execution grants.
                    -- The flow is:
                    --   1. run batch with conn role
                    --   2. set_config working_role
                    --   3. execute walrus
                    --   4. reset role (revert)
                    --   5. repeat
                    perform set_config('role', null, true);

                    if subscription_has_access then
                        visible_role_sub_ids = visible_role_sub_ids || subscription_id;
                    end if;
                end if;
            end loop;

            perform set_config('role', null, true);

            -- Inner loop: per distinct selected_columns for this role
            for cols_record in
                select selected_columns
                from (select distinct selected_columns from unnest(subscriptions) s where s.claims_role = working_role) t
                order by coalesce(array_to_string(selected_columns, ','), '')
            loop
                working_selected_columns := cols_record.selected_columns;

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
                            left join (
                                select unnest(conkey) as pkey_attnum
                                from pg_constraint
                                where conrelid = entity_ and contype = 'p'
                            ) pk on pk.pkey_attnum = pa.attnum
                        where
                            attrelid = entity_
                            and attnum > 0
                            and pg_catalog.has_column_privilege(working_role, entity_, pa.attname, 'SELECT')
                            and (working_selected_columns is null or pa.attname = any(working_selected_columns) or pk.pkey_attnum is not null)
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
                                    and (working_selected_columns is null or coalesce((c).name, (oc).name) = any(working_selected_columns) or coalesce((c).is_pkey, (oc).is_pkey))
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
                                        and (working_selected_columns is null or (c).name = any(working_selected_columns) or (c).is_pkey)
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
                                    and (working_selected_columns is null or (c).name = any(working_selected_columns) or (c).is_pkey)
                                    and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                                    and ( not is_rls_enabled or (c).is_pkey ) -- if RLS enabled, we can't secure deletes so filter to pkey
                            )
                        )
                    else '{}'::jsonb
                end;

                -- Filter visible_role_sub_ids to those matching the current selected_columns group
                visible_to_subscription_ids = coalesce(
                    (
                        select array_agg(s.subscription_id)
                        from unnest(subscriptions) s
                        where s.claims_role = working_role
                          and (s.selected_columns is not distinct from working_selected_columns)
                          and s.subscription_id = any(visible_role_sub_ids)
                    ),
                    '{}'::uuid[]
                );

                return next (
                    output,
                    is_rls_enabled,
                    visible_to_subscription_ids,
                    case
                        when error_record_exceeds_max_size then array['Error 413: Payload Too Large']
                        else '{}'
                    end
                )::realtime.wal_rls;
            end loop;

        end if;
    end loop;

    perform set_config('role', null, true);
end;
$$;


ALTER FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) OWNER TO supabase_realtime_admin;

--
-- Name: broadcast_changes(text, text, text, text, text, record, record, text); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
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


ALTER FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) OWNER TO supabase_realtime_admin;

--
-- Name: build_prepared_statement_sql(text, regclass, realtime.wal_column[]); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
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


ALTER FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) OWNER TO supabase_realtime_admin;

--
-- Name: cast(text, regtype); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime."cast"(val text, type_ regtype) RETURNS jsonb
    LANGUAGE plpgsql IMMUTABLE
    AS $$
declare
  res jsonb;
begin
  if type_::text = 'bytea' then
    return to_jsonb(val);
  end if;
  execute format('select to_jsonb(%L::'|| type_::text || ')', val) into res;
  return res;
end
$$;


ALTER FUNCTION realtime."cast"(val text, type_ regtype) OWNER TO supabase_realtime_admin;

--
-- Name: check_equality_op(realtime.equality_op, regtype, text, text); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
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


ALTER FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) OWNER TO supabase_realtime_admin;

--
-- Name: check_equality_op(realtime.equality_op, regtype, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text, negate boolean) RETURNS boolean
    LANGUAGE plpgsql STABLE
    AS $$
declare
    op_symbol text;
    res boolean;
begin
    -- IS DISTINCT FROM / IS NOT DISTINCT FROM: infix, both sides typed literals
    if op = 'isdistinct' then
        execute format(
            'select %L::%s %s %L::%s',
            val_1,
            type_::text,
            case when negate then 'IS NOT DISTINCT FROM' else 'IS DISTINCT FROM' end,
            val_2,
            type_::text
        ) into res;
        return res;
    end if;

    -- IS requires a keyword RHS (NULL, TRUE, FALSE, UNKNOWN), not a typed literal
    if op = 'is' then
        if val_2 not in ('null', 'true', 'false', 'unknown') then
            raise exception 'invalid value for is filter: must be null, true, false, or unknown';
        end if;
        execute format(
            'select %L::%s %s %s',
            val_1,
            type_::text,
            case when negate then 'IS NOT' else 'IS' end,
            upper(val_2)
        ) into res;
        return res;
    end if;

    op_symbol = case
        when op = 'eq'    then '='
        when op = 'neq'   then '!='
        when op = 'lt'    then '<'
        when op = 'lte'   then '<='
        when op = 'gt'    then '>'
        when op = 'gte'   then '>='
        when op = 'in'    then '= any'
        when op = 'like'   then 'LIKE'
        when op = 'ilike'  then 'ILIKE'
        when op = 'match'  then '~'
        when op = 'imatch' then '~*'
        else null
    end;

    if op_symbol is null then
        raise exception 'unsupported equality operator: %', op::text;
    end if;

    execute format(
        'select %L::%s %s (%L::%s)',
        val_1,
        type_::text,
        op_symbol,
        val_2,
        case when op = 'in' then type_::text || '[]' else type_::text end
    ) into res;

    return case when negate then not res else res end;
end;
$$;


ALTER FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text, negate boolean) OWNER TO supabase_realtime_admin;

--
-- Name: is_visible_through_filters(realtime.wal_column[], realtime.user_defined_filter[]); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) RETURNS boolean
    LANGUAGE sql STABLE
    AS $$
    select
        filters is null
        or array_length(filters, 1) is null
        or coalesce(
            count(col.name) = count(1)
            and sum(
                realtime.check_equality_op(
                    op:=f.op,
                    type_:=coalesce(col.type_oid::regtype, col.type_name::regtype),
                    val_1:=col.value #>> '{}',
                    val_2:=f.value,
                    negate:=coalesce(f.negate, false)
                )::int
            ) filter (where col.name is not null) = count(col.name),
            false
        )
    from
        unnest(filters) f
        left join unnest(columns) col
            on f.column_name = col.name;
$$;


ALTER FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) OWNER TO supabase_realtime_admin;

--
-- Name: list_changes(name, name, integer, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) RETURNS TABLE(wal jsonb, is_rls_enabled boolean, subscription_ids uuid[], errors text[], slot_changes_count bigint)
    LANGUAGE sql
    SET log_min_messages TO 'fatal'
    AS $$
  WITH pub AS (
    SELECT
      concat_ws(
        ',',
        CASE WHEN bool_or(pubinsert) THEN 'insert' ELSE NULL END,
        CASE WHEN bool_or(pubupdate) THEN 'update' ELSE NULL END,
        CASE WHEN bool_or(pubdelete) THEN 'delete' ELSE NULL END
      ) AS w2j_actions,
      coalesce(
        string_agg(
          realtime.quote_wal2json(format('%I.%I', schemaname, tablename)::regclass),
          ','
        ) filter (WHERE ppt.tablename IS NOT NULL),
        ''
      ) AS w2j_add_tables
    FROM pg_publication pp
    LEFT JOIN pg_publication_tables ppt ON pp.pubname = ppt.pubname
    WHERE pp.pubname = publication
    GROUP BY pp.pubname
    LIMIT 1
  ),
  -- MATERIALIZED ensures pg_logical_slot_get_changes is called exactly once
  w2j AS MATERIALIZED (
    SELECT x.*, pub.w2j_add_tables
    FROM pub,
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
  ),
  slot_count AS (
    SELECT count(*)::bigint AS cnt
    FROM w2j
    WHERE w2j.w2j_add_tables <> ''
  ),
  rls_filtered AS (
    SELECT xyz.wal, xyz.is_rls_enabled, xyz.subscription_ids, xyz.errors
    FROM w2j,
         realtime.apply_rls(
           wal := w2j.data::jsonb,
           max_record_bytes := max_record_bytes
         ) xyz(wal, is_rls_enabled, subscription_ids, errors)
    WHERE w2j.w2j_add_tables <> ''
      AND xyz.subscription_ids[1] IS NOT NULL
  )
  SELECT rf.wal, rf.is_rls_enabled, rf.subscription_ids, rf.errors, sc.cnt
  FROM rls_filtered rf, slot_count sc

  UNION ALL

  SELECT null, null, null, null, sc.cnt
  FROM slot_count sc
  WHERE NOT EXISTS (SELECT 1 FROM rls_filtered)
$$;


ALTER FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) OWNER TO supabase_realtime_admin;

--
-- Name: quote_wal2json(regclass); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.quote_wal2json(entity regclass) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
  SELECT
    realtime.wal2json_escape_identifier(nsp.nspname::text)
    || '.'
    || realtime.wal2json_escape_identifier(pc.relname::text)
  FROM pg_class pc
  JOIN pg_namespace nsp ON pc.relnamespace = nsp.oid
  WHERE pc.oid = entity
$$;


ALTER FUNCTION realtime.quote_wal2json(entity regclass) OWNER TO supabase_realtime_admin;

--
-- Name: send(jsonb, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean DEFAULT true) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
  generated_id uuid;
  final_payload jsonb;
BEGIN
  BEGIN
    generated_id := gen_random_uuid();

    -- Check if payload has an 'id' key, if not, add the generated UUID
    IF payload ? 'id' THEN
      final_payload := payload;
    ELSE
      final_payload := jsonb_set(payload, '{id}', to_jsonb(generated_id));
    END IF;

    -- Set the topic configuration
    EXECUTE format('SET LOCAL realtime.topic TO %L', topic);

    INSERT INTO realtime.messages (id, payload, event, topic, private, extension)
    VALUES (generated_id, final_payload, event, topic, private, 'broadcast');
  EXCEPTION
    WHEN OTHERS THEN
      RAISE WARNING 'WarnSendingBroadcastMessage: %', SQLERRM;
  END;
END;
$$;


ALTER FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) OWNER TO supabase_realtime_admin;

--
-- Name: send_binary(bytea, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.send_binary(payload bytea, event text, topic text, private boolean DEFAULT true) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
  generated_id uuid;
BEGIN
  BEGIN
    generated_id := gen_random_uuid();

    EXECUTE format('SET LOCAL realtime.topic TO %L', topic);

    INSERT INTO realtime.messages (id, binary_payload, event, topic, private, extension)
    VALUES (generated_id, payload, event, topic, private, 'broadcast');
  EXCEPTION
    WHEN OTHERS THEN
      RAISE WARNING 'WarnSendingBroadcastMessage: %', SQLERRM;
  END;
END;
$$;


ALTER FUNCTION realtime.send_binary(payload bytea, event text, topic text, private boolean) OWNER TO supabase_realtime_admin;

--
-- Name: subscription_check_filters(); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.subscription_check_filters() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare
    col_names text[] = coalesce(
            array_agg(a.attname order by a.attnum),
            '{}'::text[]
        )
        from
            pg_catalog.pg_attribute a
        where
            a.attrelid = new.entity
            and a.attnum > 0
            and not a.attisdropped
            and pg_catalog.has_column_privilege(
                (new.claims ->> 'role'),
                a.attrelid,
                a.attnum,
                'SELECT'
            );
    filter realtime.user_defined_filter;
    col_type regtype;
    in_val jsonb;
    selected_col text;
begin
    for filter in select * from unnest(new.filters) loop
        if not filter.column_name = any(col_names) then
            raise exception 'invalid column for filter %', filter.column_name;
        end if;

        col_type = (
            select atttypid::regtype
            from pg_catalog.pg_attribute
            where attrelid = new.entity
                  and attname = filter.column_name
        );
        if col_type is null then
            raise exception 'failed to lookup type for column %', filter.column_name;
        end if;

        if filter.op = 'in'::realtime.equality_op then
            in_val = realtime.cast(filter.value, (col_type::text || '[]')::regtype);
            if coalesce(jsonb_array_length(in_val), 0) > 100 then
                raise exception 'too many values for `in` filter. Maximum 100';
            end if;
        elsif filter.op = 'is'::realtime.equality_op then
            -- `is` requires a keyword RHS rather than a typed literal
            if filter.value not in ('null', 'true', 'false', 'unknown') then
                raise exception 'invalid value for is filter: must be null, true, false, or unknown';
            end if;
            -- IS NULL works for any type, but IS TRUE/FALSE/UNKNOWN require a boolean
            -- operand. Reject the non-null keywords on non-boolean columns here so they
            -- don't abort apply_rls at WAL time.
            if filter.value <> 'null' and col_type <> 'boolean'::regtype then
                raise exception 'is % filter requires a boolean column, got %', filter.value, col_type::text;
            end if;
        elsif filter.op in ('like'::realtime.equality_op, 'ilike'::realtime.equality_op) then
            -- like/ilike apply the text pattern operator (~~); reject column types that
            -- have no such operator instead of failing at WAL time
            if not exists (
                select 1 from pg_catalog.pg_operator
                where oprname = '~~' and oprleft = col_type
            ) then
                raise exception 'operator % requires a text-compatible column type, got %', filter.op::text, col_type::text;
            end if;
        elsif filter.op in ('match'::realtime.equality_op, 'imatch'::realtime.equality_op) then
            -- match/imatch apply the regex operators ~ / ~*; reject column types that have
            -- no such operator (e.g. integer) instead of failing at WAL time, mirroring the
            -- like/ilike guard above.
            if not exists (
                select 1 from pg_catalog.pg_operator
                where oprname = case when filter.op = 'imatch'::realtime.equality_op then '~*' else '~' end
                  and oprleft = col_type
                  and oprright = col_type
                  and oprresult = 'boolean'::regtype
            ) then
                raise exception 'operator % requires a text-compatible column type, got %', filter.op::text, col_type::text;
            end if;
            -- validate the regex eagerly so a bad pattern is rejected here, not inside
            -- apply_rls where it would abort the WAL stream for the entity
            begin
                perform '' ~ filter.value;
            exception when others then
                raise exception 'invalid regular expression for % filter: %', filter.op::text, sqlerrm;
            end;
        else
            -- eq/neq/lt/lte/gt/gte: value must be coercable to the type
            perform realtime.cast(filter.value, col_type);
        end if;
    end loop;

    if new.selected_columns is not null then
        for selected_col in select * from unnest(new.selected_columns) loop
            if not selected_col = any(col_names) then
                raise exception 'invalid column for select %', selected_col;
            end if;
        end loop;
    end if;

    -- Apply consistent order to filters so the unique constraint can't be tricked by a
    -- different filter order. negate is part of the sort key.
    new.filters = coalesce(
        array_agg(f order by f.column_name, f.op, f.value, f.negate),
        '{}'
    ) from unnest(new.filters) f;

    new.selected_columns = (
        select array_agg(c order by c)
        from unnest(new.selected_columns) c
    );

    return new;
end;
$$;


ALTER FUNCTION realtime.subscription_check_filters() OWNER TO supabase_realtime_admin;

--
-- Name: to_regrole(text); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.to_regrole(role_name text) RETURNS regrole
    LANGUAGE sql IMMUTABLE
    AS $$ select role_name::regrole $$;


ALTER FUNCTION realtime.to_regrole(role_name text) OWNER TO supabase_realtime_admin;

--
-- Name: topic(); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.topic() RETURNS text
    LANGUAGE sql STABLE
    AS $$
select nullif(current_setting('realtime.topic', true), '')::text;
$$;


ALTER FUNCTION realtime.topic() OWNER TO supabase_realtime_admin;

--
-- Name: wal2json_escape_identifier(text); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.wal2json_escape_identifier(name text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
  -- Prefix `\`, `,`, `.`, and any whitespace with `\`
  SELECT regexp_replace(name, '([\\,.[:space:]])', '\\\1', 'g')
$$;


ALTER FUNCTION realtime.wal2json_escape_identifier(name text) OWNER TO supabase_realtime_admin;

--
-- Name: allow_any_operation(text[]); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.allow_any_operation(expected_operations text[]) RETURNS boolean
    LANGUAGE sql STABLE
    AS $$
  WITH current_operation AS (
    SELECT storage.operation() AS raw_operation
  ),
  normalized AS (
    SELECT CASE
      WHEN raw_operation LIKE 'storage.%' THEN substr(raw_operation, 9)
      ELSE raw_operation
    END AS current_operation
    FROM current_operation
  )
  SELECT EXISTS (
    SELECT 1
    FROM normalized n
    CROSS JOIN LATERAL unnest(expected_operations) AS expected_operation
    WHERE expected_operation IS NOT NULL
      AND expected_operation <> ''
      AND n.current_operation = CASE
        WHEN expected_operation LIKE 'storage.%' THEN substr(expected_operation, 9)
        ELSE expected_operation
      END
  );
$$;


ALTER FUNCTION storage.allow_any_operation(expected_operations text[]) OWNER TO supabase_storage_admin;

--
-- Name: allow_only_operation(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.allow_only_operation(expected_operation text) RETURNS boolean
    LANGUAGE sql STABLE
    AS $$
  WITH current_operation AS (
    SELECT storage.operation() AS raw_operation
  ),
  normalized AS (
    SELECT
      CASE
        WHEN raw_operation LIKE 'storage.%' THEN substr(raw_operation, 9)
        ELSE raw_operation
      END AS current_operation,
      CASE
        WHEN expected_operation LIKE 'storage.%' THEN substr(expected_operation, 9)
        ELSE expected_operation
      END AS requested_operation
    FROM current_operation
  )
  SELECT CASE
    WHEN requested_operation IS NULL OR requested_operation = '' THEN FALSE
    ELSE COALESCE(current_operation = requested_operation, FALSE)
  END
  FROM normalized;
$$;


ALTER FUNCTION storage.allow_only_operation(expected_operation text) OWNER TO supabase_storage_admin;

--
-- Name: can_insert_object(text, text, uuid, jsonb); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
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


ALTER FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) OWNER TO supabase_storage_admin;

--
-- Name: enforce_bucket_name_length(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
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


ALTER FUNCTION storage.enforce_bucket_name_length() OWNER TO supabase_storage_admin;

--
-- Name: extension(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.extension(name text) RETURNS text
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
    _parts text[];
    _filename text;
BEGIN
    -- Split on "/" to get path segments
    SELECT string_to_array(name, '/') INTO _parts;
    -- Get the last path segment (the actual filename)
    SELECT _parts[array_length(_parts, 1)] INTO _filename;
    -- Extract extension: reverse, split on '.', then reverse again
    RETURN reverse(split_part(reverse(_filename), '.', 1));
END
$$;


ALTER FUNCTION storage.extension(name text) OWNER TO supabase_storage_admin;

--
-- Name: filename(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.filename(name text) RETURNS text
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
    _parts text[];
BEGIN
    SELECT string_to_array(name, '/') INTO _parts;
    RETURN _parts[array_length(_parts, 1)];
END
$$;


ALTER FUNCTION storage.filename(name text) OWNER TO supabase_storage_admin;

--
-- Name: foldername(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.foldername(name text) RETURNS text[]
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
    _parts text[];
BEGIN
    -- Split on "/" to get path segments
    SELECT string_to_array(name, '/') INTO _parts;
    -- Return everything except the last segment
    RETURN _parts[1 : array_length(_parts,1) - 1];
END
$$;


ALTER FUNCTION storage.foldername(name text) OWNER TO supabase_storage_admin;

--
-- Name: get_common_prefix(text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
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


ALTER FUNCTION storage.get_common_prefix(p_key text, p_prefix text, p_delimiter text) OWNER TO supabase_storage_admin;

--
-- Name: get_size_by_bucket(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_size_by_bucket() RETURNS TABLE(size bigint, bucket_id text)
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::bigint)::bigint as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;


ALTER FUNCTION storage.get_size_by_bucket() OWNER TO supabase_storage_admin;

--
-- Name: list_multipart_uploads_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
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


ALTER FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text) OWNER TO supabase_storage_admin;

--
-- Name: list_objects_with_delimiter(text, text, text, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
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


ALTER FUNCTION storage.list_objects_with_delimiter(_bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text, sort_order text) OWNER TO supabase_storage_admin;

--
-- Name: operation(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.operation() RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN current_setting('storage.operation', true);
END;
$$;


ALTER FUNCTION storage.operation() OWNER TO supabase_storage_admin;

--
-- Name: protect_delete(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
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


ALTER FUNCTION storage.protect_delete() OWNER TO supabase_storage_admin;

--
-- Name: search(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
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
    v_prefix_len INT;
    v_prefix_start INT;
    v_combined_levels INT;
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
    v_prefix_len := length(coalesce(prefix, ''));
    v_prefix_start := coalesce(array_length(string_to_array(coalesce(prefix, ''), v_delimiter), 1), 1);
    v_combined_levels := coalesce(array_length(string_to_array(v_prefix, v_delimiter), 1), 1);
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
    -- NON-NAME SORTING: Use path_tokens approach
    -- ========================================================================
    IF v_order_by != 'name' THEN
        RETURN QUERY EXECUTE format(
            $sql$
            WITH folders AS (
                SELECT array_to_string(path_tokens[$1:$2], '/') AS folder
                FROM storage.objects
                WHERE objects.name ILIKE $3 || '%%'
                  AND bucket_id = $4
                  AND array_length(objects.path_tokens, 1) <> $2
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
            (SELECT array_to_string(path_tokens[$1:$2], '/') AS "name",
                   id, updated_at, created_at, last_accessed_at, metadata
             FROM storage.objects
             WHERE objects.name ILIKE $3 || '%%'
               AND bucket_id = $4
               AND array_length(objects.path_tokens, 1) = $2
             ORDER BY %I %s)
            LIMIT $5 OFFSET $6
            $sql$, v_sort_order, v_order_by, v_sort_order
        ) USING v_prefix_start, v_combined_levels, v_prefix, bucketname, v_limit, offsets;
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
                name := substring(rtrim(storage.get_common_prefix(v_peek_name, v_prefix, v_delimiter), v_delimiter) from v_prefix_len + 1);
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
                    name := substring(v_current.name from v_prefix_len + 1);
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


ALTER FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- Name: search_by_timestamp(text, text, integer, integer, text, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_by_timestamp(p_prefix text, p_bucket_id text, p_limit integer, p_level integer, p_start_after text, p_sort_order text, p_sort_column text, p_sort_column_after text) RETURNS TABLE(key text, name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    v_cursor_op text;
    v_query text;
    v_prefix text;
    v_sort_order text;
    v_sort_column text;
BEGIN
    v_prefix := coalesce(p_prefix, '');

    -- Defense-in-depth: this function is independently reachable and must
    -- not trust p_sort_order/p_sort_column to already be validated by a
    -- caller. Normalize to the same strict allow-list storage.search_v2
    -- uses before interpolating anything into dynamic SQL below.
    v_sort_order := lower(coalesce(p_sort_order, 'asc'));
    IF v_sort_order NOT IN ('asc', 'desc') THEN
        v_sort_order := 'asc';
    END IF;

    v_sort_column := lower(coalesce(p_sort_column, 'updated_at'));
    IF v_sort_column NOT IN ('updated_at', 'created_at') THEN
        v_sort_column := 'updated_at';
    END IF;

    IF v_sort_order = 'asc' THEN
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
        v_sort_column,
        v_cursor_op,
        v_sort_column,
        v_sort_order,
        v_sort_order
    );

    RETURN QUERY EXECUTE v_query
    USING v_prefix, p_bucket_id, p_level, p_limit, p_start_after, p_sort_column_after;
END;
$_$;


ALTER FUNCTION storage.search_by_timestamp(p_prefix text, p_bucket_id text, p_limit integer, p_level integer, p_start_after text, p_sort_order text, p_sort_column text, p_sort_column_after text) OWNER TO supabase_storage_admin;

--
-- Name: search_v2(text, text, integer, integer, text, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
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


ALTER FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer, levels integer, start_after text, sort_order text, sort_column text, sort_column_after text) OWNER TO supabase_storage_admin;

--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$$;


ALTER FUNCTION storage.update_updated_at_column() OWNER TO supabase_storage_admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.audit_log_entries (
    instance_id uuid,
    id uuid NOT NULL,
    payload json,
    created_at timestamp with time zone,
    ip_address character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE auth.audit_log_entries OWNER TO supabase_auth_admin;

--
-- Name: TABLE audit_log_entries; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.audit_log_entries IS 'Auth: Audit trail for user actions.';


--
-- Name: custom_oauth_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.custom_oauth_providers (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    provider_type text NOT NULL,
    identifier text NOT NULL,
    name text NOT NULL,
    client_id text NOT NULL,
    client_secret text NOT NULL,
    acceptable_client_ids text[] DEFAULT '{}'::text[] NOT NULL,
    scopes text[] DEFAULT '{}'::text[] NOT NULL,
    pkce_enabled boolean DEFAULT true NOT NULL,
    attribute_mapping jsonb DEFAULT '{}'::jsonb NOT NULL,
    authorization_params jsonb DEFAULT '{}'::jsonb NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    email_optional boolean DEFAULT false NOT NULL,
    issuer text,
    discovery_url text,
    skip_nonce_check boolean DEFAULT false NOT NULL,
    cached_discovery jsonb,
    discovery_cached_at timestamp with time zone,
    authorization_url text,
    token_url text,
    userinfo_url text,
    jwks_uri text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    custom_claims_allowlist text[] DEFAULT '{}'::text[] NOT NULL,
    CONSTRAINT custom_oauth_providers_authorization_url_https CHECK (((authorization_url IS NULL) OR (authorization_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_authorization_url_length CHECK (((authorization_url IS NULL) OR (char_length(authorization_url) <= 2048))),
    CONSTRAINT custom_oauth_providers_client_id_length CHECK (((char_length(client_id) >= 1) AND (char_length(client_id) <= 512))),
    CONSTRAINT custom_oauth_providers_discovery_url_length CHECK (((discovery_url IS NULL) OR (char_length(discovery_url) <= 2048))),
    CONSTRAINT custom_oauth_providers_identifier_format CHECK ((identifier ~ '^[a-z0-9][a-z0-9:-]{0,48}[a-z0-9]$'::text)),
    CONSTRAINT custom_oauth_providers_issuer_length CHECK (((issuer IS NULL) OR ((char_length(issuer) >= 1) AND (char_length(issuer) <= 2048)))),
    CONSTRAINT custom_oauth_providers_jwks_uri_https CHECK (((jwks_uri IS NULL) OR (jwks_uri ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_jwks_uri_length CHECK (((jwks_uri IS NULL) OR (char_length(jwks_uri) <= 2048))),
    CONSTRAINT custom_oauth_providers_name_length CHECK (((char_length(name) >= 1) AND (char_length(name) <= 100))),
    CONSTRAINT custom_oauth_providers_oauth2_requires_endpoints CHECK (((provider_type <> 'oauth2'::text) OR ((authorization_url IS NOT NULL) AND (token_url IS NOT NULL) AND (userinfo_url IS NOT NULL)))),
    CONSTRAINT custom_oauth_providers_oidc_discovery_url_https CHECK (((provider_type <> 'oidc'::text) OR (discovery_url IS NULL) OR (discovery_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_oidc_issuer_https CHECK (((provider_type <> 'oidc'::text) OR (issuer IS NULL) OR (issuer ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_oidc_requires_issuer CHECK (((provider_type <> 'oidc'::text) OR (issuer IS NOT NULL))),
    CONSTRAINT custom_oauth_providers_provider_type_check CHECK ((provider_type = ANY (ARRAY['oauth2'::text, 'oidc'::text]))),
    CONSTRAINT custom_oauth_providers_token_url_https CHECK (((token_url IS NULL) OR (token_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_token_url_length CHECK (((token_url IS NULL) OR (char_length(token_url) <= 2048))),
    CONSTRAINT custom_oauth_providers_userinfo_url_https CHECK (((userinfo_url IS NULL) OR (userinfo_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_userinfo_url_length CHECK (((userinfo_url IS NULL) OR (char_length(userinfo_url) <= 2048)))
);


ALTER TABLE auth.custom_oauth_providers OWNER TO supabase_auth_admin;

--
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
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


ALTER TABLE auth.flow_state OWNER TO supabase_auth_admin;

--
-- Name: TABLE flow_state; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.flow_state IS 'Stores metadata for all OAuth/SSO login flows';


--
-- Name: identities; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
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


ALTER TABLE auth.identities OWNER TO supabase_auth_admin;

--
-- Name: TABLE identities; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.identities IS 'Auth: Stores identities associated to a user.';


--
-- Name: COLUMN identities.email; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.identities.email IS 'Auth: Email is a generated column that references the optional email property in the identity_data';


--
-- Name: instances; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.instances (
    id uuid NOT NULL,
    uuid uuid,
    raw_base_config text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE auth.instances OWNER TO supabase_auth_admin;

--
-- Name: TABLE instances; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.instances IS 'Auth: Manages users across multiple sites.';


--
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_amr_claims (
    session_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    authentication_method text NOT NULL,
    id uuid NOT NULL
);


ALTER TABLE auth.mfa_amr_claims OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_amr_claims; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_amr_claims IS 'auth: stores authenticator method reference claims for multi factor authentication';


--
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
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


ALTER TABLE auth.mfa_challenges OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_challenges; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_challenges IS 'auth: stores metadata about challenge requests made';


--
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
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


ALTER TABLE auth.mfa_factors OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_factors; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_factors IS 'auth: stores metadata about factors';


--
-- Name: COLUMN mfa_factors.last_webauthn_challenge_data; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.mfa_factors.last_webauthn_challenge_data IS 'Stores the latest WebAuthn challenge data including attestation/assertion for customer verification';


--
-- Name: oauth_authorizations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
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


ALTER TABLE auth.oauth_authorizations OWNER TO supabase_auth_admin;

--
-- Name: oauth_client_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_client_states (
    id uuid NOT NULL,
    provider_type text NOT NULL,
    code_verifier text,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE auth.oauth_client_states OWNER TO supabase_auth_admin;

--
-- Name: TABLE oauth_client_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.oauth_client_states IS 'Stores OAuth states for third-party provider authentication flows where Supabase acts as the OAuth client.';


--
-- Name: oauth_clients; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
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


ALTER TABLE auth.oauth_clients OWNER TO supabase_auth_admin;

--
-- Name: oauth_consents; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
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


ALTER TABLE auth.oauth_consents OWNER TO supabase_auth_admin;

--
-- Name: one_time_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
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


ALTER TABLE auth.one_time_tokens OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
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


ALTER TABLE auth.refresh_tokens OWNER TO supabase_auth_admin;

--
-- Name: TABLE refresh_tokens; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.refresh_tokens IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: supabase_auth_admin
--

CREATE SEQUENCE auth.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE auth.refresh_tokens_id_seq OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: supabase_auth_admin
--

ALTER SEQUENCE auth.refresh_tokens_id_seq OWNED BY auth.refresh_tokens.id;


--
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
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


ALTER TABLE auth.saml_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_providers IS 'Auth: Manages SAML Identity Provider connections.';


--
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
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


ALTER TABLE auth.saml_relay_states OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_relay_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_relay_states IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';


--
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE auth.schema_migrations OWNER TO supabase_auth_admin;

--
-- Name: TABLE schema_migrations; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.schema_migrations IS 'Auth: Manages updates to the auth system.';


--
-- Name: sessions; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
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


ALTER TABLE auth.sessions OWNER TO supabase_auth_admin;

--
-- Name: TABLE sessions; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sessions IS 'Auth: Stores session data associated to a user.';


--
-- Name: COLUMN sessions.not_after; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.not_after IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';


--
-- Name: COLUMN sessions.refresh_token_hmac_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.refresh_token_hmac_key IS 'Holds a HMAC-SHA256 key used to sign refresh tokens for this session.';


--
-- Name: COLUMN sessions.refresh_token_counter; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.refresh_token_counter IS 'Holds the ID (counter) of the last issued refresh token.';


--
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_domains (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    domain text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK ((char_length(domain) > 0))
);


ALTER TABLE auth.sso_domains OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_domains; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_domains IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';


--
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_providers (
    id uuid NOT NULL,
    resource_id text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    disabled boolean,
    CONSTRAINT "resource_id not empty" CHECK (((resource_id = NULL::text) OR (char_length(resource_id) > 0)))
);


ALTER TABLE auth.sso_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_providers IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';


--
-- Name: COLUMN sso_providers.resource_id; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sso_providers.resource_id IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';


--
-- Name: users; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
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


ALTER TABLE auth.users OWNER TO supabase_auth_admin;

--
-- Name: TABLE users; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';


--
-- Name: COLUMN users.is_sso_user; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';


--
-- Name: webauthn_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.webauthn_challenges (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid,
    challenge_type text NOT NULL,
    session_data jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    expires_at timestamp with time zone NOT NULL,
    CONSTRAINT webauthn_challenges_challenge_type_check CHECK ((challenge_type = ANY (ARRAY['signup'::text, 'registration'::text, 'authentication'::text])))
);


ALTER TABLE auth.webauthn_challenges OWNER TO supabase_auth_admin;

--
-- Name: webauthn_credentials; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.webauthn_credentials (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    credential_id bytea NOT NULL,
    public_key bytea NOT NULL,
    attestation_type text DEFAULT ''::text NOT NULL,
    aaguid uuid,
    sign_count bigint DEFAULT 0 NOT NULL,
    transports jsonb DEFAULT '[]'::jsonb NOT NULL,
    backup_eligible boolean DEFAULT false NOT NULL,
    backed_up boolean DEFAULT false NOT NULL,
    friendly_name text DEFAULT ''::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    last_used_at timestamp with time zone
);


ALTER TABLE auth.webauthn_credentials OWNER TO supabase_auth_admin;

--
-- Name: ai_conversations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ai_conversations (
    conversation_id integer NOT NULL,
    user_id integer NOT NULL,
    role character varying(10) NOT NULL,
    content text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT ai_conversations_role_check CHECK (((role)::text = ANY ((ARRAY['user'::character varying, 'assistant'::character varying])::text[])))
);


ALTER TABLE public.ai_conversations OWNER TO postgres;

--
-- Name: ai_conversations_conversation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ai_conversations_conversation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ai_conversations_conversation_id_seq OWNER TO postgres;

--
-- Name: ai_conversations_conversation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ai_conversations_conversation_id_seq OWNED BY public.ai_conversations.conversation_id;


--
-- Name: assignment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.assignment (
    assignment_id integer NOT NULL,
    team_id integer NOT NULL,
    cluster_id integer NOT NULL,
    status character varying(20) DEFAULT 'pending'::character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT assignment_status_check CHECK (((status)::text = ANY ((ARRAY['pending'::character varying, 'dispatched'::character varying, 'resolved'::character varying])::text[])))
);


ALTER TABLE public.assignment OWNER TO postgres;

--
-- Name: assignment_assignment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.assignment_assignment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.assignment_assignment_id_seq OWNER TO postgres;

--
-- Name: assignment_assignment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.assignment_assignment_id_seq OWNED BY public.assignment.assignment_id;


--
-- Name: cities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cities (
    city_id integer NOT NULL,
    name character varying(100) NOT NULL,
    province character varying(100),
    region character varying(100)
);


ALTER TABLE public.cities OWNER TO postgres;

--
-- Name: cities_city_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cities_city_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cities_city_id_seq OWNER TO postgres;

--
-- Name: cities_city_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cities_city_id_seq OWNED BY public.cities.city_id;


--
-- Name: clusters; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clusters (
    cluster_id integer NOT NULL,
    latitude double precision,
    longitude double precision,
    priority_level character varying(20) DEFAULT 'medium'::character varying NOT NULL,
    status character varying(20) DEFAULT 'open'::character varying NOT NULL,
    report_count integer DEFAULT 0 NOT NULL,
    people_affected integer DEFAULT 0 NOT NULL,
    ai_summary text,
    action_plan jsonb DEFAULT '[]'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    city_id integer,
    typhoon_id integer,
    ai_severity character varying(20),
    ai_disaster_type character varying(50),
    ai_analyzed_at timestamp with time zone,
    CONSTRAINT cluster_priority_check CHECK (((priority_level)::text = ANY ((ARRAY['high'::character varying, 'medium'::character varying, 'low'::character varying])::text[]))),
    CONSTRAINT cluster_status_check CHECK (((status)::text = ANY ((ARRAY['open'::character varying, 'saved'::character varying, 'resolved'::character varying])::text[])))
);


ALTER TABLE public.clusters OWNER TO postgres;

--
-- Name: cluster_cluster_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cluster_cluster_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cluster_cluster_id_seq OWNER TO postgres;

--
-- Name: cluster_cluster_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cluster_cluster_id_seq OWNED BY public.clusters.cluster_id;


--
-- Name: elevation_cache; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.elevation_cache (
    cache_key text NOT NULL,
    lat double precision NOT NULL,
    lng double precision NOT NULL,
    elevation_m double precision,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.elevation_cache OWNER TO postgres;

--
-- Name: family; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.family (
    family_id integer NOT NULL,
    name character varying(150) NOT NULL,
    created_by integer
);


ALTER TABLE public.family OWNER TO postgres;

--
-- Name: family_family_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.family_family_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.family_family_id_seq OWNER TO postgres;

--
-- Name: family_family_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.family_family_id_seq OWNED BY public.family.family_id;


--
-- Name: family_members; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.family_members (
    family_member_id integer NOT NULL,
    family_id integer NOT NULL,
    user_id integer NOT NULL,
    relation character varying(50) NOT NULL,
    status character varying(20) DEFAULT 'pending'::character varying NOT NULL,
    CONSTRAINT family_members_status_check CHECK (((status)::text = ANY (ARRAY[('pending'::character varying)::text, ('accepted'::character varying)::text, ('rejected'::character varying)::text])))
);


ALTER TABLE public.family_members OWNER TO postgres;

--
-- Name: family_members_family_member_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.family_members_family_member_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.family_members_family_member_id_seq OWNER TO postgres;

--
-- Name: family_members_family_member_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.family_members_family_member_id_seq OWNED BY public.family_members.family_member_id;


--
-- Name: images; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.images (
    image_id integer NOT NULL,
    public_url text,
    created_at timestamp with time zone DEFAULT now(),
    submitted_by integer
);


ALTER TABLE public.images OWNER TO postgres;

--
-- Name: images_image_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.images_image_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.images_image_id_seq OWNER TO postgres;

--
-- Name: images_image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.images_image_id_seq OWNED BY public.images.image_id;


--
-- Name: people; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.people (
    person_id integer NOT NULL,
    first_name character varying(100) NOT NULL,
    middle_name character varying(100),
    last_name character varying(100) NOT NULL,
    gender character varying(20),
    disabilities text[],
    age smallint,
    city character varying(100),
    barangay character varying(100),
    street character varying(150),
    address character varying(100),
    house_floors integer,
    pets text[],
    CONSTRAINT people_age_check CHECK ((age >= 0))
);


ALTER TABLE public.people OWNER TO postgres;

--
-- Name: people_person_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.people_person_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.people_person_id_seq OWNER TO postgres;

--
-- Name: people_person_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.people_person_id_seq OWNED BY public.people.person_id;


--
-- Name: report_clusters; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.report_clusters (
    report_id integer NOT NULL,
    cluster_id integer NOT NULL
);


ALTER TABLE public.report_clusters OWNER TO postgres;

--
-- Name: report_images; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.report_images (
    report_id integer NOT NULL,
    image_id integer NOT NULL
);


ALTER TABLE public.report_images OWNER TO postgres;

--
-- Name: reports; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reports (
    report_id integer NOT NULL,
    longitude numeric(9,6) NOT NULL,
    latitude numeric(9,6) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    description text,
    reported_by integer NOT NULL,
    ai_summary text,
    status character varying(10) DEFAULT 'open'::character varying,
    people_affected integer,
    ai_severity character varying(20),
    ai_disaster_type character varying(50),
    ai_people_estimate integer,
    ai_action_plan jsonb DEFAULT '[]'::jsonb,
    ai_analyzed_at timestamp with time zone,
    ai_raw_response jsonb,
    CONSTRAINT reports_status_check CHECK (((status)::text = ANY ((ARRAY['open'::character varying, 'saved'::character varying, 'resolved'::character varying])::text[])))
);


ALTER TABLE public.reports OWNER TO postgres;

--
-- Name: reports_report_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reports_report_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reports_report_id_seq OWNER TO postgres;

--
-- Name: reports_report_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reports_report_id_seq OWNED BY public.reports.report_id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    role_id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- Name: roles_role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_role_id_seq OWNER TO postgres;

--
-- Name: roles_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_role_id_seq OWNED BY public.roles.role_id;


--
-- Name: teams; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.teams (
    team_id integer NOT NULL,
    name character varying(150) NOT NULL,
    contact_number character varying(50),
    latitude double precision,
    longitude double precision,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    archived_at timestamp with time zone,
    city_id integer,
    assigned_to integer
);


ALTER TABLE public.teams OWNER TO postgres;

--
-- Name: team_team_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.team_team_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.team_team_id_seq OWNER TO postgres;

--
-- Name: team_team_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.team_team_id_seq OWNED BY public.teams.team_id;


--
-- Name: typhoon_city_signals; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.typhoon_city_signals (
    typhoon_city_signal_id integer NOT NULL,
    typhoon_id integer NOT NULL,
    city_id integer NOT NULL,
    signal_level integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT typhoon_city_signals_signal_level_check CHECK (((signal_level >= 0) AND (signal_level <= 5)))
);


ALTER TABLE public.typhoon_city_signals OWNER TO postgres;

--
-- Name: typhoon_city_signals_typhoon_city_signal_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.typhoon_city_signals_typhoon_city_signal_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.typhoon_city_signals_typhoon_city_signal_id_seq OWNER TO postgres;

--
-- Name: typhoon_city_signals_typhoon_city_signal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.typhoon_city_signals_typhoon_city_signal_id_seq OWNED BY public.typhoon_city_signals.typhoon_city_signal_id;


--
-- Name: typhoons; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.typhoons (
    typhoon_id integer NOT NULL,
    name character varying(100) NOT NULL,
    season_year integer NOT NULL,
    category character varying(20) NOT NULL,
    status character varying(20) DEFAULT 'active'::character varying NOT NULL,
    source text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT typhoons_category_check CHECK (((category)::text = ANY ((ARRAY['Tropical Depression'::character varying, 'Storm'::character varying, 'Typhoon'::character varying, 'Super Typhoon'::character varying])::text[]))),
    CONSTRAINT typhoons_status_check CHECK (((status)::text = ANY ((ARRAY['active'::character varying, 'dissipated'::character varying, 'exited_par'::character varying, 'archived'::character varying])::text[])))
);


ALTER TABLE public.typhoons OWNER TO postgres;

--
-- Name: typhoons_typhoon_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.typhoons_typhoon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.typhoons_typhoon_id_seq OWNER TO postgres;

--
-- Name: typhoons_typhoon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.typhoons_typhoon_id_seq OWNED BY public.typhoons.typhoon_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    username character varying(50),
    phone_number character varying(20),
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    archived_at timestamp with time zone,
    person_id integer,
    role_id integer NOT NULL,
    hashed_password character varying(255),
    last_seen timestamp with time zone,
    latitude numeric(9,6),
    longitude numeric(9,6)
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_user_id_seq OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: messages; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.messages (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    binary_payload bytea
)
PARTITION BY RANGE (inserted_at);


ALTER TABLE realtime.messages OWNER TO supabase_realtime_admin;

--
-- Name: schema_migrations; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone DEFAULT now()
);


ALTER TABLE realtime.schema_migrations OWNER TO supabase_admin;

--
-- Name: subscription; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.subscription (
    id bigint NOT NULL,
    subscription_id uuid NOT NULL,
    entity regclass NOT NULL,
    filters realtime.user_defined_filter[] DEFAULT '{}'::realtime.user_defined_filter[] NOT NULL,
    claims jsonb NOT NULL,
    claims_role regrole GENERATED ALWAYS AS (realtime.to_regrole((claims ->> 'role'::text))) STORED NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    action_filter text DEFAULT '*'::text,
    selected_columns text[],
    CONSTRAINT subscription_action_filter_check CHECK ((action_filter = ANY (ARRAY['*'::text, 'INSERT'::text, 'UPDATE'::text, 'DELETE'::text])))
);


ALTER TABLE realtime.subscription OWNER TO supabase_realtime_admin;

--
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: realtime; Owner: supabase_realtime_admin
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
-- Name: buckets; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
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
    type storage.buckettype DEFAULT 'STANDARD'::storage.buckettype NOT NULL,
    versioning_status text DEFAULT 'DISABLED'::text NOT NULL,
    CONSTRAINT buckets_versioning_dark_check CHECK ((versioning_status = 'DISABLED'::text)),
    CONSTRAINT buckets_versioning_standard_only_check CHECK (((type = 'STANDARD'::storage.buckettype) OR (versioning_status = 'DISABLED'::text))),
    CONSTRAINT buckets_versioning_status_check CHECK ((versioning_status = ANY (ARRAY['DISABLED'::text, 'ENABLED'::text, 'SUSPENDED'::text])))
);


ALTER TABLE storage.buckets OWNER TO supabase_storage_admin;

--
-- Name: COLUMN buckets.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: buckets_analytics; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
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


ALTER TABLE storage.buckets_analytics OWNER TO supabase_storage_admin;

--
-- Name: buckets_vectors; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets_vectors (
    id text NOT NULL,
    type storage.buckettype DEFAULT 'VECTOR'::storage.buckettype NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.buckets_vectors OWNER TO supabase_storage_admin;

--
-- Name: migrations; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.migrations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    hash character varying(40) NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE storage.migrations OWNER TO supabase_storage_admin;

--
-- Name: objects; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
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
    user_metadata jsonb,
    archived_at timestamp with time zone,
    is_delete_marker boolean DEFAULT false NOT NULL,
    is_versioned boolean DEFAULT false NOT NULL
);


ALTER TABLE storage.objects OWNER TO supabase_storage_admin;

--
-- Name: COLUMN objects.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: s3_multipart_uploads; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
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
    user_metadata jsonb,
    metadata jsonb
);


ALTER TABLE storage.s3_multipart_uploads OWNER TO supabase_storage_admin;

--
-- Name: s3_multipart_uploads_parts; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
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


ALTER TABLE storage.s3_multipart_uploads_parts OWNER TO supabase_storage_admin;

--
-- Name: vector_indexes; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
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


ALTER TABLE storage.vector_indexes OWNER TO supabase_storage_admin;

--
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);


--
-- Name: ai_conversations conversation_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ai_conversations ALTER COLUMN conversation_id SET DEFAULT nextval('public.ai_conversations_conversation_id_seq'::regclass);


--
-- Name: assignment assignment_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assignment ALTER COLUMN assignment_id SET DEFAULT nextval('public.assignment_assignment_id_seq'::regclass);


--
-- Name: cities city_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cities ALTER COLUMN city_id SET DEFAULT nextval('public.cities_city_id_seq'::regclass);


--
-- Name: clusters cluster_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clusters ALTER COLUMN cluster_id SET DEFAULT nextval('public.cluster_cluster_id_seq'::regclass);


--
-- Name: family family_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.family ALTER COLUMN family_id SET DEFAULT nextval('public.family_family_id_seq'::regclass);


--
-- Name: family_members family_member_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.family_members ALTER COLUMN family_member_id SET DEFAULT nextval('public.family_members_family_member_id_seq'::regclass);


--
-- Name: images image_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.images ALTER COLUMN image_id SET DEFAULT nextval('public.images_image_id_seq'::regclass);


--
-- Name: people person_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.people ALTER COLUMN person_id SET DEFAULT nextval('public.people_person_id_seq'::regclass);


--
-- Name: reports report_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reports ALTER COLUMN report_id SET DEFAULT nextval('public.reports_report_id_seq'::regclass);


--
-- Name: roles role_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN role_id SET DEFAULT nextval('public.roles_role_id_seq'::regclass);


--
-- Name: teams team_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teams ALTER COLUMN team_id SET DEFAULT nextval('public.team_team_id_seq'::regclass);


--
-- Name: typhoon_city_signals typhoon_city_signal_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.typhoon_city_signals ALTER COLUMN typhoon_city_signal_id SET DEFAULT nextval('public.typhoon_city_signals_typhoon_city_signal_id_seq'::regclass);


--
-- Name: typhoons typhoon_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.typhoons ALTER COLUMN typhoon_id SET DEFAULT nextval('public.typhoons_typhoon_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) FROM stdin;
\.


--
-- Data for Name: custom_oauth_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.custom_oauth_providers (id, provider_type, identifier, name, client_id, client_secret, acceptable_client_ids, scopes, pkce_enabled, attribute_mapping, authorization_params, enabled, email_optional, issuer, discovery_url, skip_nonce_check, cached_discovery, discovery_cached_at, authorization_url, token_url, userinfo_url, jwks_uri, created_at, updated_at, custom_claims_allowlist) FROM stdin;
\.


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.flow_state (id, user_id, auth_code, code_challenge_method, code_challenge, provider_type, provider_access_token, provider_refresh_token, created_at, updated_at, authentication_method, auth_code_issued_at, invite_token, referrer, oauth_client_state_id, linking_target_id, email_optional) FROM stdin;
\.


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) FROM stdin;
\.


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.instances (id, uuid, raw_base_config, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_amr_claims (session_id, created_at, updated_at, authentication_method, id) FROM stdin;
\.


--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_challenges (id, factor_id, created_at, verified_at, ip_address, otp_code, web_authn_session_data) FROM stdin;
\.


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_factors (id, user_id, friendly_name, factor_type, status, created_at, updated_at, secret, phone, last_challenged_at, web_authn_credential, web_authn_aaguid, last_webauthn_challenge_data) FROM stdin;
\.


--
-- Data for Name: oauth_authorizations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_authorizations (id, authorization_id, client_id, user_id, redirect_uri, scope, state, resource, code_challenge, code_challenge_method, response_type, status, authorization_code, created_at, expires_at, approved_at, nonce) FROM stdin;
\.


--
-- Data for Name: oauth_client_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_client_states (id, provider_type, code_verifier, created_at) FROM stdin;
\.


--
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_clients (id, client_secret_hash, registration_type, redirect_uris, grant_types, client_name, client_uri, logo_uri, created_at, updated_at, deleted_at, client_type, token_endpoint_auth_method) FROM stdin;
\.


--
-- Data for Name: oauth_consents; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_consents (id, user_id, client_id, scopes, granted_at, revoked_at) FROM stdin;
\.


--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.one_time_tokens (id, user_id, token_type, token_hash, relates_to, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) FROM stdin;
\.


--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_providers (id, sso_provider_id, entity_id, metadata_xml, metadata_url, attribute_mapping, created_at, updated_at, name_id_format) FROM stdin;
\.


--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_relay_states (id, sso_provider_id, request_id, for_email, redirect_to, created_at, updated_at, flow_state_id) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
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
20260219120000
20260302000000
20260625000000
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sessions (id, user_id, created_at, updated_at, factor_id, aal, not_after, refreshed_at, user_agent, ip, tag, oauth_client_id, refresh_token_hmac_key, refresh_token_counter, scopes) FROM stdin;
\.


--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_domains (id, sso_provider_id, domain, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_providers (id, resource_id, created_at, updated_at, disabled) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) FROM stdin;
\.


--
-- Data for Name: webauthn_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.webauthn_challenges (id, user_id, challenge_type, session_data, created_at, expires_at) FROM stdin;
\.


--
-- Data for Name: webauthn_credentials; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.webauthn_credentials (id, user_id, credential_id, public_key, attestation_type, aaguid, sign_count, transports, backup_eligible, backed_up, friendly_name, created_at, updated_at, last_used_at) FROM stdin;
\.


--
-- Data for Name: ai_conversations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ai_conversations (conversation_id, user_id, role, content, created_at) FROM stdin;
7	10	user	hello	2026-08-25 19:08:00.082108+00
8	10	assistant	Hello Rhez! How can I help you and your family in Pinagbakahan, Malolos today? Are you checking on safety conditions, or is there an emergency you need assistance with?	2026-08-25 19:08:00.152221+00
9	10	user	ano ang kailangan ko gawin pag may baha	2026-08-25 19:08:24.618092+00
10	10	assistant	[EMERGENCY]\nLumikas agad sa mas mataas na lugar kasama sina Albert, Justine, Luigi, at ang iyong anak kung tumataas na ang tubig sa inyong lugar sa Pinagbakahan. Huwag nang maghintay na lumubog pa ang inyong bahay.\n\n[WARNING]\nHuwag na huwag lulusong o maglalakad sa baha. Mapanganib ito dahil maaaring may nakitang live wire o nakatagong butas sa daan, at maduming tubig ang dala nito na maaaring magdulot ng sakit.\n\n[TIP]\nI-angat agad sa mataas na bahagi ng bahay ang inyong mga appliances, dokumento, at pagkain. Huwag kalimutang i-off ang inyong main circuit breaker para sa kuryente at dalhin ang inyong Go Bag bago lumikas.	2026-08-25 19:08:24.682733+00
11	10	user	What does the "Flood Risk (5-Year Return Period)" hazard layer mean? Explain it in detail.	2026-08-25 19:30:05.864674+00
12	10	assistant	[INFO]\nAng "Flood Risk (5-Year Return Period)" hazard layer ay tumutukoy sa mga lugar na may posibilidad na bahain tuwing may mga pag-ulan na may 20% na tyansa na mangyari sa anumang taon. Sa madaling salita, ito ang mga lugar na karaniwang nalulubog sa baha tuwing may malalakas na bagyo o pag-ulan na nararanasan natin kada limang taon.\n\n[TIP]\nPara sa inyo sa Pinagbakahan, Malolos, ang impormasyong ito ay mahalaga para malaman kung ang inyong tahanan ay nasa mababang lugar na madaling abutin ng baha. Makakatulong ito sa inyo nina Albert, Justine, Luigi, at ng iyong anak na magplano nang maaga kung kailangang lumikas bago pa man tumaas ang tubig.	2026-08-25 19:30:05.934568+00
\.


--
-- Data for Name: assignment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.assignment (assignment_id, team_id, cluster_id, status, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: cities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cities (city_id, name, province, region) FROM stdin;
2	plaridel	bulacan	3
1	Bulacan	bulacan	3
\.


--
-- Data for Name: clusters; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clusters (cluster_id, latitude, longitude, priority_level, status, report_count, people_affected, ai_summary, action_plan, created_at, updated_at, city_id, typhoon_id, ai_severity, ai_disaster_type, ai_analyzed_at) FROM stdin;
16	14.8664	120.7912	high	open	1	10	A large residential fire caused by a short circuit is spreading rapidly due to strong winds, affecting multiple houses with children trapped inside.	["Dispatch multiple fire trucks immediately to contain the spreading fire.", "Deploy search and rescue teams to evacuate children and residents trapped in affected homes.", "Coordinate with local medical services and barangay officials for emergency triage and evacuation shelter setup."]	2026-08-25 15:20:20.893104+00	2026-08-25 15:20:27.355195+00	1	\N	critical	fire	2026-08-25 15:20:27.355195+00
17	14.8782175	120.8290415	low	open	2	2	Light rain is beginning to fall in Bulacan with no flooding outside yet, and the resident is monitoring the typhoon situation from a single-floor home. Floodwater has reached ankle-deep in the yard of a single-floor residence, with the resident monitoring rising water levels.	["Log the monitoring status in the disaster response database", "Send local weather and typhoon updates to the reporter", "Advise preparation for potential evacuation if rainfall intensifies", "Monitor water levels closely given the single-floor residence vulnerability", "Prepare emergency Go Bag and important documents", "Stay alert for evacuation advisories from local barangay officials"]	2026-08-25 15:48:48.731778+00	2026-08-25 18:07:18.314041+00	1	\N	medium	typhoon	2026-08-25 18:07:18.314041+00
22	14.860537	120.8337005	low	open	2	5	Emergency report from a 33-year-old male residing in a single-floor house in Bulacan indicating a disaster situation. Emergency report indicates a disaster situation in Bulacan requiring assessment and potential response.	["Dispatch local rescue team to the specified location in Bulacan", "Advise the reporter to move to higher ground immediately due to single-floor residence risk", "Establish communication with local barangay disaster operations center for rapid assessment", "Dispatch local barangay response unit to check on the resident at the specified coordinates", "Monitor water levels in Barangay p07_edgar, Bulacan", "Advise resident to prepare for possible evacuation if water levels rise"]	2026-08-25 16:26:48.815723+00	2026-08-25 18:23:29.630509+00	1	\N	high	flood	2026-08-25 18:23:29.630509+00
20	14.876381	120.826496	low	open	2	3	Emergency report indicates a disaster situation in Bulacan requiring assessment and potential response based on location and reporter profile. Floodwaters are at ankle-deep level in the yard and the resident is closely monitoring the rising water. Living in a single-floor house increases vulnerability to further flooding.	["Dispatch local barangay unit to verify status at coordinates 14.876381, 120.825799", "Contact reporter to confirm immediate safety and water levels", "Prepare evacuation support if floodwaters rise to the second floor", "Monitor flood water levels continuously", "Prepare emergency Go Bag and move valuables to higher surfaces", "Standby for potential evacuation if water levels rise to critical heights"]	2026-08-25 16:26:41.36232+00	2026-08-25 18:23:18.600188+00	1	\N	medium	flood	2026-08-25 18:23:18.600188+00
24	14.857613	120.8324005	low	open	2	5	Emergency report indicates a disaster situation in Bulacan requiring assessment and potential response based on location context. Emergency report in Bulacan involving a male resident living in a single-floor house, facing heightened vulnerability due to potential localized hazards.	["Dispatch local barangay tanod to verify the situation at the specified coordinates in Bulacan", "Contact the reporter to confirm current safety status and immediate needs", "Prepare rescue or relief deployment if water levels rise threatening the two-floor residence", "Dispatch local rescue unit to check on the single-floor residence in Bulacan", "Assess immediate water levels and evacuation needs for the reporter", "Provide instructions on safe elevation and emergency contacts"]	2026-08-25 16:26:55.840715+00	2026-08-25 18:23:25.25927+00	1	\N	high	flood	2026-08-25 18:23:25.25927+00
23	14.858026	120.834746	low	open	1	1	The reporter notes intermittent power fluctuations at her single-story residence in Bulacan with no other reported issues.	["Log the power fluctuation report for grid monitoring", "Advise the resident to monitor appliances and unplug sensitive electronics", "Notify the local electric cooperative of potential local electrical instability"]	2026-08-25 16:26:53.520711+00	2026-08-25 18:23:28.026955+00	1	\N	low	other	2026-08-25 18:23:28.026955+00
26	14.905164	120.774128	low	open	1	0	An elderly male resident reports rising floodwaters approaching his single-story house in Bulacan, though he is currently able to evacuate independently if necessary.	["Dispatch a local rescue team to check on the 66-year-old resident at the specified coordinates.", "Assist the resident with immediate evacuation due to vulnerability and single-story housing.", "Monitor water level progression in Barangay p09_wilfredo, Bulacan."]	2026-08-25 16:26:59.943001+00	2026-08-25 18:07:24.76101+00	1	\N	\N	flood	2026-08-25 16:27:02.650376+00
27	14.906960333333334	120.77180366666667	high	open	3	3	A small tree fell in the backyard due to strong winds, posing a potential hazard to the single-floor residence. ... and 2 more reports.	["Dispatch barangay personnel to assess and clear the fallen tree", "Check for any damage to power lines or the house structure", "Advise the resident to stay clear of the area until cleared", "Dispatch a local rescue team to assist the elderly resident with pre-emptive evacuation.", "Monitor water level progression at the specified location in Bulacan.", "Provide designated evacuation center information and transport support.", "Advise the resident to move to the second floor of the house for safety", "Turn off main electrical breakers if safe to do so", "Dispatch local rescue boat to check on the resident and assess evacuation needs"]	2026-08-25 18:07:22.802613+00	2026-08-25 18:23:33.815145+00	1	\N	high	flood	2026-08-25 18:23:33.815145+00
25	14.910185	120.772036	low	open	1	0	A small tree fell in the backyard due to strong winds, posing potential risk to the single-floor residence.	["Dispatch local barangay tanods to clear the fallen tree", "Inspect the property for any roof or structural damage", "Advise resident to stay indoors until winds subside"]	2026-08-25 16:26:57.716794+00	2026-08-25 17:55:44.10748+00	1	\N	\N	typhoon	2026-08-25 16:27:00.142806+00
18	14.994553	120.929005	low	open	1	0	\N	[]	2026-08-25 15:57:10.390444+00	2026-08-25 17:45:59.340332+00	\N	\N	\N	\N	\N
21	14.87387	120.8246475	high	open	2	2	Floodwaters are at ankle-deep level in the yard and the resident is closely monitoring the rising water. Due to living in a single-floor house, there is a risk of inundation if waters continue to rise. A 24-year-old resident living in a single-floor house in Bulacan requires immediate assistance due to rising floodwaters.	["Monitor water level closely and prepare for possible evacuation", "Elevate important belongings and electrical appliances", "Ensure mobile phones are charged and emergency contacts are ready", "Dispatch water rescue team to coordinates 14.875033, 120.825799", "Advise reporter to move to the highest possible area of the single-floor house", "Coordinate with Barangay p01_ana local disaster risk reduction and management office"]	2026-08-25 16:26:45.220072+00	2026-08-25 18:23:13.219764+00	1	\N	critical	flood	2026-08-25 18:23:13.219764+00
29	14.872308333333333	120.86483266666667	high	open	3	4	Chest-deep floodwaters have entered a single-floor residence where a pregnant female reporter is trapped and urgently requires evacuation. ... and 2 more reports.	["Dispatch water rescue boat to the specified coordinates immediately", "Prioritize evacuation of the pregnant resident to a medical facility", "Notify local Barangay p15_rowena disaster response units for on-ground assistance", "Dispatch local rescue team to coordinates 14.871859, 120.865762 for immediate extraction", "Coordinate with Barangay p16_bayani local disaster risk reduction and management office (LDRRMO)", "Provide medical and mobility assistance upon rescue due to reporter's physical disability and ground-floor residence", "Dispatch an emergency water rescue team immediately to the specified coordinates in Bulacan.", "Equip the rescue unit with life vests and swift-water rescue gear to retrieve the trapped woman and child.", "Coordinate with local disaster risk reduction and management (DRRM) units for safe immediate evacuation and medical assistance."]	2026-08-25 18:23:39.254995+00	2026-08-25 18:23:44.286479+00	1	\N	critical	flood	2026-08-25 18:23:44.286479+00
19	14.874962	120.8265775	high	open	2	2	The road outside the house is muddy due to weather conditions, but there is no flood yet and vehicles are passing carefully. A 72-year-old female trapped on her roof in Bulacan reports neck-deep floodwaters inside her single-floor home and urgently needs rescue.	["Monitor weather updates and local water levels", "Prepare emergency Go-Bag in case conditions worsen", "Advise residents to stay alert for potential flash floods", "Dispatch an immediate water rescue team to the specified coordinates in Barangay Rosario, Bulacan.", "Prioritize elderly extraction due to neck-deep indoor flooding and single-floor rooftop exposure.", "Coordinate with local disaster risk reduction and management officers (DRRMO) for rapid deployment."]	2026-08-25 16:26:37.26135+00	2026-08-25 18:23:49.958934+00	1	\N	critical	flood	2026-08-25 18:23:49.958934+00
28	14.89522	120.84674	high	open	4	11	Floodwaters have reached waist-deep inside a single-floor house where a 31-year-old mother and her young child are stranded, requiring immediate evacuation assistance. ... and 3 more reports.	["Dispatch water rescue team to coordinates 14.894546, 120.846043 in Barangay p11_jasmin, Bulacan.", "Prioritize evacuation of the mother and young child due to waist-deep indoor flooding in a single-floor residence.", "Provide immediate medical check-up upon rescue and transport to the nearest designated evacuation center.", "Dispatch an emergency rescue team to safely clear the fallen electric pole and free trapped individuals.", "Coordinate with the local power distributor to immediately cut off electricity in the area to prevent electrocution.", "Deploy medical personnel to check on affected residents and provide first aid if necessary.", "Dispatch emergency rescue team immediately to the reported location for extraction and medical assistance.", "Coordinate with local Barangay p13_leonora disaster response units to provide temporary shelter and dry clothing.", "Assess structural damage to the single-floor house and arrange for urgent roof repair.", "Dispatch water rescue team to the coordinates immediately"]	2026-08-25 18:23:32.978816+00	2026-08-25 18:23:39.493681+00	1	\N	critical	flood	2026-08-25 18:23:39.493681+00
30	14.850697333333333	120.85487666666667	high	open	3	3	An elderly male resident in Bulacan reports a developing emergency situation at his location requiring potential intervention. ... and 2 more reports.	["Contact the reporter to assess current water levels at the specific address", "Alert Barangay p18_danilo local disaster response units to check on the elderly resident", "Prepare for potential evacuation assistance if floodwaters rise to the second floor", "Dispatch an immediate water rescue team to the specified coordinates in Barangay Remedios, Bulacan.", "Coordinate with local MDRRMO and emergency services for priority evacuation of a vulnerable wheelchair-bound senior citizen.", "Provide medical triage and support immediately upon extraction due to age, disability, and floodwater exposure.", "Dispatch local rescue team to the specific address in Barangay p20_herminia, Bulacan", "Provide physical assistance for evacuation considering the resident's disability and age", "Transport the resident to the nearest designated safe evacuation center"]	2026-08-25 18:23:43.407468+00	2026-08-25 18:23:48.722483+00	1	\N	critical	flood	2026-08-25 18:23:48.722483+00
\.


--
-- Data for Name: elevation_cache; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.elevation_cache (cache_key, lat, lng, elevation_m, created_at) FROM stdin;
14.9727,120.9414	14.9727	120.9414	26	2026-08-24 18:35:30.696674+00
14.9950,120.9290	14.995	120.929	25	2026-08-24 18:44:25.443999+00
14.9940,120.9290	14.994	120.929	25	2026-08-24 19:09:16.270761+00
14.9960,120.9290	14.996	120.929	22	2026-08-25 18:25:09.275257+00
\.


--
-- Data for Name: family; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.family (family_id, name, created_by) FROM stdin;
7	fuck	10
8	Sahoors	29
9	Sahoor	10
10	Dimla	27
11	Mama mia	26
12	The Simpsons	41
15	ishowmeat	43
\.


--
-- Data for Name: family_members; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.family_members (family_member_id, family_id, user_id, relation, status) FROM stdin;
13	9	10	father	accepted
18	10	10	father	pending
22	12	41	son	accepted
23	12	39	grandfather	accepted
17	9	27	daughter	accepted
16	9	26	mother	accepted
28	9	43	mother	accepted
20	10	29	son	accepted
29	9	39	grandmother	pending
\.


--
-- Data for Name: images; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.images (image_id, public_url, created_at, submitted_by) FROM stdin;
3	http://res.cloudinary.com/pi52m6i7/image/upload/v1787222124/2026_08_20/hgcmmg9nsrvhaq9sshsv.png	2026-08-20 10:35:36.985382+00	13
4	http://res.cloudinary.com/pi52m6i7/image/upload/v1787223511/2026_08_20/xkasydoplqhhg5fbc3uk.jpg	2026-08-20 10:58:32.906523+00	10
5	http://res.cloudinary.com/pi52m6i7/image/upload/v1787223675/2026_08_20/nwiqzz904xximeattqf3.jpg	2026-08-20 11:01:16.371+00	10
6	http://res.cloudinary.com/pi52m6i7/image/upload/v1787277148/2026_08_21/rrtdz9oeljg6xz9w3uq6.jpg	2026-08-21 01:52:30.908092+00	10
7	http://res.cloudinary.com/pi52m6i7/image/upload/v1787278302/2026_08_21/ykphlm6qvzyngzufqisq.jpg	2026-08-21 02:11:47.331901+00	10
8	http://res.cloudinary.com/pi52m6i7/image/upload/v1787280599/2026_08_21/kbmvvmd7gt75aek3024e.jpg	2026-08-21 02:50:01.099529+00	10
9	http://res.cloudinary.com/pi52m6i7/image/upload/v1787286062/2026_08_21/gg1cpmfjdvoyvvje1y3l.jpg	2026-08-21 04:21:03.598281+00	10
10	http://res.cloudinary.com/pi52m6i7/image/upload/v1787311777/2026_08_21/sdimehdpwq7wmglagfcg.jpg	2026-08-21 11:29:39.203405+00	18
11	http://res.cloudinary.com/pi52m6i7/image/upload/v1787319196/2026_08_21/i30erijzgestj8r4x0iq.png	2026-08-21 13:33:28.398888+00	10
12	http://res.cloudinary.com/pi52m6i7/image/upload/v1787319288/2026_08_21/se1idx7ar6hqxxpb8s7l.png	2026-08-21 13:34:59.270746+00	10
13	http://res.cloudinary.com/pi52m6i7/image/upload/v1787319288/2026_08_21/gjehlnwnmj7fffwyeat9.png	2026-08-21 13:34:59.270746+00	10
14	http://res.cloudinary.com/pi52m6i7/image/upload/v1787319288/2026_08_21/wh5nsloj9oktuqe1zxxj.png	2026-08-21 13:34:59.270746+00	10
15	http://res.cloudinary.com/pi52m6i7/image/upload/v1787319710/2026_08_21/zdrnjmdbnwy5jz1unyce.png	2026-08-21 13:42:01.385993+00	10
16	http://res.cloudinary.com/pi52m6i7/image/upload/v1787322009/2026_08_21/vlx7azo3aefuu0hge3n6.jpg	2026-08-21 14:20:11.074272+00	10
17	http://res.cloudinary.com/pi52m6i7/image/upload/v1787322012/2026_08_21/ym7de5qo7ysslmofd3ub.jpg	2026-08-21 14:20:13.682865+00	10
18	http://res.cloudinary.com/pi52m6i7/image/upload/v1787323164/2026_08_21/qyaikdxqzpjihxpafglo.png	2026-08-21 14:39:35.854598+00	10
19	http://res.cloudinary.com/pi52m6i7/image/upload/v1787323378/2026_08_21/vcwibuoeqgmf0vlqf07i.png	2026-08-21 14:43:09.266407+00	10
25	http://res.cloudinary.com/pi52m6i7/image/upload/v1787324399/2026_08_21/urbyy4yikucp0rgfhosh.jpg	2026-08-21 15:00:01.012058+00	10
26	http://res.cloudinary.com/pi52m6i7/image/upload/v1787324402/2026_08_21/yd9mb5pzsq40qhll4pzb.jpg	2026-08-21 15:00:03.605861+00	10
27	http://res.cloudinary.com/pi52m6i7/image/upload/v1787324404/2026_08_21/pjwsxa1dpuhbr8bj1xxu.jpg	2026-08-21 15:00:06.591032+00	10
28	http://res.cloudinary.com/pi52m6i7/image/upload/v1787324717/2026_08_21/d59pa6awo0cxmrw9fooa.jpg	2026-08-21 15:05:18.858736+00	10
29	http://res.cloudinary.com/pi52m6i7/image/upload/v1787324720/2026_08_21/jl75lvoyvtoykftktqng.jpg	2026-08-21 15:05:21.828144+00	10
30	http://res.cloudinary.com/pi52m6i7/image/upload/v1787324722/2026_08_21/jqehnnrafbowajmhnivn.jpg	2026-08-21 15:05:23.820333+00	10
31	http://res.cloudinary.com/pi52m6i7/image/upload/v1787324913/2026_08_21/cuxxi0wnyuc4blpcvnra.jpg	2026-08-21 15:08:35.224635+00	10
32	http://res.cloudinary.com/pi52m6i7/image/upload/v1787324916/2026_08_21/pnbxefm67nepry7kxbtt.jpg	2026-08-21 15:08:37.213609+00	10
33	http://res.cloudinary.com/pi52m6i7/image/upload/v1787324918/2026_08_21/of0vylcaswmbr7gdobqr.jpg	2026-08-21 15:08:39.297934+00	10
36	http://res.cloudinary.com/pi52m6i7/image/upload/v1787363706/2026_08_22/dqyj05pqlk7dy3clwptk.png	2026-08-22 01:55:17.986066+00	10
37	http://res.cloudinary.com/pi52m6i7/image/upload/v1787363892/2026_08_22/ronw0ymtinwv4jlecbku.png	2026-08-22 01:58:22.679802+00	10
38	http://res.cloudinary.com/pi52m6i7/image/upload/v1787363891/2026_08_22/nu6p87hfirorpqgggvqe.png	2026-08-22 01:58:22.679802+00	10
39	http://res.cloudinary.com/pi52m6i7/image/upload/v1787363890/2026_08_22/nyaje3l8f3gcb75kx7xf.png	2026-08-22 01:58:22.679802+00	10
40	http://res.cloudinary.com/pi52m6i7/image/upload/v1787363916/2026_08_22/mrynd4meaqoud03csbu6.png	2026-08-22 01:58:47.884711+00	10
41	http://res.cloudinary.com/pi52m6i7/image/upload/v1787363916/2026_08_22/xygdxvwfxcy0fhdlvi9z.png	2026-08-22 01:58:47.884711+00	10
42	http://res.cloudinary.com/pi52m6i7/image/upload/v1787363917/2026_08_22/qkin7yculfxzz73dq2yd.png	2026-08-22 01:58:47.884711+00	10
43	http://res.cloudinary.com/pi52m6i7/image/upload/v1787365067/2026_08_22/ubeu5thrpb115yj5lbmy.png	2026-08-22 02:18:00.073803+00	10
44	http://res.cloudinary.com/pi52m6i7/image/upload/v1787365058/2026_08_22/iwmgp2giy2ztzgyodmpy.png	2026-08-22 02:18:00.073803+00	10
45	http://res.cloudinary.com/pi52m6i7/image/upload/v1787365069/2026_08_22/aqz8bjybdmy3ckhrnsfq.png	2026-08-22 02:18:00.073803+00	10
46	http://res.cloudinary.com/pi52m6i7/image/upload/v1787371388/2026_08_22/nan1vmgfjgbbuywguewv.png	2026-08-22 04:03:19.36177+00	10
47	http://res.cloudinary.com/pi52m6i7/image/upload/v1787371679/2026_08_22/dnkmeyfjhzwhapfhugbk.png	2026-08-22 04:08:11.981142+00	10
48	http://res.cloudinary.com/pi52m6i7/image/upload/v1787372012/2026_08_22/v1xq4nb18hcoiwxxhjqi.png	2026-08-22 04:13:51.898744+00	29
49	http://res.cloudinary.com/pi52m6i7/image/upload/v1787372021/2026_08_22/h4gczmtoefudiil1otsg.png	2026-08-22 04:13:51.898744+00	29
50	http://res.cloudinary.com/pi52m6i7/image/upload/v1787386182/2026_08_22/vvmytzhzlp1zwnbafk2u.jpg	2026-08-22 08:09:43.820891+00	39
51	http://res.cloudinary.com/pi52m6i7/image/upload/v1787386185/2026_08_22/bushdvs2dzuwmkz9rcri.jpg	2026-08-22 08:09:46.340757+00	39
52	http://res.cloudinary.com/pi52m6i7/image/upload/v1787386187/2026_08_22/ut21cuqubhflt6qg0jez.jpg	2026-08-22 08:09:48.809729+00	39
53	http://res.cloudinary.com/pi52m6i7/image/upload/v1787387470/2026_08_22/qg6iorsnpd5fnkffkc3j.jpg	2026-08-22 08:31:11.471712+00	39
54	http://res.cloudinary.com/pi52m6i7/image/upload/v1787387473/2026_08_22/jfqnvdiawaqnsklms9cy.jpg	2026-08-22 08:31:14.565745+00	39
55	http://res.cloudinary.com/pi52m6i7/image/upload/v1787387475/2026_08_22/mivyqmxfmqwo6z75e7ee.jpg	2026-08-22 08:31:16.39625+00	39
56	http://res.cloudinary.com/pi52m6i7/image/upload/v1787387809/2026_08_22/vfvxfeedq2cy39wg8kxh.jpg	2026-08-22 08:36:50.298427+00	39
57	http://res.cloudinary.com/pi52m6i7/image/upload/v1787394175/2026_08_22/ccddnwcisegsjshgpat9.jpg	2026-08-22 10:22:56.639414+00	39
58	http://res.cloudinary.com/pi52m6i7/image/upload/v1787394178/2026_08_22/exegbgqzgvkmozuijp13.jpg	2026-08-22 10:22:59.287238+00	39
59	http://res.cloudinary.com/pi52m6i7/image/upload/v1787394180/2026_08_22/hvj2gchvmahgji0co3rr.jpg	2026-08-22 10:23:01.616128+00	39
60	http://res.cloudinary.com/pi52m6i7/image/upload/v1787457286/2026_08_23/wjmhy86uvzqyd1zm85rp.jpg	2026-08-23 03:54:47.925673+00	10
61	http://res.cloudinary.com/pi52m6i7/image/upload/v1787472417/2026_08_23/denbmq3idox1wdhvzqbf.jpg	2026-08-23 08:06:58.774149+00	27
62	http://res.cloudinary.com/pi52m6i7/image/upload/v1787484544/2026_08_23/k3a6xd9njl1h8mrcskfo.jpg	2026-08-23 11:29:05.791581+00	27
63	http://res.cloudinary.com/pi52m6i7/image/upload/v1787504891/2026_08_24/mt9zlgpnarlulysddes6.jpg	2026-08-23 17:08:12.73657+00	10
64	http://res.cloudinary.com/pi52m6i7/image/upload/v1787505219/2026_08_24/gyb7ukjtnvch8evnioid.jpg	2026-08-23 17:13:40.963133+00	10
65	http://res.cloudinary.com/pi52m6i7/image/upload/v1787505223/2026_08_24/h8l0orvtjo9pmeepynzz.jpg	2026-08-23 17:13:44.656758+00	10
66	http://res.cloudinary.com/pi52m6i7/image/upload/v1787626695/2026_08_25/vt9vwbythwbppwmkpehy.png	2026-08-25 02:58:25.80049+00	29
67	http://res.cloudinary.com/pi52m6i7/image/upload/v1787648985/2026_08_25/ikxnos47hherxvthkmt0.jpg	2026-08-25 09:09:46.727819+00	10
68	http://res.cloudinary.com/pi52m6i7/image/upload/v1787661224/2026_08_25/weeeku3wvgbip6fwqs2b.jpg	2026-08-25 12:33:45.364452+00	48
69	http://res.cloudinary.com/pi52m6i7/image/upload/v1787664537/2026_08_25/kc8im0yrsn28wzxhggoh.jpg	2026-08-25 13:28:58.541109+00	48
70	http://res.cloudinary.com/pi52m6i7/image/upload/v1787668816/2026_08_25/fibmvyxigomwhnnwa7km.jpg	2026-08-25 14:40:17.094063+00	27
71	http://res.cloudinary.com/pi52m6i7/image/upload/v1787669065/2026_08_25/uwg6cglhpdp8tcopdlq6.jpg	2026-08-25 14:44:26.188874+00	27
72	http://res.cloudinary.com/pi52m6i7/image/upload/v1787671224/2026_08_25/lxxtmlfnzr5b5attsu7y.jpg	2026-08-25 15:20:24.778045+00	48
73	http://res.cloudinary.com/pi52m6i7/image/upload/v1787675194/2026_08_26/cs3dvn1yufppbwseiln3.jpg	2026-08-25 16:26:35.620384+00	53
74	http://res.cloudinary.com/pi52m6i7/image/upload/v1787675199/2026_08_26/axkks67dmsoqwvzot9t4.jpg	2026-08-25 16:26:39.718447+00	67
75	http://res.cloudinary.com/pi52m6i7/image/upload/v1787675202/2026_08_26/zdbjlusyis8g3lej2tnf.jpg	2026-08-25 16:26:43.56636+00	62
76	http://res.cloudinary.com/pi52m6i7/image/upload/v1787675206/2026_08_26/ceo7bnqlcfsgth4klxkb.jpg	2026-08-25 16:26:47.615901+00	58
77	http://res.cloudinary.com/pi52m6i7/image/upload/v1787675210/2026_08_26/c7z9ez1of4izlp57yyli.webp	2026-08-25 16:26:51.936284+00	68
78	http://res.cloudinary.com/pi52m6i7/image/upload/v1787675222/2026_08_26/otxvgyamynxe74ldb8it.jpg	2026-08-25 16:27:03.021198+00	61
\.


--
-- Data for Name: people; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.people (person_id, first_name, middle_name, last_name, gender, disabilities, age, city, barangay, street, address, house_floors, pets) FROM stdin;
7	rhez	\N	astrera	male	\N	18	malolos	pinagbakahan	\N	lot 7	\N	\N
9	Test	\N	User	male	\N	25	Cebu City	Lahug	Test St	123 Test St	\N	\N
10	jdjdsj	jdjdjdjs	jsjsjs	male	{none}	46	hshs	jsjss	hcjf	bzbzjsns	\N	\N
11	Axios	\N	Test	female	{none}	30	Manila	San Lorenzo	\N	88 Axios Ave	\N	\N
12	luigi	egar	quita	male	{none}	13	ltkrd	jejejd	jdjdjs	hdjdjcj	\N	\N
13	Luigi	Egar	Quita	male	{visual,cognitive}	20	Malolos	Caniogan	Lucero	066 Lucero St	\N	\N
14	Luigi	Egar	Quita	male	{visual}	21	Malolos	Caniogan	Lucero	199 Lucero Street Caniogan	\N	\N
15	Albert	R	Delos Reyes	other	\N	21	Malolos	Caniogan	Lucero	Lucero	1	{fish,bird,cat,dog,Albert}
8	Rhez	\N	Astrera	male	\N	18	malolos	pinagbakahan	\N	lot 7	\N	\N
6	Rhez	\N	Astrera	male	\N	18	malolos	pinagbakahan	\N	lot 7	\N	\N
16	Stephen	\N	Pogi	male	{cognitive,visual,hearing,other}	19	Malolos	Pinagbakahan	Goated St.	Lot 6 7	6	{dog,cat,bird}
17	Justine	Bautista	Dimla	male	{visual}	21	Bulacan	Paltao	Navarro St.	1167 Navarro St. Paltao Pulilan Bulacan	1	{cat}
18	John Paul	Sumaway	Sarmiento	other	{other}	21	San Rafael	Capihan	0077 Dr Guizano	0077 Dr Guizano San Rafael Capihan Bulacan	\N	\N
19	Albert	Romero	Delos Reyes	male	{visual}	21	Malolos	Sumapang Matanda	Regatta Drive	Lot 9 Block 36, Regatta North Subdivision, Sumapang Matanda, City Of Malolos, Bulacan	3	{dog}
22	Luigi	\N	Quita	male	{cognitive,other}	21	Malolos	Nigga	Bro st.	Lot 6 1	1	{dog}
23	luigi	egar	quita	other	{visual,hearing,mobility,Asthma,OneLeg,Migraine}	21	Malolos	Caniogan	Lucero	199 Luvdfo	1	{dog,cat,Tiger}
24	Luigi	Egad	Quita	male	{visual}	20	Malolos	Caniogan	Lucero	065 Lucero Street	2	{cat,dog}
47	Marites	\N	Ocampo	female	{}	40	Bulacan	Barangay p08_marites	\N	Bulacan Province	1	\N
48	Wilfredo	\N	Pascual	male	{}	66	Bulacan	Barangay p09_wilfredo	\N	Bulacan Province	1	\N
49	Cynthia	\N	Rosales	female	{}	45	Bulacan	Barangay p10_cynthia	\N	Bulacan Province	2	\N
20	Dispatcher	De	Guzman	female	\N	36	malolos	Paltao	Palayan St.	67 Palayan St. Paltao Pulilan Bulacan	1	{cat,bird}
21	Mike	D.	Dispatcher	male	\N	26	plaridel	Publacion	Francico St.	63 Francisco St. Publacion Pulilan Bulacan	3	{bird}
25	Tung	\N	Sahur	male	{mobility}	26	malolos	pinagbakahan	bruh st.	lot brainrot	1	{dog}
26	Roberto	\N	Mendoza	male	{}	38	Malolos	Sumapang Matanda	\N	Brgy. Sumapang Matanda, Malolos, Bulacan	1	\N
27	Roberto	\N	Mendoza	male	{}	38	Malolos	Sumapang Matanda	\N	Brgy. Sumapang Matanda, Malolos, Bulacan	1	\N
28	Roberto	\N	Mendoza	male	{}	38	Malolos	Sumapang Matanda	\N	Brgy. Sumapang Matanda, Malolos, Bulacan	1	\N
29	Roberto	\N	Mendoza	male	{}	38	Malolos	Sumapang Matanda	\N	Brgy. Sumapang Matanda, Malolos, Bulacan	1	\N
30	Roberto	\N	Mendoza	male	{}	38	Malolos	Sumapang Matanda	\N	Brgy. Sumapang Matanda, Malolos, Bulacan	1	\N
31	Ana	\N	Bautista	female	{}	24	Bulacan	Barangay p01_ana	\N	Bulacan Province	1	\N
32	Jasmin	\N	Aquino	female	{}	31	Bulacan	Barangay p11_jasmin	\N	Bulacan Province	1	\N
33	Danilo	\N	Espiritu	male	{}	60	Bulacan	Barangay p18_danilo	\N	Bulacan Province	2	\N
34	Herminia	\N	Buenaventura	female	{physical}	68	Bulacan	Barangay p20_herminia	\N	Bulacan Province	1	\N
35	Rosario	\N	Mendoza	female	{}	72	Bulacan	Barangay p21_rosario	\N	Bulacan Province	1	\N
36	Liza	\N	Domingo	female	{}	29	Bulacan	Barangay p06_liza	\N	Bulacan Province	1	\N
37	Tomas	\N	Bermudez	male	{}	52	Bulacan	Barangay p12_tomas	\N	Bulacan Province	1	\N
38	Grace	\N	Villaflor	female	{}	26	Bulacan	Barangay p04_grace	\N	Bulacan Province	1	\N
39	Wilfredo	\N	Pascual	male	{}	66	Bulacan	Barangay p09_wilfredo	\N	Bulacan Province	1	\N
40	Ana	\N	Bautista	female	{}	24	Bulacan	Barangay p01_ana	\N	Bulacan Province	1	\N
41	Paolo	\N	Diaz	male	{}	27	Bulacan	Barangay p02_paolo	\N	Bulacan Province	1	\N
42	Rico	\N	Manalo	male	{}	30	Bulacan	Barangay p03_rico	\N	Bulacan Province	2	\N
43	Grace	\N	Villaflor	female	{}	26	Bulacan	Barangay p04_grace	\N	Bulacan Province	1	\N
44	Noel	\N	Castro	male	{}	33	Bulacan	Barangay p05_noel	\N	Bulacan Province	1	\N
45	Liza	\N	Domingo	female	{}	29	Bulacan	Barangay p06_liza	\N	Bulacan Province	1	\N
46	Edgar	\N	Salazar	male	{}	35	Bulacan	Barangay p07_edgar	\N	Bulacan Province	2	\N
50	Ana	\N	Bautista	female	{}	24	Bulacan	Barangay p01_ana	\N	Bulacan Province	1	\N
51	Paolo	\N	Diaz	male	{}	27	Bulacan	Barangay p02_paolo	\N	Bulacan Province	1	\N
52	Rico	\N	Manalo	male	{}	30	Bulacan	Barangay p03_rico	\N	Bulacan Province	2	\N
53	Grace	\N	Villaflor	female	{}	26	Bulacan	Barangay p04_grace	\N	Bulacan Province	1	\N
54	Noel	\N	Castro	male	{}	33	Bulacan	Barangay p05_noel	\N	Bulacan Province	1	\N
55	Liza	\N	Domingo	female	{}	29	Bulacan	Barangay p06_liza	\N	Bulacan Province	1	\N
56	Edgar	\N	Salazar	male	{}	35	Bulacan	Barangay p07_edgar	\N	Bulacan Province	2	\N
57	Marites	\N	Ocampo	female	{}	40	Bulacan	Barangay p08_marites	\N	Bulacan Province	1	\N
58	Wilfredo	\N	Pascual	male	{}	66	Bulacan	Barangay p09_wilfredo	\N	Bulacan Province	1	\N
59	Cynthia	\N	Rosales	female	{}	45	Bulacan	Barangay p10_cynthia	\N	Bulacan Province	2	\N
60	Ana	\N	Bautista	female	{}	24	Bulacan	Barangay p01_ana	\N	Bulacan Province	1	\N
61	Paolo	\N	Diaz	male	{}	27	Bulacan	Barangay p02_paolo	\N	Bulacan Province	1	\N
62	Rico	\N	Manalo	male	{}	30	Bulacan	Barangay p03_rico	\N	Bulacan Province	2	\N
63	Grace	\N	Villaflor	female	{}	26	Bulacan	Barangay p04_grace	\N	Bulacan Province	1	\N
65	Liza	\N	Domingo	female	{}	29	Bulacan	Barangay p06_liza	\N	Bulacan Province	1	\N
70	Ana	\N	Bautista	female	{}	24	Bulacan	Barangay p01_ana	\N	Bulacan Province	1	\N
80	Jasmin	\N	Aquino	female	{}	31	Bulacan	Barangay p11_jasmin	\N	Bulacan Province	1	\N
83	Ferdie	\N	Lacson	male	{}	44	Bulacan	Barangay p14_ferdie	\N	Bulacan Province	2	\N
84	Rowena	\N	Gatchalian	female	{}	28	Bulacan	Barangay p15_rowena	\N	Bulacan Province	1	\N
87	Danilo	\N	Espiritu	male	{}	60	Bulacan	Barangay p18_danilo	\N	Bulacan Province	2	\N
88	Remedios	\N	Salonga	female	{physical,visual}	74	Bulacan	Barangay p19_remedios	\N	Bulacan Province	1	\N
89	Herminia	\N	Buenaventura	female	{physical}	68	Bulacan	Barangay p20_herminia	\N	Bulacan Province	1	\N
90	Rosario	\N	Mendoza	female	{}	72	Bulacan	Barangay p21_rosario	\N	Bulacan Province	1	\N
64	Noel	\N	Castro	male	{}	33	Bulacan	Barangay p05_noel	\N	Bulacan Province	1	\N
66	Edgar	\N	Salazar	male	{}	35	Bulacan	Barangay p07_edgar	\N	Bulacan Province	2	\N
67	Marites	\N	Ocampo	female	{}	40	Bulacan	Barangay p08_marites	\N	Bulacan Province	1	\N
68	Wilfredo	\N	Pascual	male	{}	66	Bulacan	Barangay p09_wilfredo	\N	Bulacan Province	1	\N
69	Cynthia	\N	Rosales	female	{}	45	Bulacan	Barangay p10_cynthia	\N	Bulacan Province	2	\N
71	Paolo	\N	Diaz	male	{}	27	Bulacan	Barangay p02_paolo	\N	Bulacan Province	1	\N
72	Rico	\N	Manalo	male	{}	30	Bulacan	Barangay p03_rico	\N	Bulacan Province	2	\N
73	Grace	\N	Villaflor	female	{}	26	Bulacan	Barangay p04_grace	\N	Bulacan Province	1	\N
74	Noel	\N	Castro	male	{}	33	Bulacan	Barangay p05_noel	\N	Bulacan Province	1	\N
75	Liza	\N	Domingo	female	{}	29	Bulacan	Barangay p06_liza	\N	Bulacan Province	1	\N
76	Edgar	\N	Salazar	male	{}	35	Bulacan	Barangay p07_edgar	\N	Bulacan Province	2	\N
77	Marites	\N	Ocampo	female	{}	40	Bulacan	Barangay p08_marites	\N	Bulacan Province	1	\N
78	Wilfredo	\N	Pascual	male	{}	66	Bulacan	Barangay p09_wilfredo	\N	Bulacan Province	1	\N
79	Cynthia	\N	Rosales	female	{}	45	Bulacan	Barangay p10_cynthia	\N	Bulacan Province	2	\N
81	Tomas	\N	Bermudez	male	{}	52	Bulacan	Barangay p12_tomas	\N	Bulacan Province	1	\N
82	Leonora	\N	Espino	female	{physical}	70	Bulacan	Barangay p13_leonora	\N	Bulacan Province	1	\N
85	Bayani	\N	Cortez	male	{physical}	55	Bulacan	Barangay p16_bayani	\N	Bulacan Province	1	\N
86	Melinda	\N	Tuazon	female	{}	38	Bulacan	Barangay p17_melinda	\N	Bulacan Province	1	\N
\.


--
-- Data for Name: report_clusters; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.report_clusters (report_id, cluster_id) FROM stdin;
115	16
130	18
131	17
134	21
135	22
137	24
138	25
143	17
148	26
149	21
150	19
151	20
152	20
153	24
154	23
155	22
156	27
157	27
158	27
159	28
160	28
161	28
162	28
163	29
164	29
165	29
166	30
167	30
168	30
169	19
\.


--
-- Data for Name: report_images; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.report_images (report_id, image_id) FROM stdin;
8	36
8	37
8	38
8	39
8	40
8	41
8	42
9	43
9	44
9	45
10	46
10	47
11	48
11	49
12	57
12	58
12	59
20	60
21	61
25	62
26	63
27	64
27	65
71	66
105	67
109	68
110	69
111	70
112	71
115	72
119	73
120	74
121	75
122	76
123	77
127	78
\.


--
-- Data for Name: reports; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reports (report_id, longitude, latitude, created_at, description, reported_by, ai_summary, status, people_affected, ai_severity, ai_disaster_type, ai_people_estimate, ai_action_plan, ai_analyzed_at, ai_raw_response) FROM stdin;
28	120.792709	14.871971	2026-08-24 03:42:20.094193+00	\N	43	\N	open	1	\N	\N	\N	[]	\N	\N
29	120.812834	14.874432	2026-08-24 03:44:16.402861+00	\N	10	\N	open	1	\N	\N	\N	[]	\N	\N
36	120.812834	14.874432	2026-08-24 04:11:29.344347+00	\N	10	\N	open	1	\N	\N	\N	[]	\N	\N
37	120.812834	14.874432	2026-08-24 04:14:06.243768+00	\N	10	\N	open	1	\N	\N	\N	[]	\N	\N
38	120.812834	14.874432	2026-08-24 04:39:30.996297+00	\N	10	\N	open	1	\N	\N	\N	[]	\N	\N
39	120.812834	14.874432	2026-08-24 04:39:47.415258+00	\N	10	\N	open	1	\N	\N	\N	[]	\N	\N
40	120.812888	14.874888	2026-08-24 04:52:36.166904+00	\N	10	\N	open	1	\N	\N	\N	[]	\N	\N
41	120.812888	14.874888	2026-08-24 04:55:07.571467+00	\N	10	\N	open	1	\N	\N	\N	[]	\N	\N
42	120.812888	14.874888	2026-08-24 04:55:37.971135+00	\N	10	\N	open	1	\N	\N	\N	[]	\N	\N
43	120.812888	14.874888	2026-08-24 04:56:05.030397+00	\N	10	\N	open	1	\N	\N	\N	[]	\N	\N
44	120.812888	14.874888	2026-08-24 04:57:01.732326+00	\N	10	\N	open	1	\N	\N	\N	[]	\N	\N
45	120.812888	14.874888	2026-08-24 04:57:36.626433+00	\N	10	\N	open	1	\N	\N	\N	[]	\N	\N
1	120.812834	14.874432	2026-08-21 14:05:09.435424+00	\N	10	\N	open	1	\N	\N	\N	[]	\N	\N
2	120.812834	14.874432	2026-08-21 14:08:04.358936+00	\N	10	\N	open	1	\N	\N	\N	[]	\N	\N
4	120.812834	14.874432	2026-08-21 14:39:12.929801+00	\N	10	\N	open	1	\N	\N	\N	[]	\N	\N
5	120.812834	14.874432	2026-08-21 14:47:57.123123+00	\N	10	\N	open	1	\N	\N	\N	[]	\N	\N
6	120.812834	14.874432	2026-08-21 14:53:25.111109+00	\N	10	\N	open	1	\N	\N	\N	[]	\N	\N
7	120.812834	14.874432	2026-08-22 01:41:18.617634+00	\N	10	\N	open	1	\N	\N	\N	[]	\N	\N
8	120.812834	14.874432	2026-08-22 01:54:07.104226+00	\N	10	\N	open	1	\N	\N	\N	[]	\N	\N
9	120.812834	14.874432	2026-08-22 02:40:42.434679+00	libog na po kami	10	\N	open	1	\N	\N	\N	[]	\N	\N
10	120.812834	14.874432	2026-08-22 04:02:56.865109+00	hello	10	\N	open	1	\N	\N	\N	[]	\N	\N
11	120.812834	14.874432	2026-08-22 04:12:29.144828+00	hello po libog na kami	29	\N	open	1	\N	\N	\N	[]	\N	\N
12	120.929038	14.994581	2026-08-22 10:22:30.247159+00	Salsal at jabol testing 123	39	\N	open	1	\N	\N	\N	[]	\N	\N
13	120.929052	14.994484	2026-08-22 10:43:00.970894+00	\N	39	\N	open	1	\N	\N	\N	[]	\N	\N
14	120.929034	14.994599	2026-08-22 10:43:21.348457+00	\N	39	\N	open	1	\N	\N	\N	[]	\N	\N
15	120.929032	14.994593	2026-08-22 10:44:46.845919+00	\N	39	\N	open	1	\N	\N	\N	[]	\N	\N
16	120.929032	14.994593	2026-08-22 10:45:16.997267+00	\N	39	\N	open	1	\N	\N	\N	[]	\N	\N
18	120.929032	14.994593	2026-08-22 10:45:46.842996+00	\N	39	\N	open	1	\N	\N	\N	[]	\N	\N
17	120.929032	14.994593	2026-08-22 10:45:46.842996+00	Yes	39	\N	open	1	\N	\N	\N	[]	\N	\N
19	120.929032	14.994593	2026-08-22 10:46:16.793948+00	Salsal part 2	39	\N	open	1	\N	\N	\N	[]	\N	\N
20	120.812738	14.874542	2026-08-23 03:53:26.17893+00	natatae na po ako	10	\N	open	1	\N	\N	\N	[]	\N	\N
21	120.858153	14.904649	2026-08-23 08:06:41.221308+00	Tulong po mamamatay na gold fish ko boss	27	\N	open	1	\N	\N	\N	[]	\N	\N
22	120.792666	14.871996	2026-08-23 11:23:12.898063+00	\N	43	\N	open	1	\N	\N	\N	[]	\N	\N
23	120.858155	14.904649	2026-08-23 11:27:24.817317+00	\N	27	\N	open	1	\N	\N	\N	[]	\N	\N
24	120.929047	14.994475	2026-08-23 11:27:32.303561+00	\N	39	\N	open	1	\N	\N	\N	[]	\N	\N
25	120.858155	14.904649	2026-08-23 11:28:24.847925+00	tulong po mababaha kami ni ryan	27	\N	open	1	\N	\N	\N	[]	\N	\N
26	120.812727	14.874538	2026-08-23 17:07:44.473592+00	Help im drowning	10	\N	open	1	\N	\N	\N	[]	\N	\N
27	120.812727	14.874538	2026-08-23 17:13:10.100915+00	dogs	10	\N	open	1	\N	\N	\N	[]	\N	\N
57	120.812997	14.874997	2026-08-24 06:02:28.946455+00	\N	29	\N	open	1	\N	\N	\N	[]	\N	\N
58	120.812997	14.876347	2026-08-24 06:03:04.859671+00	\N	10	\N	open	1	\N	\N	\N	[]	\N	\N
59	120.812997	14.878147	2026-08-24 06:03:33.499898+00	\N	27	\N	open	1	\N	\N	\N	[]	\N	\N
60	120.859477	14.874997	2026-08-24 06:03:57.548384+00	\N	26	\N	open	1	\N	\N	\N	[]	\N	\N
61	120.859477	14.876797	2026-08-24 06:05:11.550224+00	\N	39	\N	open	1	\N	\N	\N	[]	\N	\N
62	120.812997	14.964797	2026-08-24 06:05:57.447325+00	\N	43	\N	open	1	\N	\N	\N	[]	\N	\N
63	120.929051	14.994480	2026-08-24 09:05:24.587371+00	\N	39	\N	open	1	\N	\N	\N	[]	\N	\N
64	120.822314	14.861020	2026-08-24 12:23:55.41405+00	\N	41	\N	open	\N	\N	\N	\N	[]	\N	\N
65	120.822077	14.860409	2026-08-24 12:24:06.800211+00	\N	41	\N	open	\N	\N	\N	\N	[]	\N	\N
66	120.822077	14.860409	2026-08-24 12:24:07.313075+00	\N	41	\N	open	\N	\N	\N	\N	[]	\N	\N
67	120.822325	14.861023	2026-08-24 12:25:53.955806+00	\N	41	\N	open	\N	\N	\N	\N	[]	\N	\N
108	120.791200	14.866400	2026-08-25 12:28:09.111217+00	May sunog na nangyari dahil sa short circuit, malakas ang hangin kaya kumakalat. 3 bahay na apektado, may mga bata sa loob.	48	A fire caused by a short circuit has spread rapidly due to strong winds, affecting 3 houses with children trapped inside.	open	\N	critical	fire	10	["Dispatch BFP (Bureau of Fire Protection) immediately for fire suppression", "Deploy rescue units to evacuate children and residents trapped inside the affected houses", "Establish a perimeter and coordinate with local medical teams for smoke inhalation and injuries"]	2026-08-25 12:28:11.617811+00	{"ai_summary": "A fire caused by a short circuit has spread rapidly due to strong winds, affecting 3 houses with children trapped inside.", "ai_severity": "critical", "ai_action_plan": ["Dispatch BFP (Bureau of Fire Protection) immediately for fire suppression", "Deploy rescue units to evacuate children and residents trapped inside the affected houses", "Establish a perimeter and coordinate with local medical teams for smoke inhalation and injuries"], "ai_disaster_type": "fire", "ai_people_estimate": 10}
68	120.822830	14.866860	2026-08-25 02:11:32.705389+00	lubog na po kami sa baha	10	\N	open	\N	\N	\N	\N	[]	\N	\N
69	120.822830	14.866860	2026-08-25 02:42:15.127931+00	lubog na po kami sa baha lubog lubog lubog lubog lubog lubog lubog lubog	10	\N	open	\N	\N	\N	\N	[]	\N	\N
70	120.822830	14.866860	2026-08-25 02:43:20.8677+00	lubog na po kami sa baha lubog lubog lubog lubog lubog lubog lubog lubog	29	\N	open	\N	\N	\N	\N	[]	\N	\N
71	120.822830	14.866860	2026-08-25 02:57:15.607712+00	lubog na po kami sa baha lubog lubog lubog lubog	29	\N	open	\N	\N	\N	\N	[]	\N	\N
72	120.812702	14.874505	2026-08-25 05:22:58.073171+00	hello	10	\N	open	\N	\N	\N	\N	[]	\N	\N
73	120.812702	14.874505	2026-08-25 05:24:28.829791+00	\N	10	\N	open	\N	\N	\N	\N	[]	\N	\N
74	120.822324	14.861019	2026-08-25 05:51:46.225967+00	\N	26	\N	open	\N	\N	\N	\N	[]	\N	\N
75	120.812660	14.874630	2026-08-25 07:40:53.579365+00	\N	29	\N	open	\N	\N	\N	\N	[]	\N	\N
76	120.812660	14.874630	2026-08-25 07:40:53.773139+00	\N	29	\N	open	\N	\N	\N	\N	[]	\N	\N
77	120.812660	14.874630	2026-08-25 07:42:56.838746+00	\N	29	\N	open	\N	\N	\N	\N	[]	\N	\N
78	120.812660	14.874630	2026-08-25 07:42:57.026516+00	\N	29	\N	open	\N	\N	\N	\N	[]	\N	\N
79	120.812660	14.874630	2026-08-25 07:44:10.692066+00	\N	29	\N	open	\N	\N	\N	\N	[]	\N	\N
80	120.812660	14.874630	2026-08-25 07:44:10.741003+00	\N	29	\N	open	\N	\N	\N	\N	[]	\N	\N
81	120.812660	14.874630	2026-08-25 07:44:10.867717+00	\N	29	\N	open	\N	\N	\N	\N	[]	\N	\N
82	120.812660	14.874630	2026-08-25 07:44:10.919595+00	\N	29	\N	open	\N	\N	\N	\N	[]	\N	\N
83	120.812660	14.874630	2026-08-25 07:44:41.052648+00	\N	29	\N	open	\N	\N	\N	\N	[]	\N	\N
84	120.812660	14.874630	2026-08-25 07:44:41.23451+00	\N	29	\N	open	\N	\N	\N	\N	[]	\N	\N
85	120.812660	14.874630	2026-08-25 07:46:54.637863+00	\N	29	\N	open	\N	\N	\N	\N	[]	\N	\N
86	120.812660	14.874630	2026-08-25 07:46:54.822181+00	\N	29	\N	open	\N	\N	\N	\N	[]	\N	\N
87	120.812660	14.874630	2026-08-25 07:49:35.414775+00	\N	29	\N	open	\N	\N	\N	\N	[]	\N	\N
88	120.812660	14.874630	2026-08-25 07:49:35.598743+00	\N	29	\N	open	\N	\N	\N	\N	[]	\N	\N
89	120.812660	14.874630	2026-08-25 07:50:08.415268+00	\N	29	\N	open	\N	\N	\N	\N	[]	\N	\N
90	120.812660	14.874630	2026-08-25 07:50:08.596553+00	nalulunod na kami	29	\N	open	\N	\N	\N	\N	[]	\N	\N
91	120.812660	14.874630	2026-08-25 07:55:01.625792+00	\N	29	\N	open	\N	\N	\N	\N	[]	\N	\N
92	120.812660	14.874630	2026-08-25 07:55:01.636453+00	\N	29	\N	open	\N	\N	\N	\N	[]	\N	\N
93	120.812660	14.874630	2026-08-25 07:55:01.637585+00	\N	29	\N	open	\N	\N	\N	\N	[]	\N	\N
94	120.812660	14.874630	2026-08-25 07:55:01.637792+00	\N	29	\N	open	\N	\N	\N	\N	[]	\N	\N
95	120.812660	14.874630	2026-08-25 07:55:01.63889+00	\N	29	\N	open	\N	\N	\N	\N	[]	\N	\N
96	120.812660	14.874630	2026-08-25 07:55:01.814121+00	nalulunod na kami	29	\N	open	\N	\N	\N	\N	[]	\N	\N
97	120.812660	14.874630	2026-08-25 07:55:01.814943+00	we're cooked	29	\N	open	\N	\N	\N	\N	[]	\N	\N
100	120.812660	14.874630	2026-08-25 07:55:01.821295+00	nalulunod na kami	29	\N	open	\N	\N	\N	\N	[]	\N	\N
99	120.812660	14.874630	2026-08-25 07:55:01.821152+00	we're cooked	29	\N	open	\N	\N	\N	\N	[]	\N	\N
98	120.812660	14.874630	2026-08-25 07:55:01.815782+00	we're cooked	29	\N	open	\N	\N	\N	\N	[]	\N	\N
101	120.812660	14.874630	2026-08-25 07:57:31.220751+00	\N	29	\N	open	\N	\N	\N	\N	[]	\N	\N
102	120.812660	14.874630	2026-08-25 07:57:31.39942+00	yo	29	\N	open	\N	\N	\N	\N	[]	\N	\N
103	120.812660	14.874630	2026-08-25 08:00:01.59817+00	\N	29	\N	open	\N	\N	\N	\N	[]	\N	\N
104	120.812660	14.874630	2026-08-25 08:00:01.779944+00	nalulunod na kami	29	\N	open	\N	\N	\N	\N	[]	\N	\N
105	120.812682	14.874575	2026-08-25 09:09:21.395079+00	tulong kami ay lubog na	10	\N	open	\N	\N	\N	\N	[]	\N	\N
106	120.928995	14.994548	2026-08-25 09:44:14.164402+00	\N	39	\N	open	\N	\N	\N	\N	[]	\N	\N
107	120.791200	14.866400	2026-08-25 12:23:44.905405+00	May sunog na nangyari dahil sa short circuit, malakas ang hangin kaya kumakalat. 3 bahay na apektado, may mga bata sa loob.	48	\N	open	\N	\N	\N	\N	[]	\N	\N
126	120.772036	14.910185	2026-08-25 16:26:57.516774+00	Natumba ang maliit na puno sa bakuran dahil sa malakas na hangin.	69	A small tree fell in the backyard due to strong winds, posing potential risk to the single-floor residence.	open	\N	medium	typhoon	1	["Dispatch local barangay tanods to clear the fallen tree", "Inspect the property for any roof or structural damage", "Advise resident to stay indoors until winds subside"]	2026-08-25 16:26:59.744671+00	{"ai_summary": "A small tree fell in the backyard due to strong winds, posing potential risk to the single-floor residence.", "ai_severity": "medium", "ai_action_plan": ["Dispatch local barangay tanods to clear the fallen tree", "Inspect the property for any roof or structural damage", "Advise resident to stay indoors until winds subside"], "ai_disaster_type": "typhoon", "ai_people_estimate": 1}
109	120.791200	14.866400	2026-08-25 12:33:40.892802+00	May sunog na nangyari dahil sa short circuit, malakas ang hangin kaya kumakalat. 3 bahay na apektado, may mga bata sa loob.	48	A large residential fire caused by a short circuit is spreading rapidly due to strong winds, affecting multiple houses with children trapped inside.	open	\N	critical	fire	10	["Dispatch multiple fire trucks and emergency medical services to the location immediately.", "Conduct urgent search and rescue operations to evacuate children and residents from the affected houses.", "Establish a perimeter to manage the spread and ensure public safety."]	2026-08-25 12:33:48.42089+00	{"ai_summary": "A large residential fire caused by a short circuit is spreading rapidly due to strong winds, affecting multiple houses with children trapped inside.", "ai_severity": "critical", "ai_action_plan": ["Dispatch multiple fire trucks and emergency medical services to the location immediately.", "Conduct urgent search and rescue operations to evacuate children and residents from the affected houses.", "Establish a perimeter to manage the spread and ensure public safety."], "ai_disaster_type": "fire", "ai_people_estimate": 10}
111	120.858163	14.904654	2026-08-25 14:38:41.769379+00	palihug tabangi ang akong pamilya ug ako nangamatay	27	\N	open	\N	\N	\N	\N	[]	\N	\N
110	120.791200	14.866400	2026-08-25 13:28:54.732481+00	May sunog na nangyari dahil sa short circuit, malakas ang hangin kaya kumakalat. 3 bahay na apektado, may mga bata sa loob.	48	A major fire caused by a short circuit is rapidly spreading due to strong winds, affecting multiple houses with children trapped inside.	open	\N	critical	fire	10	["Dispatch multiple fire trucks and rescue units to the location immediately.", "Deploy search and rescue teams to evacuate children and residents trapped in the affected houses.", "Coordinate with local medical responders for burn treatment and smoke inhalation triage."]	2026-08-25 13:29:00.790563+00	{"ai_summary": "A major fire caused by a short circuit is rapidly spreading due to strong winds, affecting multiple houses with children trapped inside.", "ai_severity": "critical", "ai_action_plan": ["Dispatch multiple fire trucks and rescue units to the location immediately.", "Deploy search and rescue teams to evacuate children and residents trapped in the affected houses.", "Coordinate with local medical responders for burn treatment and smoke inhalation triage."], "ai_disaster_type": "fire", "ai_people_estimate": 10}
113	120.792713	14.871968	2026-08-25 14:47:09.020688+00	\N	43	Emergency report from a young male resident with cognitive disabilities and pets, living in a single-floor house in Malolos prone to severe risks.	open	\N	high	flood	1	["Dispatch local rescue team to the specified coordinates in Barangay Nigga, Malolos.", "Prioritize evacuation assistance considering the resident's cognitive disability and pets.", "Transport the individual and pets to the nearest designated evacuation center."]	2026-08-25 14:47:12.318842+00	{"ai_summary": "Emergency report from a young male resident with cognitive disabilities and pets, living in a single-floor house in Malolos prone to severe risks.", "ai_severity": "high", "ai_action_plan": ["Dispatch local rescue team to the specified coordinates in Barangay Nigga, Malolos.", "Prioritize evacuation assistance considering the resident's cognitive disability and pets.", "Transport the individual and pets to the nearest designated evacuation center."], "ai_disaster_type": "flood", "ai_people_estimate": 1}
112	120.858163	14.904654	2026-08-25 14:43:50.405394+00	palihug tabangi, ang akong pamilya ug ako nangamatay	27	Severe typhoon causing widespread flooding and high-wind damage to residential areas, directly threatening vulnerable ground-floor residents.	open	\N	critical	typhoon	1	["Dispatch emergency rescue watercraft to Barangay Paltao immediately", "Assist visually impaired resident and evacuate along with pet", "Provide medical and shelter support for displaced flood victims"]	2026-08-25 14:44:30.046383+00	{"ai_summary": "Severe typhoon causing widespread flooding and high-wind damage to residential areas, directly threatening vulnerable ground-floor residents.", "ai_severity": "critical", "ai_action_plan": ["Dispatch emergency rescue watercraft to Barangay Paltao immediately", "Assist visually impaired resident and evacuate along with pet", "Provide medical and shelter support for displaced flood victims"], "ai_disaster_type": "typhoon", "ai_people_estimate": 1}
114	120.792713	14.871968	2026-08-25 14:52:09.378237+00	\N	26	The reporter is a 21-year-old living in a single-floor house in Barangay Caniogan, Malolos, with multiple pets, placing them at high risk during flood or typhoon events.	open	\N	high	flood	1	["Dispatch rescue team to Barangay Caniogan, Malolos", "Assist single-floor resident and secure pets", "Provide immediate evacuation to higher ground"]	2026-08-25 14:52:11.368833+00	{"ai_summary": "The reporter is a 21-year-old living in a single-floor house in Barangay Caniogan, Malolos, with multiple pets, placing them at high risk during flood or typhoon events.", "ai_severity": "high", "ai_action_plan": ["Dispatch rescue team to Barangay Caniogan, Malolos", "Assist single-floor resident and secure pets", "Provide immediate evacuation to higher ground"], "ai_disaster_type": "flood", "ai_people_estimate": 1}
144	120.831958	14.856679	2026-08-25 18:07:17.449464+00	May maliit na tagas sa bubong dahil sa ulan, nakontrol na gamit ang basin.	68	A small roof leak caused by rain was reported and has already been controlled using a basin.	open	\N	low	typhoon	1	["Log the minor incident for monitoring", "Advise the resident to inspect the roof after the rain stops", "No immediate emergency dispatch required"]	2026-08-25 18:07:19.960502+00	{"ai_summary": "A small roof leak caused by rain was reported and has already been controlled using a basin.", "ai_severity": "low", "ai_action_plan": ["Log the minor incident for monitoring", "Advise the resident to inspect the roof after the rain stops", "No immediate emergency dispatch required"], "ai_disaster_type": "typhoon", "ai_people_estimate": 1}
145	120.836140	14.856679	2026-08-25 18:07:19.157398+00	Nagpapalit-palit ang kuryente pero walang ibang problema sa bahay.	59	The reporter's single-floor house in Bulacan is at immediate risk due to severe flooding conditions in the area.	open	\N	critical	flood	1	["Dispatch water rescue team to Barangay p06_liza, Bulacan coordinates", "Prioritize evacuation for single-floor residents", "Provide immediate medical and shelter assistance"]	2026-08-25 18:07:21.881005+00	{"ai_summary": "The reporter's single-floor house in Bulacan is at immediate risk due to severe flooding conditions in the area.", "ai_severity": "critical", "ai_action_plan": ["Dispatch water rescue team to Barangay p06_liza, Bulacan coordinates", "Prioritize evacuation for single-floor residents", "Provide immediate medical and shelter assistance"], "ai_disaster_type": "flood", "ai_people_estimate": 1}
148	120.774128	14.905164	2026-08-25 18:07:24.310221+00	Papalapit na ang baha sa bahay, kaya pa naming lumikas nang mag-isa kung kakailanganin.	61	\N	open	\N	\N	\N	\N	[]	\N	\N
115	120.791200	14.866400	2026-08-25 15:20:20.693004+00	May sunog na nangyari dahil sa short circuit, malakas ang hangin kaya kumakalat. 3 bahay na apektado, may mga bata sa loob.	48	A large residential fire caused by a short circuit is spreading rapidly due to strong winds, affecting multiple houses with children trapped inside.	open	\N	critical	fire	10	["Dispatch multiple fire trucks immediately to contain the spreading fire.", "Deploy search and rescue teams to evacuate children and residents trapped in affected homes.", "Coordinate with local medical services and barangay officials for emergency triage and evacuation shelter setup."]	2026-08-25 15:20:27.155845+00	{"ai_summary": "A large residential fire caused by a short circuit is spreading rapidly due to strong winds, affecting multiple houses with children trapped inside.", "ai_severity": "critical", "ai_action_plan": ["Dispatch multiple fire trucks immediately to contain the spreading fire.", "Deploy search and rescue teams to evacuate children and residents trapped in affected homes.", "Coordinate with local medical services and barangay officials for emergency triage and evacuation shelter setup."], "ai_disaster_type": "fire", "ai_people_estimate": 10}
119	120.829496	14.878707	2026-08-25 16:26:31.724039+00	Unti-unting umuulan, wala pang baha sa labas, nagbabantay lang bilang paalala sa bagyo.	53	Heavy rainfall is ongoing in Bulacan, though no flooding is reported outside yet as the resident monitors the storm conditions from a one-floor house.	open	\N	medium	typhoon	1	["Monitor water levels continuously outside the house", "Prepare evacuation essentials in case water rises rapidly due to single-floor vulnerability", "Stay tuned to local weather advisories and barangay alerts"]	2026-08-25 16:26:39.009114+00	{"ai_summary": "Heavy rainfall is ongoing in Bulacan, though no flooding is reported outside yet as the resident monitors the storm conditions from a one-floor house.", "ai_severity": "medium", "ai_action_plan": ["Monitor water levels continuously outside the house", "Prepare evacuation essentials in case water rises rapidly due to single-floor vulnerability", "Stay tuned to local weather advisories and barangay alerts"], "ai_disaster_type": "typhoon", "ai_people_estimate": 1}
116	120.829496	14.878707	2026-08-25 15:48:48.527867+00	Unti-unting umuulan, wala pang baha sa labas, nagbabantay lang bilang paalala sa bagyo.	53	Light rain is beginning to fall with no flooding outside yet, and the resident is monitoring the typhoon situation from a single-floor house.	open	\N	low	typhoon	1	["Monitor local weather updates and typhoon advisories", "Prepare emergency Go Bag and secure important documents", "Stay alert for rapid water level changes due to single-floor residence"]	2026-08-25 15:48:51.50433+00	{"ai_summary": "Light rain is beginning to fall with no flooding outside yet, and the resident is monitoring the typhoon situation from a single-floor house.", "ai_severity": "low", "ai_action_plan": ["Monitor local weather updates and typhoon advisories", "Prepare emergency Go Bag and secure important documents", "Stay alert for rapid water level changes due to single-floor residence"], "ai_disaster_type": "typhoon", "ai_people_estimate": 1}
117	120.929025	14.994596	2026-08-25 15:57:10.151884+00	\N	39	\N	open	\N	\N	\N	\N	[]	\N	\N
118	120.929025	14.994596	2026-08-25 15:57:10.498137+00	\N	39	\N	open	\N	\N	\N	\N	[]	\N	\N
120	120.829496	14.872707	2026-08-25 16:26:37.062332+00	Maputik ang kalsada sa labas ng bahay pero wala pang baha, dumadaan lang ang mga sasakyan nang maingat.	67	The reporter notes that the road outside is muddy due to recent conditions, but there is no flood yet and vehicles are passing carefully.	open	\N	low	flood	1	["Monitor local weather and rainfall updates closely", "Prepare emergency kits in case conditions worsen", "Advise the resident in the single-floor house to stay alert for rapid water level changes"]	2026-08-25 16:26:39.806316+00	{"ai_summary": "The reporter notes that the road outside is muddy due to recent conditions, but there is no flood yet and vehicles are passing carefully.", "ai_severity": "low", "ai_action_plan": ["Monitor local weather and rainfall updates closely", "Prepare emergency kits in case conditions worsen", "Advise the resident in the single-floor house to stay alert for rapid water level changes"], "ai_disaster_type": "flood", "ai_people_estimate": 1}
121	120.823496	14.878707	2026-08-25 16:26:41.158151+00	Natumba ang mga halaman sa bakuran dahil sa hangin, walang ibang naapektuhan.	62	Strong winds knocked over potted plants in the backyard, but no other damage or injuries were reported.	open	\N	low	typhoon	1	["Assess the backyard for any other unsecured objects or debris.", "Re-pot or secure undamaged plants.", "Monitor local weather updates for sustained strong winds."]	2026-08-25 16:26:46.670514+00	{"ai_summary": "Strong winds knocked over potted plants in the backyard, but no other damage or injuries were reported.", "ai_severity": "low", "ai_action_plan": ["Assess the backyard for any other unsecured objects or debris.", "Re-pot or secure undamaged plants.", "Monitor local weather updates for sustained strong winds."], "ai_disaster_type": "typhoon", "ai_people_estimate": 1}
123	120.834049	14.861700	2026-08-25 16:26:48.615744+00	May maliit na tagas sa bubong dahil sa ulan, nakontrol na gamit ang basin.	68	A small roof leak caused by rain is currently contained using a basin in a single-floor residence.	open	\N	low	other	1	["Monitor the container to ensure it does not overflow.", "Inspect the roof exterior for damage once weather permits.", "Contact maintenance or a professional roofer for permanent repairs."]	2026-08-25 16:26:55.187631+00	{"ai_summary": "A small roof leak caused by rain is currently contained using a basin in a single-floor residence.", "ai_severity": "low", "ai_action_plan": ["Monitor the container to ensure it does not overflow.", "Inspect the roof exterior for damage once weather permits.", "Contact maintenance or a professional roofer for permanent repairs."], "ai_disaster_type": "other", "ai_people_estimate": 1}
122	120.823496	14.872707	2026-08-25 16:26:45.024331+00	Bukung-bukong lang ang tubig sa bakuran, binabantayan ang taas ng baha.	58	A resident monitors rising floodwaters reaching ankle-deep inside a one-floor residential structure, attempting to block water using plastic sheeting at the doorway.	open	\N	medium	flood	1	["Dispatch monitoring team to assess water level trends in Barangay p04_grace, Bulacan", "Advise occupant to prepare for possible evacuation if flood levels continue to rise", "Ensure safety of electrical outlets and appliances above flood level"]	2026-08-25 16:26:50.935557+00	{"ai_summary": "A resident monitors rising floodwaters reaching ankle-deep inside a one-floor residential structure, attempting to block water using plastic sheeting at the doorway.", "ai_severity": "medium", "ai_action_plan": ["Dispatch monitoring team to assess water level trends in Barangay p04_grace, Bulacan", "Advise occupant to prepare for possible evacuation if flood levels continue to rise", "Ensure safety of electrical outlets and appliances above flood level"], "ai_disaster_type": "flood", "ai_people_estimate": 1}
124	120.836649	14.857200	2026-08-25 16:26:53.323826+00	Nagpapalit-palit ang kuryente pero walang ibang problema sa bahay.	59	The reporter experienced fluctuating electricity in a single-floor house in Bulacan with no other reported house damage.	open	\N	low	other	1	["Log the power fluctuation report for monitoring", "Advise the resident to check appliances and avoid electrical hazards", "Coordinate with the local electric cooperative if widespread issues occur"]	2026-08-25 16:26:56.369914+00	{"ai_summary": "The reporter experienced fluctuating electricity in a single-floor house in Bulacan with no other reported house damage.", "ai_severity": "low", "ai_action_plan": ["Log the power fluctuation report for monitoring", "Advise the resident to check appliances and avoid electrical hazards", "Coordinate with the local electric cooperative if widespread issues occur"], "ai_disaster_type": "other", "ai_people_estimate": 1}
125	120.831449	14.857200	2026-08-25 16:26:55.641312+00	Baha na hanggang bukong-bukong sa kalsada, tuloy-tuloy pa ang ulan.	72	Flooding has reached ankle-deep levels on the road in Bulacan as continuous heavy rain persists.	open	\N	medium	flood	4	["Monitor water level progression in the area", "Advise residents to stay alert and prepare for possible evacuation if rain continues", "Dispatch local monitoring unit to assess flood persistence"]	2026-08-25 16:26:57.783582+00	{"ai_summary": "Flooding has reached ankle-deep levels on the road in Bulacan as continuous heavy rain persists.", "ai_severity": "medium", "ai_action_plan": ["Monitor water level progression in the area", "Advise residents to stay alert and prepare for possible evacuation if rain continues", "Dispatch local monitoring unit to assess flood persistence"], "ai_disaster_type": "flood", "ai_people_estimate": 4}
127	120.774636	14.905685	2026-08-25 16:26:59.478177+00	Papalapit na ang baha sa bahay, kaya pa naming lumikas nang mag-isa kung kakailanganin.	61	An elderly male resident reports rising floodwaters approaching his single-story house in Bulacan, though he is currently able to evacuate independently if necessary.	open	\N	high	flood	1	["Dispatch a local rescue team to check on the 66-year-old resident at the specified coordinates.", "Assist the resident with immediate evacuation due to vulnerability and single-story housing.", "Monitor water level progression in Barangay p09_wilfredo, Bulacan."]	2026-08-25 16:27:02.320579+00	{"ai_summary": "An elderly male resident reports rising floodwaters approaching his single-story house in Bulacan, though he is currently able to evacuate independently if necessary.", "ai_severity": "high", "ai_action_plan": ["Dispatch a local rescue team to check on the 66-year-old resident at the specified coordinates.", "Assist the resident with immediate evacuation due to vulnerability and single-story housing.", "Monitor water level progression in Barangay p09_wilfredo, Bulacan."], "ai_disaster_type": "flood", "ai_people_estimate": 1}
128	120.929005	14.994553	2026-08-25 17:20:25.745765+00	\N	39	\N	open	\N	\N	\N	\N	[]	\N	\N
129	120.929005	14.994553	2026-08-25 17:45:58.707304+00	\N	39	\N	open	\N	\N	\N	\N	[]	\N	\N
130	120.929005	14.994553	2026-08-25 17:45:59.072192+00	Tite	39	\N	open	\N	\N	\N	\N	[]	\N	\N
133	120.823496	14.878707	2026-08-25 17:55:32.742835+00	Natumba ang mga halaman sa bakuran dahil sa hangin, walang ibang naapektuhan.	62	Strong winds knocked down plants in the yard, with no other damage or individuals affected.	open	\N	low	typhoon	1	["Log the minor incident report for local monitoring", "Advise the reporter to secure loose outdoor items", "No immediate field response required"]	2026-08-25 17:55:34.788147+00	{"ai_summary": "Strong winds knocked down plants in the yard, with no other damage or individuals affected.", "ai_severity": "low", "ai_action_plan": ["Log the minor incident report for local monitoring", "Advise the reporter to secure loose outdoor items", "No immediate field response required"], "ai_disaster_type": "typhoon", "ai_people_estimate": 1}
131	120.829496	14.878707	2026-08-25 17:55:26.749493+00	Unti-unting umuulan, wala pang baha sa labas, nagbabantay lang bilang paalala sa bagyo.	53	Light rain is beginning to fall in Bulacan with no flooding outside yet, and the resident is monitoring the typhoon situation from a single-floor home.	open	\N	low	typhoon	1	["Log the monitoring status in the disaster response database", "Send local weather and typhoon updates to the reporter", "Advise preparation for potential evacuation if rainfall intensifies"]	2026-08-25 17:55:30.35734+00	{"ai_summary": "Light rain is beginning to fall in Bulacan with no flooding outside yet, and the resident is monitoring the typhoon situation from a single-floor home.", "ai_severity": "low", "ai_action_plan": ["Log the monitoring status in the disaster response database", "Send local weather and typhoon updates to the reporter", "Advise preparation for potential evacuation if rainfall intensifies"], "ai_disaster_type": "typhoon", "ai_people_estimate": 1}
132	120.829496	14.872707	2026-08-25 17:55:30.336714+00	Maputik ang kalsada sa labas ng bahay pero wala pang baha, dumadaan lang ang mga sasakyan nang maingat.	67	The reporter notes that the street outside is muddy due to recent conditions, but there is no flood yet and vehicles are passing carefully.	open	\N	low	flood	1	["Monitor local weather and road conditions for changes", "Advise the resident to stay alert given the low-lying 1-floor house status", "Keep emergency channels open in case conditions deteriorate"]	2026-08-25 17:55:32.575615+00	{"ai_summary": "The reporter notes that the street outside is muddy due to recent conditions, but there is no flood yet and vehicles are passing carefully.", "ai_severity": "low", "ai_action_plan": ["Monitor local weather and road conditions for changes", "Advise the resident to stay alert given the low-lying 1-floor house status", "Keep emergency channels open in case conditions deteriorate"], "ai_disaster_type": "flood", "ai_people_estimate": 1}
135	120.834049	14.861700	2026-08-25 17:55:37.743295+00	May maliit na tagas sa bubong dahil sa ulan, nakontrol na gamit ang basin.	68	Emergency report from a 33-year-old male residing in a single-floor house in Bulacan indicating a disaster situation.	open	\N	high	flood	1	["Dispatch local rescue team to the specified location in Bulacan", "Advise the reporter to move to higher ground immediately due to single-floor residence risk", "Establish communication with local barangay disaster operations center for rapid assessment"]	2026-08-25 17:55:39.791016+00	{"ai_summary": "Emergency report from a 33-year-old male residing in a single-floor house in Bulacan indicating a disaster situation.", "ai_severity": "high", "ai_action_plan": ["Dispatch local rescue team to the specified location in Bulacan", "Advise the reporter to move to higher ground immediately due to single-floor residence risk", "Establish communication with local barangay disaster operations center for rapid assessment"], "ai_disaster_type": "flood", "ai_people_estimate": 1}
134	120.823496	14.872707	2026-08-25 17:55:35.431556+00	Bukung-bukong lang ang tubig sa bakuran, binabantayan ang taas ng baha.	58	Floodwaters are at ankle-deep level in the yard and the resident is closely monitoring the rising water. Due to living in a single-floor house, there is a risk of inundation if waters continue to rise.	open	\N	medium	flood	1	["Monitor water level closely and prepare for possible evacuation", "Elevate important belongings and electrical appliances", "Ensure mobile phones are charged and emergency contacts are ready"]	2026-08-25 17:55:38.554315+00	{"ai_summary": "Floodwaters are at ankle-deep level in the yard and the resident is closely monitoring the rising water. Due to living in a single-floor house, there is a risk of inundation if waters continue to rise.", "ai_severity": "medium", "ai_action_plan": ["Monitor water level closely and prepare for possible evacuation", "Elevate important belongings and electrical appliances", "Ensure mobile phones are charged and emergency contacts are ready"], "ai_disaster_type": "flood", "ai_people_estimate": 1}
136	120.836649	14.857200	2026-08-25 17:55:39.811249+00	Nagpapalit-palit ang kuryente pero walang ibang problema sa bahay.	59	The reporter is experiencing fluctuating power supply in a single-floor house located in Bulacan, with no other household issues reported.	open	\N	low	other	1	["Log the power fluctuation report in the system", "Advise the resident to monitor electrical appliances to prevent damage", "Forward the power stability concern to the local electric cooperative"]	2026-08-25 17:55:42.222768+00	{"ai_summary": "The reporter is experiencing fluctuating power supply in a single-floor house located in Bulacan, with no other household issues reported.", "ai_severity": "low", "ai_action_plan": ["Log the power fluctuation report in the system", "Advise the resident to monitor electrical appliances to prevent damage", "Forward the power stability concern to the local electric cooperative"], "ai_disaster_type": "other", "ai_people_estimate": 1}
137	120.831449	14.857200	2026-08-25 17:55:42.15593+00	Baha na hanggang bukong-bukong sa kalsada, tuloy-tuloy pa ang ulan.	72	Emergency report indicates a disaster situation in Bulacan requiring assessment and potential response based on location context.	open	\N	medium	flood	4	["Dispatch local barangay tanod to verify the situation at the specified coordinates in Bulacan", "Contact the reporter to confirm current safety status and immediate needs", "Prepare rescue or relief deployment if water levels rise threatening the two-floor residence"]	2026-08-25 17:55:44.404864+00	{"ai_summary": "Emergency report indicates a disaster situation in Bulacan requiring assessment and potential response based on location context.", "ai_severity": "medium", "ai_action_plan": ["Dispatch local barangay tanod to verify the situation at the specified coordinates in Bulacan", "Contact the reporter to confirm current safety status and immediate needs", "Prepare rescue or relief deployment if water levels rise threatening the two-floor residence"], "ai_disaster_type": "flood", "ai_people_estimate": 4}
139	120.774636	14.905685	2026-08-25 17:55:45.545765+00	Papalapit na ang baha sa bahay, kaya pa naming lumikas nang mag-isa kung kakailanganin.	61	\N	open	\N	\N	\N	\N	[]	\N	\N
138	120.772036	14.910185	2026-08-25 17:55:43.770195+00	Natumba ang maliit na puno sa bakuran dahil sa malakas na hangin.	69	A small tree fell in the backyard due to strong winds, posing potential risk to the single-floor residence.	open	\N	medium	typhoon	1	["Dispatch barangay tanods to assess and clear the fallen tree", "Check for any damage to power lines or the house structure", "Advise the resident to remain indoors while winds are strong"]	2026-08-25 17:55:46.72419+00	{"ai_summary": "A small tree fell in the backyard due to strong winds, posing potential risk to the single-floor residence.", "ai_severity": "medium", "ai_action_plan": ["Dispatch barangay tanods to assess and clear the fallen tree", "Check for any damage to power lines or the house structure", "Advise the resident to remain indoors while winds are strong"], "ai_disaster_type": "typhoon", "ai_people_estimate": 1}
143	120.828587	14.877728	2026-08-25 18:07:15.828382+00	Bukung-bukong lang ang tubig sa bakuran, binabantayan ang taas ng baha.	58	Floodwater has reached ankle-deep in the yard of a single-floor residence, with the resident monitoring rising water levels.	open	\N	medium	flood	1	["Monitor water levels closely given the single-floor residence vulnerability", "Prepare emergency Go Bag and important documents", "Stay alert for evacuation advisories from local barangay officials"]	2026-08-25 18:07:18.122051+00	{"ai_summary": "Floodwater has reached ankle-deep in the yard of a single-floor residence, with the resident monitoring rising water levels.", "ai_severity": "medium", "ai_action_plan": ["Monitor water levels closely given the single-floor residence vulnerability", "Prepare emergency Go Bag and important documents", "Stay alert for evacuation advisories from local barangay officials"], "ai_disaster_type": "flood", "ai_people_estimate": 1}
140	120.824405	14.873686	2026-08-25 18:07:09.591578+00	Unti-unting umuulan, wala pang baha sa labas, nagbabantay lang bilang paalala sa bagyo.	53	Severe flooding reported by a 24-year-old female resident living in a single-floor house in Bulacan, placing her at high risk due to water levels potentially inundating the home.	open	\N	critical	flood	1	["Dispatch rescue boat to coordinates 14.873686, 120.824405 in Bulacan for immediate extraction", "Advise the resident to move to the roof or highest elevated area if water continues to rise", "Alert local Barangay p01_ana disaster response teams of a trapped resident in a single-floor house"]	2026-08-25 18:07:13.080511+00	{"ai_summary": "Severe flooding reported by a 24-year-old female resident living in a single-floor house in Bulacan, placing her at high risk due to water levels potentially inundating the home.", "ai_severity": "critical", "ai_action_plan": ["Dispatch rescue boat to coordinates 14.873686, 120.824405 in Bulacan for immediate extraction", "Advise the resident to move to the roof or highest elevated area if water continues to rise", "Alert local Barangay p01_ana disaster response teams of a trapped resident in a single-floor house"], "ai_disaster_type": "flood", "ai_people_estimate": 1}
142	120.824405	14.877728	2026-08-25 18:07:14.168606+00	Natumba ang mga halaman sa bakuran dahil sa hangin, walang ibang naapektuhan.	62	Potted plants in the backyard were toppled by strong winds with no other damage reported.	open	\N	low	typhoon	1	["Log the incident report", "Monitor weather updates in the area", "Advise the resident to secure loose outdoor items"]	2026-08-25 18:07:16.477362+00	{"ai_summary": "Potted plants in the backyard were toppled by strong winds with no other damage reported.", "ai_severity": "low", "ai_action_plan": ["Log the incident report", "Monitor weather updates in the area", "Advise the resident to secure loose outdoor items"], "ai_disaster_type": "typhoon", "ai_people_estimate": 1}
141	120.828587	14.873686	2026-08-25 18:07:12.0892+00	Maputik ang kalsada sa labas ng bahay pero wala pang baha, dumadaan lang ang mga sasakyan nang maingat.	67	The reporter notes that the road outside is muddy due to recent conditions, but there is no flood yet and vehicles are passing carefully.	open	\N	low	flood	1	["Monitor local weather and road conditions for changes", "Advise reporter to remain alert given single-floor residence", "Log report for area surveillance"]	2026-08-25 18:07:14.467364+00	{"ai_summary": "The reporter notes that the road outside is muddy due to recent conditions, but there is no flood yet and vehicles are passing carefully.", "ai_severity": "low", "ai_action_plan": ["Monitor local weather and road conditions for changes", "Advise reporter to remain alert given single-floor residence", "Log report for area surveillance"], "ai_disaster_type": "flood", "ai_people_estimate": 1}
146	120.831958	14.860721	2026-08-25 18:07:20.880507+00	Baha na hanggang bukong-bukong sa kalsada, tuloy-tuloy pa ang ulan.	72	Ankle-deep flooding reported on the road with continuous rain in Bulacan. The reporter resides in a two-floor house.	open	\N	low	flood	1	["Monitor water level progression", "Advise residents to stay indoors and secure electrical appliances", "Prepare for potential evacuation if rainfall intensifies"]	2026-08-25 18:07:23.57688+00	{"ai_summary": "Ankle-deep flooding reported on the road with continuous rain in Bulacan. The reporter resides in a two-floor house.", "ai_severity": "low", "ai_action_plan": ["Monitor water level progression", "Advise residents to stay indoors and secure electrical appliances", "Prepare for potential evacuation if rainfall intensifies"], "ai_disaster_type": "flood", "ai_people_estimate": 1}
147	120.769944	14.905164	2026-08-25 18:07:22.60775+00	Natumba ang maliit na puno sa bakuran dahil sa malakas na hangin.	69	A small tree fell in the backyard due to strong winds, presenting a potential hazard to the single-floor residence.	open	\N	low	typhoon	1	["Dispatch barangay maintenance crew to clear the fallen tree", "Inspect the property for any structural damage caused by the winds", "Monitor local weather updates for further strong winds"]	2026-08-25 18:07:25.148936+00	{"ai_summary": "A small tree fell in the backyard due to strong winds, presenting a potential hazard to the single-floor residence.", "ai_severity": "low", "ai_action_plan": ["Dispatch barangay maintenance crew to clear the fallen tree", "Inspect the property for any structural damage caused by the winds", "Monitor local weather updates for further strong winds"], "ai_disaster_type": "typhoon", "ai_people_estimate": 1}
151	120.825799	14.876381	2026-08-25 18:23:13.231934+00	Natumba ang mga halaman sa bakuran dahil sa hangin, walang ibang naapektuhan.	62	Emergency report indicates a disaster situation in Bulacan requiring assessment and potential response based on location and reporter profile.	open	\N	medium	flood	2	["Dispatch local barangay unit to verify status at coordinates 14.876381, 120.825799", "Contact reporter to confirm immediate safety and water levels", "Prepare evacuation support if floodwaters rise to the second floor"]	2026-08-25 18:23:16.545921+00	{"ai_summary": "Emergency report indicates a disaster situation in Bulacan requiring assessment and potential response based on location and reporter profile.", "ai_severity": "medium", "ai_action_plan": ["Dispatch local barangay unit to verify status at coordinates 14.876381, 120.825799", "Contact reporter to confirm immediate safety and water levels", "Prepare evacuation support if floodwaters rise to the second floor"], "ai_disaster_type": "flood", "ai_people_estimate": 2}
152	120.827193	14.876381	2026-08-25 18:23:14.887439+00	Bukung-bukong lang ang tubig sa bakuran, binabantayan ang taas ng baha.	58	Floodwaters are at ankle-deep level in the yard and the resident is closely monitoring the rising water. Living in a single-floor house increases vulnerability to further flooding.	open	\N	medium	flood	1	["Monitor flood water levels continuously", "Prepare emergency Go Bag and move valuables to higher surfaces", "Standby for potential evacuation if water levels rise to critical heights"]	2026-08-25 18:23:17.709878+00	{"ai_summary": "Floodwaters are at ankle-deep level in the yard and the resident is closely monitoring the rising water. Living in a single-floor house increases vulnerability to further flooding.", "ai_severity": "medium", "ai_action_plan": ["Monitor flood water levels continuously", "Prepare emergency Go Bag and move valuables to higher surfaces", "Standby for potential evacuation if water levels rise to critical heights"], "ai_disaster_type": "flood", "ai_people_estimate": 1}
149	120.825799	14.875033	2026-08-25 18:23:08.757226+00	Unti-unting umuulan, wala pang baha sa labas, nagbabantay lang bilang paalala sa bagyo.	53	A 24-year-old resident living in a single-floor house in Bulacan requires immediate assistance due to rising floodwaters.	open	\N	critical	flood	1	["Dispatch water rescue team to coordinates 14.875033, 120.825799", "Advise reporter to move to the highest possible area of the single-floor house", "Coordinate with Barangay p01_ana local disaster risk reduction and management office"]	2026-08-25 18:23:13.027609+00	{"ai_summary": "A 24-year-old resident living in a single-floor house in Bulacan requires immediate assistance due to rising floodwaters.", "ai_severity": "critical", "ai_action_plan": ["Dispatch water rescue team to coordinates 14.875033, 120.825799", "Advise reporter to move to the highest possible area of the single-floor house", "Coordinate with Barangay p01_ana local disaster risk reduction and management office"], "ai_disaster_type": "flood", "ai_people_estimate": 1}
150	120.827193	14.875033	2026-08-25 18:23:11.524578+00	Maputik ang kalsada sa labas ng bahay pero wala pang baha, dumadaan lang ang mga sasakyan nang maingat.	67	The road outside the house is muddy due to weather conditions, but there is no flood yet and vehicles are passing carefully.	open	\N	low	flood	1	["Monitor weather updates and local water levels", "Prepare emergency Go-Bag in case conditions worsen", "Advise residents to stay alert for potential flash floods"]	2026-08-25 18:23:14.927743+00	{"ai_summary": "The road outside the house is muddy due to weather conditions, but there is no flood yet and vehicles are passing carefully.", "ai_severity": "low", "ai_action_plan": ["Monitor weather updates and local water levels", "Prepare emergency Go-Bag in case conditions worsen", "Advise residents to stay alert for potential flash floods"], "ai_disaster_type": "flood", "ai_people_estimate": 1}
153	120.833352	14.858026	2026-08-25 18:23:19.035913+00	May maliit na tagas sa bubong dahil sa ulan, nakontrol na gamit ang basin.	68	Emergency report in Bulacan involving a male resident living in a single-floor house, facing heightened vulnerability due to potential localized hazards.	open	\N	high	flood	1	["Dispatch local rescue unit to check on the single-floor residence in Bulacan", "Assess immediate water levels and evacuation needs for the reporter", "Provide instructions on safe elevation and emergency contacts"]	2026-08-25 18:23:24.369041+00	{"ai_summary": "Emergency report in Bulacan involving a male resident living in a single-floor house, facing heightened vulnerability due to potential localized hazards.", "ai_severity": "high", "ai_action_plan": ["Dispatch local rescue unit to check on the single-floor residence in Bulacan", "Assess immediate water levels and evacuation needs for the reporter", "Provide instructions on safe elevation and emergency contacts"], "ai_disaster_type": "flood", "ai_people_estimate": 1}
154	120.834746	14.858026	2026-08-25 18:23:23.75783+00	Nagpapalit-palit ang kuryente pero walang ibang problema sa bahay.	59	The reporter notes intermittent power fluctuations at her single-story residence in Bulacan with no other reported issues.	open	\N	low	other	1	["Log the power fluctuation report for grid monitoring", "Advise the resident to monitor appliances and unplug sensitive electronics", "Notify the local electric cooperative of potential local electrical instability"]	2026-08-25 18:23:27.832113+00	{"ai_summary": "The reporter notes intermittent power fluctuations at her single-story residence in Bulacan with no other reported issues.", "ai_severity": "low", "ai_action_plan": ["Log the power fluctuation report for grid monitoring", "Advise the resident to monitor appliances and unplug sensitive electronics", "Notify the local electric cooperative of potential local electrical instability"], "ai_disaster_type": "other", "ai_people_estimate": 1}
156	120.771339	14.906511	2026-08-25 18:23:28.618065+00	Natumba ang maliit na puno sa bakuran dahil sa malakas na hangin.	69	A small tree fell in the backyard due to strong winds, posing a potential hazard to the single-floor residence.	open	\N	low	typhoon	1	["Dispatch barangay personnel to assess and clear the fallen tree", "Check for any damage to power lines or the house structure", "Advise the resident to stay clear of the area until cleared"]	2026-08-25 18:23:30.724582+00	{"ai_summary": "A small tree fell in the backyard due to strong winds, posing a potential hazard to the single-floor residence.", "ai_severity": "low", "ai_action_plan": ["Dispatch barangay personnel to assess and clear the fallen tree", "Check for any damage to power lines or the house structure", "Advise the resident to stay clear of the area until cleared"], "ai_disaster_type": "typhoon", "ai_people_estimate": 1}
169	120.825962	14.874891	2026-08-25 18:23:47.79747+00	Nasa bubong po ako, leeg-leeg na ang lalim ng baha sa bahay. Matanda po ako, kailangan ng tulong agad.	57	A 72-year-old female trapped on her roof in Bulacan reports neck-deep floodwaters inside her single-floor home and urgently needs rescue.	open	\N	critical	flood	1	["Dispatch an immediate water rescue team to the specified coordinates in Barangay Rosario, Bulacan.", "Prioritize elderly extraction due to neck-deep indoor flooding and single-floor rooftop exposure.", "Coordinate with local disaster risk reduction and management officers (DRRMO) for rapid deployment."]	2026-08-25 18:23:49.766909+00	{"ai_summary": "A 72-year-old female trapped on her roof in Bulacan reports neck-deep floodwaters inside her single-floor home and urgently needs rescue.", "ai_severity": "critical", "ai_action_plan": ["Dispatch an immediate water rescue team to the specified coordinates in Barangay Rosario, Bulacan.", "Prioritize elderly extraction due to neck-deep indoor flooding and single-floor rooftop exposure.", "Coordinate with local disaster risk reduction and management officers (DRRMO) for rapid deployment."], "ai_disaster_type": "flood", "ai_people_estimate": 1}
160	120.847437	14.894546	2026-08-25 18:23:34.488562+00	Natumba ang poste ng kuryente sa harap ng bahay, humaharang sa kalsada at may mga taong naiipit sa daan.	65	A fallen electric utility pole is blocking the road in front of the residence, trapping people and obstructing the path.	open	\N	critical	collapse	4	["Dispatch an emergency rescue team to safely clear the fallen electric pole and free trapped individuals.", "Coordinate with the local power distributor to immediately cut off electricity in the area to prevent electrocution.", "Deploy medical personnel to check on affected residents and provide first aid if necessary."]	2026-08-25 18:23:36.455656+00	{"ai_summary": "A fallen electric utility pole is blocking the road in front of the residence, trapping people and obstructing the path.", "ai_severity": "critical", "ai_action_plan": ["Dispatch an emergency rescue team to safely clear the fallen electric pole and free trapped individuals.", "Coordinate with the local power distributor to immediately cut off electricity in the area to prevent electrocution.", "Deploy medical personnel to check on affected residents and provide first aid if necessary."], "ai_disaster_type": "collapse", "ai_people_estimate": 4}
157	120.772733	14.906511	2026-08-25 18:23:30.323591+00	Papalapit na ang baha sa bahay, kaya pa naming lumikas nang mag-isa kung kakailanganin.	61	Floodwaters are approaching the residence of a 66-year-old male living in a single-floor house in Bulacan, who is currently able to evacuate independently if necessary.	open	\N	high	flood	1	["Dispatch a local rescue team to assist the elderly resident with pre-emptive evacuation.", "Monitor water level progression at the specified location in Bulacan.", "Provide designated evacuation center information and transport support."]	2026-08-25 18:23:32.917983+00	{"ai_summary": "Floodwaters are approaching the residence of a 66-year-old male living in a single-floor house in Bulacan, who is currently able to evacuate independently if necessary.", "ai_severity": "high", "ai_action_plan": ["Dispatch a local rescue team to assist the elderly resident with pre-emptive evacuation.", "Monitor water level progression at the specified location in Bulacan.", "Provide designated evacuation center information and transport support."], "ai_disaster_type": "flood", "ai_people_estimate": 1}
158	120.771339	14.907859	2026-08-25 18:23:31.559412+00	Kalahating metro na ang baha sa loob ng bahay, may mga gamit na nasira.	66	Floodwaters have reached half a meter inside the house, damaging belongings. The 45-year-old female resident lives in a two-story house in Bulacan.	open	\N	high	flood	1	["Advise the resident to move to the second floor of the house for safety", "Turn off main electrical breakers if safe to do so", "Dispatch local rescue boat to check on the resident and assess evacuation needs"]	2026-08-25 18:23:33.619464+00	{"ai_summary": "Floodwaters have reached half a meter inside the house, damaging belongings. The 45-year-old female resident lives in a two-story house in Bulacan.", "ai_severity": "high", "ai_action_plan": ["Advise the resident to move to the second floor of the house for safety", "Turn off main electrical breakers if safe to do so", "Dispatch local rescue boat to check on the resident and assess evacuation needs"], "ai_disaster_type": "flood", "ai_people_estimate": 1}
155	120.833352	14.859374	2026-08-25 18:23:26.936374+00	Baha na hanggang bukong-bukong sa kalsada, tuloy-tuloy pa ang ulan.	72	Emergency report indicates a disaster situation in Bulacan requiring assessment and potential response.	open	\N	medium	flood	4	["Dispatch local barangay response unit to check on the resident at the specified coordinates", "Monitor water levels in Barangay p07_edgar, Bulacan", "Advise resident to prepare for possible evacuation if water levels rise"]	2026-08-25 18:23:29.441812+00	{"ai_summary": "Emergency report indicates a disaster situation in Bulacan requiring assessment and potential response.", "ai_severity": "medium", "ai_action_plan": ["Dispatch local barangay response unit to check on the resident at the specified coordinates", "Monitor water levels in Barangay p07_edgar, Bulacan", "Advise resident to prepare for possible evacuation if water levels rise"], "ai_disaster_type": "flood", "ai_people_estimate": 4}
163	120.864368	14.871859	2026-08-25 18:23:39.061072+00	Dibdib na ang taas ng baha, buntis ako at kailangan ko nang ilikas agad.	60	Chest-deep floodwaters have entered a single-floor residence where a pregnant female reporter is trapped and urgently requires evacuation.	open	\N	critical	flood	1	["Dispatch water rescue boat to the specified coordinates immediately", "Prioritize evacuation of the pregnant resident to a medical facility", "Notify local Barangay p15_rowena disaster response units for on-ground assistance"]	2026-08-25 18:23:41.51105+00	{"ai_summary": "Chest-deep floodwaters have entered a single-floor residence where a pregnant female reporter is trapped and urgently requires evacuation.", "ai_severity": "critical", "ai_action_plan": ["Dispatch water rescue boat to the specified coordinates immediately", "Prioritize evacuation of the pregnant resident to a medical facility", "Notify local Barangay p15_rowena disaster response units for on-ground assistance"], "ai_disaster_type": "flood", "ai_people_estimate": 1}
159	120.846043	14.894546	2026-08-25 18:23:32.786881+00	Baywang na ang baha sa loob ng bahay, may anak akong bata na kasama, kailangan namin ng tulong sa paglikas.	55	Floodwaters have reached waist-deep inside a single-floor house where a 31-year-old mother and her young child are stranded, requiring immediate evacuation assistance.	open	\N	critical	flood	2	["Dispatch water rescue team to coordinates 14.894546, 120.846043 in Barangay p11_jasmin, Bulacan.", "Prioritize evacuation of the mother and young child due to waist-deep indoor flooding in a single-floor residence.", "Provide immediate medical check-up upon rescue and transport to the nearest designated evacuation center."]	2026-08-25 18:23:34.867441+00	{"ai_summary": "Floodwaters have reached waist-deep inside a single-floor house where a 31-year-old mother and her young child are stranded, requiring immediate evacuation assistance.", "ai_severity": "critical", "ai_action_plan": ["Dispatch water rescue team to coordinates 14.894546, 120.846043 in Barangay p11_jasmin, Bulacan.", "Prioritize evacuation of the mother and young child due to waist-deep indoor flooding in a single-floor residence.", "Provide immediate medical check-up upon rescue and transport to the nearest designated evacuation center."], "ai_disaster_type": "flood", "ai_people_estimate": 2}
165	120.864368	14.873207	2026-08-25 18:23:42.00271+00	Halos maanod na ang bahay dahil sa lakas ng agos ng baha, may batang kasama na hindi marunong lumangoy.	63	A house is nearly swept away by strong flood currents, with a young child who cannot swim trapped inside. Immediate water rescue and evacuation are urgently required.	open	\N	critical	flood	2	["Dispatch an emergency water rescue team immediately to the specified coordinates in Bulacan.", "Equip the rescue unit with life vests and swift-water rescue gear to retrieve the trapped woman and child.", "Coordinate with local disaster risk reduction and management (DRRM) units for safe immediate evacuation and medical assistance."]	2026-08-25 18:23:44.094466+00	{"ai_summary": "A house is nearly swept away by strong flood currents, with a young child who cannot swim trapped inside. Immediate water rescue and evacuation are urgently required.", "ai_severity": "critical", "ai_action_plan": ["Dispatch an emergency water rescue team immediately to the specified coordinates in Bulacan.", "Equip the rescue unit with life vests and swift-water rescue gear to retrieve the trapped woman and child.", "Coordinate with local disaster risk reduction and management (DRRM) units for safe immediate evacuation and medical assistance."], "ai_disaster_type": "flood", "ai_people_estimate": 2}
162	120.847437	14.895894	2026-08-25 18:23:37.366839+00	May gumuhong bahagi ng dingding, nasa loob pa ang pamilya at natatakot lumabas dahil sa baha sa labas.	73	A portion of a house wall has collapsed with a family trapped inside, unable to evacuate due to high floodwaters outside.	open	\N	critical	flood	4	["Dispatch water rescue team to the coordinates immediately", "Coordinate with local Bulacan LGU disaster response unit for structural assessment", "Provide immediate medical assistance and safe evacuation for the trapped family"]	2026-08-25 18:23:39.301352+00	{"ai_summary": "A portion of a house wall has collapsed with a family trapped inside, unable to evacuate due to high floodwaters outside.", "ai_severity": "critical", "ai_action_plan": ["Dispatch water rescue team to the coordinates immediately", "Coordinate with local Bulacan LGU disaster response unit for structural assessment", "Provide immediate medical assistance and safe evacuation for the trapped family"], "ai_disaster_type": "flood", "ai_people_estimate": 4}
161	120.846043	14.895894	2026-08-25 18:23:36.14695+00	Nasira ang bahagi ng bubong dahil sa hangin, umuulan sa loob, matanda ako at may kapansanan kaya hirap gumalaw.	70	A 70-year-old female resident with a physical disability reports a damaged roof and indoor flooding caused by strong winds and rain. She lives alone in a single-floor house and is having difficulty moving.	open	\N	critical	typhoon	1	["Dispatch emergency rescue team immediately to the reported location for extraction and medical assistance.", "Coordinate with local Barangay p13_leonora disaster response units to provide temporary shelter and dry clothing.", "Assess structural damage to the single-floor house and arrange for urgent roof repair."]	2026-08-25 18:23:38.661377+00	{"ai_summary": "A 70-year-old female resident with a physical disability reports a damaged roof and indoor flooding caused by strong winds and rain. She lives alone in a single-floor house and is having difficulty moving.", "ai_severity": "critical", "ai_action_plan": ["Dispatch emergency rescue team immediately to the reported location for extraction and medical assistance.", "Coordinate with local Barangay p13_leonora disaster response units to provide temporary shelter and dry clothing.", "Assess structural damage to the single-floor house and arrange for urgent roof repair."], "ai_disaster_type": "typhoon", "ai_people_estimate": 1}
164	120.865762	14.871859	2026-08-25 18:23:40.376569+00	Nagkaroon ng landslide dahil sa tuloy-tuloy na ulan, bahagyang natabunan ang bahay at nasugatan ako.	71	A 55-year-old male with physical disabilities residing in a single-floor house in Bulacan requires urgent evacuation assistance due to an emergency situation.	open	\N	critical	flood	1	["Dispatch local rescue team to coordinates 14.871859, 120.865762 for immediate extraction", "Coordinate with Barangay p16_bayani local disaster risk reduction and management office (LDRRMO)", "Provide medical and mobility assistance upon rescue due to reporter's physical disability and ground-floor residence"]	2026-08-25 18:23:42.320155+00	{"ai_summary": "A 55-year-old male with physical disabilities residing in a single-floor house in Bulacan requires urgent evacuation assistance due to an emergency situation.", "ai_severity": "critical", "ai_action_plan": ["Dispatch local rescue team to coordinates 14.871859, 120.865762 for immediate extraction", "Coordinate with Barangay p16_bayani local disaster risk reduction and management office (LDRRMO)", "Provide medical and mobility assistance upon rescue due to reporter's physical disability and ground-floor residence"], "ai_disaster_type": "flood", "ai_people_estimate": 1}
166	120.854412	14.850248	2026-08-25 18:23:43.215445+00	Naiipit ang buong pamilya sa bubong ng bahay, tumataas pa ang tubig, may sanggol na kasama.	54	An elderly male resident in Bulacan reports a developing emergency situation at his location requiring potential intervention.	open	\N	medium	flood	1	["Contact the reporter to assess current water levels at the specific address", "Alert Barangay p18_danilo local disaster response units to check on the elderly resident", "Prepare for potential evacuation assistance if floodwaters rise to the second floor"]	2026-08-25 18:23:46.062964+00	{"ai_summary": "An elderly male resident in Bulacan reports a developing emergency situation at his location requiring potential intervention.", "ai_severity": "medium", "ai_action_plan": ["Contact the reporter to assess current water levels at the specific address", "Alert Barangay p18_danilo local disaster response units to check on the elderly resident", "Prepare for potential evacuation assistance if floodwaters rise to the second floor"], "ai_disaster_type": "flood", "ai_people_estimate": 1}
167	120.855806	14.850248	2026-08-25 18:23:44.931825+00	Nag-iisa ako sa loob ng bahay na binabaha, may kapansanan ako at nasa wheelchair, hindi na ako makalabas.	64	A 74-year-old female resident with physical and visual disabilities is trapped alone in a wheelchair inside a flooded single-floor house and cannot get out.	open	\N	critical	flood	1	["Dispatch an immediate water rescue team to the specified coordinates in Barangay Remedios, Bulacan.", "Coordinate with local MDRRMO and emergency services for priority evacuation of a vulnerable wheelchair-bound senior citizen.", "Provide medical triage and support immediately upon extraction due to age, disability, and floodwater exposure."]	2026-08-25 18:23:47.195577+00	{"ai_summary": "A 74-year-old female resident with physical and visual disabilities is trapped alone in a wheelchair inside a flooded single-floor house and cannot get out.", "ai_severity": "critical", "ai_action_plan": ["Dispatch an immediate water rescue team to the specified coordinates in Barangay Remedios, Bulacan.", "Coordinate with local MDRRMO and emergency services for priority evacuation of a vulnerable wheelchair-bound senior citizen.", "Provide medical triage and support immediately upon extraction due to age, disability, and floodwater exposure."], "ai_disaster_type": "flood", "ai_people_estimate": 1}
168	120.854412	14.851596	2026-08-25 18:23:46.142284+00	Naiipit ang buong pamilya kasama ang mga bata at matanda sa itaas ng bahay, kumakalat na ang tubig, may nawawalang kasapi ng pamilya, kailangan ng agarang rescue.	56	An elderly female resident with physical disabilities living in a single-floor house at lat 14.851596, lng 120.854412 in Bulacan requires urgent evacuation due to high vulnerability to flood or typhoon impacts.	open	\N	critical	flood	1	["Dispatch local rescue team to the specific address in Barangay p20_herminia, Bulacan", "Provide physical assistance for evacuation considering the resident's disability and age", "Transport the resident to the nearest designated safe evacuation center"]	2026-08-25 18:23:48.527835+00	{"ai_summary": "An elderly female resident with physical disabilities living in a single-floor house at lat 14.851596, lng 120.854412 in Bulacan requires urgent evacuation due to high vulnerability to flood or typhoon impacts.", "ai_severity": "critical", "ai_action_plan": ["Dispatch local rescue team to the specific address in Barangay p20_herminia, Bulacan", "Provide physical assistance for evacuation considering the resident's disability and age", "Transport the resident to the nearest designated safe evacuation center"], "ai_disaster_type": "flood", "ai_people_estimate": 1}
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (role_id, name) FROM stdin;
100	citizens
911	dispatcher
\.


--
-- Data for Name: teams; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.teams (team_id, name, contact_number, latitude, longitude, created_at, archived_at, city_id, assigned_to) FROM stdin;
3	Alpha Gamma nutrients	098116933	\N	\N	2026-08-23 11:59:28.09941+00	\N	2	\N
4	Lugamers	9696963636	14.874017673488723	120.82187599913107	2026-08-24 14:25:25.676801+00	\N	1	\N
\.


--
-- Data for Name: typhoon_city_signals; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.typhoon_city_signals (typhoon_city_signal_id, typhoon_id, city_id, signal_level, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: typhoons; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.typhoons (typhoon_id, name, season_year, category, status, source, created_at, updated_at) FROM stdin;
1	Odette	2026	Super Typhoon	active	PAGASA	2026-08-23 15:23:30.735251	2026-08-23 15:23:30.735251
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (user_id, username, phone_number, created_at, archived_at, person_id, role_id, hashed_password, last_seen, latitude, longitude) FROM stdin;
6	tephL	090909	2026-08-18 02:45:56.00047+00	\N	8	100	$2b$10$48KRv.GiCyNOZu/c3x5aUe0nqA/U4UzUxgZzlLOgv4DUAkwTadGpC	\N	\N	\N
13	Albert	9937230154	2026-08-19 12:49:23.400718+00	\N	\N	100	$2b$10$4oHBPkUvzEnD2h7wYWpYc.Kvr2lbezMn2NQzC8TIskCK.haL20YrS	\N	\N	\N
10	tungtung	9662081096	2026-08-19 07:12:30.965369+00	\N	6	100	$2b$10$ocKveHa0blI6rN3XVJUK1.Zfn5Q8jsZbKICfivMWHIgIoYZg..loW	2026-08-26 05:21:26.868+00	14.874463	120.812799
15	bruhL	9662081095	2026-08-19 14:30:56.057074+00	\N	\N	100	$2b$10$cNH8bQzBChlLWIGHJamubuThxGdtnFTNH2F5X5MA8MVHckww1GPNa	\N	\N	\N
16	hjgjgyj	4564564568	2026-08-19 14:38:02.102062+00	\N	\N	100	$2b$10$C6g3YSHGaiUpTkCrLCLV1uJtjDGDo3awzP1c9q4B.TmTM867NZXZu	\N	\N	\N
17	test1787151057	9171234567	2026-08-19 14:50:57.694859+00	\N	\N	100	$2b$10$eL2cfz.iWk3eG/Ld/a/tzulLXK5DhDGdOWu/XIfoPa9FSnq7GiILu	\N	\N	\N
53	\N	9179000001	2026-08-25 15:48:46.225287+00	\N	70	100	$2b$10$tuEWlegxHJjrvmZECqzbgOphXTI9HUeBT/0FUUX11NpTVmHd9yVW2	2026-08-25 18:23:09.233+00	14.875033	120.825799
23	Ahahahaha	9937230159	2026-08-19 15:30:15.105771+00	\N	\N	100	$2b$10$UbckLr9bb2mqBPw.10GWyO/cXn.73XceFR8s5s0uQyWHn4/dmAt6u	\N	\N	\N
24	Ewan	123456789	2026-08-19 15:35:19.656801+00	\N	\N	100	$2b$10$ivdtibtSdOfWNEdZBjP/iOx8DtaD0CVoibSOAug3XgyoAGCCdP0Li	\N	\N	\N
25	jsjjs	1335565	2026-08-19 15:40:29.506737+00	\N	\N	100	$2b$10$B54prgLM800pi5lmcIivKur19VtY9MdLEyN3pgGnjbRoeJKFTlQwK	\N	\N	\N
39	Lacrimosa	9927394544	2026-08-22 07:55:27.083766+00	\N	18	100	$2b$10$7td9jvFUJ1Cu.0mWX6W4beIedLytnw1kvYSt3wC2TG.5zsJAu2WuS	2026-08-26 01:02:00.425+00	14.994578	120.929041
30	qwerty	123568923	2026-08-20 04:47:54.344033+00	\N	\N	100	$2b$10$hCPSOSBECUZwTp5rJc/mjeqChWZ9xuXub3bgj0pFA1Qepq9S29Imy	\N	\N	\N
31	Sneaky	9608116935	2026-08-20 05:57:24.288569+00	\N	\N	100	$2b$10$bfdqnGzSJkLlhLGOfT2H6OCYNSugG/79LqHM5FCtxBiJHJYgvjQA2	\N	\N	\N
59	\N	9179000006	2026-08-25 16:12:32.07634+00	\N	75	100	$2b$10$LroBU72wRPj8FNBu6cjfhOK7075QhQ6vKyWKNdvu8WWJCnJD4JplG	2026-08-25 18:23:24.269+00	14.858026	120.834746
19	Albs kkk albs	6969693939	2026-08-20 08:28:03.982978+00	\N	\N	100	$2b$10$/k9KNPuDjP/f3Lm4eMfV7.BQYUd/pgN9UnNHl2cZhp3uqpGLwUIgC	\N	\N	\N
20	asdfgh	850850852	2026-08-20 08:31:34.260514+00	\N	10	100	$2b$10$XXl4wbMME94Mejf7UJLB3eFEAhNrIxk.EAQaX1jsXa8U7N8Ia1R96	\N	\N	\N
21	mobtest0817	9171234000	2026-08-20 08:51:28.247766+00	\N	11	100	$2b$10$pBgkXO/2U7tr7OQlUOC80uG77h3axuhwopmkCoAFs12keN58HSWga	\N	\N	\N
22	uiopt	9997417417	2026-08-20 09:11:24.342134+00	\N	12	100	$2b$10$0YYWIv/8lO6B4TwbKPfbN.rbdgyc7KRMSgeoDcFMw9fF7zGLR0f5u	\N	\N	\N
55	\N	9179000011	2026-08-25 16:12:31.606983+00	\N	80	100	$2b$10$hb4rln0Ceeb67YM.VcRGaOFWKLcQ8LFezD8EEjmkweAvwCttGANIm	2026-08-25 18:23:33.254+00	14.894546	120.846043
35	\N	9089914045	2026-08-22 05:56:21.181608+00	\N	20	911	$2b$10$DfOFPnLcaYQpg3SUmlhqk.vKIStbNAHUsWOhMd7W251iYF.Im62fG	2026-08-23 08:25:42.284+00	14.871969	120.792710
44	\N	9000000000	2026-08-22 14:45:58.213781+00	\N	23	100	$2b$10$NyxnhS5hZ5PVrVpG4lhwpePjgimpHg3M2cmbU8z7eiimwOMSsDhai	2026-08-22 14:52:22.161+00	14.871968	120.792714
58	\N	9179000004	2026-08-25 16:12:31.958651+00	\N	73	100	$2b$10$yv2f6Jzs0r8MdoJwAiWXN.NvxWnujoDu33Q9KSSY0YrZ6OusLEsJK	2026-08-25 18:23:15.361+00	14.876381	120.827193
37	\N	9089914046	2026-08-22 06:12:03.50005+00	\N	\N	100	$2b$10$xCMv5JChJX94ydardjRpb.xOYQYCRkf5dC9SAxk.sFDcHLLpIzP6.	\N	\N	\N
28	qwsdf	9666666666	2026-08-21 13:53:38.983642+00	\N	14	100	$2b$10$4krXZ/NwocGGdLbgg62vIuuAxvklHvrqe/p26/5sfLLYfvQSdeJVu	\N	\N	\N
32	albertmwiak	9333333333	2026-08-21 14:12:32.126223+00	\N	15	100	$2b$10$qOxIxIiw9QM.0wG3Npa9G..Hn14j7zOz2CfAAlI4u13wTwe9XnjmS	\N	\N	\N
33	albertgy	9555555555	2026-08-21 14:20:29.351782+00	\N	\N	100	$2b$10$knGjJQ1MB5Tm1K1.odu2YObsXIK2d8Tu6aQI9fKM2EfpMRS8A7ZC6	\N	\N	\N
26	Sneaky2678	9608116969	2026-08-20 10:46:42.691879+00	\N	15	100	$2b$10$uxPHXMsNoA2SoUZ0lrMbs.2fmGOuStsVEwsC0Sww7OiLWX1.KThkO	2026-08-25 14:53:39.463+00	14.871968	120.792713
18	pogiako123	9999999999	2026-08-19 14:52:38.745791+00	\N	13	100	$2b$10$Mne5Uqi/lYEO1mlU07JxKeJwphq0Y.uy1pN2lLhIwasFVQEgHwvwC	2026-08-22 14:41:18.901+00	14.871968	120.792714
45	\N	9999292751	2026-08-22 15:29:34.596525+00	\N	24	100	$2b$10$XcX2ol3v7fM/hBA05SbnE.a4RFJYIBCxyN2M2lKS1V3w0/72Xi5Y.	2026-08-22 15:41:09.635+00	14.871966	120.792710
41	\N	9757654576	2026-08-22 08:02:57.249337+00	\N	19	100	$2b$10$/7AM.IF90ENzRxn.vXWEVuJ6XyCsjHBzVb8fxoOsSY5CLeUnQ8uBe	2026-08-24 12:33:40.593+00	14.861022	120.822319
27	JustineBieber	9608116767	2026-08-21 08:03:36.195059+00	\N	17	100	$2b$10$dYhNeFTs2ErAI/ZAMLUiaOEnwsM9H5k8Xds8raoWGVKcOQDP9B3Va	2026-08-25 14:55:27.324+00	14.904654	120.858163
43	\N	9123123123	2026-08-22 14:34:17.220497+00	\N	22	100	$2b$10$YbPhNp./XTC3KZ7mRu1pI.VeUWLuYegD4RKQtpXWjQu7MBXUBCS7y	2026-08-25 14:49:39.261+00	14.864865	120.799483
29	tephlschol	9696442611	2026-08-20 04:16:15.262438+00	\N	16	100	$2b$10$bNWzxff0ROFP/9kLoMviquWE5zvQZgl1Q8MCJCDw53aQbdyYm6LEO	2026-08-25 08:00:01.578+00	14.874630	120.812660
54	\N	9179000018	2026-08-25 16:12:31.501109+00	\N	87	100	$2b$10$RyZQIylWs7dVIOPbqHU1MOzXpdaMhWah6.iwbTBUXXHLFXILbQguS	2026-08-25 18:23:43.684+00	14.850248	120.854412
42	\N	9170000000	2026-08-22 09:47:29.637826+00	\N	21	911	$2b$10$nxB1dISgTfnloeCquDLDxuw2Cqa47IEQN3x0uyzOp7rbCGlXCy69S	2026-08-23 12:23:06.997+00	14.875581	120.811666
48	\N	9171234506	2026-08-25 12:23:42.344839+00	\N	30	100	$2b$10$DVrSwNjBfqR85h/uaeWKV.eDu.gaUM6kzB0FSIhsxL62agacb3Dwq	2026-08-25 15:20:20.299+00	14.866400	120.791200
47	\N	9696967676	2026-08-24 01:00:02.513564+00	\N	25	100	$2b$10$ki1xT7ERPrcIlb8BC.x02eGle814Tgh42pN.1TGN1vba9/A8BfDAq	2026-08-24 01:20:34.027+00	14.874528	120.812757
57	\N	9179000021	2026-08-25 16:12:31.836887+00	\N	90	100	$2b$10$xxA/TkdmGOYGEg8VRkLpz.GTdGg/yOaSF6GQFe/cHhj2RdZvkSVvW	2026-08-25 18:23:48.265+00	14.874891	120.825962
56	\N	9179000020	2026-08-25 16:12:31.708519+00	\N	89	100	$2b$10$YNrKOy01s5le8OTzSEelruO98z7ayiX1sSfVcvbe.trl0V4TdDKou	2026-08-25 18:23:46.611+00	14.851596	120.854412
67	\N	9179000002	2026-08-25 16:12:33.035324+00	\N	71	100	$2b$10$jjQwdFkyo3yu1JUdXnmbMeZ2UcYzbMawJw.KfEJOPlKbOap.utNY.	2026-08-25 18:23:11.995+00	14.875033	120.827193
62	\N	9179000003	2026-08-25 16:12:32.448523+00	\N	72	100	$2b$10$XH.I3U9IqPmlJq8Z9GC/7uLGN4a/.7gz6j20ggGzCRMrKZ2r8takC	2026-08-25 18:23:13.702+00	14.876381	120.825799
68	\N	9179000005	2026-08-25 16:12:33.162913+00	\N	74	100	$2b$10$SBDeWfx26Qgf9aq.hBMvb.IIuwYOTwaz0LpcDUuKgtWwO0Vo2dexy	2026-08-25 18:23:19.562+00	14.858026	120.833352
72	\N	9179000007	2026-08-25 16:12:33.620313+00	\N	76	100	$2b$10$UNkw6NJ1uvtfQKlJH7Obseen.JTcq8TwRPrWQyrOXS5zUOFtHUbjO	2026-08-25 18:23:27.406+00	14.859374	120.833352
69	\N	9179000008	2026-08-25 16:12:33.279452+00	\N	77	100	$2b$10$..3wbRjJDLL9x1TnCXhV1u1viwa45HLDrocmsUHSbELAnzRLq5zBG	2026-08-25 18:23:29.086+00	14.906511	120.771339
61	\N	9179000009	2026-08-25 16:12:32.319684+00	\N	78	100	$2b$10$10FC6LDg4/.MF.dVUocpxOCRBQEbjtT8thoBa7lHguCQMMsw2sx7u	2026-08-25 18:23:30.794+00	14.906511	120.772733
66	\N	9179000010	2026-08-25 16:12:32.917713+00	\N	79	100	$2b$10$xdVWMoDKH/Q004AemyPKM.i5TXYdYpaUyrNsBt0cwFYhs8d057DxK	2026-08-25 18:23:32.029+00	14.907859	120.771339
65	\N	9179000012	2026-08-25 16:12:32.793052+00	\N	81	100	$2b$10$FuefNeKzbfap/700CF41jO4qpFVQOq8pRpPp/Nm1iPfrdo3F3UC62	2026-08-25 18:23:34.958+00	14.894546	120.847437
70	\N	9179000013	2026-08-25 16:12:33.393302+00	\N	82	100	$2b$10$GPZPNKx7.BQvQ5xh5L1lJudFz9nJP0pIAC/X94S1Bv6H64ygYEuki	2026-08-25 18:23:36.617+00	14.895894	120.846043
73	\N	9179000014	2026-08-25 16:12:33.733681+00	\N	83	100	$2b$10$a4MpFX7QLlg34LD3Wz.tU.LdM6eOu4HMJu.I1mzfX/F9iVfnrnqHG	2026-08-25 18:23:37.834+00	14.895894	120.847437
60	\N	9179000015	2026-08-25 16:12:32.198144+00	\N	84	100	$2b$10$LX8gKiJ75T/0cSe8GERSSulne4IgnZef4Ksz9FiDXz9LQ4M5VV62G	2026-08-25 18:23:39.53+00	14.871859	120.864368
71	\N	9179000016	2026-08-25 16:12:33.509786+00	\N	85	100	$2b$10$QoYtJbaKzRjEDCyMzuViUuxGPQ6fZMpZFJ8odxpYtTJXvYty0exMu	2026-08-25 18:23:40.845+00	14.871859	120.865762
63	\N	9179000017	2026-08-25 16:12:32.571875+00	\N	86	100	$2b$10$NnQEzUABFb4/v8tuWRWsDOF2hTLjFjIAiLgrHAzZ.EZodvY2vThQ2	2026-08-25 18:23:42.472+00	14.873207	120.864368
64	\N	9179000019	2026-08-25 16:12:32.681817+00	\N	88	100	$2b$10$skEksVggF425e/rdRugBwOzL9yl7KI6j.2/XHJ8cKqvoBwA0aVea2	2026-08-25 18:23:45.401+00	14.850248	120.855806
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.schema_migrations (version, inserted_at) FROM stdin;
20211116024918	2026-08-19 10:30:57
20211116045059	2026-08-19 10:30:57
20211116050929	2026-08-19 10:30:57
20211116051442	2026-08-19 10:30:57
20211116212300	2026-08-19 10:30:57
20211116213355	2026-08-19 10:30:57
20211116213934	2026-08-19 10:30:57
20211116214523	2026-08-19 10:30:57
20211122062447	2026-08-19 10:30:57
20211124070109	2026-08-19 10:30:57
20211202204204	2026-08-19 10:30:57
20211202204605	2026-08-19 10:30:57
20211210212804	2026-08-19 10:30:57
20211228014915	2026-08-19 10:30:57
20220107221237	2026-08-19 10:30:57
20220228202821	2026-08-19 10:30:57
20220312004840	2026-08-19 10:30:57
20220603231003	2026-08-19 10:30:57
20220603232444	2026-08-19 10:30:57
20220615214548	2026-08-19 10:30:57
20220712093339	2026-08-19 10:30:57
20220908172859	2026-08-19 10:30:57
20220916233421	2026-08-19 10:30:57
20230119133233	2026-08-19 10:30:57
20230128025114	2026-08-19 10:30:57
20230128025212	2026-08-19 10:30:57
20230227211149	2026-08-19 10:30:57
20230228184745	2026-08-19 10:30:57
20230308225145	2026-08-19 10:30:57
20230328144023	2026-08-19 10:30:57
20231018144023	2026-08-19 10:30:57
20231204144023	2026-08-19 10:30:57
20231204144024	2026-08-19 10:30:57
20231204144025	2026-08-19 10:30:57
20240108234812	2026-08-19 10:30:57
20240109165339	2026-08-19 10:30:57
20240227174441	2026-08-19 10:30:57
20240311171622	2026-08-19 10:30:57
20240321100241	2026-08-19 10:30:57
20240401105812	2026-08-19 10:30:57
20240418121054	2026-08-19 10:30:57
20240523004032	2026-08-19 10:30:57
20240618124746	2026-08-19 10:30:57
20240801235015	2026-08-19 10:30:57
20240805133720	2026-08-19 10:30:57
20240827160934	2026-08-19 10:30:57
20240919163303	2026-08-19 10:30:57
20240919163305	2026-08-19 10:30:57
20241019105805	2026-08-19 10:30:57
20241030150047	2026-08-19 10:30:57
20241108114728	2026-08-19 10:30:57
20241121104152	2026-08-19 10:30:57
20241130184212	2026-08-19 10:30:57
20241220035512	2026-08-19 10:30:57
20241220123912	2026-08-19 10:30:57
20241224161212	2026-08-19 10:30:57
20250107150512	2026-08-19 10:30:57
20250110162412	2026-08-19 10:30:57
20250123174212	2026-08-19 10:30:57
20250128220012	2026-08-19 10:30:57
20250506224012	2026-08-19 10:30:57
20250523164012	2026-08-19 10:30:57
20250714121412	2026-08-19 10:30:57
20250905041441	2026-08-19 10:30:57
20251103001201	2026-08-19 10:30:57
20251120212548	2026-08-19 10:30:57
20251120215549	2026-08-19 10:30:57
20260218120000	2026-08-19 10:30:57
20260326120000	2026-08-19 10:30:57
20260514120000	2026-08-19 10:30:57
20260527120000	2026-08-19 10:30:57
20260528120000	2026-08-19 10:30:57
20260603120000	2026-08-19 10:30:57
20260605120000	2026-08-19 10:30:57
20260606110000	2026-08-19 10:30:57
20260616120000	2026-08-19 10:30:57
20260624120000	2026-08-19 10:30:57
20260626120000	2026-08-19 10:30:57
20260706120000	2026-08-19 10:30:57
20260707120000	2026-08-19 10:30:57
20260709120000	2026-08-19 10:30:57
\.


--
-- Data for Name: subscription; Type: TABLE DATA; Schema: realtime; Owner: supabase_realtime_admin
--

COPY realtime.subscription (id, subscription_id, entity, filters, claims, created_at, action_filter, selected_columns) FROM stdin;
\.


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id, type, versioning_status) FROM stdin;
\.


--
-- Data for Name: buckets_analytics; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets_analytics (name, type, format, created_at, updated_at, id, deleted_at) FROM stdin;
\.


--
-- Data for Name: buckets_vectors; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets_vectors (id, type, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.migrations (id, name, hash, executed_at) FROM stdin;
0	create-migrations-table	e18db593bcde2aca2a408c4d1100f6abba2195df	2026-08-19 09:52:31.011371
1	initialmigration	6ab16121fbaa08bbd11b712d05f358f9b555d777	2026-08-19 09:52:31.040298
2	storage-schema	f6a1fa2c93cbcd16d4e487b362e45fca157a8dbd	2026-08-19 09:52:31.043032
3	pathtoken-column	2cb1b0004b817b29d5b0a971af16bafeede4b70d	2026-08-19 09:52:31.067648
4	add-migrations-rls	427c5b63fe1c5937495d9c635c263ee7a5905058	2026-08-19 09:52:31.082023
5	add-size-functions	79e081a1455b63666c1294a440f8ad4b1e6a7f84	2026-08-19 09:52:31.084572
6	change-column-name-in-get-size	ded78e2f1b5d7e616117897e6443a925965b30d2	2026-08-19 09:52:31.087451
7	add-rls-to-buckets	e7e7f86adbc51049f341dfe8d30256c1abca17aa	2026-08-19 09:52:31.090171
8	add-public-to-buckets	fd670db39ed65f9d08b01db09d6202503ca2bab3	2026-08-19 09:52:31.092655
9	fix-search-function	af597a1b590c70519b464a4ab3be54490712796b	2026-08-19 09:52:31.096103
10	search-files-search-function	b595f05e92f7e91211af1bbfe9c6a13bb3391e16	2026-08-19 09:52:31.098786
11	add-trigger-to-auto-update-updated_at-column	7425bdb14366d1739fa8a18c83100636d74dcaa2	2026-08-19 09:52:31.102137
12	add-automatic-avif-detection-flag	8e92e1266eb29518b6a4c5313ab8f29dd0d08df9	2026-08-19 09:52:31.105055
13	add-bucket-custom-limits	cce962054138135cd9a8c4bcd531598684b25e7d	2026-08-19 09:52:31.107593
14	use-bytes-for-max-size	941c41b346f9802b411f06f30e972ad4744dad27	2026-08-19 09:52:31.110529
15	add-can-insert-object-function	934146bc38ead475f4ef4b555c524ee5d66799e5	2026-08-19 09:52:31.138115
16	add-version	76debf38d3fd07dcfc747ca49096457d95b1221b	2026-08-19 09:52:31.140562
17	drop-owner-foreign-key	f1cbb288f1b7a4c1eb8c38504b80ae2a0153d101	2026-08-19 09:52:31.142865
18	add_owner_id_column_deprecate_owner	e7a511b379110b08e2f214be852c35414749fe66	2026-08-19 09:52:31.145885
19	alter-default-value-objects-id	02e5e22a78626187e00d173dc45f58fa66a4f043	2026-08-19 09:52:31.149588
20	list-objects-with-delimiter	cd694ae708e51ba82bf012bba00caf4f3b6393b7	2026-08-19 09:52:31.155028
21	s3-multipart-uploads	8c804d4a566c40cd1e4cc5b3725a664a9303657f	2026-08-19 09:52:31.15875
22	s3-multipart-uploads-big-ints	9737dc258d2397953c9953d9b86920b8be0cdb73	2026-08-19 09:52:31.170062
23	optimize-search-function	9d7e604cddc4b56a5422dc68c9313f4a1b6f132c	2026-08-19 09:52:31.176654
24	operation-function	8312e37c2bf9e76bbe841aa5fda889206d2bf8aa	2026-08-19 09:52:31.179119
25	custom-metadata	d974c6057c3db1c1f847afa0e291e6165693b990	2026-08-19 09:52:31.181353
26	objects-prefixes	215cabcb7f78121892a5a2037a09fedf9a1ae322	2026-08-19 09:52:31.18362
27	search-v2	859ba38092ac96eb3964d83bf53ccc0b141663a6	2026-08-19 09:52:31.18588
28	object-bucket-name-sorting	c73a2b5b5d4041e39705814fd3a1b95502d38ce4	2026-08-19 09:52:31.18783
29	create-prefixes	ad2c1207f76703d11a9f9007f821620017a66c21	2026-08-19 09:52:31.189613
30	update-object-levels	2be814ff05c8252fdfdc7cfb4b7f5c7e17f0bed6	2026-08-19 09:52:31.191462
31	objects-level-index	b40367c14c3440ec75f19bbce2d71e914ddd3da0	2026-08-19 09:52:31.19331
32	backward-compatible-index-on-objects	e0c37182b0f7aee3efd823298fb3c76f1042c0f7	2026-08-19 09:52:31.195102
33	backward-compatible-index-on-prefixes	b480e99ed951e0900f033ec4eb34b5bdcb4e3d49	2026-08-19 09:52:31.196893
34	optimize-search-function-v1	ca80a3dc7bfef894df17108785ce29a7fc8ee456	2026-08-19 09:52:31.198718
35	add-insert-trigger-prefixes	458fe0ffd07ec53f5e3ce9df51bfdf4861929ccc	2026-08-19 09:52:31.200525
36	optimise-existing-functions	6ae5fca6af5c55abe95369cd4f93985d1814ca8f	2026-08-19 09:52:31.202589
37	add-bucket-name-length-trigger	3944135b4e3e8b22d6d4cbb568fe3b0b51df15c1	2026-08-19 09:52:31.2045
38	iceberg-catalog-flag-on-buckets	02716b81ceec9705aed84aa1501657095b32e5c5	2026-08-19 09:52:31.207208
39	add-search-v2-sort-support	6706c5f2928846abee18461279799ad12b279b78	2026-08-19 09:52:31.215478
40	fix-prefix-race-conditions-optimized	7ad69982ae2d372b21f48fc4829ae9752c518f6b	2026-08-19 09:52:31.217581
41	add-object-level-update-trigger	07fcf1a22165849b7a029deed059ffcde08d1ae0	2026-08-19 09:52:31.219424
42	rollback-prefix-triggers	771479077764adc09e2ea2043eb627503c034cd4	2026-08-19 09:52:31.221669
43	fix-object-level	84b35d6caca9d937478ad8a797491f38b8c2979f	2026-08-19 09:52:31.224029
44	vector-bucket-type	99c20c0ffd52bb1ff1f32fb992f3b351e3ef8fb3	2026-08-19 09:52:31.225964
45	vector-buckets	049e27196d77a7cb76497a85afae669d8b230953	2026-08-19 09:52:31.228565
46	buckets-objects-grants	fedeb96d60fefd8e02ab3ded9fbde05632f84aed	2026-08-19 09:52:31.23615
47	iceberg-table-metadata	649df56855c24d8b36dd4cc1aeb8251aa9ad42c2	2026-08-19 09:52:31.238827
48	iceberg-catalog-ids	e0e8b460c609b9999ccd0df9ad14294613eed939	2026-08-19 09:52:31.240902
49	buckets-objects-grants-postgres	072b1195d0d5a2f888af6b2302a1938dd94b8b3d	2026-08-19 09:52:31.254044
50	search-v2-optimised	6323ac4f850aa14e7387eb32102869578b5bd478	2026-08-19 09:52:31.25679
51	index-backward-compatible-search	2ee395d433f76e38bcd3856debaf6e0e5b674011	2026-08-19 09:52:31.828747
52	drop-not-used-indexes-and-functions	5cc44c8696749ac11dd0dc37f2a3802075f3a171	2026-08-19 09:52:31.82987
53	drop-index-lower-name	d0cb18777d9e2a98ebe0bc5cc7a42e57ebe41854	2026-08-19 09:52:31.836281
54	drop-index-object-level	6289e048b1472da17c31a7eba1ded625a6457e67	2026-08-19 09:52:31.83764
55	prevent-direct-deletes	262a4798d5e0f2e7c8970232e03ce8be695d5819	2026-08-19 09:52:31.83853
56	fix-optimized-search-function	b823ed1e418101032fa01374edc9a436e54e3ed4	2026-08-19 09:52:31.841357
57	s3-multipart-uploads-metadata	f127886e00d1b374fadbc7c6b31e09336aad5287	2026-08-19 09:52:31.844709
58	operation-ergonomics	00ca5d483b3fe0d522133d9002ccc5df98365120	2026-08-19 09:52:31.846801
59	drop-unused-functions	38456f13e39691c2bbb4b5151d0d1cdbabd4a8c4	2026-08-19 09:52:31.849236
60	optimize-existing-functions-again	db35e1c91a9201e59f4fef8d972c2f277d68b157	2026-08-19 09:52:31.851631
61	mark-filename-immutable	fe0096517ae9d60aaec1d110172ba9036dc66bb7	2026-08-19 09:52:31.853897
62	object-versioning-core	0b855f00ff3be0bfca91efee02a9858912491a9a	2026-08-22 01:58:51.312072
63	fix-search-name-relative-to-prefix	c7485e417624f795ce8bb2da21927f48e088904d	2026-08-23 07:37:37.000572
64	fix-search-by-timestamp-sqli	0af424ecd388a39bb1645184b222185a12149675	2026-08-23 07:37:37.062731
\.


--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata, archived_at, is_delete_marker, is_versioned) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads (id, in_progress_size, upload_signature, bucket_id, key, version, owner_id, created_at, user_metadata, metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads_parts (id, upload_id, size, part_number, bucket_id, key, etag, owner_id, version, created_at) FROM stdin;
\.


--
-- Data for Name: vector_indexes; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.vector_indexes (id, name, bucket_id, data_type, dimension, distance_metric, metadata_configuration, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: supabase_admin
--

COPY vault.secrets (id, name, description, secret, key_id, nonce, created_at, updated_at) FROM stdin;
\.


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 1, false);


--
-- Name: ai_conversations_conversation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ai_conversations_conversation_id_seq', 12, true);


--
-- Name: assignment_assignment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.assignment_assignment_id_seq', 26, true);


--
-- Name: cities_city_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cities_city_id_seq', 2, true);


--
-- Name: cluster_cluster_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cluster_cluster_id_seq', 30, true);


--
-- Name: family_family_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.family_family_id_seq', 15, true);


--
-- Name: family_members_family_member_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.family_members_family_member_id_seq', 29, true);


--
-- Name: images_image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.images_image_id_seq', 78, true);


--
-- Name: people_person_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.people_person_id_seq', 90, true);


--
-- Name: reports_report_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reports_report_id_seq', 169, true);


--
-- Name: roles_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_role_id_seq', 1, false);


--
-- Name: team_team_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.team_team_id_seq', 4, true);


--
-- Name: typhoon_city_signals_typhoon_city_signal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.typhoon_city_signals_typhoon_city_signal_id_seq', 1, false);


--
-- Name: typhoons_typhoon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.typhoons_typhoon_id_seq', 1, true);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_id_seq', 125, true);


--
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: supabase_realtime_admin
--

SELECT pg_catalog.setval('realtime.subscription_id_seq', 1, false);


--
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT amr_id_pk PRIMARY KEY (id);


--
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.audit_log_entries
    ADD CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id);


--
-- Name: custom_oauth_providers custom_oauth_providers_identifier_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.custom_oauth_providers
    ADD CONSTRAINT custom_oauth_providers_identifier_key UNIQUE (identifier);


--
-- Name: custom_oauth_providers custom_oauth_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.custom_oauth_providers
    ADD CONSTRAINT custom_oauth_providers_pkey PRIMARY KEY (id);


--
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.flow_state
    ADD CONSTRAINT flow_state_pkey PRIMARY KEY (id);


--
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- Name: identities identities_provider_id_provider_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_provider_id_provider_unique UNIQUE (provider_id, provider);


--
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.instances
    ADD CONSTRAINT instances_pkey PRIMARY KEY (id);


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey UNIQUE (session_id, authentication_method);


--
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_pkey PRIMARY KEY (id);


--
-- Name: mfa_factors mfa_factors_last_challenged_at_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_last_challenged_at_key UNIQUE (last_challenged_at);


--
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_pkey PRIMARY KEY (id);


--
-- Name: oauth_authorizations oauth_authorizations_authorization_code_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_authorization_code_key UNIQUE (authorization_code);


--
-- Name: oauth_authorizations oauth_authorizations_authorization_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_authorization_id_key UNIQUE (authorization_id);


--
-- Name: oauth_authorizations oauth_authorizations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_pkey PRIMARY KEY (id);


--
-- Name: oauth_client_states oauth_client_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_client_states
    ADD CONSTRAINT oauth_client_states_pkey PRIMARY KEY (id);


--
-- Name: oauth_clients oauth_clients_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_clients
    ADD CONSTRAINT oauth_clients_pkey PRIMARY KEY (id);


--
-- Name: oauth_consents oauth_consents_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_pkey PRIMARY KEY (id);


--
-- Name: oauth_consents oauth_consents_user_client_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_user_client_unique UNIQUE (user_id, client_id);


--
-- Name: one_time_tokens one_time_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_unique UNIQUE (token);


--
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_entity_id_key UNIQUE (entity_id);


--
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_pkey PRIMARY KEY (id);


--
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_pkey PRIMARY KEY (id);


--
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_providers
    ADD CONSTRAINT sso_providers_pkey PRIMARY KEY (id);


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: webauthn_challenges webauthn_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.webauthn_challenges
    ADD CONSTRAINT webauthn_challenges_pkey PRIMARY KEY (id);


--
-- Name: webauthn_credentials webauthn_credentials_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.webauthn_credentials
    ADD CONSTRAINT webauthn_credentials_pkey PRIMARY KEY (id);


--
-- Name: ai_conversations ai_conversations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ai_conversations
    ADD CONSTRAINT ai_conversations_pkey PRIMARY KEY (conversation_id);


--
-- Name: assignment assignment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assignment
    ADD CONSTRAINT assignment_pkey PRIMARY KEY (assignment_id);


--
-- Name: cities cities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_pkey PRIMARY KEY (city_id);


--
-- Name: clusters cluster_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clusters
    ADD CONSTRAINT cluster_pkey PRIMARY KEY (cluster_id);


--
-- Name: elevation_cache elevation_cache_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.elevation_cache
    ADD CONSTRAINT elevation_cache_pkey PRIMARY KEY (cache_key);


--
-- Name: family_members family_members_family_id_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.family_members
    ADD CONSTRAINT family_members_family_id_user_id_key UNIQUE (family_id, user_id);


--
-- Name: family_members family_members_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.family_members
    ADD CONSTRAINT family_members_pkey PRIMARY KEY (family_member_id);


--
-- Name: family family_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.family
    ADD CONSTRAINT family_pkey PRIMARY KEY (family_id);


--
-- Name: images images_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.images
    ADD CONSTRAINT images_pkey PRIMARY KEY (image_id);


--
-- Name: people people_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.people
    ADD CONSTRAINT people_pkey PRIMARY KEY (person_id);


--
-- Name: report_clusters report_clusters_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.report_clusters
    ADD CONSTRAINT report_clusters_pkey PRIMARY KEY (report_id, cluster_id);


--
-- Name: report_images report_images_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.report_images
    ADD CONSTRAINT report_images_pkey PRIMARY KEY (report_id, image_id);


--
-- Name: reports reports_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reports
    ADD CONSTRAINT reports_pkey PRIMARY KEY (report_id);


--
-- Name: roles roles_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_key UNIQUE (name);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (role_id);


--
-- Name: teams team_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT team_pkey PRIMARY KEY (team_id);


--
-- Name: typhoon_city_signals typhoon_city_signals_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.typhoon_city_signals
    ADD CONSTRAINT typhoon_city_signals_pkey PRIMARY KEY (typhoon_city_signal_id);


--
-- Name: typhoon_city_signals typhoon_city_signals_typhoon_id_city_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.typhoon_city_signals
    ADD CONSTRAINT typhoon_city_signals_typhoon_id_city_id_key UNIQUE (typhoon_id, city_id);


--
-- Name: typhoons typhoons_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.typhoons
    ADD CONSTRAINT typhoons_pkey PRIMARY KEY (typhoon_id);


--
-- Name: users uq_phone; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT uq_phone UNIQUE (phone_number);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: messages messages_payload_exclusive; Type: CHECK CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE realtime.messages
    ADD CONSTRAINT messages_payload_exclusive CHECK (((payload IS NULL) OR (binary_payload IS NULL))) NOT VALID;


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: subscription pk_subscription; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.subscription
    ADD CONSTRAINT pk_subscription PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: buckets_analytics buckets_analytics_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets_analytics
    ADD CONSTRAINT buckets_analytics_pkey PRIMARY KEY (id);


--
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);


--
-- Name: buckets_vectors buckets_vectors_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets_vectors
    ADD CONSTRAINT buckets_vectors_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_pkey PRIMARY KEY (id);


--
-- Name: vector_indexes vector_indexes_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.vector_indexes
    ADD CONSTRAINT vector_indexes_pkey PRIMARY KEY (id);


--
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX audit_logs_instance_id_idx ON auth.audit_log_entries USING btree (instance_id);


--
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: custom_oauth_providers_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX custom_oauth_providers_created_at_idx ON auth.custom_oauth_providers USING btree (created_at);


--
-- Name: custom_oauth_providers_enabled_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX custom_oauth_providers_enabled_idx ON auth.custom_oauth_providers USING btree (enabled);


--
-- Name: custom_oauth_providers_identifier_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX custom_oauth_providers_identifier_idx ON auth.custom_oauth_providers USING btree (identifier);


--
-- Name: custom_oauth_providers_provider_type_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX custom_oauth_providers_provider_type_idx ON auth.custom_oauth_providers USING btree (provider_type);


--
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);


--
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX factor_id_created_at_idx ON auth.mfa_factors USING btree (user_id, created_at);


--
-- Name: flow_state_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX flow_state_created_at_idx ON auth.flow_state USING btree (created_at DESC);


--
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_email_idx ON auth.identities USING btree (email text_pattern_ops);


--
-- Name: INDEX identities_email_idx; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.identities_email_idx IS 'Auth: Ensures indexed queries on the email column';


--
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_user_id_idx ON auth.identities USING btree (user_id);


--
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);


--
-- Name: idx_oauth_client_states_created_at; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_oauth_client_states_created_at ON auth.oauth_client_states USING btree (created_at);


--
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_user_id_auth_method ON auth.flow_state USING btree (user_id, authentication_method);


--
-- Name: idx_users_created_at_desc; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_users_created_at_desc ON auth.users USING btree (created_at DESC);


--
-- Name: idx_users_email; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_users_email ON auth.users USING btree (email);


--
-- Name: idx_users_last_sign_in_at_desc; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_users_last_sign_in_at_desc ON auth.users USING btree (last_sign_in_at DESC);


--
-- Name: idx_users_name; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_users_name ON auth.users USING btree (((raw_user_meta_data ->> 'name'::text))) WHERE ((raw_user_meta_data ->> 'name'::text) IS NOT NULL);


--
-- Name: mfa_challenge_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_challenge_created_at_idx ON auth.mfa_challenges USING btree (created_at DESC);


--
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX mfa_factors_user_friendly_name_unique ON auth.mfa_factors USING btree (friendly_name, user_id) WHERE (TRIM(BOTH FROM friendly_name) <> ''::text);


--
-- Name: mfa_factors_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_factors_user_id_idx ON auth.mfa_factors USING btree (user_id);


--
-- Name: oauth_auth_pending_exp_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_auth_pending_exp_idx ON auth.oauth_authorizations USING btree (expires_at) WHERE (status = 'pending'::auth.oauth_authorization_status);


--
-- Name: oauth_clients_deleted_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_clients_deleted_at_idx ON auth.oauth_clients USING btree (deleted_at);


--
-- Name: oauth_consents_active_client_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_active_client_idx ON auth.oauth_consents USING btree (client_id) WHERE (revoked_at IS NULL);


--
-- Name: oauth_consents_active_user_client_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_active_user_client_idx ON auth.oauth_consents USING btree (user_id, client_id) WHERE (revoked_at IS NULL);


--
-- Name: oauth_consents_user_order_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_user_order_idx ON auth.oauth_consents USING btree (user_id, granted_at DESC);


--
-- Name: one_time_tokens_relates_to_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_relates_to_hash_idx ON auth.one_time_tokens USING hash (relates_to);


--
-- Name: one_time_tokens_token_hash_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_token_hash_hash_idx ON auth.one_time_tokens USING hash (token_hash);


--
-- Name: one_time_tokens_user_id_token_type_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX one_time_tokens_user_id_token_type_key ON auth.one_time_tokens USING btree (user_id, token_type);


--
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_idx ON auth.refresh_tokens USING btree (instance_id);


--
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_user_id_idx ON auth.refresh_tokens USING btree (instance_id, user_id);


--
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_parent_idx ON auth.refresh_tokens USING btree (parent);


--
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_session_id_revoked_idx ON auth.refresh_tokens USING btree (session_id, revoked);


--
-- Name: refresh_tokens_updated_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_updated_at_idx ON auth.refresh_tokens USING btree (updated_at DESC);


--
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_providers_sso_provider_id_idx ON auth.saml_providers USING btree (sso_provider_id);


--
-- Name: saml_relay_states_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_created_at_idx ON auth.saml_relay_states USING btree (created_at DESC);


--
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_for_email_idx ON auth.saml_relay_states USING btree (for_email);


--
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_sso_provider_id_idx ON auth.saml_relay_states USING btree (sso_provider_id);


--
-- Name: sessions_not_after_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_not_after_idx ON auth.sessions USING btree (not_after DESC);


--
-- Name: sessions_oauth_client_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_oauth_client_id_idx ON auth.sessions USING btree (oauth_client_id);


--
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_user_id_idx ON auth.sessions USING btree (user_id);


--
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_domains_domain_idx ON auth.sso_domains USING btree (lower(domain));


--
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_domains_sso_provider_id_idx ON auth.sso_domains USING btree (sso_provider_id);


--
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_providers_resource_id_idx ON auth.sso_providers USING btree (lower(resource_id));


--
-- Name: sso_providers_resource_id_pattern_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_providers_resource_id_pattern_idx ON auth.sso_providers USING btree (resource_id text_pattern_ops);


--
-- Name: unique_phone_factor_per_user; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX unique_phone_factor_per_user ON auth.mfa_factors USING btree (user_id, phone);


--
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX user_id_created_at_idx ON auth.sessions USING btree (user_id, created_at);


--
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);


--
-- Name: INDEX users_email_partial_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';


--
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));


--
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);


--
-- Name: users_is_anonymous_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_is_anonymous_idx ON auth.users USING btree (is_anonymous);


--
-- Name: webauthn_challenges_expires_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX webauthn_challenges_expires_at_idx ON auth.webauthn_challenges USING btree (expires_at);


--
-- Name: webauthn_challenges_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX webauthn_challenges_user_id_idx ON auth.webauthn_challenges USING btree (user_id);


--
-- Name: webauthn_credentials_credential_id_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX webauthn_credentials_credential_id_key ON auth.webauthn_credentials USING btree (credential_id);


--
-- Name: webauthn_credentials_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX webauthn_credentials_user_id_idx ON auth.webauthn_credentials USING btree (user_id);


--
-- Name: idx_ai_conv_user_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ai_conv_user_time ON public.ai_conversations USING btree (user_id, created_at DESC);


--
-- Name: idx_assignment_cluster; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_assignment_cluster ON public.assignment USING btree (cluster_id);


--
-- Name: idx_assignment_team; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_assignment_team ON public.assignment USING btree (team_id);


--
-- Name: one_accepted_family_per_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX one_accepted_family_per_user ON public.family_members USING btree (user_id) WHERE ((status)::text = 'accepted'::text);


--
-- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING btree (entity);


--
-- Name: messages_inserted_at_topic_index; Type: INDEX; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE INDEX messages_inserted_at_topic_index ON ONLY realtime.messages USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: subscription_subscription_id_entity_filters_action_filter_selec; Type: INDEX; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE UNIQUE INDEX subscription_subscription_id_entity_filters_action_filter_selec ON realtime.subscription USING btree (subscription_id, entity, filters, action_filter, COALESCE(selected_columns, '{}'::text[]));


--
-- Name: bname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);


--
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);


--
-- Name: buckets_analytics_unique_name_idx; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX buckets_analytics_unique_name_idx ON storage.buckets_analytics USING btree (name) WHERE (deleted_at IS NULL);


--
-- Name: idx_multipart_uploads_list; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_multipart_uploads_list ON storage.s3_multipart_uploads USING btree (bucket_id, key, created_at);


--
-- Name: idx_objects_bucket_id_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_bucket_id_name ON storage.objects USING btree (bucket_id, name COLLATE "C");


--
-- Name: idx_objects_bucket_id_name_lower; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_bucket_id_name_lower ON storage.objects USING btree (bucket_id, lower(name) COLLATE "C");


--
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);


--
-- Name: vector_indexes_name_bucket_id_idx; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX vector_indexes_name_bucket_id_idx ON storage.vector_indexes USING btree (name, bucket_id);


--
-- Name: subscription tr_check_filters; Type: TRIGGER; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TRIGGER tr_check_filters BEFORE INSERT OR UPDATE ON realtime.subscription FOR EACH ROW EXECUTE FUNCTION realtime.subscription_check_filters();


--
-- Name: buckets enforce_bucket_name_length_trigger; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER enforce_bucket_name_length_trigger BEFORE INSERT OR UPDATE OF name ON storage.buckets FOR EACH ROW EXECUTE FUNCTION storage.enforce_bucket_name_length();


--
-- Name: buckets protect_buckets_delete; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER protect_buckets_delete BEFORE DELETE ON storage.buckets FOR EACH STATEMENT EXECUTE FUNCTION storage.protect_delete();


--
-- Name: objects protect_objects_delete; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER protect_objects_delete BEFORE DELETE ON storage.objects FOR EACH STATEMENT EXECUTE FUNCTION storage.protect_delete();


--
-- Name: objects update_objects_updated_at; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER update_objects_updated_at BEFORE UPDATE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.update_updated_at_column();


--
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_auth_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES auth.mfa_factors(id) ON DELETE CASCADE;


--
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: oauth_authorizations oauth_authorizations_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_client_id_fkey FOREIGN KEY (client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: oauth_authorizations oauth_authorizations_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: oauth_consents oauth_consents_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_client_id_fkey FOREIGN KEY (client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: oauth_consents oauth_consents_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: one_time_tokens one_time_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_flow_state_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_flow_state_id_fkey FOREIGN KEY (flow_state_id) REFERENCES auth.flow_state(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_oauth_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_oauth_client_id_fkey FOREIGN KEY (oauth_client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: webauthn_challenges webauthn_challenges_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.webauthn_challenges
    ADD CONSTRAINT webauthn_challenges_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: webauthn_credentials webauthn_credentials_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.webauthn_credentials
    ADD CONSTRAINT webauthn_credentials_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: ai_conversations ai_conversations_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ai_conversations
    ADD CONSTRAINT ai_conversations_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: assignment assignment_cluster_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assignment
    ADD CONSTRAINT assignment_cluster_id_fkey FOREIGN KEY (cluster_id) REFERENCES public.clusters(cluster_id) ON DELETE CASCADE;


--
-- Name: assignment assignment_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assignment
    ADD CONSTRAINT assignment_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.teams(team_id) ON DELETE CASCADE;


--
-- Name: clusters cluster_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clusters
    ADD CONSTRAINT cluster_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.cities(city_id);


--
-- Name: clusters cluster_typhoon_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clusters
    ADD CONSTRAINT cluster_typhoon_id_fkey FOREIGN KEY (typhoon_id) REFERENCES public.typhoons(typhoon_id);


--
-- Name: family family_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.family
    ADD CONSTRAINT family_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(user_id);


--
-- Name: images images_users_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.images
    ADD CONSTRAINT images_users_id_fkey FOREIGN KEY (submitted_by) REFERENCES public.users(user_id);


--
-- Name: report_clusters report_clusters_cluster_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.report_clusters
    ADD CONSTRAINT report_clusters_cluster_id_fkey FOREIGN KEY (cluster_id) REFERENCES public.clusters(cluster_id) ON DELETE CASCADE;


--
-- Name: report_clusters report_clusters_report_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.report_clusters
    ADD CONSTRAINT report_clusters_report_id_fkey FOREIGN KEY (report_id) REFERENCES public.reports(report_id) ON DELETE CASCADE;


--
-- Name: report_images report_images_image_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.report_images
    ADD CONSTRAINT report_images_image_id_fkey FOREIGN KEY (image_id) REFERENCES public.images(image_id);


--
-- Name: report_images report_images_report_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.report_images
    ADD CONSTRAINT report_images_report_id_fkey FOREIGN KEY (report_id) REFERENCES public.reports(report_id);


--
-- Name: reports reports_reported_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reports
    ADD CONSTRAINT reports_reported_by_fkey FOREIGN KEY (reported_by) REFERENCES public.users(user_id);


--
-- Name: teams teams_assigned_to_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_assigned_to_fkey FOREIGN KEY (assigned_to) REFERENCES public.clusters(cluster_id) ON DELETE SET NULL;


--
-- Name: teams teams_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.cities(city_id) ON DELETE SET NULL;


--
-- Name: typhoon_city_signals typhoon_city_signals_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.typhoon_city_signals
    ADD CONSTRAINT typhoon_city_signals_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.cities(city_id);


--
-- Name: typhoon_city_signals typhoon_city_signals_typhoon_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.typhoon_city_signals
    ADD CONSTRAINT typhoon_city_signals_typhoon_id_fkey FOREIGN KEY (typhoon_id) REFERENCES public.typhoons(typhoon_id);


--
-- Name: users users_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.people(person_id) ON DELETE CASCADE;


--
-- Name: users users_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(role_id) ON DELETE RESTRICT;


--
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES storage.s3_multipart_uploads(id) ON DELETE CASCADE;


--
-- Name: vector_indexes vector_indexes_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.vector_indexes
    ADD CONSTRAINT vector_indexes_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets_vectors(id);


--
-- Name: audit_log_entries; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.audit_log_entries ENABLE ROW LEVEL SECURITY;

--
-- Name: flow_state; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.flow_state ENABLE ROW LEVEL SECURITY;

--
-- Name: identities; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.identities ENABLE ROW LEVEL SECURITY;

--
-- Name: instances; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.instances ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_amr_claims; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_amr_claims ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_challenges; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_challenges ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_factors; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_factors ENABLE ROW LEVEL SECURITY;

--
-- Name: one_time_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.one_time_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: refresh_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.refresh_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_relay_states; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_relay_states ENABLE ROW LEVEL SECURITY;

--
-- Name: schema_migrations; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.schema_migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: sessions; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sessions ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_domains; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_domains ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: users; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.users ENABLE ROW LEVEL SECURITY;

--
-- Name: messages; Type: ROW SECURITY; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE realtime.messages ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets_analytics; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets_analytics ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets_vectors; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets_vectors ENABLE ROW LEVEL SECURITY;

--
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: objects; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads_parts; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads_parts ENABLE ROW LEVEL SECURITY;

--
-- Name: vector_indexes; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.vector_indexes ENABLE ROW LEVEL SECURITY;

--
-- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: postgres
--

CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime OWNER TO postgres;

--
-- Name: SCHEMA auth; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA auth TO anon;
GRANT USAGE ON SCHEMA auth TO authenticated;
GRANT USAGE ON SCHEMA auth TO service_role;
GRANT ALL ON SCHEMA auth TO supabase_auth_admin;
GRANT ALL ON SCHEMA auth TO dashboard_user;
GRANT USAGE ON SCHEMA auth TO postgres;


--
-- Name: SCHEMA extensions; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA extensions TO anon;
GRANT USAGE ON SCHEMA extensions TO authenticated;
GRANT USAGE ON SCHEMA extensions TO service_role;
GRANT ALL ON SCHEMA extensions TO dashboard_user;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT USAGE ON SCHEMA public TO postgres;
GRANT USAGE ON SCHEMA public TO anon;
GRANT USAGE ON SCHEMA public TO authenticated;
GRANT USAGE ON SCHEMA public TO service_role;


--
-- Name: SCHEMA realtime; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA realtime TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA realtime TO anon;
GRANT USAGE ON SCHEMA realtime TO service_role;
GRANT ALL ON SCHEMA realtime TO supabase_realtime_admin WITH GRANT OPTION;
GRANT USAGE ON SCHEMA realtime TO authenticated;


--
-- Name: SCHEMA storage; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA storage TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA storage TO anon;
GRANT USAGE ON SCHEMA storage TO authenticated;
GRANT USAGE ON SCHEMA storage TO service_role;
GRANT ALL ON SCHEMA storage TO supabase_storage_admin WITH GRANT OPTION;
GRANT ALL ON SCHEMA storage TO dashboard_user;


--
-- Name: SCHEMA vault; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA vault TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA vault TO service_role;


--
-- Name: FUNCTION email(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.email() TO dashboard_user;


--
-- Name: FUNCTION jwt(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.jwt() TO postgres;
GRANT ALL ON FUNCTION auth.jwt() TO dashboard_user;


--
-- Name: FUNCTION role(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.role() TO dashboard_user;


--
-- Name: FUNCTION uid(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.uid() TO dashboard_user;


--
-- Name: FUNCTION armor(bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.armor(bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO dashboard_user;


--
-- Name: FUNCTION armor(bytea, text[], text[]); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.armor(bytea, text[], text[]) FROM postgres;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO dashboard_user;


--
-- Name: FUNCTION crypt(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.crypt(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO dashboard_user;


--
-- Name: FUNCTION dearmor(text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.dearmor(text) FROM postgres;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO dashboard_user;


--
-- Name: FUNCTION decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION decrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION digest(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.digest(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION digest(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.digest(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO dashboard_user;


--
-- Name: FUNCTION encrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION encrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION gen_random_bytes(integer); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_random_bytes(integer) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO dashboard_user;


--
-- Name: FUNCTION gen_random_uuid(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_random_uuid() FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO dashboard_user;


--
-- Name: FUNCTION gen_salt(text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_salt(text) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO dashboard_user;


--
-- Name: FUNCTION gen_salt(text, integer); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_salt(text, integer) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO dashboard_user;


--
-- Name: FUNCTION grant_pg_cron_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_cron_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO dashboard_user;


--
-- Name: FUNCTION grant_pg_graphql_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.grant_pg_graphql_access() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION grant_pg_net_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_net_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO dashboard_user;


--
-- Name: FUNCTION hmac(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.hmac(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION hmac(text, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.hmac(text, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) TO dashboard_user;


--
-- Name: FUNCTION pgp_armor_headers(text, OUT key text, OUT value text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO dashboard_user;


--
-- Name: FUNCTION pgp_key_id(bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_key_id(bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgrst_ddl_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_ddl_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgrst_drop_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_drop_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION set_graphql_placeholder(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.set_graphql_placeholder() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_generate_v1(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v1() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v1mc(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v1mc() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v3(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v4(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v4() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v5(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO dashboard_user;


--
-- Name: FUNCTION uuid_nil(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_nil() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_dns(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_dns() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_oid(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_oid() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_url(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_url() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_x500(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_x500() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO dashboard_user;


--
-- Name: FUNCTION graphql("operationName" text, query text, variables jsonb, extensions jsonb); Type: ACL; Schema: graphql_public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO postgres;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO anon;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO authenticated;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO service_role;


--
-- Name: FUNCTION pg_reload_conf(); Type: ACL; Schema: pg_catalog; Owner: supabase_admin
--

GRANT ALL ON FUNCTION pg_catalog.pg_reload_conf() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION get_auth(p_usename text); Type: ACL; Schema: pgbouncer; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgbouncer.get_auth(p_usename text) FROM PUBLIC;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO pgbouncer;


--
-- Name: FUNCTION apply_rls(wal jsonb, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO service_role;


--
-- Name: FUNCTION broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO postgres;
GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO dashboard_user;


--
-- Name: FUNCTION build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO postgres;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO anon;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO service_role;


--
-- Name: FUNCTION "cast"(val text, type_ regtype); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO postgres;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO dashboard_user;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO anon;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO authenticated;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO service_role;


--
-- Name: FUNCTION check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO postgres;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO anon;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO authenticated;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO service_role;


--
-- Name: FUNCTION check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text, negate boolean); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text, negate boolean) TO postgres;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text, negate boolean) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text, negate boolean) TO anon;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text, negate boolean) TO authenticated;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text, negate boolean) TO service_role;


--
-- Name: FUNCTION is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO postgres;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO anon;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO service_role;


--
-- Name: FUNCTION list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO dashboard_user;


--
-- Name: FUNCTION quote_wal2json(entity regclass); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO postgres;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO anon;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO authenticated;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO service_role;


--
-- Name: FUNCTION send(payload jsonb, event text, topic text, private boolean); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO postgres;
GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO dashboard_user;


--
-- Name: FUNCTION send_binary(payload bytea, event text, topic text, private boolean); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.send_binary(payload bytea, event text, topic text, private boolean) TO postgres;
GRANT ALL ON FUNCTION realtime.send_binary(payload bytea, event text, topic text, private boolean) TO dashboard_user;


--
-- Name: FUNCTION subscription_check_filters(); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO postgres;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO dashboard_user;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO anon;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO authenticated;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO service_role;


--
-- Name: FUNCTION to_regrole(role_name text); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO postgres;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO anon;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO authenticated;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO service_role;


--
-- Name: FUNCTION topic(); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.topic() TO postgres;
GRANT ALL ON FUNCTION realtime.topic() TO dashboard_user;


--
-- Name: FUNCTION wal2json_escape_identifier(name text); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.wal2json_escape_identifier(name text) TO postgres;
GRANT ALL ON FUNCTION realtime.wal2json_escape_identifier(name text) TO dashboard_user;


--
-- Name: FUNCTION _crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO service_role;


--
-- Name: FUNCTION create_secret(new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- Name: FUNCTION update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- Name: TABLE audit_log_entries; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.audit_log_entries TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.audit_log_entries TO postgres;
GRANT SELECT ON TABLE auth.audit_log_entries TO postgres WITH GRANT OPTION;


--
-- Name: TABLE custom_oauth_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.custom_oauth_providers TO postgres;
GRANT ALL ON TABLE auth.custom_oauth_providers TO dashboard_user;


--
-- Name: TABLE flow_state; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.flow_state TO postgres;
GRANT SELECT ON TABLE auth.flow_state TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.flow_state TO dashboard_user;


--
-- Name: TABLE identities; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.identities TO postgres;
GRANT SELECT ON TABLE auth.identities TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.identities TO dashboard_user;


--
-- Name: TABLE instances; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.instances TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.instances TO postgres;
GRANT SELECT ON TABLE auth.instances TO postgres WITH GRANT OPTION;


--
-- Name: TABLE mfa_amr_claims; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_amr_claims TO postgres;
GRANT SELECT ON TABLE auth.mfa_amr_claims TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_amr_claims TO dashboard_user;


--
-- Name: TABLE mfa_challenges; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_challenges TO postgres;
GRANT SELECT ON TABLE auth.mfa_challenges TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_challenges TO dashboard_user;


--
-- Name: TABLE mfa_factors; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_factors TO postgres;
GRANT SELECT ON TABLE auth.mfa_factors TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_factors TO dashboard_user;


--
-- Name: TABLE oauth_authorizations; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_authorizations TO postgres;
GRANT ALL ON TABLE auth.oauth_authorizations TO dashboard_user;


--
-- Name: TABLE oauth_client_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_client_states TO postgres;
GRANT ALL ON TABLE auth.oauth_client_states TO dashboard_user;


--
-- Name: TABLE oauth_clients; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_clients TO postgres;
GRANT ALL ON TABLE auth.oauth_clients TO dashboard_user;


--
-- Name: TABLE oauth_consents; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_consents TO postgres;
GRANT ALL ON TABLE auth.oauth_consents TO dashboard_user;


--
-- Name: TABLE one_time_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.one_time_tokens TO postgres;
GRANT SELECT ON TABLE auth.one_time_tokens TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.one_time_tokens TO dashboard_user;


--
-- Name: TABLE refresh_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.refresh_tokens TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.refresh_tokens TO postgres;
GRANT SELECT ON TABLE auth.refresh_tokens TO postgres WITH GRANT OPTION;


--
-- Name: SEQUENCE refresh_tokens_id_seq; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO dashboard_user;
GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO postgres;


--
-- Name: TABLE saml_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.saml_providers TO postgres;
GRANT SELECT ON TABLE auth.saml_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_providers TO dashboard_user;


--
-- Name: TABLE saml_relay_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.saml_relay_states TO postgres;
GRANT SELECT ON TABLE auth.saml_relay_states TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_relay_states TO dashboard_user;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT ON TABLE auth.schema_migrations TO postgres WITH GRANT OPTION;


--
-- Name: TABLE sessions; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sessions TO postgres;
GRANT SELECT ON TABLE auth.sessions TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sessions TO dashboard_user;


--
-- Name: TABLE sso_domains; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sso_domains TO postgres;
GRANT SELECT ON TABLE auth.sso_domains TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_domains TO dashboard_user;


--
-- Name: TABLE sso_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sso_providers TO postgres;
GRANT SELECT ON TABLE auth.sso_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_providers TO dashboard_user;


--
-- Name: TABLE users; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.users TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.users TO postgres;
GRANT SELECT ON TABLE auth.users TO postgres WITH GRANT OPTION;


--
-- Name: TABLE webauthn_challenges; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.webauthn_challenges TO postgres;
GRANT ALL ON TABLE auth.webauthn_challenges TO dashboard_user;


--
-- Name: TABLE webauthn_credentials; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.webauthn_credentials TO postgres;
GRANT ALL ON TABLE auth.webauthn_credentials TO dashboard_user;


--
-- Name: TABLE pg_stat_statements; Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON TABLE extensions.pg_stat_statements FROM postgres;
GRANT ALL ON TABLE extensions.pg_stat_statements TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements TO dashboard_user;


--
-- Name: TABLE pg_stat_statements_info; Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON TABLE extensions.pg_stat_statements_info FROM postgres;
GRANT ALL ON TABLE extensions.pg_stat_statements_info TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements_info TO dashboard_user;


--
-- Name: TABLE ai_conversations; Type: ACL; Schema: public; Owner: postgres
--

GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE public.ai_conversations TO anon;
GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE public.ai_conversations TO authenticated;
GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE public.ai_conversations TO service_role;


--
-- Name: TABLE assignment; Type: ACL; Schema: public; Owner: postgres
--

GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE public.assignment TO anon;
GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE public.assignment TO authenticated;
GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE public.assignment TO service_role;


--
-- Name: TABLE cities; Type: ACL; Schema: public; Owner: postgres
--

GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE public.cities TO anon;
GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE public.cities TO authenticated;
GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE public.cities TO service_role;


--
-- Name: TABLE clusters; Type: ACL; Schema: public; Owner: postgres
--

GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE public.clusters TO anon;
GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE public.clusters TO authenticated;
GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE public.clusters TO service_role;


--
-- Name: TABLE elevation_cache; Type: ACL; Schema: public; Owner: postgres
--

GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE public.elevation_cache TO anon;
GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE public.elevation_cache TO authenticated;
GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE public.elevation_cache TO service_role;


--
-- Name: TABLE family; Type: ACL; Schema: public; Owner: postgres
--

GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE public.family TO anon;
GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE public.family TO authenticated;
GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE public.family TO service_role;


--
-- Name: TABLE family_members; Type: ACL; Schema: public; Owner: postgres
--

GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE public.family_members TO anon;
GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE public.family_members TO authenticated;
GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE public.family_members TO service_role;


--
-- Name: TABLE images; Type: ACL; Schema: public; Owner: postgres
--

GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE public.images TO anon;
GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE public.images TO authenticated;
GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE public.images TO service_role;


--
-- Name: TABLE people; Type: ACL; Schema: public; Owner: postgres
--

GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE public.people TO anon;
GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE public.people TO authenticated;
GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE public.people TO service_role;


--
-- Name: TABLE report_clusters; Type: ACL; Schema: public; Owner: postgres
--

GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE public.report_clusters TO anon;
GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE public.report_clusters TO authenticated;
GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE public.report_clusters TO service_role;


--
-- Name: TABLE report_images; Type: ACL; Schema: public; Owner: postgres
--

GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE public.report_images TO anon;
GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE public.report_images TO authenticated;
GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE public.report_images TO service_role;


--
-- Name: TABLE reports; Type: ACL; Schema: public; Owner: postgres
--

GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE public.reports TO anon;
GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE public.reports TO authenticated;
GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE public.reports TO service_role;


--
-- Name: TABLE roles; Type: ACL; Schema: public; Owner: postgres
--

GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE public.roles TO anon;
GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE public.roles TO authenticated;
GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE public.roles TO service_role;


--
-- Name: TABLE teams; Type: ACL; Schema: public; Owner: postgres
--

GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE public.teams TO anon;
GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE public.teams TO authenticated;
GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE public.teams TO service_role;


--
-- Name: TABLE typhoon_city_signals; Type: ACL; Schema: public; Owner: postgres
--

GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE public.typhoon_city_signals TO anon;
GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE public.typhoon_city_signals TO authenticated;
GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE public.typhoon_city_signals TO service_role;


--
-- Name: TABLE typhoons; Type: ACL; Schema: public; Owner: postgres
--

GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE public.typhoons TO anon;
GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE public.typhoons TO authenticated;
GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE public.typhoons TO service_role;


--
-- Name: TABLE users; Type: ACL; Schema: public; Owner: postgres
--

GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE public.users TO anon;
GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE public.users TO authenticated;
GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE public.users TO service_role;


--
-- Name: TABLE messages; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON TABLE realtime.messages TO postgres;
GRANT ALL ON TABLE realtime.messages TO dashboard_user;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO authenticated;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO service_role;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.schema_migrations TO postgres;
GRANT ALL ON TABLE realtime.schema_migrations TO dashboard_user;


--
-- Name: TABLE subscription; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON TABLE realtime.subscription TO postgres;
GRANT ALL ON TABLE realtime.subscription TO dashboard_user;
GRANT SELECT ON TABLE realtime.subscription TO anon;
GRANT SELECT ON TABLE realtime.subscription TO authenticated;
GRANT SELECT ON TABLE realtime.subscription TO service_role;


--
-- Name: SEQUENCE subscription_id_seq; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO postgres;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO dashboard_user;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO anon;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO authenticated;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO service_role;


--
-- Name: TABLE buckets; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

REVOKE ALL ON TABLE storage.buckets FROM supabase_storage_admin;
GRANT ALL ON TABLE storage.buckets TO supabase_storage_admin WITH GRANT OPTION;
GRANT ALL ON TABLE storage.buckets TO service_role;
GRANT ALL ON TABLE storage.buckets TO authenticated;
GRANT ALL ON TABLE storage.buckets TO anon;
GRANT ALL ON TABLE storage.buckets TO postgres WITH GRANT OPTION;


--
-- Name: TABLE buckets_analytics; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.buckets_analytics TO service_role;
GRANT ALL ON TABLE storage.buckets_analytics TO authenticated;
GRANT ALL ON TABLE storage.buckets_analytics TO anon;


--
-- Name: TABLE buckets_vectors; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT ON TABLE storage.buckets_vectors TO service_role;
GRANT SELECT ON TABLE storage.buckets_vectors TO authenticated;
GRANT SELECT ON TABLE storage.buckets_vectors TO anon;


--
-- Name: TABLE objects; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

REVOKE ALL ON TABLE storage.objects FROM supabase_storage_admin;
GRANT ALL ON TABLE storage.objects TO supabase_storage_admin WITH GRANT OPTION;
GRANT ALL ON TABLE storage.objects TO service_role;
GRANT ALL ON TABLE storage.objects TO authenticated;
GRANT ALL ON TABLE storage.objects TO anon;
GRANT ALL ON TABLE storage.objects TO postgres WITH GRANT OPTION;


--
-- Name: TABLE s3_multipart_uploads; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO anon;


--
-- Name: TABLE s3_multipart_uploads_parts; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads_parts TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO anon;


--
-- Name: TABLE vector_indexes; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT ON TABLE storage.vector_indexes TO service_role;
GRANT SELECT ON TABLE storage.vector_indexes TO authenticated;
GRANT SELECT ON TABLE storage.vector_indexes TO anon;


--
-- Name: TABLE secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.secrets TO service_role;


--
-- Name: TABLE decrypted_secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.decrypted_secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.decrypted_secrets TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON SEQUENCES TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON FUNCTIONS TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON TABLES TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO service_role;


--
-- Name: issue_graphql_placeholder; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_graphql_placeholder ON sql_drop
         WHEN TAG IN ('DROP EXTENSION')
   EXECUTE FUNCTION extensions.set_graphql_placeholder();


ALTER EVENT TRIGGER issue_graphql_placeholder OWNER TO supabase_admin;

--
-- Name: issue_pg_cron_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_cron_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_cron_access();


ALTER EVENT TRIGGER issue_pg_cron_access OWNER TO supabase_admin;

--
-- Name: issue_pg_graphql_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_graphql_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_graphql_access();


ALTER EVENT TRIGGER issue_pg_graphql_access OWNER TO supabase_admin;

--
-- Name: issue_pg_net_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_net_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_net_access();


ALTER EVENT TRIGGER issue_pg_net_access OWNER TO supabase_admin;

--
-- Name: pgrst_ddl_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_ddl_watch ON ddl_command_end
   EXECUTE FUNCTION extensions.pgrst_ddl_watch();


ALTER EVENT TRIGGER pgrst_ddl_watch OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_drop_watch ON sql_drop
   EXECUTE FUNCTION extensions.pgrst_drop_watch();


ALTER EVENT TRIGGER pgrst_drop_watch OWNER TO supabase_admin;

--
-- PostgreSQL database dump complete
--

\unrestrict ooOVJQ9MauZvJQ45AS6Iaap1Oc1JitEOiZeh88nkiGXytukY697ckoewb90bimS

