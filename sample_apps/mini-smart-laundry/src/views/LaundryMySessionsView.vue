<template>
  <div class="my-laundry-view">
    <div class="nav-bar">
      <button class="nav-back-btn" @click="$router.push('/')">
        <svg viewBox="0 0 24 24" width="22" height="22" stroke="currentColor" stroke-width="2.5" fill="none">
          <line x1="19" y1="12" x2="5" y2="12"></line>
          <polyline points="12 19 5 12 12 5"></polyline>
        </svg>
      </button>
      <h2 class="nav-title">Laundry History</h2>
      <button class="nav-exit-btn" @click="$router.push('/')">✕</button>
    </div>

    <div class="content-scroll">
      <div v-if="store.state.sessions.length > 0" class="sessions-list">
        <div v-for="s in store.state.sessions" :key="s.id" class="session-card" @click="$router.push(`/confirmation/${s.id}`)">
          <div class="sc-top">
            <span class="m-num">{{ s.machine.number }}</span>
            <span class="m-stat">{{ s.status }}</span>
          </div>
          <span class="m-cfg">{{ s.config.waterTemp }} • {{ s.config.spinSpeed }}</span>
          <div class="sc-foot">
            <span>{{ s.startTime }}</span>
            <span class="m-paid">${{ s.totalPaid.toFixed(2) }}</span>
          </div>
        </div>
      </div>
      <div v-else class="empty-state">
        <p>No laundry sessions recorded.</p>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { useLaundryStore } from '../store/laundryStore'
const store = useLaundryStore()
</script>

<style scoped>
.my-laundry-view { min-height: 100vh; background-color: #f0f9ff; color: #0f172a; }
.nav-bar {
  display: flex; align-items: center; justify-content: space-between;
  padding: 12px 16px; background: #ffffff; border-bottom: 1px solid #bae6fd;
}
.nav-back-btn, .nav-exit-btn { background: none; border: none; cursor: pointer; color: #0f172a; }
.nav-title { margin: 0; font-size: 16px; font-weight: 800; }
.content-scroll { padding: 16px; }

.sessions-list { display: flex; flex-direction: column; gap: 12px; }
.session-card { background: #ffffff; border-radius: 14px; padding: 14px; border: 1px solid #bae6fd; cursor: pointer; }
.sc-top { display: flex; justify-content: space-between; margin-bottom: 4px; }
.m-num { font-size: 14px; font-weight: 900; color: #0284c7; }
.m-stat { font-size: 10px; font-weight: 800; background: #e0f2fe; color: #0284c7; padding: 2px 6px; border-radius: 4px; }
.m-cfg { font-size: 11px; color: #64748b; margin-bottom: 8px; display: block; }
.sc-foot { display: flex; justify-content: space-between; font-size: 12px; color: #64748b; border-top: 1px solid #f0f9ff; padding-top: 6px; }
.m-paid { font-weight: 900; color: #0ea5e9; }
.empty-state { text-align: center; padding: 40px; color: #64748b; }
</style>
