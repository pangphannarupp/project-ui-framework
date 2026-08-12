<template>
  <PPBottomSheet v-model="isOpen" backdrop-type="blur">
    <div class="sheet-container">
      <div class="sheet-header">
        <div class="header-logo">
          <span class="logo-box">Smart @Home</span>
          <h2 class="title">SmartFiber+</h2>
        </div>
      </div>

      <div class="plan-info-card">
        <div class="card-badge">
          <svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none"><path d="M20.59 13.41l-7.17 7.17a2 2 0 0 1-2.83 0L2 12V2h10l8.59 8.59a2 2 0 0 1 0 2.82z"></path><line x1="7" y1="7" x2="7.01" y2="7"></line></svg>
          Plan Information
        </div>
        <div class="card-content">
          <div class="info-row">
            <div class="info-label">
              <div class="main-label">Monthly</div>
              <div class="sub-label highlight">5G @Home Chill 500GB</div>
            </div>
            <div class="info-value">15 USD</div>
          </div>
          <div class="info-row">
            <div class="info-label">
              <div class="main-label">Speed</div>
            </div>
            <div class="info-value">200mbps</div>
          </div>
        </div>
      </div>

      <div class="contact-card">
        <div class="contact-text">
          <div class="contact-title">Need more info?</div>
          <div class="contact-subtitle">Contact our team - we're happy to assist you!</div>
        </div>
        <div class="contact-action">
          <div class="phone-number">010 200 888</div>
          <PPButton variant="outline" style="--pp-primary-variant: var(--smart-green); color: var(--smart-green); border-color: var(--smart-green);">
            <template #iconLeft>
              <svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"></path></svg>
            </template>
            Call us
          </PPButton>
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

.header-logo {
  display: flex;
  align-items: center;
  gap: 1rem;
}

.logo-box {
  background-color: #f5f5f5;
  color: var(--smart-green);
  font-size: 0.7rem;
  font-weight: bold;
  padding: 0.2rem 0.4rem;
  border-radius: 4px;
  border: 1px solid #e0e0e0;
}

.title {
  margin: 0;
  font-size: 1.25rem;
  color: var(--text-main);
}

.plan-info-card {
  border: 1px solid #e0e0e0;
  border-radius: 12px;
  overflow: hidden;
  margin-bottom: 1.5rem;
  position: relative;
}

.card-badge {
  background-color: var(--smart-green);
  color: white;
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.4rem 1rem;
  border-bottom-right-radius: 12px;
  font-weight: 500;
  font-size: 0.9rem;
}

.card-content {
  padding: 1.5rem 1rem 1rem;
}

.info-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 1rem;
}

.info-row:last-child {
  margin-bottom: 0;
}

.info-label {
  display: flex;
  flex-direction: column;
}

.main-label {
  color: var(--text-secondary);
  font-size: 0.9rem;
}

.sub-label {
  font-weight: 600;
  color: var(--text-main);
  margin-top: 0.2rem;
}

.sub-label.highlight {
  color: var(--smart-green);
}

.info-value {
  font-weight: 600;
  color: var(--text-main);
}

.contact-card {
  background-color: #f9f9f9;
  border-radius: 12px;
  padding: 1rem;
  text-align: center;
}

.contact-title {
  font-size: 0.95rem;
  color: var(--text-secondary);
  margin-bottom: 0.2rem;
}

.contact-subtitle {
  font-size: 0.85rem;
  color: var(--text-secondary);
  margin-bottom: 1rem;
}

.contact-action {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 1rem;
}

.phone-number {
  font-weight: 600;
  color: var(--text-main);
  font-size: 1.1rem;
}
</style>
