import { createRouter, createWebHashHistory } from 'vue-router'
import type { RouteRecordRaw } from 'vue-router'
import GiftHomeView from '../views/GiftHomeView.vue'
import GiftCheckoutView from '../views/GiftCheckoutView.vue'
import GiftPassView from '../views/GiftPassView.vue'
import GiftMyCardsView from '../views/GiftMyCardsView.vue'

const routes: Array<RouteRecordRaw> = [
  { path: '/', name: 'home', component: GiftHomeView },
  { path: '/checkout', name: 'checkout', component: GiftCheckoutView },
  { path: '/confirmation/:id?', name: 'confirmation', component: GiftPassView },
  { path: '/my-tickets', name: 'my-tickets', component: GiftMyCardsView },
  { path: '/:pathMatch(.*)*', redirect: '/' }
]

const router = createRouter({
  history: createWebHashHistory(),
  routes,
  scrollBehavior() { return { top: 0 } }
})

export default router
