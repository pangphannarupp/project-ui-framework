<template>
  <button
    :class="['biz-segment-button', { 'biz-segment-button--active': isActive }]"
    @click="handleClick"
  >
    <span class="biz-segment-button__icon" v-if="$slots.icon">
      <slot name="icon"></slot>
    </span>
    <span class="biz-segment-button__label">
      <slot></slot>
    </span>
  </button>
</template>

<script setup lang="ts">
import { inject, computed } from 'vue';

const props = defineProps<{
  value: string | number;
}>();

const context = inject<{
  activeValue: { value: string | number },
  updateValue: (val: string | number) => void
}>('bizSegmentContext');

if (!context) {
  throw new Error('BizSegmentButton must be used within a BizSegment component');
}

const isActive = computed(() => context.activeValue.value === props.value);

const handleClick = () => {
  context.updateValue(props.value);
};
</script>

<style scoped>
.biz-segment-button {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  padding: var(--biz-segment-btn-padding, 12px 16px);
  border-radius: var(--biz-segment-btn-radius, 26px);
  border: none;
  background: var(--biz-segment-btn-bg, transparent);
  color: var(--biz-segment-btn-color, #666666);
  font-size: var(--biz-segment-btn-font-size, 14px);
  font-weight: var(--biz-segment-btn-font-weight, 500);
  cursor: pointer;
  transition: all 0.2s ease;
  white-space: nowrap;
}

.biz-segment-button--active {
  background-color: var(--biz-segment-btn-active-bg, var(--biz-primary-variant, #1a2a5e));
  color: var(--biz-segment-btn-active-color, #ffffff);
  box-shadow: var(--biz-segment-btn-active-shadow, 0 2px 4px rgba(0,0,0,0.1));
}

.biz-segment-button__icon {
  display: inline-flex;
  align-items: center;
}
.biz-segment-button__icon :deep(svg) {
  width: var(--biz-segment-icon-size, 18px);
  height: var(--biz-segment-icon-size, 18px);
  fill: currentColor;
}
</style>
