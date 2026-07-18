<template>
  <div class="biz-collapse">
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

provide('biz-collapse', {
  activeNames,
  handleItemClick
});
</script>

<style scoped>
.biz-collapse {
  border-top: 1px solid var(--biz-border-color, #e0e2ec);
  border-bottom: 1px solid var(--biz-border-color, #e0e2ec);
  border-radius: 0;
  display: flex;
  flex-direction: column;
}
</style>
