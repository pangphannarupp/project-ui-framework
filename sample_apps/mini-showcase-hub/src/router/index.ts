import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import ProjectView from '../views/ProjectView.vue'
import SettingView from '../views/SettingView.vue'

const router = createRouter({
  history: createWebHistory(),
  routes: [
    {
      path: '/',
      redirect: '/home'
    },
    {
      path: '/home',
      name: 'home',
      component: HomeView
    },
    {
      path: '/project',
      name: 'project',
      component: ProjectView
    },
    {
      path: '/setting',
      name: 'setting',
      component: SettingView
    }
  ]
})

export default router
