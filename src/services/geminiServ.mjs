import genAI from '#/config/gemini.mjs';

const MODEL = 'gemini-3.5-flash-lite';

const SEVERITY_VALUES = ['critical', 'high', 'medium', 'low'];
const DISASTER_TYPES = [
  'flood', 'fire', 'earthquake', 'landslide', 'typhoon',
  'storm_surge', 'collapse', 'other',
];

const SYSTEM_PROMPT = `You are a disaster response AI assistant for a Philippines-based emergency reporting system. Analyze emergency report data and return a JSON object with the specified fields. Be concise and accurate. Base your assessment on the visual evidence and any provided context.`;

function buildPrompt({ description, location }) {
  let context = '';
  if (description) context += `\n- Description from reporter: "${description}"`;
  if (location) context += `\n- Location: lat ${location.latitude}, lng ${location.longitude}`;

  return `${SYSTEM_PROMPT}

Analyze this emergency report and return ONLY a valid JSON object (no markdown, no backticks) with these fields:
{
  "ai_summary": "Brief 1-2 sentence summary of the situation",
  "ai_disaster_type": "One of: ${DISASTER_TYPES.join(', ')}",
  "ai_severity": "One of: ${SEVERITY_VALUES.join(', ')}",
  "ai_people_estimate": <integer, estimated number of people affected based on what you see>,
  "ai_action_plan": ["action 1", "action 2", "action 3"]
}

Severity guidelines:
- critical: immediate life threat, active rescue needed, people trapped or in danger
- high: significant danger, urgent response needed, property at risk
- medium: concerning situation, response needed within hours
- low: minor incident, monitoring sufficient

Context:${context || '\n- No additional context provided.'}`;
}

function validateResult(data) {
  if (!data || typeof data !== 'object') throw new Error('Invalid AI response: not an object');

  if (typeof data.ai_summary !== 'string' || data.ai_summary.length === 0) {
    throw new Error('Invalid AI response: missing or empty ai_summary');
  }

  if (!SEVERITY_VALUES.includes(data.ai_severity)) {
    throw new Error(`Invalid AI response: ai_severity must be one of ${SEVERITY_VALUES.join(', ')}`);
  }

  if (!DISASTER_TYPES.includes(data.ai_disaster_type)) {
    throw new Error(`Invalid AI response: ai_disaster_type must be one of ${DISASTER_TYPES.join(', ')}`);
  }

  if (!Number.isInteger(data.ai_people_estimate) || data.ai_people_estimate < 0) {
    throw new Error('Invalid AI response: ai_people_estimate must be a non-negative integer');
  }

  if (!Array.isArray(data.ai_action_plan) || data.ai_action_plan.length === 0) {
    throw new Error('Invalid AI response: ai_action_plan must be a non-empty array');
  }

  return {
    ai_summary: data.ai_summary,
    ai_disaster_type: data.ai_disaster_type,
    ai_severity: data.ai_severity,
    ai_people_estimate: data.ai_people_estimate,
    ai_action_plan: data.ai_action_plan,
  };
}

function parseJsonFromResponse(text) {
  const trimmed = text.trim();
  const withoutMarkdown = trimmed.replace(/^```(?:json)?\s*/i, '').replace(/\s*```$/i, '');
  return JSON.parse(withoutMarkdown);
}

async function callGemini(prompt, imageParts) {
  const model = genAI.getGenerativeModel({ model: MODEL });

  const parts = [];
  if (imageParts) parts.push(...imageParts);
  parts.push({ text: prompt });

  const result = await model.generateContent({
    contents: [{ role: 'user', parts }],
    generationConfig: { responseMimeType: 'application/json' },
  });
  const response = await result.response;
  const text = response.text();

  const parsed = parseJsonFromResponse(text);
  return validateResult(parsed);
}

function bufferToGenerativePart(buffer, mimeType = 'image/jpeg') {
  return {
    inlineData: {
      data: buffer.toString('base64'),
      mimeType,
    },
  };
}

export async function analyzeImage({ imageBuffer, description, location, mimeType }) {
  const prompt = buildPrompt({ description, location });
  const imagePart = bufferToGenerativePart(imageBuffer, mimeType || 'image/jpeg');
  return callGemini(prompt, [imagePart]);
}

export async function analyzeMultipleImages({ imageBuffers, description, location, mimeTypes }) {
  const prompt = buildPrompt({ description, location });
  const imageParts = imageBuffers.map((buf, i) =>
    bufferToGenerativePart(buf, mimeTypes?.[i] || 'image/jpeg')
  );
  return callGemini(prompt, imageParts);
}

export async function analyzeText({ description, location }) {
  const prompt = buildPrompt({ description, location });
  return callGemini(prompt, null);
}
