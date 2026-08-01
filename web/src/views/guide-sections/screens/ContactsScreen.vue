<template>
  <div class="screen-preview-container">
    <div class="header-actions">
      <PPButton variant="primary" size="small" @click="isDarkMode = !isDarkMode">
        Toggle {{ isDarkMode ? 'Light' : 'Dark' }} Mode
      </PPButton>
    </div>

    <!-- Phone Mockup Container -->
    <div class="phone-mockup" :class="{ 'dark-mode': isDarkMode }">
      <div class="contacts-screen">
        
        <!-- Header -->
        <PPAppBar title="Contacts" class="transparent-appbar">
          <template #right>
            <PPIconButton :icon="ellipsisVerticalOutline" color="transparent" class="header-icon-btn" />
          </template>
        </PPAppBar>

        <!-- Search Bar -->
        <div class="search-wrapper">
          <PPSearch placeholder="Search" class="contacts-search" />
        </div>

        <!-- Scrollable Contacts List -->
        <div class="contacts-scroll-area">
          <div v-for="group in contactGroups" :key="group.letter" class="contact-group">
            <div class="group-letter">{{ group.letter }}</div>
            <div class="group-items">
              <div v-for="contact in group.contacts" :key="contact.name" class="contact-item">
                <PPAvatar :src="contact.avatar" :name="contact.name" size="md" />
                <span class="contact-name">{{ contact.name }}</span>
              </div>
            </div>
          </div>
        </div>

        <!-- Floating Action Button -->
        <PPFab :icon="addOutline" color="primary" class="contacts-fab" />

        <!-- Bottom Navigation -->
        <div class="bottom-nav-wrapper">
          <PPBottomNav :items="bottomNavItems" v-model="activeTab" />
          <div class="home-indicator"></div>
        </div>

      </div>
    </div>
    
    <div class="usage-section">
      <h3>Code Usage</h3>
      <pre class="code-block" v-pre><code>
&lt;template&gt;
  &lt;div class="contacts-screen"&gt;
    &lt;PPAppBar title="Contacts" class="transparent-appbar"&gt;
      &lt;template #right&gt;
        &lt;PPIconButton :icon="ellipsisVerticalOutline" color="transparent" /&gt;
      &lt;/template&gt;
    &lt;/PPAppBar&gt;

    &lt;div class="search-wrapper"&gt;
      &lt;PPSearch placeholder="Search" /&gt;
    &lt;/div&gt;

    &lt;div class="contacts-list"&gt;
      &lt;!-- Contact Items Grouped by Letter --&gt;
      &lt;div class="contact-group"&gt;
        &lt;div class="group-letter"&gt;A&lt;/div&gt;
        &lt;div class="group-items"&gt;
          &lt;div class="contact-item"&gt;
            &lt;PPAvatar src="..." name="Alicia" size="md" /&gt;
            &lt;span class="contact-name"&gt;Alicia&lt;/span&gt;
          &lt;/div&gt;
        &lt;/div&gt;
      &lt;/div&gt;
    &lt;/div&gt;

    &lt;PPFab :icon="addOutline" color="primary" class="contacts-fab" /&gt;

    &lt;PPBottomNav :items="bottomNavItems" v-model="activeTab" /&gt;
  &lt;/div&gt;
&lt;/template&gt;
      </code></pre>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { 
  ellipsisVerticalOutline,
  addOutline,
  homeOutline,
  peopleOutline,
  settingsOutline
} from 'ionicons/icons';
import { PPButton, PPAvatar, PPAppBar, PPIconButton, PPSearch, PPFab, PPBottomNav } from '@phanna/ui-framework';

const isDarkMode = ref(false);
const activeTab = ref('contacts');

const bottomNavItems = [
  { id: 'chats', label: 'Chats', icon: homeOutline },
  { id: 'contacts', label: 'Contacts', icon: peopleOutline },
  { id: 'settings', label: 'Settings', icon: settingsOutline }
];

const contactGroups = [
  {
    letter: 'A',
    contacts: [
      { name: 'Alicia', avatar: 'https://i.pravatar.cc/150?img=1' },
      { name: 'Anthony', avatar: 'https://i.pravatar.cc/150?img=11' }
    ]
  },
  {
    letter: 'B',
    contacts: [
      { name: 'Ben', avatar: 'https://i.pravatar.cc/150?img=13' },
      { name: 'Bryan', avatar: 'https://i.pravatar.cc/150?img=14' },
      { name: 'Brianna', avatar: 'https://i.pravatar.cc/150?img=5' }
    ]
  },
  {
    letter: 'C',
    contacts: [
      { name: 'Cindy', avatar: 'https://i.pravatar.cc/150?img=9' }
    ]
  },
  {
    letter: 'D',
    contacts: [
      { name: 'Daisy', avatar: 'https://i.pravatar.cc/150?img=10' },
      { name: 'Diana', avatar: 'https://i.pravatar.cc/150?img=12' }
    ]
  }
];
</script>

