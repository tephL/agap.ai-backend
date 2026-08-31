import { query } from "#/services/db.mjs";
import { whoIsUser } from "#/middlewares/helper-mid.mjs";

/**
 * GET /api/my-assignments
 *
 * Returns active team assignments for clusters that contain the
 * current citizen's reports. Used by the mobile app to show
 * "help is on the way" notifications.
 *
 * Join path:
 *   users -> reports (reported_by)
 *         -> report_clusters (report_id)
 *         -> clusters (cluster_id)
 *         -> assignment (cluster_id)
 *         -> teams (team_id)
 *         -> cities (cluster.city_id)
 */
export async function getMyAssignments(req, res) {
  try {
    const session = whoIsUser(req);
    if (!session?.user_id) {
      return res.status(401).json({ error: "Not authenticated" });
    }

    const text = `
      SELECT DISTINCT
        a.assignment_id,
        a.team_id,
        a.cluster_id,
        a.status          AS assignment_status,
        a.created_at      AS assignment_created_at,
        t.name            AS team_name,
        t.latitude        AS team_lat,
        t.longitude       AS team_lng,
        c.cluster_id      AS c_cluster_id,
        c.latitude        AS cluster_lat,
        c.longitude       AS cluster_lng,
        c.priority_level,
        c.report_count,
        c.people_affected,
        ci.name           AS city_name
      FROM reports r
      JOIN report_clusters rc ON rc.report_id = r.report_id
      JOIN clusters c         ON c.cluster_id = rc.cluster_id
      LEFT JOIN cities ci     ON ci.city_id = c.city_id
      JOIN assignment a       ON a.cluster_id = c.cluster_id
      JOIN teams t            ON t.team_id = a.team_id
      WHERE r.reported_by = $1
        AND a.status IN ('pending', 'dispatched', 'cancelled')
      ORDER BY a.created_at DESC;
    `;

    const result = await query(text, [session.user_id]);

    const assignments = result.rows.map((row) => ({
      assignment_id: row.assignment_id,
      team_id: row.team_id,
      cluster_id: row.cluster_id,
      status: row.assignment_status,
      created_at: row.assignment_created_at,
      team: {
        name: row.team_name,
        lat: row.team_lat != null ? Number(row.team_lat) : null,
        lng: row.team_lng != null ? Number(row.team_lng) : null,
      },
      cluster: {
        cluster_id: row.c_cluster_id,
        lat: row.cluster_lat != null ? Number(row.cluster_lat) : null,
        lng: row.cluster_lng != null ? Number(row.cluster_lng) : null,
        priority_level: row.priority_level,
        report_count: row.report_count,
        people_affected: row.people_affected,
        city: row.city_name,
      },
    }));

    return res.json({ assignments });
  } catch (err) {
    console.error("getMyAssignments error:", err);
    return res.status(500).json({ error: "Failed to load assignments" });
  }
}
