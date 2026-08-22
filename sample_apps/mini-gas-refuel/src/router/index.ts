import { createRouter, createWebHistory } from 'vue-router'
import FuelHomeView from '../views/FuelHomeView.vue'
import FuelCheckoutView from '../views/FuelCheckoutView.vue'
import FuelStatusView from '../views/FuelStatusView.vue'
import FuelMyTicketsView from '../views/FuelMyTicketsView.vue'

const routes = [
  { path: '/', name: 'home', component: FuelHomeView },
  { path: '/checkout', name: 'checkout', component: FuelCheckoutView },
  { path: '/status', name: 'status', component: FuelStatusView },
  { path: '/my-tickets', name: 'my-tickets', component: FuelMyTicketsView }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router
