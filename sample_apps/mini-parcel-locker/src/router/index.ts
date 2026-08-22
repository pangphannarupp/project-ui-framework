import { createRouter, createWebHashHistory } from 'vue-router'
import type { RouteRecordRaw } from 'vue-router'
import ParcelHomeView from '../views/ParcelHomeView.vue'
import ParcelCheckoutView from '../views/ParcelCheckoutView.vue'
import ParcelStatusView from '../views/ParcelStatusView.vue'
import ParcelMyHistoryView from '../views/ParcelMyHistoryView.vue'

const routes: Array<RouteRecordRaw> = [
  { path: '/', name: 'home', component: ParcelHomeView },
  { path: '/checkout', name: 'checkout', component: ParcelCheckoutView },
  { path: '/confirmation/:id?', name: 'confirmation', component: ParcelStatusView },
  { path: '/my-tickets', name: 'my-tickets', component: ParcelMyHistoryView },
  { path: '/:pathMatch(.*)*', redirect: '/' }
]

const router = createRouter({
  history: createWebHashHistory(),
  routes,
  scrollBehavior() { return { top: 0 } }
})

export default router
