import { createRouter, createWebHashHistory } from 'vue-router'
import type { RouteRecordRaw } from 'vue-router'
import WheelHomeView from '../views/WheelHomeView.vue'
import WheelCheckoutView from '../views/WheelCheckoutView.vue'
import WheelMyVouchersView from '../views/WheelMyVouchersView.vue'

const routes: Array<RouteRecordRaw> = [
  { path: '/', name: 'home', component: WheelHomeView },
  { path: '/checkout', name: 'checkout', component: WheelCheckoutView },
  { path: '/my-tickets', name: 'my-tickets', component: WheelMyVouchersView },
  { path: '/:pathMatch(.*)*', redirect: '/' }
]

const router = createRouter({
  history: createWebHashHistory(),
  routes,
  scrollBehavior() { return { top: 0 } }
})

export default router
