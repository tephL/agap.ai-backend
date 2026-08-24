import { query } from '#/services/db.mjs';

const EPS_METERS = 400; 

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

export async function getNearestCluster({ latitude, longitude }) {
  try {
    const text = `
      SELECT
        cluster_id,
        latitude,
        longitude,
        (
          6371000 * acos(
            LEAST(1, GREATEST(-1,
              cos(radians($1)) * cos(radians(latitude)) *
              cos(radians(longitude) - radians($2)) +
              sin(radians($1)) * sin(radians(latitude))
            ))
          )
        ) AS distance_m
      FROM clusters
      WHERE status = 'open'
      ORDER BY distance_m ASC
      LIMIT 1;
    `;
    const values = [latitude, longitude];
    const q = await query(text, values);
    const [nearest] = q.rows;

    if (!nearest || nearest.distance_m > EPS_METERS) {
      return null; 
    }
    return nearest;
  } catch (e) {
    throw e;
  }
}

export async function createCluster({ latitude, longitude, city_id, people_affected = 0 }) {
  try {
    const text = `
      INSERT INTO clusters(latitude, longitude, city_id, status, report_count, people_affected, priority_level, created_at, updated_at)
      VALUES($1, $2, $3, 'open', 1, COALESCE($4, 0), 'low', now(), now())
      RETURNING cluster_id;
    `;
    const values = [latitude, longitude, city_id, people_affected];
    const q = await query(text, values);
    return q.rows[0];
  } catch (e) {
    throw e;
  }
}

export async function updateClusterStats(cluster_id) {
  try {
    const text = `
      UPDATE clusters c
      SET latitude = sub.avg_lat,
          longitude = sub.avg_lon,
          report_count = sub.cnt,
          people_affected = sub.people_sum,
          priority_level = CASE
            WHEN sub.cnt >= 5 OR sub.people_sum >= 20 THEN 'high'
            WHEN sub.cnt >= 3 OR sub.people_sum >= 8 THEN 'medium'
            ELSE 'low'
          END,
          updated_at = now()
      FROM (
        SELECT
          rc.cluster_id,
          AVG(r.latitude) AS avg_lat,
          AVG(r.longitude) AS avg_lon,
          COUNT(*) AS cnt,
          COALESCE(SUM(r.people_affected), 0) AS people_sum
        FROM report_clusters rc
        JOIN reports r ON r.report_id = rc.report_id
        WHERE rc.cluster_id = $1
        GROUP BY rc.cluster_id
      ) sub
      WHERE c.cluster_id = sub.cluster_id;
    `;
    await query(text, [cluster_id]);
  } catch (e) {
    throw e;
  }
}
