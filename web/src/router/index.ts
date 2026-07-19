import { createRouter, createWebHistory } from '@ionic/vue-router';
import { RouteRecordRaw } from 'vue-router';
import TabsPage from '../views/TabsPage.vue'

const routes: Array<RouteRecordRaw> = [
  {
    path: '/',
    component: () => import('@/views/UsageGuide.vue')
  },
  {
    path: '/login',
    component: () => import('@/views/LoginScreen.vue')
  },
  {
    path: '/home',
    component: () => import('@/views/HomeScreen.vue')
  },
  {
    path: '/activate',
    component: () => import('@/views/ActivateScreen.vue')
  },
  {
    path: '/verify-otp',
    component: () => import('@/views/VerifyOtpScreen.vue')
  },
  {
    path: '/pin',
    component: () => import('@/views/PinScreen.vue')
  },
  {
    path: '/activation-success',
    component: () => import('@/views/ActivationSuccessScreen.vue')
  },
  {
    path: '/change-phone',
    component: () => import('@/views/ChangePhoneScreen.vue')
  },
  {
    path: '/document-verification',
    component: () => import('@/views/DocumentVerificationScreen.vue')
  },
  {
    path: '/confirm-info',
    component: () => import('@/views/ConfirmInfoScreen.vue')
  },
  {
    path: '/upgrade-info',
    component: () => import('@/views/UpgradeInfoScreen.vue')
  },
  {
    path: '/branch-map',
    component: () => import('@/views/BranchMapScreen.vue')
  },
  {
    path: '/user-management',
    component: () => import('@/views/UserManagementScreen.vue')
  },
  {
    path: '/usage-guide',
    component: () => import('@/views/UsageGuide.vue')
  },
  {
    path: '/edit-account-nickname',
    component: () => import('@/views/EditAccountNicknameScreen.vue')
  },
  {
    path: '/notification',
    component: () => import('@/views/NotificationScreen.vue')
  },
  {
    path: '/edit-account-nickname-success',
    component: () => import('@/views/EditAccountNicknameSuccessScreen.vue')
  }
]

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes
})

export default router
