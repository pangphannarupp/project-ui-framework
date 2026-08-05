<template>
  <header class="header">
    <div style="width: 300px">
      <PPSearch placeholder="Search anything..." v-model="searchQuery" />
    </div>
    <div class="user-profile">
      <WebPortalHeaderThemeToggle />
      <WebPortalHeaderLanguage />
      <WebPortalHeaderNotifications />
      <WebPortalHeaderProfile />
    </div>
  </header>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { PPSearch } from '@phanna/ui-framework';
import WebPortalHeaderThemeToggle from './WebPortalHeaderThemeToggle.vue';
import WebPortalHeaderLanguage from './WebPortalHeaderLanguage.vue';
import WebPortalHeaderNotifications from './WebPortalHeaderNotifications.vue';
import WebPortalHeaderProfile from './WebPortalHeaderProfile.vue';

const searchQuery = ref('');
</script>

<style scoped>
.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 24px 40px;
  background: white;
  position: sticky;
  top: 0;
  z-index: 5;
  border-bottom: 1px solid #e2e8f0;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
}

.user-profile {
  display: flex;
  align-items: center;
  gap: 24px;
}
</style>
