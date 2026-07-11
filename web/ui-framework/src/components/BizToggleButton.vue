<template>
  <button
    class="biz-toggle-btn"
    :class="[
      `biz-toggle-btn--${variant}`,
      `biz-toggle-btn--${size}`,
      { 'is-active': modelValue },
      { 'is-disabled': disabled },
      { 'is-icon-only': iconOnly }
    ]"
    :disabled="disabled"
    @click="toggle"
    type="button"
  >
    <span class="biz-toggle-btn-icon" v-if="$slots.icon || icon">
      <slot name="icon">
        <ion-icon v-if="icon" :icon="icon"></ion-icon>
      </slot>
    </span>
    <span class="biz-toggle-btn-content" v-if="!iconOnly">
      <slot>{{ label }}</slot>
    </span>
  </button>
</template>

<script setup lang="ts">
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
.biz-toggle-btn {
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

.biz-toggle-btn.is-disabled {
  opacity: 0.5;
  cursor: not-allowed;
  pointer-events: none;
}

/* --- SIZES --- */
.biz-toggle-btn--small {
  height: 32px;
  padding: 0 12px;
  font-size: 13px;
}
.biz-toggle-btn--small.is-icon-only {
  width: 32px;
  padding: 0;
}

.biz-toggle-btn--medium {
  height: 40px;
  padding: 0 16px;
  font-size: 14px;
}
.biz-toggle-btn--medium.is-icon-only {
  width: 40px;
  padding: 0;
}

.biz-toggle-btn--large {
  height: 48px;
  padding: 0 20px;
  font-size: 16px;
}
.biz-toggle-btn--large.is-icon-only {
  width: 48px;
  padding: 0;
}

/* --- VARIANTS --- */

/* OUTLINE */
.biz-toggle-btn--outline {
  background: transparent;
  border: 1px solid #cccccc;
  color: #333333;
}
.biz-toggle-btn--outline:hover:not(.is-disabled) {
  background: #f5f5f5;
}
.biz-toggle-btn--outline.is-active {
  background: rgba(26, 42, 94, 0.1);
  border-color: var(--biz-primary-variant, #1a2a5e);
  color: var(--biz-primary-variant, #1a2a5e);
}

/* SOLID */
.biz-toggle-btn--solid {
  background: #f0f0f0;
  border: 1px solid transparent;
  color: #555555;
}
.biz-toggle-btn--solid:hover:not(.is-disabled) {
  background: #e0e0e0;
}
.biz-toggle-btn--solid.is-active {
  background: var(--biz-primary-variant, #1a2a5e);
  color: #ffffff;
}

/* TEXT */
.biz-toggle-btn--text {
  background: transparent;
  border: 1px solid transparent;
  color: #555555;
}
.biz-toggle-btn--text:hover:not(.is-disabled) {
  background: rgba(0, 0, 0, 0.05);
}
.biz-toggle-btn--text.is-active {
  background: rgba(26, 42, 94, 0.1);
  color: var(--biz-primary-variant, #1a2a5e);
}

.biz-toggle-btn-icon {
  display: flex;
  align-items: center;
  justify-content: center;
}

.biz-toggle-btn-icon :deep(svg),
.biz-toggle-btn-icon :deep(ion-icon) {
  width: 1.2em;
  height: 1.2em;
  fill: currentColor;
}
</style>
