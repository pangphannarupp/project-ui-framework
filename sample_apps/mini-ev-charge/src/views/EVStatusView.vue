<template>
  <div class="session-view">
    <div class="nav-bar">
      <button class="nav-back-btn" @click="$router.push('/')">
        <svg viewBox="0 0 24 24" width="22" height="22" stroke="currentColor" stroke-width="2.5" fill="none">
          <line x1="19" y1="12" x2="5" y2="12"></line>
          <polyline points="12 19 5 12 12 5"></polyline>
        </svg>
      </button>
      <h2 class="nav-title">{{ t.liveGauge }}</h2>
      <button class="nav-exit-btn" @click="$router.push('/')">✕</button>
    </div>

    <div class="content-scroll" v-if="session">
      <!-- Live Telemetry Card -->
      <div class="telemetry-card">
        <div class="battery-visual">
          <div class="battery-ring">
            <span class="soc-number">{{ socPercent }}%</span>
            <span class="soc-sub">⚡ Fast DC</span>
          </div>
        </div>

        <div class="power-stats-grid">
          <div class="p-stat">
            <span class="lbl">POWER</span>
            <span class="val">{{ session.chargingPowerKw }} kW</span>
          </div>
          <div class="p-stat">
            <span class="lbl">ENERGY</span>
            <span class="val">{{ session.energyDeliveredKwh }} kWh</span>
          </div>
          <div class="p-stat">
            <span class="lbl">TARGET</span>
            <span class="val">{{ session.targetPercent }}%</span>
          </div>
          <div class="p-stat">
            <span class="lbl">COST</span>
            <span class="val">${{ session.totalAmount.toFixed(2) }}</span>
          </div>
        </div>
      </div>

      <!-- Station Info -->
      <div class="station-meta-card">
        <h4>{{ session.station.name }}</h4>
        <span class="meta-line">📍 {{ session.station.address }}</span>
        <span class="meta-line">🔌 Port: {{ session.portId }}</span>
      </div>

      <!-- QR -->
      <div class="qr-stop-card">
        <p class="qr-hint">Scan at dispenser screen to stop session prematurely</p>
        <PPQRCode :value="session.qrValue" :size="120" foreground="#0f172a" background="#ffffff" />
        <span class="session-token">{{ session.sessionCode }}</span>
      </div>

      <button class="btn-home" @click="$router.push('/')">Back to Stations</button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, onUnmounted } from 'vue'
import { useRoute } from 'vue-router'
import { PPQRCode } from '@phanna/ui-framework'
import { useEVStore } from '../store/evStore'
import { useI18n } from '../i18n'
import type { EVChargeSession } from '../types/ev'

const route = useRoute()
const store = useEVStore()
const { t } = useI18n()
const session = ref<EVChargeSession | null>(null)
const socPercent = ref(36)
let timer: any = null

onMounted(() => {
  const id = route.params.id as string
  if (id) session.value = store.state.sessions.find(s => s.id === id) || null
  if (!session.value) session.value = store.state.currentSession || store.state.sessions[0] || null

  timer = setInterval(() => {
    if (session.value && socPercent.value < session.value.targetPercent) {
      socPercent.value++
    }
  }, 2000)
})

onUnmounted(() => {
  if (timer) clearInterval(timer)
})
</script>

<style scoped>
.session-view { min-height: 100vh; background-color: #f8fafc; }
.nav-bar {
  display: flex; align-items: center; justify-content: space-between;
  padding: 12px 16px; background: #ffffff; border-bottom: 1px solid #edf2f7;
}
.nav-back-btn, .nav-exit-btn { background: none; border: none; cursor: pointer; }
.nav-title { margin: 0; font-size: 16px; font-weight: 800; }
.content-scroll { padding: 16px; display: flex; flex-direction: column; gap: 14px; }

.telemetry-card {
  background: #ffffff; border-radius: 20px; padding: 24px 16px; border: 1px solid #e2e8f0;
  text-align: center; box-shadow: 0 10px 30px rgba(0,0,0,0.05);
}
.battery-visual { display: flex; justify-content: center; margin-bottom: 20px; }
.battery-ring {
  width: 140px; height: 140px; border-radius: 50%;
  border: 8px solid #10b981; display: flex; flex-direction: column; align-items: center; justify-content: center;
  box-shadow: 0 0 20px rgba(16, 185, 129, 0.25);
}
.soc-number { font-size: 32px; font-weight: 900; color: #047857; }
.soc-sub { font-size: 11px; font-weight: 800; color: #10b981; }

.power-stats-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 10px; }
.p-stat { background: #f8fafc; padding: 10px; border-radius: 10px; border: 1px solid #e2e8f0; display: flex; flex-direction: column; }
.lbl { font-size: 9px; font-weight: 800; color: #94a3b8; }
.val { font-size: 14px; font-weight: 900; color: #0f172a; }

.station-meta-card { background: #ffffff; border-radius: 16px; padding: 14px; border: 1px solid #e2e8f0; }
.station-meta-card h4 { margin: 0 0 4px 0; font-size: 14px; font-weight: 800; }
.meta-line { font-size: 11px; color: #64748b; display: block; }

.qr-stop-card {
  background: #ffffff; border-radius: 16px; padding: 16px; text-align: center;
  border: 1px solid #e2e8f0; display: flex; flex-direction: column; align-items: center; gap: 8px;
}
.qr-hint { font-size: 11px; color: #64748b; margin: 0; }
.session-token { font-family: monospace; font-size: 12px; font-weight: 800; color: #64748b; }

.btn-home {
  background: #10b981; color: white; border: none; padding: 12px; border-radius: 12px; font-weight: 800; cursor: pointer;
}
</style>
