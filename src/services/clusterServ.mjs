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

// Returns { cluster, reports } for a cluster, but only if it belongs to the
// dispatcher's city. Coordinates are cast to float8 so pg returns JS numbers
// (numeric comes back as strings) ready for map rendering.
export async function getReportsInCluster({ user_id, cluster_id }) {
  try {
    const ownedText = `
      SELECT
          c.cluster_id,
          c.latitude::double precision AS latitude,
          c.longitude::double precision AS longitude,
          c.priority_level,
          c.status,
          c.report_count,
          c.people_affected,
          c.ai_summary,
          c.action_plan,
          ci.name AS city,
          c.created_at,
          c.updated_at
      FROM clusters c
      JOIN users u
          ON u.user_id = $1
      LEFT JOIN people p
          ON p.person_id = u.person_id
      JOIN cities ci
          ON ci.city_id = c.city_id
         AND LOWER(ci.name) = LOWER(p.city)
      WHERE c.cluster_id = $2;
    `;
    const owned = await query(ownedText, [user_id, cluster_id]);
    const [cluster] = owned.rows;
    if (!cluster) return null;

    const text = `
      SELECT
          r.report_id,
          r.latitude::double precision AS latitude,
          r.longitude::double precision AS longitude,
          r.description,
          r.ai_summary,
          r.status,
          r.people_affected,
          r.created_at,
          ru.user_id AS reporter_user_id,
          ru.username AS reporter_username,
          rp.first_name AS reporter_first_name,
          rp.last_name AS reporter_last_name,
          COALESCE(
            json_agg(i.public_url ORDER BY i.created_at)
              FILTER (WHERE i.image_id IS NOT NULL),
            '[]'::json
          ) AS images
      FROM reports r
      JOIN report_clusters rc
          ON rc.report_id = r.report_id
      LEFT JOIN users ru
          ON ru.user_id = r.reported_by
      LEFT JOIN people rp
          ON rp.person_id = ru.person_id
      LEFT JOIN report_images ri
          ON ri.report_id = r.report_id
      LEFT JOIN images i
          ON i.image_id = ri.image_id
      WHERE rc.cluster_id = $1
      GROUP BY r.report_id, ru.user_id, ru.username, rp.first_name, rp.last_name
      ORDER BY r.created_at DESC;
    `;
    const q = await query(text, [cluster_id]);

    const reports = q.rows.map((row) => {
      const { reporter_user_id, reporter_username, reporter_first_name, reporter_last_name, ...report } = row;
      return {
        ...report,
        reporter: reporter_user_id == null ? null : {
          user_id: reporter_user_id,
          username: reporter_username,
          name: [reporter_first_name, reporter_last_name].filter(Boolean).join(' '),
        },
      };
    });

    return { cluster, reports };
  } catch (e) {
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

// Removes clusters that no longer have any reports attached. Safe to run
// often: report_clusters and assignment cascade on delete, teams.assigned_to
// is set null. Returns the deleted cluster ids.
export async function deleteClustersWithoutReports(){
  try{
    const text = `
      DELETE FROM clusters c
      WHERE NOT EXISTS (
        SELECT 1
        FROM report_clusters rc
        WHERE rc.cluster_id = c.cluster_id
      )
      RETURNING cluster_id;
    `;
    const q = await query(text);
    return q.rows.map((row) => row.cluster_id);
  } catch(e){
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
          people_affected = GREATEST(sub.people_sum, sub.ai_people_sum),
          priority_level = CASE
            WHEN sub.max_severity = 'critical' THEN 'high'
            WHEN sub.max_severity = 'high' AND (sub.cnt >= 3 OR sub.ai_people_sum >= 20) THEN 'high'
            WHEN sub.cnt >= 3 OR sub.ai_people_sum >= 8 THEN 'medium'
            WHEN sub.cnt >= 5 OR sub.people_sum >= 20 THEN 'high'
            WHEN sub.cnt >= 3 OR sub.people_sum >= 8 THEN 'medium'
            ELSE 'low'
          END,
          ai_severity = sub.max_severity,
          ai_analyzed_at = CASE WHEN sub.max_severity IS NOT NULL THEN now() ELSE c.ai_analyzed_at END,
          updated_at = now()
      FROM (
        SELECT
          rc.cluster_id,
          AVG(r.latitude) AS avg_lat,
          AVG(r.longitude) AS avg_lon,
          COUNT(*) AS cnt,
          COALESCE(SUM(r.people_affected), 0) AS people_sum,
          MAX(r.ai_severity) AS max_severity,
          COALESCE(SUM(r.ai_people_estimate), 0) AS ai_people_sum
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
