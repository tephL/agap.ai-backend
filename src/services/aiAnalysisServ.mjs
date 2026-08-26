import { query } from '#/services/db.mjs';
import * as geminiServ from '#/services/geminiServ.mjs';

export async function analyzeReport({ report_id }) {
  try {
    const report = await fetchReportWithImages(report_id);
    if (!report) return null;

    const location = report.latitude && report.longitude
      ? { latitude: Number(report.latitude), longitude: Number(report.longitude) }
      : null;

    const personDetails = await fetchReporterDetails(report.reported_by);

    const hasImages = report.images && report.images.length > 0;
    let aiResult;

    if (hasImages) {
      const imageBuffers = await fetchImageBuffers(report.images);
      if (imageBuffers.length > 0) {
        aiResult = await geminiServ.analyzeMultipleImages({
          imageBuffers,
          description: report.description || null,
          location,
          personDetails,
          mimeTypes: imageBuffers.map(() => 'image/jpeg'),
        });
      }
    }

    if (!aiResult) {
      if (!report.description && !personDetails) return null;
      aiResult = await geminiServ.analyzeText({
        description: report.description || null,
        location,
        personDetails,
      });
    }

    await writeReportAI({ report_id, aiResult });

    const clusterLink = await fetchClusterForReport(report_id);
    if (clusterLink) {
      await reevaluateCluster({ cluster_id: clusterLink.cluster_id });
    }

    return aiResult;
  } catch (e) {
    console.error(`AI analysis failed for report ${report_id}:`, e.message);
    return null;
  }
}

export async function reevaluateCluster({ cluster_id }) {
  try {
    const reports = await fetchReportsForCluster(cluster_id);
    if (!reports.length) return null;

    const stats = computeClusterStats(reports);

    let aiResult;
    try {
      aiResult = await geminiServ.analyzeCluster({
        reports,
        totalPeople: stats.people_affected,
        reportCount: reports.length,
      });
    } catch (e) {
      console.error(`Gemini cluster analysis failed for cluster ${cluster_id}, using fallback:`, e.message);
      aiResult = null;
    }

    const summary = {
      ai_summary: aiResult?.ai_summary || stats.mergedSummaries,
      ai_severity: aiResult?.ai_severity || stats.maxSeverity,
      ai_disaster_type: aiResult?.ai_disaster_type || stats.dominantType,
      priority_level: stats.priority,
      people_affected: stats.people_affected,
      action_plan: aiResult?.ai_action_plan || stats.actionPlan,
    };

    await writeClusterAI({ cluster_id, summary });

    return summary;
  } catch (e) {
    console.error(`Cluster re-evaluation failed for cluster ${cluster_id}:`, e.message);
    return null;
  }
}

// ------------------------------------------------------------------
// Data fetchers
// ------------------------------------------------------------------

async function fetchReportWithImages(report_id) {
  const text = `
    SELECT r.report_id, r.latitude, r.longitude, r.description,
           r.reported_by,
           r.ai_summary AS existing_summary
    FROM reports r
    WHERE r.report_id = $1;
  `;
  const { rows } = await query(text, [report_id]);
  const report = rows[0];
  if (!report) return null;

  const imgText = `
    SELECT i.image_id, i.public_url
    FROM report_images ri
    JOIN images i ON i.image_id = ri.image_id
    WHERE ri.report_id = $1
    ORDER BY i.created_at ASC;
  `;
  const imgs = await query(imgText, [report_id]);
  report.images = imgs.rows;

  return report;
}

async function fetchReporterDetails(user_id) {
  if (!user_id) return null;
  const text = `
    SELECT p.age, p.gender, p.city, p.barangay,
           p.disabilities, p.pets, p.house_floors
    FROM users u
    JOIN people p ON p.person_id = u.person_id
    WHERE u.user_id = $1;
  `;
  const { rows } = await query(text, [user_id]);
  return rows[0] || null;
}

async function fetchImageBuffers(images) {
  const buffers = [];
  for (const img of images) {
    try {
      const res = await fetch(img.public_url);
      if (!res.ok) continue;
      const arrayBuf = await res.arrayBuffer();
      buffers.push(Buffer.from(arrayBuf));
    } catch {
      continue;
    }
  }
  return buffers;
}

