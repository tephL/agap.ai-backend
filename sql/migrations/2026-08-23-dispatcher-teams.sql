-- Dispatcher teams, emergency clusters, and team assignments.
-- Apply with:  psql -U username -d db_name -f sql/migrations/2026-08-23-dispatcher-teams.sql

-- Teams are responder units a dispatcher can dispatch to clusters.
CREATE TABLE IF NOT EXISTS public.team (
    team_id serial PRIMARY KEY,
    name character varying(150) NOT NULL,
    contact_number character varying(50),
    location_text character varying(255),
    latitude double precision,
    longitude double precision,
    status character varying(20) NOT NULL DEFAULT 'available',
    created_by integer REFERENCES public.users(user_id) ON DELETE SET NULL,
    created_at timestamp with time zone NOT NULL DEFAULT now(),
    CONSTRAINT team_status_check CHECK (
        status IN ('available', 'busy', 'offline')
    )
);

-- Clusters group nearby citizen reports after AI triage.
-- report_count / people_affected are denormalized rollups maintained
-- by whatever clustering job groups the reports.
CREATE TABLE IF NOT EXISTS public.cluster (
    cluster_id serial PRIMARY KEY,
    name character varying(150) NOT NULL,
    latitude double precision,
    longitude double precision,
    priority character varying(20) NOT NULL DEFAULT 'medium',
    status character varying(20) NOT NULL DEFAULT 'open',
    report_count integer NOT NULL DEFAULT 0,
    people_affected integer NOT NULL DEFAULT 0,
    ai_summary text,
    action_plan jsonb NOT NULL DEFAULT '[]'::jsonb,
    created_at timestamp with time zone NOT NULL DEFAULT now(),
    updated_at timestamp with time zone NOT NULL DEFAULT now(),
    CONSTRAINT cluster_priority_check CHECK (
        priority IN ('high', 'medium', 'low')
    ),
    CONSTRAINT cluster_status_check CHECK (
        status IN ('open', 'saved', 'resolved')
    )
);

-- Links a team to the cluster it is responding to.
-- One active (non-resolved) assignment per team is enforced in the service
-- layer inside a transaction.
CREATE TABLE IF NOT EXISTS public.assignment (
    assignment_id serial PRIMARY KEY,
    team_id integer NOT NULL REFERENCES public.team(team_id) ON DELETE CASCADE,
    cluster_id integer NOT NULL REFERENCES public.cluster(cluster_id) ON DELETE CASCADE,
    status character varying(20) NOT NULL DEFAULT 'pending',
    created_at timestamp with time zone NOT NULL DEFAULT now(),
    updated_at timestamp with time zone NOT NULL DEFAULT now(),
    CONSTRAINT assignment_status_check CHECK (
        status IN ('pending', 'dispatched', 'resolved')
    )
);

CREATE INDEX IF NOT EXISTS idx_assignment_team ON public.assignment(team_id);
CREATE INDEX IF NOT EXISTS idx_assignment_cluster ON public.assignment(cluster_id);

-- ------------------------------------------------------------------
-- Sample data for local development. Uncomment to seed.
--
-- INSERT INTO public.cluster (name, latitude, longitude, priority, report_count, people_affected)
-- VALUES ('Tondo, Manila', 14.6289, 120.9719, 'high', 7, 23),
--        ('Quiapo, Manila', 14.5995, 120.9842, 'medium', 4, 11);
--
-- INSERT INTO public.team (name, contact_number, location_text, latitude, longitude)
-- VALUES ('Rescue Alpha', '09171002001', 'Barangay Hall, San Roque', 14.6102, 120.9822);
-- ------------------------------------------------------------------
