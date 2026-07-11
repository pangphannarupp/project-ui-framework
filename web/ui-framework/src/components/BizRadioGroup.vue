<template>
  <div class="biz-radio-group" :class="{ 'biz-radio-group--vertical': vertical }">
    <slot></slot>
  </div>
</template>

<script setup lang="ts">
import { provide, computed } from 'vue';

const props = withDefaults(defineProps<{
  modelValue?: any;
  vertical?: boolean;
}>(), {
  vertical: false
});

const emit = defineEmits(['update:modelValue', 'change']);

const updateValue = (value: any) => {
  emit('update:modelValue', value);
  emit('change', value);
};

provide('bizRadioGroup', {
  modelValue: computed(() => props.modelValue),
  updateValue
});
</script>

<style scoped>
.biz-radio-group {
  display: flex;
  flex-wrap: wrap;
  gap: 16px;
}

.biz-radio-group--vertical {
  flex-direction: column;
  gap: 12px;
}
</style>
