import { createRouter, createWebHashHistory } from 'vue-router'
import type { RouteRecordRaw } from 'vue-router'
import GymHomeView from '../views/GymHomeView.vue'
import GymCheckoutView from '../views/GymCheckoutView.vue'
import GymPassView from '../views/GymPassView.vue'
import GymMyPassesView from '../views/GymMyPassesView.vue'

const routes: Array<RouteRecordRaw> = [
  { path: '/', name: 'home', component: GymHomeView },
  { path: '/checkout', name: 'checkout', component: GymCheckoutView },
  { path: '/confirmation/:id?', name: 'confirmation', component: GymPassView },
  { path: '/my-tickets', name: 'my-tickets', component: GymMyPassesView },
  { path: '/:pathMatch(.*)*', redirect: '/' }
]

const router = createRouter({
  history: createWebHashHistory(),
  routes,
  scrollBehavior() { return { top: 0 } }
})

export default router
