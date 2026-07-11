<template>
  <div 
    class="biz-khmer-calendar" 
    :class="{ 'hide-actions': !showActionButtons }"
    @touchstart="onTouchStart"
    @touchend="onTouchEnd"
  >
    <!-- Header Row -->
    <div class="calendar-header">
      <div class="month-title" @click="showMonthPicker = true">
        {{ monthNames[currentMonth - 1] }} {{ currentYear }} 
        <svg viewBox="0 0 24 24" width="14" height="14" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><polyline points="6 9 12 15 18 9"></polyline></svg>
      </div>
      <div class="nav-buttons">
        <button class="icon-btn" @click="prevMonth" title="Previous Month">
          <svg viewBox="0 0 24 24" width="24" height="24" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><polyline points="15 18 9 12 15 6"></polyline></svg>
        </button>
        <button class="icon-btn today-btn" @click="goToToday" title="Today">
          <svg viewBox="0 0 24 24" width="24" height="24" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg>
        </button>
        <button class="icon-btn" @click="nextMonth" title="Next Month">
          <svg viewBox="0 0 24 24" width="24" height="24" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><polyline points="9 18 15 12 9 6"></polyline></svg>
        </button>
      </div>
    </div>

    <!-- Subtitle Info -->
    <div class="khmer-subtitle" v-if="selectedKhmerDateFull">
      {{ selectedKhmerDateFull }}
    </div>
    <div class="khmer-subtitle" v-else-if="firstDayKhmer">
      ឆ្នាំ{{ firstDayKhmer.zodiacYear }} {{ firstDayKhmer.stem }} ព.ស. {{ firstDayKhmer.lunarYear }}
    </div>
    <div class="khmer-subtitle-placeholder" v-else></div>

    <!-- Days of Week -->
    <div class="weekdays">
      <div 
        v-for="(day, idx) in daysOfWeek" 
        :key="day" 
        class="weekday"
        :class="{ 'is-sunday': isSundayIndex(idx) }"
      >
        {{ day }}
      </div>
    </div>

    <!-- Calendar Grid -->
    <div class="calendar-grid-container">
    <Transition :name="transitionName">
      <div class="calendar-grid" :key="currentYear + '-' + currentMonth">
        <div 
          v-for="(day, index) in days" 
          :key="index"
          class="day-cell-wrapper"
        >
          <div v-if="day.isHidden" class="day-cell hidden"></div>
          <div 
            v-else 
            class="day-cell"
            :class="{
              'is-disabled': !day.isEnabled || !day.isCurrentMonth,
              'is-selected': isSelected(day),
              'is-in-range': isInRange(day),
              'is-range-start': isRangeStart(day),
              'is-range-end': isRangeEnd(day),
              'is-today': day.isToday,
              'is-sunday': day.isSunday
            }"
            @click="onDayClick(day)"
          >
            <div class="day-content">
              <div v-if="day.isSpecial" class="special-dot"></div>
              <div class="lunar-day">{{ day.khmerDate.lunarDay }}</div>
              <div class="gregorian-day">{{ day.gregorianDay }}</div>
              <div class="lunar-month">{{ day.khmerDate.lunarMonth }}</div>
            </div>
          </div>
        </div>
      </div>
    </Transition>
    </div>

    <!-- Action Buttons -->
    <!-- Month/Year Picker Sheet -->
    <BizBottomSheet v-model="showMonthPicker" title="Select Month">
      <div class="picker-content">
        <div class="picker-headers">
          <div class="picker-col-header">Month</div>
          <div class="picker-col-header">Year</div>
        </div>
        <div class="wheel-container">
          <!-- Month Wheel -->
          <div class="wheel-col" ref="monthCol" @scroll="onMonthScroll">
            <div class="wheel-pad"></div>
            <div 
              class="wheel-item" 
              v-for="(m, i) in monthNames" 
              :key="i" 
              :class="{'active': tempMonth === i + 1}"
              @click="scrollToMonth(i)"
            >
              {{ m }}
            </div>
            <div class="wheel-pad"></div>
          </div>
          <!-- Year Wheel -->
          <div class="wheel-col" ref="yearCol" @scroll="onYearScroll">
            <div class="wheel-pad"></div>
            <div 
              class="wheel-item" 
              v-for="y in yearOptions" 
              :key="y"
              :class="{'active': tempYear === y}"
              @click="scrollToYear(y)"
            >
              {{ y }}
            </div>
            <div class="wheel-pad"></div>
          </div>
        </div>
        <div class="picker-actions">
          <button class="btn-close-picker" @click="showMonthPicker = false">Close</button>
          <button class="btn-confirm-picker" @click="confirmMonthYear">Confirm</button>
        </div>
      </div>
    </BizBottomSheet>

    <div class="action-buttons" v-if="showActionButtons">
      <button class="btn-cancel" @click="onCancel">Cancel</button>
      <button class="btn-confirm" @click="onConfirmAction">Confirm</button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, watch } from 'vue';
