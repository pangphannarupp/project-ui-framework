<template>
  <div class="pp-switch-wrapper" :class="[`variant-${variant}`, { 'is-disabled': disabled }]">
    <ion-toggle
      class="pp-switch"
      :checked="modelValue"
      :disabled="disabled"
      :color="color"
      :mode="mode"
      @ionChange="onChange"
    >
      <!-- Label on the left or right can be passed via slot -->
      <span class="pp-switch-label" v-if="label">{{ label }}</span>
      <slot></slot>
    </ion-toggle>
  </div>
</template>

<script setup lang="ts">
import { IonToggle } from '@ionic/vue';

withDefaults(defineProps<{
  modelValue?: boolean;
  disabled?: boolean;
  color?: 'primary' | 'secondary' | 'tertiary' | 'success' | 'warning' | 'danger' | 'light' | 'medium' | 'dark';
  label?: string;
  variant?: 'standard' | 'm3' | 'icon';
  mode?: 'ios' | 'md';
}>(), {
  modelValue: false,
  disabled: false,
  color: 'primary',
  variant: 'standard'
});

const emit = defineEmits(['update:modelValue', 'change']);

const onChange = (e: any) => {
  emit('update:modelValue', e.detail.checked);
  emit('change', e.detail.checked);
};
</script>

<style scoped>
.pp-switch-wrapper {
  display: inline-flex;
  align-items: center;
}

.pp-switch-label {
  font-size: 16px;
  color: var(--pp-primary-variant, #1a2a5e);
  margin-right: 16px;
}

.pp-switch {
  --track-background: #e0e0e0;
  --track-background-checked: var(--pp-primary, #003399);
}

/* Material 3 Variant */
.variant-m3 .pp-switch {
  --track-background: #e0e0e0;
  --track-background-checked: var(--pp-primary, #003399);
  --handle-background: var(--pp-primary-variant, #1a2a5e);
  --handle-background-checked: #ffffff;
  --handle-width: 24px;
  --handle-height: 24px;
  --handle-spacing: 4px;
  --handle-box-shadow: none;
}

.variant-m3 .pp-switch::part(track) {
  height: 32px;
  width: 52px;
  border-radius: 16px;
  border: 2px solid transparent;
}

.variant-m3 .pp-switch:not(.toggle-checked)::part(track) {
  border-color: #757575;
}

.variant-m3 .pp-switch:not(.toggle-checked)::part(handle) {
  background: #757575;
  transform: scale(0.66);
}

/* Icon Variant */
.variant-icon .pp-switch::part(handle) {
  display: flex;
  align-items: center;
  justify-content: center;
}
.variant-icon .pp-switch::part(handle)::after {
  content: '';
  display: block;
  width: 12px;
  height: 12px;
  background-size: contain;
  background-repeat: no-repeat;
  background-position: center;
  transition: 0.2s all ease-in-out;
}

.variant-icon .pp-switch:not(.toggle-checked)::part(handle)::after {
  /* Cross icon URL encoded SVG */
  background-image: url("data:image/svg+xml;charset=utf-8,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512'%3E%3Cpath fill='%23757575' d='M289.9 256l95-95A24 24 0 00351 127l-95 95-95-95a24 24 0 00-34 34l95 95-95 95a24 24 0 1034 34l95-95 95 95a24 24 0 0034-34z'/%3E%3C/svg%3E");
}

.variant-icon .pp-switch.toggle-checked::part(handle)::after {
  /* Check icon URL encoded SVG */
  background-image: url("data:image/svg+xml;charset=utf-8,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 512 512'%3E%3Cpath fill='%23003399' d='M416 128L192 384l-96-96' stroke='%23003399' stroke-width='48' stroke-linecap='round' stroke-linejoin='round'/%3E%3C/svg%3E");
}

.is-disabled {
  opacity: 0.5;
  pointer-events: none;
}
</style>
