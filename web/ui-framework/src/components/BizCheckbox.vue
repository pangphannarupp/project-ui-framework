<template>
  <label class="biz-checkbox-label">
    <div :class="['biz-checkbox', { 'biz-checkbox--checked': isChecked }]">
      <input
        type="checkbox"
        class="biz-checkbox-input"
        :checked="isChecked"
        @change="onChange"
      />
      <svg class="biz-checkbox-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round">
        <polyline points="20 6 9 17 4 12"></polyline>
      </svg>
    </div>
    <span class="biz-checkbox-text" v-if="label || $slots.default">
      <slot>{{ label }}</slot>
    </span>
  </label>
</template>

<script setup lang="ts">
import { inject, computed, type Ref } from 'vue';

const props = defineProps<{
  modelValue?: boolean;
  value?: any;
  label?: string;
}>();

const emit = defineEmits(['update:modelValue', 'change']);

// Group support
const checkboxGroup = inject<{ 
  modelValue: Ref<any[]>; 
  updateValue: (val: any, checked: boolean) => void 
} | null>('bizCheckboxGroup', null);

const isChecked = computed(() => {
  if (checkboxGroup && props.value !== undefined) {
    return checkboxGroup.modelValue.value.includes(props.value);
  }
  return !!props.modelValue;
});

const onChange = (event: Event) => {
  const target = event.target as HTMLInputElement;
  const checked = target.checked;
  
  if (checkboxGroup && props.value !== undefined) {
    checkboxGroup.updateValue(props.value, checked);
  } else {
    emit('update:modelValue', checked);
  }
  emit('change', checked);
};
</script>

<style scoped>
.biz-checkbox-label {
  display: inline-flex;
  align-items: center;
  cursor: pointer;
  user-select: none;
}

.biz-checkbox {
  position: relative;
  width: 20px;
  height: 20px;
  border-radius: 4px;
  border: 1.5px solid #cccccc;
  background-color: #ffffff;
  transition: all 0.2s ease;
  display: flex;
  align-items: center;
  justify-content: center;
}

.biz-checkbox--checked {
  background-color: var(--biz-primary-variant, #1a2a5e);
  border-color: var(--biz-primary-variant, #1a2a5e);
}

.biz-checkbox-input {
  position: absolute;
  opacity: 0;
  width: 0;
  height: 0;
  margin: 0;
}

.biz-checkbox-icon {
  width: 14px;
  height: 14px;
  color: #ffffff;
  opacity: 0;
  transform: scale(0.5);
  transition: all 0.2s cubic-bezier(0.175, 0.885, 0.32, 1.275);
}

.biz-checkbox--checked .biz-checkbox-icon {
  opacity: 1;
  transform: scale(1);
}

.biz-checkbox-text {
  margin-left: 8px;
  font-size: 14px;
  color: #333333;
}
</style>
