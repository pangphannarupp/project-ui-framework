<template>
  <div class="pp-picker-wrapper" ref="wrapperRef">
    <div class="trigger" @click.stop="toggleCalendar">
      <slot name="trigger" :value="formattedText">
        <div class="default-input">
          <input 
            type="text" 
            :value="formattedText" 
            :placeholder="placeholder"
            readonly
            class="pp-picker-input"
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
        <PPYearPicker
          :initialYear="modelValue?.year || new Date().getFullYear()"
          @year-selected="onYearSelected"
        />
      </div>
    </transition>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted, onUnmounted } from 'vue';
import PPYearPicker from './PPYearPicker.vue';

const props = withDefaults(defineProps<{
  modelValue?: { year: number } | null;
  placeholder?: string;
  clearable?: boolean;
  format?: (val: { year: number }) => string;
}>(), {
  modelValue: null,
  placeholder: 'Select a year',
  clearable: true,
});

const emit = defineEmits<{
  (e: 'update:modelValue', value: { year: number } | null): void;
}>();

const isOpen = ref(false);
const wrapperRef = ref<HTMLElement | null>(null);
const menuRef = ref<HTMLElement | null>(null);

const formattedText = computed(() => {
  if (!props.modelValue) return '';
  if (props.format) return props.format(props.modelValue);
  return `${props.modelValue.year}`;
});

const toggleCalendar = () => {
  isOpen.value = !isOpen.value;
};

const onYearSelected = (payload: { year: number }) => {
  emit('update:modelValue', payload);
  isOpen.value = false;
};

const clearValue = () => {
  emit('update:modelValue', null);
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
