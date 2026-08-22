import { createRouter, createWebHashHistory } from 'vue-router'
import type { RouteRecordRaw } from 'vue-router'
import EVHomeView from '../views/EVHomeView.vue'
import EVCheckoutView from '../views/EVCheckoutView.vue'
import EVStatusView from '../views/EVStatusView.vue'
import EVMyPassesView from '../views/EVMyPassesView.vue'

const routes: Array<RouteRecordRaw> = [
  { path: '/', name: 'home', component: EVHomeView },
  { path: '/checkout', name: 'checkout', component: EVCheckoutView },
  { path: '/confirmation/:id?', name: 'confirmation', component: EVStatusView },
  { path: '/my-tickets', name: 'my-tickets', component: EVMyPassesView },
  { path: '/:pathMatch(.*)*', redirect: '/' }
]

const router = createRouter({
  history: createWebHashHistory(),
  routes,
  scrollBehavior() { return { top: 0 } }
})

export default router
