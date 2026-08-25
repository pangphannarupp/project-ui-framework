<template>
  <div class="omakase-pass-root" v-if="latest">
    <div class="status-top">
      <div class="sake-cup-disc">🍶</div>
      <h2>{{ t.paymentSuccess }}</h2>
      <span class="ref-no">{{ t.code }}: {{ latest.invitationCode }}</span>
    </div>

    <!-- Formal Master Chef VIP Invitation Card -->
    <div class="chef-invitation-card">
      <div class="inv-head">
        <span class="inv-tag">MASTER CHEF VIP INVITATION</span>
        <h3>HINOKI OMAKASE TABLE</h3>
      </div>

      <div class="inv-grid">
        <div class="ig-item">
          <span class="ig-lbl">DATE & SEATING</span>
          <span class="ig-val">{{ latest.selectedDate }} • {{ latest.seatingTime }}</span>
        </div>
        <div class="ig-item">
          <span class="ig-lbl">COUNTER SEAT</span>
          <span class="ig-val gold-seat">SEAT 0{{ latest.seat.seatNumber }} ({{ latest.guestCount }} GUESTS)</span>
        </div>
        <div class="ig-item">
          <span class="ig-lbl">EXPERIENCE</span>
          <span class="ig-val">12-Course Seasonal Tasting</span>
        </div>
        <div class="ig-item">
          <span class="ig-lbl">SAKE PAIRING</span>
          <span class="ig-val">{{ latest.sakePairingIncluded ? 'Included (6 Sakes)' : 'None' }}</span>
        </div>
      </div>

      <div class="inv-qr-area">
        <PPQRCode :value="latest.invitationCode" :size="130" />
        <span class="qr-sub">Present to host upon arrival at counter</span>
      </div>
    </div>

    <div class="pass-actions">
      <PPButton variant="outline" block size="medium" @click="$router.push('/')">
        ← Back to Counter
      </PPButton>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { useRouter } from 'vue-router'
import { PPQRCode, PPButton } from '@phanna/ui-framework'
import { useOmakaseStore } from '../store/omakaseStore'
import { useI18n } from '../i18n'

const router = useRouter()
const store = useOmakaseStore()
const { t } = useI18n()

const latest = computed(() => store.state.latestBooking || store.state.bookings[0])
</script>

<style scoped>
.omakase-pass-root {
  min-height: 100vh;
  background: radial-gradient(circle at 50% 10%, #1c1917 0%, #141210 100%);
  padding: 24px 16px;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 16px;
  color: #f7f3ee;
}
.status-top { display: flex; flex-direction: column; align-items: center; text-align: center; }
.sake-cup-disc {
  width: 60px; height: 60px; border-radius: 50%; background: #c2a688; color: black;
  display: flex; align-items: center; justify-content: center; font-size: 26px; margin-bottom: 8px;
}
.status-top h2 { font-size: 16px; font-weight: 900; margin: 0; color: #ffffff; }
.ref-no { font-size: 10px; font-family: monospace; color: #a8a29e; margin-top: 4px; }

.chef-invitation-card {
  background: #1c1917; border-radius: 20px; padding: 18px; width: 100%; border: 1.5px solid #292524;
  display: flex; flex-direction: column; gap: 14px; box-shadow: 0 10px 30px rgba(0,0,0,0.5);
}
.inv-head { display: flex; flex-direction: column; gap: 2px; border-bottom: 1px solid #292524; padding-bottom: 10px; }
.inv-tag { font-size: 8px; font-weight: 900; letter-spacing: 1.5px; color: #c2a688; }
.inv-head h3 { font-size: 14px; font-weight: 900; margin: 0; color: #ffffff; }

.inv-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 10px; }
.ig-item { display: flex; flex-direction: column; }
.ig-lbl { font-size: 8px; font-weight: 800; color: #a8a29e; }
.ig-val { font-size: 11px; font-weight: 900; color: #f7f3ee; }
.gold-seat { color: #c2a688; }

.inv-qr-area { display: flex; flex-direction: column; align-items: center; gap: 6px; background: white; padding: 12px; border-radius: 14px; }
.qr-sub { font-size: 9px; font-weight: 800; color: #141210; }

.pass-actions { width: 100%; }
</style>
