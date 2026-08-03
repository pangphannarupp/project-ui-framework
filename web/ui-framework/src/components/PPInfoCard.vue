<template>
  <div 
    class="pp-info-card" 
    :class="[
      `pp-info-card--${type}`,
      `pp-info-card--${variant}`
    ]"
    :style="{ backgroundColor: backgroundColor, borderRadius: borderRadius, color: textColor, borderColor: borderColor }"
  >
    <div class="icon-container" :style="{ color: iconColor }">
      <slot name="icon">
        <svg v-if="type === 'warning'" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z"></path>
          <line x1="12" y1="9" x2="12" y2="13"></line>
          <line x1="12" y1="17" x2="12.01" y2="17"></line>
        </svg>
        <svg v-else-if="type === 'success'" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path>
          <polyline points="22 4 12 14.01 9 11.01"></polyline>
        </svg>
        <svg v-else-if="type === 'error'" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <circle cx="12" cy="12" r="10"></circle>
          <line x1="15" y1="9" x2="9" y2="15"></line>
          <line x1="9" y1="9" x2="15" y2="15"></line>
        </svg>
        <svg v-else viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <circle cx="12" cy="12" r="10"></circle>
          <line x1="12" y1="16" x2="12" y2="12"></line>
          <line x1="12" y1="8" x2="12.01" y2="8"></line>
        </svg>
      </slot>
    </div>
    <div class="content-container">
      <slot></slot>
    </div>
  </div>
</template>

<script setup lang="ts">
defineProps({
  type: {
    type: String,
    default: 'info' // 'info', 'warning', 'success', 'error', 'neutral'
  },
  variant: {
    type: String,
    default: 'soft' // 'soft', 'solid', 'outline', 'glass'
  },
  backgroundColor: { type: String, default: undefined },
  textColor: { type: String, default: undefined },
  iconColor: { type: String, default: undefined },
  borderColor: { type: String, default: undefined },
  borderRadius: { type: String, default: undefined }
});
</script>

<style scoped>
.pp-info-card {
  display: flex;
  align-items: flex-start;
  gap: 12px;
  padding: 16px;
  border-radius: 12px;
  border: 1px solid transparent;
  transition: all 0.3s ease;
}

.icon-container {
  flex-shrink: 0;
  display: flex;
  align-items: center;
  justify-content: center;
}

.icon-container svg {
  width: 20px;
  height: 20px;
}

.content-container {
  flex: 1;
  font-size: 14px;
  line-height: 1.5;
}

/* Base colors */
.pp-info-card--info { --card-color: #3b82f6; --card-bg: #eff6ff; --card-border: #bfdbfe; }
.pp-info-card--success { --card-color: #10b981; --card-bg: #ecfdf5; --card-border: #a7f3d0; }
.pp-info-card--warning { --card-color: #f59e0b; --card-bg: #fffbeb; --card-border: #fde68a; }
.pp-info-card--error { --card-color: #ef4444; --card-bg: #fef2f2; --card-border: #fecaca; }
.pp-info-card--neutral { --card-color: #6b7280; --card-bg: #f9fafb; --card-border: #e5e7eb; }

/* Variants */
.pp-info-card--soft {
  background-color: var(--card-bg);
  border-color: var(--card-border);
  color: #374151;
}
.pp-info-card--soft .icon-container {
  color: var(--card-color);
}

.pp-info-card--solid {
  background-color: var(--card-color);
  border-color: var(--card-color);
  color: #ffffff;
}
.pp-info-card--solid .icon-container {
  color: #ffffff;
}

.pp-info-card--outline {
  background-color: transparent;
  border-color: var(--card-color);
  color: #374151;
}
.pp-info-card--outline .icon-container {
  color: var(--card-color);
}

.pp-info-card--glass {
  background-color: rgba(255, 255, 255, 0.4);
  backdrop-filter: blur(12px);
  -webkit-backdrop-filter: blur(12px);
  border: 1px solid rgba(255, 255, 255, 0.6);
  color: #374151;
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.05);
}
.pp-info-card--glass .icon-container {
  color: var(--card-color);
}
</style>
