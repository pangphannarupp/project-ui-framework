import { createRouter, createWebHashHistory } from 'vue-router'
import type { RouteRecordRaw } from 'vue-router'
import BusHomeView from '../views/BusHomeView.vue'
import BusCheckoutView from '../views/BusCheckoutView.vue'
import BusPassView from '../views/BusPassView.vue'
import BusMyTicketsView from '../views/BusMyTicketsView.vue'

const routes: Array<RouteRecordRaw> = [
  { path: '/', name: 'home', component: BusHomeView },
  { path: '/checkout', name: 'checkout', component: BusCheckoutView },
  { path: '/confirmation/:id?', name: 'confirmation', component: BusPassView },
  { path: '/my-tickets', name: 'my-tickets', component: BusMyTicketsView },
  { path: '/:pathMatch(.*)*', redirect: '/' }
]

const router = createRouter({
  history: createWebHashHistory(),
  routes,
  scrollBehavior() { return { top: 0 } }
})

export default router
