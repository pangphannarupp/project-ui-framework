<template>
  <PPBottomSheet v-model="isOpen" backdrop-type="blur">
    <div class="sheet-container">
      <div class="sheet-header">
        <h2 class="title">Data Pack 1 <span class="badge">Direct Add-on</span></h2>
      </div>

      <div class="input-group">
        <PPTextField
          v-model="phoneNumber"
          label="Enter Smart Number"
          type="tel"
          variant="filled"
          clearable
          style="--pp-primary-variant: var(--smart-green);"
        />
      </div>

      <div class="plan-details">
        <div class="detail-row">
          <div class="detail-label"><span class="check-icon">✓</span> Service fee</div>
          <div class="detail-value highlight">1 USD</div>
        </div>
        <div class="detail-row">
          <div class="detail-label"><span class="check-icon">✓</span> Internet data</div>
          <div class="detail-value">7GB</div>
        </div>
        <div class="detail-row">
          <div class="detail-label"><span class="check-icon">✓</span> Service validity</div>
          <div class="detail-value">7 Days</div>
        </div>
        <div class="detail-row">
          <div class="detail-label"><span class="check-icon">✓</span> Main Balance Validity</div>
          <div class="detail-value">7 Days</div>
        </div>
        <div class="detail-row">
          <div class="detail-label"><span class="check-icon">✓</span> Non Auto renewal</div>
        </div>
      </div>

      <div class="payment-method">
        <div class="payment-header">
          <div class="pay-logo">ABA</div>
          <span class="pay-title">ABA Pay</span>
        </div>
        <div class="payment-account">
          <div>
            <div class="account-name">Mobile Savings</div>
            <div class="account-number">### ### ### | KHR</div>
          </div>
          <button class="change-btn">Change <svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none"><polyline points="6 9 12 15 18 9"></polyline></svg></button>
        </div>
      </div>
    </div>

    <template #footer>
      <div class="sheet-footer">
        <PPButton 
          variant="primary" 
          size="large" 
          block 
          @click="isOpen = false"
          style="--pp-primary-variant: var(--smart-green);"
        >
          Pay $1.00
        </PPButton>
      </div>
    </template>
  </PPBottomSheet>
</template>

<script setup lang="ts">
import { ref, watch } from 'vue';
import { PPTextField, PPButton, PPBottomSheet } from '@phanna/ui-framework';

const props = defineProps({
  modelValue: Boolean
});
const emit = defineEmits(['update:modelValue']);

const isOpen = ref(props.modelValue);
const phoneNumber = ref('0123456789');

watch(() => props.modelValue, (val) => {
  isOpen.value = val;
});
watch(isOpen, (val) => {
  emit('update:modelValue', val);
});
</script>

<style scoped>
.sheet-container {
  padding: 0 1.5rem;
}

.sheet-header {
  margin-bottom: 1.5rem;
}

.title {
  margin: 0;
  display: flex;
  align-items: center;
  gap: 0.5rem;
  font-size: 1.25rem;
  color: var(--text-main);
}

.badge {
  background-color: #e6f4f1;
  color: var(--smart-green);
  font-size: 0.75rem;
  padding: 0.2rem 0.5rem;
  border-radius: 12px;
  font-weight: 500;
}

.input-group {
  margin-bottom: 1.5rem;
}

.plan-details {
  border-bottom: 1px dashed #e0e0e0;
  padding-bottom: 1.5rem;
  margin-bottom: 1.5rem;
}

.detail-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 0.8rem;
  font-size: 0.95rem;
}

.detail-row:last-child {
  margin-bottom: 0;
}

.detail-label {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  color: var(--text-main);
}

.check-icon {
  color: var(--smart-green);
  font-weight: bold;
}

.detail-value {
  color: var(--smart-green);
  font-weight: 600;
}

.detail-value.highlight {
  background-color: var(--smart-green);
  color: white;
  padding: 0.1rem 0.5rem;
  border-radius: 4px;
}

.payment-method {
  margin-bottom: 1rem;
}

.payment-header {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  margin-bottom: 1rem;
}

.pay-logo {
  background-color: #004b7b;
  color: white;
  font-size: 0.7rem;
  font-weight: bold;
  padding: 0.2rem 0.4rem;
  border-radius: 4px;
}

.pay-title {
  font-weight: 600;
  color: var(--text-main);
}

.payment-account {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.account-name {
  font-weight: 500;
  color: var(--text-main);
}

.account-number {
  font-size: 0.85rem;
  color: var(--text-secondary);
  margin-top: 0.2rem;
}

.change-btn {
  background: none;
  border: none;
  color: var(--text-secondary);
  display: flex;
  align-items: center;
  gap: 0.2rem;
  font-size: 0.9rem;
  cursor: pointer;
  padding: 0;
}

.sheet-footer {
  padding: 0 1.5rem;
}
</style>
