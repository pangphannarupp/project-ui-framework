<template>
  <div class="pp-select-wrapper" :class="[
    `pp-select--${variant}`,
    { 'pp-select--error': error },
    { 'pp-select--disabled': disabled }
  ]" ref="selectWrapper">
    <label v-if="label" class="pp-select-label">
      {{ label }} <span v-if="required" class="pp-select-required">*</span>
    </label>
    
    <div 
      :class="['pp-select-container', { 'pp-select-container--focused': isFocused || isOpen }]"
      @click="toggleDropdown"
      tabindex="0"
      @keydown.enter="toggleDropdown"
      @keydown.space.prevent="toggleDropdown"
      @keydown.esc="closeDropdown"
    >
      <span class="pp-select-icon pp-select-icon--left" v-if="$slots.iconLeft || iconLeft">
        <slot name="iconLeft">
          <IonIcon v-if="iconLeft" :icon="iconLeft"></IonIcon>
        </slot>
      </span>
      
      <div class="pp-select-input pp-select-display" :class="{ 'is-placeholder': !selectedOptionLabel }">
        {{ selectedOptionLabel || placeholder }}
      </div>
      
      <div class="pp-select-actions">
        <span class="pp-select-icon pp-select-icon--right" :class="{ 'is-open': isOpen }">
          <slot name="iconRight">
            <IonIcon :icon="chevronDownOutline" />
          </slot>
        </span>
      </div>
    </div>

    <!-- Dropdown Menu -->
    <Transition name="pp-dropdown">
      <div v-if="isOpen" class="pp-select-dropdown">
        <div 
          v-for="option in options" 
          :key="option.value"
          class="pp-select-option"
          :class="{ 'is-selected': option.value === modelValue }"
          @click.stop="selectOption(option)"
        >
          <span class="pp-select-option-label">{{ option.label }}</span>
          <IonIcon v-if="option.value === modelValue" :icon="checkmarkOutline" class="pp-select-check" />
        </div>
        <div v-if="!options || options.length === 0" class="pp-select-no-options">
          No options available
        </div>
      </div>
    </Transition>
    
    <div class="pp-select-helper" v-if="helperText || error">
      <span class="pp-select-message" :class="{ 'pp-select-message--error': error }">
        {{ error || helperText }}
      </span>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted, onUnmounted } from 'vue';
import { IonIcon } from '@ionic/vue';
import { chevronDownOutline, checkmarkOutline } from 'ionicons/icons';

export interface SelectOption {
  label: string;
  value: string | number;
}

const props = withDefaults(defineProps<{
  modelValue?: string | number;
  options?: SelectOption[];
  label?: string;
  placeholder?: string;
  variant?: 'outlined' | 'filled';
  disabled?: boolean;
  error?: string;
  helperText?: string;
  required?: boolean;
  iconLeft?: string;
}>(), {
  modelValue: '',
  options: () => [],
  variant: 'outlined',
  disabled: false,
  required: false
});

const emit = defineEmits(['update:modelValue', 'change', 'focus', 'blur']);

const selectWrapper = ref<HTMLElement | null>(null);
const isOpen = ref(false);
const isFocused = ref(false);

const selectedOptionLabel = computed(() => {
  const selected = props.options.find(opt => opt.value === props.modelValue);
  return selected ? selected.label : '';
});

const toggleDropdown = () => {
  if (props.disabled) return;
  isOpen.value = !isOpen.value;
  isFocused.value = isOpen.value;
  if (isOpen.value) {
    emit('focus');
  } else {
    emit('blur');
  }
};

const closeDropdown = () => {
  if (isOpen.value) {
    isOpen.value = false;
    isFocused.value = false;
    emit('blur');
  }
};

const selectOption = (option: SelectOption) => {
  emit('update:modelValue', option.value);
  emit('change', option.value);
  closeDropdown();
};

const handleClickOutside = (event: MouseEvent) => {
  if (selectWrapper.value && !selectWrapper.value.contains(event.target as Node)) {
    closeDropdown();
  }
};

onMounted(() => {
  document.addEventListener('click', handleClickOutside);
});

onUnmounted(() => {
  document.removeEventListener('click', handleClickOutside);
});
</script>

