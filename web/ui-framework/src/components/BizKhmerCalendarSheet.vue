<template>
  <BizBottomSheet 
    :modelValue="modelValue"
    @update:modelValue="$emit('update:modelValue', $event)"
    :title="title"
  >
    <BizKhmerCalendar 
      :config="config"
      :initialDate="initialDate"
      :showActionButtons="showActionButtons"
      @date-selected="$emit('date-selected', $event)"
      @range-selected="(s, e) => $emit('range-selected', s, e)"
      @month-changed="(y, m) => $emit('month-changed', y, m)"
      @confirm="(s, e) => $emit('confirm', s, e)"
      @cancel="$emit('cancel')"
    />
  </BizBottomSheet>
</template>

<script setup lang="ts">
import BizBottomSheet from './BizBottomSheet.vue';
import BizKhmerCalendar, { type CalendarSelection } from './BizKhmerCalendar.vue';
import type { CalendarConfig } from '../utils/KhmerDate';

defineProps<{
  modelValue: boolean;
  title?: string;
  config?: CalendarConfig;
  initialDate?: Date;
  showActionButtons?: boolean;
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
