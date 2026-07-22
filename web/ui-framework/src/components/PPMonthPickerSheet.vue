<template>
  <PPBottomSheet 
    :modelValue="modelValue"
    @update:modelValue="$emit('update:modelValue', $event)"
  >
    <PPMonthPicker 
      :config="config"
      :initialDate="initialDate"
      :showActionButtons="showActionButtons"
      :cancelText="cancelText"
      :confirmText="confirmText"
      @month-selected="$emit('month-selected', $event)"
      @range-selected="(s, e) => $emit('range-selected', s, e)"
      @year-changed="(y) => $emit('year-changed', y)"
      @confirm="(s, e) => $emit('confirm', s, e)"
      @cancel="$emit('cancel')"
    />
  </PPBottomSheet>
</template>

<script setup lang="ts">
import PPMonthPicker, { type MonthSelection, type MonthPickerConfig } from './PPMonthPicker.vue';
import PPBottomSheet from './PPBottomSheet.vue';

defineProps<{
  modelValue: boolean;
  title?: string;
  config?: MonthPickerConfig;
  initialDate?: Date;
  showActionButtons?: boolean;
  cancelText?: string;
  confirmText?: string;
}>();

defineEmits<{
  (e: 'update:modelValue', val: boolean): void;
  (e: 'month-selected', selection: MonthSelection): void;
  (e: 'range-selected', start: MonthSelection | null, end: MonthSelection | null): void;
  (e: 'year-changed', year: number): void;
  (e: 'confirm', start: MonthSelection | null, end: MonthSelection | null): void;
  (e: 'cancel'): void;
}>();
</script>
