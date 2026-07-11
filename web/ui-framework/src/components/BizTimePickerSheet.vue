<template>
  <BizBottomSheet 
    :modelValue="modelValue"
    @update:modelValue="$emit('update:modelValue', $event)"
    :title="title"
  >
    <BizTimePicker 
      :modelValue="timeValue"
      :min="min"
      :max="max"
      :minuteValues="minuteValues"
      :hourCycle="hourCycle"
      :showActionButtons="showActionButtons"
      @update:modelValue="onTimeUpdate"
      @change="(val) => $emit('change', val)"
      @confirm="(val) => $emit('confirm', val)"
      @cancel="$emit('cancel')"
    />
  </BizBottomSheet>
</template>

<script setup lang="ts">
import BizTimePicker from './BizTimePicker.vue';
import BizBottomSheet from './BizBottomSheet.vue';

defineProps<{
  modelValue: boolean; // sheet open state
  timeValue?: string;  // actual time value
  title?: string;
  min?: string;
  max?: string;
  minuteValues?: string | number[];
  hourCycle?: 'h12' | 'h23';
  showActionButtons?: boolean;
}>();

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
