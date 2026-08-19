import { query, withTransaction } from '#/services/db.mjs';
import { getUserWithPhone } from '#/services/userServ.mjs';

export async function inviteMember(familyId, phoneNumber, relation) {
  const invitee = await getUserWithPhone(phoneNumber);
  if (!invitee) {
    const err = new Error('No registered user found with that phone number');
    err.code = 'USER_NOT_FOUND';
    throw err;
  }

  const existing = await query(
    `SELECT * FROM family_members WHERE family_id = $1 AND user_id = $2`,
    [familyId, invitee.user_id]
  );

  if (existing.rows.length > 0) {
    const row = existing.rows[0];
    if (row.status === 'accepted') {
      const err = new Error('This person is already a member of the family');
      err.code = 'ALREADY_MEMBER';
      throw err;
    }
    if (row.status === 'pending') {
      const err = new Error('This person already has a pending invitation');
      err.code = 'ALREADY_PENDING';
      throw err;
    }
    const updated = await query(
      `UPDATE family_members SET status = 'pending', relation = $1
       WHERE family_member_id = $2 RETURNING *`,
      [relation, row.family_member_id]
    );
    return updated.rows[0];
  }

  const result = await query(
    `INSERT INTO family_members (family_id, user_id, relation, status)
     VALUES ($1, $2, $3, 'pending') RETURNING *`,
    [familyId, invitee.user_id, relation]
  );
  return result.rows[0];
}

export async function getMyInvitations(userId) {
  const result = await query(
    `SELECT fm.family_member_id, fm.family_id, f.name AS family_name, fm.relation
     FROM family_members fm
     JOIN family f ON f.family_id = fm.family_id
     WHERE fm.user_id = $1 AND fm.status = 'pending'`,
    [userId]
  );
  return result.rows;
}

export async function acceptInvitation(invitationId, userId) {
  return withTransaction(async (client) => {
    const inviteRes = await client.query(
      `SELECT * FROM family_members WHERE family_member_id = $1 AND user_id = $2 AND status = 'pending'`,
      [invitationId, userId]
    );
    const invite = inviteRes.rows[0];
    if (!invite) return null;

    const existingRes = await client.query(
      `SELECT 1 FROM family_members WHERE user_id = $1 AND status = 'accepted'`,
      [userId]
    );
    if (existingRes.rows.length > 0) {
      const err = new Error('You are already a member of another family');
      err.code = 'ALREADY_MEMBER';
      throw err;
    }

    const updated = await client.query(
      `UPDATE family_members SET status = 'accepted' WHERE family_member_id = $1 RETURNING *`,
      [invitationId]
    );

    await client.query(
      `UPDATE family_members SET status = 'rejected'
       WHERE user_id = $1 AND status = 'pending' AND family_member_id != $2`,
      [userId, invitationId]
    );

    return updated.rows[0];
  });
}

export async function rejectInvitation(invitationId, userId) {
  const result = await query(
    `UPDATE family_members SET status = 'rejected'
     WHERE family_member_id = $1 AND user_id = $2 AND status = 'pending'
     RETURNING *`,
    [invitationId, userId]
  );
  return result.rows[0] ?? null;
}