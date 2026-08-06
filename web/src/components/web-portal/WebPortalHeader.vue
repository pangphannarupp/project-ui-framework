<template>
  <header class="header">
    <div class="header-left">
      <button class="mobile-toggle" @click="$emit('toggle-sidebar')">
        <ion-icon :icon="menuOutline" />
      </button>
      <div class="search-box">
        <PPSearch placeholder="Search anything..." v-model="searchQuery" />
      </div>
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
import { IonIcon } from '@ionic/vue';
import { menuOutline } from 'ionicons/icons';
import { PPSearch } from '@phanna/ui-framework';
import WebPortalHeaderThemeToggle from './WebPortalHeaderThemeToggle.vue';
import WebPortalHeaderLanguage from './WebPortalHeaderLanguage.vue';
import WebPortalHeaderNotifications from './WebPortalHeaderNotifications.vue';
import WebPortalHeaderProfile from './WebPortalHeaderProfile.vue';

defineEmits(['toggle-sidebar']);

const searchQuery = ref('');
</script>

<style scoped>
.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px 24px;
  background: white;
  position: sticky;
  top: 0;
  z-index: 5;
  border-bottom: 1px solid #e2e8f0;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
}

.header-left {
  display: flex;
  align-items: center;
  gap: 16px;
  flex: 1;
}

.search-box {
  width: 100%;
  max-width: 300px;
}

.mobile-toggle {
  display: none;
  background: none;
  border: none;
  font-size: 24px;
  color: #334155;
  cursor: pointer;
  padding: 4px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.user-profile {
  display: flex;
  align-items: center;
  gap: 16px;
}

@media (min-width: 769px) {
  .mobile-toggle {
    display: none !important;
  }
  .header {
    padding: 24px 40px;
  }
  .user-profile {
    gap: 24px;
  }
}
</style>
