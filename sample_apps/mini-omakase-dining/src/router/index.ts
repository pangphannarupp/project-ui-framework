import { createRouter, createWebHistory } from 'vue-router'
import OmakaseHomeView from '../views/OmakaseHomeView.vue'
import OmakaseCheckoutView from '../views/OmakaseCheckoutView.vue'
import OmakaseStatusView from '../views/OmakaseStatusView.vue'
import OmakaseMyTicketsView from '../views/OmakaseMyTicketsView.vue'

const routes = [
  { path: '/', name: 'home', component: OmakaseHomeView },
  { path: '/checkout', name: 'checkout', component: OmakaseCheckoutView },
  { path: '/status', name: 'status', component: OmakaseStatusView },
  { path: '/my-tickets', name: 'my-tickets', component: OmakaseMyTicketsView }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router
