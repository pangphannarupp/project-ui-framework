<template>
  <div class="biz-year-picker-island-wrapper">
    <BizDynamicIsland 
      :modelValue="internalModelValue" 
      :state="islandState"
      :position="position"
      :fullWidth="fullWidth"
      :offset="offset"
      bgColor="#ffffff"
      textColor="#333333"
      wrapperClass="year-picker-island"
      @update:modelValue="handleIslandUpdate"
    >
      <template #minimal v-if="islandState === 'minimal'">
        <div class="calendar-minimal-dot"></div>
      </template>

      <template #expanded-body v-if="islandState === 'expanded'">
        <div class="calendar-island-body">
          <BizYearPicker 
            :title="title"
            :config="config"
            :initialYear="initialYear"
            :showActionButtons="showActionButtons"
            @year-selected="(s: YearSelection) => $emit('year-selected', s)"
            @range-selected="(s: YearSelection | null, e: YearSelection | null) => $emit('range-selected', s, e)"
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
import BizYearPicker, { type YearSelection, type YearPickerConfig } from './BizYearPicker.vue';

const props = withDefaults(defineProps<{
  modelValue: boolean;
  title?: string;
  config?: YearPickerConfig;
  initialYear?: number;
  showActionButtons?: boolean;
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
  (e: 'year-selected', selection: YearSelection): void;
  (e: 'range-selected', start: YearSelection | null, end: YearSelection | null): void;
  (e: 'confirm', start: YearSelection | null, end: YearSelection | null): void;
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

const handleConfirm = (start: YearSelection | null, end: YearSelection | null) => {
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
  background-color: var(--biz-color-primary, #1976d2);
  border-radius: 50%;
}
</style>

<style>
.year-picker-island {
  --biz-island-expanded-width: 360px;
  --biz-island-expanded-height: 320px;
  --biz-island-expanded-radius: 24px;
}
</style>
