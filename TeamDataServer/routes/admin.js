import express from 'express';
import asyncHandler from 'express-async-handler';

import { getAdmins, getAdmin, deleteAdmin, postAdmin, patchAdmin } from '../controllers/admin.js';

const router = express.Router();

router.get('/', getAdmins);
router.get('/:id', getAdmin);
router.delete('/:id', asyncHandler(deleteAdmin));
router.post('/', postAdmin);
router.patch('/:id', asyncHandler(patchAdmin));

export default router;
