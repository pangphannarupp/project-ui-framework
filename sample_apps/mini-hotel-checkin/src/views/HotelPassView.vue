<template>
  <div class="pass-view">
    <div class="nav-bar">
      <button class="nav-back-btn" @click="$router.push('/')">
        <svg viewBox="0 0 24 24" width="22" height="22" stroke="currentColor" stroke-width="2.5" fill="none">
          <line x1="19" y1="12" x2="5" y2="12"></line>
          <polyline points="12 19 5 12 12 5"></polyline>
        </svg>
      </button>
      <h2 class="nav-title">Digital Key & Access</h2>
      <button class="nav-exit-btn" @click="$router.push('/')">✕</button>
    </div>

    <div class="content-scroll" v-if="booking">
      <div class="hotel-key-card">
        <div class="hk-top">
          <span class="hk-badge">★ MOBILE KEY ACTIVE</span>
          <h2 class="hk-room">{{ booking.roomNumber }}</h2>
          <span class="hk-suite">{{ booking.suite.name.en }}</span>
        </div>

        <div class="hk-body">
          <div class="nfc-icon-ring">
            <span>📲</span>
          </div>
          <p class="hk-hint">Hold phone near door reader to unlock suite or scan QR pass below</p>
          <PPQRCode :value="booking.digitalKeyQr" :size="130" foreground="#0b132b" background="#ffffff" />
          <span class="hk-res">{{ booking.reservationNumber }}</span>
        </div>

        <div class="hk-foot">
          <span>Check-in: {{ booking.checkInDate }} • Check-out: {{ booking.checkOutDate }}</span>
        </div>
      </div>

      <PPButton variant="primary" block size="large" @click="$router.push('/')">
        Back to Hotel Overview
      </PPButton>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import { PPQRCode, PPButton } from '@phanna/ui-framework'
import { useHotelStore } from '../store/hotelStore'
import type { HotelBookingRecord } from '../types/hotel'

const route = useRoute()
const store = useHotelStore()
const booking = ref<HotelBookingRecord | null>(null)

onMounted(() => {
  const id = route.params.id as string
  if (id) booking.value = store.state.bookings.find(b => b.id === id) || null
  if (!booking.value) booking.value = store.state.currentBooking || store.state.bookings[0] || null
})
</script>

<style scoped>
.pass-view { min-height: 100vh; background-color: #0b132b; color: #ffffff; }
.nav-bar {
  display: flex; align-items: center; justify-content: space-between;
  padding: 12px 16px; background: #1c2541; border-bottom: 1px solid #3a506b;
}
.nav-back-btn, .nav-exit-btn { background: none; border: none; cursor: pointer; color: white; }
.nav-title { margin: 0; font-size: 16px; font-weight: 800; }
.content-scroll { padding: 20px 16px; display: flex; flex-direction: column; gap: 16px; }

.hotel-key-card {
  background: #1c2541; border-radius: 20px; overflow: hidden;
  border: 1.5px solid #d4af37; box-shadow: 0 10px 30px rgba(212,175,55,0.15); text-align: center;
}

.hk-top { background: #d4af37; color: black; padding: 20px; }
.hk-badge { font-size: 9px; font-weight: 900; background: rgba(0,0,0,0.15); padding: 3px 8px; border-radius: 4px; }
.hk-room { font-size: 26px; font-weight: 900; margin: 6px 0 2px 0; }
.hk-suite { font-size: 11px; font-weight: 800; }

.hk-body { padding: 20px 16px; display: flex; flex-direction: column; align-items: center; gap: 8px; background: #ffffff; }
.nfc-icon-ring {
  width: 50px; height: 50px; border-radius: 50%; background: #0b132b;
  display: flex; align-items: center; justify-content: center; font-size: 22px; margin-bottom: 4px;
}
.hk-hint { font-size: 11px; color: #64748b; margin: 0; max-width: 240px; }
.hk-res { font-family: monospace; font-size: 12px; font-weight: 900; color: #0b132b; }

.hk-foot { background: #1c2541; padding: 12px; font-size: 11px; color: #a1a1aa; font-weight: 700; border-top: 1px solid #3a506b; }
</style>