import { KhmerDate, CalendarState, type CalendarDay, type CalendarConfig, type IKhmerDate, type SelectionMode } from '../utils/KhmerDate';

export interface CalendarSelection {
  date: Date;
  khmerDate: IKhmerDate;
  fullText: string;
}
import BizBottomSheet from './BizBottomSheet.vue';

const props = withDefaults(defineProps<{
  config?: CalendarConfig;
  initialDate?: Date;
  showActionButtons?: boolean;
}>(), {
  config: () => ({ selectionMode: 'Single' as SelectionMode }),
  initialDate: () => new Date(),
  showActionButtons: false
});

const emit = defineEmits<{
  (e: 'date-selected', selection: CalendarSelection): void;
  (e: 'range-selected', start: CalendarSelection | null, end: CalendarSelection | null): void;
  (e: 'month-changed', year: number, month: number): void;
  (e: 'confirm', start: CalendarSelection | null, end: CalendarSelection | null): void;
  (e: 'cancel'): void;
}>();

// State
const selectedDate = ref<Date | null>(props.initialDate);
const rangeStartDate = ref<Date | null>(null);
const rangeEndDate = ref<Date | null>(null);

const today = new Date();
const currentMonth = ref(props.initialDate.getMonth() + 1);
const currentYear = ref(props.initialDate.getFullYear());
const showMonthPicker = ref(false);
const tempMonth = ref(currentMonth.value);
const tempYear = ref(currentYear.value);
const monthCol = ref<HTMLElement | null>(null);
const yearCol = ref<HTMLElement | null>(null);
const touchStartX = ref(0);
const transitionName = ref('slide-left');

const yearOptions = computed(() => {
  const current = new Date().getFullYear();
  const years = [];
  for (let y = current - 50; y <= current + 50; y++) {
    years.push(y);
  }
  return years;
});

const confirmMonthYear = () => {
  currentMonth.value = tempMonth.value;
  currentYear.value = tempYear.value;
  showMonthPicker.value = false;
};

watch(showMonthPicker, (val) => {
  if (val) {
    tempMonth.value = currentMonth.value;
    tempYear.value = currentYear.value;
    setTimeout(() => {
      scrollToMonth(tempMonth.value - 1);
      scrollToYear(tempYear.value);
    }, 50);
  }
});

const onMonthScroll = (e: Event) => {
  const target = e.target as HTMLElement;
  const index = Math.round(target.scrollTop / 56);
  if (index >= 0 && index < monthNames.length) {
    tempMonth.value = index + 1;
  }
};

const onYearScroll = (e: Event) => {
  const target = e.target as HTMLElement;
  const index = Math.round(target.scrollTop / 56);
  if (index >= 0 && index < yearOptions.value.length) {
    tempYear.value = yearOptions.value[index];
  }
};

const onTouchStart = (e: TouchEvent) => {
  touchStartX.value = e.changedTouches[0].screenX;
};

