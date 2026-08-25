import { query } from '#/services/db.mjs';

export async function saveMessage(user_id, role, content) {
    const text = `
        INSERT INTO ai_conversations (user_id, role, content)
        VALUES ($1, $2, $3)
        RETURNING conversation_id, role, content, created_at;
    `;
    const { rows } = await query(text, [user_id, role, content]);
    return rows[0];
}

export async function getHistory(user_id, { limit = 20, offset = 0 } = {}) {
    const text = `
        SELECT conversation_id, role, content, created_at
        FROM ai_conversations
        WHERE user_id = $1
        ORDER BY created_at ASC
        LIMIT $2 OFFSET $3;
    `;
    const { rows } = await query(text, [user_id, limit, offset]);
    return rows;
}

export async function clearHistory(user_id) {
    const text = 'DELETE FROM ai_conversations WHERE user_id = $1;';
    await query(text, [user_id]);
}
