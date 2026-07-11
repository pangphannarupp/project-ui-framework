<template>
  <div class="biz-phone-input-wrapper">
    <div v-if="label" class="biz-input-label">{{ label }}</div>
    <div class="biz-phone-input-container">
      
      <button class="country-selector" @click="$emit('select-country')">
        <span class="country-code">{{ countryCode }}</span>
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="chevron-down">
          <polyline points="6 9 12 15 18 9"></polyline>
        </svg>
      </button>

      <div class="separator"></div>

      <input 
        class="biz-phone-input"
        type="tel"
        :value="modelValue"
        :placeholder="placeholder"
        @input="onInput"
        @focus="$emit('focus', $event)"
        @blur="$emit('blur', $event)"
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
defineProps({
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
  }
});

const emit = defineEmits(['update:modelValue', 'clear', 'focus', 'blur', 'select-country']);

const onInput = (event: Event) => {
  const target = event.target as HTMLInputElement;
  emit('update:modelValue', target.value);
};

const clear = () => {
  emit('update:modelValue', '');
  emit('clear');
};
</script>

<style scoped>
.biz-phone-input-wrapper {
  display: flex;
  flex-direction: column;
  gap: 8px;
  width: 100%;
}

.biz-input-label {
  font-size: 13px;
  color: #333;
  font-weight: 500;
}

.biz-phone-input-container {
  display: flex;
  align-items: center;
  background-color: white;
  border: 1px solid #0066cc; /* Active blue border based on design */
  border-radius: 12px;
  height: 50px;
  overflow: hidden;
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
  color: var(--biz-primary-variant, #1a2a5e);
  font-size: 15px;
  font-weight: 600;
}

.country-code {
  letter-spacing: 0.5px;
}

.chevron-down {
  width: 16px;
  height: 16px;
  color: var(--biz-primary-variant, #1a2a5e);
}

.separator {
  width: 1px;
  height: 24px;
  background-color: #e0e0e0;
}

.biz-phone-input {
  flex: 1;
  height: 100%;
  border: none;
  background: transparent;
  padding: 0 16px;
  font-size: 15px;
  font-weight: 600;
  color: var(--biz-primary-variant, #1a2a5e);
  outline: none;
  width: 100%;
}

.biz-phone-input::placeholder {
  color: var(--biz-primary-variant, #1a2a5e); /* Design has strong placeholder color for masked values */
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
