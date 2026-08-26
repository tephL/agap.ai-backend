const CLUSTER_SYSTEM_PROMPT = `You are a disaster response AI assistant for a Philippines-based emergency reporting system. You analyze aggregated emergency report data for a cluster of incidents and provide a strategic overview for dispatchers and response coordinators. Be concise, actionable, and focus on the bigger picture.`;

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

You are given aggregated data from ${reportCount} emergency report(s) in a single cluster. Synthesize them into a SINGLE cohesive cluster-level summary and action plan.

Individual reports:
${reportSummaries || '  No individual report summaries available.'}

Cluster statistics:
- Total reports: ${reportCount}
- Total people affected: ${totalPeople}
- Severity breakdown: ${JSON.stringify(severityBreakdown)}
- Disaster type breakdown: ${JSON.stringify(disasterBreakdown)}

Return ONLY a valid JSON object (no markdown, no backticks) with these fields:
{
  "ai_summary": "2-3 sentence strategic overview of the cluster situation, highlighting the overall scope, dominant disaster type, severity trend, and key concerns for dispatchers",
  "ai_disaster_type": "One of: ${DISASTER_TYPES.join(', ')}",
  "ai_severity": "One of: ${SEVERITY_VALUES.join(', ')}",
  "ai_action_plan": ["action 1", "action 2", "action 3"]
}

Guidelines:
- The summary should give dispatchers a quick understanding of the overall situation across all reports
- Identify patterns: are reports clustered around the same type? escalating severity?
- The severity should reflect the overall cluster risk (use the highest severity from individual reports as a baseline, but consider compounding factors)
- The disaster type should be the dominant type across reports
- Action plan should focus on cluster-level response coordination, not individual report actions
- Consider compounding risks: multiple reports in the same area may indicate spreading disaster
- Keep the summary concise but informative for decision-makers`;
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