<style scoped>
.pp-select-wrapper {
  display: flex;
  flex-direction: column;
  gap: 6px;
  margin-bottom: 16px;
  width: 100%;
  position: relative;
}

.pp-select-label {
  font-size: 14px;
  color: #333333;
  font-weight: 500;
  display: flex;
  align-items: center;
}

.pp-select-required {
  color: #dc3545;
  margin-left: 4px;
}

.pp-select-container {
  display: flex;
  align-items: center;
  transition: all 0.2s ease-in-out;
  height: 52px;
  padding: 0 16px;
  position: relative;
  cursor: pointer;
  outline: none;
}

/* OUTLINED VARIANT (Default) */
.pp-select--outlined .pp-select-container {
  border: 1px solid #cccccc;
  border-radius: 12px;
  background-color: #ffffff;
}
.pp-select--outlined .pp-select-container--focused {
  border-color: var(--pp-primary-variant, #1a2a5e);
  box-shadow: 0 0 0 2px rgba(26, 42, 94, 0.1);
}

/* FILLED VARIANT */
.pp-select--filled .pp-select-container {
  border: 1px solid transparent;
  border-radius: 12px;
  background-color: #f5f5f5;
}
.pp-select--filled .pp-select-container--focused {
  background-color: #ffffff;
  border-color: var(--pp-primary-variant, #1a2a5e);
  box-shadow: 0 0 0 2px rgba(26, 42, 94, 0.1);
}

/* ERROR STATE */
.pp-select--error .pp-select-container {
  border-color: #dc3545 !important;
}
.pp-select--error .pp-select-label {
  color: #dc3545;
}

/* DISABLED STATE */
.pp-select--disabled {
  opacity: 0.6;
  cursor: not-allowed;
}
.pp-select--disabled .pp-select-container {
  background-color: #f9f9f9;
  border-color: #e0e0e0;
}
.pp-select--disabled .pp-select-input {
  cursor: not-allowed;
}

.pp-select-icon {
  display: flex;
  align-items: center;
  color: #999999;
  pointer-events: none;
  transition: transform 0.2s ease;
}
.pp-select-icon :deep(svg),
.pp-select-icon :deep(ion-icon) {
  width: 20px;
  height: 20px;
  fill: currentColor;
}
.pp-select-icon--left {
  margin-right: 12px;
}
.pp-select-icon--right {
  margin-left: 12px;
}
.pp-select-icon--right.is-open {
  transform: rotate(180deg);
}

.pp-select-display {
  flex: 1;
  font-size: 16px;
  color: #333333;
  width: 100%;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  user-select: none;
}
.pp-select-display.is-placeholder {
  color: #999999;
}

.pp-select-actions {
  display: flex;
  align-items: center;
  gap: 8px;
  pointer-events: none;
}

/* Dropdown Menu */
.pp-select-dropdown {
  position: absolute;
  top: calc(100% + 4px);
  left: 0;
  right: 0;
  background: #ffffff;
  border: 1px solid #e0e0e0;
  border-radius: 12px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
  z-index: 1000;
  max-height: 250px;
  overflow-y: auto;
  padding: 8px 0;
}

.pp-select-option {
  padding: 12px 16px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  cursor: pointer;
  transition: background-color 0.2s ease;
  font-size: 15px;
  color: #333333;
}
.pp-select-option:hover {
  background-color: #f5f7fa;
}
.pp-select-option.is-selected {
  background-color: rgba(26, 42, 94, 0.05);
  color: var(--pp-primary-variant, #1a2a5e);
  font-weight: 500;
}

.pp-select-check {
  color: var(--pp-primary-variant, #1a2a5e);
  width: 18px;
  height: 18px;
}

.pp-select-no-options {
  padding: 16px;
  text-align: center;
  color: #999999;
  font-size: 14px;
}

/* Transitions */
.pp-dropdown-enter-active,
.pp-dropdown-leave-active {
  transition: opacity 0.2s ease, transform 0.2s ease;
}
.pp-dropdown-enter-from,
.pp-dropdown-leave-to {
  opacity: 0;
  transform: translateY(-10px);
}

.pp-select-helper {
  font-size: 12px;
  margin-top: 2px;
}
.pp-select-message {
  color: #666666;
}
.pp-select-message--error {
  color: #dc3545;
}
</style>
