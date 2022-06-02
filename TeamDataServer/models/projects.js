/* eslint-disable camelcase */
import { query, pool } from '../db/index.js';

const dbGetProjects = async () => {
  const { rows } = await query(
    "SELECT name, description, to_char(start, 'YYYY-MM-DD') as start, to_char(deadline, 'YYYY-MM-DD') as deadline, customer_id, admin_id, project_id FROM projects",
  );
  return rows;
};

const dbGetProject = async (id) => {
  const { rows } = await query(
    "SELECT name, description, to_char(start, 'YYYY-MM-DD') as start, to_char(deadline, 'YYYY-MM-DD') as deadline, customer_id, admin_id, project_id FROM projects WHERE project_id =$1",
    [id],
  );
  return rows[0];
};

const dbGetProjectDetails = async () => {
  const { rows } = await query('SELECT * FROM projectdetails');
  return rows[0];
};

const dbGetProjectDetail = async (id) => {
  const { rows } = await query('SELECT * FROM projectdetails WHERE id = $1', [id]);
  return rows[0];
};

const dbDeleteProject = async (id) => {
  const { rows } = await query('DELETE FROM projects WHERE project_id =$1 returning *', [id]);
  return rows[0];
};

const dbpostProject = async (obj) => {
  const { name, description, start, deadline, admin_id, customer_id } = obj;
  return query(
    'INSERT INTO projects (name, description, start, deadline, admin_id, customer_id) VALUES ($1, $2, $3, $4, $5, $6) returning *',
    [name, description, start, deadline, admin_id, customer_id],
  );
};

const dbpatchProject = async (id, obj) => {
  const client = await pool.connect();
  let command = 'UPDATE projects SET ';
  let counter = 1;
  const val = [];
  const commandparts = [];
  await client.query('BEGIN');
  try {
    const isThere = await client.query('SELECT project_id from projects where project_id = $1', [
      id,
    ]);
    if (!isThere == null) return null;
    for (const property in obj) {
      val.push(obj[property]);
      commandparts.push(`${property} = $${counter}`);
      counter++;
    }
    command += commandparts.join(', ');
    command += ` WHERE project_id = $${counter} returning *`;
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

export {
  dbGetProjects,
  dbGetProjectDetails,
  dbGetProjectDetail,
  dbGetProject,
  dbDeleteProject,
  dbpostProject,
  dbpatchProject,
};
