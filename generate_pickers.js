const fs = require('fs');
const path = require('path');

const componentsDir = path.join(__dirname, 'web/ui-framework/src/components');

const templates = [
  {
    name: 'PPKhmerDatePicker',
    innerComponent: 'PPKhmerCalendar',
    modelType: 'Date | null',
    emits: `(e: 'update:modelValue', value: Date | null): void;`,
    eventHandler: `const onDateSelected = (payload: { date: Date, khmerDate: any, fullText: string }) => {
  emit('update:modelValue', payload.date);
  isOpen.value = false;
};`,
    innerTemplate: `<PPKhmerCalendar
          :config="calendarConfig"
          :initialDate="modelValue || new Date()"
          @date-selected="onDateSelected"
        />`,
    scriptExtras: `const calendarConfig = {
  selectionMode: 'Single' as const,
  firstDayOfWeek: 0
};`,
    formatLogic: `
  const d = props.modelValue;
  const day = d.getDate().toString().padStart(2, '0');
  const month = d.toLocaleString('en-US', { month: 'short' });
  const year = d.getFullYear();
  return \`\${day} \${month}, \${year}\`;`
  },
  {
    name: 'PPMonthPickerInput',
    innerComponent: 'PPMonthPicker',
    modelType: '{ year: number, month: number } | null',
    emits: `(e: 'update:modelValue', value: { year: number, month: number } | null): void;`,
    eventHandler: `const onMonthSelected = (payload: { year: number, month: number }) => {
  emit('update:modelValue', payload);
  isOpen.value = false;
};`,
    innerTemplate: `<PPMonthPicker
          :initialYear="modelValue?.year || new Date().getFullYear()"
          @month-selected="onMonthSelected"
        />`,
    scriptExtras: ``,
    formatLogic: `
  const d = props.modelValue;
  return \`\${String(d.month).padStart(2, '0')}/\${d.year}\`;`
  },
  {
    name: 'PPYearPickerInput',
    innerComponent: 'PPYearPicker',
    modelType: '{ year: number } | null',
    emits: `(e: 'update:modelValue', value: { year: number } | null): void;`,
    eventHandler: `const onYearSelected = (payload: { year: number }) => {
  emit('update:modelValue', payload);
  isOpen.value = false;
};`,
    innerTemplate: `<PPYearPicker
          :initialYear="modelValue?.year || new Date().getFullYear()"
          @year-selected="onYearSelected"
        />`,
    scriptExtras: ``,
    formatLogic: `
  return \`\${props.modelValue.year}\`;`
  },
  {
    name: 'PPQuarterPickerInput',
    innerComponent: 'PPQuarterPicker',
    modelType: '{ year: number, quarter: number } | null',
    emits: `(e: 'update:modelValue', value: { year: number, quarter: number } | null): void;`,
    eventHandler: `const onQuarterSelected = (payload: { year: number, quarter: number }) => {
  emit('update:modelValue', payload);
  isOpen.value = false;
};`,
    innerTemplate: `<PPQuarterPicker
          :initialYear="modelValue?.year || new Date().getFullYear()"
          @quarter-selected="onQuarterSelected"
        />`,
    scriptExtras: ``,
    formatLogic: `
  const d = props.modelValue;
  return \`Q\${d.quarter} \${d.year}\`;`
  },
  {
    name: 'PPTimePickerInput',
    innerComponent: 'PPTimePicker',
    modelType: 'string | null',
    emits: `(e: 'update:modelValue', value: string | null): void;`,
    eventHandler: `const onConfirm = (value: string) => {
  emit('update:modelValue', value);
  isOpen.value = false;
};
const onCancel = () => {
  isOpen.value = false;
};`,
    innerTemplate: `<PPTimePicker
          :modelValue="modelValue || '12:00'"
          :showActionButtons="true"
          @confirm="onConfirm"
          @cancel="onCancel"
        />`,
    scriptExtras: ``,
    formatLogic: `
  return props.modelValue;`
  },
  {
    name: 'PPDateRangePickerInput',
    innerComponent: 'PPDateRangePicker',
    modelType: '{ start: Date | null, end: Date | null, presetId?: string } | null',
    emits: `(e: 'update:modelValue', value: { start: Date | null, end: Date | null, presetId?: string } | null): void;`,
    eventHandler: `const onRangeUpdate = (payload: { start: Date | null, end: Date | null, presetId?: string }) => {
  emit('update:modelValue', payload);
  // Optional: close if both start and end are selected, but for range picker usually better to let user click outside
};`,
    innerTemplate: `<PPDateRangePicker
          :modelValue="modelValue || { start: null, end: null }"
          @update:modelValue="onRangeUpdate"
        />`,
    scriptExtras: ``,
    formatLogic: `
  const v = props.modelValue;
  if (!v.start && !v.end) return '';
  const formatD = (d: Date | null) => d ? \`\${d.getFullYear()}-\${String(d.getMonth()+1).padStart(2,'0')}-\${String(d.getDate()).padStart(2,'0')}\` : '?';
  return \`\${formatD(v.start)} to \${formatD(v.end)}\`;`
  },
  {
    name: 'PPColorPickerInput',
    innerComponent: 'PPColorPicker',
    modelType: 'string | null',
    emits: `(e: 'update:modelValue', value: string | null): void;`,
    eventHandler: `const onColorUpdate = (payload: string) => {
  emit('update:modelValue', payload);
};`,
    innerTemplate: `<PPColorPicker
          :modelValue="modelValue || '#000000'"
          @update:modelValue="onColorUpdate"
        />`,
    scriptExtras: ``,
    formatLogic: `
  return props.modelValue;`
  }
];

