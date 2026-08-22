import { createRouter, createWebHistory } from 'vue-router'
import ScooterHomeView from '../views/ScooterHomeView.vue'
import ScooterCheckoutView from '../views/ScooterCheckoutView.vue'
import ScooterStatusView from '../views/ScooterStatusView.vue'
import ScooterMyTicketsView from '../views/ScooterMyTicketsView.vue'

const routes = [
  { path: '/', name: 'home', component: ScooterHomeView },
  { path: '/checkout', name: 'checkout', component: ScooterCheckoutView },
  { path: '/status', name: 'status', component: ScooterStatusView },
  { path: '/my-tickets', name: 'my-tickets', component: ScooterMyTicketsView }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router
