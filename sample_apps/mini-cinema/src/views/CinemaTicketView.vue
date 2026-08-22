<template>
  <div class="ticket-view">
    <div class="nav-bar">
      <button class="nav-back-btn" @click="$router.push('/')">
        <svg viewBox="0 0 24 24" width="22" height="22" stroke="currentColor" stroke-width="2.5" fill="none">
          <line x1="19" y1="12" x2="5" y2="12"></line>
          <polyline points="12 19 5 12 12 5"></polyline>
        </svg>
      </button>
      <h2 class="nav-title">{{ t.paymentSuccessTitle }}</h2>
      <button class="nav-exit-btn" @click="$router.push('/')">✕</button>
    </div>

    <div class="content-scroll" v-if="booking">
      <div class="cinema-e-ticket">
        <div class="ticket-top">
          <span class="hall-badge">{{ booking.cinemaBranch }}</span>
          <h3 class="t-movie-title">{{ booking.movie.title }}</h3>
          <div class="t-meta">
            <span>📅 {{ booking.visitDate }}</span>
            <span>⏰ {{ booking.showtime.time }} ({{ booking.showtime.hall }})</span>
          </div>
        </div>

        <div class="ticket-perforation">
          <div class="hole left"></div>
          <div class="dash-line"></div>
          <div class="hole right"></div>
        </div>

        <div class="ticket-bottom">
          <div class="seats-callout">
            <span class="seat-lbl">{{ t.seats }}:</span>
            <span class="seat-val">{{ booking.seats.join(', ') }}</span>
          </div>

          <div class="qr-box">
            <PPQRCode :value="booking.qrValue" :size="130" foreground="#0f172a" background="#ffffff" />
            <span class="booking-code">{{ booking.bookingCode }}</span>
          </div>
        </div>
      </div>

      <div class="ticket-actions">
        <button class="btn-wallet" @click="$router.push('/my-tickets')">{{ t.myPasses }}</button>
        <button class="btn-home" @click="$router.push('/')">{{ t.newBooking }}</button>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import { PPQRCode } from '@phanna/ui-framework'
import { useCinemaStore } from '../store/cinemaStore'
import { useI18n } from '../i18n'
import type { CinemaBookingRecord } from '../types/cinema'

const route = useRoute()
const store = useCinemaStore()
const { t } = useI18n()
const booking = ref<CinemaBookingRecord | null>(null)

onMounted(() => {
  const id = route.params.id as string
  if (id) booking.value = store.state.bookings.find(b => b.id === id) || null
  if (!booking.value) booking.value = store.state.currentBooking || store.state.bookings[0] || null
})
</script>

<style scoped>
.ticket-view { min-height: 100vh; background-color: #0f172a; color: #ffffff; }
.nav-bar {
  display: flex; align-items: center; justify-content: space-between;
  padding: 12px 16px; background-color: #1e293b; border-bottom: 1px solid #334155;
}
.nav-back-btn, .nav-exit-btn { background: none; border: none; color: white; cursor: pointer; }
.nav-title { margin: 0; font-size: 16px; font-weight: 800; }
.content-scroll { padding: 20px 16px; display: flex; flex-direction: column; gap: 16px; }

.cinema-e-ticket {
  background: #ffffff;
  color: #0f172a;
  border-radius: 20px;
  overflow: hidden;
  box-shadow: 0 10px 30px rgba(0,0,0,0.5);
}

.ticket-top {
  background: #f59e0b;
  padding: 18px;
  color: #000000;
}
.hall-badge { font-size: 10px; font-weight: 800; background: rgba(0,0,0,0.15); padding: 3px 6px; border-radius: 4px; }
.t-movie-title { font-size: 18px; font-weight: 900; margin: 6px 0 4px 0; }
.t-meta { display: flex; gap: 8px; font-size: 11px; font-weight: 700; }

.ticket-perforation {
  height: 20px; background: #ffffff; position: relative;
  display: flex; align-items: center; justify-content: center;
}
.hole { position: absolute; width: 20px; height: 20px; border-radius: 50%; background: #0f172a; }
.hole.left { left: -10px; }
.hole.right { right: -10px; }
.dash-line { width: 85%; border-top: 2px dashed #cbd5e1; }

.ticket-bottom { padding: 16px; text-align: center; }
.seats-callout { font-size: 14px; font-weight: 800; margin-bottom: 12px; }
.seat-val { color: #d97706; font-size: 16px; margin-left: 4px; }

.qr-box { display: flex; flex-direction: column; align-items: center; gap: 6px; }
.booking-code { font-family: monospace; font-size: 12px; font-weight: 800; color: #64748b; }

.ticket-actions { display: flex; flex-direction: column; gap: 8px; }
.btn-wallet {
  background: #1e293b; color: white; border: 1px solid #334155;
  padding: 12px; border-radius: 12px; font-weight: 700; cursor: pointer;
}
.btn-home {
  background: #f59e0b; color: #000000; border: none;
  padding: 12px; border-radius: 12px; font-weight: 800; cursor: pointer;
}
</style>
