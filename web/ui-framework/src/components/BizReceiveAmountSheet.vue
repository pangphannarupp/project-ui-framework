<template>
  <BizBottomSheet :modelValue="modelValue" @update:modelValue="$emit('update:modelValue', $event)">
    <div class="receive-amount-sheet">
      <div class="sheet-header">
        <h3>Receive Amount</h3>
      </div>
      
      <div class="amount-input-row" @click="openKeypad">
        <div class="currency-toggle-wrapper" @click.stop="toggleCurrency">
          <!-- The Toggle -->
          <div class="currency-toggle" :class="currency.toLowerCase()">
            <div class="toggle-thumb" :class="currency.toLowerCase()">
              <span v-if="currency === 'USD'">$</span>
              <span v-else>៛</span>
            </div>
          </div>
          <!-- Labels below -->
          <div class="currency-labels">
            <span :class="{ active: currency === 'USD' }">USD</span>
            <span :class="{ active: currency === 'KHR', 'khr-active': currency === 'KHR' }">KHR</span>
          </div>
        </div>
        
        <div class="amount-input-area">
          <div class="amount-display-wrapper">
            <div class="amount-display" :class="{ 'has-value': rawAmount !== '0' }">
              <span class="amount-value">{{ formattedAmount }}</span>
              <span class="currency-symbol">{{ currency === 'USD' ? '$' : '៛' }}</span>
            </div>
            <div class="input-line" :class="{ active: isKeypadOpen }"></div>
          </div>
          
          <div class="clear-btn-wrapper">
            <button class="clear-btn" v-if="rawAmount !== '0'" @click.stop="clearAmount">
              <svg viewBox="0 0 24 24" fill="currentColor">
                <circle cx="12" cy="12" r="10" fill="#c4c4c4"></circle>
                <path d="M15 9l-6 6M9 9l6 6" stroke="white" stroke-width="2" stroke-linecap="round"></path>
              </svg>
            </button>
          </div>
        </div>
      </div>
      
      <div class="confirm-action">
        <BizButton 
          block 
          :variant="isConfirmEnabled ? 'primary' : 'secondary'"
          :disabled="!isConfirmEnabled"
          @click="onConfirm"
          class="confirm-btn"
        >
          Confirm
        </BizButton>
      </div>
    </div>
    
    <!-- Keypad placed in the footer slot so it goes edge-to-edge -->
    <template #footer v-if="isKeypadOpen">
      <div class="keypad-wrapper">
        <BizKeypad @press="onKeyPress" />
      </div>
    </template>
  </BizBottomSheet>
</template>

<script setup lang="ts">
import { ref, computed, watch } from 'vue';
import BizBottomSheet from './BizBottomSheet.vue';
import BizButton from './BizButton.vue';
import BizKeypad from './BizKeypad.vue';

const props = defineProps({
  modelValue: Boolean
});

const emit = defineEmits(['update:modelValue', 'confirm']);

const currency = ref<'USD' | 'KHR'>('KHR');
const rawAmount = ref('0');
const isKeypadOpen = ref(false);

watch(() => props.modelValue, (newVal) => {
  if (newVal) {
    // Reset state when opened
    rawAmount.value = '0';
    isKeypadOpen.value = false; // Starts closed as per screenshot 1
  }
});

const formattedAmount = computed(() => {
  if (!rawAmount.value) return '0';
  return Number(rawAmount.value).toLocaleString('en-US');
});

// Mockup image 2 shows button active even when 0, but image 1 shows disabled when 0 and keypad closed.
// We'll enable it if keypad is open or amount > 0.
const isConfirmEnabled = computed(() => {
  return isKeypadOpen.value || parseInt(rawAmount.value) > 0;
});

const toggleCurrency = () => {
  currency.value = currency.value === 'USD' ? 'KHR' : 'USD';
  rawAmount.value = '0';
};

const openKeypad = () => {
  isKeypadOpen.value = true;
};

const clearAmount = () => {
  rawAmount.value = '0';
};

