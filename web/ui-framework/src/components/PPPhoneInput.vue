<template>
  <div class="pp-phone-input-wrapper">
    <div v-if="label" class="pp-input-label">{{ label }}</div>
    <div 
      :class="[
        'pp-phone-input-container',
        `pp-phone-input-container--${variant}`,
        `pp-phone-input-container--${size}`,
        { 'pp-phone-input-container--focused': isFocused },
        { 'pp-phone-input-container--rounded': rounded }
      ]"
    >
      
      <button class="country-selector" @click="$emit('select-country')">
        <span class="country-code">{{ countryCode }}</span>
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="chevron-down">
          <polyline points="6 9 12 15 18 9"></polyline>
        </svg>
      </button>

      <div class="separator"></div>

      <input 
        class="pp-phone-input"
        type="tel"
        :value="displayValue"
        :placeholder="placeholder"
        @input="onInput"
        @focus="onFocus"
        @blur="onBlur"
      />

      <button 
        v-if="clearable && modelValue" 
        class="clear-btn" 
        @click="clear"
      >
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <line x1="18" y1="6" x2="6" y2="18"></line>
          <line x1="6" y1="6" x2="18" y2="18"></line>
        </svg>
      </button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

const props = defineProps({
  modelValue: {
    type: String,
    default: ''
  },
  countryCode: {
    type: String,
    default: '+855'
  },
  label: {
    type: String,
    default: ''
  },
  placeholder: {
    type: String,
    default: ''
  },
  clearable: {
    type: Boolean,
    default: true
  },
  format: {
    type: String,
    default: ''
  },
  variant: {
    type: String,
    default: 'outline' // 'outline', 'filled', 'underlined'
  },
  size: {
    type: String,
    default: 'md' // 'sm', 'md', 'lg'
  },
  rounded: {
    type: Boolean,
    default: false
  }
});

const emit = defineEmits(['update:modelValue', 'clear', 'focus', 'blur', 'select-country']);

const isFocused = ref(false);

const onFocus = (event: FocusEvent) => {
  isFocused.value = true;
  emit('focus', event);
};

const onBlur = (event: FocusEvent) => {
  isFocused.value = false;
  emit('blur', event);
};

const formatValue = (val: string, formatStr: string) => {
  if (!val) return '';
  const digits = val.replace(/\D/g, '');
  if (!formatStr) return digits;
  
  let formatted = '';
  let digitIndex = 0;
  
  const maskChar = formatStr.includes('#') ? '#' : (formatStr.includes('8') ? '8' : (formatStr.includes('X') ? 'X' : 'x'));
  if (!maskChar) return digits;

  for (let i = 0; i < formatStr.length; i++) {
    if (digitIndex >= digits.length) break;
    if (formatStr[i] === maskChar) {
      formatted += digits[digitIndex];
      digitIndex++;
    } else {
      formatted += formatStr[i];
    }
  }
  return formatted;
};

const displayValue = computed(() => formatValue(props.modelValue, props.format));

const onInput = (event: Event) => {
  const target = event.target as HTMLInputElement;
  const digits = target.value.replace(/\D/g, '');
  const formatted = formatValue(digits, props.format);
  
  if (target.value !== formatted) {
    target.value = formatted;
  }
  emit('update:modelValue', digits);
};

const clear = () => {
  emit('update:modelValue', '');
  emit('clear');
};
</script>

<style scoped>
.pp-phone-input-wrapper {
  display: flex;
  flex-direction: column;
  gap: 8px;
  width: 100%;
}

.pp-input-label {
  font-size: 13px;
  color: #333;
  font-weight: 500;
}

.pp-phone-input-container {
  display: flex;
  align-items: center;
  overflow: hidden;
  transition: all 0.2s ease;
}

/* Variants */
.pp-phone-input-container--outline {
  border: 1px solid #cccccc;
  border-radius: 12px;
  background-color: #ffffff;
}
.pp-phone-input-container--outline.pp-phone-input-container--focused {
  border-color: #0066cc; /* Active blue border based on design */
  box-shadow: 0 0 0 2px rgba(0, 102, 204, 0.1);
}

.pp-phone-input-container--filled {
  border: 1px solid transparent;
  border-radius: 12px;
  background-color: #f1f3f5;
}
.pp-phone-input-container--filled.pp-phone-input-container--focused {
  background-color: #e9ecef;
  border-color: #0066cc;
}

.pp-phone-input-container--underlined {
  border: none;
  border-bottom: 2px solid #e0e0e0;
  border-radius: 0;
  background-color: transparent;
}
.pp-phone-input-container--underlined.pp-phone-input-container--focused {
  border-bottom-color: #0066cc;
}

/* Sizes */
.pp-phone-input-container--sm { height: 40px; }
.pp-phone-input-container--md { height: 50px; } /* Kept 50px for backwards compatibility with screenshot */
.pp-phone-input-container--lg { height: 64px; }

/* Rounded */
.pp-phone-input-container--rounded {
  border-radius: 100px;
}
.pp-phone-input-container--underlined.pp-phone-input-container--rounded {
  border-radius: 0;
}

.country-selector {
  display: flex;
  align-items: center;
  gap: 4px;
  background: transparent;
  border: none;
  padding: 0 16px;
  height: 100%;
  cursor: pointer;
  color: var(--pp-primary-variant, #1a2a5e);
  font-size: 15px;
  font-weight: 600;
}

.country-code {
  letter-spacing: 0.5px;
}

.chevron-down {
  width: 16px;
  height: 16px;
  color: var(--pp-primary-variant, #1a2a5e);
}

.separator {
  width: 1px;
  height: 24px;
  background-color: #e0e0e0;
}

.pp-phone-input {
  flex: 1;
  height: 100%;
  border: none;
  background: transparent;
  padding: 0 16px;
  font-size: 15px;
  font-weight: 600;
  color: var(--pp-primary-variant, #1a2a5e);
  outline: none;
  width: 100%;
}

.pp-phone-input::placeholder {
  color: var(--pp-primary-variant, #1a2a5e); /* Design has strong placeholder color for masked values */
}

.clear-btn {
  background: transparent;
  border: none;
  padding: 0 16px;
  height: 100%;
  cursor: pointer;
  color: #a0a0a0;
  display: flex;
  align-items: center;
  justify-content: center;
}

.clear-btn svg {
  width: 16px;
  height: 16px;
}
</style>
