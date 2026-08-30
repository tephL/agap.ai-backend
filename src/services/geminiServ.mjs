import genAI from '#/config/gemini.mjs';
import { buildClusterPrompt, validateClusterResult } from '#/prompts/clusterSummary.mjs';

const MODEL = 'gemini-3.5-flash-lite';

const SEVERITY_VALUES = ['critical', 'high', 'medium', 'low'];
const DISASTER_TYPES = [
  'flood', 'fire', 'earthquake', 'landslide', 'typhoon',
  'storm_surge', 'collapse', 'other',
];

const SYSTEM_PROMPT = `Ikaw ay isang AI na tumutugon sa mga kaganapang pang-emergency para sa isang disaster reporting system sa Pilipinas. Wastong suriin ang datos ng ulat at magbigay ng JSON na tugon. Tiyakin na ang bawat detalye ay may kinalaman sa emerhensya o kalamidad. Huwag magbigay ng impormasyon na wala sa paksa.

MGA PANGUNAHING TUNTUNIN (para sa lahat ng teksto):
- CONCISE: Magbigay ng PINAKAMAIKLING sagot na posible. Direktahin ang punto. Huwag magdagdag ng hindi kinakailangang paliwanag o salita. Isang pangungusap o ilang bullet lang kung sapat na.
- TAGALOG: Lahat ng teksto (summary, action plan, rekomendasyon) ay dapat nasa malinaw na Tagalog. Iwasan ang labis na English terms maliban kung walang eksaktong salin.`;

function buildBaselinePrompt({ location, personDetails }) {
  let context = '';
  if (location) context += `\n- Lokasyon: lat ${location.latitude}, lng ${location.longitude}`;
  if (personDetails) {
    context += '\n- Detalye ng gumagamit:';
    if (personDetails.first_name) context += ` Pangalan: ${personDetails.first_name}`;
    if (personDetails.age != null) context += `, Edad: ${personDetails.age}`;
    if (personDetails.gender) context += `, Kasarian: ${personDetails.gender}`;
    if (personDetails.barangay) context += `, Barangay: ${personDetails.barangay}`;
    if (personDetails.city) context += `, Lungsod: ${personDetails.city}`;
    if (personDetails.disabilities?.length) context += `, Kapansanan: ${personDetails.disabilities.join(', ')}`;
    if (personDetails.pets?.length) context += `, Alagang hayop: ${personDetails.pets.join(', ')}`;
    if (personDetails.house_floors) context += `, Naninirahan sa ${personDetails.house_floors}-palapag na bahay`;
  }

  return `${SYSTEM_PROMPT}

Suriin ang profile ng gumagamit at ang kanyang lokasyon upang lumikha ng baseline na panganib na pagtatasa para sa mga kalamidad. I-return LANG ang valid na JSON object (walang markdown, walang backticks) na may mga field na ito:
{
  "risk_level": "critical", "high", "medium", o "low",
  "vulnerability_factors": ["1-3 na pinakamahalagang salik"],
  "recommended_actions": ["2-3 na pinakamahalagang hakbang"],
  "summary": "Napakaikling buod ng panganib at ang pinakamahalagang dapat tandaan, 1-2 pangungusap lang sa Tagalog"
}

Mga alituntunin:
- CONCISE: Limitahan ang vulnerability_factors sa 1-3 at recommended_actions sa 2-3. Maikli at diretso ang bawat bullet.
- Tanging ang mga kadahilanang may kinalaman sa panganib at kalamidad lang ang isama (edad, kapansanan, lokasyon, uri ng bahay, alagang hayop)
- Ang mga recommended_actions ay dapat nakatuon sa paghahanda at kaligtasan ng panganib
- Huwag magbigay ng impormasyong walang kinalaman sa emerhensya o kalamidad
- Lahat ng teksto (vulnerability_factors, recommended_actions, summary) ay dapat nasa malinaw na Filipino

Konteksto:${context || '\n- Walang karagdagang konteksto.'}`;
}

