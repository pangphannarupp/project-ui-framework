<template>
  <div class="biz-autocomplete-wrapper" ref="wrapperRef">
    <label v-if="label" class="biz-input-label">{{ label }}</label>
    <div 
      class="biz-input-container" 
      :class="{ 'biz-input-container--focused': isFocused }"
    >
      <span class="biz-input-icon biz-input-icon--left" v-if="$slots.iconLeft">
        <slot name="iconLeft"></slot>
      </span>
      
      <input
        ref="inputRef"
        class="biz-input"
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
      
      <div class="biz-input-actions">
        <button v-if="modelValue" type="button" class="biz-input-action-btn" @click="clearInput">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <line x1="18" y1="6" x2="6" y2="18"></line>
            <line x1="6" y1="6" x2="18" y2="18"></line>
          </svg>
        </button>
        <span class="biz-input-icon biz-input-icon--right">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" :style="{ transform: isOpen ? 'rotate(180deg)' : 'rotate(0)' }">
            <polyline points="6 9 12 15 18 9"></polyline>
          </svg>
        </span>
      </div>
    </div>

    <!-- Dropdown Menu -->
    <Transition name="dropdown">
      <div v-if="isOpen" class="biz-autocomplete-dropdown">
        <ul v-if="filteredOptions.length > 0" class="biz-autocomplete-list">
          <li 
            v-for="(option, index) in filteredOptions" 
            :key="index"
            class="biz-autocomplete-item"
            :class="{ 'is-active': activeIndex === index }"
            @mousedown.prevent="selectOption(option)"
          >
            {{ getOptionLabel(option) }}
          </li>
        </ul>
        <div v-else class="biz-autocomplete-empty">
          No results found.
        </div>
      </div>
    </Transition>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted, onUnmounted } from 'vue';

const props = withDefaults(defineProps<{
  modelValue?: string;
  label?: string;
  placeholder?: string;
  options?: any[];
  filter?: boolean;
  optionLabel?: string;
  optionValue?: string;
}>(), {
  modelValue: '',
  options: () => [],
  filter: true,
  optionLabel: 'label',
  optionValue: 'value'
});

const emit = defineEmits(['update:modelValue', 'item-select']);

const wrapperRef = ref<HTMLElement | null>(null);
const inputRef = ref<HTMLInputElement | null>(null);
const isFocused = ref(false);
const isOpen = ref(false);
const activeIndex = ref(-1);

// Computed properties
const getOptionLabel = (option: any) => {
  if (typeof option === 'object' && option !== null) {
    return option[props.optionLabel] || '';
  }
  return String(option);
};



const filteredOptions = computed(() => {
  if (!props.filter || !props.modelValue) {
    return props.options;
  }
  const query = props.modelValue.toLowerCase();
  return props.options.filter(option => {
    const label = getOptionLabel(option).toLowerCase();
    return label.includes(query);
  });
});

// Event handlers
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
};

const selectOption = (option: any) => {
  const label = getOptionLabel(option);
  emit('update:modelValue', label);
  emit('item-select', option);
  isOpen.value = false;
  inputRef.value?.blur();
};

// Keyboard navigation
const onArrowDown = () => {
  if (!isOpen.value) {
    isOpen.value = true;
    return;
  }
  if (activeIndex.value < filteredOptions.value.length - 1) {
    activeIndex.value++;
  }
};

const onArrowUp = () => {
  if (activeIndex.value > 0) {
    activeIndex.value--;
  }
};

const onEnter = () => {
  if (isOpen.value && activeIndex.value >= 0 && activeIndex.value < filteredOptions.value.length) {
    selectOption(filteredOptions.value[activeIndex.value]);
  }
};

// Handle clicking outside
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
.biz-autocomplete-wrapper {
  display: flex;
  flex-direction: column;
  gap: 8px;
  margin-bottom: 16px;
  position: relative;
}

.biz-input-label {
  font-size: 14px;
  color: #333333;
  font-weight: 500;
}

.biz-input-container {
  display: flex;
  align-items: center;
  border: 1px solid #cccccc;
  border-radius: 12px;
  background-color: #ffffff;
  padding: 0 16px;
  transition: border-color 0.2s;
  height: 52px;
}

.biz-input-container--focused {
  border-color: var(--biz-primary-variant, #1a2a5e);
}

.biz-input-icon {
  display: flex;
  align-items: center;
  color: #999999;
  transition: transform 0.2s;
}

.biz-input-icon svg {
  width: 20px;
  height: 20px;
}

.biz-input-icon--left {
  margin-right: 12px;
}

.biz-input-icon--right {
  margin-left: 8px;
}

.biz-input {
  flex: 1;
  border: none;
  outline: none;
  background: transparent;
  font-size: 16px;
  color: #333333;
  width: 100%;
  height: 100%;
}

.biz-input::placeholder {
  color: #999999;
}

.biz-input-actions {
  display: flex;
  align-items: center;
  gap: 4px;
}

.biz-input-action-btn {
  background: transparent;
  border: none;
  padding: 4px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #999999;
  cursor: pointer;
  border-radius: 50%;
}

.biz-input-action-btn:hover {
  background: #f5f5f5;
  color: #666666;
}

.biz-input-action-btn svg {
  width: 18px;
  height: 18px;
}

/* Dropdown */
.biz-autocomplete-dropdown {
  position: absolute;
  top: calc(100% + 4px);
  left: 0;
  right: 0;
  background: #ffffff;
  border: 1px solid #e0e0e0;
  border-radius: 12px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
  z-index: 1000;
  max-height: 240px;
  overflow-y: auto;
}

.biz-autocomplete-list {
  list-style: none;
  margin: 0;
  padding: 8px 0;
}

.biz-autocomplete-item {
  padding: 12px 16px;
  font-size: 15px;
  color: #333333;
  cursor: pointer;
  transition: background-color 0.2s;
}

.biz-autocomplete-item:hover,
.biz-autocomplete-item.is-active {
  background-color: #f4f6f9;
  color: var(--biz-primary-variant, #1a2a5e);
}

.biz-autocomplete-empty {
  padding: 16px;
  color: #999999;
  text-align: center;
  font-size: 14px;
}

/* Animations */
.dropdown-enter-active,
.dropdown-leave-active {
  transition: all 0.2s ease;
  transform-origin: top;
}

.dropdown-enter-from,
.dropdown-leave-to {
  opacity: 0;
  transform: scaleY(0.95);
}
</style>
