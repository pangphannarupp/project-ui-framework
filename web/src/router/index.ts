import { createRouter, createWebHashHistory } from '@ionic/vue-router';
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
  },
  {
    path: '/setting',
    component: () => import('@/views/SettingScreen.vue')
  },
  {
    path: '/web-portal',
    component: () => import('@/views/web-portal/WebPortalRoot.vue'),
    children: [
      {
        path: '',
        component: () => import('@/views/web-portal/WebPortalDashboard.vue')
      },
      {
        path: 'users',
        component: () => import('@/views/web-portal/UserManagement.vue')
      },
      {
        path: 'users/new',
        component: () => import('@/views/web-portal/UserForm.vue')
      },
      {
        path: 'users/edit/:id',
        component: () => import('@/views/web-portal/UserForm.vue')
      },
      {
        path: 'roles',
        component: () => import('@/views/web-portal/RoleManagement.vue')
      },
      {
        path: 'roles/new',
        component: () => import('@/views/web-portal/RoleForm.vue')
      },
      {
        path: 'roles/edit/:id',
        component: () => import('@/views/web-portal/RoleForm.vue')
      },
      {
        path: 'categories',
        component: () => import('@/views/web-portal/CategoryManagement.vue')
      },
      {
        path: 'categories/new',
        component: () => import('@/views/web-portal/CategoryForm.vue')
      },
      {
        path: 'categories/edit/:id',
        component: () => import('@/views/web-portal/CategoryForm.vue')
      },
      {
        path: 'products',
        component: () => import('@/views/web-portal/ProductManagement.vue')
      },
      {
        path: 'products/new',
        component: () => import('@/views/web-portal/ProductForm.vue')
      },
      {
        path: 'products/edit/:id',
        component: () => import('@/views/web-portal/ProductForm.vue')
      },
      {
        path: 'settings/global',
        component: () => import('@/views/web-portal/GlobalSettings.vue')
      },
      {
        path: 'settings/notifications',
        component: () => import('@/views/web-portal/NotificationSettings.vue')
      },
      {
        path: 'orders',
        component: () => import('@/views/web-portal/OrderManagement.vue')
      },
      {
        path: 'orders/:id',
        component: () => import('@/views/web-portal/OrderDetails.vue')
      },
      {
        path: 'marketing/discounts',
        component: () => import('@/views/web-portal/DiscountManagement.vue')
      },
      {
        path: 'marketing/banners',
        component: () => import('@/views/web-portal/BannerManagement.vue')
      },
      {
        path: 'analytics/sales',
        component: () => import('@/views/web-portal/SalesReports.vue')
      },
      {
        path: 'analytics/inventory',
        component: () => import('@/views/web-portal/InventoryReports.vue')
      },
      {
        path: 'support/tickets',
        component: () => import('@/views/web-portal/TicketManagement.vue')
      },
      {
        path: 'school/dashboard',
        component: () => import('@/views/web-portal/school/SchoolDashboard.vue')
      },
      {
        path: 'school/students',
        component: () => import('@/views/web-portal/school/SchoolStudents.vue')
      },
      {
        path: 'school/teachers',
        component: () => import('@/views/web-portal/school/SchoolTeachers.vue')
      },
      {
        path: 'school/classes',
        component: () => import('@/views/web-portal/school/SchoolClasses.vue')
      },
      {
        path: 'school/attendance',
        component: () => import('@/views/web-portal/school/SchoolAttendance.vue')
      },
      {
        path: 'school/gradebook',
        component: () => import('@/views/web-portal/school/SchoolGradebook.vue')
      },
      {
        path: 'school/transcripts',
        component: () => import('@/views/web-portal/school/SchoolTranscripts.vue')
      },
      {
        path: 'school/schedule',
        component: () => import('@/views/web-portal/school/SchoolSchedule.vue')
      },
      {
        path: 'school/announcements',
        component: () => import('@/views/web-portal/school/SchoolAnnouncements.vue')
      }
    ]
  }
]

const router = createRouter({
  history: createWebHashHistory(),
  routes
})

export default router
