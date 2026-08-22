<template>
  <div class="status-view">
    <div class="nav-bar">
      <button class="nav-back-btn" @click="$router.push('/')">
        <svg viewBox="0 0 24 24" width="22" height="22" stroke="currentColor" stroke-width="2.5" fill="none">
          <line x1="19" y1="12" x2="5" y2="12"></line>
          <polyline points="12 19 5 12 12 5"></polyline>
        </svg>
      </button>
      <h2 class="nav-title">{{ t.orderStatus }}</h2>
      <button class="nav-exit-btn" @click="$router.push('/')">✕</button>
    </div>

    <div class="content-scroll" v-if="session">
      <div class="laundry-telemetry-card">
        <div class="drum-container">
          <div class="big-drum">
            <span class="bubble-anim">🫧</span>
            <span class="mins-left">{{ minsRemaining }} min</span>
            <span class="cycle-type">{{ session.config.waterTemp }}</span>
          </div>
        </div>

        <div class="drum-stats-grid">
          <div class="d-stat">
            <span class="lbl">MACHINE</span>
            <span class="val">{{ session.machine.number }}</span>
          </div>
          <div class="d-stat">
            <span class="lbl">SPIN SPEED</span>
            <span class="val">{{ session.config.spinSpeed.split(' ')[0] }}</span>
          </div>
          <div class="d-stat">
            <span class="lbl">START TIME</span>
            <span class="val">{{ session.startTime }}</span>
          </div>
          <div class="d-stat">
            <span class="lbl">STATUS</span>
            <span class="val run">RUNNING</span>
          </div>
        </div>
      </div>

      <!-- Emergency Unlock / Barcode Pass -->
      <div class="qr-door-card">
        <p class="qr-hint">Scan at machine interface to unlock drum when cycle ends</p>
        <PPQRCode :value="session.qrValue" :size="130" foreground="#0f172a" background="#ffffff" />
        <span class="tok-code">{{ session.sessionToken }}</span>
      </div>

      <PPButton variant="primary" block size="large" @click="$router.push('/')">
        Back to Laundromat Bays
      </PPButton>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, onUnmounted } from 'vue'
import { useRoute } from 'vue-router'
import { PPQRCode, PPButton } from '@phanna/ui-framework'
import { useLaundryStore } from '../store/laundryStore'
import { useI18n } from '../i18n'
import type { LaundrySessionRecord } from '../types/laundry'

const route = useRoute()
const store = useLaundryStore()
const { t } = useI18n()
const session = ref<LaundrySessionRecord | null>(null)
const minsRemaining = ref(28)
let timer: any = null

onMounted(() => {
  const id = route.params.id as string
  if (id) session.value = store.state.sessions.find(s => s.id === id) || null
  if (!session.value) session.value = store.state.currentSession || store.state.sessions[0] || null

  timer = setInterval(() => {
    if (minsRemaining.value > 0) minsRemaining.value--
  }, 4000)
})

onUnmounted(() => {
  if (timer) clearInterval(timer)
})
</script>

<style scoped>
.status-view { min-height: 100vh; background-color: #f0f9ff; color: #0f172a; }
.nav-bar {
  display: flex; align-items: center; justify-content: space-between;
  padding: 12px 16px; background: #ffffff; border-bottom: 1px solid #bae6fd;
}
.nav-back-btn, .nav-exit-btn { background: none; border: none; cursor: pointer; color: #0f172a; }
.nav-title { margin: 0; font-size: 16px; font-weight: 800; }
.content-scroll { padding: 16px; display: flex; flex-direction: column; gap: 14px; }

.laundry-telemetry-card {
  background: #ffffff; border-radius: 20px; padding: 24px 16px; border: 1px solid #bae6fd;
  text-align: center; box-shadow: 0 10px 30px rgba(14,165,233,0.06);
}
.drum-container { display: flex; justify-content: center; margin-bottom: 20px; }
.big-drum {
  width: 140px; height: 140px; border-radius: 50%; border: 6px solid #0ea5e9;
  display: flex; flex-direction: column; align-items: center; justify-content: center;
  box-shadow: 0 0 20px rgba(14,165,233,0.2);
}
.bubble-anim { font-size: 24px; animation: bounce 1.5s infinite; }
@keyframes bounce { 0%, 100% { transform: translateY(0); } 50% { transform: translateY(-6px); } }
.mins-left { font-size: 26px; font-weight: 900; color: #0284c7; }
.cycle-type { font-size: 10px; color: #64748b; font-weight: 700; }

.drum-stats-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 8px; }
.d-stat { background: #f0f9ff; padding: 10px; border-radius: 10px; border: 1px solid #e0f2fe; display: flex; flex-direction: column; }
.lbl { font-size: 9px; font-weight: 800; color: #64748b; }
.val { font-size: 13px; font-weight: 900; color: #0f172a; }
.val.run { color: #0ea5e9; }

.qr-door-card {
  background: #ffffff; border-radius: 16px; padding: 16px; border: 1px solid #bae6fd;
  text-align: center; display: flex; flex-direction: column; align-items: center; gap: 8px;
}
.qr-hint { font-size: 11px; color: #64748b; margin: 0; }
.tok-code { font-family: monospace; font-size: 12px; font-weight: 800; color: #0284c7; }
</style>
