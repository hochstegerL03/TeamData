import validator from 'is-my-json-valid';
import {
  dbGetAdmins,
  dbGetAdmin,
  dbDeleteAdmin,
  dbpostAdmin,
  dbpatchAdmin,
} from '../models/admin.js';

const getAdmins = async (req, res) => res.status(200).json(await dbGetAdmins());

const getAdmin = async (req, res) => {
  const { id } = req.params;
  const admin = await dbGetAdmin(id);
  if (!admin) return res.status(404).send('Not found');
  return res.status(200).json(admin);
};

const deleteAdmin = async (req, res) => {
  const { id } = req.params;
  const result = await dbDeleteAdmin(id);
  console.log(result);
  if (result === null) {
    return res
      .status(400)
      .send('Admin cannot be deleted due to being referenced from the table "projects".');
  }
  if (result === undefined) return res.status(404).send('Not found');
  return res.status(200).json(result);
};

const validateAdmin = validator({
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
  },
});

const validateAdminPatch = validator({
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
  },
});

const postAdmin = async (req, res) => {
  if (validateAdmin(req.body)) {
    const result = await dbpostAdmin(req.body);
    if (result) {
      return res.status(200).json(result.rows[0]);
    }
    return res.status(404).send('Values were incorrect');
  }
  return res.status(404).send('Wrong format was used.');
};

const patchAdmin = async (req, res) => {
  const { id } = req.params;
  console.log(req.body);
  if (validateAdminPatch(req.body)) {
    const result = await dbpatchAdmin(id, req.body);
    console.log(result);
    if (result) return res.status(200).send(result);
    return res.status(400).send('Not found!');
  }
  return res.status(400).send('Incorrect Properties');
};

export { getAdmins, getAdmin, deleteAdmin, postAdmin, patchAdmin };
