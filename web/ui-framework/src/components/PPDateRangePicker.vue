<template>
  <div class="pp-date-range-picker">
    <!-- Sidebar -->
    <div class="sidebar">
      <ul class="presets-list">
        <li 
          v-for="preset in presets" 
          :key="preset.id"
          class="preset-item"
          :class="{ active: selectedPresetId === preset.id }"
          @click="selectPreset(preset)"
        >
          {{ preset.label }}
        </li>
      </ul>
    </div>
    
    <!-- Calendar View -->
    <div class="calendar-view">
      <PPCalendar 
        :config="{ selectionMode: 'Range', firstDayOfWeek: 0 }"
        :doubleView="true"
        :initialRangeStart="customStartDate"
        :initialRangeEnd="customEndDate"
        :hide-header-picker="hideHeaderPicker"
        :hide-nav-buttons="hideNavButtons"
        @range-selected="onCustomRangeSelected"
      />
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import PPCalendar from './PPCalendar.vue';

const props = defineProps<{
  modelValue?: { start: Date | null, end: Date | null, presetId?: string };
  hideHeaderPicker?: boolean;
  hideNavButtons?: boolean;
}>();

const emit = defineEmits<{
  (e: 'update:modelValue', value: { start: Date | null, end: Date | null, presetId?: string }): void;
}>();

const selectedPresetId = ref<string | undefined>(props.modelValue?.presetId);
const customStartDate = ref<Date | null>(props.modelValue?.start || null);
const customEndDate = ref<Date | null>(props.modelValue?.end || null);

const presets = [
  { id: 'today', label: 'Today', getRange: () => getSingleDayRange(0) },
  { id: 'yesterday', label: 'Yesterday', getRange: () => getSingleDayRange(1) },
  { id: 'this_week', label: 'This week', getRange: () => getThisWeekRange() },
  { id: 'last_week', label: 'Last week', getRange: () => getLastWeekRange() },
  { id: '7d', label: 'Last 7 days', getRange: () => getPastDaysRange(7) },
  { id: '14d', label: 'Last 14 days', getRange: () => getPastDaysRange(14) },
  { id: '30d', label: 'Last 30 days', getRange: () => getPastDaysRange(30) },
  { id: 'this_month', label: 'This month', getRange: () => getThisMonthRange() },
  { id: 'last_month', label: 'Last month', getRange: () => getLastMonthRange() },
  { id: '3m', label: 'Last 3 months', getRange: () => getPastMonthsRange(3) },
  { id: '6m', label: 'Last 6 months', getRange: () => getPastMonthsRange(6) },
  { id: '1y', label: 'Last year', getRange: () => getPastMonthsRange(12) }
];

const getThisWeekRange = () => {
  const start = new Date();
  const day = start.getDay();
  const diff = start.getDate() - day + (day === 0 ? -6 : 1); // adjust when day is sunday
  start.setDate(diff);
  const end = new Date(start);
  end.setDate(end.getDate() + 6);
  return { start, end };
};

const getLastWeekRange = () => {
  const start = new Date();
  const day = start.getDay();
  const diff = start.getDate() - day + (day === 0 ? -6 : 1) - 7;
  start.setDate(diff);
  const end = new Date(start);
  end.setDate(end.getDate() + 6);
  return { start, end };
};

const getThisMonthRange = () => {
  const start = new Date();
  start.setDate(1);
  const end = new Date(start);
  end.setMonth(end.getMonth() + 1);
  end.setDate(0);
  return { start, end };
};

const getLastMonthRange = () => {
  const start = new Date();
  start.setMonth(start.getMonth() - 1);
  start.setDate(1);
  const end = new Date(start);
  end.setMonth(end.getMonth() + 1);
  end.setDate(0);
  return { start, end };
};

const getSingleDayRange = (daysAgo: number) => {
  const start = new Date();
  start.setDate(start.getDate() - daysAgo);
  const end = new Date(start);
  return { start, end };
};

const getPastDaysRange = (days: number) => {
  const end = new Date();
  const start = new Date();
  start.setDate(end.getDate() - days);
  return { start, end };
};

const getPastMonthsRange = (months: number) => {
  const end = new Date();
  const start = new Date();
  start.setMonth(end.getMonth() - months);
  return { start, end };
};

const selectPreset = (preset: typeof presets[0]) => {
  selectedPresetId.value = preset.id;
  const range = preset.getRange();
  
  if (range) {
    customStartDate.value = range.start;
    customEndDate.value = range.end;
  }
  
  emit('update:modelValue', {
    start: customStartDate.value,
    end: customEndDate.value,
    presetId: selectedPresetId.value
  });
};

const onCustomRangeSelected = (start: { date: Date } | null, end: { date: Date } | null) => {
  customStartDate.value = start?.date || null;
  customEndDate.value = end?.date || null;
  
  // Custom selection clears the preset active state
  selectedPresetId.value = undefined;
  
  emit('update:modelValue', {
    start: customStartDate.value,
    end: customEndDate.value,
    presetId: undefined
  });
};
</script>

<style scoped>
.pp-date-range-picker {
  display: flex;
  background-color: #ffffff;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
  border: 1px solid #e2e8f0;
  width: 100%;
}

.sidebar {
  width: 160px;
  border-right: 1px solid #e2e8f0;
  background-color: #f8fafc;
  padding: 16px 0;
}

.presets-list {
  list-style: none;
  margin: 0;
  padding: 0;
}

.preset-item {
  padding: 12px 24px;
  color: #475569;
  font-size: 14px;
  cursor: pointer;
  transition: all 0.2s;
}

.preset-item:hover {
  background-color: rgba(0, 0, 0, 0.03);
}

.preset-item.active {
  color: var(--pp-primary-color, #003399);
  font-weight: 600;
  background-color: rgba(0, 51, 153, 0.05);
}

.calendar-view {
  padding: 8px;
  flex: 1;
}

/* Specific overrides for PPCalendar children */
:deep(.calendar-header) {
  padding-bottom: 24px !important;
}

:deep(.month-title) {
  font-weight: 600;
  font-size: 16px;
  flex: 1;
  text-align: center;
  justify-content: center;
}

:deep(.nav-buttons-left), :deep(.nav-buttons-right) {
  display: flex;
  gap: 8px;
}
</style>
