<template>
  <div class="pp-search-wrapper" ref="wrapperRef">
    <div 
      class="pp-search-container" 
      :class="{ 'is-focused': isFocused }"
    >
      <span class="pp-search-icon pp-search-icon--left">
        <ion-icon :icon="searchOutline" />
      </span>
      
      <input
        ref="inputRef"
        class="pp-search-input"
        type="text"
        :value="modelValue"
        :placeholder="placeholder"
        @input="onInput"
        @focus="onFocus"
        @blur="onBlur"
        @keydown.down.prevent="onArrowDown"
        @keydown.up.prevent="onArrowUp"
        @keydown.enter.prevent="onEnter"
        @keydown.esc="closeDropdown"
      />
      
      <div class="pp-search-actions">
        <div v-if="loading" class="pp-search-loading">
          <svg class="spinner" viewBox="0 0 50 50">
            <defs>
              <linearGradient id="spinner-gradient" x1="0%" y1="0%" x2="100%" y2="100%">
                <stop offset="0%" stop-color="#3b82f6" />
                <stop offset="100%" stop-color="#ec4899" />
              </linearGradient>
            </defs>
            <circle class="path" cx="25" cy="25" r="20" fill="none" stroke-width="5"></circle>
          </svg>
        </div>
        <!-- Clear button -->
        <button v-else-if="modelValue" type="button" class="pp-search-action-btn" @mousedown.prevent="clearInput">
          <ion-icon :icon="closeCircle" />
        </button>
      </div>
    </div>

    <!-- Dropdown Menu -->
    <Transition name="dropdown">
      <div v-if="isOpen && (hasHistory || hasResults)" class="pp-search-dropdown">
        <!-- Results View -->
        <template v-if="modelValue">
          <ul v-if="results.length > 0" class="pp-search-list">
            <li 
              v-for="(item, index) in results" 
              :key="index"
              class="pp-search-item"
              :class="{ 'is-active': activeIndex === index }"
              @mousedown.prevent="selectResult(item)"
            >
              <slot name="result" :item="item" :index="index">
                <ion-icon :icon="searchOutline" class="item-icon" />
                <span class="item-label">{{ getLabel(item) }}</span>
              </slot>
            </li>
          </ul>
          <div v-else class="pp-search-empty">
            <slot name="empty">No results found for "{{ modelValue }}"</slot>
          </div>
        </template>
        
        <!-- History View -->
        <template v-else>
          <div class="pp-search-history-header" v-if="hasHistory">
            <span class="history-title">Recent Searches</span>
            <button class="clear-history-btn" @mousedown.prevent="clearHistory">Clear All</button>
          </div>
          <ul class="pp-search-list">
            <li 
              v-for="(item, index) in history" 
              :key="index"
              class="pp-search-item"
              :class="{ 'is-active': activeIndex === index }"
              @mousedown.prevent="selectHistory(item)"
            >
              <slot name="history" :item="item" :index="index">
                <ion-icon :icon="timeOutline" class="item-icon" />
                <span class="item-label">{{ getLabel(item) }}</span>
                <button class="remove-item-btn" @mousedown.prevent.stop="removeHistoryItem(item, index)">
                  <ion-icon :icon="closeOutline" />
                </button>
              </slot>
            </li>
          </ul>
        </template>
      </div>
    </Transition>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted, onUnmounted } from 'vue';
import { IonIcon } from '@ionic/vue';
import { searchOutline, closeCircle, timeOutline, closeOutline } from 'ionicons/icons';

const props = withDefaults(defineProps<{
  modelValue?: string;
  placeholder?: string;
  results?: any[];
  history?: any[];
  loading?: boolean;
  itemLabel?: string;
}>(), {
  modelValue: '',
  placeholder: 'Search...',
  results: () => [],
  history: () => [],
  loading: false,
  itemLabel: 'label'
});

const emit = defineEmits([
  'update:modelValue', 
  'search', 
  'clear-history', 
  'remove-history-item'
]);

const wrapperRef = ref<HTMLElement | null>(null);
const inputRef = ref<HTMLInputElement | null>(null);
const isFocused = ref(false);
const isOpen = ref(false);
const activeIndex = ref(-1);

const hasHistory = computed(() => props.history && props.history.length > 0);
const hasResults = computed(() => props.results && props.results.length > 0);

