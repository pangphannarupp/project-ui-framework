<template>
  <div 
    class="biz-account-list-card" 
    @click="$emit('click')"
  >
    <!-- Background Watermark -->
    <div class="watermark" :class="currency.toLowerCase()">
      {{ currency === 'USD' ? '$' : '៛' }}
    </div>

    <!-- Content -->
    <div class="card-content">
      <!-- Left Column -->
      <div class="col-left">
        <span class="account-type-badge">{{ type }}</span>
        <p class="account-number">{{ accountNumber }}</p>
        <h4 class="account-name">{{ accountName }}</h4>
      </div>
      
      <!-- Right Column -->
      <div class="col-right">
        <div class="action-area">
          <slot name="action">
            <button class="action-btn" @click.stop="$emit('action-click')">
              <svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <circle cx="12" cy="5" r="1"></circle>
                <circle cx="12" cy="12" r="1"></circle>
                <circle cx="12" cy="19" r="1"></circle>
              </svg>
            </button>
          </slot>
        </div>
        <div class="balance-area">
          <span class="balance-label">Total Balance</span>
          <div class="balance-amount-wrapper">
            <button class="visibility-toggle" @click.stop="$emit('update:isHidden', !isHidden)">
              <svg v-if="isHidden" viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24"></path>
                <line x1="1" y1="1" x2="23" y2="23"></line>
              </svg>
              <svg v-else viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path>
                <circle cx="12" cy="12" r="3"></circle>
              </svg>
            </button>
            <div class="balance-amount">
              <span class="currency-symbol">{{ currency === 'USD' ? '$' : '៛' }}</span>
              <span class="amount-value">{{ formattedBalance }}</span>
            </div>
          </div>
        </div>
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
  isHidden: { type: Boolean, default: false }
});

defineEmits(['click', 'action-click', 'update:isHidden']);

const formattedBalance = computed(() => {
  if (props.isHidden) return '***,***.**';
  return props.balance.toLocaleString('en-US', {
    minimumFractionDigits: 2,
    maximumFractionDigits: 2
  });
});
</script>

<style scoped>
.biz-account-list-card {
  position: relative;
  background-color: #ffffff;
  border-radius: 20px;
  padding: 16px;
  overflow: hidden;
  cursor: pointer;
  transition: all 0.2s ease;
  box-shadow: 0 4px 12px rgba(0,0,0,0.05);
  margin-bottom: 12px;
  border: 1px solid #f0f2f5;
}

.biz-account-list-card:active {
  transform: scale(0.98);
}

/* Watermark */
.watermark {
  position: absolute;
  left: -20px;
  top: 50%;
  transform: translateY(-50%);
  font-size: 140px;
  font-weight: 800;
  line-height: 1;
  z-index: 0;
  user-select: none;
  font-family: Arial, sans-serif;
  pointer-events: none;
}

.watermark.usd {
  color: #eef3fb; /* Light blue */
}

.watermark.khr {
  color: #fff0f5; /* Light pink */
}

/* Content */
.card-content {
  position: relative;
  z-index: 1;
  display: flex;
  justify-content: space-between;
  width: 100%;
}

/* Left Column */
.col-left {
  display: flex;
  flex-direction: column;
  gap: 6px;
  flex: 1;
}

.account-type-badge {
  display: inline-block;
  padding: 2px 10px;
  border: 1px solid var(--biz-primary-variant, #1a2a5e);
  border-radius: 12px;
  font-size: 11px;
  color: var(--biz-primary-variant, #1a2a5e);
  background: white;
  font-weight: 600;
  align-self: flex-start;
}

.account-number {
  margin: 4px 0 0 0;
  font-size: 12px;
  color: var(--biz-primary-variant, #1a2a5e);
  font-weight: 500;
}

.account-name {
  margin: 0;
  font-size: 11px;
  color: var(--biz-primary-variant, #1a2a5e);
}

/* Right Column */
.col-right {
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  align-items: flex-end;
}

.action-area {
  height: 24px;
  display: flex;
  align-items: flex-start;
}

.action-btn {
  background: transparent;
  border: none;
  color: #999;
  padding: 0;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
}

.balance-area {
  display: flex;
  flex-direction: column;
  align-items: flex-end;
  gap: 2px;
}

.balance-label {
  font-size: 11px;
  color: #777;
}

.balance-amount-wrapper {
  display: flex;
  align-items: center;
  gap: 4px;
}

.visibility-toggle {
  background: transparent;
  border: none;
  color: #777;
  padding: 0;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
}

.balance-amount {
  display: flex;
  align-items: baseline;
  gap: 2px;
  color: var(--biz-primary-variant, #1a2a5e);
}

.currency-symbol {
  font-size: 14px;
  font-weight: 700;
}

.amount-value {
  font-size: 18px;
  font-weight: 700;
}
</style>
