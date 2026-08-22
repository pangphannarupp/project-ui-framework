<template>
  <div class="spa-pass-root" v-if="latest">
    <div class="status-top">
      <div class="zen-lotus-disc">🪷</div>
      <h2>{{ t.paymentSuccess }}</h2>
      <span class="ref-no">{{ t.passCode }}: {{ latest.sanctuaryPassCode }}</span>
    </div>

    <!-- Digital Sanctuary Key & Locker Pass -->
    <div class="sanctuary-pass-card">
      <div class="sp-head">
        <span class="sp-tag">LOTUS SANCTUARY ACCESS PASS</span>
        <h3>{{ latest.ritual.name[currentLanguage] || latest.ritual.name.en }}</h3>
      </div>

      <div class="sp-metrics-grid">
        <div class="sp-item">
          <span class="sp-lbl">APPOINTMENT</span>
          <span class="sp-val">{{ latest.selectedDate }} • {{ latest.selectedTime }}</span>
        </div>
        <div class="sp-item">
          <span class="sp-lbl">ASSIGNED LOCKER</span>
          <span class="sp-val rose-locker">LOCKER #{{ latest.lockerNumber }} (ROBE {{ latest.robeSize }})</span>
        </div>
        <div class="sp-item">
          <span class="sp-lbl">AROMA BLEND</span>
          <span class="sp-val">{{ latest.oilChoice.split('&')[0] }}</span>
        </div>
        <div class="sp-item">
          <span class="sp-lbl">TEA SERVICE</span>
          <span class="sp-val">Organic Jasmine Green</span>
        </div>
      </div>

      <div class="sp-qr-area">
        <PPQRCode :value="latest.sanctuaryPassCode" :size="130" />
        <span class="qr-sub">Scan at sanctuary turnstile for locker unlock</span>
      </div>
    </div>

    <div class="pass-actions">
      <PPButton variant="outline" block size="medium" @click="$router.push('/')">
        ← Back to Sanctuary
      </PPButton>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { useRouter } from 'vue-router'
import { PPQRCode, PPButton } from '@phanna/ui-framework'
import { useSpaStore } from '../store/spaStore'
import { useI18n } from '../i18n'

const store = useSpaStore()
const { t, currentLanguage } = useI18n()

const latest = computed(() => store.state.latestReservation || store.state.reservations[0])
</script>

<style scoped>
.spa-pass-root {
  min-height: 100vh;
  background: radial-gradient(circle at 50% 10%, #292524 0%, #1c1917 100%);
  padding: 24px 16px;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 16px;
  color: #fafaf9;
}
.status-top { display: flex; flex-direction: column; align-items: center; text-align: center; }
.zen-lotus-disc {
  width: 60px; height: 60px; border-radius: 50%; background: #f43f5e; color: white;
  display: flex; align-items: center; justify-content: center; font-size: 26px; margin-bottom: 8px;
}
.status-top h2 { font-size: 16px; font-weight: 900; margin: 0; color: #ffffff; }
.ref-no { font-size: 10px; font-family: monospace; color: #a8a29e; margin-top: 4px; }

.sanctuary-pass-card {
  background: #292524; border-radius: 20px; padding: 18px; width: 100%; border: 1.5px solid #44403c;
  display: flex; flex-direction: column; gap: 14px; box-shadow: 0 10px 30px rgba(0,0,0,0.5);
}
.sp-head { display: flex; flex-direction: column; gap: 2px; border-bottom: 1px solid #44403c; padding-bottom: 10px; }
.sp-tag { font-size: 8px; font-weight: 900; letter-spacing: 1.5px; color: #f43f5e; }
.sp-head h3 { font-size: 14px; font-weight: 900; margin: 0; color: #ffffff; }

.sp-metrics-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 10px; }
.sp-item { display: flex; flex-direction: column; }
.sp-lbl { font-size: 8px; font-weight: 800; color: #a8a29e; }
.sp-val { font-size: 11px; font-weight: 900; color: #fafaf9; }
.rose-locker { color: #f43f5e; }

.sp-qr-area { display: flex; flex-direction: column; align-items: center; gap: 6px; background: white; padding: 12px; border-radius: 14px; }
.qr-sub { font-size: 9px; font-weight: 800; color: #1c1917; }

.pass-actions { width: 100%; }
</style>
