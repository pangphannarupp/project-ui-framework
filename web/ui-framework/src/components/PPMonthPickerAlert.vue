<template>
  <div v-if="modelValue" class="pp-calendar-alert-overlay" @click="onOverlayClick">
    <div class="pp-calendar-alert-content" @click.stop>
      <div class="alert-body">
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
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import PPMonthPicker, { type MonthSelection, type MonthPickerConfig } from './PPMonthPicker.vue';

const props = defineProps<{
  modelValue: boolean;
  title?: string;
  config?: MonthPickerConfig;
  initialDate?: Date;
  showActionButtons?: boolean;
  dismissOnOverlayClick?: boolean;
  cancelText?: string;
  confirmText?: string;
}>();

const emit = defineEmits<{
  (e: 'update:modelValue', val: boolean): void;
  (e: 'month-selected', selection: MonthSelection): void;
  (e: 'range-selected', start: MonthSelection | null, end: MonthSelection | null): void;
  (e: 'year-changed', year: number): void;
  (e: 'confirm', start: MonthSelection | null, end: MonthSelection | null): void;
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
