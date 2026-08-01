<template>
  <div class="screen-preview-container">
    <div class="header-actions">
      <PPButton variant="primary" size="small" @click="isDarkMode = !isDarkMode">
        Toggle {{ isDarkMode ? 'Light' : 'Dark' }} Mode
      </PPButton>
    </div>

    <!-- Phone Mockup Container -->
    <div class="phone-mockup" :class="{ 'dark-mode': isDarkMode }">
      <div class="chat-detail-screen">
        
        <!-- Header -->
        <PPAppBar title="Bryan" class="transparent-appbar">
          <template #left>
            <PPIconButton :icon="arrowBackOutline" color="transparent" class="header-icon-btn" />
          </template>
          <template #right>
            <PPIconButton :icon="callOutline" color="transparent" class="header-icon-btn" />
            <PPIconButton :icon="searchOutline" color="transparent" class="header-icon-btn" />
            <PPIconButton :icon="ellipsisVerticalOutline" color="transparent" class="header-icon-btn" />
          </template>
        </PPAppBar>

        <!-- Chat Body -->
        <div class="chat-body" ref="chatBody">
          
          <!-- Received Text -->
          <div class="message-row received">
            <PPAvatar src="https://i.pravatar.cc/150?img=11" name="Bryan" size="md" class="msg-avatar" />
            <div class="message-bubble received-bubble">
              Looking forward to the trip.
            </div>
          </div>
          
          <!-- Sent Text -->
          <div class="message-row sent">
            <div class="message-bubble sent-bubble">
              Same! Can't wait.
            </div>
          </div>
          
          <!-- Timestamp -->
          <div class="message-timestamp">
            Today 8:43 AM
          </div>

          <!-- Received Rich Card -->
          <div class="message-row received align-top">
            <PPAvatar src="https://i.pravatar.cc/150?img=11" name="Bryan" size="md" class="msg-avatar" />
            <div class="message-bubble received-bubble rich-card">
              <img src="https://picsum.photos/400/200?random=1" alt="Antelope Canyon" class="rich-card-image" />
              <div class="rich-card-content">
                <div class="rich-card-title">Antelope Canyon guide tour</div>
                <div class="rich-card-subtitle">airbnb.com</div>
              </div>
            </div>
          </div>

          <!-- Received Text -->
          <div class="message-row received">
            <PPAvatar src="https://i.pravatar.cc/150?img=11" name="Bryan" size="md" class="msg-avatar" />
            <div class="message-bubble received-bubble">
              What do you think?
            </div>
          </div>
          
          <!-- Sent Text -->
          <div class="message-row sent">
            <div class="message-bubble sent-bubble">
              Oh yes this looks great!
            </div>
          </div>

        </div>

        <!-- Chat Footer (Input) -->
        <div class="chat-footer">
          <PPIconButton :icon="camera" color="transparent" class="footer-icon-btn" />
          <PPIconButton :icon="imageOutline" color="transparent" class="footer-icon-btn" />
          <PPInput placeholder="Message" class="chat-input" />
        </div>

        <!-- Home Indicator -->
        <div class="home-indicator"></div>
      </div>
    </div>
    
    <div class="usage-section">
      <h3>Code Usage</h3>
      <pre class="code-block" v-pre><code>
&lt;template&gt;
  &lt;div class="chat-detail-screen"&gt;
    &lt;PPAppBar title="Bryan" class="transparent-appbar"&gt;
      &lt;template #left&gt;
        &lt;PPIconButton :icon="arrowBackOutline" color="transparent" class="header-icon-btn" /&gt;
      &lt;/template&gt;
    &lt;/PPAppBar&gt;
    
    &lt;div class="chat-body"&gt;
      &lt;div class="message-row received"&gt;
        &lt;PPAvatar src="https://i.pravatar.cc/150?img=11" name="Bryan" size="md" /&gt;
        &lt;div class="message-bubble received-bubble"&gt;
          Looking forward to the trip.
        &lt;/div&gt;
      &lt;/div&gt;
      &lt;div class="message-row sent"&gt;
        &lt;div class="message-bubble sent-bubble"&gt;
          Same! Can't wait.
        &lt;/div&gt;
      &lt;/div&gt;
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
  callOutline, 
  searchOutline, 
  ellipsisVerticalOutline,
  camera,
  imageOutline
} from 'ionicons/icons';
import { PPButton, PPAvatar, PPAppBar, PPIconButton, PPInput } from '@phanna/ui-framework';

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
  --bg-color: #f8fafc;
  --text-main: #1e293b;
  --text-sub: #64748b;
  --header-icon: #334155;
  
  --received-bubble-bg: #ffffff;
  --received-bubble-text: #1e293b;
  --received-bubble-sub: #64748b;
  
  --sent-bubble-bg: #1d4ed8;
  --sent-bubble-text: #ffffff;
  
  --input-bg: #ffffff;
  --input-text: #1e293b;
  --input-icon: #1d4ed8;
  --input-icon-secondary: #3b82f6;
  
  --home-indicator: #1e293b;
}

