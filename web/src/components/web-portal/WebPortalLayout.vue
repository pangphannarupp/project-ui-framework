<template>
  <div class="web-portal-container" :class="{ 'sidebar-open': isMobileSidebarOpen }">
    <!-- Overlay for mobile -->
    <div v-if="isMobileSidebarOpen" class="mobile-overlay" @click="isMobileSidebarOpen = false"></div>
    
    <div class="sidebar-wrapper" :class="{ 'is-open': isMobileSidebarOpen }">
      <WebPortalSidebar @menu-selected="isMobileSidebarOpen = false" />
    </div>

    <main class="main-content">
      <WebPortalHeader @toggle-sidebar="isMobileSidebarOpen = !isMobileSidebarOpen" />
      
      <!-- Page Content gets injected here -->
      <div class="content-wrapper">
        <slot />
      </div>
    </main>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import WebPortalSidebar from './WebPortalSidebar.vue';
import WebPortalHeader from './WebPortalHeader.vue';

const isMobileSidebarOpen = ref(false);
</script>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap');

.web-portal-container {
  display: flex;
  height: 100vh;
  width: 100vw;
  font-family: 'Outfit', sans-serif;
  background: #f4f6f8; /* Light gray background for content */
  color: #334155; /* Dark text */
  overflow: hidden;
  position: relative;
}

.sidebar-wrapper {
  position: fixed;
  top: 0;
  left: -280px; /* Hide off-screen initially on mobile */
  height: 100%;
  width: 260px;
  z-index: 20;
  transition: transform 0.3s ease;
}

.sidebar-wrapper.is-open {
  transform: translateX(280px);
}

.mobile-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100vw;
  height: 100vh;
  background: rgba(0, 0, 0, 0.5);
  z-index: 15;
}

.main-content {
  flex: 1;
  display: flex;
  flex-direction: column;
  position: relative;
  width: 100%;
  overflow: hidden;
}

.content-wrapper {
  flex: 1;
  position: relative;
  overflow-y: auto;
  overflow-x: hidden;
}

@media (min-width: 769px) {
  .sidebar-wrapper {
    position: static;
    left: 0;
    transform: none;
  }
}
</style>
