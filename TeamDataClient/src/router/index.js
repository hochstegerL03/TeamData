import { createRouter, createWebHistory } from 'vue-router';
import ProjectView from '../views/ProjectView.vue';

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'projects',
      component: ProjectView,
    },
    {
      path: '/add',
      name: 'add',
      component: () => import('../views/ProjektAddView.vue'),
    },
  ],
});

export default router;
