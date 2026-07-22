<template>
  <div class="pp-year-picker" :class="{ 'hide-actions': !showActionButtons }">
    <!-- Header Row -->
    <div class="picker-header" v-if="title">
      <div class="year-title">{{ title }}</div>
    </div>
    
    <!-- Year Wheels -->
    <div class="year-wheels-container">
      <div class="selection-overlay"></div>
      
      <!-- Start Year / Single Year Wheel -->
      <div class="wheel" ref="startWheel" @scroll="onStartScroll">
        <div class="wheel-padding"></div>
        <div 
          v-for="y in yearsList" 
          :key="'start-'+y" 
          class="wheel-item"
          :class="{ 'is-selected': internalStartYear === y }"
          @click="selectStart(y)"
        >
          {{ y }}
        </div>
        <div class="wheel-padding"></div>
      </div>
      
      <!-- End Year Wheel (Range Mode only) -->
      <template v-if="config.selectionMode === 'Range'">
        <div class="wheel-separator">-</div>
        <div class="wheel" ref="endWheel" @scroll="onEndScroll">
          <div class="wheel-padding"></div>
          <div 
            v-for="y in yearsList" 
            :key="'end-'+y" 
            class="wheel-item"
            :class="{ 'is-selected': internalEndYear === y }"
            @click="selectEnd(y)"
          >
            {{ y }}
          </div>
          <div class="wheel-padding"></div>
        </div>
      </template>
    </div>

    <!-- Actions -->
    <div class="action-buttons" v-if="showActionButtons">
      <button class="btn-cancel" @click="onCancel">Cancel</button>
      <button class="btn-confirm" @click="onConfirmAction">Confirm</button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, watch, onMounted, nextTick } from 'vue';

export interface YearSelection {
  year: number;
}

export interface YearPickerConfig {
  selectionMode?: 'Single' | 'Range';
  minYear?: number | null;
  maxYear?: number | null;
}

const props = withDefaults(defineProps<{
  config?: YearPickerConfig;
  initialYear?: number;
  initialEndYear?: number;
  title?: string;
  showActionButtons?: boolean;
}>(), {
  config: () => ({ selectionMode: 'Single' }),
  initialYear: () => new Date().getFullYear(),
  initialEndYear: () => new Date().getFullYear() + 1,
  showActionButtons: false
});

const emit = defineEmits<{
  (e: 'year-selected', selection: YearSelection): void;
  (e: 'range-selected', start: YearSelection | null, end: YearSelection | null): void;
  (e: 'confirm', start: YearSelection | null, end: YearSelection | null): void;
  (e: 'cancel'): void;
}>();

const ITEM_HEIGHT = 40; // px height of one item

const min = props.config.minYear || 1900;
const max = props.config.maxYear || 2100;
const yearsList = Array.from({ length: max - min + 1 }, (_, i) => min + i);

const internalStartYear = ref(props.initialYear);
const internalEndYear = ref(props.initialEndYear);

const startWheel = ref<HTMLElement | null>(null);
const endWheel = ref<HTMLElement | null>(null);

let isScrolling = false;
let scrollTimeout: any = null;

const onStartScroll = () => {
  if (!startWheel.value || isScrolling) return;
  clearTimeout(scrollTimeout);
  scrollTimeout = setTimeout(() => {
    const index = Math.round(startWheel.value!.scrollTop / ITEM_HEIGHT);
    const y = yearsList[index] || yearsList[0];
    internalStartYear.value = y;
    emitUpdate();
  }, 100);
};

const onEndScroll = () => {
  if (!endWheel.value || isScrolling) return;
  clearTimeout(scrollTimeout);
  scrollTimeout = setTimeout(() => {
    const index = Math.round(endWheel.value!.scrollTop / ITEM_HEIGHT);
    const y = yearsList[index] || yearsList[0];
    internalEndYear.value = y;
    emitUpdate();
  }, 100);
};

