<script setup lang="ts">
import { ref, computed } from 'vue'
import { useRouter, useRoute } from 'vue-router'

const router = useRouter()
const route = useRoute()

const isSidebarCollapsed = ref(false)
const searchQuery = ref('')
const showNotifications = ref(false)

const navItems = [
  { name: 'Dashboard', path: '/dashboard', icon: 'grid-outline', badge: '' },
  { name: 'Mini Apps', path: '/mini-apps', icon: 'apps-outline', badge: '30' },
  { name: 'Portal Users', path: '/users', icon: 'people-outline', badge: '' },
  { name: 'Customers', path: '/customers', icon: 'person-circle-outline', badge: '' },
  { name: 'Payment Setup', path: '/payments', icon: 'card-outline', badge: 'Active' },
  { name: 'Push Alerts', path: '/push', icon: 'notifications-outline', badge: 'New' },
  { name: 'Log Viewer', path: '/logs', icon: 'terminal-outline', badge: 'Live' },
  { name: 'Settings', path: '/settings', icon: 'settings-outline', badge: '' },
]

const currentTitle = computed(() => {
  const current = navItems.find(item => item.path === route.path)
  return current ? current.name : 'Mini Portal Management'
})

const toggleSidebar = () => {
  isSidebarCollapsed.value = !isSidebarCollapsed.value
}

const handleLogout = () => {
  router.push('/login')
}
</script>

<template>
  <div class="admin-layout">
    <!-- Sidebar -->
    <aside class="sidebar" :class="{ 'collapsed': isSidebarCollapsed }">
      <div class="sidebar-header">
        <div class="brand">
          <div class="brand-logo">⚡</div>
          <div class="brand-text" v-if="!isSidebarCollapsed">
            <h3>Mini Portal</h3>
            <span>Management Console</span>
          </div>
        </div>
      </div>

      <nav class="sidebar-nav">
        <RouterLink
          v-for="item in navItems"
          :key="item.path"
          :to="item.path"
          class="nav-link"
          :class="{ 'active': route.path === item.path }"
        >
          <span class="nav-icon">
            <span v-if="item.name === 'Dashboard'">📊</span>
            <span v-else-if="item.name === 'Mini Apps'">📱</span>
            <span v-else-if="item.name === 'Portal Users'">👥</span>
            <span v-else-if="item.name === 'Customers'">👤</span>
            <span v-else-if="item.name === 'Payment Setup'">💳</span>
            <span v-else-if="item.name === 'Push Alerts'">🔔</span>
            <span v-else-if="item.name === 'Log Viewer'">💻</span>
            <span v-else>⚙️</span>
          </span>
          <span class="nav-label" v-if="!isSidebarCollapsed">{{ item.name }}</span>
          <span class="nav-badge" v-if="!isSidebarCollapsed && item.badge">{{ item.badge }}</span>
        </RouterLink>
      </nav>

      <div class="sidebar-footer" v-if="!isSidebarCollapsed">
        <div class="user-chip">
          <img src="https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=80&h=80&fit=crop" class="avatar-img" />
          <div class="user-info">
            <strong>Phanna Pang</strong>
            <small>Super Admin</small>
          </div>
          <button @click="handleLogout" class="logout-btn" title="Sign out">
            🚪
          </button>
        </div>
      </div>
    </aside>

    <!-- Main Content Area -->
    <div class="main-wrapper">
      <!-- Top Navbar -->
      <header class="top-nav glass-panel">
        <div class="top-nav-left">
          <button @click="toggleSidebar" class="toggle-btn">
            ☰
          </button>
          <div class="page-title">
            <h2>{{ currentTitle }}</h2>
            <span class="env-pill">Production Cluster</span>
          </div>
        </div>

        <div class="top-nav-right">
          <div class="search-box">
            <span class="search-icon">🔍</span>
            <input
              type="text"
              v-model="searchQuery"
              placeholder="Search apps, logs, users..."
            />
          </div>

          <div class="header-actions">
            <button class="icon-btn" @click="showNotifications = !showNotifications" title="System Notifications">
              🔔
              <span class="dot-indicator"></span>
            </button>
            <a href="https://github.com/pangphannarupp/project-ui-framework" target="_blank" class="icon-btn" title="GitHub Repository">
              ⭐
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

/* Sidebar */
.sidebar {
  width: 260px;
  background: #111827;
  border-right: 1px solid #1f2937;
  display: flex;
  flex-direction: column;
  transition: width 0.25s ease;
  position: sticky;
  top: 0;
  height: 100vh;
  z-index: 50;
}

.sidebar.collapsed {
  width: 80px;
}

.sidebar-header {
  padding: 24px 20px;
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

.sidebar-nav {
  padding: 16px 12px;
  display: flex;
  flex-direction: column;
  gap: 6px;
  flex: 1;
  overflow-y: auto;
}

.nav-link {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 12px 14px;
  border-radius: 10px;
  color: #94a3b8;
  text-decoration: none;
  font-size: 14px;
  font-weight: 500;
  transition: all 0.2s ease;
}

.nav-link:hover {
  background: rgba(255, 255, 255, 0.05);
  color: #f8fafc;
}

.nav-link.active {
  background: linear-gradient(135deg, rgba(59, 130, 246, 0.2), rgba(99, 102, 241, 0.2));
  color: #60a5fa;
  border: 1px solid rgba(59, 130, 246, 0.3);
}

.nav-icon {
  font-size: 18px;
  display: flex;
  align-items: center;
  justify-content: center;
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
