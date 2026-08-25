import genAI from '#/config/gemini.mjs';
import * as conversationServ from '#/services/conversationServ.mjs';
import * as peopleServ from '#/services/peopleServ.mjs';
import * as familyServ from '#/services/family.service.mjs';
import { buildSystemPrompt } from '#/prompts/personalAssistant.mjs';

const MODEL = 'gemini-3.5-flash-lite';
const HISTORY_LIMIT = 20;

async function buildPersonalContext(user_id) {
    const user = await familyServ.getFamilyMembers(null).catch(() => null);

    let person = null;
    let familyMembers = null;

    // Fetch person details via a direct query since we need user's own person_id
    const { query: dbQuery } = await import('#/services/db.mjs');
    const userRow = await dbQuery(
        'SELECT person_id, family_id FROM users WHERE user_id = $1',
        [user_id]
    );
    const userData = userRow.rows[0];

    if (userData?.person_id) {
        person = await peopleServ.getPersonById(userData.person_id);
    }

    if (userData?.family_id) {
        familyMembers = await familyServ.getFamilyMembers(userData.family_id);
    }

    return { person, familyMembers };
}

function toGeminiHistory(messages) {
    return messages.map((m) => ({
        role: m.role === 'assistant' ? 'model' : 'user',
        parts: [{ text: m.content }],
    }));
}

export async function chat(user_id, message) {
    const { person, familyMembers } = await buildPersonalContext(user_id);
    const systemText = buildSystemPrompt({ person, familyMembers });

    const historyRows = await conversationServ.getHistory(user_id, { limit: HISTORY_LIMIT });
    const geminiHistory = toGeminiHistory(historyRows);

    const model = genAI.getGenerativeModel({
        model: MODEL,
        systemInstruction: systemText,
    });

    const chatSession = model.startChat({ history: geminiHistory });
    const result = await chatSession.sendMessage(message);
    const reply = result.response.text();

    await conversationServ.saveMessage(user_id, 'user', message);
    await conversationServ.saveMessage(user_id, 'assistant', reply);

    return reply;
}

export async function getHistory(user_id, opts) {
    return conversationServ.getHistory(user_id, opts);
}

export async function clearHistory(user_id) {
    return conversationServ.clearHistory(user_id);
}