const scrollToItem = (wheel: HTMLElement | null, val: number) => {
  if (!wheel) return;
  const index = yearsList.indexOf(val);
  if (index !== -1) {
    isScrolling = true;
    wheel.scrollTo({ top: index * ITEM_HEIGHT, behavior: 'smooth' });
    setTimeout(() => { isScrolling = false; }, 300);
  }
};

const selectStart = (y: number) => {
  internalStartYear.value = y;
  scrollToItem(startWheel.value, y);
  emitUpdate();
};

const selectEnd = (y: number) => {
  internalEndYear.value = y;
  scrollToItem(endWheel.value, y);
  emitUpdate();
};

const emitUpdate = () => {
  if (!props.showActionButtons) {
    if (props.config.selectionMode === 'Single') {
      emit('year-selected', { year: internalStartYear.value });
    } else {
      emit('range-selected', { year: internalStartYear.value }, { year: internalEndYear.value });
    }
  }
};

watch(() => props.initialYear, (newVal) => {
  if (newVal && newVal !== internalStartYear.value) {
    internalStartYear.value = newVal;
    scrollToItem(startWheel.value, newVal);
  }
});

watch(() => props.initialEndYear, (newVal) => {
  if (newVal && newVal !== internalEndYear.value) {
    internalEndYear.value = newVal;
    scrollToItem(endWheel.value, newVal);
  }
});

onMounted(() => {
  nextTick(() => {
    if (startWheel.value) {
      const idx = yearsList.indexOf(internalStartYear.value);
      if (idx !== -1) startWheel.value.scrollTop = idx * ITEM_HEIGHT;
    }
    if (props.config.selectionMode === 'Range' && endWheel.value) {
      const idx = yearsList.indexOf(internalEndYear.value);
      if (idx !== -1) endWheel.value.scrollTop = idx * ITEM_HEIGHT;
    }
  });
});

const onCancel = () => {
  emit('cancel');
};

const onConfirmAction = () => {
  if (props.config.selectionMode === 'Single') {
    emit('year-selected', { year: internalStartYear.value });
    emit('confirm', { year: internalStartYear.value }, null);
  } else {
    emit('range-selected', { year: internalStartYear.value }, { year: internalEndYear.value });
    emit('confirm', { year: internalStartYear.value }, { year: internalEndYear.value });
  }
};
</script>

<style scoped>
.pp-year-picker {
  display: flex;
  flex-direction: column;
  width: 100%;
  background: var(--pp-calendar-bg, #fff);
  padding: 16px;
  border-radius: var(--pp-calendar-radius, 16px);
  user-select: none;
}

.picker-header {
  display: flex;
  justify-content: center;
  align-items: center;
  margin-bottom: 16px;
  padding: 0 8px;
}

.year-title {
  font-size: 16px;
  font-weight: 600;
  color: var(--pp-calendar-text, #333);
}

.year-wheels-container {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 200px;
  position: relative;
  overflow: hidden;
  background: transparent;
}

.selection-overlay {
  position: absolute;
  top: 50%;
  left: 10%;
  right: 10%;
  height: 40px;
  margin-top: -20px;
  background: var(--pp-calendar-range-bg, rgba(255, 77, 79, 0.1));
  border-radius: 8px;
  pointer-events: none;
}

.wheel {
  height: 100%;
  overflow-y: auto;
  scroll-snap-type: y mandatory;
  scrollbar-width: none; /* Firefox */
  flex: 1;
  text-align: center;
}
.wheel::-webkit-scrollbar {
  display: none; /* Safari/Chrome */
}

.wheel-item {
  height: 40px;
  line-height: 40px;
  scroll-snap-align: center;
  font-size: 18px;
  font-weight: 500;
  color: #999;
  transition: all 0.2s ease;
  cursor: pointer;
}

.wheel-item.is-selected {
  font-size: 22px;
  font-weight: 700;
  color: var(--pp-calendar-selected-bg, #ff4d4f);
}

.wheel-padding {
  height: 80px;
}

.wheel-separator {
  font-size: 24px;
  font-weight: 600;
  color: #333;
  padding: 0 8px;
  z-index: 1;
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
