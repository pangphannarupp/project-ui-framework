<template>
  <div class="pass-view">
    <div class="nav-bar">
      <button class="nav-back-btn" @click="$router.push('/')">
        <svg viewBox="0 0 24 24" width="22" height="22" stroke="currentColor" stroke-width="2.5" fill="none">
          <line x1="19" y1="12" x2="5" y2="12"></line>
          <polyline points="12 19 5 12 12 5"></polyline>
        </svg>
      </button>
      <h2 class="nav-title">{{ t.statusTitle }}</h2>
      <button class="nav-exit-btn" @click="$router.push('/')">✕</button>
    </div>

    <div class="content-scroll" v-if="pass">
      <div class="arena-gate-card">
        <div class="ag-top">
          <span class="ag-gate">{{ pass.entryGate }}</span>
          <h3 class="ag-event">{{ pass.event.title }}</h3>
          <span class="ag-zone">{{ pass.zone.name.en }} • {{ pass.seatCode }}</span>
        </div>

        <div class="ag-body">
          <p class="ag-hint">Dynamic anti-screenshot barcode. Present at arena turnstile scanner.</p>
          <PPQRCode :value="pass.qrValue" :size="140" foreground="#0d0614" background="#ffffff" />
          <span class="ag-code">{{ pass.ticketNumber }}</span>
        </div>

        <div class="ag-foot">
          <span>{{ pass.event.date }} • {{ pass.event.venue }}</span>
        </div>
      </div>

      <PPButton variant="primary" block size="large" @click="$router.push('/')">
        Back to Arena Overview
      </PPButton>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import { PPQRCode, PPButton } from '@phanna/ui-framework'
import { useEventStore } from '../store/eventStore'
import { useI18n } from '../i18n'
import type { ConcertPassRecord } from '../types/event'

const route = useRoute()
const store = useEventStore()
const { t } = useI18n()
const pass = ref<ConcertPassRecord | null>(null)

onMounted(() => {
  const id = route.params.id as string
  if (id) pass.value = store.state.passes.find(p => p.id === id) || null
  if (!pass.value) pass.value = store.state.currentPass || store.state.passes[0] || null
})
</script>

<style scoped>
.pass-view { min-height: 100vh; background-color: #0d0614; color: #ffffff; }
.nav-bar {
  display: flex; align-items: center; justify-content: space-between;
  padding: 12px 16px; background: #1a0b2e; border-bottom: 1px solid #2e1065;
}
.nav-back-btn, .nav-exit-btn { background: none; border: none; cursor: pointer; color: white; }
.nav-title { margin: 0; font-size: 16px; font-weight: 800; }
.content-scroll { padding: 20px 16px; display: flex; flex-direction: column; gap: 16px; }

.arena-gate-card {
  background: #1a0b2e; border-radius: 20px; overflow: hidden;
  border: 1.5px solid #f59e0b; box-shadow: 0 10px 30px rgba(245,158,11,0.15); text-align: center;
}

.ag-top { background: #f59e0b; color: black; padding: 18px; }
.ag-gate { font-size: 9px; font-weight: 900; background: rgba(0,0,0,0.15); padding: 3px 8px; border-radius: 4px; }
.ag-event { font-size: 18px; font-weight: 900; margin: 6px 0 2px 0; }
.ag-zone { font-size: 11px; font-weight: 800; }

.ag-body { padding: 20px 16px; display: flex; flex-direction: column; align-items: center; gap: 8px; background: #ffffff; }
.ag-hint { font-size: 11px; color: #64748b; margin: 0; max-width: 240px; }
.ag-code { font-family: monospace; font-size: 12px; font-weight: 900; color: #0d0614; }

.ag-foot { background: #1a0b2e; padding: 12px; font-size: 11px; color: #cbd5e1; font-weight: 700; border-top: 1px solid #2e1065; }
</style>
