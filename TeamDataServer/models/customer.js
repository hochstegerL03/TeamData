/* eslint-disable camelcase */
import { query, pool } from '../db/index.js';

const dbGetCustomers = async () => {
  const { rows } = await query(
    "SELECT firstname, lastname, to_char(birthday, 'DD.MM.YYYY') as birthday, to_char(joined, 'DD.MM.YYYY') as joined, company, budget, customer_id FROM customers",
  );
  return rows;
};

const dbGetCustomer = async (id) => {
  const { rows } = await query('SELECT * FROM customers WHERE customer_id =$1', [id]);
  return rows[0];
};

const dbDeleteCustomer = async (id) => {
  const client = await pool.connect();
  await client.query('BEGIN');
  try {
    const isThere = await client.query('SELECT project_id from projects where customer_id = $1', [id]);
    if (!isThere == null) return null;
    const { rows } = await query('DELETE FROM customers WHERE customer_id =$1 returning *', [id]);
    await client.query('COMMIT');
    return rows[0];
  } catch (error) {
    client.query('ROLLBACK');
    return null;
  } finally {
    client.release();
  }
};

const dbpostCustomer = async (obj) => {
  const { firstname, lastname, birthday, joined, company, budget } = obj;
  return query(
    'INSERT INTO customers (firstname, lastname, birthday, joined, company, budget) VALUES ($1, $2, $3, $4, $5, $6) returning *',
    [firstname, lastname, birthday, joined, company, budget],
  );
};

const dbpatchCustomer = async (id, obj) => {
  const client = await pool.connect();
  let command = 'UPDATE customers SET ';
  let counter = 1;
  const val = [];
  const commandparts = [];
  await client.query('BEGIN');
  try {
    const isThere = await client.query('SELECT customer_id from customers where customer_id = $1', [
      id,
    ]);
    if (!isThere == null) return null;
    for (const property in obj) {
      val.push(obj[property]);
      commandparts.push(`${property} = $${counter}`);
      counter++;
    }
    command += commandparts.join(', ');
    command += ` WHERE customer_id = $${counter} returning *`;
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

export { dbGetCustomers, dbGetCustomer, dbDeleteCustomer, dbpostCustomer, dbpatchCustomer };