const onTouchEnd = (e: TouchEvent) => {
  const touchEndX = e.changedTouches[0].screenX;
  if (touchStartX.value - touchEndX > 50) {
    nextMonth();
  } else if (touchEndX - touchStartX.value > 50) {
    prevMonth();
  }
};

const scrollToMonth = (idx: number) => {
  tempMonth.value = idx + 1;
  if (monthCol.value) {
    monthCol.value.scrollTo({ top: idx * 56, behavior: 'smooth' });
  }
};

const scrollToYear = (year: number) => {
  tempYear.value = year;
  const idx = yearOptions.value.indexOf(year);
  if (yearCol.value && idx !== -1) {
    yearCol.value.scrollTo({ top: idx * 56, behavior: 'smooth' });
  }
};

const calendarState = computed(() => new CalendarState(props.config));
const days = ref<CalendarDay[]>([]);
const firstDayKhmer = ref<IKhmerDate | null>(null);

const getFullKhmerString = (k: IKhmerDate) => {
  return `${k.lunarDay} ${k.lunarMonth} ឆ្នាំ${k.zodiacYear} ${k.stem} ព.ស. ${k.lunarYear}`;
};

const selectedKhmerDateFull = computed(() => {
  if (props.config.selectionMode === 'Single' && selectedDate.value) {
    const d = days.value.find(day => isSameDay(day.date, selectedDate.value));
    if (d) return getFullKhmerString(d.khmerDate);
  }
  return null;
});

const monthNames = [
  "មករា", "កុម្ភៈ", "មីនា", "មេសា", "ឧសភា", "មិថុនា", 
  "កក្កដា", "សីហា", "កញ្ញា", "តុលា", "វិច្ឆិកា", "ធ្នូ"
];

const daysOfWeek = computed(() => {
  const firstDay = props.config.firstDayOfWeek ?? 1;
  if (firstDay === 1) {
    return ["ចន្ទ", "អង្គារ", "ពុធ", "ព្រហ.", "សុក្រ", "សៅរ៍", "អាទិត្យ"];
  }
  return ["អាទិត្យ", "ចន្ទ", "អង្គារ", "ពុធ", "ព្រហ.", "សុក្រ", "សៅរ៍"];
});

const isSundayIndex = (idx: number) => {
  const firstDay = props.config.firstDayOfWeek ?? 1;
  return firstDay === 1 ? idx === 6 : idx === 0;
};

const updateCalendar = () => {
  days.value = calendarState.value.generateDaysForMonth(currentYear.value, currentMonth.value);
  firstDayKhmer.value = new KhmerDate(1, currentMonth.value, currentYear.value).toLunar();
  emit('month-changed', currentYear.value, currentMonth.value);
};

watch([currentMonth, currentYear, calendarState], () => {
  updateCalendar();
}, { immediate: true });

const prevMonth = () => {
  transitionName.value = 'slide-right';
  if (currentMonth.value === 1) {
    currentMonth.value = 12;
    currentYear.value -= 1;
  } else {
    currentMonth.value -= 1;
  }
};

const nextMonth = () => {
  transitionName.value = 'slide-left';
  if (currentMonth.value === 12) {
    currentMonth.value = 1;
    currentYear.value += 1;
  } else {
    currentMonth.value += 1;
  }
};

const goToToday = () => {
  transitionName.value = 'fade';
  currentMonth.value = today.getMonth() + 1;
  currentYear.value = today.getFullYear();
};

// Selection Logic
const isSameDay = (d1: Date | null, d2: Date | null) => {
  if (!d1 || !d2) return false;
  return d1.getFullYear() === d2.getFullYear() &&
         d1.getMonth() === d2.getMonth() &&
         d1.getDate() === d2.getDate();
};

const isSelected = (day: CalendarDay) => {
  const mode = props.config.selectionMode || 'Single';
  if (mode === 'Single') {
    return isSameDay(selectedDate.value, day.date);
  }
  return isSameDay(rangeStartDate.value, day.date) || isSameDay(rangeEndDate.value, day.date);
};

