<template>
  <BizBottomSheet 
    :modelValue="modelValue"
    @update:modelValue="$emit('update:modelValue', $event)"
  >
    <BizYearPicker 
      :title="title"
      :config="config"
      :initialYear="initialYear"
      :showActionButtons="showActionButtons"
      @year-selected="(s: YearSelection) => $emit('year-selected', s)"
      @range-selected="(s: YearSelection | null, e: YearSelection | null) => $emit('range-selected', s, e)"
      @confirm="(s: YearSelection | null, e: YearSelection | null) => $emit('confirm', s, e)"
      @cancel="$emit('cancel')"
    />
  </BizBottomSheet>
</template>

<script setup lang="ts">
import BizYearPicker, { type YearSelection, type YearPickerConfig } from './BizYearPicker.vue';
import BizBottomSheet from './BizBottomSheet.vue';

defineProps<{
  modelValue: boolean;
  title?: string;
  config?: YearPickerConfig;
  initialYear?: number;
  showActionButtons?: boolean;
}>();

defineEmits<{
  (e: 'update:modelValue', val: boolean): void;
  (e: 'year-selected', selection: YearSelection): void;
  (e: 'range-selected', start: YearSelection | null, end: YearSelection | null): void;
  (e: 'confirm', start: YearSelection | null, end: YearSelection | null): void;
  (e: 'cancel'): void;
}>();
</script>
