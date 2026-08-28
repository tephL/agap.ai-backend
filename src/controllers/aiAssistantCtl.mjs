import { matchedData } from 'express-validator';
import { whoIsUser } from '#/middlewares/helper-mid.mjs';
import * as personalizedAI from '#/services/personalizedAI.mjs';

export async function chat(req, res) {
    try {
        const { user_id } = whoIsUser(req);
        const { message } = matchedData(req);
        const hazardContext = req.body?.hazardContext || null;

        const reply = await personalizedAI.chat(user_id, message, hazardContext);
        return res.status(200).json({ reply });
    } catch (e) {
        console.error('AI chat error:', e.message);
        return res.status(500).json({ message: 'Failed to get AI response' });
    }
}

export async function getHistory(req, res) {
    try {
        const { user_id } = whoIsUser(req);
        const { limit, offset } = matchedData(req);

        const messages = await personalizedAI.getHistory(user_id, {
            limit: limit ?? 20,
            offset: offset ?? 0,
        });
        return res.status(200).json({ messages });
    } catch (e) {
        console.error('AI history error:', e.message);
        return res.status(500).json({ message: 'Failed to fetch history' });
    }
}

export async function clearHistory(req, res) {
    try {
        const { user_id } = whoIsUser(req);
        await personalizedAI.clearHistory(user_id);
        return res.sendStatus(200);
    } catch (e) {
        console.error('AI clear history error:', e.message);
        return res.status(500).json({ message: 'Failed to clear history' });
    }
}

export async function getSuggestions(req, res) {
    try {
        const { user_id } = whoIsUser(req);
        const suggestions = await personalizedAI.getSuggestions(user_id);
        return res.status(200).json({ suggestions });
    } catch (e) {
        console.error('AI suggestions error:', e.message);
        return res.status(500).json({ message: 'Failed to fetch suggestions' });
    }
}
