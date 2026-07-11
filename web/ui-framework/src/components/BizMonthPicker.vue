<template>
  <div 
    class="biz-month-picker" 
    :class="{ 'hide-actions': !showActionButtons }"
    @touchstart="onTouchStart"
    @touchend="onTouchEnd"
  >
    <!-- Header Row -->
    <div class="picker-header">
      <div class="year-title">
        {{ currentYear }} 
      </div>
      <div class="nav-buttons">
        <button class="icon-btn" @click="prevYear" title="Previous Year">
          <svg viewBox="0 0 24 24" width="24" height="24" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><polyline points="15 18 9 12 15 6"></polyline></svg>
        </button>
        <button class="icon-btn today-btn" @click="goToCurrentYear" title="Current Year">
          <svg viewBox="0 0 24 24" width="24" height="24" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg>
        </button>
        <button class="icon-btn" @click="nextYear" title="Next Year">
          <svg viewBox="0 0 24 24" width="24" height="24" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><polyline points="9 18 15 12 9 6"></polyline></svg>
        </button>
      </div>
    </div>

    <!-- Month Grid -->
    <div class="month-grid-container">
      <Transition :name="transitionName">
        <div class="month-grid" :key="currentYear">
          <div 
            v-for="(month, index) in months" 
            :key="index"
            class="month-cell-wrapper"
          >
            <div 
              class="month-cell"
              :class="{
                'is-disabled': !month.isEnabled,
                'is-selected': isSelected(month),
                'is-in-range': isInRange(month),
                'is-range-start': isRangeStart(month),
                'is-range-end': isRangeEnd(month),
                'is-current': month.isCurrent
              }"
              @click="onMonthClick(month)"
            >
              <div class="month-content">
                {{ monthNames[month.month - 1] }}
              </div>
            </div>
          </div>
        </div>
      </Transition>
    </div>

    <div class="action-buttons" v-if="showActionButtons">
      <button class="btn-cancel" @click="onCancel">Cancel</button>
      <button class="btn-confirm" @click="onConfirmAction">Confirm</button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

export interface MonthSelection {
  year: number;
  month: number; // 1-12
}

export interface MonthPickerConfig {
  selectionMode?: 'Single' | 'Range';
  minDate?: Date | null;
  maxDate?: Date | null;
}

const props = withDefaults(defineProps<{
  config?: MonthPickerConfig;
  initialDate?: Date;
  showActionButtons?: boolean;
}>(), {
  config: () => ({ selectionMode: 'Single' }),
  initialDate: () => new Date(),
  showActionButtons: false
});

const emit = defineEmits<{
  (e: 'month-selected', selection: MonthSelection): void;
  (e: 'range-selected', start: MonthSelection | null, end: MonthSelection | null): void;
  (e: 'year-changed', year: number): void;
  (e: 'confirm', start: MonthSelection | null, end: MonthSelection | null): void;
  (e: 'cancel'): void;
}>();

const monthNames = [
  "Jan", "Feb", "Mar", "Apr", "May", "Jun", 
  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
];

const today = new Date();
const currentYear = ref(props.initialDate.getFullYear());
const selectedMonth = ref<MonthSelection | null>({
  year: props.initialDate.getFullYear(),
  month: props.initialDate.getMonth() + 1
});
const rangeStartMonth = ref<MonthSelection | null>(null);
const rangeEndMonth = ref<MonthSelection | null>(null);

const touchStartX = ref(0);
const transitionName = ref('slide-left');

// Generate month cells for the current year
const months = computed(() => {
  const res = [];
  const minTime = props.config.minDate ? new Date(props.config.minDate.getFullYear(), props.config.minDate.getMonth(), 1).getTime() : null;
  const maxTime = props.config.maxDate ? new Date(props.config.maxDate.getFullYear(), props.config.maxDate.getMonth(), 1).getTime() : null;
  
  for (let i = 1; i <= 12; i++) {
    const t = new Date(currentYear.value, i - 1, 1).getTime();
    let isEnabled = true;
    if (minTime !== null && t < minTime) isEnabled = false;
    if (maxTime !== null && t > maxTime) isEnabled = false;
    
    res.push({
      year: currentYear.value,
      month: i,
      isEnabled,
      isCurrent: today.getFullYear() === currentYear.value && today.getMonth() + 1 === i
    });
  }
  return res;
});