/* Dark Mode Overrides */
.phone-mockup.dark-mode {
  --bg-color: #0b1120;
  --text-main: #f9fafb;
  --text-sub: #9ca3af;
  --header-icon: #f9fafb;
  
  --received-bubble-bg: #1e293b;
  --received-bubble-text: #f9fafb;
  --received-bubble-sub: #9ca3af;
  
  --sent-bubble-bg: #93c5fd;
  --sent-bubble-text: #0f172a;
  
  --input-bg: #1e293b;
  --input-text: #f9fafb;
  --input-icon: #93c5fd;
  --input-icon-secondary: #93c5fd;
  
  --home-indicator: #f9fafb;
}

.chat-detail-screen {
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

:deep(.transparent-appbar .app-bar-right) {
  gap: 8px;
}

/* Chat Body */
.chat-body {
  flex: 1;
  padding: 16px;
  overflow-y: auto;
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.message-row {
  display: flex;
  align-items: flex-end;
  gap: 8px;
  max-width: 100%;
}

.message-row.align-top {
  align-items: flex-start;
}

.message-row.sent {
  justify-content: flex-end;
}

.msg-avatar {
  flex-shrink: 0;
}

.message-bubble {
  padding: 12px 16px;
  border-radius: 20px;
  font-size: 15px;
  line-height: 1.4;
  max-width: 75%;
  word-break: break-word;
}

.received-bubble {
  background-color: var(--received-bubble-bg);
  color: var(--received-bubble-text);
  border-bottom-left-radius: 4px;
  box-shadow: 0 1px 2px rgba(0,0,0,0.05);
}

.sent-bubble {
  background-color: var(--sent-bubble-bg);
  color: var(--sent-bubble-text);
  border-bottom-right-radius: 4px;
  box-shadow: 0 1px 2px rgba(0,0,0,0.05);
}

.message-timestamp {
  text-align: center;
  font-size: 12px;
  color: var(--text-sub);
  margin: 16px 0;
}

/* Rich Card Message */
.rich-card {
  padding: 0;
  overflow: hidden;
  border-radius: 16px;
  border-bottom-left-radius: 4px;
  display: flex;
  flex-direction: column;
}

.rich-card-image {
  width: 100%;
  height: 140px;
  object-fit: cover;
  display: block;
}

.rich-card-content {
  padding: 12px 16px;
}

.rich-card-title {
  font-size: 14px;
  font-weight: 500;
  margin-bottom: 2px;
}

.rich-card-subtitle {
  font-size: 13px;
  color: var(--received-bubble-sub);
}

/* Footer / Input Area */
.chat-footer {
  padding: 12px 16px 24px;
  display: flex;
  align-items: center;
  gap: 12px;
  background: transparent;
}

:deep(.footer-icon-btn.pp-icon-btn--transparent) {
  color: var(--input-icon) !important;
}

.chat-input {
  flex: 1;
}

:deep(.chat-input.pp-input-wrapper) {
  margin-bottom: 0;
}

:deep(.chat-input .pp-input-container) {
  background-color: var(--input-bg);
  border-radius: 24px;
  height: 48px;
  padding: 0 16px;
  border: none;
  box-shadow: 0 1px 2px rgba(0,0,0,0.05);
}

:deep(.chat-input .pp-input) {
  font-size: 15px;
  color: var(--input-text);
}

:deep(.chat-input .pp-input::placeholder) {
  color: var(--text-sub);
}

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

/* Hide scrollbar for cleaner look */
.chat-body::-webkit-scrollbar {
  display: none;
}
.chat-body {
  -ms-overflow-style: none;
  scrollbar-width: none;
}
</style>
