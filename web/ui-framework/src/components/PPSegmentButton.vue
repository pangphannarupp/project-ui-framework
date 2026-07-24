<template>
  <button
    :class="['pp-segment-button', { 'pp-segment-button--active': isActive }]"
    @click="handleClick"
  >
    <span class="pp-segment-button__icon" v-if="$slots.icon">
      <slot name="icon"></slot>
    </span>
    <span class="pp-segment-button__label">
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
}>('ppSegmentContext');

if (!context) {
  throw new Error('PPSegmentButton must be used within a PPSegment component');
}

const isActive = computed(() => context.activeValue.value === props.value);

const handleClick = () => {
  context.updateValue(props.value);
};
</script>

<style scoped>
.pp-segment-button {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  padding: var(--pp-segment-btn-padding, 12px 16px);
  border-radius: var(--pp-segment-btn-radius, 26px);
  border: none;
  background: var(--pp-segment-btn-bg, transparent);
  color: var(--pp-segment-btn-color, #666666);
  font-size: var(--pp-segment-btn-font-size, 14px);
  font-weight: var(--pp-segment-btn-font-weight, 500);
  cursor: pointer;
  transition: all 0.2s ease;
  white-space: nowrap;
}

.pp-segment-button--active {
  background-color: var(--pp-segment-btn-active-bg, var(--pp-primary-variant, #1a2a5e));
  color: var(--pp-segment-btn-active-color, #ffffff);
  box-shadow: var(--pp-segment-btn-active-shadow, 0 2px 4px rgba(0,0,0,0.1));
}

.pp-segment-button__icon {
  display: inline-flex;
  align-items: center;
}
.pp-segment-button__icon :deep(svg) {
  width: var(--pp-segment-icon-size, 18px);
  height: var(--pp-segment-icon-size, 18px);
  fill: currentColor;
}
</style>
