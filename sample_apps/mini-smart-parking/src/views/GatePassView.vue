<template>
  <div class="pass-view">
    <div class="nav-bar">
      <button class="nav-back-btn" @click="$router.push('/')">
        <svg viewBox="0 0 24 24" width="22" height="22" stroke="currentColor" stroke-width="2.5" fill="none">
          <line x1="19" y1="12" x2="5" y2="12"></line>
          <polyline points="12 19 5 12 12 5"></polyline>
        </svg>
      </button>
      <h2 class="nav-title">Barrier Gate Exit Pass</h2>
      <button class="nav-exit-btn" @click="$router.push('/')">✕</button>
    </div>

    <div class="content-scroll">
      <div class="gate-pass-card">
        <div class="gate-top">
          <span class="g-status">✓ PAYMENT COMPLETED</span>
          <h3 class="g-plate">{{ store.state.activeSession?.plateNumber }}</h3>
          <span class="g-loc">{{ store.state.activeSession?.location }}</span>
        </div>

        <div class="gate-qr-body">
          <p class="g-hint">Show or scan this QR at the exit barrier scanner</p>
          <PPQRCode :value="store.state.activeSession?.qrValue || 'PAID_GATE_OPEN'" :size="140" foreground="#0f172a" background="#ffffff" />
          <span class="g-token">{{ store.state.activeSession?.ticketNumber }}</span>
        </div>

        <div class="gate-foot">
          <span>Grace period to exit: <strong>15 minutes</strong></span>
        </div>
      </div>

      <button class="btn-home" @click="$router.push('/')">Back to Parking Home</button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { PPQRCode } from '@phanna/ui-framework'
import { useParkingStore } from '../store/parkingStore'
const store = useParkingStore()
</script>

<style scoped>
.pass-view { min-height: 100vh; background-color: #f8fafc; }
.nav-bar {
  display: flex; align-items: center; justify-content: space-between;
  padding: 12px 16px; background: #ffffff; border-bottom: 1px solid #edf2f7;
}
.nav-back-btn, .nav-exit-btn { background: none; border: none; cursor: pointer; }
.nav-title { margin: 0; font-size: 16px; font-weight: 800; }
.content-scroll { padding: 20px 16px; display: flex; flex-direction: column; gap: 16px; }

.gate-pass-card {
  background: #ffffff; border-radius: 20px; overflow: hidden;
  border: 1px solid #e2e8f0; box-shadow: 0 10px 30px rgba(0,0,0,0.06); text-align: center;
}

.gate-top { background: #0284c7; color: white; padding: 18px; }
.g-status { font-size: 10px; font-weight: 800; background: rgba(255,255,255,0.2); padding: 3px 8px; border-radius: 4px; }
.g-plate { font-size: 24px; font-weight: 900; font-family: monospace; margin: 6px 0 2px 0; }
.g-loc { font-size: 11px; opacity: 0.85; }

.gate-qr-body { padding: 20px 16px; display: flex; flex-direction: column; align-items: center; gap: 8px; }
.g-hint { font-size: 11px; color: #64748b; margin: 0; }
.g-token { font-family: monospace; font-size: 12px; font-weight: 800; color: #64748b; }

.gate-foot { background: #f8fafc; padding: 12px; border-top: 1px solid #f1f5f9; font-size: 11px; color: #64748b; }

.btn-home {
  background: #0284c7; color: white; border: none; padding: 12px; border-radius: 12px; font-size: 14px; font-weight: 800; cursor: pointer;
}
</style>
