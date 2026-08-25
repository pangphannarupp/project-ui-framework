<template>
  <div class="omakase-checkout-root">
    <header class="chk-header">
      <button class="back-btn" @click="$router.back()">←</button>
      <h2>Dining Invitation Summary</h2>
      <div style="width: 32px"></div>
    </header>

    <main class="chk-body">
      <div class="summary-dining-card">
        <h3>Grand 12-Course Omakase Experience</h3>
        <span>📅 {{ store.state.selectedDate }} • {{ store.state.selectedSeatingTime }}</span>
        <span>🍣 Seat #0{{ store.state.selectedSeat.seatNumber }} ({{ store.state.selectedSeat.position }}) • {{ store.state.guestCount }} Guests</span>
      </div>

      <div class="pricing-card">
        <div class="p-row">
          <span>12-Course Tasting ({{ store.state.guestCount }}x):</span>
          <span>${{ (180.00 * store.state.guestCount).toFixed(2) }}</span>
        </div>
        <div class="p-row" v-if="store.state.sakePairingIncluded">
          <span>Junmai Sake Pairing ({{ store.state.guestCount }}x):</span>
          <span>+${{ (65.00 * store.state.guestCount).toFixed(2) }}</span>
        </div>
        <div class="p-row total">
          <span>Total Deposit Payable:</span>
          <span>${{ store.totalCost.value.toFixed(2) }}</span>
        </div>
      </div>
    </main>

    <footer class="chk-footer">
      <PPButton variant="primary" block size="large" @click="handleConfirm">
        {{ t.confirmAndPay }} • ${{ store.totalCost.value.toFixed(2) }} 🍣
      </PPButton>
    </footer>
  </div>
</template>

<script setup lang="ts">
import { useRouter } from 'vue-router'
import { PPButton } from '@phanna/ui-framework'
import { useOmakaseStore } from '../store/omakaseStore'
import { useI18n } from '../i18n'

const router = useRouter()
const store = useOmakaseStore()
const { t } = useI18n()

const handleConfirm = () => {
  store.confirmReservation()
  router.push('/status')
}
</script>

<style scoped>
.omakase-checkout-root { min-height: 100vh; background: #141210; color: #f7f3ee; padding-bottom: 96px; }
.chk-header {
  display: flex; justify-content: space-between; align-items: center; padding: 16px;
  background: #1c1917; border-bottom: 1px solid #292524;
}
.back-btn { background: none; border: none; font-size: 20px; color: #f7f3ee; cursor: pointer; }
.chk-header h2 { font-size: 15px; font-weight: 900; margin: 0; }

.chk-body { padding: 16px; display: flex; flex-direction: column; gap: 14px; }
.summary-dining-card, .pricing-card {
  background: #1c1917; border-radius: 16px; padding: 16px; border: 1px solid #292524;
  display: flex; flex-direction: column; gap: 8px;
}
.summary-dining-card h3 { font-size: 15px; font-weight: 900; margin: 0; color: #c2a688; }
.summary-dining-card span { font-size: 11px; color: #a8a29e; }

.p-row { display: flex; justify-content: space-between; font-size: 12px; color: #a8a29e; }
.p-row.total { font-size: 16px; font-weight: 900; color: #c2a688; border-top: 1px solid #292524; padding-top: 8px; }

.chk-footer { position: fixed; bottom: 0; left: 0; right: 0; background: #1c1917; padding: 16px; border-top: 1px solid #292524; }
</style>
