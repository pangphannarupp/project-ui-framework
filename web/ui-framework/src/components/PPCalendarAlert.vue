<template>
  <div v-if="modelValue" class="pp-calendar-alert-overlay" @click="onOverlayClick">
    <div class="pp-calendar-alert-content" @click.stop>

      <div class="alert-body">
        <PPCalendar 
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
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import PPCalendar, { type CalendarSelection } from './PPCalendar.vue';
import type { CalendarConfig } from '../utils/KhmerDate';

const props = defineProps<{
  modelValue: boolean;
  title?: string;
  config?: CalendarConfig;
  initialDate?: Date;
  showActionButtons?: boolean;
  dismissOnOverlayClick?: boolean;
  pickerTitleText?: string;
  pickerMonthText?: string;
  pickerYearText?: string;
  pickerCancelText?: string;
  pickerConfirmText?: string;
  cancelText?: string;
  confirmText?: string;
}>();

const emit = defineEmits<{
  (e: 'update:modelValue', val: boolean): void;
  (e: 'date-selected', selection: CalendarSelection): void;
  (e: 'range-selected', start: CalendarSelection | null, end: CalendarSelection | null): void;
  (e: 'month-changed', year: number, month: number): void;
  (e: 'confirm', start: CalendarSelection | null, end: CalendarSelection | null): void;
  (e: 'cancel'): void;
}>();

const onOverlayClick = () => {
  if (props.dismissOnOverlayClick !== false) {
    emit('update:modelValue', false);
  }
};
</script>

<style scoped>
.pp-calendar-alert-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.4);
  z-index: 1000;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 16px;
}

.pp-calendar-alert-content {
  background: #fff;
  border-radius: 16px;
  width: 100%;
  max-width: 400px;
  max-height: 90vh;
  overflow-y: auto;
  box-shadow: 0 12px 32px rgba(0, 0, 0, 0.15);
}



.alert-body {
  padding: 0px;
}
</style>
