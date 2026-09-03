-- Report flood hazard level (25-year return period) attached by the client.
-- Apply with:  psql -U username -d db_name -f sql/migrations/2026-09-03-report-hazard-level.sql
--
-- The value is resolved on the mobile device against the Project NOAH
-- flood_25yr layer and sent with the report. It maps to:
--   1 = Mababa (Low), 2 = Katamtaman (Medium), 3 = Mataas (High).
-- NULL means the client could not resolve a hazard level at report time.

ALTER TABLE public.reports
    ADD COLUMN IF NOT EXISTS hazard_level_25yr smallint;

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM pg_constraint
        WHERE conname = 'reports_hazard_level_25yr_check'
          AND conrelid = 'public.reports'::regclass
    ) THEN
        ALTER TABLE public.reports
            ADD CONSTRAINT reports_hazard_level_25yr_check
            CHECK (hazard_level_25yr IS NULL OR hazard_level_25yr IN (1, 2, 3));
    END IF;
END
$$;
