<template>
  <PPBottomSheet 
    :modelValue="modelValue"
    @update:modelValue="$emit('update:modelValue', $event)"
  >
    <PPKhmerCalendar 
      :config="config"
      :initialDate="initialDate"
      :showActionButtons="showActionButtons"
      :pickerTitleText="pickerTitleText"
      :pickerMonthText="pickerMonthText"
      :pickerYearText="pickerYearText"
      :pickerCancelText="pickerCancelText"
      :pickerConfirmText="pickerConfirmText"
      :cancelText="cancelText"
      :confirmText="confirmText"
      @date-selected="$emit('date-selected', $event)"
      @range-selected="(s, e) => $emit('range-selected', s, e)"
      @month-changed="(y, m) => $emit('month-changed', y, m)"
      @confirm="(s, e) => $emit('confirm', s, e)"
      @cancel="$emit('cancel')"
    />
  </PPBottomSheet>
</template>

<script setup lang="ts">
import PPBottomSheet from './PPBottomSheet.vue';
import PPKhmerCalendar, { type CalendarSelection } from './PPKhmerCalendar.vue';
import type { CalendarConfig } from '../utils/KhmerDate';

defineProps<{
  modelValue: boolean;
  title?: string;
  config?: CalendarConfig;
  initialDate?: Date;
  showActionButtons?: boolean;
  pickerTitleText?: string;
  pickerMonthText?: string;
  pickerYearText?: string;
  pickerCancelText?: string;
  pickerConfirmText?: string;
  cancelText?: string;
  confirmText?: string;
}>();

defineEmits<{
  (e: 'update:modelValue', val: boolean): void;
  (e: 'date-selected', selection: CalendarSelection): void;
  (e: 'range-selected', start: CalendarSelection | null, end: CalendarSelection | null): void;
  (e: 'month-changed', year: number, month: number): void;
  (e: 'confirm', start: CalendarSelection | null, end: CalendarSelection | null): void;
  (e: 'cancel'): void;
}>();
</script>
