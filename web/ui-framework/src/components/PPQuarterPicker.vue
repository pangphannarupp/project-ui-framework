<template>
  <div 
    class="pp-quarter-picker" 
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

    <!-- Quarter Grid -->
    <div class="quarter-grid-container">
      <Transition :name="transitionName">
        <div class="quarter-grid" :key="currentYear">
          <div 
            v-for="(quarter, index) in quarters" 
            :key="index"
            class="quarter-cell-wrapper"
          >
            <div 
              class="quarter-cell"
              :class="{
                'is-disabled': !quarter.isEnabled,
                'is-selected': isSelected(quarter),
                'is-in-range': isInRange(quarter),
                'is-range-start': isRangeStart(quarter),
                'is-range-end': isRangeEnd(quarter),
                'is-current': quarter.isCurrent
              }"
              @click="onQuarterClick(quarter)"
            >
              <div class="quarter-content">
                {{ quarterNames[quarter.quarter - 1] }}
              </div>
            </div>
          </div>
        </div>
      </Transition>
    </div>

    <div class="action-buttons" v-if="showActionButtons">
      <button class="btn-cancel" @click="onCancel">{{ cancelText }}</button>
      <button class="btn-confirm" @click="onConfirmAction">{{ confirmText }}</button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

export interface QuarterSelection {
  year: number;
  quarter: number; // 1-4
}

export interface QuarterPickerConfig {
  selectionMode?: 'Single' | 'Range';
  minDate?: Date | null;
  maxDate?: Date | null;
}

const props = withDefaults(defineProps<{
  config?: QuarterPickerConfig;
  initialDate?: Date;
  showActionButtons?: boolean;
  cancelText?: string;
  confirmText?: string;
}>(), {
  config: () => ({ selectionMode: 'Single' }),
  initialDate: () => new Date(),
  showActionButtons: false,
  cancelText: 'Cancel',
  confirmText: 'Confirm'
});

const emit = defineEmits<{
  (e: 'quarter-selected', selection: QuarterSelection): void;
  (e: 'range-selected', start: QuarterSelection | null, end: QuarterSelection | null): void;
  (e: 'year-changed', year: number): void;
  (e: 'confirm', start: QuarterSelection | null, end: QuarterSelection | null): void;
  (e: 'cancel'): void;
}>();

const quarterNames = ["Q1", "Q2", "Q3", "Q4"];

const today = new Date();
const currentYear = ref(props.initialDate.getFullYear());
const currentQuarterNum = Math.floor(props.initialDate.getMonth() / 3) + 1;

const selectedQuarter = ref<QuarterSelection | null>({
  year: props.initialDate.getFullYear(),
  quarter: currentQuarterNum
});
const rangeStartQuarter = ref<QuarterSelection | null>(null);
const rangeEndQuarter = ref<QuarterSelection | null>(null);

const touchStartX = ref(0);
const transitionName = ref('slide-left');

// Helper to get Date for start of a quarter (e.g. Q1 -> Jan, Q2 -> Apr)
const getQuarterStartDate = (year: number, quarter: number) => {
  return new Date(year, (quarter - 1) * 3, 1);
};

