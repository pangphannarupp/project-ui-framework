<template>
  <div class="pp-notification-item" @click="$emit('click')">
    <div class="pp-notification-icon-wrapper">
      <div v-if="unread" class="pp-notification-unread-dot"></div>
      <div class="pp-notification-icon">
        <slot name="icon"></slot>
      </div>
    </div>
    
    <div class="pp-notification-content">
      <div class="pp-notification-title">{{ title }}</div>
      <div class="pp-notification-desc">{{ description }}</div>
      
      <div class="pp-notification-footer">
        <div class="pp-notification-time">{{ timestamp }}</div>
        <div class="pp-notification-action" @click.stop="$emit('detail-click')">
          <span>Detail</span>
          <svg viewBox="0 0 24 24" width="14" height="14" stroke="currentColor" stroke-width="2" fill="none"><path d="M9 18l6-6-6-6"/></svg>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
defineProps<{
  title: string;
  description: string;
  timestamp: string;
  unread?: boolean;
}>();

defineEmits(['click', 'detail-click']);
</script>

<style scoped>
.pp-notification-item {
  display: flex;
  padding: 16px;
  background-color: var(--pp-notification-bg, #ffffff);
  border-bottom: 1px solid var(--pp-notification-border-color, #f0f0f0);
  cursor: pointer;
  transition: background-color 0.2s;
}

.pp-notification-item:active {
  background-color: var(--pp-notification-active-bg, #f9f9f9);
}

.pp-notification-icon-wrapper {
  position: relative;
  margin-right: 16px;
  flex-shrink: 0;
}

.pp-notification-icon {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background-color: var(--pp-notification-icon-bg, #f4f6fc);
  color: var(--pp-notification-icon-color, #1a2a5e);
}

.pp-notification-icon :deep(svg) {
  width: 20px;
  height: 20px;
}

.pp-notification-unread-dot {
  position: absolute;
  top: 0;
  left: 0;
  width: 8px;
  height: 8px;
  border-radius: 50%;
  background-color: var(--pp-notification-unread-color, #e03b41);
}

.pp-notification-content {
  flex: 1;
  display: flex;
  flex-direction: column;
}

.pp-notification-title {
  font-size: 15px;
  font-weight: 700;
  color: var(--pp-notification-title-color, #1a2a5e);
  margin-bottom: 4px;
}

.pp-notification-desc {
  font-size: 14px;
  color: var(--pp-notification-desc-color, #555555);
  line-height: 1.4;
  margin-bottom: 12px;
}

.pp-notification-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: auto;
}

.pp-notification-time {
  font-size: 12px;
  color: var(--pp-notification-time-color, #888888);
}

.pp-notification-action {
  display: flex;
  align-items: center;
  font-size: 13px;
  color: var(--pp-notification-action-color, #666666);
  gap: 2px;
}

.pp-notification-action span {
  /* optional hover styling */
}
</style>
