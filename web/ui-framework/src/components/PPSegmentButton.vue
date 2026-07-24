<template>
  <button
    :class="['pp-segment-button', `variant-${variant}`, { 'pp-segment-button--active': isActive }]"
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
  updateValue: (val: string | number) => void,
  variant: string
}>('ppSegmentContext');

if (!context) {
  throw new Error('PPSegmentButton must be used within a PPSegment component');
}

const variant = computed(() => context.variant || 'pill');
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
  border: none;
  font-size: var(--pp-segment-btn-font-size, 14px);
  font-weight: var(--pp-segment-btn-font-weight, 500);
  cursor: pointer;
  transition: color 0.3s ease;
  white-space: nowrap;
  background: transparent; /* Background is handled by the indicator in the parent */
}

/* Variant: Pill */
.pp-segment-button.variant-pill {
  padding: var(--pp-segment-btn-padding, 12px 16px);
  border-radius: var(--pp-segment-btn-radius, 26px);
  color: var(--pp-segment-btn-color, #666666);
}
.pp-segment-button.variant-pill.pp-segment-button--active {
  color: var(--pp-segment-btn-active-color, #ffffff);
}

/* Variant: Underline */
.pp-segment-button.variant-underline {
  padding: 12px 4px;
  color: #64748b;
  border-bottom: 2px solid transparent;
  margin-bottom: -2px; /* Pull down to overlap parent border */
}
.pp-segment-button.variant-underline.pp-segment-button--active {
  color: var(--pp-primary, #3b82f6);
  border-bottom: 2px solid var(--pp-primary, #3b82f6);
}
.pp-segment-button.variant-underline:hover:not(.pp-segment-button--active) {
  color: #334155;
  border-bottom: 2px solid #cbd5e1;
}

/* Variant: Block */
.pp-segment-button.variant-block {
  padding: 8px 16px;
  border-radius: 6px;
  color: #475569;
}
.pp-segment-button.variant-block.pp-segment-button--active {
  color: #0f172a;
}
.pp-segment-button.variant-block:hover:not(.pp-segment-button--active) {
  color: #334155;
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

/* Variant: Material UI 3 */
.pp-segment-button.variant-material3 {
  padding: 10px 16px;
  border-radius: 30px;
  color: #4b5563; /* On-surface variant M3 */
}
.pp-segment-button.variant-material3.pp-segment-button--active {
  color: #004085; /* On-primary-container M3 */
  font-weight: 600;
}
.pp-segment-button.variant-material3:hover:not(.pp-segment-button--active) {
  color: #1f2937;
  background-color: rgba(0,0,0,0.04); /* Hover state */
}

/* Variant: iOS Liquid Glass */
.pp-segment-button.variant-ios-glass {
  padding: 6px 16px;
  border-radius: 18px;
  color: rgba(0, 0, 0, 0.6);
  font-size: 13px;
  font-weight: 600;
}
.pp-segment-button.variant-ios-glass.pp-segment-button--active {
  color: #000000;
}
.pp-segment-button.variant-ios-glass:hover:not(.pp-segment-button--active) {
  color: rgba(0, 0, 0, 0.8);
}
</style>
