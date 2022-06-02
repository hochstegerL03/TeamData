import validator from 'is-my-json-valid';
import {
  dbGetProjects,
  dbGetProjectDetails,
  dbGetProjectDetail,
  dbGetProject,
  dbDeleteProject,
  dbpostProject,
  dbpatchProject,
} from '../models/projects.js';

const getProjects = async (req, res) => res.status(200).json(await dbGetProjects());

const getProjectDetails = async (req, res) => res.status(200).json(await dbGetProjectDetails());
const getProjectDetail = async (req, res) => {
  const { id } = req.params;
  const projectdetail = await dbGetProjectDetail(id);
  if (!projectdetail) return res.status(400).send('Not found.');
  return res.status(200).json(projectdetail);
};

const getProject = async (req, res) => {
  const { id } = req.params;
  const project = await dbGetProject(id);
  if (!project) return res.status(404).send('Not found');
  return res.status(200).json(project);
};

const deleteProject = async (req, res) => {
  const { id } = req.params;
  const result = await dbDeleteProject(id);
  console.log(result);
  if (result === undefined) return res.status(404).send('Not found');
  return res.status(200).json(result);
};

const validateProject = validator({
  required: true,
  type: 'object',
  properties: {
    name: {
      type: 'string',
      required: true,
    },
    description: {
      type: 'string',
      required: true,
    },
    start: {
      type: 'string',
      required: true,
    },
    deadline: {
      type: 'string',
      required: true,
    },
    admin_id: {
      type: 'number',
      required: true,
    },
    customer_id: {
      type: 'number',
      required: true,
    },
  },
});

const validateProjectPatch = validator({
  required: true,
  type: 'object',
  properties: {
    name: {
      type: 'string',
      required: false,
    },
    description: {
      type: 'string',
      required: false,
    },
    start: {
      type: 'string',
      required: false,
    },
    deadline: {
      type: 'string',
      required: false,
    },
    admin_id: {
      type: 'number',
      required: false,
    },
    customer_id: {
      type: 'number',
      required: false,
    },
  },
});

const postProject = async (req, res) => {
  if (validateProject(req.body)) {
    const result = await dbpostProject(req.body);
    if (result) {
      return res.status(200).json(result.rows[0]);
    }
    return res.status(404).send('Values were incorrect');
  }
  return res.status(404).send('Wrong format was used.');
};

const patchProject = async (req, res) => {
  const { id } = req.params;
  console.log(req.body);
  if (validateProjectPatch(req.body)) {
    const result = await dbpatchProject(id, req.body);
    console.log(result);
    if (result) return res.status(200).send(result);
    return res.status(400).send('Not found!');
  }
  return res.status(400).send('Incorrect Properties');
};

export {
  getProjects,
  getProjectDetails,
  getProjectDetail,
  getProject,
  deleteProject,
  postProject,
  patchProject,
};
