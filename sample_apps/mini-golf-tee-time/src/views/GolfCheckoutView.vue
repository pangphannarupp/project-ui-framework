<template>
  <div class="golf-checkout-root">
    <header class="chk-header">
      <button class="back-btn" @click="$router.back()">←</button>
      <h2>{{ t.roundSummary }}</h2>
      <div style="width: 32px"></div>
    </header>

    <main class="chk-body">
      <div class="summary-golf-card">
        <h3>Augusta Championship Course</h3>
        <span>📅 {{ store.state.selectedDate }} • {{ store.state.selectedTeeTime }}</span>
        <span>🏌️ {{ store.state.playersCount }} Players • {{ store.state.holesCount }} Holes Round</span>
      </div>

      <div class="pricing-card">
        <div class="p-row">
          <span>Green Fees ({{ store.state.playersCount }}x):</span>
          <span>${{ ((store.state.holesCount === 18 ? 95 : 55) * store.state.playersCount).toFixed(2) }}</span>
        </div>
        <div class="p-row" v-if="store.state.selectedCaddie">
          <span>Caddie ({{ store.state.selectedCaddie.name }}):</span>
          <span>+${{ store.state.selectedCaddie.fee.toFixed(2) }}</span>
        </div>
        <div class="p-row" v-if="store.state.cartIncluded">
          <span>Clubhouse GPS Cart:</span>
          <span>+$30.00</span>
        </div>
        <div class="p-row total">
          <span>Total Payable:</span>
          <span>${{ store.baseGreenFee.value.toFixed(2) }}</span>
        </div>
      </div>
    </main>

    <footer class="chk-footer">
      <PPButton variant="primary" block size="large" @click="handleConfirm">
        {{ t.confirmAndPay }} • ${{ store.baseGreenFee.value.toFixed(2) }} ⛳
      </PPButton>
    </footer>
  </div>
</template>

<script setup lang="ts">
import { useRouter } from 'vue-router'
import { PPButton } from '@phanna/ui-framework'
import { useGolfStore } from '../store/golfStore'
import { useI18n } from '../i18n'

const store = useGolfStore()
const { t } = useI18n()

const handleConfirm = () => {
  store.confirmTeeTime()
  router.push('/status')
}
</script>

<style scoped>
.golf-checkout-root { min-height: 100vh; background: #05140c; color: #f8fafc; padding-bottom: 96px; }
.chk-header {
  display: flex; justify-content: space-between; align-items: center; padding: 16px;
  background: #091d12; border-bottom: 1px solid #1c402b;
}
.back-btn { background: none; border: none; font-size: 20px; color: #f8fafc; cursor: pointer; }
.chk-header h2 { font-size: 15px; font-weight: 900; margin: 0; }

.chk-body { padding: 16px; display: flex; flex-direction: column; gap: 14px; }
.summary-golf-card, .pricing-card {
  background: #091d12; border-radius: 16px; padding: 16px; border: 1px solid #1c402b;
  display: flex; flex-direction: column; gap: 8px;
}
.summary-golf-card h3 { font-size: 15px; font-weight: 900; margin: 0; color: #d4af37; }
.summary-golf-card span { font-size: 11px; color: #a7f3d0; }

.p-row { display: flex; justify-content: space-between; font-size: 12px; color: #a7f3d0; }
.p-row.total { font-size: 16px; font-weight: 900; color: #d4af37; border-top: 1px solid #1c402b; padding-top: 8px; }

.chk-footer { position: fixed; bottom: 0; left: 0; right: 0; background: #091d12; padding: 16px; border-top: 1px solid #1c402b; }
</style>
