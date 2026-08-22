<template>
  <div class="spa-checkout-root">
    <header class="chk-header">
      <button class="back-btn" @click="$router.back()">←</button>
      <h2>Sanctuary Booking Summary</h2>
      <div style="width: 32px"></div>
    </header>

    <main class="chk-body">
      <div class="summary-spa-card">
        <h3>{{ store.state.selectedRitual.name[currentLanguage] || store.state.selectedRitual.name.en }}</h3>
        <span>📅 {{ store.state.selectedDate }} • {{ store.state.selectedTime }}</span>
        <span>🌿 Oil: {{ store.state.selectedOil }} • Robe: Size {{ store.state.robeSize }}</span>
      </div>

      <div class="pricing-card">
        <div class="p-row">
          <span>Thermal Ritual ({{ store.state.selectedRitual.durationMins }}m):</span>
          <span>${{ store.state.selectedRitual.price.toFixed(2) }}</span>
        </div>
        <div class="p-row">
          <span>Organic Herbal Tea & Locker:</span>
          <span>Complimentary</span>
        </div>
        <div class="p-row total">
          <span>Total Payable:</span>
          <span>${{ store.totalCost.value.toFixed(2) }}</span>
        </div>
      </div>
    </main>

    <footer class="chk-footer">
      <PPButton variant="primary" block size="large" @click="handleConfirm">
        {{ t.confirmAndPay }} • ${{ store.totalCost.value.toFixed(2) }} 🌿
      </PPButton>
    </footer>
  </div>
</template>

<script setup lang="ts">
import { useRouter } from 'vue-router'
import { PPButton } from '@phanna/ui-framework'
import { useSpaStore } from '../store/spaStore'
import { useI18n } from '../i18n'

const store = useSpaStore()
const { t, currentLanguage } = useI18n()

const handleConfirm = () => {
  store.confirmReservation()
  router.push('/status')
}
</script>

<style scoped>
.spa-checkout-root { min-height: 100vh; background: #1c1917; color: #fafaf9; padding-bottom: 96px; }
.chk-header {
  display: flex; justify-content: space-between; align-items: center; padding: 16px;
  background: #292524; border-bottom: 1px solid #44403c;
}
.back-btn { background: none; border: none; font-size: 20px; color: #fafaf9; cursor: pointer; }
.chk-header h2 { font-size: 15px; font-weight: 900; margin: 0; }

.chk-body { padding: 16px; display: flex; flex-direction: column; gap: 14px; }
.summary-spa-card, .pricing-card {
  background: #292524; border-radius: 16px; padding: 16px; border: 1px solid #44403c;
  display: flex; flex-direction: column; gap: 8px;
}
.summary-spa-card h3 { font-size: 15px; font-weight: 900; margin: 0; color: #f43f5e; }
.summary-spa-card span { font-size: 11px; color: #a8a29e; }

.p-row { display: flex; justify-content: space-between; font-size: 12px; color: #a8a29e; }
.p-row.total { font-size: 16px; font-weight: 900; color: #f43f5e; border-top: 1px solid #44403c; padding-top: 8px; }

.chk-footer { position: fixed; bottom: 0; left: 0; right: 0; background: #292524; padding: 16px; border-top: 1px solid #44403c; }
</style>
