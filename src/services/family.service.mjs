import { query, withTransaction } from '#/services/db.mjs';

const FAMILY_COLUMNS = 'family_id, name';

export async function createFamilyWithCreator(name, relation, userId) {
  return withTransaction(async (client) => {
    const familyResult = await client.query(
      `INSERT INTO family (name, created_by) VALUES ($1, $2) RETURNING family_id, name`,
      [name, userId]
    );
    const family = familyResult.rows[0];

    await client.query(
      `INSERT INTO family_members (family_id, user_id, relation, status)
       VALUES ($1, $2, $3, 'accepted')`,
      [family.family_id, userId, relation]
    );

    return family;
  });
}

export async function isFamilyCreator(familyId, userId) {
  const result = await query(
    `SELECT 1 FROM family WHERE family_id = $1 AND created_by = $2`,
    [familyId, userId]
  );
  return result.rows.length > 0;
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

export async function getMyFamily(userId) {
  const familyRes = await query(
    `SELECT f.family_id, f.name, f.created_by
     FROM family f
     JOIN family_members fm ON fm.family_id = f.family_id
     WHERE fm.user_id = $1 AND fm.status = 'accepted'
     LIMIT 1`,
    [userId]
  );
  const familyRow = familyRes.rows[0];
  if (!familyRow) return null;

  const members = await getFamilyMembers(familyRow.family_id);

  return {
    family_id: familyRow.family_id,
    name: familyRow.name,
    created_by: familyRow.created_by,
    is_creator: familyRow.created_by === userId,
    members,
  };
}

export async function getFamilyMembers(familyId) {
  const result = await query(
    `SELECT 
        fm.family_member_id,
        u.user_id, 
        u.username, 
        u.phone_number, 
        p.first_name, 
        p.last_name, 
        p.age, 
        fm.relation
     FROM family_members fm
     JOIN users u ON u.user_id = fm.user_id
     LEFT JOIN people p ON p.person_id = u.person_id
     WHERE fm.family_id = $1 AND fm.status = 'accepted' AND u.archived_at IS NULL
     ORDER BY fm.family_member_id`,
    [familyId]
  );
  return result.rows;
}

export async function isAcceptedMember(familyId, userId) {
  const result = await query(
    `SELECT 1 FROM family_members WHERE family_id = $1 AND user_id = $2 AND status = 'accepted'`,
    [familyId, userId]
  );
  return result.rows.length > 0;
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

export async function removeMember(familyId, memberId, requestingUserId) {
  const memberRes = await query(
    `SELECT * FROM family_members
     WHERE family_member_id = $1 AND family_id = $2 AND status = 'accepted'`,
    [memberId, familyId]
  );
  const member = memberRes.rows[0];
  if (!member) return null;

  if (member.user_id === requestingUserId) {
    const err = new Error('The family creator cannot remove themselves. Delete the family instead.');
    err.code = 'CANNOT_REMOVE_CREATOR';
    throw err;
  }

  const result = await query(
    `DELETE FROM family_members WHERE family_member_id = $1 RETURNING family_member_id`,
    [memberId]
  );
  return result.rows[0] ?? null;
}