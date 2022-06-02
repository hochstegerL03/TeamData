import express from 'express';
import morgan from 'morgan';
import helmet from 'helmet';
import dotenv from 'dotenv';
import cors from 'cors';
import path from 'path';
import employeeRoutes from './routes/employee.js';
import adminRoutes from './routes/admin.js';
import customerRoutes from './routes/customers.js';
import projectsRoutes from './routes/projects.js';
// eslint-disable-next-line import/no-unresolved
import { errorHandler, notFoundHandler } from './middleware/errorHandler.js';

dotenv.config();

const dirname = path.resolve();

const app = express();

app.use(morgan('dev'));
app.use(helmet());
app.use(cors());

app.use(express.static(path.join(dirname, '/public')));

app.use(express.json());

app.use('/employees', employeeRoutes);

app.use('/admins', adminRoutes);

app.use('/customers', customerRoutes);

app.use('/projects', projectsRoutes);

app.use(errorHandler);

app.use(notFoundHandler);

const PORT = process.env.PORT || 5000;

app.listen(PORT, () => console.log('server running'));
