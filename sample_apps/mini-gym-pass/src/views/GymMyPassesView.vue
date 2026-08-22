<template>
  <div class="my-gym-view">
    <div class="nav-bar">
      <button class="nav-back-btn" @click="$router.push('/')">
        <svg viewBox="0 0 24 24" width="22" height="22" stroke="currentColor" stroke-width="2.5" fill="none">
          <line x1="19" y1="12" x2="5" y2="12"></line>
          <polyline points="12 19 5 12 12 5"></polyline>
        </svg>
      </button>
      <h2 class="nav-title">My Gym Passes</h2>
      <button class="nav-exit-btn" @click="$router.push('/')">✕</button>
    </div>

    <div class="content-scroll">
      <div v-if="store.state.passes.length > 0" class="passes-list">
        <div v-for="p in store.state.passes" :key="p.id" class="pass-card" @click="$router.push(`/confirmation/${p.id}`)">
          <div class="pc-top">
            <span class="p-plan">{{ p.planName }}</span>
            <span class="p-stat">ACTIVE</span>
          </div>
          <span class="p-valid">{{ p.validUntil }}</span>
          <div class="pc-foot">
            <span>{{ p.memberId }}</span>
            <span class="p-paid">${{ p.totalPaid.toFixed(2) }}</span>
          </div>
        </div>
      </div>
      <div v-else class="empty-state">
        <p>No active passes found.</p>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { useGymStore } from '../store/gymStore'
const store = useGymStore()
</script>

<style scoped>
.my-gym-view { min-height: 100vh; background-color: #09090b; color: #ffffff; }
.nav-bar {
  display: flex; align-items: center; justify-content: space-between;
  padding: 12px 16px; background: #18181b; border-bottom: 1px solid #27272a;
}
.nav-back-btn, .nav-exit-btn { background: none; border: none; color: white; cursor: pointer; }
.nav-title { margin: 0; font-size: 16px; font-weight: 800; }
.content-scroll { padding: 16px; }

.passes-list { display: flex; flex-direction: column; gap: 12px; }
.pass-card { background: #18181b; border-radius: 14px; padding: 14px; border: 1px solid #27272a; cursor: pointer; }
.pc-top { display: flex; justify-content: space-between; margin-bottom: 4px; }
.p-plan { font-weight: 900; font-size: 14px; color: #84cc16; }
.p-stat { font-size: 10px; font-weight: 800; background: rgba(132,204,22,0.15); color: #84cc16; padding: 2px 6px; border-radius: 4px; }
.p-valid { font-size: 11px; color: #a1a1aa; margin-bottom: 8px; display: block; }
.pc-foot { display: flex; justify-content: space-between; font-size: 12px; color: #71717a; border-top: 1px solid #27272a; padding-top: 6px; }
.p-paid { font-weight: 900; color: #ffffff; }
.empty-state { text-align: center; padding: 40px; color: #71717a; }
</style>
