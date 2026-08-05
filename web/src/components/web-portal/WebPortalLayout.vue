<template>
  <div class="web-portal-container">
    <WebPortalSidebar />

    <main class="main-content">
      <WebPortalHeader />
      
      <!-- Page Content gets injected here -->
      <div class="content-wrapper">
        <slot />
      </div>
    </main>
  </div>
</template>

<script setup lang="ts">
import WebPortalSidebar from './WebPortalSidebar.vue';
import WebPortalHeader from './WebPortalHeader.vue';
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
}

/* Sidebar still needs to look dark, so we can ensure the layout component handles that or Sidebar handles itself. 
   Sidebar currently has its own background color. */

.main-content {
  flex: 1;
  display: flex;
  flex-direction: column;
  position: relative;
}

.content-wrapper {
  flex: 1;
  position: relative;
  overflow-y: auto;
  overflow-x: hidden;
}
</style>
