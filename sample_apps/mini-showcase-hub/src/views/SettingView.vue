<template>
  <div class="setting-view">
    <!-- Header -->
    <div class="setting-banner glass-panel">
      <div class="banner-avatar">
        <PPAvatar name="Admin UI" size="lg" />
      </div>
      <div class="banner-info">
        <h2>App Configuration & Themes</h2>
        <p>Personalize localization, styling palettes, and view framework details.</p>
      </div>
    </div>

    <!-- Appearance Mode (Theme Mode) Section -->
    <SettingsSection :title="t.themeMode" subtitle="Switch between Light, Dark, or System mode">
      <div class="theme-mode-selector">
        <PPSegment v-model="themeMode" variant="pill">
          <PPSegmentButton value="light">
            <div class="mode-item">
              <svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="5"></circle><line x1="12" y1="1" x2="12" y2="3"></line><line x1="12" y1="21" x2="12" y2="23"></line><line x1="4.22" y1="4.22" x2="5.64" y2="5.64"></line><line x1="18.36" y1="18.36" x2="19.78" y2="19.78"></line><line x1="1" y1="12" x2="3" y2="12"></line><line x1="21" y1="12" x2="23" y2="12"></line><line x1="4.22" y1="19.78" x2="5.64" y2="18.36"></line><line x1="18.36" y1="5.64" x2="19.78" y2="4.22"></line></svg>
              <span>{{ t.light }}</span>
            </div>
          </PPSegmentButton>
          <PPSegmentButton value="dark">
            <div class="mode-item">
              <svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z"></path></svg>
              <span>{{ t.dark }}</span>
            </div>
          </PPSegmentButton>
          <PPSegmentButton value="system">
            <div class="mode-item">
              <svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2"><rect x="2" y="3" width="20" height="14" rx="2" ry="2"></rect><line x1="8" y1="21" x2="16" y2="21"></line><line x1="12" y1="17" x2="12" y2="21"></line></svg>
              <span>{{ t.system }}</span>
            </div>
          </PPSegmentButton>
        </PPSegment>
      </div>
    </SettingsSection>

    <!-- Theme Color Customization -->
    <SettingsSection :title="t.themeColor" subtitle="Select primary accent theme color for framework components">
      <div class="color-picker-row">
        <div class="swatches-list">
          <div
            v-for="color in presetColors"
            :key="color"
            class="color-circle"
            :class="{ 'is-selected': primaryColor === color }"
            :style="{ backgroundColor: color }"
            @click="applyPrimaryColor(color)"
          >
            <svg v-if="primaryColor === color" viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="#fff" stroke-width="3">
              <polyline points="20 6 9 17 4 12"></polyline>
            </svg>
          </div>
        </div>

        <PPButton variant="soft" size="small" @click="showColorSheet = true">
          <span>Custom Palette</span>
        </PPButton>
      </div>
    </SettingsSection>

    <!-- Language Selector -->
    <SettingsSection :title="t.changeLanguage" subtitle="Change app display language and region">
      <div class="setting-action-row" @click="showLangSheet = true">
        <div class="action-left">
          <span class="flag-icon">{{ currentLangFlag }}</span>
          <div>
            <strong>{{ currentLangName }}</strong>
            <small>Active Application Locale</small>
          </div>
        </div>
        <PPButton variant="outline" size="small">
          <span>Change</span>
        </PPButton>
      </div>
    </SettingsSection>

    <!-- Project Information Card -->
    <SettingsSection :title="t.projectInfo" subtitle="Build architecture and library dependencies">
      <div class="info-list">
        <div class="info-item">
          <span>Application Name</span>
          <strong>UI Framework Showcase & Mini Hub</strong>
        </div>
        <div class="info-item">
          <span>{{ t.frameworkVersion }}</span>
          <PPChip label="@phanna/ui-framework 1.0.11" size="sm" variant="soft" color="primary" />
        </div>
        <div class="info-item">
          <span>{{ t.version }}</span>
          <code>v1.0.0 (Build 2026.09)</code>
        </div>
        <div class="info-item">
          <span>{{ t.techStack }}</span>
          <strong>Vue 3 • Vite 5 • TypeScript • Ionic</strong>
        </div>
        <div class="info-item">
          <span>{{ t.author }}</span>
          <strong>Pang Phanna & Team</strong>
        </div>
      </div>
    </SettingsSection>

    <!-- Language Bottom Sheet Component from ui-framework -->
    <PPLanguageSheet
      v-model="showLangSheet"
      v-model:modelValueLang="selectedLanguage"
    />

    <!-- Color Picker Sheet Component from ui-framework -->
    <PPColorPickerSheet
      v-model="showColorSheet"
      :colorValue="primaryColor"
      title="Custom Primary Accent Color"
      @confirm="onColorPicked"
    />
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import {
  PPSegment,
  PPSegmentButton,
  PPButton,
  PPChip,
  PPAvatar,
  PPLanguageSheet,
  PPColorPickerSheet
} from '@phanna/ui-framework'
import { useAppState } from '../stores/appState'
import SettingsSection from '../components/settings/SettingsSection.vue'

