import express from 'express';
import asyncHandler from 'express-async-handler';

import {
  getProjects,
  getProjectDetails,
  getProjectDetail,
  getProject,
  deleteProject,
  postProject,
  patchProject,
} from '../controllers/projects.js';

const router = express.Router();

router.get('/', getProjects);
router.get('/details', getProjectDetails);
router.get('/details/:id', getProjectDetail);
router.get('/:id', getProject);
router.delete('/:id', deleteProject);
router.post('/', postProject);
router.patch('/:id', asyncHandler(patchProject));

export default router;
