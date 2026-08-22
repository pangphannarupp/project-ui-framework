import { createRouter, createWebHashHistory } from 'vue-router'
import type { RouteRecordRaw } from 'vue-router'
import EventHomeView from '../views/EventHomeView.vue'
import EventCheckoutView from '../views/EventCheckoutView.vue'
import EventPassView from '../views/EventPassView.vue'
import EventMyTicketsView from '../views/EventMyTicketsView.vue'

const routes: Array<RouteRecordRaw> = [
  { path: '/', name: 'home', component: EventHomeView },
  { path: '/checkout', name: 'checkout', component: EventCheckoutView },
  { path: '/confirmation/:id?', name: 'confirmation', component: EventPassView },
  { path: '/my-tickets', name: 'my-tickets', component: EventMyTicketsView },
  { path: '/:pathMatch(.*)*', redirect: '/' }
]

const router = createRouter({
  history: createWebHashHistory(),
  routes,
  scrollBehavior() { return { top: 0 } }
})

export default router
