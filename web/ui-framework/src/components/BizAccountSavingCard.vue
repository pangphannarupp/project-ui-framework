<template>
  <div 
    class="biz-account-saving-card" 
    :class="{ 'is-selected': selected }"
    @click="$emit('select')"
  >
    <!-- Background Watermark -->
    <div class="watermark" :class="currency.toLowerCase()">
      {{ currency === 'USD' ? '$' : '៛' }}
    </div>

    <!-- Content -->
    <div class="card-content">
      <div class="card-header">
        <span class="account-type-badge">{{ type }}</span>
      </div>
      
      <div class="account-details">
        <h4 class="account-name">{{ accountName }}</h4>
        <p class="account-number">{{ accountNumber }}</p>
      </div>
      
      <div class="balance-section">
        <span class="balance-label">Total Balance</span>
        <div class="balance-amount">
          <span class="currency-symbol">{{ currency === 'USD' ? '$' : '៛' }}</span>
          <span class="amount-value">{{ formattedBalance }}</span>
        </div>
      </div>
    </div>

    <!-- Radio Button -->
    <div class="radio-selector">
      <div class="radio-circle" :class="{ 'is-active': selected }">
        <div class="radio-inner" v-if="selected"></div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue';

const props = defineProps({
  accountName: { type: String, required: true },
  accountNumber: { type: String, required: true },
  balance: { type: Number, required: true },
  currency: { type: String, default: 'USD' }, // 'USD' | 'KHR'
  type: { type: String, default: 'Savings' },
  selected: { type: Boolean, default: false }
});

defineEmits(['select']);

const formattedBalance = computed(() => {
  return props.balance.toLocaleString('en-US', {
    minimumFractionDigits: props.currency === 'USD' ? 2 : 0,
    maximumFractionDigits: props.currency === 'USD' ? 2 : 0
  });
});
</script>

<style scoped>
.biz-account-saving-card {
  position: relative;
  background-color: #fcfcfc;
  border: 1px solid #f0f0f0;
  border-radius: 12px;
  padding: 16px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  overflow: hidden;
  cursor: pointer;
  transition: all 0.2s ease;
  margin-bottom: 12px;
}

.biz-account-saving-card.is-selected {
  border: 1.5px solid var(--biz-primary-variant, #1a2a5e);
  background-color: #ffffff;
}

/* Watermark */
.watermark {
  position: absolute;
  right: 10%;
  top: 50%;
  transform: translateY(-50%);
  font-size: 140px;
  font-weight: 800;
  line-height: 1;
  z-index: 0;
  user-select: none;
  font-family: Arial, sans-serif;
}

.watermark.usd {
  color: #eef3fb; /* Light blue/grey */
}

.watermark.khr {
  color: #fff0f5; /* Light pink */
}

/* Content */
.card-content {
  position: relative;
  z-index: 1;
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.account-type-badge {
  display: inline-block;
  padding: 2px 8px;
  border: 1px solid #d0d0d0;
  border-radius: 12px;
  font-size: 10px;
  color: #666;
  background: white;
}

.account-name {
  margin: 0 0 2px 0;
  font-size: 13px;
  font-weight: 700;
  color: var(--biz-primary-variant, #1a2a5e);
}

.account-number {
  margin: 0;
  font-size: 11px;
  color: #777;
}

.balance-section {
  margin-top: 4px;
}

.balance-label {
  display: block;
  font-size: 11px;
  color: #777;
  margin-bottom: 2px;
}

.balance-amount {
  display: flex;
  align-items: center;
  gap: 4px;
  font-weight: 800;
  color: var(--biz-primary-variant, #1a2a5e);
  font-size: 16px;
}

/* Radio Button */
.radio-selector {
  position: relative;
  z-index: 1;
  padding-left: 16px;
}

.radio-circle {
  width: 22px;
  height: 22px;
  border-radius: 50%;
  border: 2px solid #e0e0e0;
  display: flex;
  align-items: center;
  justify-content: center;
  background: white;
  transition: all 0.2s;
}

.radio-circle.is-active {
  border-color: var(--biz-primary-variant, #1a2a5e);
  border-width: 3px;
}

/* We don't necessarily need a dot inside if it's just a thick border, but let's add one if needed, or leave empty if the thick border is enough. Mockup shows just a thick border with empty center. */
</style>
