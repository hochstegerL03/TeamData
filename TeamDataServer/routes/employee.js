import express from 'express';
import asyncHandler from 'express-async-handler';

import {
  getEmployees,
  getEmployee,
  deleteEmployee,
  postEmployee,
  patchEmployee,
  getEmployeesDetails,
  getEmployeesDetail,
} from '../controllers/employee.js';

const router = express.Router();

router.get('/', getEmployees);
router.get('/details', getEmployeesDetails);
router.get('/details/:id', getEmployeesDetail);
router.get('/:id', getEmployee);
router.delete('/:id', deleteEmployee);
router.post('/', postEmployee);
router.patch('/:id', asyncHandler(patchEmployee));

export default router;
