<template>
  <label class="pp-radio-label">
    <div :class="['pp-radio', { 'pp-radio--checked': isChecked }]">
      <input
        type="radio"
        class="pp-radio-input"
        :checked="isChecked"
        :value="value"
        :name="name"
        @change="onChange"
      />
      <div class="pp-radio-inner"></div>
    </div>
    <span class="pp-radio-text" v-if="label || $slots.default">
      <slot>{{ label }}</slot>
    </span>
  </label>
</template>

<script setup lang="ts">
import { inject, computed, type Ref } from 'vue';

const props = defineProps<{
  modelValue?: any;
  value?: any;
  label?: string;
  name?: string;
}>();

const emit = defineEmits(['update:modelValue', 'change']);

// Group support
const radioGroup = inject<{ 
  modelValue: Ref<any>; 
  updateValue: (val: any) => void 
} | null>('ppRadioGroup', null);

const isChecked = computed(() => {
  if (radioGroup && props.value !== undefined) {
    return radioGroup.modelValue.value === props.value;
  }
  return props.modelValue === props.value;
});

const onChange = () => {
  if (radioGroup && props.value !== undefined) {
    radioGroup.updateValue(props.value);
  } else {
    emit('update:modelValue', props.value);
  }
  emit('change', props.value);
};
</script>

<style scoped>
.pp-radio-label {
  display: inline-flex;
  align-items: center;
  cursor: pointer;
  user-select: none;
}

.pp-radio {
  position: relative;
  width: 20px;
  height: 20px;
  border-radius: 50%;
  border: 1.5px solid #cccccc;
  background-color: #ffffff;
  transition: all 0.2s ease;
  display: flex;
  align-items: center;
  justify-content: center;
}

.pp-radio--checked {
  border-color: var(--pp-primary-variant, #1a2a5e);
}

.pp-radio-input {
  position: absolute;
  opacity: 0;
  width: 0;
  height: 0;
  margin: 0;
}

.pp-radio-inner {
  width: 10px;
  height: 10px;
  border-radius: 50%;
  background-color: var(--pp-primary-variant, #1a2a5e);
  opacity: 0;
  transform: scale(0.5);
  transition: all 0.2s cubic-bezier(0.175, 0.885, 0.32, 1.275);
}

.pp-radio--checked .pp-radio-inner {
  opacity: 1;
  transform: scale(1);
}

.pp-radio-text {
  margin-left: 8px;
  font-size: 14px;
  color: #333333;
}
</style>
