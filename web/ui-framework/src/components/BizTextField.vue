<template>
  <div class="biz-text-field-wrapper" :class="[
    `biz-text-field--${variant}`,
    { 'biz-text-field--error': error },
    { 'biz-text-field--disabled': disabled }
  ]">
    <label v-if="label" class="biz-text-field-label">
      {{ label }} <span v-if="required" class="biz-text-field-required">*</span>
    </label>
    
    <div :class="['biz-text-field-container', { 'biz-text-field-container--focused': isFocused }]">
      <span class="biz-text-field-icon biz-text-field-icon--left" v-if="$slots.iconLeft || iconLeft">
        <slot name="iconLeft">
          <ion-icon v-if="iconLeft" :icon="iconLeft"></ion-icon>
        </slot>
      </span>
      
      <input
        class="biz-text-field-input"
        :type="inputType"
        :value="modelValue"
        :placeholder="placeholder"
        :disabled="disabled"
        :readonly="readonly"
        @input="onInput"
        @focus="onFocus"
        @blur="onBlur"
      />
      
      <div class="biz-text-field-actions" v-if="hasActions">
        <button v-if="clearable && modelValue && !disabled && !readonly" type="button" class="biz-text-field-action-btn" @click="clearInput">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <line x1="18" y1="6" x2="6" y2="18"></line>
            <line x1="6" y1="6" x2="18" y2="18"></line>
          </svg>
        </button>
        <button v-if="type === 'password' && !disabled" type="button" class="biz-text-field-action-btn" @click="togglePasswordVisibility">
          <svg v-if="isPasswordVisible" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path>
            <circle cx="12" cy="12" r="3"></circle>
          </svg>
          <svg v-else viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24"></path>
            <line x1="1" y1="1" x2="23" y2="23"></line>
          </svg>
        </button>
        <span class="biz-text-field-icon biz-text-field-icon--right" v-if="$slots.iconRight || iconRight">
          <slot name="iconRight">
            <ion-icon v-if="iconRight" :icon="iconRight"></ion-icon>
          </slot>
        </span>
      </div>
    </div>
    
    <div class="biz-text-field-helper" v-if="helperText || error">
      <span class="biz-text-field-message" :class="{ 'biz-text-field-message--error': error }">
        {{ error || helperText }}
      </span>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, useSlots } from 'vue';

const props = withDefaults(defineProps<{
  modelValue?: string | number;
  label?: string;
  type?: string;
  placeholder?: string;
  variant?: 'outlined' | 'filled' | 'underlined';
  clearable?: boolean;
  disabled?: boolean;
  readonly?: boolean;
  error?: string;
  helperText?: string;
  required?: boolean;
  iconLeft?: string;
  iconRight?: string;
}>(), {
  modelValue: '',
  type: 'text',
  variant: 'outlined',
  clearable: false,
  disabled: false,
  readonly: false,
  required: false
});

const emit = defineEmits(['update:modelValue', 'focus', 'blur']);
const slots = useSlots();

const isFocused = ref(false);
const isPasswordVisible = ref(false);

const inputType = computed(() => {
  if (props.type === 'password') {
    return isPasswordVisible.value ? 'text' : 'password';
  }
  return props.type;
});

const hasActions = computed(() => {
  return (props.clearable && props.modelValue) || props.type === 'password' || !!slots.iconRight || !!props.iconRight;
});

const onInput = (event: Event) => {
  const target = event.target as HTMLInputElement;
  emit('update:modelValue', target.value);
};

const onFocus = (event: FocusEvent) => {
  isFocused.value = true;
  emit('focus', event);
};

const onBlur = (event: FocusEvent) => {
  isFocused.value = false;
  emit('blur', event);
};

const clearInput = () => {
  emit('update:modelValue', '');
};

const togglePasswordVisibility = () => {
  isPasswordVisible.value = !isPasswordVisible.value;
};
</script>

