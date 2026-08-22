<template>
  <div class="my-parcel-view">
    <div class="nav-bar">
      <button class="nav-back-btn" @click="$router.push('/')">
        <svg viewBox="0 0 24 24" width="22" height="22" stroke="currentColor" stroke-width="2.5" fill="none">
          <line x1="19" y1="12" x2="5" y2="12"></line>
          <polyline points="12 19 5 12 12 5"></polyline>
        </svg>
      </button>
      <h2 class="nav-title">Locker History</h2>
      <button class="nav-exit-btn" @click="$router.push('/')">✕</button>
    </div>

    <div class="content-scroll">
      <div v-if="store.state.actions.length > 0" class="actions-list">
        <div v-for="a in store.state.actions" :key="a.id" class="action-card" @click="$router.push(`/confirmation/${a.id}`)">
          <div class="ac-top">
            <span class="l-bay">{{ a.lockerBay }}</span>
            <span class="l-stat">PIN: {{ a.pinCode }}</span>
          </div>
          <span class="l-meta">{{ a.size }} Locker • Sent to: {{ a.recipientPhone }}</span>
          <div class="ac-foot">
            <span>{{ a.createdAt }}</span>
            <span class="l-paid">${{ a.totalPaid.toFixed(2) }}</span>
          </div>
        </div>
      </div>
      <div v-else class="empty-state">
        <p>No locker history found.</p>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { useParcelStore } from '../store/parcelStore'
const store = useParcelStore()
</script>

<style scoped>
.my-parcel-view { min-height: 100vh; background-color: #f8fafc; color: #0f172a; }
.nav-bar {
  display: flex; align-items: center; justify-content: space-between;
  padding: 12px 16px; background: #ffffff; border-bottom: 1px solid #e2e8f0;
}
.nav-back-btn, .nav-exit-btn { background: none; border: none; cursor: pointer; color: #0f172a; }
.nav-title { margin: 0; font-size: 16px; font-weight: 800; }
.content-scroll { padding: 16px; }

.actions-list { display: flex; flex-direction: column; gap: 12px; }
.action-card { background: #ffffff; border-radius: 14px; padding: 14px; border: 1px solid #e2e8f0; cursor: pointer; }
.ac-top { display: flex; justify-content: space-between; margin-bottom: 4px; }
.l-bay { font-weight: 900; font-size: 14px; color: #0f172a; }
.l-stat { font-size: 10px; font-weight: 800; background: #fef08a; color: #854d0e; padding: 2px 6px; border-radius: 4px; }
.l-meta { font-size: 11px; color: #64748b; margin-bottom: 8px; display: block; }
.ac-foot { display: flex; justify-content: space-between; font-size: 12px; color: #64748b; border-top: 1px solid #f1f5f9; padding-top: 6px; }
.l-paid { font-weight: 900; color: #854d0e; }
.empty-state { text-align: center; padding: 40px; color: #64748b; }
</style>
