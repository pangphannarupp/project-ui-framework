import { createRouter, createWebHistory } from 'vue-router'
import ClinicHomeView from '../views/ClinicHomeView.vue'
import ClinicCheckoutView from '../views/ClinicCheckoutView.vue'
import ClinicStatusView from '../views/ClinicStatusView.vue'
import ClinicMyTicketsView from '../views/ClinicMyTicketsView.vue'

const routes = [
  { path: '/', name: 'home', component: ClinicHomeView },
  { path: '/checkout', name: 'checkout', component: ClinicCheckoutView },
  { path: '/status', name: 'status', component: ClinicStatusView },
  { path: '/my-tickets', name: 'my-tickets', component: ClinicMyTicketsView }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router
