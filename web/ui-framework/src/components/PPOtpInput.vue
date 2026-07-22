<template>
  <div class="pp-otp-input">
    <input
      v-for="(digit, index) in localDigits"
      :key="index"
      :ref="el => { if (el) inputs[index] = el as HTMLInputElement }"
      type="tel"
      maxlength="1"
      class="otp-box"
      :class="{ 'is-filled': digit !== '' }"
      :value="digit"
      @input="onInput($event, index)"
      @keydown="onKeydown($event, index)"
      @focus="onFocus(index)"
      @paste="onPaste"
    />
  </div>
</template>

<script setup lang="ts">
import { ref, watch } from 'vue';

const props = defineProps({
  modelValue: {
    type: String,
    default: ''
  },
  length: {
    type: Number,
    default: 6
  }
});

const emit = defineEmits(['update:modelValue', 'complete']);

const inputs = ref<HTMLInputElement[]>([]);
const localDigits = ref<string[]>(Array(props.length).fill(''));

// Sync from prop
watch(() => props.modelValue, (newVal) => {
  const chars = newVal.split('');
  for (let i = 0; i < props.length; i++) {
    localDigits.value[i] = chars[i] || '';
  }
}, { immediate: true });

const emitValue = () => {
  const val = localDigits.value.join('');
  emit('update:modelValue', val);
  if (val.length === props.length) {
    emit('complete', val);
  }
};

const onInput = (event: Event, index: number) => {
  const target = event.target as HTMLInputElement;
  // Ensure only numbers
  const val = target.value.replace(/\D/g, '');
  
  if (val) {
    localDigits.value[index] = val.charAt(val.length - 1);
    // Move to next
    if (index < props.length - 1) {
      inputs.value[index + 1]?.focus();
    }
  } else {
    localDigits.value[index] = '';
  }
  
  target.value = localDigits.value[index];
  emitValue();
};

const onKeydown = (event: KeyboardEvent, index: number) => {
  if (event.key === 'Backspace' && !localDigits.value[index] && index > 0) {
    // If empty and backspace is pressed, move to previous box
    inputs.value[index - 1]?.focus();
  }
};

const onFocus = (index: number) => {
  // Auto-select text so typing immediately overwrites it
  inputs.value[index]?.select();
};

const onPaste = (event: ClipboardEvent) => {
  event.preventDefault();
  const pastedData = event.clipboardData?.getData('text/plain') || '';
  const numbers = pastedData.replace(/\D/g, '').split('').slice(0, props.length);
  
  for (let i = 0; i < numbers.length; i++) {
    localDigits.value[i] = numbers[i];
  }
  
  emitValue();
  
  // Focus the next empty box or the last box
  const nextEmptyIndex = localDigits.value.findIndex(d => !d);
  const focusIndex = nextEmptyIndex !== -1 ? nextEmptyIndex : props.length - 1;
  inputs.value[focusIndex]?.focus();
};
</script>

<style scoped>
.pp-otp-input {
  display: flex;
  justify-content: space-between;
  gap: 8px;
  width: 100%;
}

.otp-box {
  flex: 1;
  aspect-ratio: 1 / 1;
  max-width: 50px;
  border: 1px solid #e0e0e0;
  border-radius: 12px;
  background-color: white;
  text-align: center;
  font-size: 20px;
  font-weight: 700;
  color: var(--pp-primary-variant, #1a2a5e);
  outline: none;
  transition: border-color 0.2s, box-shadow 0.2s;
  padding: 0; /* Remove default padding for better centering */
}

/* For browsers that don't support aspect-ratio perfectly */
@supports not (aspect-ratio: 1 / 1) {
  .otp-box {
    height: 50px;
  }
}

.otp-box {
  transition: all 0.2s;
}

.otp-box:focus {
  border-color: var(--pp-primary-color, var(--pp-primary, #003399));
  outline: none;
  box-shadow: 0 0 0 2px rgba(0, 51, 153, 0.1);
}

.otp-box.is-filled {
  background-color: #2954d6;
  color: white;
  border-color: #2954d6;
}
</style>
