<template>
  <ion-page>
    <div class="pp-screen pp-setting-screen">
      <!-- Top App Bar -->
      <div class="top-bar">
        <button class="dev-back-btn" @click="router.push('/')">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <line x1="19" y1="12" x2="5" y2="12"></line>
            <polyline points="12 19 5 12 12 5"></polyline>
          </svg>
          Back
        </button>
        <h2 class="screen-title">Settings</h2>
      </div>

      <div class="main-card">
        <!-- Theme Setting -->
        <div class="setting-item setting-item-column">
          <div class="setting-info">
            <h3 class="setting-title">Theme Mode</h3>
            <p class="setting-desc">Choose light, dark, or system default</p>
          </div>
          <PPSegment v-model="themeMode" variant="pill" style="margin-top: 12px;">
            <PPSegmentButton value="light">Light</PPSegmentButton>
            <PPSegmentButton value="dark">Dark</PPSegmentButton>
            <PPSegmentButton value="system">System</PPSegmentButton>
          </PPSegment>
        </div>

        <PPDivider />

        <!-- Language Setting -->
        <div class="setting-item" @click="isLanguageSheetOpen = true">
          <div class="setting-info">
            <h3 class="setting-title">Language</h3>
            <p class="setting-desc">{{ getLanguageName(currentLanguage) }}</p>
          </div>
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="20" height="20" class="arrow-icon">
            <polyline points="9 18 15 12 9 6"></polyline>
          </svg>
        </div>

        <PPDivider />

        <!-- Version -->
        <div class="setting-item">
          <div class="setting-info">
            <h3 class="setting-title">App Version</h3>
            <p class="setting-desc">v1.0.0</p>
          </div>
        </div>
      </div>
      
      <PPLanguageSheet
        v-model="isLanguageSheetOpen"
        v-model:modelValueLang="currentLanguage"
      />
    </div>
  </ion-page>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import PPSegment from '../../ui-framework/src/components/PPSegment.vue';
import PPSegmentButton from '../../ui-framework/src/components/PPSegmentButton.vue';
import PPLanguageSheet from '../../ui-framework/src/components/PPLanguageSheet.vue';
import PPDivider from '../../ui-framework/src/components/PPDivider.vue';
import { IonPage } from '@ionic/vue';

const router = useRouter();
const themeMode = ref('system');
const currentLanguage = ref('en');
const isLanguageSheetOpen = ref(false);

const languages = [
  { code: 'km', name: 'ភាសាខ្មែរ' },
  { code: 'en', name: 'English' },
  { code: 'ko', name: '한국어' },
];

const getLanguageName = (code: string) => {
  const lang = languages.find(l => l.code === code);
  return lang ? lang.name : 'English';
};
</script>

<style scoped>
.pp-setting-screen {
  display: flex;
  flex-direction: column;
  height: 100%;
  background-color: var(--pp-background, #f8f9fa);
}

.top-bar {
  display: flex;
  align-items: center;
  padding: 16px 20px;
  background: white;
  border-bottom: 1px solid #eaeaea;
}

.dev-back-btn {
  display: flex;
  align-items: center;
  gap: 8px;
  background: none;
  border: none;
  color: var(--pp-primary, #0052FF);
  font-size: 16px;
  font-weight: 500;
  cursor: pointer;
  padding: 0;
  margin-right: 16px;
}

.dev-back-btn svg {
  width: 20px;
  height: 20px;
}

.screen-title {
  font-size: 18px;
  font-weight: 600;
  margin: 0;
  color: var(--pp-text-primary, #1a1a1a);
}

.main-card {
  margin: 20px;
  background: white;
  border-radius: 16px;
  padding: 20px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.setting-item {
  display: flex;
  align-items: center;
  justify-content: space-between;
  cursor: pointer;
  padding: 4px 0;
}

.setting-item-column {
  flex-direction: column;
  align-items: stretch;
  cursor: default;
}

.setting-info {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.setting-title {
  font-size: 16px;
  font-weight: 600;
  color: var(--pp-text-primary, #1a1a1a);
  margin: 0;
}

.setting-desc {
  font-size: 14px;
  color: var(--pp-text-secondary, #666);
  margin: 0;
}

.arrow-icon {
  color: #999;
}
</style>
