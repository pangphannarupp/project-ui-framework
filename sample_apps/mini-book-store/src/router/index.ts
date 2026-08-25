import { createRouter, createWebHashHistory } from 'vue-router'
import type { RouteRecordRaw } from 'vue-router'
import BookCatalogView from '../views/BookCatalogView.vue'
import BookDetailView from '../views/BookDetailView.vue'
import BookCheckoutView from '../views/BookCheckoutView.vue'
import BookConfirmationView from '../views/BookConfirmationView.vue'

const routes: Array<RouteRecordRaw> = [
  { path: '/', name: 'catalog', component: BookCatalogView },
  { path: '/book/:id', name: 'detail', component: BookDetailView },
  { path: '/checkout', name: 'checkout', component: BookCheckoutView },
  { path: '/confirmation/:id', name: 'confirmation', component: BookConfirmationView },
  { path: '/:pathMatch(.*)*', redirect: '/' }
]

const router = createRouter({
  history: createWebHashHistory(),
  routes,
  scrollBehavior() { return { top: 0 } }
})

export default router
