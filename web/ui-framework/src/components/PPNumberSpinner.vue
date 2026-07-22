<template>
  <div class="pp-number-spinner" :class="{ 'pp-number-spinner--disabled': disabled }">
    <button 
      class="pp-number-spinner-btn pp-number-spinner-btn--decrement" 
      @click="decrement"
      :disabled="disabled || (min !== undefined && modelValue <= min)"
    >
      <svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round">
        <line x1="5" y1="12" x2="19" y2="12"></line>
      </svg>
    </button>
    <input 
      type="number"
      class="pp-number-spinner-input"
      :value="modelValue"
      @change="onInputChange"
      :disabled="disabled"
      :min="min"
      :max="max"
      :step="step"
    />
    <button 
      class="pp-number-spinner-btn pp-number-spinner-btn--increment"
      @click="increment"
      :disabled="disabled || (max !== undefined && modelValue >= max)"
    >
      <svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round">
        <line x1="12" y1="5" x2="12" y2="19"></line>
        <line x1="5" y1="12" x2="19" y2="12"></line>
      </svg>
    </button>
  </div>
</template>

<script setup lang="ts">
const props = withDefaults(defineProps<{
  modelValue?: number;
  min?: number;
  max?: number;
  step?: number;
  disabled?: boolean;
}>(), {
  modelValue: 0,
  step: 1,
  disabled: false
});

const emit = defineEmits(['update:modelValue', 'change']);

const updateValue = (val: number) => {
  let newValue = val;
  if (props.min !== undefined && newValue < props.min) newValue = props.min;
  if (props.max !== undefined && newValue > props.max) newValue = props.max;
  
  if (newValue !== props.modelValue) {
    emit('update:modelValue', newValue);
    emit('change', newValue);
  }
};

const increment = () => {
  updateValue(props.modelValue + props.step);
};

const decrement = () => {
  updateValue(props.modelValue - props.step);
};

const onInputChange = (e: Event) => {
  const target = e.target as HTMLInputElement;
  const parsed = parseFloat(target.value);
  if (!isNaN(parsed)) {
    updateValue(parsed);
  } else {
    // Revert to old value
    target.value = props.modelValue.toString();
  }
};
</script>

<style scoped>
.pp-number-spinner {
  display: inline-flex;
  align-items: center;
  border: 1px solid #e0e0e0;
  border-radius: 8px;
  background-color: #ffffff;
  height: 48px;
  overflow: hidden;
  transition: border-color 0.2s;
}

.pp-number-spinner:focus-within {
  border-color: var(--pp-primary-variant, #1a2a5e);
}

.pp-number-spinner--disabled {
  background-color: #f5f5f5;
  border-color: #e0e0e0;
}

.pp-number-spinner-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 48px;
  height: 100%;
  background: transparent;
  border: none;
  cursor: pointer;
  color: #333333;
  transition: background-color 0.2s;
}

.pp-number-spinner-btn:hover:not(:disabled) {
  background-color: #f0f0f0;
}

.pp-number-spinner-btn:active:not(:disabled) {
  background-color: #e0e0e0;
}

.pp-number-spinner-btn:disabled {
  color: #bdbdbd;
  cursor: not-allowed;
}

.pp-number-spinner-input {
  width: 60px;
  height: 100%;
  border: none;
  border-left: 1px solid #e0e0e0;
  border-right: 1px solid #e0e0e0;
  text-align: center;
  font-size: 16px;
  font-weight: 600;
  color: #333333;
  background: transparent;
  -moz-appearance: textfield;
}

.pp-number-spinner-input:focus {
  outline: none;
}

/* Remove default up/down arrows in webkit browsers */
.pp-number-spinner-input::-webkit-outer-spin-button,
.pp-number-spinner-input::-webkit-inner-spin-button {
  -webkit-appearance: none;
  margin: 0;
}

.pp-number-spinner--disabled .pp-number-spinner-input {
  color: #888888;
}
</style>
