import { createRouter, createWebHashHistory } from 'vue-router'
import type { RouteRecordRaw } from 'vue-router'
import FoodHomeView from '../views/FoodHomeView.vue'
import FoodCheckoutView from '../views/FoodCheckoutView.vue'
import FoodOrderStatusView from '../views/FoodOrderStatusView.vue'
import FoodMyOrdersView from '../views/FoodMyOrdersView.vue'

const routes: Array<RouteRecordRaw> = [
  { path: '/', name: 'home', component: FoodHomeView },
  { path: '/checkout', name: 'checkout', component: FoodCheckoutView },
  { path: '/confirmation/:id?', name: 'confirmation', component: FoodOrderStatusView },
  { path: '/my-tickets', name: 'my-tickets', component: FoodMyOrdersView },
  { path: '/:pathMatch(.*)*', redirect: '/' }
]

const router = createRouter({
  history: createWebHashHistory(),
  routes,
  scrollBehavior() { return { top: 0 } }
})

export default router
