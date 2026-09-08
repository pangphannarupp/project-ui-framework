<template>
  <div class="app-layout">
    <!-- Top Header Navigation Bar -->
    <header class="app-header glass-panel">
      <div class="header-container">
        <div class="brand-group">
          <div class="brand-logo">
            <svg viewBox="0 0 24 24" width="22" height="22" fill="none" stroke="currentColor" stroke-width="2.5">
              <polygon points="12 2 2 7 12 12 22 7 12 2"></polygon>
              <polyline points="2 17 12 22 22 17"></polyline>
              <polyline points="2 12 12 17 22 12"></polyline>
            </svg>
          </div>
          <div class="brand-meta">
            <span class="brand-title">Mini Showcase Hub</span>
            <span class="brand-sub">UI Framework Explorer</span>
          </div>
        </div>

        <div class="header-right-actions">
          <PPChip :label="currentNavLabel" size="sm" variant="soft" color="primary" />
        </div>
      </div>
    </header>

    <!-- Main Dynamic Route View -->
    <main class="main-content">
      <div class="content-container">
        <router-view v-slot="{ Component }">
          <transition name="fade" mode="out-in">
            <component :is="Component" />
          </transition>
        </router-view>
      </div>
    </main>

    <!-- Bottom Navigation Bar using PPBottomNav from @phanna/ui-framework -->
    <footer class="bottom-nav-fixed">
      <div class="nav-inner-container">
        <PPBottomNav
          v-model="activeNavValue"
          :items="navItems"
          @change="onNavChange"
        />
      </div>
    </footer>
  </div>
</template>

<script setup lang="ts">
import { computed, onMounted, ref, watch } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { homeOutline, folderOutline, settingsOutline } from 'ionicons/icons'
import { PPBottomNav, PPChip } from '@phanna/ui-framework'
import { useAppState } from './stores/appState'

const router = useRouter()
const route = useRoute()
const { t, initPreferences } = useAppState()

const activeNavValue = ref('home')

const navItems = computed(() => [
  { label: t.value.home, value: 'home', icon: homeOutline },
  { label: t.value.project, value: 'project', icon: folderOutline },
  { label: t.value.setting, value: 'setting', icon: settingsOutline }
])

const currentNavLabel = computed(() => {
  if (route.name === 'home') return t.value.home
  if (route.name === 'project') return t.value.project
  if (route.name === 'setting') return t.value.setting
  return 'Showcase'
})

const onNavChange = (val: string) => {
  router.push(`/${val}`)
}

watch(() => route.name, (name) => {
  if (name && typeof name === 'string') {
    activeNavValue.value = name
  }
}, { immediate: true })

onMounted(() => {
  initPreferences()
})
</script>

<style scoped>
.app-layout {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  background-color: var(--bg-main);
  position: relative;
}

.app-header {
  position: sticky;
  top: 0;
  z-index: 50;
  border-bottom: 1px solid var(--border-color);
  padding: 12px 20px;
}

.header-container {
  max-width: 960px;
  margin: 0 auto;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.brand-group {
  display: flex;
  align-items: center;
  gap: 12px;
}

.brand-logo {
  width: 38px;
  height: 38px;
  border-radius: 10px;
  background: var(--pp-primary);
  color: white;
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 0 4px 12px var(--pp-primary-light);
}

.brand-meta {
  display: flex;
  flex-direction: column;
}

.brand-title {
  font-size: 15px;
  font-weight: 800;
  color: var(--text-main);
  letter-spacing: -0.2px;
}

.brand-sub {
  font-size: 11px;
  color: var(--text-sub);
  font-weight: 500;
}

.main-content {
  flex: 1;
  padding: 20px 16px 100px 16px;
}

.content-container {
  max-width: 960px;
  margin: 0 auto;
}

.bottom-nav-fixed {
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  z-index: 100;
  pointer-events: none;
}

.nav-inner-container {
  /* max-width: 500px; */
  margin: 0 auto;
  pointer-events: auto;
  box-shadow: var(--nav-shadow);
}

/* Page transitions */
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.2s ease, transform 0.2s ease;
}

.fade-enter-from {
  opacity: 0;
  transform: translateY(6px);
}

.fade-leave-to {
  opacity: 0;
  transform: translateY(-6px);
}
</style>