async function fetchClusterForReport(report_id) {
  const text = `
    SELECT cluster_id
    FROM report_clusters
    WHERE report_id = $1
    LIMIT 1;
  `;
  const { rows } = await query(text, [report_id]);
  return rows[0] || null;
}

async function fetchReportsForCluster(cluster_id) {
  const text = `
    SELECT r.report_id,
           r.ai_summary,
           r.ai_severity,
           r.ai_disaster_type,
           r.ai_people_estimate,
           r.ai_action_plan
    FROM report_clusters rc
    JOIN reports r ON r.report_id = rc.report_id
    WHERE rc.cluster_id = $1
      AND r.ai_analyzed_at IS NOT NULL
      AND r.status != 'resolved';
  `;
  const { rows } = await query(text, [cluster_id]);
  return rows;
}

// ------------------------------------------------------------------
// Aggregation
// ------------------------------------------------------------------

const SEVERITY_RANK = { critical: 4, high: 3, medium: 2, low: 1 };

function computeClusterStats(reports) {
  let totalPeople = 0;
  let maxSeverity = 'low';
  const disasterCounts = {};
  const actionPlanSet = new Set();
  const summaries = [];

  for (const r of reports) {
    if (r.ai_people_estimate) totalPeople += r.ai_people_estimate;

    if (r.ai_severity && SEVERITY_RANK[r.ai_severity] > SEVERITY_RANK[maxSeverity]) {
      maxSeverity = r.ai_severity;
    }

    if (r.ai_disaster_type) {
      disasterCounts[r.ai_disaster_type] = (disasterCounts[r.ai_disaster_type] || 0) + 1;
    }

    if (Array.isArray(r.ai_action_plan)) {
      r.ai_action_plan.forEach(action => actionPlanSet.add(action));
    }

    if (r.ai_summary) summaries.push(r.ai_summary);
  }

  const dominantType = Object.entries(disasterCounts)
    .sort((a, b) => b[1] - a[1])[0]?.[0] || 'other';

  const priority = computePriority(maxSeverity, totalPeople, reports.length);

  const mergedSummaries = summaries.length <= 2
    ? summaries.join(' ')
    : `${summaries[0]} ... and ${summaries.length - 1} more reports.`;

  return {
    maxSeverity,
    dominantType,
    priority,
    people_affected: totalPeople,
    actionPlan: [...actionPlanSet].slice(0, 10),
    mergedSummaries,
  };
}

function computePriority(maxSeverity, totalPeople, reportCount) {
  if (maxSeverity === 'critical') return 'high';
  if (maxSeverity === 'high' && (reportCount >= 3 || totalPeople >= 20)) return 'high';
  if (reportCount >= 3 || totalPeople >= 8) return 'medium';
  return 'low';
}

// ------------------------------------------------------------------
// DB writers
// ------------------------------------------------------------------

async function writeReportAI({ report_id, aiResult }) {
  const text = `
    UPDATE reports
    SET ai_summary        = $2,
        ai_severity       = $3,
        ai_disaster_type  = $4,
        ai_people_estimate = $5,
        ai_action_plan    = $6,
        ai_analyzed_at    = now(),
        ai_raw_response   = $7
    WHERE report_id = $1;
  `;
  const values = [
    report_id,
    aiResult.ai_summary,
    aiResult.ai_severity,
    aiResult.ai_disaster_type,
    aiResult.ai_people_estimate,
    JSON.stringify(aiResult.ai_action_plan),
    JSON.stringify(aiResult),
  ];
  await query(text, values);
}

async function writeClusterAI({ cluster_id, summary }) {
  const text = `
    UPDATE clusters
    SET ai_summary        = $2,
        ai_severity       = $3,
        ai_disaster_type  = $4,
        priority_level    = $5,
        people_affected   = $6,
        action_plan       = $7,
        ai_analyzed_at    = now(),
        updated_at        = now()
    WHERE cluster_id = $1;
  `;
  const values = [
    cluster_id,
    summary.ai_summary,
    summary.ai_severity,
    summary.ai_disaster_type,
    summary.priority_level,
    summary.people_affected,
    JSON.stringify(summary.action_plan),
  ];
  await query(text, values);
}
