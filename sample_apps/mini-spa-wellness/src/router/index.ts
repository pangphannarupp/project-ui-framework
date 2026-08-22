import { createRouter, createWebHistory } from 'vue-router'
import SpaHomeView from '../views/SpaHomeView.vue'
import SpaCheckoutView from '../views/SpaCheckoutView.vue'
import SpaStatusView from '../views/SpaStatusView.vue'
import SpaMyTicketsView from '../views/SpaMyTicketsView.vue'

const routes = [
  { path: '/', name: 'home', component: SpaHomeView },
  { path: '/checkout', name: 'checkout', component: SpaCheckoutView },
  { path: '/status', name: 'status', component: SpaStatusView },
  { path: '/my-tickets', name: 'my-tickets', component: SpaMyTicketsView }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router
