<template>
  <div class="fuel-checkout-root">
    <header class="chk-header">
      <button class="back-btn" @click="$router.back()">←</button>
      <h2>Payment Authorization</h2>
      <div style="width: 32px"></div>
    </header>

    <main class="chk-body">
      <div class="summary-fuel-card">
        <div class="s-head">
          <span class="p-num">PUMP 0{{ store.state.selectedPump.pumpNumber }}</span>
          <span class="g-badge" :style="{ background: store.state.selectedGrade.badgeColor }">{{ store.state.selectedGrade.octane }} OCTANE</span>
        </div>
        <div class="s-fuel-name">{{ store.state.selectedGrade.name }}</div>
        <span class="s-dispense-vol">Target Volume: ~{{ store.calculatedLiters.value.toFixed(2) }} Liters</span>
      </div>

      <div class="pricing-card">
        <div class="p-row">
          <span>Fuel Rate:</span>
          <span>${{ store.state.selectedGrade.pricePerLiter.toFixed(2) }} / L</span>
        </div>
        <div class="p-row">
          <span>Volume Dispense:</span>
          <span>{{ store.calculatedLiters.value.toFixed(2) }} L</span>
        </div>
        <div class="p-row total">
          <span>Preset Authorization:</span>
          <span>${{ store.state.fuelPresetDollars.toFixed(2) }}</span>
        </div>
      </div>
    </main>

    <footer class="chk-footer">
      <PPButton variant="primary" block size="large" @click="handleConfirm">
        {{ t.confirmAndPay }} • ${{ store.state.fuelPresetDollars.toFixed(2) }} ⛽
      </PPButton>
    </footer>
  </div>
</template>

<script setup lang="ts">
import { useRouter } from 'vue-router'
import { PPButton } from '@phanna/ui-framework'
import { useFuelStore } from '../store/fuelStore'
import { useI18n } from '../i18n'

const store = useFuelStore()
const { t } = useI18n()

const handleConfirm = () => {
  store.dispenseFuel()
  router.push('/status')
}
</script>

<style scoped>
.fuel-checkout-root { min-height: 100vh; background: #0c0a09; color: #fafaf9; padding-bottom: 96px; }
.chk-header {
  display: flex; justify-content: space-between; align-items: center; padding: 16px;
  background: #1c1917; border-bottom: 1px solid #292524;
}
.back-btn { background: none; border: none; font-size: 20px; color: #fafaf9; cursor: pointer; }
.chk-header h2 { font-size: 15px; font-weight: 900; margin: 0; }

.chk-body { padding: 16px; display: flex; flex-direction: column; gap: 14px; }
.summary-fuel-card, .pricing-card {
  background: #1c1917; border-radius: 16px; padding: 16px; border: 1px solid #292524;
  display: flex; flex-direction: column; gap: 8px;
}
.s-head { display: flex; justify-content: space-between; align-items: center; }
.p-num { font-size: 14px; font-weight: 900; color: #f59e0b; font-family: monospace; }
.g-badge { font-size: 8px; font-weight: 900; color: white; padding: 2px 6px; border-radius: 4px; }
.s-fuel-name { font-size: 16px; font-weight: 900; color: #ffffff; }
.s-dispense-vol { font-size: 11px; color: #a8a29e; }

.p-row { display: flex; justify-content: space-between; font-size: 12px; color: #a8a29e; }
.p-row.total { font-size: 16px; font-weight: 900; color: #f59e0b; border-top: 1px solid #292524; padding-top: 8px; }

.chk-footer { position: fixed; bottom: 0; left: 0; right: 0; background: #1c1917; padding: 16px; border-top: 1px solid #292524; }
</style>
