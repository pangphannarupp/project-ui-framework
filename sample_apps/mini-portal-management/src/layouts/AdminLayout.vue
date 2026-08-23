<script setup lang="ts">
import { ref, computed } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import {
  gridOutline,
  appsOutline,
  folderOutline,
  pricetagOutline,
  peopleOutline,
  personCircleOutline,
  cardOutline,
  notificationsOutline,
  terminalOutline,
  settingsOutline
} from 'ionicons/icons'

const router = useRouter()
const route = useRoute()

const isSidebarCollapsed = ref(false)
const searchQuery = ref('')
const showNotifications = ref(false)

const sidebarGroups = [
  {
    groupLabel: 'PORTAL MANAGEMENT',
    items: [
      { id: '/dashboard', label: 'Dashboard', icon: gridOutline },
      { id: '/mini-apps', label: 'Mini Apps', icon: appsOutline },
      { id: '/categories', label: 'App Categories', icon: folderOutline },
      { id: '/tags', label: 'App Tags', icon: pricetagOutline },
      { id: '/users', label: 'Portal Users', icon: peopleOutline },
      { id: '/customers', label: 'Customers', icon: personCircleOutline },
      { id: '/payments', label: 'Payment Setup', icon: cardOutline },
      { id: '/push', label: 'Push Alerts', icon: notificationsOutline },
      { id: '/logs', label: 'Log Viewer', icon: terminalOutline },
      { id: '/settings', label: 'Settings', icon: settingsOutline }
    ]
  }
]

const currentTitle = computed(() => {
  for (const group of sidebarGroups) {
    const found = group.items.find(i => i.id === route.path)
    if (found) return found.label
  }
  return 'Mini Portal Management'
})

const handleNavSelect = (path: string) => {
  if (path && route.path !== path) {
    router.push(path)
  }
}

const toggleSidebar = () => {
  isSidebarCollapsed.value = !isSidebarCollapsed.value
}

const handleLogout = () => {
  router.push('/login')
}
</script>

<template>
  <div class="admin-layout">
    <!-- UI Framework Sidebar Navigation -->
    <PPSidebarNavigation
      :model-value="route.path"
      :items="sidebarGroups"
      theme="dark"
      variant="indicator"
      :collapsed="isSidebarCollapsed"
      width="260px"
      collapsed-width="80px"
      @update:model-value="handleNavSelect"
    >
      <template #header>
        <div class="sidebar-header-content">
          <div class="brand">
            <div class="brand-logo">
              <svg viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="#60a5fa" stroke-width="2.5"><polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"></polygon></svg>
            </div>
            <div class="brand-text" v-if="!isSidebarCollapsed">
              <h3>Mini Portal</h3>
              <span>Management Console</span>
            </div>
          </div>
        </div>
      </template>

      <template #footer>
        <div class="sidebar-footer-content" v-if="!isSidebarCollapsed">
          <div class="user-chip">
            <PPAvatar src="https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=80&h=80&fit=crop" name="Phanna Pang" size="sm" />
            <div class="user-info">
              <strong>Phanna Pang</strong>
              <small>Super Admin</small>
            </div>
            <button @click="handleLogout" class="logout-btn" title="Sign out">
              <svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"></path><polyline points="16 17 21 12 16 7"></polyline><line x1="21" y1="12" x2="9" y2="12"></line></svg>
            </button>
          </div>
        </div>
      </template>
    </PPSidebarNavigation>

    <!-- Main Content Area -->
    <div class="main-wrapper">
      <!-- Top Navbar -->
      <header class="top-nav glass-panel">
        <div class="top-nav-left">
          <button @click="toggleSidebar" class="toggle-btn" title="Toggle Navigation">
            <svg viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="currentColor" stroke-width="2"><line x1="3" y1="12" x2="21" y2="12"></line><line x1="3" y1="6" x2="21" y2="6"></line><line x1="3" y1="18" x2="21" y2="18"></line></svg>
          </button>
          <div class="page-title">
            <h2>{{ currentTitle }}</h2>
            <PPChip label="Production Cluster" color="success" variant="soft" size="sm" />
          </div>
        </div>

        <div class="top-nav-right">
          <div class="search-box">
            <PPInput
              v-model="searchQuery"
              placeholder="Search apps, logs, users..."
            />
          </div>

          <div class="header-actions">
            <button class="icon-btn" @click="showNotifications = !showNotifications" title="System Notifications">
              <svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2"><path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"></path><path d="M13.73 21a2 2 0 0 1-3.46 0"></path></svg>
              <span class="dot-indicator"></span>
            </button>
            <a href="https://github.com/pangphannarupp/project-ui-framework" target="_blank" class="icon-btn" title="GitHub Repository">
              <svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"></polygon></svg>
            </a>
          </div>
        </div>
      </header>

      <!-- Page Content -->
      <main class="page-content">
        <slot />
      </main>
    </div>
  </div>
</template>

<style scoped>
.admin-layout {
  display: flex;
  min-height: 100vh;
  background: #0b1120;
}

