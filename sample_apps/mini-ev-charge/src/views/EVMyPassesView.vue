<template>
  <div class="my-ev-view">
    <div class="nav-bar">
      <button class="nav-back-btn" @click="$router.push('/')">
        <svg viewBox="0 0 24 24" width="22" height="22" stroke="currentColor" stroke-width="2.5" fill="none">
          <line x1="19" y1="12" x2="5" y2="12"></line>
          <polyline points="12 19 5 12 12 5"></polyline>
        </svg>
      </button>
      <h2 class="nav-title">Charge History</h2>
      <button class="nav-exit-btn" @click="$router.push('/')">✕</button>
    </div>

    <div class="content-scroll">
      <div v-if="store.state.sessions.length > 0" class="sessions-list">
        <div v-for="s in store.state.sessions" :key="s.id" class="session-card" @click="$router.push(`/confirmation/${s.id}`)">
          <div class="s-top">
            <span class="st-name">{{ s.station.name }}</span>
            <span class="s-status">{{ s.status }}</span>
          </div>
          <span class="s-energy">{{ s.energyDeliveredKwh }} kWh delivered</span>
          <div class="s-foot">
            <span>Power: {{ s.chargingPowerKw }} kW</span>
            <span class="s-cost">${{ s.totalAmount.toFixed(2) }}</span>
          </div>
        </div>
      </div>
      <div v-else class="empty-state">
        <p>No EV charging sessions yet.</p>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { useEVStore } from '../store/evStore'
const store = useEVStore()
</script>

<style scoped>
.my-ev-view { min-height: 100vh; background-color: #f8fafc; }
.nav-bar {
  display: flex; align-items: center; justify-content: space-between;
  padding: 12px 16px; background: #ffffff; border-bottom: 1px solid #edf2f7;
}
.nav-back-btn, .nav-exit-btn { background: none; border: none; cursor: pointer; }
.nav-title { margin: 0; font-size: 16px; font-weight: 800; }
.content-scroll { padding: 16px; }

.sessions-list { display: flex; flex-direction: column; gap: 12px; }
.session-card { background: #ffffff; border-radius: 14px; padding: 14px; border: 1px solid #e2e8f0; cursor: pointer; }
.s-top { display: flex; justify-content: space-between; margin-bottom: 4px; }
.st-name { font-size: 13px; font-weight: 800; }
.s-status { font-size: 10px; font-weight: 800; background: #ecfdf5; color: #047857; padding: 2px 6px; border-radius: 4px; }
.s-energy { font-size: 12px; color: #64748b; margin-bottom: 8px; display: block; }
.s-foot { display: flex; justify-content: space-between; font-size: 12px; color: #64748b; border-top: 1px solid #f1f5f9; padding-top: 6px; }
.s-cost { font-weight: 900; color: #10b981; }
.empty-state { text-align: center; padding: 40px; color: #94a3b8; }
</style>
