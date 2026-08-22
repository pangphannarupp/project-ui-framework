<template>
  <div class="my-passes-view">
    <div class="nav-bar">
      <button class="nav-back-btn" @click="$router.push('/')">
        <svg viewBox="0 0 24 24" width="22" height="22" stroke="currentColor" stroke-width="2.5" fill="none">
          <line x1="19" y1="12" x2="5" y2="12"></line>
          <polyline points="12 19 5 12 12 5"></polyline>
        </svg>
      </button>
      <h2 class="nav-title">{{ t.myPasses }}</h2>
      <button class="nav-exit-btn" @click="$router.push('/')">✕</button>
    </div>

    <div class="content-scroll">
      <div v-if="store.state.bookings.length > 0" class="passes-list">
        <div v-for="b in store.state.bookings" :key="b.id" class="pass-mini-card" @click="$router.push(`/confirmation/${b.id}`)">
          <div class="pass-top">
            <span class="op">{{ b.route.operator }}</span>
            <span class="status">CONFIRMED</span>
          </div>
          <p class="route-line">{{ b.route.origin }} ➔ {{ b.route.destination }}</p>
          <div class="pass-foot">
            <span>Seats: {{ b.seats.join(', ') }}</span>
            <span>${{ b.totalAmount.toFixed(2) }}</span>
          </div>
        </div>
      </div>
      <div v-else class="empty-state">
        <p>No bus passes booked yet.</p>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { useBusStore } from '../store/busStore'
import { useI18n } from '../i18n'
const store = useBusStore()
const { t } = useI18n()
</script>

<style scoped>
.my-passes-view { min-height: 100vh; background-color: #f8fafc; }
.nav-bar {
  display: flex; align-items: center; justify-content: space-between;
  padding: 12px 16px; background: #ffffff; border-bottom: 1px solid #edf2f7;
}
.nav-back-btn, .nav-exit-btn { background: none; border: none; cursor: pointer; }
.nav-title { margin: 0; font-size: 16px; font-weight: 800; }
.content-scroll { padding: 16px; }

.passes-list { display: flex; flex-direction: column; gap: 12px; }
.pass-mini-card {
  background: #ffffff; border-radius: 14px; padding: 14px;
  border: 1px solid #e2e8f0; cursor: pointer;
}
.pass-top { display: flex; justify-content: space-between; margin-bottom: 6px; }
.op { font-weight: 800; font-size: 13px; color: #2563eb; }
.status { font-size: 10px; font-weight: 800; background: #dcfce7; color: #166534; padding: 2px 6px; border-radius: 4px; }
.route-line { font-size: 14px; font-weight: 800; margin: 0 0 6px 0; }
.pass-foot { display: flex; justify-content: space-between; font-size: 12px; color: #64748b; font-weight: 600; }
.empty-state { text-align: center; padding: 40px; color: #94a3b8; }
</style>