function buildPrompt({ description, location, personDetails }) {
  let context = '';
  if (description) context += `\n- Paglalarawan mula sa nag-ulat: "${description}"`;
  if (location) context += `\n- Lokasyon: lat ${location.latitude}, lng ${location.longitude}`;
  if (personDetails) {
    context += '\n- Profile ng nag-ulat:';
    if (personDetails.age != null) context += ` Edad ${personDetails.age}`;
    if (personDetails.gender) context += `, ${personDetails.gender}`;
    if (personDetails.barangay) context += `, Barangay ${personDetails.barangay}`;
    if (personDetails.city) context += `, ${personDetails.city}`;
    if (personDetails.disabilities?.length) context += `, kapansanan: ${personDetails.disabilities.join(', ')}`;
    if (personDetails.pets?.length) context += `, may alagang hayop: ${personDetails.pets.join(', ')}`;
    if (personDetails.house_floors) context += `, naninirahan sa ${personDetails.house_floors}-palapag na bahay`;
  } else {
    context += '\n- Walang available na profile ng nag-ulat: hindi alam ang edad, kasarian, kapansanan, o iba pang vulnerability factor. Huwag idagdag o ibawas sa severity batay sa hindi kilalang data ng nag-ulat.';
  }

  return `${SYSTEM_PROMPT}

Suriin ang ulat na ito ng emerhensya at ibalik LANG ang valid na JSON object (walang markdown, walang backticks) na may mga field na ito:
{
  "ai_summary": "Pinakamaikling buod ng sitwasyon, 1 pangungusap lang, sa Filipino",
  "ai_disaster_type": "Isa sa mga: ${DISASTER_TYPES.join(', ')}",
  "ai_severity": "Isa sa mga: ${SEVERITY_VALUES.join(', ')}",
  "ai_people_estimate": <integer, tinatayang bilang ng mga taong apektado batay sa nakikita mo>,
  "ai_action_plan": ["1-3 na pinakamahalagang aksyon"]
}

Mga alituntunin sa severity:
- critical: agarang banta sa buhay, kailangan ng aktibong pagliligtas, may mga nakakulong o nasa panganib
- high: malaking panganib, kailangan ng agarang aksyon, nasa panganib ang ari-arian
- medium: nakababahala na sitwasyon, kailangan ng aksyon sa loob ng ilang oras
- low: minor na insidente, sapat ang pagsubaybay

CONCISE na tuntunin:
- Limitahan ang ai_action_plan sa pinakamarami 3 aksyon, bawat isa ay 1-3 salita o maikling parirala. Direkta ang punto, walang paligoy-ligoy.
- Ang ai_summary ay dapat isang maikling pangungusap lang na nagpapakita ng pinakamahalagang impormasyon.

Isaalang-alang ang profile ng nag-ulat kapag tinatantiya ang severity at mga taong nasa panganib. Ang mga matatanda, may kapansanan, may alagang hayop, at naninirahan sa ibaba ng bahay ay mas nasa panganib sa mga kalamidad.

Rationale ng vulnerability weighting (para sa transparency):
- Ang weighting na ito ay sinasadya: pinangangalagaan nito ang mga at-risk na tao sa pamamagitan ng pag-taas ng severity para sa mas maapektuhan ng kalamidad. Naaapektuhan nito ang cluster priority sa pamamagitan ng maxSeverity.
- Ang gender ay kasama lamang bilang isang maingat na factor (hal. buntis, matatandang babae sa mababang lugar) at dapat gamitin nang konserbatibo — huwag itaas ang severity batay lamang sa kasarian nang walang tiyak at may-katwirang panganib.
- Huwag masyadong umasa sa profile ng nag-ulat; ang pangunahing basehan ng severity ay ang katotohanan ng sitwasyon (imga, paglalarawan, lokasyon). Ang profile ay pampalakas (adjacent), hindi kapalit, ng hazard data.
- Kung walang profile ang nag-ulat, huwag ibawas ang severity dahil lamang dito — ituring itong neutral, hindi mas mababa ang panganib.

Ang ai_summary at ai_action_plan ay dapat nasa malinaw na Filipino (hindi mixed). Huwag magbigay ng impormasyong walang kinalaman sa emerhensya o kalamidad.

Konteksto:${context || '\n- Walang karagdagang konteksto.'}`;
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

function validateBaselineResult(data) {
  if (!data || typeof data !== 'object') throw new Error('Invalid baseline AI response: not an object');

  if (!SEVERITY_VALUES.includes(data.risk_level)) {
    throw new Error(`Invalid baseline AI response: risk_level must be one of ${SEVERITY_VALUES.join(', ')}`);
  }

  if (!Array.isArray(data.vulnerability_factors)) {
    throw new Error('Invalid baseline AI response: vulnerability_factors must be an array');
  }

  if (!Array.isArray(data.recommended_actions) || data.recommended_actions.length === 0) {
    throw new Error('Invalid baseline AI response: recommended_actions must be a non-empty array');
  }

  if (typeof data.summary !== 'string' || data.summary.length === 0) {
    throw new Error('Invalid baseline AI response: missing or empty summary');
  }

  return {
    risk_level: data.risk_level,
    vulnerability_factors: data.vulnerability_factors,
    recommended_actions: data.recommended_actions,
    summary: data.summary,
  };
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

export async function analyzeImage({ imageBuffer, description, location, mimeType, personDetails }) {
  const prompt = buildPrompt({ description, location, personDetails });
  const imagePart = bufferToGenerativePart(imageBuffer, mimeType || 'image/jpeg');
  return callGemini(prompt, [imagePart]);
}

export async function analyzeMultipleImages({ imageBuffers, description, location, mimeTypes, personDetails }) {
  const prompt = buildPrompt({ description, location, personDetails });
  const imageParts = imageBuffers.map((buf, i) =>
    bufferToGenerativePart(buf, mimeTypes?.[i] || 'image/jpeg')
  );
  return callGemini(prompt, imageParts);
}

export async function analyzeText({ description, location, personDetails }) {
  const prompt = buildPrompt({ description, location, personDetails });
  return callGemini(prompt, null);
}

// ------------------------------------------------------------------
// Cluster-level analysis
// ------------------------------------------------------------------

async function callClusterGemini(prompt) {
  const model = genAI.getGenerativeModel({ model: MODEL });

  const result = await model.generateContent({
    contents: [{ role: 'user', parts: [{ text: prompt }] }],
    generationConfig: { responseMimeType: 'application/json' },
  });
  const response = await result.response;
  const text = response.text();

  const parsed = parseJsonFromResponse(text);
  return validateClusterResult(parsed);
}

export async function analyzeCluster({ reports, totalPeople, reportCount }) {
  const prompt = buildClusterPrompt({ reports, totalPeople, reportCount });
  return callClusterGemini(prompt);
}

// ------------------------------------------------------------------
// Baseline user profile analysis
// ------------------------------------------------------------------

async function callBaselineGemini(prompt) {
  const model = genAI.getGenerativeModel({ model: MODEL });

  const result = await model.generateContent({
    contents: [{ role: 'user', parts: [{ text: prompt }] }],
    generationConfig: { responseMimeType: 'application/json' },
  });
  const response = await result.response;
  const text = response.text();

  const parsed = parseJsonFromResponse(text);
  return validateBaselineResult(parsed);
}

export async function analyzeBaseline({ location, personDetails }) {
  const prompt = buildBaselinePrompt({ location, personDetails });
  return callBaselineGemini(prompt);
}
