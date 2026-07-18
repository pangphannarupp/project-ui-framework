<template>
  <BizBottomSheet :modelValue="visible" @update:modelValue="onVisibleUpdate" :title="sheetTitle">
    <div class="biz-date-range-content">
      <BizDateRangePicker 
        :modelValue="dateRangeVal"
        @update:modelValue="onRangeSelected"
      />
      
      <!-- Footer Actions -->
      <div class="footer-actions">
        <BizButton variant="secondary" block @click="onCancel">Cancel</BizButton>
        <BizButton variant="primary" block @click="onApply">Apply</BizButton>
      </div>
    </div>
  </BizBottomSheet>
</template>

<script setup lang="ts">
import { ref, watch } from 'vue';
import BizBottomSheet from './BizBottomSheet.vue';
import BizButton from './BizButton.vue';
import BizDateRangePicker from './BizDateRangePicker.vue';

const props = withDefaults(defineProps<{
  visible?: boolean;
  modelValue?: { start: Date | null, end: Date | null, presetId?: string };
}>(), {
  visible: false,
  modelValue: () => ({ start: null, end: null, presetId: undefined })
});

const emit = defineEmits<{
  (e: 'update:visible', value: boolean): void;
  (e: 'update:modelValue', value: { start: Date | null, end: Date | null, presetId?: string }): void;
  (e: 'apply', value: { start: Date | null, end: Date | null, presetId?: string }): void;
}>();

const dateRangeVal = ref<{ start: Date | null, end: Date | null, presetId?: string }>({
  start: null, end: null, presetId: undefined
});

watch(() => props.modelValue, (newVal) => {
  if (newVal) {
    dateRangeVal.value = { ...newVal };
  }
});

const onVisibleUpdate = (v: boolean) => {
  emit('update:visible', v);
};

const sheetTitle = 'Select Date Range';

const onRangeSelected = (val: any) => {
  dateRangeVal.value = val;
};

const onCancel = () => {
  emit('update:visible', false);
};

const onApply = () => {
  emit('update:modelValue', dateRangeVal.value);
  emit('apply', dateRangeVal.value);
  emit('update:visible', false);
};
</script>

<style scoped>
.biz-date-range-content {
  display: flex;
  flex-direction: column;
}

:deep(.biz-date-range-picker) {
  border: none;
  box-shadow: none;
  border-radius: 0;
  width: 100%;
}

.footer-actions {
  display: flex;
  gap: 16px;
  margin-top: 16px;
  padding: 0 16px 24px 16px;
}
</style>
