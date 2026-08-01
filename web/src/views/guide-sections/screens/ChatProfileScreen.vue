<template>
  <div class="screen-preview-container">
    <div class="header-actions">
      <PPButton variant="primary" size="small" @click="isDarkMode = !isDarkMode">
        Toggle {{ isDarkMode ? 'Light' : 'Dark' }} Mode
      </PPButton>
    </div>

    <!-- Phone Mockup Container -->
    <div class="phone-mockup" :class="{ 'dark-mode': isDarkMode }">
      <div class="chat-profile-screen">
        
        <!-- Header -->
        <PPAppBar class="transparent-appbar">
          <template #left>
            <PPIconButton :icon="arrowBackOutline" color="transparent" class="header-icon-btn" />
          </template>
          <template #right>
            <PPIconButton :icon="ellipsisVerticalOutline" color="transparent" class="header-icon-btn" />
          </template>
        </PPAppBar>

        <div class="profile-scroll-area">
          <!-- Profile Info -->
          <div class="profile-info">
            <div class="avatar-wrapper">
              <PPAvatar src="https://i.pravatar.cc/150?img=5" name="Cindy" size="xl" class="profile-avatar" />
            </div>
            <h2 class="profile-name">Cindy</h2>
            <p class="profile-phone">+14844533842</p>
          </div>

          <!-- Actions Group -->
          <div class="actions-group">
            <div class="action-item">
              <PPIconButton :icon="pencilOutline" class="action-icon-btn" />
              <span class="action-label">Message</span>
            </div>
            <div class="action-item">
              <PPIconButton :icon="callOutline" class="action-icon-btn" />
              <span class="action-label">Call</span>
            </div>
            <div class="action-item">
              <PPIconButton :icon="notificationsOffOutline" class="action-icon-btn" />
              <span class="action-label">Mute</span>
            </div>
          </div>

          <!-- More Actions List -->
          <div class="more-actions-section">
            <h3 class="section-title">More actions</h3>
            
            <div class="action-list">
              <div class="list-item">
                <ion-icon :icon="imageOutline" class="list-icon" />
                <span class="list-text">View media</span>
              </div>
              <div class="list-item">
                <ion-icon :icon="searchOutline" class="list-icon" />
                <span class="list-text">Search in conversation</span>
              </div>
              <div class="list-item">
                <ion-icon :icon="notificationsOutline" class="list-icon" />
                <span class="list-text">Notifications</span>
              </div>
            </div>
          </div>
        </div>

        <!-- Home Indicator -->
        <div class="home-indicator"></div>
      </div>
    </div>
    
    <div class="usage-section">
      <h3>Code Usage</h3>
      <pre class="code-block" v-pre><code>
&lt;template&gt;
  &lt;div class="chat-profile-screen"&gt;
    &lt;PPAppBar class="transparent-appbar"&gt;
      &lt;template #left&gt;
        &lt;PPIconButton :icon="arrowBackOutline" color="transparent" /&gt;
      &lt;/template&gt;
      &lt;template #right&gt;
        &lt;PPIconButton :icon="ellipsisVerticalOutline" color="transparent" /&gt;
      &lt;/template&gt;
    &lt;/PPAppBar&gt;
    
    &lt;div class="profile-info"&gt;
      &lt;PPAvatar src="..." name="Cindy" size="xl" /&gt;
      &lt;h2&gt;Cindy&lt;/h2&gt;
      &lt;p&gt;+14844533842&lt;/p&gt;
    &lt;/div&gt;

    &lt;div class="actions-group"&gt;
      &lt;div class="action-item"&gt;
        &lt;PPIconButton :icon="pencilOutline" /&gt;
        &lt;span&gt;Message&lt;/span&gt;
      &lt;/div&gt;
      &lt;!-- Call and Mute buttons --&gt;
    &lt;/div&gt;
  &lt;/div&gt;
&lt;/template&gt;
      </code></pre>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { IonIcon } from '@ionic/vue';
import { 
  arrowBackOutline, 
  ellipsisVerticalOutline,
  pencilOutline,
  callOutline,
  notificationsOffOutline,
  imageOutline,
  searchOutline,
  notificationsOutline
} from 'ionicons/icons';
import { PPButton, PPAvatar, PPAppBar, PPIconButton } from '@phanna/ui-framework';

const isDarkMode = ref(false);
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
  
  --action-btn-bg: #1d4ed8;
  --action-btn-icon: #ffffff;
  --action-btn-label: #1d4ed8;
  
  --list-icon: #1d4ed8;
  
  --home-indicator: #111827;
}

/* Dark Mode Overrides */
.phone-mockup.dark-mode {
  --bg-color: #0f172a;
  --text-main: #f9fafb;
  --text-sub: #9ca3af;
  --header-icon: #f9fafb;
  
  --action-btn-bg: #93c5fd;
  --action-btn-icon: #0f172a;
  --action-btn-label: #93c5fd;
  
  --list-icon: #93c5fd;
  
  --home-indicator: #f9fafb;
}

.chat-profile-screen {
  display: flex;
  flex-direction: column;
  height: 100%;
  width: 100%;
}

/* Header Overrides */
.transparent-appbar {
  --pp-app-bar-bg: transparent;
  --pp-app-bar-color: var(--text-main);
  padding-top: 50px; /* Extra padding for status bar */
  box-shadow: none;
}

:deep(.header-icon-btn.pp-icon-btn--transparent) {
  color: var(--header-icon) !important;
}

.profile-scroll-area {
  flex: 1;
  overflow-y: auto;
  padding: 16px;
  -ms-overflow-style: none;
  scrollbar-width: none;
}
.profile-scroll-area::-webkit-scrollbar {
  display: none;
}

/* Profile Info */
.profile-info {
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-top: 16px;
  margin-bottom: 32px;
}

.avatar-wrapper {
  margin-bottom: 24px;
}

:deep(.profile-avatar.pp-avatar) {
  width: 120px;
  height: 120px;
}

.profile-name {
  font-size: 28px;
  font-weight: 500;
  color: var(--text-main);
  margin: 0 0 8px;
}

.profile-phone {
  font-size: 15px;
  color: var(--text-sub);
  margin: 0;
}

/* Actions Group */
.actions-group {
  display: flex;
  justify-content: center;
  gap: 32px;
  margin-bottom: 40px;
}

.action-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8px;
}

:deep(.action-icon-btn.pp-icon-btn) {
  width: 48px;
  height: 48px;
  border-radius: 50%;
  background-color: var(--action-btn-bg);
  color: var(--action-btn-icon);
}

.action-label {
  font-size: 13px;
  font-weight: 500;
  color: var(--action-btn-label);
}

/* More Actions List */
.more-actions-section {
  display: flex;
  flex-direction: column;
}

.section-title {
  font-size: 14px;
  font-weight: 600;
  color: var(--action-btn-label);
  margin: 0 0 16px;
  padding: 0 16px;
}

.action-list {
  display: flex;
  flex-direction: column;
}

.list-item {
  display: flex;
  align-items: center;
  padding: 16px;
  gap: 16px;
  cursor: pointer;
}

.list-icon {
  font-size: 24px;
  color: var(--list-icon);
}

.list-text {
  font-size: 16px;
  font-weight: 400;
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
