import { query } from '#/services/db.mjs';

const HAZARD_LEVEL_MAP = { 1: 'Low', 2: 'Medium', 3: 'High' };

const LAYERS = [
  { key: 'flood_5yr',   table: 'flood_hazard_5yr' },
  { key: 'flood_25yr',  table: 'flood_hazard_25yr' },
  { key: 'flood_100yr', table: 'flood_hazard_100yr' },
];

/**
 * Look up flood hazard context for a geographic point.
 * Returns an object like:
 *   { flood_5yr: "High", flood_25yr: "Medium", flood_100yr: "None" }
 *
 * "None" means no mapped polygon contains this point — it is a real
 * category, not a null or missing value.
 *
 * Returns null if the lookup fails entirely (DB error, bad coords, etc.)
 * so callers can fall back gracefully.
 */
export async function getHazardContext(lat, lng) {
  if (lat == null || lng == null) return null;
  const latitude = Number(lat);
  const longitude = Number(lng);
  if (!Number.isFinite(latitude) || !Number.isFinite(longitude)) return null;
  if (latitude < -90 || latitude > 90 || longitude < -180 || longitude > 180) return null;

  const result = {};

  for (const { key, table } of LAYERS) {
    try {
      const text = `
        SELECT hazard_level
        FROM ${table}
        WHERE ST_Contains(geom, ST_SetSRID(ST_MakePoint($1, $2), 4326))
        LIMIT 1;
      `;
      const { rows } = await query(text, [longitude, latitude]);
      result[key] = rows[0]
        ? (HAZARD_LEVEL_MAP[rows[0].hazard_level] || 'None')
        : 'None';
    } catch (e) {
      console.warn(`Hazard lookup failed for ${key} at (${lat}, ${lng}):`, e.message);
      result[key] = 'None';
    }
  }

  return result;
}
