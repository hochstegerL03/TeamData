import express from 'express';
import asyncHandler from 'express-async-handler';

import {
  getCustomers,
  getCustomer,
  deleteCustomer,
  postCustomer,
  patchCustomer,
} from '../controllers/customer.js';

const router = express.Router();

router.get('/', getCustomers);
router.get('/:id', getCustomer);
router.delete('/:id', deleteCustomer);
router.post('/', postCustomer);
router.patch('/:id', asyncHandler(patchCustomer));

export default router;
