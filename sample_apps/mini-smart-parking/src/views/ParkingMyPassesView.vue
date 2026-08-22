<template>
  <div class="my-parking-view">
    <div class="nav-bar">
      <button class="nav-back-btn" @click="$router.push('/')">
        <svg viewBox="0 0 24 24" width="22" height="22" stroke="currentColor" stroke-width="2.5" fill="none">
          <line x1="19" y1="12" x2="5" y2="12"></line>
          <polyline points="12 19 5 12 12 5"></polyline>
        </svg>
      </button>
      <h2 class="nav-title">Parking History</h2>
      <button class="nav-exit-btn" @click="$router.push('/')">✕</button>
    </div>

    <div class="content-scroll">
      <div v-if="store.state.history.length > 0" class="history-list">
        <div v-for="h in store.state.history" :key="h.id" class="hist-card">
          <div class="h-top">
            <span class="h-plate">{{ h.plateNumber }}</span>
            <span class="h-status">PAID</span>
          </div>
          <span class="h-loc">{{ h.location }}</span>
          <div class="h-foot">
            <span>{{ h.durationHours }}h parked</span>
            <span class="h-fee">${{ h.totalFee.toFixed(2) }}</span>
          </div>
        </div>
      </div>
      <div v-else class="empty-state">
        <p>No settled parking records found.</p>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { useParkingStore } from '../store/parkingStore'
const store = useParkingStore()
</script>

<style scoped>
.my-parking-view { min-height: 100vh; background-color: #f8fafc; }
.nav-bar {
  display: flex; align-items: center; justify-content: space-between;
  padding: 12px 16px; background: #ffffff; border-bottom: 1px solid #edf2f7;
}
.nav-back-btn, .nav-exit-btn { background: none; border: none; cursor: pointer; }
.nav-title { margin: 0; font-size: 16px; font-weight: 800; }
.content-scroll { padding: 16px; }

.history-list { display: flex; flex-direction: column; gap: 12px; }
.hist-card { background: #ffffff; border-radius: 14px; padding: 14px; border: 1px solid #e2e8f0; }
.h-top { display: flex; justify-content: space-between; margin-bottom: 4px; }
.h-plate { font-family: monospace; font-size: 15px; font-weight: 900; color: #0284c7; }
.h-status { font-size: 10px; font-weight: 800; background: #dcfce7; color: #166534; padding: 2px 6px; border-radius: 4px; }
.h-loc { font-size: 12px; color: #64748b; margin-bottom: 8px; display: block; }
.h-foot { display: flex; justify-content: space-between; font-size: 12px; color: #64748b; border-top: 1px solid #f1f5f9; padding-top: 6px; }
.h-fee { font-weight: 800; color: #0f172a; }
.empty-state { text-align: center; padding: 40px; color: #94a3b8; }
</style>
