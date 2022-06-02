import validator from 'is-my-json-valid';
import {
  dbGetCustomers,
  dbGetCustomer,
  dbDeleteCustomer,
  dbpostCustomer,
  dbpatchCustomer,
} from '../models/customer.js';

const getCustomers = async (req, res) => res.status(200).json(await dbGetCustomers());

const getCustomer = async (req, res) => {
  const { id } = req.params;
  const customer = await dbGetCustomer(id);
  if (!customer) return res.status(404).send('Not found');
  return res.status(200).json(customer);
};

const deleteCustomer = async (req, res) => {
  const { id } = req.params;
  const result = await dbDeleteCustomer(id);
  console.log(result);
  if (result === null) {
    return res
      .status(400)
      .send('Customer cannot be deleted due to being referenced by the table "projects".');
  }
  if (result === undefined) return res.status(404).send('Not found');
  return res.status(200).json(result);
};

const validateCustomer = validator({
  required: true,
  type: 'object',
  properties: {
    firstname: {
      type: 'string',
      required: true,
    },
    lastname: {
      type: 'string',
      required: true,
    },
    birthday: {
      type: 'string',
      required: true,
    },
    joined: {
      type: 'string',
      required: true,
    },
    company: {
      type: 'string',
      required: true,
    },
    budget: {
      type: 'number',
      required: true,
    },
  },
});

const validateCustomerPatch = validator({
  required: true,
  type: 'object',
  properties: {
    firstname: {
      type: 'string',
      required: false,
    },
    lastname: {
      type: 'string',
      required: false,
    },
    birthday: {
      type: 'string',
      required: false,
    },
    joined: {
      type: 'string',
      required: false,
    },
    company: {
      type: 'string',
      required: false,
    },
    budget: {
      type: 'number',
      required: false,
    },
  },
});

const postCustomer = async (req, res) => {
  if (validateCustomer(req.body)) {
    const result = await dbpostCustomer(req.body);
    if (result) {
      return res.status(200).json(result.rows[0]);
    }
    return res.status(404).send('Values were incorrect');
  }
  return res.status(404).send('Wrong format was used.');
};

const patchCustomer = async (req, res) => {
  const { id } = req.params;
  console.log(req.body);
  if (validateCustomerPatch(req.body)) {
    const result = await dbpatchCustomer(id, req.body);
    console.log(result);
    if (result) return res.status(200).send(result);
    return res.status(400).send('Not found!');
  }
  return res.status(400).send('Incorrect Properties');
};

export { getCustomers, getCustomer, deleteCustomer, postCustomer, patchCustomer };