const getLabel = (item: any) => {
  if (typeof item === 'object' && item !== null) {
    return item[props.itemLabel] || '';
  }
  return String(item);
};

const currentList = computed(() => {
  return props.modelValue ? props.results : props.history;
});

const onInput = (event: Event) => {
  const target = event.target as HTMLInputElement;
  emit('update:modelValue', target.value);
  isOpen.value = true;
  activeIndex.value = -1;
};

const onFocus = () => {
  isFocused.value = true;
  isOpen.value = true;
};

const onBlur = () => {
  isFocused.value = false;
  isOpen.value = false;
  activeIndex.value = -1;
};

const closeDropdown = () => {
  isOpen.value = false;
  activeIndex.value = -1;
  inputRef.value?.blur();
};

const clearInput = () => {
  emit('update:modelValue', '');
  inputRef.value?.focus();
  isOpen.value = true;
  activeIndex.value = -1;
};

const selectResult = (item: any) => {
  emit('search', item);
  isOpen.value = false;
  inputRef.value?.blur();
};

const selectHistory = (item: any) => {
  const label = getLabel(item);
  emit('update:modelValue', label);
  emit('search', item);
  isOpen.value = false;
  inputRef.value?.blur();
};

const clearHistory = () => {
  emit('clear-history');
  // keep input focused
  inputRef.value?.focus();
};

const removeHistoryItem = (item: any, index: number) => {
  emit('remove-history-item', { item, index });
  inputRef.value?.focus();
};

// Keyboard navigation
const onArrowDown = () => {
  if (!isOpen.value) {
    isOpen.value = true;
    return;
  }
  const list = currentList.value;
  if (activeIndex.value < list.length - 1) {
    activeIndex.value++;
  }
};

const onArrowUp = () => {
  if (activeIndex.value > 0) {
    activeIndex.value--;
  }
};

const onEnter = () => {
  if (isOpen.value && activeIndex.value >= 0 && activeIndex.value < currentList.value.length) {
    const item = currentList.value[activeIndex.value];
    if (props.modelValue) {
      selectResult(item);
    } else {
      selectHistory(item);
    }
  } else if (props.modelValue) {
    emit('search', props.modelValue);
    isOpen.value = false;
    inputRef.value?.blur();
  }
};

const handleClickOutside = (event: MouseEvent) => {
  if (wrapperRef.value && !wrapperRef.value.contains(event.target as Node)) {
    isOpen.value = false;
  }
};

onMounted(() => {
  document.addEventListener('mousedown', handleClickOutside);
});

onUnmounted(() => {
  document.removeEventListener('mousedown', handleClickOutside);
});
</script>

<style scoped>
.pp-search-wrapper {
  position: relative;
  display: flex;
  flex-direction: column;
  width: 100%;
}

