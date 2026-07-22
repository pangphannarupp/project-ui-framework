<template>
  <div class="pp-checkbox-group" :class="{ 'pp-checkbox-group--vertical': vertical }">
    <slot></slot>
  </div>
</template>

<script setup lang="ts">
import { provide, computed } from 'vue';

const props = withDefaults(defineProps<{
  modelValue?: any[];
  vertical?: boolean;
}>(), {
  modelValue: () => [],
  vertical: false
});

const emit = defineEmits(['update:modelValue', 'change']);

const updateValue = (value: any, checked: boolean) => {
  const newValue = [...props.modelValue];
  const index = newValue.indexOf(value);
  
  if (checked && index === -1) {
    newValue.push(value);
  } else if (!checked && index !== -1) {
    newValue.splice(index, 1);
  }
  
  emit('update:modelValue', newValue);
  emit('change', newValue);
};

provide('bizCheckboxGroup', {
  modelValue: computed(() => props.modelValue),
  updateValue
});
</script>

<style scoped>
.pp-checkbox-group {
  display: flex;
  flex-wrap: wrap;
  gap: 16px;
}

.pp-checkbox-group--vertical {
  flex-direction: column;
  gap: 12px;
}
</style>
