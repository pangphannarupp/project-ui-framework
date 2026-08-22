import { createRouter, createWebHashHistory } from 'vue-router'
import type { RouteRecordRaw } from 'vue-router'
import ParkingHomeView from '../views/ParkingHomeView.vue'
import ParkingCheckoutView from '../views/ParkingCheckoutView.vue'
import GatePassView from '../views/GatePassView.vue'
import ParkingMyPassesView from '../views/ParkingMyPassesView.vue'

const routes: Array<RouteRecordRaw> = [
  { path: '/', name: 'home', component: ParkingHomeView },
  { path: '/checkout', name: 'checkout', component: ParkingCheckoutView },
  { path: '/confirmation', name: 'confirmation', component: GatePassView },
  { path: '/my-tickets', name: 'my-tickets', component: ParkingMyPassesView },
  { path: '/:pathMatch(.*)*', redirect: '/' }
]

const router = createRouter({
  history: createWebHashHistory(),
  routes,
  scrollBehavior() { return { top: 0 } }
})

export default router
