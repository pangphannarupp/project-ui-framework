<template>
  <div class="pp-time-picker" :class="[`theme-${theme}`, { 'hide-actions': !showActionButtons }]">
    <!-- Header Row -->
    <div class="picker-header" v-if="title">
      <div class="time-title">{{ title }}</div>
    </div>
    
    <!-- Time Wheels -->
    <div class="time-wheels-container">
      <div class="selection-overlay"></div>
      
      <!-- Hours Wheel -->
      <div class="wheel" ref="hourWheel" @scroll="onHourScroll">
        <div class="wheel-padding"></div>
        <div 
          v-for="h in hoursList" 
          :key="h" 
          class="wheel-item"
          :class="{ 'is-selected': selectedHour === h }"
          @click="selectHour(h)"
        >
          {{ h }}
        </div>
        <div class="wheel-padding"></div>
      </div>
      
      <div class="wheel-separator">:</div>
      
      <!-- Minutes Wheel -->
      <div class="wheel" ref="minuteWheel" @scroll="onMinuteScroll">
        <div class="wheel-padding"></div>
        <div 
          v-for="m in minutesList" 
          :key="m" 
          class="wheel-item"
          :class="{ 'is-selected': selectedMinute === m }"
          @click="selectMinute(m)"
        >
          {{ m }}
        </div>
        <div class="wheel-padding"></div>
      </div>
    </div>

    <!-- Action Buttons -->
    <div class="action-buttons" v-if="showActionButtons">
      <button class="btn-cancel" @click="onCancel">Cancel</button>
      <button class="btn-confirm" @click="onConfirmAction">Confirm</button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, watch, onMounted, nextTick } from 'vue';

const props = withDefaults(defineProps<{
  modelValue?: string; // HH:mm format
  title?: string;
  min?: string;
  max?: string;
  showActionButtons?: boolean;
  theme?: 'light' | 'dark' | 'auto';
}>(), {
  modelValue: '12:00',
  showActionButtons: false,
  theme: 'auto',
});

const emit = defineEmits<{
  (e: 'update:modelValue', value: string): void;
  (e: 'change', value: string): void;
  (e: 'cancel'): void;
  (e: 'confirm', value: string): void;
}>();

const ITEM_HEIGHT = 40; // px height of one item

// Parse modelValue
const parseTime = (val: string) => {
  if (!val) return { h: '12', m: '00' };
  const [h, m] = val.split(':');
  return { h: h || '12', m: m || '00' };
};

const internalTime = ref(parseTime(props.modelValue));

const hoursList = Array.from({ length: 24 }, (_, i) => i.toString().padStart(2, '0'));
const minutesList = Array.from({ length: 60 }, (_, i) => i.toString().padStart(2, '0'));

const selectedHour = computed(() => internalTime.value.h);
const selectedMinute = computed(() => internalTime.value.m);

const hourWheel = ref<HTMLElement | null>(null);
const minuteWheel = ref<HTMLElement | null>(null);

let isScrolling = false;

// Debounce scroll events
let scrollTimeout: any = null;

const onHourScroll = () => {
  if (!hourWheel.value || isScrolling) return;
  clearTimeout(scrollTimeout);
  scrollTimeout = setTimeout(() => {
    const index = Math.round(hourWheel.value!.scrollTop / ITEM_HEIGHT);
    const h = hoursList[index] || hoursList[0];
    internalTime.value.h = h;
    emitUpdate();
  }, 100);
};

const onMinuteScroll = () => {
  if (!minuteWheel.value || isScrolling) return;
  clearTimeout(scrollTimeout);
  scrollTimeout = setTimeout(() => {
    const index = Math.round(minuteWheel.value!.scrollTop / ITEM_HEIGHT);
    const m = minutesList[index] || minutesList[0];
    internalTime.value.m = m;
    emitUpdate();
  }, 100);
};

const scrollToItem = (wheel: HTMLElement | null, list: string[], val: string) => {
  if (!wheel) return;
  const index = list.indexOf(val);
  if (index !== -1) {
    isScrolling = true;
    wheel.scrollTo({ top: index * ITEM_HEIGHT, behavior: 'smooth' });
    setTimeout(() => { isScrolling = false; }, 300);
  }
};

