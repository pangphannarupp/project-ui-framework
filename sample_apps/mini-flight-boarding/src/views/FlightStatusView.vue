<template>
  <div class="flight-pass-root" v-if="latest">
    <!-- Holographic Perforated Boarding Pass Card -->
    <div class="boarding-pass-card">
      <div class="pass-top">
        <div class="airline-row">
          <span class="a-brand">SINGAPORE AIRLINES</span>
          <span class="a-class">FIRST CLASS SUITE</span>
        </div>

        <div class="route-big">
          <div class="city-col">
            <span class="c-iata">{{ latest.flight.originCode }}</span>
            <span class="c-sub">SINGAPORE</span>
          </div>
          <span class="flight-plane">✈️</span>
          <div class="city-col right">
            <span class="c-iata">{{ latest.flight.destCode }}</span>
            <span class="c-sub">LONDON HEATHROW</span>
          </div>
        </div>
      </div>

      <!-- Perforated Tear Line -->
      <div class="tear-notch-line">
        <span class="notch left"></span>
        <div class="dashed-border"></div>
        <span class="notch right"></span>
      </div>

      <div class="pass-stub">
        <div class="stub-grid">
          <div class="sg-item">
            <span class="sg-lbl">PASSENGER</span>
            <span class="sg-val">{{ latest.passengerName }}</span>
          </div>
          <div class="sg-item">
            <span class="sg-lbl">FLIGHT</span>
            <span class="sg-val">{{ latest.flight.flightNumber }}</span>
          </div>
          <div class="sg-item">
            <span class="sg-lbl">SEAT</span>
            <span class="sg-val gold-seat">{{ latest.seat.seatNumber }}</span>
          </div>
          <div class="sg-item">
            <span class="sg-lbl">GATE / GROUP</span>
            <span class="sg-val">{{ latest.flight.gate }} • GRP 1</span>
          </div>
        </div>

        <div class="pass-barcode-area">
          <PPQRCode :value="latest.boardingBarcode" :size="130" />
          <span class="bc-ref">{{ latest.eticketNumber }}</span>
        </div>
      </div>
    </div>

    <div class="pass-actions">
      <PPButton variant="outline" block size="medium" @click="$router.push('/')">
        ← Back to Flight
      </PPButton>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { useRouter } from 'vue-router'
import { PPQRCode, PPButton } from '@phanna/ui-framework'
import { useFlightStore } from '../store/flightStore'

const store = useFlightStore()

const latest = computed(() => store.state.latestPass || store.state.boardingPasses[0])
</script>

<style scoped>
.flight-pass-root {
  min-height: 100vh;
  background: radial-gradient(circle at 50% 10%, #101c3d 0%, #0b1329 100%);
  padding: 24px 16px;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 16px;
}
.boarding-pass-card {
  background: white; border-radius: 24px; overflow: hidden; width: 100%; max-width: 340px;
  color: #0b1329; box-shadow: 0 15px 35px rgba(0,0,0,0.5);
}
.pass-top { background: #101c3d; color: white; padding: 20px; display: flex; flex-direction: column; gap: 14px; }
.airline-row { display: flex; justify-content: space-between; font-size: 9px; font-weight: 900; }
.a-brand { color: #d4af37; letter-spacing: 1px; }
.a-class { background: #1e293b; padding: 2px 6px; border-radius: 4px; }

.route-big { display: flex; justify-content: space-between; align-items: center; }
.city-col { display: flex; flex-direction: column; }
.city-col.right { text-align: right; }
.c-iata { font-size: 28px; font-weight: 900; color: #d4af37; font-family: monospace; }
.c-sub { font-size: 8px; color: #94a3b8; font-weight: 800; }
.flight-plane { font-size: 20px; }

.tear-notch-line { position: relative; height: 20px; background: #101c3d; display: flex; align-items: center; }
.notch { position: absolute; width: 20px; height: 20px; border-radius: 50%; background: #0b1329; }
.notch.left { left: -10px; }
.notch.right { right: -10px; }
.dashed-border { width: 100%; border-bottom: 2px dashed #334155; }

.pass-stub { padding: 20px; display: flex; flex-direction: column; gap: 14px; background: #fdfdfd; }
.stub-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 10px; }
.sg-item { display: flex; flex-direction: column; }
.sg-lbl { font-size: 8px; font-weight: 800; color: #64748b; }
.sg-val { font-size: 12px; font-weight: 900; color: #0b1329; }
.gold-seat { color: #b45309; font-size: 16px; font-family: monospace; }

.pass-barcode-area { display: flex; flex-direction: column; align-items: center; gap: 6px; }
.bc-ref { font-size: 9px; font-family: monospace; color: #64748b; }

.pass-actions { width: 100%; max-width: 340px; }
</style>
