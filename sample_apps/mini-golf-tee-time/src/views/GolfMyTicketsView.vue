<template>
  <div class="golf-tickets-root">
    <header class="t-header">
      <button class="back-btn" @click="$router.push('/')">←</button>
      <h2>{{ t.myPasses }}</h2>
      <div style="width: 32px"></div>
    </header>

    <main class="t-body">
      <div v-if="store.state.bookings.length === 0" class="no-tickets-box">
        <span class="empty-emoji">🏌️</span>
        <p>{{ t.noPasses }}</p>
        <PPButton variant="primary" size="medium" @click="$router.push('/')">
          {{ t.bookFirst }}
        </PPButton>
      </div>

      <div v-else class="bookings-column">
        <div 
          v-for="b in store.state.bookings" 
          :key="b.id"
          class="golf-booking-card"
        >
          <div class="gb-head">
            <span class="gb-code">{{ b.bookingCode }}</span>
            <span class="gb-status">{{ b.status }}</span>
          </div>
          <div class="gb-info">
            <h4>{{ b.courseName }}</h4>
            <span>{{ b.selectedDate }} • {{ b.teeTime }}</span>
          </div>
          <div class="gb-foot">
            <span class="gb-price">${{ b.totalFee.toFixed(2) }}</span>
            <PPButton variant="primary" size="small" @click="store.state.latestBooking = b; $router.push('/status')">
              Show Pass ⛳
            </PPButton>
          </div>
        </div>
      </div>
    </main>
  </div>
</template>

<script setup lang="ts">
import { useRouter } from 'vue-router'
import { PPButton } from '@phanna/ui-framework'
import { useGolfStore } from '../store/golfStore'
import { useI18n } from '../i18n'

const store = useGolfStore()
const { t } = useI18n()
</script>

<style scoped>
.golf-tickets-root { min-height: 100vh; background: #05140c; color: #f8fafc; }
.t-header {
  display: flex; justify-content: space-between; align-items: center; padding: 16px;
  background: #091d12; border-bottom: 1px solid #1c402b;
}
.back-btn { background: none; border: none; font-size: 20px; color: #f8fafc; cursor: pointer; }
.t-header h2 { font-size: 15px; font-weight: 900; margin: 0; }

.t-body { padding: 16px; }
.no-tickets-box { display: flex; flex-direction: column; align-items: center; gap: 10px; margin-top: 40px; }
.empty-emoji { font-size: 40px; }

.bookings-column { display: flex; flex-direction: column; gap: 12px; }
.golf-booking-card {
  background: #091d12; border-radius: 16px; padding: 14px; border: 1px solid #1c402b;
  display: flex; flex-direction: column; gap: 8px;
}
.gb-head { display: flex; justify-content: space-between; font-size: 10px; font-weight: 800; }
.gb-code { font-family: monospace; color: #d4af37; }
.gb-status { color: #22c55e; background: #133320; padding: 2px 6px; border-radius: 4px; }
.gb-info h4 { font-size: 13px; font-weight: 900; margin: 0; color: #ffffff; }
.gb-info span { font-size: 10px; color: #a7f3d0; }
.gb-foot { display: flex; justify-content: space-between; align-items: center; border-top: 1px solid #1c402b; padding-top: 8px; }
.gb-price { font-size: 14px; font-weight: 900; color: #d4af37; }
</style>
