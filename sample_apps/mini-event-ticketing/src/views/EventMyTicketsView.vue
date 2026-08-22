<template>
  <div class="my-event-view">
    <div class="nav-bar">
      <button class="nav-back-btn" @click="$router.push('/')">
        <svg viewBox="0 0 24 24" width="22" height="22" stroke="currentColor" stroke-width="2.5" fill="none">
          <line x1="19" y1="12" x2="5" y2="12"></line>
          <polyline points="12 19 5 12 12 5"></polyline>
        </svg>
      </button>
      <h2 class="nav-title">Concert Tickets</h2>
      <button class="nav-exit-btn" @click="$router.push('/')">✕</button>
    </div>

    <div class="content-scroll">
      <div v-if="store.state.passes.length > 0" class="passes-list">
        <div v-for="p in store.state.passes" :key="p.id" class="pass-card" @click="$router.push(`/confirmation/${p.id}`)">
          <div class="pc-top">
            <span class="p-ticket">{{ p.ticketNumber }}</span>
            <span class="p-gate">{{ p.entryGate }}</span>
          </div>
          <span class="p-title">{{ p.event.title }}</span>
          <span class="p-zone">{{ p.zone.name.en }} ({{ p.seatCode }})</span>
          <div class="pc-foot">
            <span>{{ p.issuedAt }}</span>
            <span class="p-paid">${{ p.totalPaid.toFixed(2) }}</span>
          </div>
        </div>
      </div>
      <div v-else class="empty-state">
        <p>No concert tickets found.</p>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { useEventStore } from '../store/eventStore'
const store = useEventStore()
</script>

<style scoped>
.my-event-view { min-height: 100vh; background-color: #0d0614; color: #ffffff; }
.nav-bar {
  display: flex; align-items: center; justify-content: space-between;
  padding: 12px 16px; background: #1a0b2e; border-bottom: 1px solid #2e1065;
}
.nav-back-btn, .nav-exit-btn { background: none; border: none; color: white; cursor: pointer; }
.nav-title { margin: 0; font-size: 16px; font-weight: 800; }
.content-scroll { padding: 16px; }

.passes-list { display: flex; flex-direction: column; gap: 12px; }
.pass-card { background: #1a0b2e; border-radius: 14px; padding: 14px; border: 1px solid #2e1065; cursor: pointer; }
.pc-top { display: flex; justify-content: space-between; margin-bottom: 4px; }
.p-ticket { font-weight: 900; font-size: 13px; color: #f59e0b; }
.p-gate { font-size: 10px; font-weight: 800; background: #0d0614; color: #f59e0b; padding: 2px 6px; border-radius: 4px; }
.p-title { font-size: 13px; font-weight: 800; color: #ffffff; display: block; }
.p-zone { font-size: 11px; color: #c084fc; margin-bottom: 8px; display: block; }
.pc-foot { display: flex; justify-content: space-between; font-size: 12px; color: #94a3b8; border-top: 1px solid #2e1065; padding-top: 6px; }
.p-paid { font-weight: 900; color: #ffffff; }
.empty-state { text-align: center; padding: 40px; color: #94a3b8; }
</style>
