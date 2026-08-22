import { createRouter, createWebHashHistory } from 'vue-router'
import LoginView from '../views/LoginView.vue'
import DashboardView from '../views/DashboardView.vue'
import MiniAppsView from '../views/MiniAppsView.vue'
import UsersView from '../views/UsersView.vue'
import CustomersView from '../views/CustomersView.vue'
import PaymentSetupView from '../views/PaymentSetupView.vue'
import PushManagementView from '../views/PushManagementView.vue'
import LogViewerView from '../views/LogViewerView.vue'
import SettingsView from '../views/SettingsView.vue'

const routes = [
  {
    path: '/',
    redirect: '/login'
  },
  {
    path: '/login',
    name: 'Login',
    component: LoginView
  },
  {
    path: '/dashboard',
    name: 'Dashboard',
    component: DashboardView
  },
  {
    path: '/mini-apps',
    name: 'MiniApps',
    component: MiniAppsView
  },
  {
    path: '/users',
    name: 'Users',
    component: UsersView
  },
  {
    path: '/customers',
    name: 'Customers',
    component: CustomersView
  },
  {
    path: '/payments',
    name: 'Payments',
    component: PaymentSetupView
  },
  {
    path: '/push',
    name: 'Push',
    component: PushManagementView
  },
  {
    path: '/logs',
    name: 'Logs',
    component: LogViewerView
  },
  {
    path: '/settings',
    name: 'Settings',
    component: SettingsView
  }
]

const router = createRouter({
  history: createWebHashHistory(),
  routes
})

export default router
