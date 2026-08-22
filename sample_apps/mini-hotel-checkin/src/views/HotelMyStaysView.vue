<template>
  <div class="my-hotel-view">
    <div class="nav-bar">
      <button class="nav-back-btn" @click="$router.push('/')">
        <svg viewBox="0 0 24 24" width="22" height="22" stroke="currentColor" stroke-width="2.5" fill="none">
          <line x1="19" y1="12" x2="5" y2="12"></line>
          <polyline points="12 19 5 12 12 5"></polyline>
        </svg>
      </button>
      <h2 class="nav-title">My Stays</h2>
      <button class="nav-exit-btn" @click="$router.push('/')">✕</button>
    </div>

    <div class="content-scroll">
      <div v-if="store.state.bookings.length > 0" class="bookings-list">
        <div v-for="b in store.state.bookings" :key="b.id" class="booking-card" @click="$router.push(`/confirmation/${b.id}`)">
          <div class="bc-top">
            <span class="b-room">{{ b.roomNumber }}</span>
            <span class="b-stat">CONFIRMED</span>
          </div>
          <span class="b-suite">{{ b.suite.name.en }}</span>
          <div class="bc-foot">
            <span>{{ b.checkInDate }} ({{ b.nights }}N)</span>
            <span class="b-paid">${{ b.totalPaid.toFixed(2) }}</span>
          </div>
        </div>
      </div>
      <div v-else class="empty-state">
        <p>No active reservations found.</p>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { useHotelStore } from '../store/hotelStore'
const store = useHotelStore()
</script>

<style scoped>
.my-hotel-view { min-height: 100vh; background-color: #0b132b; color: #ffffff; }
.nav-bar {
  display: flex; align-items: center; justify-content: space-between;
  padding: 12px 16px; background: #1c2541; border-bottom: 1px solid #3a506b;
}
.nav-back-btn, .nav-exit-btn { background: none; border: none; color: white; cursor: pointer; }
.nav-title { margin: 0; font-size: 16px; font-weight: 800; }
.content-scroll { padding: 16px; }

.bookings-list { display: flex; flex-direction: column; gap: 12px; }
.booking-card { background: #1c2541; border-radius: 14px; padding: 14px; border: 1px solid #3a506b; cursor: pointer; }
.bc-top { display: flex; justify-content: space-between; margin-bottom: 4px; }
.b-room { font-weight: 900; font-size: 14px; color: #d4af37; }
.b-stat { font-size: 10px; font-weight: 800; background: #0b132b; color: #d4af37; padding: 2px 6px; border-radius: 4px; }
.b-suite { font-size: 11px; color: #cbd5e1; margin-bottom: 8px; display: block; }
.bc-foot { display: flex; justify-content: space-between; font-size: 12px; color: #a1a1aa; border-top: 1px solid #3a506b; padding-top: 6px; }
.b-paid { font-weight: 900; color: #ffffff; }
.empty-state { text-align: center; padding: 40px; color: #a1a1aa; }
</style>