// Generate quarter cells for the current year
const quarters = computed(() => {
  const res = [];
  const minTime = props.config.minDate ? new Date(props.config.minDate.getFullYear(), Math.floor(props.config.minDate.getMonth() / 3) * 3, 1).getTime() : null;
  // For maxDate, we also round to the start of the quarter for easy comparison, or we just keep it exact and compare start dates.
  const maxTime = props.config.maxDate ? new Date(props.config.maxDate.getFullYear(), Math.floor(props.config.maxDate.getMonth() / 3) * 3, 1).getTime() : null;
  
  const todayQuarter = Math.floor(today.getMonth() / 3) + 1;

  for (let i = 1; i <= 4; i++) {
    const t = getQuarterStartDate(currentYear.value, i).getTime();
    let isEnabled = true;
    if (minTime !== null && t < minTime) isEnabled = false;
    if (maxTime !== null && t > maxTime) isEnabled = false;
    
    res.push({
      year: currentYear.value,
      quarter: i,
      isEnabled,
      isCurrent: today.getFullYear() === currentYear.value && todayQuarter === i
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

const isSameQuarter = (q1: QuarterSelection | null, q2: QuarterSelection | null) => {
  if (!q1 || !q2) return false;
  return q1.year === q2.year && q1.quarter === q2.quarter;
};

const isQuarterBefore = (q1: QuarterSelection, q2: QuarterSelection) => {
  return q1.year < q2.year || (q1.year === q2.year && q1.quarter < q2.quarter);
};

const isQuarterAfter = (q1: QuarterSelection, q2: QuarterSelection) => {
  return q1.year > q2.year || (q1.year === q2.year && q1.quarter > q2.quarter);
};

const isSelected = (quarter: QuarterSelection) => {
  const mode = props.config.selectionMode || 'Single';
  if (mode === 'Single') {
    return isSameQuarter(selectedQuarter.value, quarter);
  }
  return isSameQuarter(rangeStartQuarter.value, quarter) || isSameQuarter(rangeEndQuarter.value, quarter);
};

const isInRange = (quarter: QuarterSelection) => {
  const mode = props.config.selectionMode || 'Single';
  if (mode === 'Single' || !rangeStartQuarter.value || !rangeEndQuarter.value) return false;
  return isQuarterAfter(quarter, rangeStartQuarter.value) && isQuarterBefore(quarter, rangeEndQuarter.value);
};

const isRangeStart = (quarter: QuarterSelection) => {
  const mode = props.config.selectionMode || 'Single';
  if (mode === 'Single') return false;
  return isSameQuarter(rangeStartQuarter.value, quarter);
};

const isRangeEnd = (quarter: QuarterSelection) => {
  const mode = props.config.selectionMode || 'Single';
  if (mode === 'Single') return false;
  return isSameQuarter(rangeEndQuarter.value, quarter);
};

const onQuarterClick = (quarter: QuarterSelection & { isEnabled: boolean }) => {
  if (!quarter.isEnabled) return;
  
  const mode = props.config.selectionMode || 'Single';
  
  if (mode === 'Single') {
    selectedQuarter.value = { year: quarter.year, quarter: quarter.quarter };
    emit('quarter-selected', { year: quarter.year, quarter: quarter.quarter });
  } else {
    // Range mode
    if (!rangeStartQuarter.value || (rangeStartQuarter.value && rangeEndQuarter.value)) {
      rangeStartQuarter.value = { year: quarter.year, quarter: quarter.quarter };
      rangeEndQuarter.value = null;
    } else if (rangeStartQuarter.value && !rangeEndQuarter.value) {
      if (isQuarterBefore(quarter, rangeStartQuarter.value)) {
        rangeStartQuarter.value = { year: quarter.year, quarter: quarter.quarter };
      } else {
        rangeEndQuarter.value = { year: quarter.year, quarter: quarter.quarter };
        emit('range-selected', rangeStartQuarter.value, rangeEndQuarter.value);
      }
    }
  }
};

const onCancel = () => {
  emit('cancel');
};

const onConfirmAction = () => {
  if (props.config.selectionMode === 'Single') {
    emit('confirm', selectedQuarter.value, null);
  } else {
    emit('confirm', rangeStartQuarter.value, rangeEndQuarter.value);
  }
};
</script>

<style scoped>
.pp-quarter-picker {
  width: 100%;
  font-family: 'Inter', -apple-system, sans-serif;
  background: var(--pp-calendar-bg, #ffffff);
  color: var(--pp-calendar-text, var(--pp-primary-variant, #1a2a5e));
  padding: 0 16px 16px 16px;
  box-sizing: border-box;

  --pp-calendar-wheel-text: rgba(26, 42, 94, 0.4);
  --pp-calendar-wheel-active: var(--pp-calendar-text, var(--pp-primary-variant, #1a2a5e));
  --pp-calendar-selected-bg: var(--pp-danger-color, #ff4d4f);
  --pp-calendar-selected-text: #ffffff;
  --pp-calendar-range-bg: rgba(255, 77, 79, 0.1);
  --pp-calendar-today-border: var(--pp-danger-color, #ff4d4f);
  --pp-calendar-cell-height: 56px;
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
  color: var(--pp-primary-color, var(--pp-primary, #003399));
}

.quarter-grid-container {
  position: relative;
  min-height: 140px;
  width: 100%;
  overflow: hidden;
}

.quarter-grid {
  display: grid;
  width: 100%;
  grid-template-columns: repeat(2, 1fr);
  gap: 12px;
}

.quarter-cell-wrapper {
  padding: 4px;
}

.quarter-cell {
  height: var(--pp-calendar-cell-height);
  display: flex;
  justify-content: center;
  align-items: center;
  cursor: pointer;
  transition: background 0.2s;
  position: relative;
}

.quarter-cell.is-disabled {
  opacity: var(--pp-calendar-day-disabled-opacity, 0.3);
  cursor: not-allowed;
}

.quarter-content {
  position: relative;
  width: 100%;
  height: 100%;
  border-radius: 8px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  font-size: 16px;
  font-weight: 600;
}

/* Single & Range Start/End Selection */
.quarter-cell.is-selected .quarter-content {
  background: var(--pp-calendar-selected-bg);
  color: var(--pp-calendar-selected-text);
}

/* Range Background Highlights */
.quarter-cell.is-in-range {
  background: var(--pp-calendar-range-bg);
}

.quarter-cell.is-range-start {
  background: linear-gradient(to right, transparent 50%, var(--pp-calendar-range-bg) 50%);
}

.quarter-cell.is-range-end {
  background: linear-gradient(to left, transparent 50%, var(--pp-calendar-range-bg) 50%);
}

.quarter-cell.is-range-start.is-range-end {
  background: transparent;
}

/* Current Quarter Outline */
.quarter-cell.is-current:not(.is-selected) .quarter-content {
  border: 1px solid var(--pp-calendar-today-border);
  color: var(--pp-calendar-today-border);
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
  color: var(--pp-calendar-btn-cancel-text, #666);
}

.btn-confirm {
  background: var(--pp-calendar-btn-confirm-bg, var(--pp-primary-color, var(--pp-primary, #003399)));
  color: var(--pp-calendar-btn-confirm-text, #ffffff);
}
</style>
