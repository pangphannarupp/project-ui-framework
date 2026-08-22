<template>
  <div class="scooter-status-root" v-if="active">
    <div class="status-top">
      <div class="speedo-gauge">
        <span class="speed-number">18.4</span>
        <span class="speed-unit">KM / H</span>
      </div>
      <h2>{{ t.activeTrip }}</h2>
      <span class="ref-no">{{ t.tripCode }}: {{ active.tripCode }}</span>
    </div>

    <div class="hud-telemetry-panel">
      <div class="hud-stat-box">
        <span class="stat-v">14 MIN</span>
        <span class="stat-l">ELAPSED TIME</span>
      </div>
      <div class="hud-stat-box">
        <span class="stat-v">2.8 KM</span>
        <span class="stat-l">DISTANCE</span>
      </div>
      <div class="hud-stat-box">
        <span class="stat-v neon-lime">0.42 KG</span>
        <span class="stat-l">CO2 SAVED</span>
      </div>
    </div>

    <div class="scooter-qr-lock">
      <PPQRCode :value="active.tripCode" :size="130" />
      <span class="qr-label">Scan at drop zone to lock & end ride</span>
    </div>

    <div class="status-actions">
      <PPButton variant="primary" block size="large" @click="handleEndRide" class="btn-end-ride">
        {{ t.endRide }}
      </PPButton>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { useRouter } from 'vue-router'
import { PPQRCode, PPButton } from '@phanna/ui-framework'
import { useScooterStore } from '../store/scooterStore'
import { useI18n } from '../i18n'

const store = useScooterStore()
const { t } = useI18n()

const active = computed(() => store.state.activeTrip || store.state.trips[0])

const handleEndRide = () => {
  alert('Ride ended! Final summary saved. Helmet locked.')
  router.push('/my-tickets')
}
</script>

<style scoped>
.scooter-status-root {
  min-height: 100vh;
  background: #0b0f17;
  color: #f8fafc;
  padding: 24px 16px;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 16px;
}
.status-top { display: flex; flex-direction: column; align-items: center; text-align: center; }
.speedo-gauge {
  width: 90px; height: 90px; border-radius: 50%; border: 3px solid #ccff00;
  display: flex; flex-direction: column; align-items: center; justify-content: center;
  box-shadow: 0 0 20px rgba(204,255,0,0.3); margin-bottom: 8px;
}
.speed-number { font-size: 24px; font-weight: 900; color: #ccff00; }
.speed-unit { font-size: 7px; font-weight: 900; color: #9ca3af; }
.status-top h2 { font-size: 16px; font-weight: 900; margin: 0; color: #ffffff; }
.ref-no { font-size: 10px; font-family: monospace; color: #6b7280; margin-top: 4px; }

.hud-telemetry-panel {
  display: grid; grid-template-columns: repeat(3, 1fr); gap: 8px; width: 100%;
  background: #111827; padding: 14px; border-radius: 16px; border: 1px solid #1f2937;
}
.hud-stat-box { display: flex; flex-direction: column; align-items: center; }
.stat-v { font-size: 14px; font-weight: 900; color: #ffffff; }
.stat-l { font-size: 7px; font-weight: 800; color: #6b7280; margin-top: 2px; }
.neon-lime { color: #ccff00 !important; }

.scooter-qr-lock {
  background: white; border-radius: 16px; padding: 14px; display: flex; flex-direction: column; align-items: center; gap: 6px;
}
.qr-label { font-size: 9px; font-weight: 800; color: #0b0f17; }

.status-actions { width: 100%; margin-top: 10px; }
.btn-end-ride { background: #ef4444 !important; border-color: #ef4444 !important; color: white !important; font-weight: 900 !important; }
</style>
