import { createRouter, createWebHistory } from 'vue-router'
import PhotoBoothHomeView from '../views/PhotoBoothHomeView.vue'
import PhotoBoothCheckoutView from '../views/PhotoBoothCheckoutView.vue'
import PhotoBoothStatusView from '../views/PhotoBoothStatusView.vue'
import PhotoBoothMyTicketsView from '../views/PhotoBoothMyTicketsView.vue'

const routes = [
  { path: '/', name: 'home', component: PhotoBoothHomeView },
  { path: '/checkout', name: 'checkout', component: PhotoBoothCheckoutView },
  { path: '/status', name: 'status', component: PhotoBoothStatusView },
  { path: '/my-tickets', name: 'my-tickets', component: PhotoBoothMyTicketsView }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router