const selectHour = (h: string) => {
  internalTime.value.h = h;
  scrollToItem(hourWheel.value, hoursList, h);
  emitUpdate();
};

const selectMinute = (m: string) => {
  internalTime.value.m = m;
  scrollToItem(minuteWheel.value, minutesList, m);
  emitUpdate();
};

const emitUpdate = () => {
  const formatted = `${internalTime.value.h}:${internalTime.value.m}`;
  if (!props.showActionButtons) {
    emit('update:modelValue', formatted);
    emit('change', formatted);
  }
};

watch(() => props.modelValue, (newVal) => {
  if (newVal) {
    const parsed = parseTime(newVal);
    if (parsed.h !== internalTime.value.h || parsed.m !== internalTime.value.m) {
      internalTime.value = parsed;
      scrollToItem(hourWheel.value, hoursList, parsed.h);
      scrollToItem(minuteWheel.value, minutesList, parsed.m);
    }
  }
});

onMounted(() => {
  nextTick(() => {
    if (hourWheel.value) {
      const idx = hoursList.indexOf(internalTime.value.h);
      if (idx !== -1) hourWheel.value.scrollTop = idx * ITEM_HEIGHT;
    }
    if (minuteWheel.value) {
      const idx = minutesList.indexOf(internalTime.value.m);
      if (idx !== -1) minuteWheel.value.scrollTop = idx * ITEM_HEIGHT;
    }
  });
});

const onCancel = () => {
  emit('cancel');
};

const onConfirmAction = () => {
  const formatted = `${internalTime.value.h}:${internalTime.value.m}`;
  emit('update:modelValue', formatted);
  emit('change', formatted);
  emit('confirm', formatted);
};
</script>

<style scoped>
.pp-time-picker {
  /* Default Theme Variables */
  --time-picker-bg: var(--pp-calendar-bg, #fff);
  --time-picker-text: var(--pp-calendar-text, #333);
  --time-picker-sep: #333;
  --time-picker-btn-cancel-bg: #f4f5f8;
  --time-picker-btn-cancel-text: var(--pp-calendar-btn-cancel-text, #666);

  display: flex;
  flex-direction: column;
  width: 100%;
  background: var(--time-picker-bg);
  padding: 16px;
  border-radius: var(--pp-calendar-radius, 16px);
  user-select: none;
}

/* Dark Theme Variables */
.pp-time-picker.theme-dark {
  --time-picker-bg: var(--pp-calendar-bg, transparent);
  --time-picker-text: var(--pp-calendar-text, #fff);
  --time-picker-sep: #fff;
  --time-picker-btn-cancel-bg: #333;
  --time-picker-btn-cancel-text: #ccc;
}

@media (prefers-color-scheme: dark) {
  .pp-time-picker.theme-auto {
    --time-picker-bg: var(--pp-calendar-bg, transparent);
    --time-picker-text: var(--pp-calendar-text, #fff);
    --time-picker-sep: #fff;
    --time-picker-btn-cancel-bg: #333;
    --time-picker-btn-cancel-text: #ccc;
  }
}

.picker-header {
  display: flex;
  justify-content: center;
  align-items: center;
  margin-bottom: 16px;
  padding: 0 8px;
}

.time-title {
  font-size: 16px;
  font-weight: 600;
  color: var(--time-picker-text);
}

.time-wheels-container {
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
  background: var(--pp-calendar-range-bg, rgba(0, 122, 255, 0.1));
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
  color: var(--pp-calendar-selected-bg, #007aff);
}

.wheel-padding {
  height: 80px;
}

.wheel-separator {
  font-size: 24px;
  font-weight: 600;
  color: var(--time-picker-sep);
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
  background: var(--time-picker-btn-cancel-bg);
  color: var(--time-picker-btn-cancel-text);
}

.btn-confirm {
  background: var(--pp-calendar-btn-confirm-bg, var(--pp-primary-color, var(--pp-primary, #003399)));
  color: var(--pp-calendar-btn-confirm-text, #ffffff);
}
</style>
