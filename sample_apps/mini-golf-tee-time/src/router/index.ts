import { createRouter, createWebHistory } from 'vue-router'
import GolfHomeView from '../views/GolfHomeView.vue'
import GolfCheckoutView from '../views/GolfCheckoutView.vue'
import GolfStatusView from '../views/GolfStatusView.vue'
import GolfMyTicketsView from '../views/GolfMyTicketsView.vue'

const routes = [
  { path: '/', name: 'home', component: GolfHomeView },
  { path: '/checkout', name: 'checkout', component: GolfCheckoutView },
  { path: '/status', name: 'status', component: GolfStatusView },
  { path: '/my-tickets', name: 'my-tickets', component: GolfMyTicketsView }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router
