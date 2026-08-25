<template>
  <div class="flight-tickets-root">
    <header class="t-header">
      <button class="back-btn" @click="$router.push('/')">←</button>
      <h2>{{ t.myPasses }}</h2>
      <div style="width: 32px"></div>
    </header>

    <main class="t-body">
      <div v-if="store.state.boardingPasses.length === 0" class="no-tickets-box">
        <span class="empty-emoji">✈️</span>
        <p>{{ t.noPasses }}</p>
        <PPButton variant="primary" size="medium" @click="$router.push('/')">
          {{ t.bookFirst }}
        </PPButton>
      </div>

      <div v-else class="passes-column">
        <div 
          v-for="p in store.state.boardingPasses" 
          :key="p.id"
          class="flight-pass-item"
        >
          <div class="f-item-head">
            <span class="f-fl-num">{{ p.flight.flightNumber }}</span>
            <span class="f-seat-badge">SEAT {{ p.seat.seatNumber }}</span>
          </div>
          <div class="f-route-row">
            <span>{{ p.flight.originCode }} → {{ p.flight.destCode }}</span>
            <span class="f-price">${{ p.totalPrice.toFixed(2) }}</span>
          </div>
          <PPButton variant="primary" size="small" @click="store.state.latestPass = p; $router.push('/status')">
            Show Mobile Pass 🎟️
          </PPButton>
        </div>
      </div>
    </main>
  </div>
</template>

<script setup lang="ts">
import { useRouter } from 'vue-router'
import { PPButton } from '@phanna/ui-framework'
import { useFlightStore } from '../store/flightStore'
import { useI18n } from '../i18n'

const router = useRouter()
const store = useFlightStore()
const { t } = useI18n()
</script>

<style scoped>
.flight-tickets-root { min-height: 100vh; background: #0b1329; color: #f8fafc; }
.t-header {
  display: flex; justify-content: space-between; align-items: center; padding: 16px;
  background: #101c3d; border-bottom: 1px solid #1e293b;
}
.back-btn { background: none; border: none; font-size: 20px; color: #f8fafc; cursor: pointer; }
.t-header h2 { font-size: 15px; font-weight: 900; margin: 0; }

.t-body { padding: 16px; }
.no-tickets-box { display: flex; flex-direction: column; align-items: center; gap: 10px; margin-top: 40px; }
.empty-emoji { font-size: 40px; }

.passes-column { display: flex; flex-direction: column; gap: 12px; }
.flight-pass-item {
  background: #101c3d; border-radius: 16px; padding: 14px; border: 1px solid #1e293b;
  display: flex; flex-direction: column; gap: 10px;
}
.f-item-head { display: flex; justify-content: space-between; align-items: center; }
.f-fl-num { font-size: 14px; font-weight: 900; color: #d4af37; font-family: monospace; }
.f-seat-badge { font-size: 10px; font-weight: 900; background: #1e293b; padding: 2px 6px; border-radius: 4px; }
.f-route-row { display: flex; justify-content: space-between; font-size: 12px; font-weight: 800; }
.f-price { color: #d4af37; }
</style>
