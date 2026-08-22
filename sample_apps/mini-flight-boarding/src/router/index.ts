import { createRouter, createWebHistory } from 'vue-router'
import FlightHomeView from '../views/FlightHomeView.vue'
import FlightCheckoutView from '../views/FlightCheckoutView.vue'
import FlightStatusView from '../views/FlightStatusView.vue'
import FlightMyTicketsView from '../views/FlightMyTicketsView.vue'

const routes = [
  { path: '/', name: 'home', component: FlightHomeView },
  { path: '/checkout', name: 'checkout', component: FlightCheckoutView },
  { path: '/status', name: 'status', component: FlightStatusView },
  { path: '/my-tickets', name: 'my-tickets', component: FlightMyTicketsView }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router
