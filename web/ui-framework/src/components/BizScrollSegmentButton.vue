<template>
  <button 
    class="biz-scroll-segment-btn" 
    :class="{ active: isActive }"
    @click="$emit('click')"
  >
    <span class="btn-icon" v-if="$slots.icon">
      <slot name="icon"></slot>
    </span>
    <slot></slot>
  </button>
</template>

<script setup lang="ts">
defineProps({
  isActive: {
    type: Boolean,
    default: false
  }
});

defineEmits(['click']);
</script>

<style scoped>
.biz-scroll-segment-btn {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  white-space: nowrap;
  padding: var(--biz-scroll-segment-btn-padding, 8px 16px);
  border-radius: var(--biz-scroll-segment-btn-radius, 20px);
  border: 1px solid var(--biz-scroll-segment-btn-border-color, #eaeaea);
  background-color: var(--biz-scroll-segment-btn-bg, white);
  color: var(--biz-scroll-segment-btn-color, #3b63cc);
  font-size: var(--biz-scroll-segment-btn-font-size, 13px);
  font-weight: 600;
  cursor: pointer;
  transition: all 0.2s;
  box-shadow: var(--biz-scroll-segment-btn-shadow, 0 1px 2px rgba(0,0,0,0.02));
  flex-shrink: 0;
}

.biz-scroll-segment-btn.active {
  background-color: var(--biz-scroll-segment-btn-active-bg, var(--biz-primary-variant, #1a2a5e));
  border-color: var(--biz-scroll-segment-btn-active-border-color, var(--biz-primary-variant, #1a2a5e));
  color: var(--biz-scroll-segment-btn-active-color, white);
}

:deep(.btn-icon) {
  display: flex;
  align-items: center;
  justify-content: center;
}

:deep(.btn-icon svg) { 
  width: 14px; 
  height: 14px; 
}
</style>
