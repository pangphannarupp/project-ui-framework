import { createRouter, createWebHashHistory } from 'vue-router';
import type { RouteRecordRaw } from 'vue-router';
import ZooHomeView from '../views/ZooHomeView.vue';
import CheckoutView from '../views/CheckoutView.vue';
import TicketConfirmationView from '../views/TicketConfirmationView.vue';
import MyTicketsView from '../views/MyTicketsView.vue';

const routes: Array<RouteRecordRaw> = [
  {
    path: '/',
    name: 'home',
    component: ZooHomeView
  },
  {
    path: '/checkout',
    name: 'checkout',
    component: CheckoutView
  },
  {
    path: '/confirmation/:id?',
    name: 'confirmation',
    component: TicketConfirmationView
  },
  {
    path: '/my-tickets',
    name: 'my-tickets',
    component: MyTicketsView
  },
  {
    path: '/:pathMatch(.*)*',
    redirect: '/'
  }
];

const router = createRouter({
  history: createWebHashHistory(),
  routes,
  scrollBehavior() {
    return { top: 0 };
  }
});

export default router;
