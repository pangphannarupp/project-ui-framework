<template>
  <div v-if="modelValue" class="pp-calendar-alert-overlay" @click="onOverlayClick">
    <div class="pp-calendar-alert-content" @click.stop>
      <div class="alert-body">
        <PPYearPicker 
          :config="config"
          :initialYear="initialYear"
          :showActionButtons="showActionButtons"
          @year-selected="(s: YearSelection) => $emit('year-selected', s)"
          @range-selected="(s: YearSelection | null, e: YearSelection | null) => $emit('range-selected', s, e)"
          @confirm="(s: YearSelection | null, e: YearSelection | null) => $emit('confirm', s, e)"
          @cancel="$emit('cancel')"
        />
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import PPYearPicker, { type YearSelection, type YearPickerConfig } from './PPYearPicker.vue';

const props = defineProps<{
  modelValue: boolean;
  title?: string;
  config?: YearPickerConfig;
  initialYear?: number;
  showActionButtons?: boolean;
  dismissOnOverlayClick?: boolean;
}>();

const emit = defineEmits<{
  (e: 'update:modelValue', val: boolean): void;
  (e: 'year-selected', selection: YearSelection): void;
  (e: 'range-selected', start: YearSelection | null, end: YearSelection | null): void;
  (e: 'confirm', start: YearSelection | null, end: YearSelection | null): void;
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