:deep(.pp-sidebar) {
  background: #111827 !important;
  border-right: 1px solid #1f2937 !important;
  position: sticky !important;
  top: 0 !important;
  height: 100vh !important;
  z-index: 50 !important;
}

.sidebar-header-content {
  padding: 20px 16px;
  border-bottom: 1px solid #1f2937;
}

.brand {
  display: flex;
  align-items: center;
  gap: 12px;
}

.brand-logo {
  font-size: 24px;
  width: 44px;
  height: 44px;
  background: linear-gradient(135deg, #3b82f6, #6366f1);
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 0 4px 15px rgba(59, 130, 246, 0.4);
}

.brand-text h3 {
  font-size: 16px;
  font-weight: 700;
  color: #fff;
  line-height: 1.2;
}

.brand-text span {
  font-size: 11px;
  color: #9ca3af;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

:deep(.pp-sidebar .nav-section-title) {
  font-size: 11px !important;
  font-weight: 700 !important;
  letter-spacing: 0.8px !important;
  color: #64748b !important;
  padding: 12px 14px 6px !important;
}

:deep(.pp-sidebar .nav-item) {
  color: #94a3b8 !important;
  font-size: 14px !important;
  font-weight: 500 !important;
  border-radius: 10px !important;
  margin: 2px 8px !important;
  transition: all 0.2s ease !important;
}

:deep(.pp-sidebar .nav-item:hover) {
  background: rgba(255, 255, 255, 0.05) !important;
  color: #f8fafc !important;
}

:deep(.pp-sidebar .nav-item.active) {
  background: linear-gradient(135deg, rgba(59, 130, 246, 0.2), rgba(99, 102, 241, 0.2)) !important;
  color: #60a5fa !important;
  border: 1px solid rgba(59, 130, 246, 0.3) !important;
}

.sidebar-footer-content {
  padding: 14px 16px;
  border-top: 1px solid #1f2937;
}

.nav-badge {
  margin-left: auto;
  background: #374151;
  color: #e5e7eb;
  padding: 2px 8px;
  border-radius: 12px;
  font-size: 11px;
  font-weight: 600;
}

.nav-link.active .nav-badge {
  background: #2563eb;
  color: #fff;
}

.sidebar-footer {
  padding: 16px;
  border-top: 1px solid #1f2937;
}

.user-chip {
  display: flex;
  align-items: center;
  gap: 10px;
  background: #1f2937;
  padding: 8px 12px;
  border-radius: 12px;
}

.avatar-img {
  width: 36px;
  height: 36px;
  border-radius: 50%;
  object-fit: cover;
  border: 2px solid #3b82f6;
}

.user-info {
  display: flex;
  flex-direction: column;
  flex: 1;
}

.user-info strong {
  font-size: 13px;
  color: #fff;
}

.user-info small {
  font-size: 11px;
  color: #9ca3af;
}

.logout-btn {
  background: transparent;
  border: none;
  font-size: 16px;
  cursor: pointer;
  padding: 4px;
  border-radius: 6px;
  transition: background 0.2s;
}

.logout-btn:hover {
  background: rgba(239, 68, 68, 0.2);
}

/* Main Wrapper */
.main-wrapper {
  flex: 1;
  display: flex;
  flex-direction: column;
  overflow-x: hidden;
}

/* Top Nav */
.top-nav {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 16px 28px;
  margin: 16px 24px 0 24px;
  border-radius: 14px;
  background: rgba(17, 24, 39, 0.85);
  border: 1px solid #1f2937;
}

.top-nav-left {
  display: flex;
  align-items: center;
  gap: 16px;
}

.toggle-btn {
  background: #1f2937;
  border: 1px solid #374151;
  color: #fff;
  width: 38px;
  height: 38px;
  border-radius: 10px;
  font-size: 18px;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: background 0.2s;
}

.toggle-btn:hover {
  background: #374151;
}

.page-title h2 {
  font-size: 18px;
  font-weight: 700;
  color: #fff;
}

.env-pill {
  font-size: 11px;
  background: rgba(16, 185, 129, 0.15);
  color: #10b981;
  border: 1px solid rgba(16, 185, 129, 0.3);
  padding: 2px 8px;
  border-radius: 20px;
  font-weight: 600;
}

.top-nav-right {
  display: flex;
  align-items: center;
  gap: 16px;
}

.search-box {
  display: flex;
  align-items: center;
  gap: 8px;
  background: #111827;
  border: 1px solid #374151;
  padding: 8px 14px;
  border-radius: 10px;
  width: 260px;
}

.search-box input {
  background: transparent;
  border: none;
  color: #fff;
  font-size: 13px;
  outline: none;
  width: 100%;
}

.header-actions {
  display: flex;
  align-items: center;
  gap: 8px;
}

.icon-btn {
  background: #1f2937;
  border: 1px solid #374151;
  color: #fff;
  width: 38px;
  height: 38px;
  border-radius: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  position: relative;
  text-decoration: none;
}

.dot-indicator {
  position: absolute;
  top: 8px;
  right: 8px;
  width: 8px;
  height: 8px;
  background: #ef4444;
  border-radius: 50%;
}

/* Page Content */
.page-content {
  padding: 24px;
  flex: 1;
}
</style>
