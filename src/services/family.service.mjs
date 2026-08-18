import { query } from '#/services/db.mjs';

const FAMILY_COLUMNS = 'family_id, name';

export async function createFamily(name) {
  const result = await query(
    `INSERT INTO family (name) VALUES ($1) RETURNING ${FAMILY_COLUMNS}`,
    [name]
  );
  return result.rows[0];
}

export async function getFamilies({ limit = 50, offset = 0 } = {}) {
  const result = await query(
    `SELECT ${FAMILY_COLUMNS} FROM family ORDER BY family_id LIMIT $1 OFFSET $2`,
    [limit, offset]
  );
  return result.rows;
}

export async function getFamilyById(familyId) {
  const result = await query(
    `SELECT ${FAMILY_COLUMNS} FROM family WHERE family_id = $1`,
    [familyId]
  );
  return result.rows[0] ?? null;
}

// Bonus: useful in a disaster context — who's actually in this family unit
export async function getFamilyMembers(familyId) {
  const result = await query(
    `SELECT u.user_id, u.username, u.phone_number, p.first_name, p.last_name, p.age
     FROM users u
     JOIN people p ON p.person_id = u.person_id
     WHERE u.family_id = $1 AND u.archived_at IS NULL
     ORDER BY u.user_id`,
    [familyId]
  );
  return result.rows;
}

export async function updateFamily(familyId, name) {
  const result = await query(
    `UPDATE family SET name = $1 WHERE family_id = $2 RETURNING ${FAMILY_COLUMNS}`,
    [name, familyId]
  );
  return result.rows[0] ?? null;
}

export async function deleteFamily(familyId) {
  const result = await query(
    `DELETE FROM family WHERE family_id = $1 RETURNING family_id`,
    [familyId]
  );
  return result.rows[0] ?? null;
}