<template>
  <div class="biz-input-wrapper">
    <label v-if="label" class="biz-input-label">{{ label }}</label>
    <div :class="['biz-input-container', { 'biz-input-container--focused': isFocused }]">
      <span class="biz-input-icon biz-input-icon--left" v-if="$slots.iconLeft">
        <slot name="iconLeft"></slot>
      </span>
      <input
        class="biz-input"
        :type="inputType"
        :value="modelValue"
        :placeholder="placeholder"
        @input="onInput"
        @focus="isFocused = true"
        @blur="isFocused = false"
      />
      
      <div class="biz-input-actions" v-if="hasActions">
        <button v-if="clearable && modelValue" type="button" class="biz-input-action-btn" @click="clearInput">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <line x1="18" y1="6" x2="6" y2="18"></line>
            <line x1="6" y1="6" x2="18" y2="18"></line>
          </svg>
        </button>
        <button v-if="type === 'password'" type="button" class="biz-input-action-btn" @click="togglePasswordVisibility">
          <svg v-if="isPasswordVisible" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path>
            <circle cx="12" cy="12" r="3"></circle>
          </svg>
          <svg v-else viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24"></path>
            <line x1="1" y1="1" x2="23" y2="23"></line>
          </svg>
        </button>
        <span class="biz-input-icon biz-input-icon--right" v-if="$slots.iconRight">
          <slot name="iconRight"></slot>
        </span>
      </div>
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
  clearable?: boolean;
}>(), {
  modelValue: '',
  type: 'text',
  clearable: false
});

const emit = defineEmits(['update:modelValue']);
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
  return (props.clearable && props.modelValue) || props.type === 'password' || !!slots.iconRight;
});

const onInput = (event: Event) => {
  const target = event.target as HTMLInputElement;
  emit('update:modelValue', target.value);
};

const clearInput = () => {
  emit('update:modelValue', '');
};

const togglePasswordVisibility = () => {
  isPasswordVisible.value = !isPasswordVisible.value;
};
</script>

<style scoped>
.biz-input-wrapper {
  display: flex;
  flex-direction: column;
  gap: 8px;
  margin-bottom: 16px;
}

.biz-input-label {
  font-size: 14px;
  color: #333333;
  font-weight: 500;
}

.biz-input-container {
  display: flex;
  align-items: center;
  border: 1px solid #cccccc;
  border-radius: 12px;
  background-color: #ffffff;
  padding: 0 16px;
  transition: border-color 0.2s;
  height: 52px;
}

.biz-input-container--focused {
  border-color: var(--biz-primary-variant, #1a2a5e);
}

.biz-input-icon {
  display: flex;
  align-items: center;
  color: #999999;
}

.biz-input-icon :deep(svg) {
  width: 20px;
  height: 20px;
  fill: currentColor;
}

.biz-input-icon--left {
  margin-right: 12px;
}

.biz-input-icon--right {
  margin-left: 12px;
}

.biz-input {
  flex: 1;
  border: none;
  outline: none;
  background: transparent;
  font-size: 16px;
  color: #333333;
  width: 100%;
  height: 100%;
}

.biz-input::placeholder {
  color: #999999;
}

.biz-input-actions {
  display: flex;
  align-items: center;
  gap: 8px;
}

.biz-input-action-btn {
  background: transparent;
  border: none;
  padding: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #999999;
  cursor: pointer;
}

.biz-input-action-btn svg {
  width: 20px;
  height: 20px;
}

.biz-input-action-btn:hover {
  color: #666666;
}
</style>
