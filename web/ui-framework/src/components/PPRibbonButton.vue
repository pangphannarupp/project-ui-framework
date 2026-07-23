<template>
  <button 
    :class="[
      'pp-ribbon-button',
      `pp-ribbon-button--${size}`,
      { 'pp-ribbon-button--active': active },
      { 'pp-ribbon-button--disabled': disabled }
    ]"
    :disabled="disabled"
    @click="$emit('click', $event)"
  >
    <span v-if="icon" class="pp-ribbon-button-icon">
      <!-- Simple placeholder for an ion-icon if ionic is present, otherwise fallback text -->
      <slot name="icon">
        <ion-icon v-if="hasIonIcon" :icon="icon"></ion-icon>
        <span v-else class="icon-fallback" v-html="iconSvg || 'Icon'"></span>
      </slot>
    </span>
    <span class="pp-ribbon-button-label">
      <slot>{{ label }}</slot>
    </span>
  </button>
</template>

<script setup lang="ts">
import { computed } from 'vue';

const props = withDefaults(defineProps<{
  label?: string;
  icon?: any; // Ion icon object or name
  iconSvg?: string; // Optional raw SVG
  size?: 'large' | 'small';
  active?: boolean;
  disabled?: boolean;
}>(), {
  size: 'large'
});

defineEmits(['click']);

const hasIonIcon = computed(() => !!props.icon && typeof props.icon !== 'string' || (typeof props.icon === 'string' && props.icon.includes('-')));
</script>

<style scoped>
.pp-ribbon-button {
  display: inline-flex;
  background: transparent;
  border: 1px solid transparent;
  border-radius: 4px;
  cursor: pointer;
  color: #374151;
  transition: background-color 0.15s, border-color 0.15s;
  font-family: inherit;
  align-items: center;
}

.pp-ribbon-button:not(.pp-ribbon-button--disabled):hover {
  background-color: #e5e7eb;
  border-color: #d1d5db;
}

.pp-ribbon-button--active {
  background-color: #dbeafe;
  border-color: #93c5fd;
  color: #1e3a8a;
}

.pp-ribbon-button--disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

/* Large Button: Stacked layout */
.pp-ribbon-button--large {
  flex-direction: column;
  justify-content: flex-start;
  min-width: 52px;
  padding: 6px 4px;
  gap: 4px;
}

.pp-ribbon-button--large .pp-ribbon-button-icon {
  font-size: 28px;
  display: flex;
  align-items: center;
  justify-content: center;
  height: 32px;
}

.pp-ribbon-button--large .pp-ribbon-button-label {
  font-size: 11px;
  text-align: center;
  line-height: 1.2;
}

/* Small Button: Horizontal layout */
.pp-ribbon-button--small {
  flex-direction: row;
  justify-content: flex-start;
  padding: 4px 6px;
  gap: 6px;
  height: 24px;
}

.pp-ribbon-button--small .pp-ribbon-button-icon {
  font-size: 16px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.pp-ribbon-button--small .pp-ribbon-button-label {
  font-size: 12px;
  white-space: nowrap;
}

.icon-fallback {
  display: inline-block;
  width: 1em;
  height: 1em;
  background: currentColor;
  mask-size: contain;
  mask-repeat: no-repeat;
  mask-position: center;
  -webkit-mask-size: contain;
  -webkit-mask-repeat: no-repeat;
  -webkit-mask-position: center;
}
</style>
