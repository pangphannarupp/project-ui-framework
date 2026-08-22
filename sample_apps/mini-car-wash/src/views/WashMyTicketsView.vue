<template>
  <div class="my-wash-view">
    <div class="nav-bar">
      <button class="nav-back-btn" @click="$router.push('/')">
        <svg viewBox="0 0 24 24" width="22" height="22" stroke="currentColor" stroke-width="2.5" fill="none">
          <line x1="19" y1="12" x2="5" y2="12"></line>
          <polyline points="12 19 5 12 12 5"></polyline>
        </svg>
      </button>
      <h2 class="nav-title">Wash Tickets</h2>
      <button class="nav-exit-btn" @click="$router.push('/')">✕</button>
    </div>

    <div class="content-scroll">
      <div v-if="store.state.records.length > 0" class="records-list">
        <div v-for="r in store.state.records" :key="r.id" class="record-card" @click="$router.push(`/confirmation/${r.id}`)">
          <div class="rc-top">
            <span class="r-ticket">{{ r.washTicket }}</span>
            <span class="r-bay">{{ r.bayAssigned }}</span>
          </div>
          <span class="r-tier">{{ r.tier.name.en }} • {{ r.vehiclePlate }}</span>
          <div class="rc-foot">
            <span>{{ r.createdAt }}</span>
            <span class="r-paid">${{ r.totalPaid.toFixed(2) }}</span>
          </div>
        </div>
      </div>
      <div v-else class="empty-state">
        <p>No car wash tickets found.</p>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { useWashStore } from '../store/washStore'
const store = useWashStore()
</script>

<style scoped>
.my-wash-view { min-height: 100vh; background-color: #0c1821; color: #ffffff; }
.nav-bar {
  display: flex; align-items: center; justify-content: space-between;
  padding: 12px 16px; background: #1b2a41; border-bottom: 1px solid #324a5f;
}
.nav-back-btn, .nav-exit-btn { background: none; border: none; color: white; cursor: pointer; }
.nav-title { margin: 0; font-size: 16px; font-weight: 800; }
.content-scroll { padding: 16px; }

.records-list { display: flex; flex-direction: column; gap: 12px; }
.record-card { background: #1b2a41; border-radius: 14px; padding: 14px; border: 1px solid #324a5f; cursor: pointer; }
.rc-top { display: flex; justify-content: space-between; margin-bottom: 4px; }
.r-ticket { font-weight: 900; font-size: 14px; color: #00b4d8; }
.r-bay { font-size: 10px; font-weight: 800; background: #0c1821; color: #00b4d8; padding: 2px 6px; border-radius: 4px; }
.r-tier { font-size: 11px; color: #cbd5e1; margin-bottom: 8px; display: block; }
.rc-foot { display: flex; justify-content: space-between; font-size: 12px; color: #94a3b8; border-top: 1px solid #324a5f; padding-top: 6px; }
.r-paid { font-weight: 900; color: #ffffff; }
.empty-state { text-align: center; padding: 40px; color: #94a3b8; }
</style>
