<template>
  <div class="scooter-checkout-root">
    <header class="chk-header">
      <button class="back-btn" @click="$router.back()">←</button>
      <h2>{{ t.tripSummary }}</h2>
      <div style="width: 32px"></div>
    </header>

    <main class="chk-body">
      <div class="summary-scooter-card">
        <span class="s-bolt">⚡</span>
        <div class="s-info">
          <h3>{{ store.state.selectedScooter.code }}</h3>
          <span>{{ store.state.selectedScooter.model }}</span>
          <span class="s-bat">🔋 Battery: {{ store.state.selectedScooter.batteryPercent }}% ({{ store.state.selectedScooter.rangeKm }}km range)</span>
        </div>
      </div>

      <div class="pricing-card">
        <div class="p-row">
          <span>Unlock Fee:</span>
          <span>${{ store.state.selectedScooter.unlockFee.toFixed(2) }}</span>
        </div>
        <div class="p-row">
          <span>Refundable Helmet Deposit:</span>
          <span>${{ store.state.depositAmount.toFixed(2) }}</span>
        </div>
        <div class="p-row">
          <span>Ride Rate:</span>
          <span>${{ store.state.selectedScooter.pricePerMinute }}/minute</span>
        </div>
        <div class="p-row total">
          <span>Initial Hold Total:</span>
          <span>${{ store.initialCost.value.toFixed(2) }}</span>
        </div>
      </div>
    </main>

    <footer class="chk-footer">
      <PPButton variant="primary" block size="large" @click="handleConfirm">
        {{ t.confirmAndPay }} • ${{ store.initialCost.value.toFixed(2) }} ⚡
      </PPButton>
    </footer>
  </div>
</template>

<script setup lang="ts">
import { useRouter } from 'vue-router'
import { PPButton } from '@phanna/ui-framework'
import { useScooterStore } from '../store/scooterStore'
import { useI18n } from '../i18n'

const store = useScooterStore()
const { t } = useI18n()

const handleConfirm = () => {
  store.startRide()
  router.push('/status')
}
</script>

<style scoped>
.scooter-checkout-root { min-height: 100vh; background: #0b0f17; color: #f8fafc; padding-bottom: 96px; }
.chk-header {
  display: flex; justify-content: space-between; align-items: center; padding: 16px;
  background: #111827; border-bottom: 1px solid #1f2937;
}
.back-btn { background: none; border: none; font-size: 20px; color: #f8fafc; cursor: pointer; }
.chk-header h2 { font-size: 15px; font-weight: 900; margin: 0; }

.chk-body { padding: 16px; display: flex; flex-direction: column; gap: 14px; }
.summary-scooter-card, .pricing-card {
  background: #111827; border-radius: 16px; padding: 16px; border: 1px solid #1f2937;
  display: flex; gap: 12px;
}
.pricing-card { flex-direction: column; gap: 8px; }
.s-bolt { font-size: 24px; background: #1f2937; padding: 10px; border-radius: 12px; }
.s-info h3 { font-size: 16px; font-weight: 900; margin: 0; color: #ccff00; }
.s-info span { font-size: 11px; color: #9ca3af; }
.s-bat { display: block; margin-top: 4px; color: #f8fafc !important; }

.p-row { display: flex; justify-content: space-between; font-size: 12px; color: #9ca3af; }
.p-row.total { font-size: 16px; font-weight: 900; color: #ccff00; border-top: 1px solid #1f2937; padding-top: 8px; }

.chk-footer { position: fixed; bottom: 0; left: 0; right: 0; background: #111827; padding: 16px; border-top: 1px solid #1f2937; }
</style>