const prevYear = () => {
  transitionName.value = 'slide-right';
  currentYear.value -= 1;
  emit('year-changed', currentYear.value);
};

const nextYear = () => {
  transitionName.value = 'slide-left';
  currentYear.value += 1;
  emit('year-changed', currentYear.value);
};

const goToCurrentYear = () => {
  if (currentYear.value > today.getFullYear()) {
    transitionName.value = 'slide-right';
  } else {
    transitionName.value = 'slide-left';
  }
  currentYear.value = today.getFullYear();
  emit('year-changed', currentYear.value);
};

const onTouchStart = (e: TouchEvent) => {
  touchStartX.value = e.changedTouches[0].screenX;
};

const onTouchEnd = (e: TouchEvent) => {
  const touchEndX = e.changedTouches[0].screenX;
  if (touchStartX.value - touchEndX > 50) {
    nextYear();
  } else if (touchEndX - touchStartX.value > 50) {
    prevYear();
  }
};

const isSameMonth = (m1: MonthSelection | null, m2: MonthSelection | null) => {
  if (!m1 || !m2) return false;
  return m1.year === m2.year && m1.month === m2.month;
};

const isMonthBefore = (m1: MonthSelection, m2: MonthSelection) => {
  return m1.year < m2.year || (m1.year === m2.year && m1.month < m2.month);
};

const isMonthAfter = (m1: MonthSelection, m2: MonthSelection) => {
  return m1.year > m2.year || (m1.year === m2.year && m1.month > m2.month);
};

const isSelected = (month: MonthSelection) => {
  const mode = props.config.selectionMode || 'Single';
  if (mode === 'Single') {
    return isSameMonth(selectedMonth.value, month);
  }
  return isSameMonth(rangeStartMonth.value, month) || isSameMonth(rangeEndMonth.value, month);
};

const isInRange = (month: MonthSelection) => {
  const mode = props.config.selectionMode || 'Single';
  if (mode === 'Single' || !rangeStartMonth.value || !rangeEndMonth.value) return false;
  return isMonthAfter(month, rangeStartMonth.value) && isMonthBefore(month, rangeEndMonth.value);
};

const isRangeStart = (month: MonthSelection) => {
  const mode = props.config.selectionMode || 'Single';
  if (mode === 'Single') return false;
  return isSameMonth(rangeStartMonth.value, month);
};

const isRangeEnd = (month: MonthSelection) => {
  const mode = props.config.selectionMode || 'Single';
  if (mode === 'Single') return false;
  return isSameMonth(rangeEndMonth.value, month);
};

const onMonthClick = (month: MonthSelection & { isEnabled: boolean }) => {
  if (!month.isEnabled) return;
  
  const mode = props.config.selectionMode || 'Single';
  
  if (mode === 'Single') {
    selectedMonth.value = { year: month.year, month: month.month };
    emit('month-selected', { year: month.year, month: month.month });
  } else {
    // Range mode
    if (!rangeStartMonth.value || (rangeStartMonth.value && rangeEndMonth.value)) {
      rangeStartMonth.value = { year: month.year, month: month.month };
      rangeEndMonth.value = null;
    } else if (rangeStartMonth.value && !rangeEndMonth.value) {
      if (isMonthBefore(month, rangeStartMonth.value)) {
        rangeStartMonth.value = { year: month.year, month: month.month };
      } else {
        rangeEndMonth.value = { year: month.year, month: month.month };
        emit('range-selected', rangeStartMonth.value, rangeEndMonth.value);
      }
    }
  }
};

const onCancel = () => {
  emit('cancel');
};

const onConfirmAction = () => {
  if (props.config.selectionMode === 'Single') {
    emit('confirm', selectedMonth.value, null);
  } else {
    emit('confirm', rangeStartMonth.value, rangeEndMonth.value);
  }
};
</script>

