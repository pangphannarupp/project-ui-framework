<template>
  <div class="pp-tabs" :class="[`pp-tabs--${variant}`]">
    <slot></slot>
  </div>
</template>

<script setup lang="ts">
import { provide, ref, watch } from 'vue';

const props = withDefaults(defineProps<{
  modelValue?: string | number;
  variant?: 'standard' | 'pills' | 'segmented' | 'outlined' | 'minimal';
}>(), {
  modelValue: '',
  variant: 'standard'
});

const emit = defineEmits(['update:modelValue', 'change']);

const activeTab = ref(props.modelValue);

watch(() => props.modelValue, (newVal) => {
  activeTab.value = newVal;
});

const setActiveTab = (val: string | number) => {
  activeTab.value = val;
  emit('update:modelValue', val);
  emit('change', val);
};

provide('ppTabsContext', {
  activeTab,
  setActiveTab,
  variant: props.variant
});
</script>

<style scoped>
.pp-tabs {
  display: flex;
  flex-direction: column;
  width: 100%;
}
</style>