const baseTemplate = (config) => `<template>
  <div class="pp-picker-wrapper" ref="wrapperRef">
    <div class="trigger" @click.stop="toggleCalendar">
      <slot name="trigger" :value="formattedText">
        <div class="default-input">
          <!-- Color specific prefix dot if needed, but generic is fine for now -->
          \${config.name === 'PPColorPickerInput' ? '<div v-if="modelValue" class="color-dot" :style="{ backgroundColor: modelValue }"></div>' : ''}
          <input 
            type="text" 
            :value="formattedText" 
            :placeholder="placeholder"
            readonly
            class="pp-picker-input"
            \${config.name === 'PPColorPickerInput' ? 'style="padding-left: 36px;"' : ''}
          />
          <button v-if="modelValue && clearable" @click.stop="clearValue" class="clear-btn">
            <svg viewBox="0 0 24 24" width="14" height="14" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><path d="M18 6L6 18M6 6l12 12"></path></svg>
          </button>
        </div>
      </slot>
    </div>

    <transition name="menu-fade">
      <div
        v-if="isOpen"
        class="pp-picker-menu"
        ref="menuRef"
      >
        ${config.innerTemplate}
      </div>
    </transition>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted, onUnmounted } from 'vue';
import ${config.innerComponent} from './${config.innerComponent}.vue';

const props = withDefaults(defineProps<{
  modelValue?: ${config.modelType};
  placeholder?: string;
  clearable?: boolean;
  format?: (val: any) => string;
}>(), {
  modelValue: null,
  placeholder: 'Select...',
  clearable: true,
});

const emit = defineEmits<{
  ${config.emits}
}>();

const isOpen = ref(false);
const wrapperRef = ref<HTMLElement | null>(null);
const menuRef = ref<HTMLElement | null>(null);

${config.scriptExtras}

const formattedText = computed(() => {
  if (!props.modelValue) return '';
  if (props.format) return props.format(props.modelValue);
  ${config.formatLogic}
});

const toggleCalendar = () => {
  isOpen.value = !isOpen.value;
};

${config.eventHandler}

const clearValue = () => {
  emit('update:modelValue', null as any);
};

const closeOnOutsideClick = (e: MouseEvent) => {
  if (
    isOpen.value &&
    wrapperRef.value && !wrapperRef.value.contains(e.target as Node) &&
    menuRef.value && !menuRef.value.contains(e.target as Node)
  ) {
    isOpen.value = false;
  }
};

onMounted(() => {
  document.addEventListener('click', closeOnOutsideClick);
});

onUnmounted(() => {
  document.removeEventListener('click', closeOnOutsideClick);
});
</script>

<style scoped>
.pp-picker-wrapper {
  position: relative;
  display: inline-block;
  width: 100%;
}
.trigger {
  cursor: pointer;
}
.default-input {
  position: relative;
  display: flex;
  align-items: center;
}
.pp-picker-input {
  width: 100%;
  padding: 12px 16px;
  border: 1px solid #d1d5db;
  border-radius: 8px;
  font-size: 16px;
  font-family: inherit;
  font-weight: 500;
  color: #111827;
  background-color: #fff;
  cursor: pointer;
  outline: none;
  transition: all 0.2s ease;
}
.pp-picker-input:focus {
  border-color: #3b82f6;
  box-shadow: 0 0 0 2px rgba(59, 130, 246, 0.2);
}
.color-dot {
  position: absolute;
  left: 12px;
  width: 16px;
  height: 16px;
  border-radius: 4px;
  border: 1px solid #e5e7eb;
}
.clear-btn {
  position: absolute;
  right: 12px;
  background: #f3f4f6;
  border: none;
  border-radius: 50%;
  width: 24px;
  height: 24px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #9ca3af;
  cursor: pointer;
  padding: 0;
  transition: all 0.2s;
}
.clear-btn:hover {
  background: #e5e7eb;
  color: #4b5563;
}
.pp-picker-menu {
  position: absolute;
  top: calc(100% + 8px);
  left: 0;
  z-index: 1000;
  background-color: #ffffff;
  border: 1px solid #e5e7eb;
  border-radius: 12px;
  box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.1), 0 8px 10px -6px rgba(0, 0, 0, 0.1);
  padding: 12px;
  min-width: 300px;
}
.menu-fade-enter-active,
.menu-fade-leave-active {
  transition: opacity 0.2s ease, transform 0.2s ease;
}
.menu-fade-enter-from,
.menu-fade-leave-to {
  opacity: 0;
  transform: translateY(-8px);
}
</style>
`;

templates.forEach(t => {
  fs.writeFileSync(path.join(componentsDir, \`\${t.name}.vue\`), baseTemplate(t));
  console.log(\`Generated \${t.name}.vue\`);
});
