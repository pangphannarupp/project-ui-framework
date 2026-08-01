<template>
  <div class="component-section">
    <h2>Chat Application Template</h2>
    <p>A full chat interface utilizing search, avatars, badges, floating action button, and bottom navigation.</p>

    <div style="display: flex; gap: 32px; flex-wrap: wrap; justify-content: center; margin-top: 32px;">
      
      <!-- Light Mode Demo -->
      <div class="phone-mockup light-mode">
        <!-- Status Bar Mock -->
        <div class="status-bar">
          <span class="time">9:30</span>
          <div class="status-icons">
            <svg viewBox="0 0 24 24" width="16" height="16" fill="currentColor"><path d="M12 21L1 3h22L12 21z"/></svg>
            <svg viewBox="0 0 24 24" width="16" height="16" fill="currentColor"><path d="M2 22h20V2L2 22z"/></svg>
            <svg viewBox="0 0 24 24" width="16" height="16" fill="currentColor"><path d="M22 4v16a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h16a2 2 0 0 1 2 2z"/></svg>
          </div>
        </div>

        <div class="chat-header">
          <PPSearch v-model="searchQuery" placeholder="Search" />
        </div>

        <div class="chat-list">
          <PPChatItem 
            v-for="chat in chats" 
            :key="chat.id"
            :name="chat.name"
            :avatar="chat.avatar"
            :time="chat.time"
            :message="chat.message"
            :unread="chat.unread"
          />
        </div>

        <PPFab style="bottom: 88px; right: 16px;" color="primary">
          <template #icon>
            <ion-icon :icon="pencilOutline" />
          </template>
        </PPFab>

        <div class="bottom-nav-container">
          <PPBottomNav 
            v-model="activeTab"
            variant="material"
            :items="navItems"
          />
        </div>
      </div>

      <!-- Dark Mode Demo -->
      <div class="phone-mockup dark-mode">
        <!-- Status Bar Mock -->
        <div class="status-bar">
          <span class="time">9:30</span>
          <div class="status-icons">
            <svg viewBox="0 0 24 24" width="16" height="16" fill="currentColor"><path d="M12 21L1 3h22L12 21z"/></svg>
            <svg viewBox="0 0 24 24" width="16" height="16" fill="currentColor"><path d="M2 22h20V2L2 22z"/></svg>
            <svg viewBox="0 0 24 24" width="16" height="16" fill="currentColor"><path d="M22 4v16a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h16a2 2 0 0 1 2 2z"/></svg>
          </div>
        </div>

        <div class="chat-header">
          <PPSearch v-model="searchQuery" placeholder="Search" />
        </div>

        <div class="chat-list">
          <PPChatItem 
            v-for="chat in chats" 
            :key="chat.id"
            :name="chat.name"
            :avatar="chat.avatar"
            :time="chat.time"
            :message="chat.message"
            :unread="chat.unread"
          />
        </div>

        <PPFab style="bottom: 88px; right: 16px;" color="primary">
          <template #icon>
            <ion-icon :icon="pencilOutline" />
          </template>
        </PPFab>

        <div class="bottom-nav-container">
          <PPBottomNav 
            v-model="activeTab"
            variant="material"
            :items="navItems"
          />
        </div>
      </div>
      
    </div>

    <div class="usage-section">
      <h3>Code Usage</h3>
      <pre class="code-block" v-pre><code>
&lt;template&gt;
  &lt;div class="chat-screen"&gt;
    &lt;!-- Header & Search --&gt;
    &lt;div class="chat-header"&gt;
      &lt;PPSearch v-model="searchQuery" placeholder="Search" /&gt;
    &lt;/div&gt;

    &lt;!-- Chat List --&gt;
    &lt;div class="chat-list"&gt;
      &lt;PPChatItem 
        v-for="chat in chats" 
        :key="chat.id"
        :name="chat.name"
        :avatar="chat.avatar"
        :time="chat.time"
        :message="chat.message"
        :unread="chat.unread"
      /&gt;
    &lt;/div&gt;

    &lt;!-- Floating Action Button --&gt;
    &lt;PPFab style="bottom: 88px; right: 16px;" color="primary"&gt;
      &lt;template #icon&gt;
        &lt;ion-icon :icon="pencilOutline" /&gt;
      &lt;/template&gt;
    &lt;/PPFab&gt;

    &lt;!-- Bottom Navigation --&gt;
    &lt;PPBottomNav 
      v-model="activeTab"
      variant="material"
      :items="navItems"
    /&gt;
  &lt;/div&gt;
&lt;/template&gt;
      </code></pre>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { PPBottomNav, PPSearch, PPChatItem, PPFab } from '@phanna/ui-framework';
import { IonIcon } from '@ionic/vue';
import { pencilOutline, homeOutline, home, peopleOutline, people, settingsOutline, settings } from 'ionicons/icons';

const activeTab = ref('chats');
const searchQuery = ref('');

const navItems = [
  { label: 'Chats', value: 'chats', icon: homeOutline, activeIcon: home },
  { label: 'Contacts', value: 'contacts', icon: peopleOutline, activeIcon: people },
  { label: 'Settings', value: 'settings', icon: settingsOutline, activeIcon: settings }
];

