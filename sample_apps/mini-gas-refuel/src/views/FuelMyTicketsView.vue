<template>
  <div class="fuel-tickets-root">
    <header class="t-header">
      <button class="back-btn" @click="$router.push('/')">←</button>
      <h2>{{ t.myPasses }}</h2>
      <div style="width: 32px"></div>
    </header>

    <main class="t-body">
      <div v-if="store.state.transactions.length === 0" class="no-tickets-box">
        <span class="empty-emoji">⛽</span>
        <p>{{ t.noPasses }}</p>
        <PPButton variant="primary" size="medium" @click="$router.push('/')">
          {{ t.bookFirst }}
        </PPButton>
      </div>

      <div v-else class="tx-column">
        <div 
          v-for="tx in store.state.transactions" 
          :key="tx.id"
          class="fuel-tx-card"
        >
          <div class="tx-head">
            <span class="tx-ref">{{ tx.receiptNumber }}</span>
            <span class="pump-tag">PUMP 0{{ tx.pumpNumber }}</span>
          </div>
          <div class="tx-info">
            <h4>{{ tx.fuelGrade.name }}</h4>
            <span>{{ tx.volumeLiters }}L • {{ tx.timestamp }}</span>
          </div>
          <div class="tx-foot">
            <span class="tx-total">${{ tx.totalAmount.toFixed(2) }}</span>
            <PPButton variant="primary" size="small" @click="store.state.latestTransaction = tx; $router.push('/status')">
              View Receipt 🧾
            </PPButton>
          </div>
        </div>
      </div>
    </main>
  </div>
</template>

<script setup lang="ts">
import { useRouter } from 'vue-router'
import { PPButton } from '@phanna/ui-framework'
import { useFuelStore } from '../store/fuelStore'
import { useI18n } from '../i18n'

const router = useRouter()
const store = useFuelStore()
const { t } = useI18n()
</script>

<style scoped>
.fuel-tickets-root { min-height: 100vh; background: #0c0a09; color: #fafaf9; }
.t-header {
  display: flex; justify-content: space-between; align-items: center; padding: 16px;
  background: #1c1917; border-bottom: 1px solid #292524;
}
.back-btn { background: none; border: none; font-size: 20px; color: #fafaf9; cursor: pointer; }
.t-header h2 { font-size: 15px; font-weight: 900; margin: 0; }

.t-body { padding: 16px; }
.no-tickets-box { display: flex; flex-direction: column; align-items: center; gap: 10px; margin-top: 40px; }
.empty-emoji { font-size: 40px; }

.tx-column { display: flex; flex-direction: column; gap: 12px; }
.fuel-tx-card {
  background: #1c1917; border-radius: 16px; padding: 14px; border: 1px solid #292524;
  display: flex; flex-direction: column; gap: 8px;
}
.tx-head { display: flex; justify-content: space-between; font-size: 10px; font-weight: 800; }
.tx-ref { font-family: monospace; color: #f59e0b; }
.pump-tag { color: #a8a29e; }
.tx-info h4 { font-size: 13px; font-weight: 900; margin: 0; color: #ffffff; }
.tx-info span { font-size: 10px; color: #a8a29e; }
.tx-foot { display: flex; justify-content: space-between; align-items: center; border-top: 1px solid #292524; padding-top: 8px; }
.tx-total { font-size: 14px; font-weight: 900; color: #f59e0b; }
</style>
