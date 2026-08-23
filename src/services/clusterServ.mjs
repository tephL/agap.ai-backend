import { query } from '#/services/db.mjs';

export async function getClustersFromCityOfDispatcher(user_id){
  try{
    const text = `
      SELECT
          LOWER(p.city) AS city,
          c.latitude, 
          c.longitude,
          c.priority,
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
