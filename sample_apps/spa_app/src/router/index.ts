import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: HomeView
    },
    {
      path: '/search',
      name: 'search',
      component: () => import('../views/SearchView.vue')
    },
    {
      path: '/service/:id',
      name: 'service-detail',
      component: () => import('../views/ServiceDetailView.vue')
    },
    {
      path: '/service/:id/datetime',
      name: 'datetime-selection',
      component: () => import('../views/DateTimeSelectionView.vue')
    },
    {
      path: '/checkout',
      name: 'checkout',
      component: () => import('../views/ConfirmPayView.vue')
    }
  ],
  scrollBehavior(_to, _from, savedPosition) {
    if (savedPosition) {
      return savedPosition
    } else {
      return { top: 0 }
    }
  }
})

export default router
