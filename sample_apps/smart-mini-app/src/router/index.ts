import { createRouter, createWebHashHistory } from 'vue-router';
import type { RouteRecordRaw } from 'vue-router';
import BrowsePlansView from '@/views/smart-app/BrowsePlansView.vue';

const routes: Array<RouteRecordRaw> = [
  {
    path: '/',
    redirect: '/smart-mini-app'
  },
  {
    path: '/smart-mini-app',
    component: () => import('@/views/SmartMiniApp.vue')
  },
  {
    path: '/smart/browse-plans',
    name: 'smart-browse-plans',
    component: BrowsePlansView
  }
];

const router = createRouter({
  history: createWebHashHistory(),
  routes
});

export default router;
