<template>
  <div class="biz-account-card" :class="[`card-${type}`]" @click="$emit('click')">
    <div class="card-bg-watermark">
      $
    </div>
    
    <div class="card-header">
      <div class="account-count">
        <span class="count-badge">{{ countNumber }}</span>
        Account(s)
      </div>
      <svg class="chevron-right" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <polyline points="9 18 15 12 9 6"></polyline>
      </svg>
    </div>
    
    <div class="card-body">
      <div class="balance-label">Total Balance</div>
      <div class="balance-row">
        <button class="visibility-toggle" @click.stop="$emit('update:isHidden', !isHidden)">
          <svg v-if="isHidden" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24"></path>
            <line x1="1" y1="1" x2="23" y2="23"></line>
          </svg>
          <svg v-else viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path>
            <circle cx="12" cy="12" r="3"></circle>
          </svg>
        </button>
        <span class="currency-symbol">{{ currency }}</span>
        <span class="balance-amount">{{ formattedBalance }}</span>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue';

const props = defineProps({
  type: {
    type: String,
    default: 'deposit' // 'deposit' (blue), 'loan' (pink), etc.
  },
  count: {
    type: Number,
    required: true
  },
  balance: {
    type: Number,
    required: true
  },
  currency: {
    type: String,
    default: 'KHR' // or '$'
  },
  isHidden: {
    type: Boolean,
    default: false
  }
});

defineEmits(['click', 'update:isHidden']);

const countNumber = computed(() => props.count);

const formattedBalance = computed(() => {
  if (props.isHidden) {
    return '***,***.**';
  }
  // Basic formatting with commas and 2 decimals
  return props.balance.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
});
</script>

<style scoped>
.biz-account-card {
  position: relative;
  border-radius: 20px;
  padding: 16px 20px 24px;
  color: white;
  overflow: hidden;
  cursor: pointer;
  box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
  transition: transform 0.2s;
  min-height: 120px;
  display: flex;
  flex-direction: column;
}

.biz-account-card:active {
  transform: scale(0.98);
}

.card-deposit {
  background: linear-gradient(135deg, #1a75ff 0%, #4da6ff 100%);
}

.card-loan {
  background: linear-gradient(135deg, #ff3366 0%, #ff809f 100%);
}

.card-bg-watermark {
  position: absolute;
  top: -20px;
  left: -20px;
  font-size: 200px;
  font-weight: 900;
  color: rgba(255, 255, 255, 0.15);
  line-height: 1;
  pointer-events: none;
  font-family: Arial, sans-serif;
  z-index: 0;
}

.card-header, .card-body {
  position: relative;
  z-index: 1;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: auto;
}

.account-count {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 13px;
  font-weight: 600;
}

.count-badge {
  background: white;
  color: #1a75ff;
  width: 20px;
  height: 20px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 12px;
}
.card-loan .count-badge {
  color: #ff3366;
}

.chevron-right {
  width: 20px;
  height: 20px;
  opacity: 0.8;
}

.card-body {
  text-align: right;
  margin-top: 24px;
}

.balance-label {
  font-size: 13px;
  opacity: 0.9;
  margin-bottom: 4px;
}

.balance-row {
  display: flex;
  align-items: center;
  justify-content: flex-end;
  gap: 6px;
}

.visibility-toggle {
  background: transparent;
  border: none;
  color: white;
  padding: 0;
  margin-right: 4px;
  cursor: pointer;
  display: flex;
  align-items: center;
  opacity: 0.8;
}

.visibility-toggle svg {
  width: 20px;
  height: 20px;
}

.currency-symbol {
  font-size: 20px;
  font-weight: 700;
}

.balance-amount {
  font-size: 28px;
  font-weight: 700;
  letter-spacing: -0.5px;
}
</style>