const isInRange = (day: CalendarDay) => {
  const mode = props.config.selectionMode || 'Single';
  if (mode === 'Single' || !rangeStartDate.value || !rangeEndDate.value) return false;
  return day.date.getTime() > rangeStartDate.value.getTime() && 
         day.date.getTime() < rangeEndDate.value.getTime();
};

const isRangeStart = (day: CalendarDay) => {
  const mode = props.config.selectionMode || 'Single';
  if (mode === 'Single') return false;
  return isSameDay(rangeStartDate.value, day.date);
};

const isRangeEnd = (day: CalendarDay) => {
  const mode = props.config.selectionMode || 'Single';
  if (mode === 'Single') return false;
  return isSameDay(rangeEndDate.value, day.date);
};

const onDayClick = (day: CalendarDay) => {
  if (!day.isEnabled || !day.isCurrentMonth) return;
  
  const mode = props.config.selectionMode || 'Single';
  
  if (mode === 'Single') {
    selectedDate.value = day.date;
    emit('date-selected', { date: day.date, khmerDate: day.khmerDate, fullText: getFullKhmerString(day.khmerDate) });
  } else if (mode === 'Week') {
    // Find the week row this day belongs to
    const index = days.value.findIndex(d => isSameDay(d.date, day.date));
    if (index !== -1) {
      const rowStart = Math.floor(index / 7) * 7;
      const weekDays = days.value.slice(rowStart, rowStart + 7).filter(d => d.isEnabled && !d.isHidden);
      if (weekDays.length > 0) {
        rangeStartDate.value = weekDays[0].date;
        rangeEndDate.value = weekDays[weekDays.length - 1].date;
        emit('range-selected', 
          { date: weekDays[0].date, khmerDate: weekDays[0].khmerDate, fullText: getFullKhmerString(weekDays[0].khmerDate) },
          { date: weekDays[weekDays.length - 1].date, khmerDate: weekDays[weekDays.length - 1].khmerDate, fullText: getFullKhmerString(weekDays[weekDays.length - 1].khmerDate) }
        );
      }
    }
  } else {
    // Range mode
    if (!rangeStartDate.value || (rangeStartDate.value && rangeEndDate.value)) {
      rangeStartDate.value = day.date;
      rangeEndDate.value = null;
    } else if (rangeStartDate.value && !rangeEndDate.value) {
      if (day.date.getTime() < rangeStartDate.value.getTime()) {
        rangeStartDate.value = day.date;
      } else {
        rangeEndDate.value = day.date;
        const startDay = days.value.find(d => isSameDay(d.date, rangeStartDate.value));
        emit('range-selected', 
          startDay ? { date: startDay.date, khmerDate: startDay.khmerDate, fullText: getFullKhmerString(startDay.khmerDate) } : null, 
          { date: day.date, khmerDate: day.khmerDate, fullText: getFullKhmerString(day.khmerDate) }
        );
      }
    }
  }
};

const onCancel = () => {
  emit('cancel');
};

const onConfirmAction = () => {
  const startDay = days.value.find(d => isSameDay(d.date, props.config.selectionMode === 'Single' ? selectedDate.value : rangeStartDate.value));
  const endDay = days.value.find(d => isSameDay(d.date, rangeEndDate.value));

  if (props.config.selectionMode === 'Single') {
    emit('confirm', startDay ? { date: startDay.date, khmerDate: startDay.khmerDate, fullText: getFullKhmerString(startDay.khmerDate) } : null, null);
  } else {
    emit('confirm', 
      startDay ? { date: startDay.date, khmerDate: startDay.khmerDate, fullText: getFullKhmerString(startDay.khmerDate) } : null, 
      endDay ? { date: endDay.date, khmerDate: endDay.khmerDate, fullText: getFullKhmerString(endDay.khmerDate) } : null
    );
  }
};
</script>

