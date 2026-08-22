import { createRouter, createWebHashHistory } from 'vue-router'
import type { RouteRecordRaw } from 'vue-router'
import LaundryHomeView from '../views/LaundryHomeView.vue'
import LaundryCheckoutView from '../views/LaundryCheckoutView.vue'
import LaundryStatusView from '../views/LaundryStatusView.vue'
import LaundryMySessionsView from '../views/LaundryMySessionsView.vue'

const routes: Array<RouteRecordRaw> = [
  { path: '/', name: 'home', component: LaundryHomeView },
  { path: '/checkout', name: 'checkout', component: LaundryCheckoutView },
  { path: '/confirmation/:id?', name: 'confirmation', component: LaundryStatusView },
  { path: '/my-tickets', name: 'my-tickets', component: LaundryMySessionsView },
  { path: '/:pathMatch(.*)*', redirect: '/' }
]

const router = createRouter({
  history: createWebHashHistory(),
  routes,
  scrollBehavior() { return { top: 0 } }
})

export default router
