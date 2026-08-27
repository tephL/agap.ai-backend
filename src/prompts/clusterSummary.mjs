const CLUSTER_SYSTEM_PROMPT = `Ikaw ay isang AI na tumutugon sa mga kaganapang pang-emergency para sa isang disaster reporting system sa Pilipinas. Sinusuri mo ang pinagsama-samang datos ng mga ulat ng emerhensya para sa isang cluster ng mga insidente at nagbibigay ng estratehikong pangkalahatang-ideya para sa mga dispatcher at coordinator ng tugon. Maging maikli, nangangahulugan, at nakatuon sa mas malaking larawan. LAGING tumugon sa Filipino.

MGA PANGUNAHING TUNTUNIN:
- CONCISE: Ibigay ang PINAKAMAIKLING posibleng sagot na may sapat na impormasyon para sa desisyon. Direkta ang punto, walang dagdag na paliwanag.
- TAGALOG: Lahat ng teksto (summary, action plan) ay dapat nasa malinaw na Tagalog, hindi mixed.`;

const SEVERITY_VALUES = ['critical', 'high', 'medium', 'low'];
const DISASTER_TYPES = [
  'flood', 'fire', 'earthquake', 'landslide', 'typhoon',
  'storm_surge', 'collapse', 'other',
];

export function buildClusterPrompt({ reports, totalPeople, reportCount }) {
  const reportSummaries = reports
    .filter(r => r.ai_summary)
    .map((r, i) => {
      let entry = `  ${i + 1}. [${r.ai_severity?.toUpperCase() || 'UNKNOWN'}] ${r.ai_summary}`;
      if (r.ai_people_estimate) entry += ` (${r.ai_people_estimate} people)`;
      return entry;
    })
    .join('\n');

  const severityBreakdown = {};
  const disasterBreakdown = {};
  for (const r of reports) {
    if (r.ai_severity) severityBreakdown[r.ai_severity] = (severityBreakdown[r.ai_severity] || 0) + 1;
    if (r.ai_disaster_type) disasterBreakdown[r.ai_disaster_type] = (disasterBreakdown[r.ai_disaster_type] || 0) + 1;
  }

  return `${CLUSTER_SYSTEM_PROMPT}

Binibigyan ka ng datos mula sa ${reportCount} ulat ng emerhensya sa iisang cluster. Pagsamahin ang mga ito sa iisang magkakaugnay na buod ng cluster at plano ng aksyon.

Mga indibidwal na ulat:
${reportSummaries || '  Walang available na buod ng indibidwal na ulat.'}

Estadistika ng cluster:
- Kabuuang ulat: ${reportCount}
- Kabuuang taong apektado: ${totalPeople}
- Pagkakabaha-bahagi ng severity: ${JSON.stringify(severityBreakdown)}
- Pagkakabaha-bahagi ng uri ng kalamidad: ${JSON.stringify(disasterBreakdown)}

Ibalik LANG ang valid na JSON object (walang markdown, walang backticks) na may mga field na ito:
{
  "ai_summary": "2 pangungusap na estratehikong pangkalahatang-ideya ng cluster: pangkalahatang sakop, nangingibabaw na uri ng kalamidad, at takbo ng severity, sa Filipino",
  "ai_disaster_type": "Isa sa mga: ${DISASTER_TYPES.join(', ')}",
  "ai_severity": "Isa sa mga: ${SEVERITY_VALUES.join(', ')}",
  "ai_action_plan": ["1-3 na pinakamahalagang aksyon para sa koordinasyon ng tugon"]
}

Mga alituntunin:
- CONCISE: Ang ai_summary ay limitado sa 2 pangungusap. Ang ai_action_plan ay maximum 3 aksyon, bawat isa ay maikling parirala.
- Ang buod ay dapat magbigay sa mga dispatcher ng mabilis na pag-unawa sa pangkalahatang sitwasyon sa lahat ng ulat
- Tukuyin ang mga pattern: pareho bang uri ng kalamidad ang mga ulat? lumalala ba ang severity?
- Ang severity ay dapat sumalamin sa pangkalahatang panganib ng cluster (gamitin ang pinakamataas na severity mula sa mga indibidwal na ulat bilang baseline, ngunit isaalang-alang ang mga kababalagang nagpapalala)
- Ang uri ng kalamidad ay dapat ang pinakanangingibabaw na uri sa lahat ng ulat
- Ang plano ng aksyon ay dapat nakatuon sa koordinasyon ng tugon sa antas ng cluster, hindi sa mga aksyon ng indibidwal na ulat
- Isaalang-alang ang mga kababalagang nagpapalala: maraming ulat sa iisang lugar ay maaaring nagpapahiwatig ng kumakalat na kalamidad
- Panatilihing maikli ngunit may sapat na impormasyon para sa mga nagdedesisyon
- Lahat ng teksto (summary at action plan) ay dapat nasa malinaw na Filipino, hindi mixed`;
}

export function validateClusterResult(data) {
  if (!data || typeof data !== 'object') throw new Error('Invalid cluster AI response: not an object');

  if (typeof data.ai_summary !== 'string' || data.ai_summary.length === 0) {
    throw new Error('Invalid cluster AI response: missing or empty ai_summary');
  }

  if (!SEVERITY_VALUES.includes(data.ai_severity)) {
    throw new Error(`Invalid cluster AI response: ai_severity must be one of ${SEVERITY_VALUES.join(', ')}`);
  }

  if (!DISASTER_TYPES.includes(data.ai_disaster_type)) {
    throw new Error(`Invalid cluster AI response: ai_disaster_type must be one of ${DISASTER_TYPES.join(', ')}`);
  }

  if (!Array.isArray(data.ai_action_plan) || data.ai_action_plan.length === 0) {
    throw new Error('Invalid cluster AI response: ai_action_plan must be a non-empty array');
  }

  return {
    ai_summary: data.ai_summary,
    ai_disaster_type: data.ai_disaster_type,
    ai_severity: data.ai_severity,
    ai_action_plan: data.ai_action_plan,
  };
}
