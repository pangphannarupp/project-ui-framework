<template>
  <div 
    class="pp-info-card" 
    :class="[`pp-info-card--${type}`]"
    :style="{ backgroundColor: backgroundColor, borderRadius: borderRadius }"
  >
    <div class="icon-container" :style="{ color: iconColor }">
      <slot name="icon">
        <svg v-if="type === 'warning'" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z"></path>
          <line x1="12" y1="9" x2="12" y2="13"></line>
          <line x1="12" y1="17" x2="12.01" y2="17"></line>
        </svg>
        <svg v-else viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <circle cx="12" cy="12" r="10"></circle>
          <line x1="12" y1="16" x2="12" y2="12"></line>
          <line x1="12" y1="8" x2="12.01" y2="8"></line>
        </svg>
      </slot>
    </div>
    <div class="content-container" :style="{ color: textColor }">
      <slot></slot>
    </div>
  </div>
</template>

<script setup lang="ts">
defineProps({
  type: {
    type: String,
    default: 'warning' // 'warning', 'info'
  },
  backgroundColor: { type: String, default: undefined },
  textColor: { type: String, default: undefined },
  iconColor: { type: String, default: undefined },
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
  background-color: #f8f9fa;
  border: 1px solid #f1f3f5;
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
  color: var(--pp-primary-variant, #1a2a5e); /* Default dark blue as in the design */
}

.content-container {
  flex: 1;
  font-size: 13px;
  line-height: 1.5;
  color: #333;
}
</style>
