<template>
  <div class="pass-view">
    <div class="nav-bar">
      <button class="nav-back-btn" @click="$router.push('/')">
        <svg viewBox="0 0 24 24" width="22" height="22" stroke="currentColor" stroke-width="2.5" fill="none">
          <line x1="19" y1="12" x2="5" y2="12"></line>
          <polyline points="12 19 5 12 12 5"></polyline>
        </svg>
      </button>
      <h2 class="nav-title">Boarding Pass</h2>
      <button class="nav-exit-btn" @click="$router.push('/')">✕</button>
    </div>

    <div class="content-scroll" v-if="booking">
      <div class="boarding-card">
        <div class="pass-top">
          <span class="operator-badge">{{ booking.route.operator }}</span>
          <div class="route-flight-style">
            <div class="city-box">
              <span class="city-code">{{ booking.route.origin.substring(0, 3).toUpperCase() }}</span>
              <span class="city-name">{{ booking.route.origin }}</span>
            </div>
            <div class="bus-divider">➔</div>
            <div class="city-box">
              <span class="city-code">{{ booking.route.destination.substring(0, 3).toUpperCase() }}</span>
              <span class="city-name">{{ booking.route.destination }}</span>
            </div>
          </div>
        </div>

        <div class="pass-perforation">
          <div class="circle-cut left"></div>
          <div class="dash-line"></div>
          <div class="circle-cut right"></div>
        </div>

        <div class="pass-body">
          <div class="meta-grid">
            <div class="meta-item">
              <span class="lbl">PASSENGER</span>
              <span class="val">{{ booking.passengerName }}</span>
            </div>
            <div class="meta-item">
              <span class="lbl">SEATS</span>
              <span class="val highlight">{{ booking.seats.join(', ') }}</span>
            </div>
            <div class="meta-item">
              <span class="lbl">DEPARTURE</span>
              <span class="val">{{ booking.route.departureTime }}</span>
            </div>
            <div class="meta-item">
              <span class="lbl">DATE</span>
              <span class="val">{{ booking.travelDate }}</span>
            </div>
          </div>

          <div class="qr-gate-section">
            <PPQRCode :value="booking.qrValue" :size="120" foreground="#0f172a" background="#ffffff" />
            <span class="ticket-ref">{{ booking.ticketCode }}</span>
          </div>
        </div>
      </div>

      <div class="pass-actions">
        <button class="btn-wallet" @click="$router.push('/my-tickets')">{{ t.myPasses }}</button>
        <button class="btn-home" @click="$router.push('/')">Search Another Route</button>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import { PPQRCode } from '@phanna/ui-framework'
import { useBusStore } from '../store/busStore'
import { useI18n } from '../i18n'
import type { BusBookingRecord } from '../types/bus'

const route = useRoute()
const store = useBusStore()
const { t } = useI18n()
const booking = ref<BusBookingRecord | null>(null)

onMounted(() => {
  const id = route.params.id as string
  if (id) booking.value = store.state.bookings.find(b => b.id === id) || null
  if (!booking.value) booking.value = store.state.currentBooking || store.state.bookings[0] || null
})
</script>

<style scoped>
.pass-view { min-height: 100vh; background-color: #f8fafc; }
.nav-bar {
  display: flex; align-items: center; justify-content: space-between;
  padding: 12px 16px; background: #ffffff; border-bottom: 1px solid #edf2f7;
}
.nav-back-btn, .nav-exit-btn { background: none; border: none; cursor: pointer; }
.nav-title { margin: 0; font-size: 16px; font-weight: 800; }
.content-scroll { padding: 16px; display: flex; flex-direction: column; gap: 16px; }

.boarding-card {
  background: #ffffff; border-radius: 20px; overflow: hidden;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08); border: 1px solid #e2e8f0;
}

.pass-top { background: linear-gradient(135deg, #2563eb 0%, #1d4ed8 100%); color: white; padding: 18px; }
.operator-badge { font-size: 10px; font-weight: 800; background: rgba(255,255,255,0.2); padding: 3px 6px; border-radius: 4px; }
.route-flight-style { display: flex; justify-content: space-between; align-items: center; margin-top: 12px; }
.city-box { display: flex; flex-direction: column; }
.city-code { font-size: 22px; font-weight: 900; }
.city-name { font-size: 11px; opacity: 0.85; }
.bus-divider { font-size: 20px; opacity: 0.8; }

.pass-perforation {
  height: 20px; background: #ffffff; position: relative;
  display: flex; align-items: center; justify-content: center;
}
.circle-cut { position: absolute; width: 20px; height: 20px; border-radius: 50%; background: #f8fafc; }
.circle-cut.left { left: -10px; }
.circle-cut.right { right: -10px; }
.dash-line { width: 85%; border-top: 2px dashed #cbd5e1; }

.pass-body { padding: 16px; }
.meta-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 12px; margin-bottom: 16px; }
.meta-item { display: flex; flex-direction: column; }
.lbl { font-size: 9px; font-weight: 800; color: #94a3b8; }
.val { font-size: 13px; font-weight: 800; color: #0f172a; }
.val.highlight { color: #2563eb; }

.qr-gate-section { display: flex; flex-direction: column; align-items: center; gap: 6px; }
.ticket-ref { font-family: monospace; font-weight: 800; font-size: 12px; color: #64748b; }

.pass-actions { display: flex; flex-direction: column; gap: 8px; }
.btn-wallet { background: #ffffff; border: 1px solid #cbd5e1; padding: 12px; border-radius: 12px; font-weight: 700; cursor: pointer; }
.btn-home { background: #2563eb; color: white; border: none; padding: 12px; border-radius: 12px; font-weight: 800; cursor: pointer; }
</style>
