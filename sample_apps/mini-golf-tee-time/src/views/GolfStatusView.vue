<template>
  <div class="golf-pass-root" v-if="latest">
    <div class="status-top">
      <div class="golf-flag-disc">⛳</div>
      <h2>{{ t.paymentSuccess }}</h2>
      <span class="ref-no">{{ t.bookingCode }}: {{ latest.bookingCode }}</span>
    </div>

    <div class="clubhouse-pass-card">
      <div class="c-head">
        <span class="c-tag">AUGUSTA LINKS CHECK-IN PASS</span>
        <h3>{{ latest.courseName }}</h3>
      </div>

      <div class="pass-details-grid">
        <div class="pd-item">
          <span class="pd-lbl">TEE-TIME</span>
          <span class="pd-val">{{ latest.teeTime }}</span>
        </div>
        <div class="pd-item">
          <span class="pd-lbl">PLAYERS</span>
          <span class="pd-val">{{ latest.playersCount }} GOLFERS ({{ latest.holesCount }}H)</span>
        </div>
        <div class="pd-item" v-if="latest.caddie">
          <span class="pd-lbl">CADDIE</span>
          <span class="pd-val">{{ latest.caddie.name }}</span>
        </div>
        <div class="pd-item">
          <span class="pd-lbl">CART</span>
          <span class="pd-val">{{ latest.cartIncluded ? 'GPS Cart #14' : 'Walking' }}</span>
        </div>
      </div>

      <div class="club-qr-area">
        <PPQRCode :value="latest.bookingCode" :size="130" />
        <span class="qr-sub">Scan at starter shack to begin round</span>
      </div>
    </div>

    <div class="pass-actions">
      <PPButton variant="outline" block size="medium" @click="$router.push('/')">
        ← Back to Clubhouse
      </PPButton>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { useRouter } from 'vue-router'
import { PPQRCode, PPButton } from '@phanna/ui-framework'
import { useGolfStore } from '../store/golfStore'
import { useI18n } from '../i18n'

const router = useRouter()
const store = useGolfStore()
const { t } = useI18n()

const latest = computed(() => store.state.latestBooking || store.state.bookings[0])
</script>

<style scoped>
.golf-pass-root {
  min-height: 100vh;
  background: radial-gradient(circle at 50% 10%, #0d2818 0%, #05140c 100%);
  padding: 24px 16px;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 16px;
  color: #f8fafc;
}
.status-top { display: flex; flex-direction: column; align-items: center; text-align: center; }
.golf-flag-disc {
  width: 60px; height: 60px; border-radius: 50%; background: #d4af37; color: black;
  display: flex; align-items: center; justify-content: center; font-size: 26px; margin-bottom: 8px;
}
.status-top h2 { font-size: 16px; font-weight: 900; margin: 0; color: #ffffff; }
.ref-no { font-size: 10px; font-family: monospace; color: #a7f3d0; margin-top: 4px; }

.clubhouse-pass-card {
  background: #091d12; border-radius: 20px; padding: 18px; width: 100%; border: 1.5px solid #1c402b;
  display: flex; flex-direction: column; gap: 14px; box-shadow: 0 10px 30px rgba(0,0,0,0.5);
}
.c-head { display: flex; flex-direction: column; gap: 2px; border-bottom: 1px solid #1c402b; padding-bottom: 10px; }
.c-tag { font-size: 8px; font-weight: 900; letter-spacing: 1.5px; color: #d4af37; }
.c-head h3 { font-size: 14px; font-weight: 900; margin: 0; color: #ffffff; }

.pass-details-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 10px; }
.pd-item { display: flex; flex-direction: column; }
.pd-lbl { font-size: 8px; font-weight: 800; color: #6ee7b7; }
.pd-val { font-size: 11px; font-weight: 900; color: #f8fafc; }

.club-qr-area { display: flex; flex-direction: column; align-items: center; gap: 6px; background: white; padding: 12px; border-radius: 14px; }
.qr-sub { font-size: 9px; font-weight: 800; color: #05140c; }

.pass-actions { width: 100%; }
</style>