.pp-search-container {
  display: flex;
  align-items: center;
  background-color: var(--search-bg, #f8fafc);
  border: 1px solid var(--search-border, rgba(226, 232, 240, 0.8));
  border-radius: 24px;
  padding: 0 16px;
  height: 48px;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  box-shadow: inset 0 2px 4px 0 rgba(0, 0, 0, 0.02);
}

.pp-search-container.is-focused {
  background-color: var(--search-bg-focused, #ffffff);
  border-color: transparent;
  background-image: linear-gradient(var(--search-bg-focused, #ffffff), var(--search-bg-focused, #ffffff)), linear-gradient(135deg, #3b82f6, #8b5cf6, #ec4899);
  background-origin: border-box;
  background-clip: padding-box, border-box;
  box-shadow: 0 4px 15px -3px rgba(139, 92, 246, 0.25), 0 2px 6px -2px rgba(139, 92, 246, 0.15);
}

.pp-search-icon {
  display: flex;
  align-items: center;
  color: var(--search-icon, #64748b);
  font-size: 20px;
  transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
}

.pp-search-container.is-focused .pp-search-icon {
  color: #8b5cf6;
  transform: scale(1.1);
}

.pp-search-icon--left {
  margin-right: 12px;
}

.pp-search-input {
  flex: 1;
  border: none;
  outline: none;
  background: transparent;
  font-size: 15px;
  color: var(--search-text, #1e293b);
  width: 100%;
  height: 100%;
}

.pp-search-input::placeholder {
  color: var(--search-placeholder, #94a3b8);
}

.pp-search-actions {
  display: flex;
  align-items: center;
  margin-left: 8px;
}

.pp-search-action-btn {
  background: transparent;
  border: none;
  padding: 4px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: var(--search-icon, #94a3b8);
  cursor: pointer;
  border-radius: 50%;
  transition: color 0.2s;
  font-size: 20px;
}

.pp-search-action-btn:hover {
  color: var(--text-main, #64748b);
}

.pp-search-dropdown {
  position: absolute;
  top: calc(100% + 12px);
  left: 0;
  right: 0;
  background: var(--search-dropdown-bg, rgba(255, 255, 255, 0.95));
  backdrop-filter: blur(16px);
  -webkit-backdrop-filter: blur(16px);
  border: 1px solid var(--search-dropdown-border, rgba(226, 232, 240, 0.8));
  border-radius: 16px;
  box-shadow: 0 20px 40px -10px rgba(0, 0, 0, 0.1), 0 10px 15px -5px rgba(0, 0, 0, 0.05);
  z-index: 1000;
  max-height: 360px;
  overflow-y: auto;
}

.pp-search-history-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 12px 16px 8px;
}

.history-title {
  font-size: 13px;
  font-weight: 600;
  color: var(--search-history-title, #64748b);
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.clear-history-btn {
  background: none;
  border: none;
  font-size: 13px;
  color: transparent;
  background-clip: text;
  -webkit-background-clip: text;
  background-image: linear-gradient(135deg, #3b82f6, #8b5cf6);
  cursor: pointer;
  font-weight: 600;
  padding: 0;
  transition: opacity 0.2s;
}

.clear-history-btn:hover {
  opacity: 0.8;
}

.pp-search-list {
  list-style: none;
  margin: 0;
  padding: 8px 0;
}

.pp-search-item {
  display: flex;
  align-items: center;
  padding: 12px 16px;
  cursor: pointer;
  transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
  margin: 0 8px;
  border-radius: 10px;
}

.pp-search-item.is-active,
.pp-search-item:hover {
  background-color: var(--search-item-hover, rgba(241, 245, 249, 0.8));
  transform: translateX(6px);
  box-shadow: -2px 0 0 0 #8b5cf6;
}

.pp-search-item:active {
  transform: translateX(4px) scale(0.98);
}

.item-icon {
  color: var(--search-item-icon, #94a3b8);
  font-size: 18px;
  margin-right: 12px;
  transition: color 0.2s;
}

.pp-search-item:hover .item-icon {
  color: #8b5cf6;
}

.item-label {
  flex: 1;
  font-size: 15px;
  color: var(--search-item-text, #1e293b);
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.remove-item-btn {
  background: none;
  border: none;
  color: #cbd5e1;
  font-size: 20px;
  display: flex;
  align-items: center;
  cursor: pointer;
  padding: 6px;
  border-radius: 50%;
  opacity: 0;
  transform: scale(0.8);
  transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
}

.pp-search-item:hover .remove-item-btn {
  opacity: 1;
  transform: scale(1);
}

.remove-item-btn:hover {
  color: #ef4444;
  background-color: rgba(239, 68, 68, 0.1);
}

.pp-search-empty {
  padding: 24px 16px;
  text-align: center;
  color: var(--search-empty-text, #64748b);
  font-size: 14px;
}

/* Loading Spinner */
.pp-search-loading {
  width: 20px;
  height: 20px;
}

.spinner {
  animation: rotate 2s linear infinite;
  width: 100%;
  height: 100%;
}

.spinner .path {
  stroke: url(#spinner-gradient);
  stroke-linecap: round;
  animation: dash 1.5s ease-in-out infinite;
}

@keyframes rotate {
  100% { transform: rotate(360deg); }
}

@keyframes dash {
  0% { stroke-dasharray: 1, 150; stroke-dashoffset: 0; }
  50% { stroke-dasharray: 90, 150; stroke-dashoffset: -35; }
  100% { stroke-dasharray: 90, 150; stroke-dashoffset: -124; }
}

/* Dropdown Animation */
.dropdown-enter-active,
.dropdown-leave-active {
  transition: opacity 0.2s ease, transform 0.2s ease;
  transform-origin: top;
}

.dropdown-enter-from,
.dropdown-leave-to {
  opacity: 0;
  transform: scaleY(0.95);
}
</style>
