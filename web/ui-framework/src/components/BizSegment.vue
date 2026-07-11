<template>
  <div class="biz-segment">
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
.biz-segment {
  display: flex;
  align-items: center;
  background-color: var(--biz-segment-bg, #ffffff);
  border: 1px solid var(--biz-segment-border-color, #e0e0e0);
  border-radius: var(--biz-segment-radius, 30px);
  padding: var(--biz-segment-padding, 4px);
  box-shadow: inset 0 1px 3px rgba(0,0,0,0.05);
}
</style>
