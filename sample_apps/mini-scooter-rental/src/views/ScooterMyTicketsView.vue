<template>
  <div class="scooter-tickets-root">
    <header class="t-header">
      <button class="back-btn" @click="$router.push('/')">←</button>
      <h2>{{ t.myPasses }}</h2>
      <div style="width: 32px"></div>
    </header>

    <main class="t-body">
      <div v-if="store.state.trips.length === 0" class="no-tickets-box">
        <span class="empty-emoji">🛴</span>
        <p>{{ t.noPasses }}</p>
        <PPButton variant="primary" size="medium" @click="$router.push('/')">
          {{ t.bookFirst }}
        </PPButton>
      </div>

      <div v-else class="trips-column">
        <div 
          v-for="trip in store.state.trips" 
          :key="trip.id"
          class="trip-ticket-card"
        >
          <div class="card-head">
            <span class="trip-code">{{ trip.tripCode }}</span>
            <span class="status-tag">{{ trip.status }}</span>
          </div>

          <div class="trip-stats">
            <div class="stat-col">
              <span class="val">{{ trip.durationMinutes }}m</span>
              <span class="lbl">Duration</span>
            </div>
            <div class="stat-col">
              <span class="val">{{ trip.distanceKm }}km</span>
              <span class="lbl">Distance</span>
            </div>
            <div class="stat-col">
              <span class="val neon-lime">{{ trip.carbonSavedKg }}kg</span>
              <span class="lbl">CO2 Saved</span>
            </div>
          </div>

          <div class="card-footer">
            <span class="cost-val">${{ trip.totalCost.toFixed(2) }}</span>
            <PPButton variant="primary" size="small" @click="store.state.activeTrip = trip; $router.push('/status')">
              Live HUD ⚡
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
import { useScooterStore } from '../store/scooterStore'
import { useI18n } from '../i18n'

const router = useRouter()
const store = useScooterStore()
const { t } = useI18n()
</script>

<style scoped>
.scooter-tickets-root { min-height: 100vh; background: #0b0f17; color: #f8fafc; }
.t-header {
  display: flex; justify-content: space-between; align-items: center; padding: 16px;
  background: #111827; border-bottom: 1px solid #1f2937;
}
.back-btn { background: none; border: none; font-size: 20px; color: #f8fafc; cursor: pointer; }
.t-header h2 { font-size: 15px; font-weight: 900; margin: 0; }

.t-body { padding: 16px; }
.no-tickets-box { display: flex; flex-direction: column; align-items: center; gap: 10px; margin-top: 40px; }
.empty-emoji { font-size: 40px; }

.trips-column { display: flex; flex-direction: column; gap: 12px; }
.trip-ticket-card {
  background: #111827; border-radius: 16px; padding: 14px; border: 1px solid #1f2937;
  display: flex; flex-direction: column; gap: 10px;
}
.card-head { display: flex; justify-content: space-between; font-size: 10px; font-weight: 800; }
.trip-code { font-family: monospace; color: #ccff00; }
.status-tag { color: #22c55e; background: #052e16; padding: 2px 6px; border-radius: 4px; }

.trip-stats { display: grid; grid-template-columns: repeat(3, 1fr); background: #0b0f17; padding: 8px; border-radius: 10px; }
.stat-col { display: flex; flex-direction: column; align-items: center; }
.val { font-size: 12px; font-weight: 900; color: #f8fafc; }
.lbl { font-size: 7px; color: #6b7280; }
.neon-lime { color: #ccff00 !important; }

.card-footer { display: flex; justify-content: space-between; align-items: center; border-top: 1px solid #1f2937; padding-top: 8px; }
.cost-val { font-size: 14px; font-weight: 900; color: #ccff00; }
</style>
