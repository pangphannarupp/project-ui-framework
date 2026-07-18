<template>
  <div v-if="modelValue" class="biz-calendar-alert-overlay" @click="onOverlayClick">
    <div class="biz-calendar-alert-content date-range-picker-alert" @click.stop>
      <div class="alert-body">
        <BizDateRangePicker 
          :modelValue="dateRangeVal"
          @update:modelValue="onRangeSelected"
        />
        <div class="action-buttons">
          <BizButton variant="secondary" @click="onCancel">Cancel</BizButton>
          <BizButton variant="primary" @click="onConfirm">Confirm</BizButton>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, watch } from 'vue';
import BizDateRangePicker from './BizDateRangePicker.vue';
import BizButton from './BizButton.vue';

const props = defineProps<{
  modelValue: boolean;
  dismissOnOverlayClick?: boolean;
  initialValue?: { start: Date | null, end: Date | null, presetId?: string };
}>();

const emit = defineEmits<{
  (e: 'update:modelValue', val: boolean): void;
  (e: 'confirm', value: { start: Date | null, end: Date | null, presetId?: string }): void;
  (e: 'cancel'): void;
}>();

const dateRangeVal = ref<{ start: Date | null, end: Date | null, presetId?: string }>({
  start: null, end: null, presetId: undefined
});

watch(() => props.modelValue, (val) => {
  if (val && props.initialValue) {
    dateRangeVal.value = { ...props.initialValue };
  }
});

const onOverlayClick = () => {
  if (props.dismissOnOverlayClick !== false) {
    emit('update:modelValue', false);
    emit('cancel');
  }
};

const onRangeSelected = (val: any) => {
  dateRangeVal.value = val;
};

const onCancel = () => {
  emit('update:modelValue', false);
  emit('cancel');
};

const onConfirm = () => {
  emit('confirm', dateRangeVal.value);
  emit('update:modelValue', false);
};
</script>

<style scoped>
.biz-calendar-alert-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.4);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 1000;
}

.biz-calendar-alert-content {
  background: #ffffff;
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 4px 12px rgba(0,0,0,0.15);
  max-width: 90vw;
  max-height: 90vh;
  display: flex;
  flex-direction: column;
}

.date-range-picker-alert .biz-date-range-picker {
  border: none;
  box-shadow: none;
  border-radius: 0;
}

.action-buttons {
  padding: 16px;
  display: flex;
  justify-content: flex-end;
  gap: 12px;
  border-top: 1px solid #e2e8f0;
  background: #ffffff;
}
</style>