const onKeyPress = (key: string) => {
  if (key === 'backspace') {
    if (rawAmount.value.length > 1) {
      rawAmount.value = rawAmount.value.slice(0, -1);
    } else {
      rawAmount.value = '0';
    }
  } else {
    // Number pressed
    if (rawAmount.value === '0') {
      rawAmount.value = key;
    } else {
      // Prevent extremely long numbers
      if (rawAmount.value.length < 12) {
        rawAmount.value += key;
      }
    }
  }
};

const onConfirm = () => {
  emit('confirm', {
    currency: currency.value,
    amount: Number(rawAmount.value)
  });
  emit('update:modelValue', false);
};
</script>

<style scoped>
.receive-amount-sheet {
  padding: 8px 20px 24px;
}

.sheet-header h3 {
  font-size: 18px;
  font-weight: 700;
  color: var(--biz-primary-variant, #1a2a5e);
  margin: 0 0 24px 0;
}

.amount-input-row {
  display: flex;
  align-items: flex-end;
  gap: 16px;
  margin-bottom: 32px;
}

.currency-toggle-wrapper {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 6px;
}

.currency-toggle {
  width: 48px;
  height: 26px;
  border-radius: 13px;
  background-color: var(--biz-primary-variant, #1a2a5e); /* USD default */
  position: relative;
  transition: all 0.3s;
  cursor: pointer;
}

.currency-toggle.khr {
  background-color: #ff2d78; /* Pink for KHR */
}

.toggle-thumb {
  width: 22px;
  height: 22px;
  border-radius: 50%;
  background-color: white;
  position: absolute;
  top: 2px;
  left: 2px;
  transition: all 0.3s;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: bold;
  font-size: 12px;
  color: var(--biz-primary-variant, #1a2a5e);
}

.toggle-thumb.khr {
  transform: translateX(22px);
  color: #ff2d78;
}

.currency-labels {
  display: flex;
  gap: 4px;
  font-size: 10px;
  font-weight: 600;
  color: #999;
}

.currency-labels span.active {
  color: var(--biz-primary-variant, #1a2a5e);
}

.currency-labels span.khr-active {
  color: #ff2d78;
}

.amount-input-area {
  flex: 1;
  display: flex;
  align-items: flex-end;
  gap: 8px;
}

.amount-display-wrapper {
  flex: 1;
  position: relative;
  padding-bottom: 8px;
}

.amount-display {
  display: flex;
  align-items: center;
  justify-content: flex-end;
  gap: 6px;
  font-size: 32px;
  font-weight: 700;
  color: var(--biz-primary-variant, #1a2a5e);
}

.amount-value {
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  max-width: 200px;
}

.currency-symbol {
  font-size: 24px;
}

.clear-btn-wrapper {
  width: 24px;
  height: 24px;
  margin-bottom: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.clear-btn {
  background: none;
  border: none;
  padding: 0;
  margin: 0;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  width: 20px;
  height: 20px;
}

.input-line {
  position: absolute;
  bottom: 0;
  left: 0;
  width: 100%;
  height: 1px;
  background-color: #eaeaea;
  transition: all 0.3s;
}

.input-line.active {
  background-color: var(--biz-primary-variant, #1a2a5e);
  height: 2px;
}

.confirm-action {
  width: 100%;
}

.confirm-btn {
  transition: all 0.2s;
}

:deep(.biz-button--secondary) {
  background-color: #d1d5e6;
  color: white;
}

.keypad-wrapper {
  background-color: #e5e5ea;
  padding: 16px 8px 32px; /* Extra padding at bottom for safe area */
  border-top: 1px solid #c9cdd4;
  margin: 24px -24px -32px -24px; /* Counteract bottom sheet padding */
}

:deep(.biz-keypad .keypad-btn) {
  background-color: white;
  border-radius: 6px;
  box-shadow: 0 1px 1px rgba(0,0,0,0.15);
  font-size: 24px;
  height: 50px;
  color: #000;
}

:deep(.biz-keypad .keypad-btn.empty-btn) {
  background: transparent;
  box-shadow: none;
}
</style>
