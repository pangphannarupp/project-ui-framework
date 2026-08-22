import { createRouter, createWebHashHistory } from 'vue-router'
import type { RouteRecordRaw } from 'vue-router'
import CoffeeHomeView from '../views/CoffeeHomeView.vue'
import CoffeeCheckoutView from '../views/CoffeeCheckoutView.vue'
import CoffeeStatusView from '../views/CoffeeStatusView.vue'
import CoffeeMyOrdersView from '../views/CoffeeMyOrdersView.vue'

const routes: Array<RouteRecordRaw> = [
  { path: '/', name: 'home', component: CoffeeHomeView },
  { path: '/checkout', name: 'checkout', component: CoffeeCheckoutView },
  { path: '/confirmation/:id?', name: 'confirmation', component: CoffeeStatusView },
  { path: '/my-tickets', name: 'my-tickets', component: CoffeeMyOrdersView },
  { path: '/:pathMatch(.*)*', redirect: '/' }
]

const router = createRouter({
  history: createWebHashHistory(),
  routes,
  scrollBehavior() { return { top: 0 } }
})

export default router
