<template>
  <PPBottomSheet :modelValue="visible" @update:modelValue="onVisibleUpdate" :title="sheetTitle">
    <div class="pp-date-range-content">
      <PPDateRangePicker 
        :modelValue="dateRangeVal"
        :hide-header-picker="hideHeaderPicker"
        :hide-nav-buttons="hideNavButtons"
        @update:modelValue="onRangeSelected"
      />
      
      <!-- Footer Actions -->
      <div class="footer-actions">
        <PPButton variant="secondary" block @click="onCancel">Cancel</PPButton>
        <PPButton variant="primary" block @click="onApply">Apply</PPButton>
      </div>
    </div>
  </PPBottomSheet>
</template>

<script setup lang="ts">
import { ref, watch } from 'vue';
import PPBottomSheet from './PPBottomSheet.vue';
import PPButton from './PPButton.vue';
import PPDateRangePicker from './PPDateRangePicker.vue';

const props = withDefaults(defineProps<{
  visible?: boolean;
  modelValue?: { start: Date | null, end: Date | null, presetId?: string };
  hideHeaderPicker?: boolean;
  hideNavButtons?: boolean;
}>(), {
  visible: false,
  modelValue: () => ({ start: null, end: null, presetId: undefined }),
  hideHeaderPicker: false,
  hideNavButtons: false
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
.pp-date-range-content {
  display: flex;
  flex-direction: column;
}

:deep(.pp-date-range-picker) {
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
