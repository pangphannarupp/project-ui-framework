import { createRouter, createWebHashHistory } from 'vue-router'
import type { RouteRecordRaw } from 'vue-router'
import CinemaHomeView from '../views/CinemaHomeView.vue'
import CinemaCheckoutView from '../views/CinemaCheckoutView.vue'
import CinemaTicketView from '../views/CinemaTicketView.vue'
import CinemaMyTicketsView from '../views/CinemaMyTicketsView.vue'

const routes: Array<RouteRecordRaw> = [
  { path: '/', name: 'home', component: CinemaHomeView },
  { path: '/checkout', name: 'checkout', component: CinemaCheckoutView },
  { path: '/confirmation/:id?', name: 'confirmation', component: CinemaTicketView },
  { path: '/my-tickets', name: 'my-tickets', component: CinemaMyTicketsView },
  { path: '/:pathMatch(.*)*', redirect: '/' }
]

const router = createRouter({
  history: createWebHashHistory(),
  routes,
  scrollBehavior() { return { top: 0 } }
})

export default router
