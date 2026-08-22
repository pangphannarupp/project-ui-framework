<template>
  <div class="smart-mini-app">
    <!-- Header -->
    <!-- <PPAppBar title="Smart Service" style="--pp-app-bar-bg: var(--smart-green); --pp-app-bar-color: white;">
      <template #left>
        <button class="icon-btn" @click="() => handleExit()" aria-label="Exit App">
          <svg viewBox="0 0 24 24" width="24" height="24" stroke="currentColor" stroke-width="2" fill="none"><line x1="19" y1="12" x2="5" y2="12"></line><polyline points="12 19 5 12 12 5"></polyline></svg>
        </button>
      </template>
      <template #right>
        <button class="icon-btn" @click="() => handleExit()" aria-label="Close">
          <svg viewBox="0 0 24 24" width="24" height="24" stroke="currentColor" stroke-width="2" fill="none"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg>
        </button>
      </template>
    </PPAppBar> -->

    <!-- Top Greeting Area -->
    <div class="greeting-area" v-if="activeTab !== 'History'">
      <div class="mascot-container">
        <!-- Placeholder for Bunny -->
        <div class="mascot-placeholder">🐰</div>
        <div class="chat-bubbles">
          <!-- <div class="bubble small">Hello!</div> -->
          <div class="bubble large">{{ userName }}</div>
          <div class="bubble small" v-if="userPhone">{{ userPhone }}</div>
        </div>
      </div>
    </div>

    <!-- Content Area (Tabs) -->
    <div class="content-area" :class="{ 'no-overlap': activeTab === 'History' }">
      <SmartMobileTab v-if="activeTab === 'Mobile'" />
      <SmartWifiTab v-else-if="activeTab === 'Wi-Fi'" />
      <SmartHistoryTab v-else />
    </div>

    <!-- Bottom Navigation -->
    <div class="bottom-nav-container">
      <PPBottomNav v-model="activeTab" :items="navItems" variant="pill-slide" style="--pp-primary: var(--smart-green); --pp-primary-light: var(--smart-light-green)" />
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { PPBottomNav } from '@phanna/ui-framework';
import SmartMobileTab from './smart-app/SmartMobileTab.vue';
import SmartWifiTab from './smart-app/SmartWifiTab.vue';
import SmartHistoryTab from './smart-app/SmartHistoryTab.vue';
import { phonePortraitOutline, wifiOutline, timeOutline } from 'ionicons/icons';
import '../lib/mini.app.lib.js'; // Ensure SDK is loaded

const MiniApp = (window as any).MiniApp;

const activeTab = ref('Mobile');
const userName = ref('GUEST USER'); // Default value
const userPhone = ref(''); // Default value

// const handleExit = (showConfirm = true) => {
//   MiniApp.exit(typeof showConfirm === 'boolean' ? showConfirm : true);
// };

const navItems = [
  { label: 'Mobile', value: 'Mobile', icon: phonePortraitOutline },
  { label: 'Wi-Fi', value: 'Wi-Fi', icon: wifiOutline },
  { label: 'History', value: 'History', icon: timeOutline }
];

onMounted(async () => {
  try {
    const profile = await MiniApp.getUserProfile({ appKey: "MY_MINIAPP_CLIENT_KEY" });
    if (profile && profile.name) {
      userName.value = profile.name.toUpperCase();
    }
    if (profile && profile.phoneNumber) {
      userPhone.value = profile.phoneNumber;
    }
  } catch (err: any) {
    console.error("Security Error:", err.errorCode, err.errorMessage);
  }
});
</script>

<style scoped>
.smart-mini-app {
  display: flex;
  flex-direction: column;
  height: 100vh;
  background-color: var(--bg-color);
  overflow: hidden;
  position: relative;
}

.app-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1rem;
  background-color: var(--smart-green);
  color: white;
}

.header-left, .header-right {
  display: flex;
  align-items: center;
  gap: 1rem;
}

.header-title {
  font-size: 1.25rem;
  font-weight: bold;
}

.icon-btn {
  background: none;
  border: none;
  color: white;
  cursor: pointer;
  padding: 4px;
}

.greeting-area {
  background: linear-gradient(180deg, var(--smart-green) 0%, rgba(0, 166, 81, 0.2) 100%);
  padding: 1rem 2rem;
  padding-bottom: 3rem; /* space for the card to overlap */
}

.mascot-container {
  display: flex;
  align-items: flex-end;
  gap: 1rem;
}

.mascot-placeholder {
  font-size: 4rem;
}

.chat-bubbles {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
  margin-bottom: 1rem;
}

.bubble {
  background-color: rgba(255, 255, 255, 0.9);
  padding: 0.5rem 1rem;
  border-radius: 20px;
  font-weight: 500;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
  color: var(--text-main);
}

.bubble.small {
  color: #d97706; /* orange text for hello */
  align-self: flex-start;
  border-bottom-left-radius: 4px;
}

.bubble.large {
  color: #c2410c; /* darker orange */
  text-transform: uppercase;
  font-weight: bold;
  border-bottom-left-radius: 4px;
}

.content-area {
  flex: 1;
  overflow-y: auto;
  padding: 0 1rem;
  margin-top: -2rem; /* Overlap greeting area */
  padding-bottom: 100px; /* space for bottom nav */
}

.content-area.no-overlap {
  margin-top: 1rem; /* Adjust margin for History tab which has no greeting area */
}

.bottom-nav-container {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  padding-top: 1rem;
  background: linear-gradient(0deg, rgba(255,255,255,1) 0%, rgba(255,255,255,0) 100%);
  z-index: 10;
}

.bottom-nav {
  display: flex;
  justify-content: space-around;
  background-color: white;
  border-radius: 30px;
  padding: 0.5rem;
  box-shadow: 0 4px 12px rgba(0,0,0,0.1);
}

.nav-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 0.5rem 1rem;
  border-radius: 20px;
  cursor: pointer;
  color: var(--text-secondary);
  transition: all 0.2s ease;
}

.nav-item.active {
  color: var(--smart-green);
}

.nav-icon {
  font-size: 1.5rem;
  margin-bottom: 2px;
}

.nav-label {
  font-size: 0.75rem;
  font-weight: 500;
}
</style>
