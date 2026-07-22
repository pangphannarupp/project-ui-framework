<template>
  <div class="pp-segment">
    <slot></slot>
  </div>
</template>

<script setup lang="ts">
import { provide, ref, watch } from 'vue';

const props = defineProps<{
  modelValue: string | number;
}>();

const emit = defineEmits(['update:modelValue', 'change']);

const activeValue = ref(props.modelValue);

watch(() => props.modelValue, (newVal) => {
  activeValue.value = newVal;
});

const updateValue = (val: string | number) => {
  activeValue.value = val;
  emit('update:modelValue', val);
  emit('change', val);
};

provide('bizSegmentContext', {
  activeValue,
  updateValue
});
</script>

<style scoped>
.pp-segment {
  display: flex;
  align-items: center;
  background-color: var(--pp-segment-bg, #ffffff);
  border: 1px solid var(--pp-segment-border-color, #e0e0e0);
  border-radius: var(--pp-segment-radius, 30px);
  padding: var(--pp-segment-padding, 4px);
  box-shadow: inset 0 1px 3px rgba(0,0,0,0.05);
}
</style>
