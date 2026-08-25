<template>
  <div class="fuel-pass-root" v-if="latest">
    <div class="status-top">
      <div class="fuel-nozzle-disc">⛽</div>
      <h2>{{ t.paymentSuccess }}</h2>
      <span class="ref-no">{{ t.receiptNo }}: {{ latest.receiptNumber }}</span>
    </div>

    <!-- Live Smart Fuel Receipt Card -->
    <div class="smart-receipt-card">
      <div class="rc-head">
        <span class="rc-tag">NITRO SMART FUEL RECEIPT</span>
        <h3>Pump #0{{ latest.pumpNumber }} Dispensed</h3>
      </div>

      <div class="rc-metrics-grid">
        <div class="rc-item">
          <span class="rc-lbl">FUEL GRADE</span>
          <span class="rc-val">{{ latest.fuelGrade.name }}</span>
        </div>
        <div class="rc-item">
          <span class="rc-lbl">VOLUME DISPENSED</span>
          <span class="rc-val amber-liters">{{ latest.volumeLiters }} LITERS</span>
        </div>
        <div class="rc-item">
          <span class="rc-lbl">PRICE / LITER</span>
          <span class="rc-val">${{ latest.fuelGrade.pricePerLiter.toFixed(2) }}</span>
        </div>
        <div class="rc-item">
          <span class="rc-lbl">TOTAL CHARGED</span>
          <span class="rc-val">${{ latest.totalAmount.toFixed(2) }}</span>
        </div>
      </div>

      <div class="rc-qr-area">
        <PPQRCode :value="latest.receiptNumber" :size="120" />
        <span class="qr-sub">Scan for tax invoice & loyalty stamps</span>
      </div>
    </div>

    <div class="pass-actions">
      <PPButton variant="outline" block size="medium" @click="$router.push('/')">
        ← Back to Station
      </PPButton>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { useRouter } from 'vue-router'
import { PPQRCode, PPButton } from '@phanna/ui-framework'
import { useFuelStore } from '../store/fuelStore'
import { useI18n } from '../i18n'

const router = useRouter()
const store = useFuelStore()
const { t } = useI18n()

const latest = computed(() => store.state.latestTransaction || store.state.transactions[0])
</script>

<style scoped>
.fuel-pass-root {
  min-height: 100vh;
  background: radial-gradient(circle at 50% 10%, #1c1917 0%, #0c0a09 100%);
  padding: 24px 16px;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 16px;
  color: #fafaf9;
}
.status-top { display: flex; flex-direction: column; align-items: center; text-align: center; }
.fuel-nozzle-disc {
  width: 60px; height: 60px; border-radius: 50%; background: #f59e0b; color: black;
  display: flex; align-items: center; justify-content: center; font-size: 26px; margin-bottom: 8px;
}
.status-top h2 { font-size: 16px; font-weight: 900; margin: 0; color: #ffffff; }
.ref-no { font-size: 10px; font-family: monospace; color: #a8a29e; margin-top: 4px; }

.smart-receipt-card {
  background: #1c1917; border-radius: 20px; padding: 18px; width: 100%; border: 1.5px solid #292524;
  display: flex; flex-direction: column; gap: 14px; box-shadow: 0 10px 30px rgba(0,0,0,0.5);
}
.rc-head { display: flex; flex-direction: column; gap: 2px; border-bottom: 1px solid #292524; padding-bottom: 10px; }
.rc-tag { font-size: 8px; font-weight: 900; letter-spacing: 1.5px; color: #f59e0b; }
.rc-head h3 { font-size: 14px; font-weight: 900; margin: 0; color: #ffffff; }

.rc-metrics-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 10px; }
.rc-item { display: flex; flex-direction: column; }
.rc-lbl { font-size: 8px; font-weight: 800; color: #a8a29e; }
.rc-val { font-size: 12px; font-weight: 900; color: #fafaf9; }
.amber-liters { color: #f59e0b; font-size: 14px; font-family: monospace; }

.rc-qr-area { display: flex; flex-direction: column; align-items: center; gap: 6px; background: white; padding: 12px; border-radius: 14px; }
.qr-sub { font-size: 9px; font-weight: 800; color: #0c0a09; }

.pass-actions { width: 100%; }
</style>
