<template>
  <button
    class="pp-toggle-btn"
    :class="[
      `pp-toggle-btn--${variant}`,
      `pp-toggle-btn--${size}`,
      { 'is-active': modelValue },
      { 'is-disabled': disabled },
      { 'is-icon-only': iconOnly }
    ]"
    :disabled="disabled"
    @click="toggle"
    type="button"
  >
    <span class="pp-toggle-btn-icon" v-if="$slots.icon || icon">
      <slot name="icon">
        <IonIcon v-if="icon" :icon="icon"></IonIcon>
      </slot>
    </span>
    <span class="pp-toggle-btn-content" v-if="!iconOnly">
      <slot>{{ label }}</slot>
    </span>
  </button>
</template>

<script setup lang="ts">
import { IonIcon } from '@ionic/vue';

const props = withDefaults(defineProps<{
  modelValue?: boolean;
  variant?: 'solid' | 'outline' | 'text';
  size?: 'small' | 'medium' | 'large';
  disabled?: boolean;
  iconOnly?: boolean;
  label?: string;
  icon?: string;
}>(), {
  modelValue: false,
  variant: 'outline',
  size: 'medium',
  disabled: false,
  iconOnly: false
});

const emit = defineEmits(['update:modelValue', 'change']);

const toggle = () => {
  if (props.disabled) return;
  const newValue = !props.modelValue;
  emit('update:modelValue', newValue);
  emit('change', newValue);
};
</script>

<style scoped>
.pp-toggle-btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  border-radius: 8px;
  font-family: inherit;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.2s ease;
  box-sizing: border-box;
  outline: none;
}

.pp-toggle-btn.is-disabled {
  opacity: 0.5;
  cursor: not-allowed;
  pointer-events: none;
}

/* --- SIZES --- */
.pp-toggle-btn--small {
  height: 32px;
  padding: 0 12px;
  font-size: 13px;
}
.pp-toggle-btn--small.is-icon-only {
  width: 32px;
  padding: 0;
}

.pp-toggle-btn--medium {
  height: 40px;
  padding: 0 16px;
  font-size: 14px;
}
.pp-toggle-btn--medium.is-icon-only {
  width: 40px;
  padding: 0;
}

.pp-toggle-btn--large {
  height: 48px;
  padding: 0 20px;
  font-size: 16px;
}
.pp-toggle-btn--large.is-icon-only {
  width: 48px;
  padding: 0;
}

/* --- VARIANTS --- */

/* OUTLINE */
.pp-toggle-btn--outline {
  background: transparent;
  border: 1px solid #cccccc;
  color: #333333;
}
.pp-toggle-btn--outline:hover:not(.is-disabled) {
  background: #f5f5f5;
}
.pp-toggle-btn--outline.is-active {
  background: rgba(26, 42, 94, 0.1);
  border-color: var(--pp-primary-variant, #1a2a5e);
  color: var(--pp-primary-variant, #1a2a5e);
}

/* SOLID */
.pp-toggle-btn--solid {
  background: #f0f0f0;
  border: 1px solid transparent;
  color: #555555;
}
.pp-toggle-btn--solid:hover:not(.is-disabled) {
  background: #e0e0e0;
}
.pp-toggle-btn--solid.is-active {
  background: var(--pp-primary-variant, #1a2a5e);
  color: #ffffff;
}

/* TEXT */
.pp-toggle-btn--text {
  background: transparent;
  border: 1px solid transparent;
  color: #555555;
}
.pp-toggle-btn--text:hover:not(.is-disabled) {
  background: rgba(0, 0, 0, 0.05);
}
.pp-toggle-btn--text.is-active {
  background: rgba(26, 42, 94, 0.1);
  color: var(--pp-primary-variant, #1a2a5e);
}

.pp-toggle-btn-icon {
  display: flex;
  align-items: center;
  justify-content: center;
}

.pp-toggle-btn-icon :deep(svg),
.pp-toggle-btn-icon :deep(ion-icon) {
  width: 1.2em;
  height: 1.2em;
  fill: currentColor;
}
</style>
