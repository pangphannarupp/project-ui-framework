<template>
  <div class="pp-collapse">
    <slot></slot>
  </div>
</template>

<script setup lang="ts">
import { provide, computed } from 'vue';

const props = defineProps({
  modelValue: {
    type: [Array, String, Number],
    default: () => []
  },
  accordion: {
    type: Boolean,
    default: false
  }
});

const emit = defineEmits(['update:modelValue', 'change']);

const activeNames = computed(() => {
  return Array.isArray(props.modelValue) ? props.modelValue : (props.modelValue ? [props.modelValue] : []);
});

const handleItemClick = (name: string | number) => {
  if (props.accordion) {
    const newVal = activeNames.value[0] === name ? '' : name;
    emit('update:modelValue', newVal);
    emit('change', newVal);
  } else {
    const _activeNames = [...activeNames.value];
    const index = _activeNames.indexOf(name);
    
    if (index > -1) {
      _activeNames.splice(index, 1);
    } else {
      _activeNames.push(name);
    }
    
    emit('update:modelValue', _activeNames);
    emit('change', _activeNames);
  }
};

provide('pp-collapse', {
  activeNames,
  handleItemClick
});
</script>

<style scoped>
.pp-collapse {
  border: 1px solid var(--pp-border-color, #e0e2ec);
  border-radius: 12px;
  background-color: var(--pp-bg-color, #ffffff);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.03);
  overflow: hidden;
  display: flex;
  flex-direction: column;
}
</style>
