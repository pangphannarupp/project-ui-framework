<template>
  <div class="flight-checkout-root">
    <header class="chk-header">
      <button class="back-btn" @click="$router.back()">←</button>
      <h2>{{ t.flightSummary }}</h2>
      <div style="width: 32px"></div>
    </header>

    <main class="chk-body">
      <div class="summary-flight-card">
        <div class="s-head">
          <span class="flight-num">{{ store.state.flight.flightNumber }}</span>
          <span class="seat-badge">SEAT {{ store.state.selectedSeat.seatNumber }} ({{ store.state.selectedSeat.cabinClass }})</span>
        </div>
        <div class="s-route">
          <span>{{ store.state.flight.originCode }} ({{ store.state.flight.departureTime }})</span>
          <span>✈️</span>
          <span>{{ store.state.flight.destCode }} ({{ store.state.flight.arrivalTime }})</span>
        </div>
      </div>

      <div class="pricing-breakdown">
        <div class="p-row">
          <span>Cabin Suite Fare:</span>
          <span>${{ store.state.selectedSeat.price.toFixed(2) }}</span>
        </div>
        <div class="p-row" v-if="store.state.loungeAccess">
          <span>SilverKris Lounge Pass:</span>
          <span>+$45.00</span>
        </div>
        <div class="p-row total">
          <span>Total Fare:</span>
          <span>${{ store.totalCost.value.toFixed(2) }}</span>
        </div>
      </div>
    </main>

    <footer class="chk-footer">
      <PPButton variant="primary" block size="large" @click="handleConfirm">
        {{ t.confirmAndPay }} • ${{ store.totalCost.value.toFixed(2) }} ✈️
      </PPButton>
    </footer>
  </div>
</template>

<script setup lang="ts">
import { useRouter } from 'vue-router'
import { PPButton } from '@phanna/ui-framework'
import { useFlightStore } from '../store/flightStore'
import { useI18n } from '../i18n'

const store = useFlightStore()
const { t } = useI18n()

const handleConfirm = () => {
  store.issueBoardingPass()
  router.push('/status')
}
</script>

<style scoped>
.flight-checkout-root { min-height: 100vh; background: #0b1329; color: #f8fafc; padding-bottom: 96px; }
.chk-header {
  display: flex; justify-content: space-between; align-items: center; padding: 16px;
  background: #101c3d; border-bottom: 1px solid #1e293b;
}
.back-btn { background: none; border: none; font-size: 20px; color: #f8fafc; cursor: pointer; }
.chk-header h2 { font-size: 15px; font-weight: 900; margin: 0; }

.chk-body { padding: 16px; display: flex; flex-direction: column; gap: 14px; }
.summary-flight-card, .pricing-breakdown {
  background: #101c3d; border-radius: 16px; padding: 16px; border: 1px solid #1e293b;
  display: flex; flex-direction: column; gap: 10px;
}
.s-head { display: flex; justify-content: space-between; align-items: center; }
.flight-num { font-size: 16px; font-weight: 900; color: #d4af37; font-family: monospace; }
.seat-badge { font-size: 10px; font-weight: 900; background: #1e293b; padding: 4px 8px; border-radius: 6px; }
.s-route { display: flex; justify-content: space-between; font-size: 12px; font-weight: 800; color: #cbd5e1; }

.p-row { display: flex; justify-content: space-between; font-size: 12px; color: #94a3b8; }
.p-row.total { font-size: 16px; font-weight: 900; color: #d4af37; border-top: 1px solid #1e293b; padding-top: 8px; }

.chk-footer { position: fixed; bottom: 0; left: 0; right: 0; background: #101c3d; padding: 16px; border-top: 1px solid #1e293b; }
</style>