<style scoped>
.biz-text-field-wrapper {
  display: flex;
  flex-direction: column;
  gap: 6px;
  margin-bottom: 16px;
  width: 100%;
}

.biz-text-field-label {
  font-size: 14px;
  color: #333333;
  font-weight: 500;
  display: flex;
  align-items: center;
}

.biz-text-field-required {
  color: #dc3545;
  margin-left: 4px;
}

.biz-text-field-container {
  display: flex;
  align-items: center;
  transition: all 0.2s ease-in-out;
  height: 52px;
  padding: 0 16px;
}

/* OUTLINED VARIANT (Default) */
.biz-text-field--outlined .biz-text-field-container {
  border: 1px solid #cccccc;
  border-radius: 12px;
  background-color: #ffffff;
}
.biz-text-field--outlined .biz-text-field-container--focused {
  border-color: var(--biz-primary-variant, #1a2a5e);
  box-shadow: 0 0 0 2px rgba(26, 42, 94, 0.1);
}

/* FILLED VARIANT */
.biz-text-field--filled .biz-text-field-container {
  border: 1px solid transparent;
  border-radius: 8px 8px 0 0;
  background-color: #f5f5f5;
  border-bottom: 1px solid #999999;
}
.biz-text-field--filled .biz-text-field-container--focused {
  background-color: #e8e8e8;
  border-bottom-color: var(--biz-primary-variant, #1a2a5e);
  border-bottom-width: 2px;
}

/* UNDERLINED VARIANT */
.biz-text-field--underlined .biz-text-field-container {
  border: none;
  border-radius: 0;
  background-color: transparent;
  border-bottom: 1px solid #cccccc;
  padding: 0 4px;
}
.biz-text-field--underlined .biz-text-field-container--focused {
  border-bottom-color: var(--biz-primary-variant, #1a2a5e);
  border-bottom-width: 2px;
}

/* ERROR STATE */
.biz-text-field--error .biz-text-field-container {
  border-color: #dc3545 !important;
}
.biz-text-field--error.biz-text-field--underlined .biz-text-field-container,
.biz-text-field--error.biz-text-field--filled .biz-text-field-container {
  border-bottom-color: #dc3545 !important;
}
.biz-text-field--error .biz-text-field-label {
  color: #dc3545;
}

/* DISABLED STATE */
.biz-text-field--disabled {
  opacity: 0.6;
  cursor: not-allowed;
}
.biz-text-field--disabled .biz-text-field-container {
  background-color: #f9f9f9;
  border-color: #e0e0e0;
}
.biz-text-field--disabled .biz-text-field-input {
  cursor: not-allowed;
}

.biz-text-field-icon {
  display: flex;
  align-items: center;
  color: #999999;
}
.biz-text-field-icon :deep(svg),
.biz-text-field-icon :deep(ion-icon) {
  width: 20px;
  height: 20px;
  fill: currentColor;
}
.biz-text-field-icon--left {
  margin-right: 12px;
}
.biz-text-field-icon--right {
  margin-left: 12px;
}

.biz-text-field-input {
  flex: 1;
  border: none;
  outline: none;
  background: transparent;
  font-size: 16px;
  color: #333333;
  width: 100%;
  height: 100%;
}
.biz-text-field-input::placeholder {
  color: #999999;
}

.biz-text-field-actions {
  display: flex;
  align-items: center;
  gap: 8px;
}
.biz-text-field-action-btn {
  background: transparent;
  border: none;
  padding: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #999999;
  cursor: pointer;
  outline: none;
}
.biz-text-field-action-btn svg {
  width: 20px;
  height: 20px;
}
.biz-text-field-action-btn:hover {
  color: #666666;
}

.biz-text-field-helper {
  font-size: 12px;
  margin-top: 2px;
}
.biz-text-field-message {
  color: #666666;
}
.biz-text-field-message--error {
  color: #dc3545;
}
</style>
