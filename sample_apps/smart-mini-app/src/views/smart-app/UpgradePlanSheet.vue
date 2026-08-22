<template>
  <PPBottomSheet v-model="isOpen" backdrop-type="blur">
    <div class="sheet-container">
      <div class="sheet-header">
        <h2 class="title">Upgrade Plan</h2>
        <p class="subtitle">Choose a new plan that fits your needs</p>
      </div>

      <div class="plan-list">
        <!-- Plan 1 -->
        <div class="plan-card">
          <div class="plan-header-row">
            <div class="plan-logo">
              SMART<br><span>LAOR!</span>
            </div>
            <div class="plan-name">Smart Laor! Data 2</div>
            <div class="plan-price">2 USD / 7 Days</div>
          </div>
          <div class="plan-benefits">
            <div class="benefit"><span class="check">✓</span> 15GB Data</div>
            <div class="benefit"><span class="check">✓</span> Unlimited On-net Calls</div>
          </div>
          <PPButton variant="primary" size="small" style="--pp-primary-variant: var(--smart-green);">Select</PPButton>
        </div>

        <!-- Plan 2 -->
        <div class="plan-card">
          <div class="plan-header-row">
            <div class="plan-logo">
              SMART<br><span>LAOR!</span>
            </div>
            <div class="plan-name">Smart Laor! Data 5</div>
            <div class="plan-price">5 USD / 30 Days</div>
          </div>
          <div class="plan-benefits">
            <div class="benefit"><span class="check">✓</span> 40GB Data</div>
            <div class="benefit"><span class="check">✓</span> Unlimited On-net Calls</div>
          </div>
          <PPButton variant="outline" size="small" style="--pp-primary-variant: var(--smart-green); color: var(--smart-green); border-color: var(--smart-green);">Select</PPButton>
        </div>
      </div>
    </div>
  </PPBottomSheet>
</template>

<script setup lang="ts">
import { ref, watch } from 'vue';
import { PPBottomSheet, PPButton } from '@phanna/ui-framework';

const props = defineProps({
  modelValue: Boolean
});
const emit = defineEmits(['update:modelValue']);

const isOpen = ref(props.modelValue);

watch(() => props.modelValue, (val) => {
  isOpen.value = val;
});
watch(isOpen, (val) => {
  emit('update:modelValue', val);
});
</script>

<style scoped>
.sheet-container {
  padding: 0 1.5rem 2rem 1.5rem;
}

.sheet-header {
  margin-bottom: 1.5rem;
}

.title {
  margin: 0;
  font-size: 1.25rem;
  color: var(--text-main);
}

.subtitle {
  color: var(--text-secondary);
  font-size: 0.9rem;
  margin: 0.5rem 0 0 0;
}

.plan-list {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.plan-card {
  border: 1px solid #e0e0e0;
  border-radius: 12px;
  padding: 1rem;
  background-color: white;
}

.plan-header-row {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  margin-bottom: 1rem;
}

.plan-logo {
  font-size: 0.65rem;
  font-weight: 900;
  font-style: italic;
  color: var(--smart-green);
  line-height: 1;
  border: 1px solid #eee;
  padding: 0.3rem;
  border-radius: 4px;
}

.plan-logo span {
  color: #E91E63;
}

.plan-name {
  font-weight: bold;
  color: var(--text-main);
  flex: 1;
}

.plan-price {
  font-size: 0.85rem;
  font-weight: 600;
  color: var(--smart-green);
}

.plan-benefits {
  margin-bottom: 1rem;
  font-size: 0.85rem;
  color: var(--text-secondary);
}

.benefit {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  margin-bottom: 0.3rem;
}

.check {
  color: var(--smart-green);
  font-weight: bold;
}
</style>
