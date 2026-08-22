import { DEV } from "#/config/env.mjs";
import { query, pool } from "#/services/db.mjs";
import { hashPassword } from "#/services/hasher.mjs";

const DISPATCHER_PHONE = process.env.DISPATCHER_PHONE || "9170000000";
const DISPATCHER_PASSWORD = process.env.DISPATCHER_PASSWORD || "Dispatcher@123";
const DISPATCHER_ROLE_ID = 911;

async function main() {
  const existing = await query(
    "SELECT user_id FROM users WHERE phone_number = $1 AND role_id = $2;",
    [DISPATCHER_PHONE, DISPATCHER_ROLE_ID]
  );

  if (existing.rows.length > 0) {
    console.log(
      `Dispatcher account already exists (user_id: ${existing.rows[0].user_id}, phone: ${DISPATCHER_PHONE}). Nothing to do.`
    );
    return;
  }

  const hashed_password = hashPassword(DISPATCHER_PASSWORD);
  const result = await query(
    "INSERT INTO users(hashed_password, phone_number, role_id) VALUES ($1, $2, $3) RETURNING user_id;",
    [hashed_password, DISPATCHER_PHONE, DISPATCHER_ROLE_ID]
  );

  console.log("Dispatcher account created:");
  console.log(`  user_id:      ${result.rows[0].user_id}`);
  console.log(`  phone_number: ${DISPATCHER_PHONE}`);
  console.log(`  password:     ${DISPATCHER_PASSWORD}`);
}

main()
  .catch((err) => {
    console.error("Failed to create dispatcher account:", err.message);
    process.exitCode = 1;
  })
  .finally(() => pool.end());