const {
  t,
  themeMode,
  selectedLanguage,
  primaryColor,
  applyPrimaryColor
} = useAppState()

const showLangSheet = ref(false)
const showColorSheet = ref(false)

const presetColors = [
  '#3b82f6', // Blue
  '#10b981', // Emerald
  '#8b5cf6', // Violet
  '#f59e0b', // Amber
  '#ec4899', // Pink
  '#06b6d4', // Cyan
  '#ef4444'  // Red
]

const currentLangFlag = computed(() => {
  switch (selectedLanguage.value) {
    case 'km': return '🇰🇭'
    case 'ko': return '🇰🇷'
    case 'ja': return '🇯🇵'
    case 'zh': return '🇨🇳'
    default: return '🇬🇧'
  }
})

const currentLangName = computed(() => {
  switch (selectedLanguage.value) {
    case 'km': return 'ភាសាខ្មែរ (Khmer)'
    case 'ko': return '한국어 (Korean)'
    case 'ja': return '日本語 (Japanese)'
    case 'zh': return '漢語 (Chinese)'
    default: return 'English (UK / US)'
  }
})

const onColorPicked = (color: string) => {
  if (color) applyPrimaryColor(color)
}
</script>

<style scoped>
.setting-view {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.setting-banner {
  padding: 24px;
  border-radius: var(--radius-lg);
  border: 1px solid var(--border-color);
  display: flex;
  align-items: center;
  gap: 18px;
}

.banner-info h2 {
  font-size: 19px;
  font-weight: 800;
  color: var(--text-main);
  margin-bottom: 4px;
}

.banner-info p {
  font-size: 13px;
  color: var(--text-muted);
}

.theme-mode-selector :deep(.pp-segment) {
  background-color: var(--bg-card) !important;
  border: 1px solid var(--border-color) !important;
}

.mode-item {
  display: flex;
  align-items: center;
  gap: 6px;
}

.color-picker-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
  gap: 14px;
}

.swatches-list {
  display: flex;
  align-items: center;
  gap: 10px;
}

.color-circle {
  width: 32px;
  height: 32px;
  border-radius: 50%;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: transform 0.2s cubic-bezier(0.4, 0, 0.2, 1);
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.15);
}

.color-circle:hover {
  transform: scale(1.15);
}

.color-circle.is-selected {
  transform: scale(1.15);
  box-shadow: 0 0 0 3px var(--bg-card), 0 0 0 5px var(--pp-primary);
}

.setting-action-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 12px 14px;
  background: var(--bg-main);
  border-radius: var(--radius-md);
  border: 1px solid var(--border-color);
  cursor: pointer;
  transition: border-color 0.2s ease;
}

.setting-action-row:hover {
  border-color: var(--pp-primary);
}

.action-left {
  display: flex;
  align-items: center;
  gap: 12px;
}

.flag-icon {
  font-size: 26px;
  line-height: 1;
}

.action-left strong {
  display: block;
  font-size: 14px;
  color: var(--text-main);
}

.action-left small {
  font-size: 11px;
  color: var(--text-sub);
}

.info-list {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.info-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 8px 0;
  border-bottom: 1px solid var(--border-color);
  font-size: 13px;
}

.info-item:last-child {
  border-bottom: none;
}

.info-item span {
  color: var(--text-muted);
}

.info-item strong {
  color: var(--text-main);
}

.info-item code {
  font-family: monospace;
  font-size: 12px;
  color: var(--pp-primary);
}
</style>