<style scoped>
.screen-preview-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 40px 20px;
  background-color: #f1f5f9;
  border-radius: 24px;
  margin-bottom: 40px;
}

.header-actions {
  margin-bottom: 24px;
  display: flex;
  gap: 12px;
}

/* Phone Mockup Base */
.phone-mockup {
  width: 375px;
  height: 812px;
  background-color: var(--bg-color);
  border-radius: 40px;
  box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
  overflow: hidden;
  position: relative;
  display: flex;
  flex-direction: column;
  border: 12px solid #1e293b;
  transition: all 0.3s ease;

  /* CSS Variables for Light Mode */
  --bg-color: #ffffff;
  --text-main: #111827;
  --text-sub: #6b7280;
  --header-icon: #111827;
  
  --search-bg: #f1f5f9;
  --letter-color: #1d4ed8;
  
  --fab-bg: #dbeafe;
  --fab-icon: #1d4ed8;
  
  --home-indicator: #111827;
}

/* Dark Mode Overrides */
.phone-mockup.dark-mode {
  --bg-color: #0f172a;
  --text-main: #f9fafb;
  --text-sub: #9ca3af;
  --header-icon: #f9fafb;
  
  --search-bg: #1e293b;
  --letter-color: #93c5fd;
  
  --fab-bg: #334155;
  --fab-icon: #f9fafb;
  
  --home-indicator: #f9fafb;
}

.contacts-screen {
  display: flex;
  flex-direction: column;
  height: 100%;
  width: 100%;
  position: relative;
}

/* Header Overrides */
.transparent-appbar {
  --pp-app-bar-bg: transparent;
  --pp-app-bar-color: var(--text-main);
  padding-top: 50px; /* Extra padding for status bar */
  box-shadow: none;
}

/* Align title size to mockup */
:deep(.transparent-appbar h1) {
  font-size: 24px !important;
  font-weight: 600 !important;
  margin-left: 8px;
}

:deep(.header-icon-btn.pp-icon-btn--transparent) {
  color: var(--header-icon) !important;
}

/* Search Area */
.search-wrapper {
  padding: 8px 24px;
}

:deep(.contacts-search.pp-search .pp-search-input-container) {
  background-color: var(--search-bg);
  border: none;
  box-shadow: none;
}

:deep(.contacts-search.pp-search input) {
  color: var(--text-main);
}

/* Contacts List */
.contacts-scroll-area {
  flex: 1;
  overflow-y: auto;
  padding: 16px 24px;
  -ms-overflow-style: none;
  scrollbar-width: none;
  padding-bottom: 80px; /* Space for FAB */
}
.contacts-scroll-area::-webkit-scrollbar {
  display: none;
}

.contact-group {
  display: flex;
  margin-bottom: 24px;
}

.group-letter {
  width: 40px;
  font-size: 16px;
  font-weight: 600;
  color: var(--letter-color);
  padding-top: 8px;
}

.group-items {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.contact-item {
  display: flex;
  align-items: center;
  gap: 16px;
}

.contact-name {
  font-size: 16px;
  color: var(--text-main);
  font-weight: 400;
}

/* FAB Overrides */
.contacts-fab {
  position: absolute;
  bottom: 100px;
  right: 24px;
  border-radius: 16px;
}

:deep(.contacts-fab.pp-fab--primary) {
  background-color: var(--fab-bg);
  color: var(--fab-icon);
  box-shadow: 0 4px 12px rgba(0,0,0,0.1);
}

/* Bottom Nav Wrapper */
.bottom-nav-wrapper {
  background-color: transparent;
  padding-bottom: 24px; /* Space for home indicator */
  position: relative;
}

:deep(.pp-bottom-nav) {
  background-color: transparent;
  border-top: none;
}
:deep(.pp-bottom-nav .pp-bottom-nav-item) {
  color: var(--text-sub);
}
:deep(.pp-bottom-nav .pp-bottom-nav-item.active) {
  color: var(--text-main);
}
:deep(.pp-bottom-nav .pp-bottom-nav-item.active .icon-container) {
  background-color: var(--fab-bg);
}
:deep(.pp-bottom-nav .pp-bottom-nav-item.active .icon-container ion-icon) {
  color: var(--text-main);
}

/* Utilities */
.home-indicator {
  position: absolute;
  bottom: 8px;
  left: 50%;
  transform: translateX(-50%);
  width: 120px;
  height: 4px;
  background-color: var(--home-indicator);
  border-radius: 2px;
  opacity: 0.8;
}

.usage-section {
  width: 100%;
  max-width: 600px;
  margin-top: 32px;
  text-align: left;
}

.code-block {
  background-color: #1e293b;
  color: #f8fafc;
  padding: 16px;
  border-radius: 12px;
  overflow-x: auto;
  font-size: 14px;
  line-height: 1.5;
}
</style>
