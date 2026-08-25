import genAI from '#/config/gemini.mjs';
import * as conversationServ from '#/services/conversationServ.mjs';
import * as peopleServ from '#/services/peopleServ.mjs';
import * as familyServ from '#/services/family.service.mjs';
import { buildSystemPrompt } from '#/prompts/personalAssistant.mjs';

const MODEL = 'gemini-3.5-flash-lite';
const HISTORY_LIMIT = 20;

async function buildPersonalContext(user_id) {
    let person = null;
    let familyMembers = null;

    const { query: dbQuery } = await import('#/services/db.mjs');
    const userRow = await dbQuery(
        'SELECT person_id FROM users WHERE user_id = $1',
        [user_id]
    );
    const userData = userRow.rows[0];

    if (userData?.person_id) {
        person = await peopleServ.getPersonById(userData.person_id);
    }

    try {
        const myFamily = await familyServ.getMyFamily(user_id);
        if (myFamily?.members) {
            familyMembers = myFamily.members;
        }
    } catch {
        // User may not have a family
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

export async function getSuggestions(user_id) {
    const { query: dbQuery } = await import('#/services/db.mjs');

    const userRow = await dbQuery(
        'SELECT person_id FROM users WHERE user_id = $1',
        [user_id]
    );
    const userData = userRow.rows[0];

    let person = null;
    if (userData?.person_id) {
        const { rows } = await dbQuery(
            'SELECT city, barangay, disabilities, age FROM people WHERE person_id = $1',
            [userData.person_id]
        );
        person = rows[0] || null;
    }

    const reportRow = await dbQuery(
        `SELECT ai_disaster_type, ai_severity, ai_summary, ai_action_plan, status, created_at
         FROM reports WHERE reported_by = $1
         ORDER BY created_at DESC LIMIT 5`,
        [user_id]
    );
    const recentReports = reportRow.rows;

    const suggestions = [];
    const location = person?.barangay || person?.city || 'your area';

    if (recentReports.length === 0) {
        suggestions.push(
            { text: `What disasters are common in ${location}?`, icon: "help-circle" },
            { text: "How do I prepare an emergency go-bag?", icon: "bag" },
            { text: "What should I do during a flood?", icon: "water" },
            { text: "How can I keep my family safe during a typhoon?", icon: "people" },
        );
        return suggestions;
    }

    const activeReports = recentReports.filter(r => r.status !== 'resolved');
    const hasOpen = activeReports.length > 0;

    const severitySet = new Set(recentReports.map(r => r.ai_severity).filter(Boolean));
    const typeSet = new Set(recentReports.map(r => r.ai_disaster_type).filter(Boolean));

    if (hasOpen) {
        suggestions.push(
            { text: `What should I do right now about the ${location} situation?`, icon: "alert-circle" },
        );
    }

    if (typeSet.has('flood')) {
        suggestions.push(
            { text: "How high should I move my belongings during a flood?", icon: "water" },
            { text: "What are the safest evacuation routes during flooding?", icon: "map" },
        );
    }
    if (typeSet.has('fire')) {
        suggestions.push(
            { text: "How do I protect my family from wildfire smoke?", icon: "flame" },
            { text: "What should I evacuate first in a fire emergency?", icon: "alert-circle" },
        );
    }
    if (typeSet.has('earthquake')) {
        suggestions.push(
            { text: "What should I do during and after an earthquake?", icon: "alert-circle" },
            { text: "How do I prepare my home for earthquakes?", icon: "home" },
        );
    }
    if (typeSet.has('typhoon') || typeSet.has('storm_surge')) {
        suggestions.push(
            { text: "How can I prepare for an incoming typhoon?", icon: "thunderstorm" },
            { text: "What supplies do I need for a typhoon?", icon: "bag" },
        );
    }
    if (typeSet.has('landslide')) {
        suggestions.push(
            { text: "What are the warning signs of a landslide?", icon: "warning" },
            { text: "How do I evacuate safely from a landslide zone?", icon: "walk" },
        );
    }

    if (severitySet.has('critical') || severitySet.has('high')) {
        suggestions.push(
            { text: "Is it safe to stay in my home right now?", icon: "help-circle" },
        );
    }

    if (person?.disabilities?.length > 0) {
        suggestions.push(
            { text: `How should I evacuate with mobility concerns?`, icon: "accessibility" },
        );
    }

    const planReports = recentReports.filter(r => r.ai_action_plan && r.ai_action_plan.length > 0);
    if (planReports.length > 0 && !suggestions.some(s => s.text.includes('action plan'))) {
        suggestions.push(
            { text: "Can you review my emergency action plan?", icon: "clipboard" },
        );
    }

    const seen = new Set();
    const unique = suggestions.filter(s => {
        if (seen.has(s.text)) return false;
        seen.add(s.text);
        return true;
    });

    return unique.slice(0, 5);
}
