import { createRouter, createWebHashHistory } from 'vue-router'
import type { RouteRecordRaw } from 'vue-router'
import HotelHomeView from '../views/HotelHomeView.vue'
import HotelCheckoutView from '../views/HotelCheckoutView.vue'
import HotelPassView from '../views/HotelPassView.vue'
import HotelMyStaysView from '../views/HotelMyStaysView.vue'

const routes: Array<RouteRecordRaw> = [
  { path: '/', name: 'home', component: HotelHomeView },
  { path: '/checkout', name: 'checkout', component: HotelCheckoutView },
  { path: '/confirmation/:id?', name: 'confirmation', component: HotelPassView },
  { path: '/my-tickets', name: 'my-tickets', component: HotelMyStaysView },
  { path: '/:pathMatch(.*)*', redirect: '/' }
]

const router = createRouter({
  history: createWebHashHistory(),
  routes,
  scrollBehavior() { return { top: 0 } }
})

export default router
