/* eslint-disable camelcase */
import { query, pool } from '../db/index.js';

const dbGetEmployees = async () => {
  const { rows } = await query(
    "SELECT firstname, lastname, to_char(birthday, 'DD.MM.YYYY') as birthday, to_char(joined, 'DD.MM.YYYY') as joined, employee_id, admin_id FROM employees",
  );
  return rows;
};

const dbGetEmployeesDetails = async () => {
  const { rows } = await query('SELECT * FROM employeedetails');
  return rows;
};

const dbGetEmployeesDetail = async (id) => {
  const { rows } = await query('SELECT * FROM employeedetails WHERE id = $1', [id]);
  return rows;
};

const dbGetEmployee = async (id) => {
  const { rows } = await query('SELECT * FROM employees WHERE employee_id =$1', [id]);
  return rows[0];
};

const dbDeleteEmployee = async (id) => {
  const { rows } = await query('DELETE FROM employees WHERE employee_id =$1 returning *', [id]);
  return rows[0];
};

const dbpostEmployee = async (obj) => {
  const { firstname, lastname, birthday, joined, admin_id } = obj;
  return query(
    'INSERT INTO employees (firstname, lastname, birthday, joined, admin_id, employee_id) VALUES ($1, $2, $3, $4, $5, DEFAULT) returning *',
    [firstname, lastname, birthday, joined, admin_id],
  );
};

const dbpatchEmployee = async (id, obj) => {
  const client = await pool.connect();
  let command = 'UPDATE employees SET ';
  let counter = 1;
  const val = [];
  const commandparts = [];
  await client.query('BEGIN');
  try {
    const isThere = await client.query('SELECT employee_id from employees where employee_id = $1', [
      id,
    ]);
    if (!isThere == null) return null;
    for (const property in obj) {
      val.push(obj[property]);
      commandparts.push(`${property} = $${counter}`);
      counter++;
    }
    command += commandparts.join(', ');
    command += ` WHERE employee_id = $${counter} returning *`;
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
  dbGetEmployees,
  dbGetEmployee,
  dbDeleteEmployee,
  dbpostEmployee,
  dbpatchEmployee,
  dbGetEmployeesDetails,
  dbGetEmployeesDetail,
};
