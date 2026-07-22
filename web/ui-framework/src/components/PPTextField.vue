<template>
  <div class="pp-text-field-wrapper" :class="[
    `pp-text-field--${variant}`,
    { 'pp-text-field--error': error },
    { 'pp-text-field--disabled': disabled }
  ]">
    <label v-if="label" class="pp-text-field-label">
      {{ label }} <span v-if="required" class="pp-text-field-required">*</span>
    </label>
    
    <div :class="['pp-text-field-container', { 'pp-text-field-container--focused': isFocused }]">
      <span class="pp-text-field-icon pp-text-field-icon--left" v-if="$slots.iconLeft || iconLeft">
        <slot name="iconLeft">
          <ion-icon v-if="iconLeft" :icon="iconLeft"></ion-icon>
        </slot>
      </span>
      
      <input
        class="pp-text-field-input"
        :type="inputType"
        :value="modelValue"
        :placeholder="placeholder"
        :disabled="disabled"
        :readonly="readonly"
        @input="onInput"
        @focus="onFocus"
        @blur="onBlur"
      />
      
      <div class="pp-text-field-actions" v-if="hasActions">
        <button v-if="clearable && modelValue && !disabled && !readonly" type="button" class="pp-text-field-action-btn" @click="clearInput">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <line x1="18" y1="6" x2="6" y2="18"></line>
            <line x1="6" y1="6" x2="18" y2="18"></line>
          </svg>
        </button>
        <button v-if="type === 'password' && !disabled" type="button" class="pp-text-field-action-btn" @click="togglePasswordVisibility">
          <svg v-if="isPasswordVisible" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path>
            <circle cx="12" cy="12" r="3"></circle>
          </svg>
          <svg v-else viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24"></path>
            <line x1="1" y1="1" x2="23" y2="23"></line>
          </svg>
        </button>
        <span class="pp-text-field-icon pp-text-field-icon--right" v-if="$slots.iconRight || iconRight">
          <slot name="iconRight">
            <ion-icon v-if="iconRight" :icon="iconRight"></ion-icon>
          </slot>
        </span>
      </div>
    </div>
    
    <div class="pp-text-field-helper" v-if="helperText || error">
      <span class="pp-text-field-message" :class="{ 'pp-text-field-message--error': error }">
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
  variant?: 'outlined' | 'filled';
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
.pp-text-field-wrapper {
  display: flex;
  flex-direction: column;
  gap: 6px;
  margin-bottom: 16px;
  width: 100%;
}

.pp-text-field-label {
  font-size: 14px;
  color: #333333;
  font-weight: 500;
  display: flex;
  align-items: center;
}

.pp-text-field-required {
  color: #dc3545;
  margin-left: 4px;
}

.pp-text-field-container {
  display: flex;
  align-items: center;
  transition: all 0.2s ease-in-out;
  height: 52px;
  padding: 0 16px;
}

/* OUTLINED VARIANT (Default) */
.pp-text-field--outlined .pp-text-field-container {
  border: 1px solid #cccccc;
  border-radius: 12px;
  background-color: #ffffff;
}
.pp-text-field--outlined .pp-text-field-container--focused {
  border-color: var(--pp-primary-variant, #1a2a5e);
  box-shadow: 0 0 0 2px rgba(26, 42, 94, 0.1);
}

/* FILLED VARIANT */
.pp-text-field--filled .pp-text-field-container {
  border: 1px solid transparent;
  border-radius: 12px;
  background-color: #f5f5f5;
}
.pp-text-field--filled .pp-text-field-container--focused {
  background-color: #ffffff;
  border-color: var(--pp-primary-variant, #1a2a5e);
  box-shadow: 0 0 0 2px rgba(26, 42, 94, 0.1);
}

/* ERROR STATE */
.pp-text-field--error .pp-text-field-container {
  border-color: #dc3545 !important;
}
.pp-text-field--error .pp-text-field-label {
  color: #dc3545;
}

/* DISABLED STATE */
.pp-text-field--disabled {
  opacity: 0.6;
  cursor: not-allowed;
}
.pp-text-field--disabled .pp-text-field-container {
  background-color: #f9f9f9;
  border-color: #e0e0e0;
}
.pp-text-field--disabled .pp-text-field-input {
  cursor: not-allowed;
}

.pp-text-field-icon {
  display: flex;
  align-items: center;
  color: #999999;
}
.pp-text-field-icon :deep(svg),
.pp-text-field-icon :deep(ion-icon) {
  width: 20px;
  height: 20px;
  fill: currentColor;
}
.pp-text-field-icon--left {
  margin-right: 12px;
}
.pp-text-field-icon--right {
  margin-left: 12px;
}

.pp-text-field-input {
  flex: 1;
  border: none;
  outline: none;
  background: transparent;
  font-size: 16px;
  color: #333333;
  width: 100%;
  height: 100%;
}
.pp-text-field-input::placeholder {
  color: #999999;
}

.pp-text-field-actions {
  display: flex;
  align-items: center;
  gap: 8px;
}
.pp-text-field-action-btn {
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
.pp-text-field-action-btn svg {
  width: 20px;
  height: 20px;
}
.pp-text-field-action-btn:hover {
  color: #666666;
}

.pp-text-field-helper {
  font-size: 12px;
  margin-top: 2px;
}
.pp-text-field-message {
  color: #666666;
}
.pp-text-field-message--error {
  color: #dc3545;
}
</style>
