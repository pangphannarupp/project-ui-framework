<template>
  <div class="pp-month-picker-island-wrapper">
    <PPDynamicIsland 
      :modelValue="internalModelValue" 
      :state="islandState"
      :position="position"
      :fullWidth="fullWidth"
      :offset="offset"
      bgColor="#ffffff"
      textColor="#333333"
      wrapperClass="month-picker-island"
      @update:modelValue="handleIslandUpdate"
    >
      <template #minimal v-if="islandState === 'minimal'">
        <div class="calendar-minimal-dot"></div>
      </template>

      <template #expanded-body v-if="islandState === 'expanded'">
        <div class="calendar-island-body">
          <PPMonthPicker 
            :config="config"
            :initialDate="initialDate"
            :showActionButtons="showActionButtons"
            :cancelText="cancelText"
            :confirmText="confirmText"
            @month-selected="$emit('month-selected', $event)"
            @range-selected="(s, e) => $emit('range-selected', s, e)"
            @year-changed="(y) => $emit('year-changed', y)"
            @confirm="handleConfirm"
            @cancel="handleCancel"
          />
        </div>
      </template>
    </PPDynamicIsland>
  </div>
</template>

<script setup lang="ts">
import { ref, watch } from 'vue';
import PPDynamicIsland from './PPDynamicIsland.vue';
import PPMonthPicker, { type MonthSelection, type MonthPickerConfig } from './PPMonthPicker.vue';

const props = withDefaults(defineProps<{
  modelValue: boolean;
  title?: string;
  config?: MonthPickerConfig;
  initialDate?: Date;
  showActionButtons?: boolean;
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
  (e: 'month-selected', selection: MonthSelection): void;
  (e: 'range-selected', start: MonthSelection | null, end: MonthSelection | null): void;
  (e: 'year-changed', year: number): void;
  (e: 'confirm', start: MonthSelection | null, end: MonthSelection | null): void;
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

const handleConfirm = (start: MonthSelection | null, end: MonthSelection | null) => {
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
  background: white; 
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
  background-color: var(--pp-color-primary, #1976d2);
  border-radius: 50%;
}
</style>

<style>
.month-picker-island {
  --pp-island-expanded-width: 360px;
  --pp-island-expanded-height: 320px;
  --pp-island-expanded-radius: 24px;
}
</style>
