import validator from 'is-my-json-valid';
import {
  dbGetEmployees,
  dbGetEmployee,
  dbDeleteEmployee,
  dbpostEmployee,
  dbpatchEmployee,
  dbGetEmployeesDetails,
  dbGetEmployeesDetail,
} from '../models/employee.js';

const getEmployees = async (req, res) => res.status(200).json(await dbGetEmployees());

const getEmployeesDetails = async (req, res) => res.status(200).json(await dbGetEmployeesDetails());

const getEmployeesDetail = async (req, res) => {
  const { id } = req.params;
  const employeedetail = await dbGetEmployeesDetail(id);
  if (!employeedetail) return res.status(400).send('Not found.');
  return res.status(200).json(employeedetail);
};

const getEmployee = async (req, res) => {
  const { id } = req.params;
  const employee = await dbGetEmployee(id);
  if (!employee) return res.status(404).send('Not found');
  return res.status(200).json(employee);
};

const deleteEmployee = async (req, res) => {
  const { id } = req.params;
  const result = await dbDeleteEmployee(id);
  console.log(result);
  if (result === undefined) return res.status(404).send('Not found');
  return res.status(200).json(result);
};

const validateEmployee = validator({
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
    admin_id: {
      type: 'number',
      required: true,
    },
  },
});

const validateEmployeePatch = validator({
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
    admin_id: {
      type: 'number',
      required: false,
    },
  },
});

const postEmployee = async (req, res) => {
  if (validateEmployee(req.body)) {
    const result = await dbpostEmployee(req.body);
    if (result) {
      return res.status(200).json(result.rows[0]);
    }
    return res.status(404).send('Values were incorrect');
  }
  return res.status(404).send('Wrong format was used.');
};

const patchEmployee = async (req, res) => {
  const { id } = req.params;
  console.log(req.body);
  if (validateEmployeePatch(req.body)) {
    const result = await dbpatchEmployee(id, req.body);
    console.log(result);
    if (result) return res.status(200).send(result);
    return res.status(400).send('Not found!');
  }
  return res.status(400).send('Incorrect Properties');
};

export {
  getEmployees,
  getEmployee,
  deleteEmployee,
  postEmployee,
  patchEmployee,
  getEmployeesDetails,
  getEmployeesDetail,
};
