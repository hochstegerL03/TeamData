/* eslint-disable camelcase */
import { query, pool } from '../db/index.js';

const dbGetAdmins = async () => {
  const { rows } = await query(
    "SELECT firstname, lastname, to_char(birthday, 'DD.MM.YYYY') as birthday, to_char(joined, 'DD.MM.YYYY') as joined, admin_id FROM admins",
  );
  return rows;
};

const dbGetAdmin = async (id) => {
  const { rows } = await query('SELECT * FROM admins WHERE admin_id =$1', [id]);
  return rows[0];
};

const dbDeleteAdmin = async (id) => {
  const client = await pool.connect();
  await client.query('BEGIN');
  try {
    const isThere = await client.query('SELECT project_id from projects where admin_id = $1', [id]);
    if (!isThere == null) return null;
    const { rows } = await query('DELETE FROM admins WHERE admin_id =$1 returning *', [id]);
    await client.query('COMMIT');
    return rows[0];
  } catch (error) {
    client.query('ROLLBACK');
    return null;
  } finally {
    client.release();
  }
};

const dbpostAdmin = async (obj) => {
  const { firstname, lastname, birthday, joined } = obj;
  return query(
    'INSERT INTO admins (firstname, lastname, birthday, joined) VALUES ($1, $2, $3, $4) returning *',
    [firstname, lastname, birthday, joined],
  );
};

const dbpatchAdmin = async (id, obj) => {
  const client = await pool.connect();
  let command = 'UPDATE admins SET ';
  let counter = 1;
  const val = [];
  const commandparts = [];
  await client.query('BEGIN');
  try {
    const isThere = await client.query('SELECT admin_id from admins where admin_id = $1', [
      id,
    ]);
    if (!isThere == null) return null;
    for (const property in obj) {
      val.push(obj[property]);
      commandparts.push(`${property} = $${counter}`);
      counter++;
    }
    command += commandparts.join(', ');
    command += ` WHERE admin_id = $${counter} returning *`;
    console.log(command);
    val.push(Number(id));
    const { rows } = await client.query(command, val);
    await client.query('COMMIT');
    return rows[0];
  } catch (error) {
    client.query('ROLLBACK');
    return null;
  } finally {
    client.release();
  }
};

export { dbGetAdmins, dbGetAdmin, dbDeleteAdmin, dbpostAdmin, dbpatchAdmin };
