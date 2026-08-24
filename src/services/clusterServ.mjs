import { query } from '#/services/db.mjs';

export async function getClustersFromCityOfDispatcher(user_id){
  try{
    const text = `
      SELECT
          LOWER(p.city) AS city,
          c.cluster_id, 
          c.latitude, 
          c.longitude,
          c.priority_level,
          c.status,
          c.report_count,
          c.people_affected,
          c.ai_summary,
          c.action_plan
      FROM users u
      LEFT JOIN people p
          ON p.person_id = u.person_id
      LEFT JOIN cities ci
          ON LOWER(ci.name) = LOWER(p.city)
      LEFT JOIN clusters c
          ON c.city_id = ci.city_id
      WHERE u.role_id = 911
        AND u.user_id = $1;
    `;
    const values = [user_id];
    const q = await query(text, values);
    return q.rows;
  } catch(e){
    throw e;
  }
}

export async function assignReportToCluster({ report_id, cluster_id, reported_by }) {
  try {
    const existingReports = await reportOfUserFromCluster({ user_id: reported_by, cluster_id });

    if (existingReports.length === 0) {
      await query(
        `INSERT INTO report_clusters(report_id, cluster_id)
         VALUES($1, $2)`,
        [report_id, cluster_id]
      );
      return;
    }

    const { report_id: existingReportId } = existingReports[0];

    await query(
      `UPDATE report_clusters
       SET report_id = $1
       WHERE report_id = $2
         AND cluster_id = $3`,
      [report_id, existingReportId, cluster_id]
    );
    return;
  } catch (e) {
    throw e;
  }
}

export async function reportOfUserFromCluster({ user_id, cluster_id }){
  try{
    const text = `
      select rc.report_id 
      from clusters c 
      left join report_clusters rc 
        on rc.cluster_id = c.cluster_id 
      left join reports r 	
        on r.report_id = rc.report_id
      where r.reported_by = $1
      and c.cluster_id = $2;
    `;
    const values = [user_id, cluster_id];
    const q = await query(text, values);
    return q.rows;
  } catch(e){
    throw e;
  }
}

// TODO: bruh make this functional
// TODO: make an alternative for not having cluster_id found
export async function getNearestCluster({ latitude, longitude }){
  return { cluster_id: 1 };
}
