<template>
  <div class="biz-select-wrapper" :class="[
    `biz-select--${variant}`,
    { 'biz-select--error': error },
    { 'biz-select--disabled': disabled }
  ]">
    <label v-if="label" class="biz-select-label">
      {{ label }} <span v-if="required" class="biz-select-required">*</span>
    </label>
    
    <div :class="['biz-select-container', { 'biz-select-container--focused': isFocused }]">
      <span class="biz-select-icon biz-select-icon--left" v-if="$slots.iconLeft || iconLeft">
        <slot name="iconLeft">
          <ion-icon v-if="iconLeft" :icon="iconLeft"></ion-icon>
        </slot>
      </span>
      
      <select
        class="biz-select-input"
        :value="modelValue"
        :disabled="disabled"
        @change="onChange"
        @focus="onFocus"
        @blur="onBlur"
      >
        <option v-if="placeholder" value="" disabled hidden selected>{{ placeholder }}</option>
        <option v-for="option in options" :key="option.value" :value="option.value">
          {{ option.label }}
        </option>
        <slot></slot>
      </select>
      
      <div class="biz-select-actions">
        <span class="biz-select-icon biz-select-icon--right">
          <slot name="iconRight">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <polyline points="6 9 12 15 18 9"></polyline>
            </svg>
          </slot>
        </span>
      </div>
    </div>
    
    <div class="biz-select-helper" v-if="helperText || error">
      <span class="biz-select-message" :class="{ 'biz-select-message--error': error }">
        {{ error || helperText }}
      </span>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';

export interface SelectOption {
  label: string;
  value: string | number;
}

withDefaults(defineProps<{
  modelValue?: string | number;
  options?: SelectOption[];
  label?: string;
  placeholder?: string;
  variant?: 'outlined' | 'filled' | 'underlined';
  disabled?: boolean;
  error?: string;
  helperText?: string;
  required?: boolean;
  iconLeft?: string;
}>(), {
  modelValue: '',
  options: () => [],
  variant: 'outlined',
  disabled: false,
  required: false
});

const emit = defineEmits(['update:modelValue', 'change', 'focus', 'blur']);

const isFocused = ref(false);

const onChange = (event: Event) => {
  const target = event.target as HTMLSelectElement;
  emit('update:modelValue', target.value);
  emit('change', target.value);
};

const onFocus = (event: FocusEvent) => {
  isFocused.value = true;
  emit('focus', event);
};

const onBlur = (event: FocusEvent) => {
  isFocused.value = false;
  emit('blur', event);
};
</script>

<style scoped>
.biz-select-wrapper {
  display: flex;
  flex-direction: column;
  gap: 6px;
  margin-bottom: 16px;
  width: 100%;
}

.biz-select-label {
  font-size: 14px;
  color: #333333;
  font-weight: 500;
  display: flex;
  align-items: center;
}

.biz-select-required {
  color: #dc3545;
  margin-left: 4px;
}

.biz-select-container {
  display: flex;
  align-items: center;
  transition: all 0.2s ease-in-out;
  height: 52px;
  padding: 0 16px;
  position: relative;
}

/* OUTLINED VARIANT (Default) */
.biz-select--outlined .biz-select-container {
  border: 1px solid #cccccc;
  border-radius: 12px;
  background-color: #ffffff;
}
.biz-select--outlined .biz-select-container--focused {
  border-color: var(--biz-primary-variant, #1a2a5e);
  box-shadow: 0 0 0 2px rgba(26, 42, 94, 0.1);
}

/* FILLED VARIANT */
.biz-select--filled .biz-select-container {
  border: 1px solid transparent;
  border-radius: 8px 8px 0 0;
  background-color: #f5f5f5;
  border-bottom: 1px solid #999999;
}
.biz-select--filled .biz-select-container--focused {
  background-color: #e8e8e8;
  border-bottom-color: var(--biz-primary-variant, #1a2a5e);
  border-bottom-width: 2px;
}

/* UNDERLINED VARIANT */
.biz-select--underlined .biz-select-container {
  border: none;
  border-radius: 0;
  background-color: transparent;
  border-bottom: 1px solid #cccccc;
  padding: 0 4px;
}
.biz-select--underlined .biz-select-container--focused {
  border-bottom-color: var(--biz-primary-variant, #1a2a5e);
  border-bottom-width: 2px;
}

/* ERROR STATE */
.biz-select--error .biz-select-container {
  border-color: #dc3545 !important;
}
.biz-select--error.biz-select--underlined .biz-select-container,
.biz-select--error.biz-select--filled .biz-select-container {
  border-bottom-color: #dc3545 !important;
}
.biz-select--error .biz-select-label {
  color: #dc3545;
}

/* DISABLED STATE */
.biz-select--disabled {
  opacity: 0.6;
  cursor: not-allowed;
}
.biz-select--disabled .biz-select-container {
  background-color: #f9f9f9;
  border-color: #e0e0e0;
}
.biz-select--disabled .biz-select-input {
  cursor: not-allowed;
}

.biz-select-icon {
  display: flex;
  align-items: center;
  color: #999999;
  pointer-events: none;
}
.biz-select-icon :deep(svg),
.biz-select-icon :deep(ion-icon) {
  width: 20px;
  height: 20px;
  fill: currentColor;
}
.biz-select-icon--left {
  margin-right: 12px;
}
.biz-select-icon--right {
  margin-left: 12px;
}

.biz-select-input {
  flex: 1;
  border: none;
  outline: none;
  background: transparent;
  font-size: 16px;
  color: #333333;
  width: 100%;
  height: 100%;
  appearance: none;
  -webkit-appearance: none;
  -moz-appearance: none;
  cursor: pointer;
}
.biz-select-input:invalid {
  color: #999999;
}
.biz-select-input option {
  color: #333333;
}
.biz-select-input option[value=""][disabled] {
  display: none;
}

.biz-select-actions {
  display: flex;
  align-items: center;
  gap: 8px;
  pointer-events: none;
}

.biz-select-helper {
  font-size: 12px;
  margin-top: 2px;
}
.biz-select-message {
  color: #666666;
}
.biz-select-message--error {
  color: #dc3545;
}
</style>