<style scoped>
.biz-khmer-calendar {
  width: 100%;
  font-family: 'Inter', -apple-system, sans-serif;
  background: var(--biz-calendar-bg, #ffffff);
  color: var(--biz-calendar-text, var(--biz-primary-variant, #1a2a5e));
  padding: 0 16px 16px 16px;
  box-sizing: border-box;

  /* Exposed CSS Variables for full customization */
  --biz-calendar-subtitle-color: var(--biz-calendar-subtitle-text, rgba(26, 42, 94, 0.7));
  --biz-calendar-wheel-text: rgba(26, 42, 94, 0.4);
  --biz-calendar-wheel-active: var(--biz-calendar-text, var(--biz-primary-variant, #1a2a5e));
  --biz-calendar-sunday-color: var(--biz-danger-color, #ff4d4f);
  --biz-calendar-selected-bg: var(--biz-danger-color, #ff4d4f);
  --biz-calendar-selected-text: #ffffff;
  --biz-calendar-range-bg: rgba(255, 77, 79, 0.1);
  --biz-calendar-today-border: var(--biz-danger-color, #ff4d4f);
  --biz-calendar-special-color: #FFA000;
  --biz-calendar-cell-height: 64px;
}

.calendar-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px 0;
}

.month-title {
  font-size: 18px;
  font-weight: 600;
  cursor: pointer;
  display: flex;
  align-items: center;
  gap: 4px;
}

.picker-content {
  padding: 16px;
  display: flex;
  flex-direction: column;
  gap: 24px;
}

.picker-headers {
  display: flex;
  justify-content: space-around;
}

.picker-col-header {
  font-size: 16px;
  font-weight: 500;
  color: var(--biz-calendar-text, var(--biz-primary-variant, #1a2a5e));
}

.wheel-container {
  display: flex;
  justify-content: space-around;
  height: 200px;
}

.wheel-col {
  width: 45%;
  height: 100%;
  overflow-y: auto;
  scroll-snap-type: y mandatory;
  -ms-overflow-style: none; 
  scrollbar-width: none;  
}
.wheel-col::-webkit-scrollbar { 
  display: none; 
}

.wheel-pad {
  height: 72px; /* half of 200 - 56 */
}

.wheel-item {
  height: 56px;
  display: flex;
  align-items: center;
  justify-content: center;
  scroll-snap-align: center;
  font-size: 20px;
  color: rgba(26, 42, 94, 0.4);
  cursor: pointer;
}

.wheel-item.active {
  font-size: 24px;
  font-weight: bold;
  color: var(--biz-calendar-text, var(--biz-primary-variant, #1a2a5e));
}

.picker-actions {
  display: flex;
  justify-content: space-between;
  gap: 16px;
}

.btn-close-picker {
  flex: 0.35;
  padding: 12px;
  border-radius: 8px;
  border: none;
  background: #F0F0F5;
  color: var(--biz-calendar-text, var(--biz-primary-variant, #1a2a5e));
  font-weight: 500;
  font-size: 16px;
  cursor: pointer;
}

.btn-confirm-picker {
  flex: 0.65;
  padding: 12px;
  border-radius: 8px;
  border: none;
  background: var(--biz-primary-color, var(--biz-primary, #003399));
  color: white;
  font-weight: 600;
  font-size: 16px;
  cursor: pointer;
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

.khmer-subtitle {
  font-size: 14px;
  color: rgba(26, 42, 94, 0.7);
  margin-bottom: 16px;
}

.khmer-subtitle-placeholder {
  height: 20px;
  margin-bottom: 16px;
}

.weekdays {
  display: grid;
  grid-template-columns: repeat(7, 1fr);
  margin-bottom: 8px;
}

.weekday {
  text-align: center;
  font-size: 13px;
  font-weight: 600;
  color: var(--biz-calendar-text, var(--biz-primary-variant, #1a2a5e));
}

.weekday.is-sunday {
  color: var(--biz-danger-color, #ff4d4f);
}

.calendar-grid-container {
  position: relative;
  min-height: 400px; /* Ensure enough height for the absolute grids during transition */
  width: 100%;
  overflow: hidden;
}

.calendar-grid {
  display: grid;
  width: 100%;
  grid-template-columns: repeat(7, 1fr);
}

.day-cell-wrapper {
  padding: 2px 0;
}

.day-cell {
  height: var(--biz-calendar-cell-height);
  display: flex;
  justify-content: center;
  align-items: center;
  cursor: pointer;
  transition: background 0.2s;
  position: relative;
}

.day-cell.hidden {
  visibility: hidden;
}

.day-cell.is-disabled {
  opacity: var(--biz-calendar-day-disabled-opacity, 0.3);
  cursor: not-allowed;
}

.day-cell.is-sunday .gregorian-day {
  color: var(--biz-danger-color, #ff4d4f);
}

.day-content {
  position: relative;
  width: calc(100% - 4px);
  height: 100%;
  border-radius: 4px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}

/* Single & Range Start/End Selection */
.day-cell.is-selected .day-content {
  background: var(--biz-calendar-selected-bg);
  color: var(--biz-calendar-selected-text);
}

.day-cell.is-selected .gregorian-day,
.day-cell.is-selected .lunar-day,
.day-cell.is-selected .lunar-month {
  color: var(--biz-calendar-selected-text) !important;
}

/* Range Background Highlights */
.day-cell.is-in-range {
  background: var(--biz-calendar-range-bg);
}

.day-cell.is-range-start {
  background: linear-gradient(to right, transparent 50%, var(--biz-calendar-range-bg) 50%);
}

.day-cell.is-range-end {
  background: linear-gradient(to left, transparent 50%, var(--biz-calendar-range-bg) 50%);
}

.day-cell.is-range-start.is-range-end {
  background: transparent;
}

/* Today Outline */
.day-cell.is-today:not(.is-selected) .day-content {
  border: 1px solid var(--biz-calendar-today-border);
}

.lunar-day {
  position: absolute;
  top: 4px;
  left: 2px;
  right: 2px;
  text-align: center;
  font-size: 7px;
  transform: scale(0.9);
  transform-origin: center bottom;
  color: var(--biz-calendar-subtitle-color);
  white-space: nowrap;
  overflow: visible;
}

.gregorian-day {
  font-size: 18px;
}

.lunar-month {
  position: absolute;
  bottom: 4px;
  left: 2px;
  right: 2px;
  text-align: center;
  font-size: 7px;
  transform: scale(0.9);
  transform-origin: center bottom;
  color: var(--biz-calendar-subtitle-color);
  white-space: nowrap;
  overflow: visible;
}

.special-dot {
  position: absolute;
  top: 4px;
  right: 4px;
  width: 6px;
  height: 6px;
  border-radius: 50%;
  background: var(--biz-calendar-special-color);
}

/* Transitions */
.slide-left-enter-active,
.slide-left-leave-active,
.slide-right-enter-active,
.slide-right-leave-active,
.fade-enter-active,
.fade-leave-active {
  transition: all 0.3s ease;
}

/* When sliding left (next month), new item comes from right, old leaves to left */
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

/* When sliding right (prev month), new item comes from left, old leaves to right */
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

.fade-enter-from, .fade-leave-to {
  opacity: 0;
  position: absolute;
}

/* Action Buttons */
.action-buttons {
  display: flex;
  justify-content: flex-end;
  gap: 16px;
  margin-top: 16px;
  padding: 8px;
}

.btn-cancel {
  background: transparent;
  border: none;
  font-size: 14px;
  font-weight: 600;
  cursor: pointer;
  color: var(--biz-calendar-text, var(--biz-primary-variant, #1a2a5e));
}

.btn-confirm {
  background: var(--biz-danger-color, #ff4d4f);
  color: white;
  border: none;
  padding: 8px 16px;
  border-radius: 4px;
  font-weight: 600;
  cursor: pointer;
}
</style>
