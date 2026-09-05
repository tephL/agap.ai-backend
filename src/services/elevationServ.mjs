import { query } from "#/services/db.mjs";

const OPENTOPODATA_URL = "https://api.opentopodata.org/v1/srtm30m";

// Matches the mobile hook's ~110 m rounding so GPS jitter reuses the same row.
function cacheKey(lat, lng) {
  return `${lat.toFixed(3)},${lng.toFixed(3)}`;
}

/**
 * Ground elevation (m ASL) for a coordinate. Checks the Postgres cache first;
 * on a miss fetches SRTM30 via OpenTopoData and caches the result. Returns
 * null for ocean points (SRTM has no data there) or on any failure — callers
 * already treat unknown elevation as a graceful no-op.
 */
export async function getElevation({ latitude, longitude }) {
  const lat = Number(latitude);
  const lng = Number(longitude);
  if (!Number.isFinite(lat) || !Number.isFinite(lng)) return null;

  const key = cacheKey(lat, lng);

  const cached = await query(
    "SELECT elevation_m FROM elevation_cache WHERE cache_key = $1",
    [key]
  );
  if (cached.rows[0] && cached.rows[0].elevation_m != null) {
    return cached.rows[0].elevation_m;
  }

  const res = await fetch(`${OPENTOPODATA_URL}?locations=${lat},${lng}`);
  if (!res.ok) return null;
  const data = await res.json();
  const elevation = data?.results?.[0]?.elevation ?? null;
  if (elevation == null) return null; // ocean / no SRTM cell — don't cache

  await query(
    `INSERT INTO elevation_cache (cache_key, lat, lng, elevation_m)
     VALUES ($1, $2, $3, $4)
     ON CONFLICT (cache_key)
     DO UPDATE SET elevation_m = EXCLUDED.elevation_m, created_at = NOW()`,
    [key, lat, lng, elevation]
  );

  return elevation;
}