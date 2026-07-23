<template>
  <PPBottomSheet 
    :modelValue="modelValue"
    @update:modelValue="$emit('update:modelValue', $event)"
  >
    <PPTimePicker 
      :title="title"
      :modelValue="timeValue"
      :min="min"
      :max="max"
      :minuteValues="minuteValues"
      :hourCycle="hourCycle"
      :showActionButtons="showActionButtons"
      :theme="theme"
      @update:modelValue="onTimeUpdate"
      @change="(val) => $emit('change', val)"
      @confirm="(val) => $emit('confirm', val)"
      @cancel="$emit('cancel')"
    />
  </PPBottomSheet>
</template>

<script setup lang="ts">
import PPTimePicker from './PPTimePicker.vue';
import PPBottomSheet from './PPBottomSheet.vue';

withDefaults(defineProps<{
  modelValue: boolean; // sheet open state
  timeValue?: string;  // actual time value
  title?: string;
  min?: string;
  max?: string;
  minuteValues?: string | number[];
  hourCycle?: 'h12' | 'h23';
  showActionButtons?: boolean;
  theme?: 'light' | 'dark' | 'auto';
}>(), {
  theme: 'auto'
});

const emit = defineEmits<{
  (e: 'update:modelValue', val: boolean): void;
  (e: 'update:timeValue', val: string | string[] | null | undefined): void;
  (e: 'change', val: string | string[] | null | undefined): void;
  (e: 'confirm', val: string | string[] | null | undefined): void;
  (e: 'cancel'): void;
}>();

const onTimeUpdate = (val: string | string[] | null | undefined) => {
  emit('update:timeValue', val);
};
</script>
