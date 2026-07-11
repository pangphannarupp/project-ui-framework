<template>
  <div class="biz-notification-item" @click="$emit('click')">
    <div class="biz-notification-icon-wrapper">
      <div v-if="unread" class="biz-notification-unread-dot"></div>
      <div class="biz-notification-icon">
        <slot name="icon"></slot>
      </div>
    </div>
    
    <div class="biz-notification-content">
      <div class="biz-notification-title">{{ title }}</div>
      <div class="biz-notification-desc">{{ description }}</div>
      
      <div class="biz-notification-footer">
        <div class="biz-notification-time">{{ timestamp }}</div>
        <div class="biz-notification-action" @click.stop="$emit('detail-click')">
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
.biz-notification-item {
  display: flex;
  padding: 16px;
  background-color: var(--biz-notification-bg, #ffffff);
  border-bottom: 1px solid var(--biz-notification-border-color, #f0f0f0);
  cursor: pointer;
  transition: background-color 0.2s;
}

.biz-notification-item:active {
  background-color: var(--biz-notification-active-bg, #f9f9f9);
}

.biz-notification-icon-wrapper {
  position: relative;
  margin-right: 16px;
  flex-shrink: 0;
}

.biz-notification-icon {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background-color: var(--biz-notification-icon-bg, #f4f6fc);
  color: var(--biz-notification-icon-color, #1a2a5e);
}

.biz-notification-icon :deep(svg) {
  width: 20px;
  height: 20px;
}

.biz-notification-unread-dot {
  position: absolute;
  top: 0;
  left: 0;
  width: 8px;
  height: 8px;
  border-radius: 50%;
  background-color: var(--biz-notification-unread-color, #e03b41);
}

.biz-notification-content {
  flex: 1;
  display: flex;
  flex-direction: column;
}

.biz-notification-title {
  font-size: 15px;
  font-weight: 700;
  color: var(--biz-notification-title-color, #1a2a5e);
  margin-bottom: 4px;
}

.biz-notification-desc {
  font-size: 14px;
  color: var(--biz-notification-desc-color, #555555);
  line-height: 1.4;
  margin-bottom: 12px;
}

.biz-notification-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: auto;
}

.biz-notification-time {
  font-size: 12px;
  color: var(--biz-notification-time-color, #888888);
}

.biz-notification-action {
  display: flex;
  align-items: center;
  font-size: 13px;
  color: var(--biz-notification-action-color, #666666);
  gap: 2px;
}

.biz-notification-action span {
  /* optional hover styling */
}
</style>
