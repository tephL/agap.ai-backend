import { query } from "#/services/db.mjs";

export async function getActiveTyphoon() {
  const result = await query(
    "SELECT * FROM typhoons WHERE status = 'active' ORDER BY created_at DESC LIMIT 1"
  );
  return result.rows[0] ?? null;
}

export async function getAllTyphoons() {
  const result = await query(
    "SELECT * FROM typhoons ORDER BY created_at DESC"
  );
  return result.rows;
}

export async function createTyphoon({ name, category, status, source }) {
  const result = await query(
    `INSERT INTO typhoons (name, season_year, category, status, source)
     VALUES ($1, EXTRACT(YEAR FROM NOW())::int, $2, $3, $4)
     RETURNING *`,
    [name, category ?? "Tropical Cyclone", status ?? "active", source ?? "PAGASA"]
  );
  return result.rows[0];
}

export async function updateTyphoon(typhoon_id, { name, category, status, source }) {
  const result = await query(
    `UPDATE typhoons
     SET name = COALESCE($2, name),
         category = COALESCE($3, category),
         status = COALESCE($4, status),
         source = COALESCE($5, source),
         updated_at = NOW()
     WHERE typhoon_id = $1
     RETURNING *`,
    [typhoon_id, name, category, status, source]
  );
  return result.rows[0] ?? null;
}

export async function deleteTyphoon(typhoon_id) {
  await query("DELETE FROM typhoons WHERE typhoon_id = $1", [typhoon_id]);
}