<style scoped>
.biz-month-picker {
  width: 100%;
  font-family: 'Inter', -apple-system, sans-serif;
  background: var(--biz-calendar-bg, #ffffff);
  color: var(--biz-calendar-text, var(--biz-primary-variant, #1a2a5e));
  padding: 0 16px 16px 16px;
  box-sizing: border-box;

  --biz-calendar-wheel-text: rgba(26, 42, 94, 0.4);
  --biz-calendar-wheel-active: var(--biz-calendar-text, var(--biz-primary-variant, #1a2a5e));
  --biz-calendar-selected-bg: var(--biz-danger-color, #ff4d4f);
  --biz-calendar-selected-text: #ffffff;
  --biz-calendar-range-bg: rgba(255, 77, 79, 0.1);
  --biz-calendar-today-border: var(--biz-danger-color, #ff4d4f);
  --biz-calendar-cell-height: 48px;
}

.picker-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px 0;
}

.year-title {
  font-size: 18px;
  font-weight: 600;
}

.nav-buttons {
  display: flex;
  gap: 8px;
}

.icon-btn {
  background: transparent;
  border: none;
  cursor: pointer;
  color: inherit;
  padding: 8px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: background 0.2s;
}

.icon-btn:hover {
  background: rgba(0,0,0,0.05);
}

.today-btn {
  color: var(--biz-primary-color, var(--biz-primary, #003399));
}

.month-grid-container {
  position: relative;
  min-height: 240px;
  width: 100%;
  overflow: hidden;
}

.month-grid {
  display: grid;
  width: 100%;
  grid-template-columns: repeat(3, 1fr);
  gap: 8px 0;
}

.month-cell-wrapper {
  padding: 4px;
}

.month-cell {
  height: var(--biz-calendar-cell-height);
  display: flex;
  justify-content: center;
  align-items: center;
  cursor: pointer;
  transition: background 0.2s;
  position: relative;
}

.month-cell.is-disabled {
  opacity: var(--biz-calendar-day-disabled-opacity, 0.3);
  cursor: not-allowed;
}

.month-content {
  position: relative;
  width: 100%;
  height: 100%;
  border-radius: 8px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  font-size: 15px;
  font-weight: 500;
}

/* Single & Range Start/End Selection */
.month-cell.is-selected .month-content {
  background: var(--biz-calendar-selected-bg);
  color: var(--biz-calendar-selected-text);
}

/* Range Background Highlights */
.month-cell.is-in-range {
  background: var(--biz-calendar-range-bg);
}

.month-cell.is-range-start {
  background: linear-gradient(to right, transparent 50%, var(--biz-calendar-range-bg) 50%);
}

.month-cell.is-range-end {
  background: linear-gradient(to left, transparent 50%, var(--biz-calendar-range-bg) 50%);
}

.month-cell.is-range-start.is-range-end {
  background: transparent;
}

/* Current Month Outline */
.month-cell.is-current:not(.is-selected) .month-content {
  border: 1px solid var(--biz-calendar-today-border);
  color: var(--biz-calendar-today-border);
}

/* Transitions */
.slide-left-enter-active,
.slide-left-leave-active,
.slide-right-enter-active,
.slide-right-leave-active {
  transition: all 0.3s ease;
}

.slide-left-enter-from {
  transform: translateX(100%);
  opacity: 0;
  position: absolute;
}
.slide-left-leave-to {
  transform: translateX(-100%);
  opacity: 0;
  position: absolute;
}

.slide-right-enter-from {
  transform: translateX(-100%);
  opacity: 0;
  position: absolute;
}
.slide-right-leave-to {
  transform: translateX(100%);
  opacity: 0;
  position: absolute;
}

/* Action Buttons */
.action-buttons {
  display: flex;
  justify-content: flex-end;
  gap: 12px;
  margin-top: 16px;
}

.btn-cancel,
.btn-confirm {
  padding: 8px 16px;
  border-radius: 8px;
  font-size: 14px;
  font-weight: 600;
  cursor: pointer;
  border: none;
}

.btn-cancel {
  background: #f4f5f8;
  color: var(--biz-calendar-btn-cancel-text, #666);
}

.btn-confirm {
  background: var(--biz-calendar-btn-confirm-bg, var(--biz-primary-color, var(--biz-primary, #003399)));
  color: var(--biz-calendar-btn-confirm-text, #ffffff);
}
</style>
