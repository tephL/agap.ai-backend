import genAI from '#/config/gemini.mjs';
import * as conversationServ from '#/services/conversationServ.mjs';
import * as peopleServ from '#/services/peopleServ.mjs';
import * as familyServ from '#/services/family.service.mjs';
import { buildSystemPrompt } from '#/prompts/personalAssistant.mjs';
import { buildHazardEnrichment } from '#/prompts/hazardAssistant.mjs';

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

export async function chat(user_id, message, hazardContext) {
    const { person, familyMembers } = await buildPersonalContext(user_id);
    const systemText = buildSystemPrompt({ person, familyMembers });

    const hazardEnrichment = await buildHazardEnrichment(user_id, message, hazardContext);
    const fullSystemText = hazardEnrichment
        ? `${systemText}\n\n${hazardEnrichment}`
        : systemText;

    const historyRows = await conversationServ.getHistory(user_id, { limit: HISTORY_LIMIT });
    const geminiHistory = toGeminiHistory(historyRows);

    const model = genAI.getGenerativeModel({
        model: MODEL,
        systemInstruction: fullSystemText,
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
           AND status != 'resolved'
         ORDER BY created_at DESC LIMIT 5`,
        [user_id]
    );
    const recentReports = reportRow.rows;

    const suggestions = [];
    const location = person?.barangay || person?.city || 'sa inyong lugar';

    if (recentReports.length === 0) {
        suggestions.push(
            { text: `Ano ang mga karaniwang kalamidad sa ${location}?`, icon: "help-circle" },
            { text: "Paano ko gagawin ang aking emergency go-bag?", icon: "bag" },
            { text: "Ano ang dapat kong gawin kapag may baha?", icon: "water" },
            { text: "Paano ko mapapanatiling ligtas ang aking pamilya kapag may bagyo?", icon: "people" },
        );
        return suggestions;
    }

    const activeReports = recentReports.filter(r => r.status !== 'resolved');
    const hasOpen = activeReports.length > 0;

    const severitySet = new Set(recentReports.map(r => r.ai_severity).filter(Boolean));
    const typeSet = new Set(recentReports.map(r => r.ai_disaster_type).filter(Boolean));

    if (hasOpen) {
        suggestions.push(
            { text: `Ano ang dapat kong gawin ngayon tungkol sa sitwasyon sa ${location}?`, icon: "alert-circle" },
        );
    }

    if (typeSet.has('flood')) {
        suggestions.push(
            { text: "Gaano kataas ko dapat ilipat ang aking mga gamit kapag may baha?", icon: "water" },
            { text: "Ano ang mga pinakaligtas na ruta ng evacuation kapag may pagbaha?", icon: "map" },
        );
    }
    if (typeSet.has('fire')) {
        suggestions.push(
            { text: "Paano ko mapoprotektahan ang aking pula mula sa usok ng sunog?", icon: "flame" },
            { text: "Ano ang dapat kong iligtas muna sa apoy?", icon: "alert-circle" },
        );
    }
    if (typeSet.has('earthquake')) {
        suggestions.push(
            { text: "Ano ang dapat kong gawin habang at pagkatapos ng lindol?", icon: "alert-circle" },
            { text: "Paano ko ihahanda ang aking bahay para sa lindol?", icon: "home" },
        );
    }
    if (typeSet.has('typhoon') || typeSet.has('storm_surge')) {
        suggestions.push(
            { text: "Paano ako maghahanda para sa paparating na bagyo?", icon: "thunderstorm" },
            { text: "Anong mga suplay ang kailangan ko para sa bagyo?", icon: "bag" },
        );
    }
    if (typeSet.has('landslide')) {
        suggestions.push(
            { text: "Ano ang mga senyales ng paparating na landslide?", icon: "warning" },
            { text: "Paano ako ligtas na mag-evacuate mula sa landslide zone?", icon: "walk" },
        );
    }

    if (severitySet.has('critical') || severitySet.has('high')) {
        suggestions.push(
            { text: "Ligtas ba na manatili sa aking bahay ngayon?", icon: "help-circle" },
        );
    }

    if (person?.disabilities?.length > 0) {
        suggestions.push(
            { text: `Paano ako mag-evacuate na may kapansanan?`, icon: "accessibility" },
        );
    }

    const planReports = recentReports.filter(r => r.ai_action_plan && r.ai_action_plan.length > 0);
    if (planReports.length > 0 && !suggestions.some(s => s.text.includes('action plan') || s.text.includes('plano ng aksyon'))) {
        suggestions.push(
            { text: "Maaari mo bang suriin ang aking plano ng aksyon sa emerhensya?", icon: "clipboard" },
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
