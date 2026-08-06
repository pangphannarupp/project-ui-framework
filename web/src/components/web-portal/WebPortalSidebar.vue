<template>
  <PPSidebarNavigation
    v-model="activeMenu"
    :items="sidebarItems"
    theme="dark"
    variant="indicator"
    class="portal-sidebar"
    :collapsed="false"
    @update:modelValue="handleMenuSelect"
  >
    <template #header>
      <div class="logo">
        <div class="logo-icon">✨</div>
        <span class="logo-text">Aura Portal</span>
      </div>
    </template>
  </PPSidebarNavigation>
</template>

<script setup lang="ts">
import { ref, watch, onMounted } from 'vue';
import { useRouter, useRoute } from 'vue-router';
import { PPSidebarNavigation } from '@phanna/ui-framework';
import { homeOutline, peopleOutline, cardOutline, settingsOutline, cartOutline, megaphoneOutline, barChartOutline, chatbubblesOutline, receiptOutline, schoolOutline, libraryOutline, calendarOutline, checkmarkDoneOutline, documentTextOutline, ribbonOutline } from 'ionicons/icons';

const router = useRouter();
const route = useRoute();
const activeMenu = ref('dashboard');

const sidebarItems = [
  {
    groupLabel: 'Main',
    items: [
      { id: 'dashboard', label: 'Dashboard', icon: homeOutline, path: '/web-portal' },
      { 
        id: 'orders', 
        label: 'Orders', 
        icon: receiptOutline,
        children: [
          { id: 'orders-list', label: 'All Orders', path: '/web-portal/orders' }
        ]
      },
      { 
        id: 'catalog', 
        label: 'Catalog', 
        icon: cartOutline,
        children: [
          { id: 'catalog-categories', label: 'Categories', path: '/web-portal/categories' },
          { id: 'catalog-products', label: 'Products', path: '/web-portal/products' }
        ]
      },
      { 
        id: 'marketing', 
        label: 'Marketing', 
        icon: megaphoneOutline,
        children: [
          { id: 'marketing-discounts', label: 'Discounts', path: '/web-portal/marketing/discounts' },
          { id: 'marketing-banners', label: 'Banners', path: '/web-portal/marketing/banners' }
        ]
      },
      { 
        id: 'analytics', 
        label: 'Analytics', 
        icon: barChartOutline,
        children: [
          { id: 'analytics-sales', label: 'Sales Reports', path: '/web-portal/analytics/sales' },
          { id: 'analytics-inventory', label: 'Inventory Reports', path: '/web-portal/analytics/inventory' }
        ]
      },
      { 
        id: 'support', 
        label: 'Support', 
        icon: chatbubblesOutline,
        children: [
          { id: 'support-tickets', label: 'Tickets', path: '/web-portal/support/tickets' }
        ]
      },
      { 
        id: 'users', 
        label: 'Users & Roles', 
        icon: peopleOutline,
        children: [
          { id: 'users-list', label: 'User List', path: '/web-portal/users' },
          { id: 'users-roles', label: 'Roles', path: '/web-portal/roles' }
        ]
      },
      { id: 'transactions', label: 'Transactions', icon: cardOutline, path: '/web-portal/transactions' },
      { 
        id: 'settings', 
        label: 'Settings', 
        icon: settingsOutline,
        children: [
          { id: 'settings-global', label: 'Global Settings', path: '/web-portal/settings/global' },
          { id: 'settings-notifications', label: 'Notifications', path: '/web-portal/settings/notifications' }
        ]
      }
    ]
  },
  {
    groupLabel: 'School Management',
    items: [
      { id: 'school-dashboard', label: 'Overview', icon: barChartOutline, path: '/web-portal/school/dashboard' },
      { id: 'school-students', label: 'Students', icon: peopleOutline, path: '/web-portal/school/students' },
      { id: 'school-teachers', label: 'Teachers', icon: schoolOutline, path: '/web-portal/school/teachers' },
      { id: 'school-classes', label: 'Classes', icon: libraryOutline, path: '/web-portal/school/classes' },
      { id: 'school-attendance', label: 'Attendance', icon: checkmarkDoneOutline, path: '/web-portal/school/attendance' },
      { id: 'school-gradebook', label: 'Gradebook', icon: ribbonOutline, path: '/web-portal/school/gradebook' },
      { id: 'school-transcripts', label: 'Transcripts', icon: documentTextOutline, path: '/web-portal/school/transcripts' },
      { id: 'school-schedule', label: 'Schedule', icon: calendarOutline, path: '/web-portal/school/schedule' },
      { id: 'school-announcements', label: 'Announcements', icon: megaphoneOutline, path: '/web-portal/school/announcements' }
    ]
  }
];

onMounted(() => {
  // Sync active menu with current route
  const currentPath = route.path;
  for (const group of sidebarItems) {
    for (const item of group.items) {
      if (item.path === currentPath) {
        activeMenu.value = item.id;
        return;
      }
      if (item.children) {
        const child = item.children.find((c: any) => c.path === currentPath);
        if (child) {
          activeMenu.value = child.id;
          return;
        }
      }
    }
  }
});

const emit = defineEmits(['menu-selected']);

const handleMenuSelect = (id: string) => {
  for (const group of sidebarItems) {
    for (const item of group.items) {
      if (item.id === id && (item as any).path) {
        router.push((item as any).path);
        emit('menu-selected', id);
        return;
      }
      if (item.children) {
        const child = item.children.find(c => c.id === id);
        if (child && (child as any).path) {
          router.push((child as any).path);
          emit('menu-selected', id);
          return;
        }
      }
    }
  }
};
</script>

<style scoped>
.portal-sidebar {
  border-right: 1px solid rgba(255, 255, 255, 0.05);
  box-shadow: 10px 0 30px rgba(0, 0, 0, 0.2);
  z-index: 10;
}

.logo {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 16px;
}

.logo-icon {
  font-size: 28px;
}

.logo-text {
  font-size: 24px;
  font-weight: 700;
  letter-spacing: -0.5px;
  color: #fff;
}
</style>
