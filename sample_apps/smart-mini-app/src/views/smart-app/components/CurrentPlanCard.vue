<template>
  <div class="card current-plan-card">
    <div class="plan-header">
      <div class="plan-logo">
        SMART<br><span>LAOR!</span>
      </div>
      <div class="plan-info">
        <div class="label">Current plan:</div>
        <div class="plan-name">Smart Laor! Data 1</div>
      </div>
    </div>
    <div class="expiry">Expires on August 18, 2026</div>
    
    <div class="plan-actions">
      <PPButton variant="outline" @click="$emit('upgrade')" style="flex: 1; --pp-primary-variant: var(--smart-green); color: var(--smart-green); border-color: var(--smart-green);">Upgrade Plan</PPButton>
      <PPButton variant="primary" @click="$emit('renew')" style="flex: 1; --pp-primary-variant: var(--smart-green);">↗ Renew</PPButton>
    </div>
  </div>
</template>

<script setup lang="ts">
import { PPButton } from '@phanna/ui-framework';

defineEmits(['upgrade', 'renew']);
</script>

<style scoped>
.card {
  background: white;
  border-radius: 12px;
  padding: 1rem;
  box-shadow: 0 2px 8px rgba(0,0,0,0.05);
}

.current-plan-card {
  position: relative;
  z-index: 2;
  border-top-left-radius: 0; /* Attach to tab */
}

.plan-header {
  display: flex;
  gap: 1rem;
  align-items: center;
  margin-bottom: 1rem;
}

.plan-logo {
  font-size: 0.8rem;
  font-weight: 900;
  font-style: italic;
  color: var(--smart-green);
  line-height: 1;
  border: 1px solid #eee;
  padding: 0.5rem;
  border-radius: 4px;
}

.plan-logo span {
  color: #E91E63;
}

.label {
  color: var(--text-secondary);
  font-size: 0.85rem;
  margin-bottom: 0.25rem;
}

.plan-name {
  font-weight: bold;
  color: var(--smart-green);
  font-size: 1.1rem;
}

.expiry {
  color: #999;
  font-size: 0.8rem;
  margin-bottom: 1rem;
}

.plan-actions {
  display: flex;
  gap: 1rem;
}
</style>
