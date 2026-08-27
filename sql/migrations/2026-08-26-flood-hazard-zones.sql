-- Flood hazard zone tables for Project NOAH return-period layers.
-- Apply with:  psql -U username -d db_name -f sql/migrations/2026-08-26-flood-hazard-zones.sql
--
-- Each table stores polygons from the respective return-period flood layer.
-- hazard_level maps to: 1 = Low, 2 = Medium, 3 = High.

CREATE EXTENSION IF NOT EXISTS postgis SCHEMA extensions;

-- 5-year return period flood zones
CREATE TABLE IF NOT EXISTS public.flood_hazard_5yr (
    id serial PRIMARY KEY,
    hazard_level smallint NOT NULL,
    geom geometry(Polygon, 4326) NOT NULL,
    CONSTRAINT flood_hazard_5yr_level_check CHECK (hazard_level IN (1, 2, 3))
);
CREATE INDEX IF NOT EXISTS idx_flood_hazard_5yr_geom
    ON public.flood_hazard_5yr USING gist (geom);

-- 25-year return period flood zones
CREATE TABLE IF NOT EXISTS public.flood_hazard_25yr (
    id serial PRIMARY KEY,
    hazard_level smallint NOT NULL,
    geom geometry(Polygon, 4326) NOT NULL,
    CONSTRAINT flood_hazard_25yr_level_check CHECK (hazard_level IN (1, 2, 3))
);
CREATE INDEX IF NOT EXISTS idx_flood_hazard_25yr_geom
    ON public.flood_hazard_25yr USING gist (geom);

-- 100-year return period flood zones
CREATE TABLE IF NOT EXISTS public.flood_hazard_100yr (
    id serial PRIMARY KEY,
    hazard_level smallint NOT NULL,
    geom geometry(Polygon, 4326) NOT NULL,
    CONSTRAINT flood_hazard_100yr_level_check CHECK (hazard_level IN (1, 2, 3))
);
CREATE INDEX IF NOT EXISTS idx_flood_hazard_100yr_geom
    ON public.flood_hazard_100yr USING gist (geom);

-- ------------------------------------------------------------------
-- Helper: get hazard level at a point across all three layers.
-- Usage:  SELECT * FROM get_hazard_at_point(14.5995, 120.9842);
-- ------------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.get_hazard_at_point(
    p_lat double precision,
    p_lng double precision
) RETURNS TABLE(layer text, hazard text)
    LANGUAGE sql STABLE
    AS $$
    SELECT 'flood_5yr'   AS layer, COALESCE(
        (SELECT CASE hazard_level WHEN 1 THEN 'Low' WHEN 2 THEN 'Medium' WHEN 3 THEN 'High' ELSE 'None' END
         FROM flood_hazard_5yr  WHERE ST_Contains(geom, ST_SetSRID(ST_MakePoint(p_lng, p_lat), 4326)) LIMIT 1),
        'None') AS hazard
    UNION ALL
    SELECT 'flood_25yr', COALESCE(
        (SELECT CASE hazard_level WHEN 1 THEN 'Low' WHEN 2 THEN 'Medium' WHEN 3 THEN 'High' ELSE 'None' END
         FROM flood_hazard_25yr WHERE ST_Contains(geom, ST_SetSRID(ST_MakePoint(p_lng, p_lat), 4326)) LIMIT 1),
        'None')
    UNION ALL
    SELECT 'flood_100yr', COALESCE(
        (SELECT CASE hazard_level WHEN 1 THEN 'Low' WHEN 2 THEN 'Medium' WHEN 3 THEN 'High' ELSE 'None' END
         FROM flood_hazard_100yr WHERE ST_Contains(geom, ST_SetSRID(ST_MakePoint(p_lng, p_lat), 4326)) LIMIT 1),
        'None');
$$;
