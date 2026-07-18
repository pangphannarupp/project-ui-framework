<template>
  <div class="biz-khmer-calendar-island-wrapper">
    <BizDynamicIsland 
      :modelValue="internalModelValue" 
      :state="islandState"
      :position="position"
      :fullWidth="fullWidth"
      :offset="offset"
      bgColor="#ffffff"
      textColor="#333333"
      wrapperClass="khmer-calendar-island"
      @update:modelValue="handleIslandUpdate"
    >
      <template #minimal v-if="islandState === 'minimal'">
        <div class="calendar-minimal-dot"></div>
      </template>

      <template #expanded-body v-if="islandState === 'expanded'">
        <div class="calendar-island-body">
          <BizKhmerCalendar 
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
            @confirm="handleConfirm"
            @cancel="handleCancel"
          />
        </div>
      </template>
    </BizDynamicIsland>
  </div>
</template>

<script setup lang="ts">
import { ref, watch } from 'vue';
import BizDynamicIsland from './BizDynamicIsland.vue';
import BizKhmerCalendar, { type CalendarSelection } from './BizKhmerCalendar.vue';
import type { CalendarConfig } from '../utils/KhmerDate';

const props = withDefaults(defineProps<{
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
  position?: 'top' | 'bottom' | 'left' | 'right';
  fullWidth?: boolean;
  offset?: number;
}>(), {
  position: 'top',
  fullWidth: false,
  offset: 16
});

const emit = defineEmits<{
  (e: 'update:modelValue', val: boolean): void;
  (e: 'date-selected', selection: CalendarSelection): void;
  (e: 'range-selected', start: CalendarSelection | null, end: CalendarSelection | null): void;
  (e: 'month-changed', year: number, month: number): void;
  (e: 'confirm', start: CalendarSelection | null, end: CalendarSelection | null): void;
  (e: 'cancel'): void;
}>();

const islandState = ref('minimal');
const internalModelValue = ref(false);
let expandTimeout: any;
let closeTimeout: any;

watch(() => props.modelValue, (val) => {
  if (val) {
    internalModelValue.value = true;
    islandState.value = 'minimal';
    clearTimeout(expandTimeout);
    expandTimeout = setTimeout(() => {
      islandState.value = 'expanded';
    }, 400); // Allow entry animation to finish before expanding
  } else {
    if (internalModelValue.value) {
      islandState.value = 'minimal';
      clearTimeout(closeTimeout);
      closeTimeout = setTimeout(() => {
        internalModelValue.value = false;
      }, 400);
    }
  }
});

const handleIslandUpdate = (val: boolean) => {
  if (!val) {
    emit('update:modelValue', false);
  } else {
    internalModelValue.value = val;
  }
};

const handleConfirm = (start: CalendarSelection | null, end: CalendarSelection | null) => {
  emit('confirm', start, end);
  emit('update:modelValue', false);
};

const handleCancel = () => {
  emit('cancel');
  emit('update:modelValue', false);
};
</script>

<style scoped>
.calendar-island-body {
  width: 100%;
  height: 100%;
  overflow-y: auto;
  scrollbar-width: none;
  background: white; /* Khmer Calendar needs white background typically */
  border-radius: 16px;
  padding: 8px;
  color: #333;
}
.calendar-island-body::-webkit-scrollbar {
  display: none;
}

.calendar-minimal-dot {
  width: 16px;
  height: 16px;
  background-color: var(--biz-color-primary, #1976d2);
  border-radius: 50%;
}
</style>

<style>
.khmer-calendar-island {
  --biz-island-expanded-width: 360px;
  --biz-island-expanded-height: 680px;
  --biz-island-expanded-radius: 24px;
}
</style>
