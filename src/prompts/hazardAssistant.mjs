import { query } from '#/services/db.mjs';
import * as hazardServ from '#/services/hazardServ.mjs';

/**
 * Authoritative knowledge about the hazard map layers used in the app,
 * injected into the assistant's system prompt so Gemini answers hazard-layer
 * questions (the "?" button on a hazard layer) with the app's exact
 * vocabulary (return periods + legend semantics) instead of generic or
 * hallucinated flood-map trivia.
 */
export const HAZARD_LAYER_REFERENCE = `--- Gabay sa Hazard Layers (mapa) ---
May kasamang hazard map ang app. Ang mga may kulay na overlay sa mapa ay batay sa Project NOAH hazard maps. Narito ang tamang kahulugan ng hazard layers at mga kulay nito:

MGA FLOOD HAZARD LAYER (Flood Risk):
- "Flood Risk (5-Year Return Period)": ang mga lugar na maaaring maapektuhan ng pagbaha na may 20% ka-chance na mangyari sa isang taon (tinatayang isang beses kada 5 taon sa karaniwan). Madalas na pagbaha, kadalasang mas maliit ang saklaw.
- "Flood Risk (25-Year Return Period)": ang mga lugar na maaaring maapektuhan ng pagbaha na may 4% ka-chance na mangyari sa isang taon (tinatayang isang beses kada 25 taon sa karaniwan). Mas malaki at mas malawak ang saklaw.
- "Flood Risk (100-Year Return Period)": ang mga lugar na maaaring maapektuhan ng napakalaking pagbaha na may 1% ka-chance na mangyari sa isang taon (tinatayang isang beses kada 100 taon sa karaniwan). Pinakamatindi at pinakamalawak na pagbaha.
- Tandaan: ang "return period" ay isang sukat ng posibilidad, HINDI eksaktong siklo. Hindi ibig sabihin na kung lumipas ang isang baha ay ligtas na ang lugar sa susunod na 5/25/100 taon.

KAHULUGAN NG KULAY SA MAPA (flood):
- Mapusyaw na asul = Mababa ang panganib (0–0.5 m ang lalim ng tubig)
- Katamtamang asul = Katamtaman ang panganib (0.5–1.5 m ang lalim)
- Madilim na asul = Mataas ang panganib (higit sa 1.5 m ang lalim)

LANDSLIDE:
- "Landslide Susceptibility": ang mga lugar na posibleng maapektuhan ng landslide/pagguho ng lupa, batay sa pagsusuri ng Project NOAH.`;

const HAZARD_PATTERN =
  /(hazard\s*layer|hazard\s*map|flood|baha|landslide|pagguho|debris|susceptibility|return\s*period)/i;

export function isHazardQuestion(message) {
  if (!message || typeof message !== 'string') return false;
  return HAZARD_PATTERN.test(message);
}

const FLOOD_LAYER_LABELS = {
  flood_5yr: 'Flood Risk (5-Year Return Period)',
  flood_25yr: 'Flood Risk (25-Year Return Period)',
  flood_100yr: 'Flood Risk (100-Year Return Period)',
};

/** Matches the app's flood legend: flood `Var` property 1 = low, 2 = medium, 3 = high. */
const VAR_LEVEL_LABELS = {
  1: 'Mababa (0–0.5 m na lalim ng tubig)',
  2: 'Katamtaman (0.5–1.5 m na lalim ng tubig)',
  3: 'Mataas (higit sa 1.5 m na lalim ng tubig)',
};

/**
 * Fetch the flood hazard levels at the user's saved location, e.g.
 *   { flood_5yr: 'High', flood_25yr: 'Medium', flood_100yr: 'None' }
 * Returns null when the user has no saved coordinates or the lookup fails.
 */
export async function getHazardContextForUser(user_id) {
  const { rows } = await query(
    'SELECT latitude, longitude FROM users WHERE user_id = $1',
    [user_id]
  );
  const row = rows?.[0];
  if (!row || row.latitude == null || row.longitude == null) return null;
  return hazardServ.getHazardContext(row.latitude, row.longitude);
}

