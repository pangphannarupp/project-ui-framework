import { createRouter, createWebHashHistory } from 'vue-router'
import type { RouteRecordRaw } from 'vue-router'
import WashHomeView from '../views/WashHomeView.vue'
import WashCheckoutView from '../views/WashCheckoutView.vue'
import WashPassView from '../views/WashPassView.vue'
import WashMyTicketsView from '../views/WashMyTicketsView.vue'

const routes: Array<RouteRecordRaw> = [
  { path: '/', name: 'home', component: WashHomeView },
  { path: '/checkout', name: 'checkout', component: WashCheckoutView },
  { path: '/confirmation/:id?', name: 'confirmation', component: WashPassView },
  { path: '/my-tickets', name: 'my-tickets', component: WashMyTicketsView },
  { path: '/:pathMatch(.*)*', redirect: '/' }
]

const router = createRouter({
  history: createWebHashHistory(),
  routes,
  scrollBehavior() { return { top: 0 } }
})

export default router