const chats = [
  { id: 1, name: 'Bryan', message: 'What do you think?', time: '4:30 PM', unread: 2, avatar: 'https://i.pravatar.cc/150?u=bryan' },
  { id: 2, name: 'Kari', message: 'Looks great!', time: '4:23 PM', unread: 1, avatar: 'https://i.pravatar.cc/150?u=kari' },
  { id: 3, name: 'Diana', message: 'Lunch on Monday?', time: '4:12 PM', unread: 0, avatar: 'https://i.pravatar.cc/150?u=diana' },
  { id: 4, name: 'Ben', message: 'You sent a photo.', time: '3:58 PM', unread: 0, avatar: 'https://i.pravatar.cc/150?u=ben' },
  { id: 5, name: 'Naomi', message: 'Naomi sent a photo.', time: '3:31 PM', unread: 0, avatar: 'https://i.pravatar.cc/150?u=naomi' },
  { id: 6, name: 'Alicia', message: 'See you at 8.', time: '3:30 PM', unread: 0, avatar: 'https://i.pravatar.cc/150?u=alicia' }
];
</script>

<style scoped>
.phone-mockup {
  width: 360px;
  height: 720px;
  border-radius: 40px;
  overflow: hidden;
  position: relative;
  display: flex;
  flex-direction: column;
  box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
  transition: all 0.3s ease;
}

/* Base Light Mode (and structural variables) */
.phone-mockup {
  --bg-color: #ffffff;
  --text-main: #111827;
  --text-sub: #6b7280;
  --search-bg: #f3f4f6;
  --fab-bg: #dbeafe;
  --fab-color: #1e3a8a;
  --badge-bg: #2563eb;
  --badge-color: #ffffff;
  --bottom-nav-bg: #ffffff;
  background-color: var(--bg-color);
  color: var(--text-main);
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
}

/* Dark Mode Overrides */
.phone-mockup.dark-mode {
  --bg-color: #111827; /* Dark background matching the image */
  --text-main: #f9fafb;
  --text-sub: #9ca3af;
  --search-bg: #1f2937;
  --search-border: #374151;
  --search-text: #f9fafb;
  --search-placeholder: #9ca3af;
  --search-icon: #9ca3af;
  --fab-bg: #374151;
  --fab-color: #e5e7eb;
  --bottom-nav-bg: #111827;
}
.phone-mockup.dark-mode .bottom-nav-container :deep(.pp-bottom-nav) {
  background-color: var(--bottom-nav-bg);
  color: #fff;
}
.phone-mockup.dark-mode .bottom-nav-container :deep(.pp-bottom-nav-item.is-active .pp-nav-indicator) {
  background-color: #d3e3fd;
}
.phone-mockup.dark-mode .bottom-nav-container :deep(.pp-bottom-nav-item.is-active .pp-nav-icon) {
  color: #041e49;
}
.phone-mockup.dark-mode .bottom-nav-container :deep(.pp-bottom-nav-item.is-active .pp-nav-label) {
  color: #d3e3fd;
}
.phone-mockup.dark-mode .bottom-nav-container :deep(.pp-bottom-nav-item:not(.is-active)) {
  color: #9ca3af;
}

/* Status Bar */
.status-bar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px 24px 8px;
  font-size: 14px;
  font-weight: 500;
  z-index: 10;
}
.status-icons {
  display: flex;
  gap: 6px;
  opacity: 0.8;
}

/* Chat Header (Search) */
.chat-header {
  padding: 8px 16px 16px;
}
/* (Replaced by PPSearch) */

/* Chat List */
.chat-list {
  flex: 1;
  overflow-y: auto;
  padding-bottom: 80px; /* space for fab */
}
.chat-list::-webkit-scrollbar {
  display: none;
}

/* CSS removed, now handled by PPChatItem and PPFab */

/* Bottom Nav */
.bottom-nav-container {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  z-index: 30;
  background: var(--bottom-nav-bg);
}
.bottom-nav-container :deep(.pp-bottom-nav-container) {
  padding-bottom: 12px; /* iOS home bar safe area simulation */
  border-radius: 0 0 40px 40px; /* match phone mockup border radius */
}

.phone-mockup.dark-mode .bottom-nav-container::after {
  content: '';
  position: absolute;
  bottom: 8px;
  left: 50%;
  transform: translateX(-50%);
  width: 100px;
  height: 4px;
  background: #ffffff;
  border-radius: 4px;
  opacity: 0.8;
  z-index: 40;
}
.phone-mockup.light-mode .bottom-nav-container::after {
  content: '';
  position: absolute;
  bottom: 8px;
  left: 50%;
  transform: translateX(-50%);
  width: 100px;
  height: 4px;
  background: #000000;
  border-radius: 4px;
  opacity: 0.8;
  z-index: 40;
}

/* Code Usage Section */
.usage-section {
  margin-top: 48px;
  background: #f8fafc;
  padding: 24px;
  border-radius: 12px;
  border: 1px solid #e2e8f0;
}
.usage-section h3 {
  margin-top: 0;
  margin-bottom: 16px;
  color: #1e293b;
  font-size: 18px;
}
.code-block {
  background: #1e293b;
  color: #e2e8f0;
  padding: 16px;
  border-radius: 8px;
  overflow-x: auto;
  font-size: 14px;
  line-height: 1.5;
  margin: 0;
}
</style>