export function buildHazardContextText(hazard) {
  if (!hazard) return '';
  const lines = [];
  for (const key of ['flood_5yr', 'flood_25yr', 'flood_100yr']) {
    const label = FLOOD_LAYER_LABELS[key];
    const level = hazard[key];
    if (!label || !level) continue;
    lines.push(`- ${label}: ${level}`);
  }
  if (!lines.length) return '';
  return `Aktwal na panganib sa lokasyon ng gumagamit (mula sa hazard map):\n${lines.join('\n')}`;
}

export function buildHazardInstructions(hasLocationContext) {
  const lines = [
    '--- Kapag Tungkol sa Hazard Layer/Mapa o Pagbaha ---',
    'Kapag ang tanong ay tungkol sa isang hazard layer (hal. "Flood Risk..."), sagutin nang ganito:',
    '- (1) Ibigay ang tamang kahulugan ng tinutukoy na layer gamit ang "Gabay sa Hazard Layers", kasama ang kahulugan ng return period.',
    '- (2) Ipaliwanag ang kahulugan ng mga kulay sa mapa gamit ang "Kahulugan ng Kulay sa Mapa".',
    '- (3) Gamitan ng [IMPORMASYON] para sa paliwanag ng layer at kulay.',
  ];
  if (hasLocationContext) {
    lines.push(
      '- (4) Gamitin ang "Aktwal na panganib sa lokasyon ng gumagamit" upang sabihin kung ang kanyang lugar ay nasa panganib para sa layer na iyon at kung ano ang dapat gawin.'
    );
    lines.push(
      '- (5) Kung ang antas sa lokasyon ay Medium/High, magdagdag ng [WARNING]; kung Low o None, mahinahong sabihin ito ngunit paalalahanan na ang kalamidad ay hindi lubos na mahuhulaan.'
    );
  }
  lines.push(
    '- Magbigay ng 1–2 maikling safety o preparedness tip na may [TIP] tag.',
    '- Layunin ng 5–10 bullet o linya: sapat at detalyado kaysa isang generic na pangungusap, ngunit hindi maligoy. Direkta at kapaki-pakinabang.'
  );
  return lines.join('\n');
}

/**
 * Build extra system-instruction content for hazard questions, or null when
 * the message is not about hazards. Combines the authoritative layer
 * reference, the user's real flood risk, and hazard-specific response
 * instructions.
 *
 * Flood risk comes from one of two sources:
 * - `clientContext` ({ hazardLayerId, hazardVar }): the phone resolved the
 *   rendered hazard layer under the user's location (the primary path). The
 *   var level (1/2/3) is exactly what the map paints, so this is trusted.
 * - otherwise it falls back to the server-side spatial lookup of the user's
 *   saved coordinates (hazardServ).
 */
export async function buildHazardEnrichment(user_id, message, clientContext) {
  if (!isHazardQuestion(message)) return null;

  let contextText = '';

  const clientLayerId = clientContext?.hazardLayerId;
  const clientVar = clientContext?.hazardVar;
  const clientLabel = FLOOD_LAYER_LABELS[clientLayerId];
  const clientLevelLabel = VAR_LEVEL_LABELS[clientVar];
  if (clientLayerId && clientLabel && clientLevelLabel !== undefined) {
    contextText =
      `Aktwal na panganib sa lokasyon ng gumagamit (mula sa hazard layer na in-on ng gumagamit sa kanyang app): ` +
      `sa layer na "${clientLabel}", ang kanyang lokasyon ay nasa ${clientLevelLabel} na panganib (halagang Var = ${clientVar}).`;
  } else {
    let hazard = null;
    try {
      hazard = await getHazardContextForUser(user_id);
    } catch (e) {
      console.warn(`Hazard context failed for user ${user_id}:`, e.message);
    }
    contextText = buildHazardContextText(hazard);
  }

  const parts = [HAZARD_LAYER_REFERENCE];
  if (contextText) parts.push(contextText);
  parts.push(buildHazardInstructions(Boolean(contextText)));
  return parts.join('\n\n');
}