import { createRouter, createWebHashHistory } from 'vue-router'
import type { RouteRecordRaw } from 'vue-router'
import AppointmentHomeView from '../views/AppointmentHomeView.vue'
import AppointmentCheckoutView from '../views/AppointmentCheckoutView.vue'
import AppointmentConfirmationView from '../views/AppointmentConfirmationView.vue'
import AppointmentMyTicketsView from '../views/AppointmentMyTicketsView.vue'

const routes: Array<RouteRecordRaw> = [
  { path: '/', name: 'home', component: AppointmentHomeView },
  { path: '/checkout', name: 'checkout', component: AppointmentCheckoutView },
  { path: '/confirmation/:id?', name: 'confirmation', component: AppointmentConfirmationView },
  { path: '/my-tickets', name: 'my-tickets', component: AppointmentMyTicketsView },
  { path: '/:pathMatch(.*)*', redirect: '/' }
]

const router = createRouter({
  history: createWebHashHistory(),
  routes,
  scrollBehavior() { return { top: 0 } }
})

export default router
