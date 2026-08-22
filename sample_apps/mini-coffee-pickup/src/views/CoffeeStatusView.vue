<template>
  <div class="status-view">
    <div class="nav-bar">
      <button class="nav-back-btn" @click="$router.push('/')">
        <svg viewBox="0 0 24 24" width="22" height="22" stroke="currentColor" stroke-width="2.5" fill="none">
          <line x1="19" y1="12" x2="5" y2="12"></line>
          <polyline points="12 19 5 12 12 5"></polyline>
        </svg>
      </button>
      <h2 class="nav-title">{{ t.orderStatus }}</h2>
      <button class="nav-exit-btn" @click="$router.push('/')">✕</button>
    </div>

    <div class="content-scroll" v-if="order">
      <div class="status-card">
        <span class="tok-label">{{ t.orderCode }}</span>
        <h2 class="tok-num">{{ order.orderNumber }}</h2>
        <span class="est-p">⏳ {{ order.pickupTime }}</span>

        <!-- Barista Stepper Tracker -->
        <div class="barista-steps">
          <div class="b-step done">
            <span class="b-icon">✓</span>
            <span class="b-lbl">Received</span>
          </div>
          <div class="b-line active"></div>
          <div class="b-step active">
            <span class="b-icon">⚙️</span>
            <span class="b-lbl">Grinding</span>
          </div>
          <div class="b-line active"></div>
          <div class="b-step active">
            <span class="b-icon">☕</span>
            <span class="b-lbl">Brewing</span>
          </div>
          <div class="b-line"></div>
          <div class="b-step">
            <span class="b-icon">🎁</span>
            <span class="b-lbl">Ready</span>
          </div>
        </div>
      </div>

      <!-- Items List -->
      <div class="items-card">
        <h4>Ordered Drinks</h4>
        <div class="items-list">
          <div v-for="(it, idx) in order.items" :key="idx" class="it-row">
            <span>{{ it.quantity }}x {{ it.item.name.en }} ({{ it.customization.cupSize }})</span>
            <span>${{ (it.unitPrice * it.quantity).toFixed(2) }}</span>
          </div>
        </div>
        <div class="it-tot">
          <span>Total Paid</span>
          <span class="val">${{ order.total.toFixed(2) }}</span>
        </div>
      </div>

      <!-- Pickup QR Pass -->
      <div class="pickup-qr-card">
        <p class="qr-hint">Present at barista pickup station when your token is called</p>
        <PPQRCode :value="order.qrValue" :size="130" foreground="#291b12" background="#ffffff" />
      </div>

      <PPButton variant="primary" block size="large" @click="$router.push('/')">
        + Order Another Drink
      </PPButton>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import { PPQRCode, PPButton } from '@phanna/ui-framework'
import { useCoffeeStore } from '../store/coffeeStore'
import { useI18n } from '../i18n'
import type { CoffeeOrderRecord } from '../types/coffee'

const route = useRoute()
const store = useCoffeeStore()
const { t } = useI18n()
const order = ref<CoffeeOrderRecord | null>(null)

onMounted(() => {
  const id = route.params.id as string
  if (id) order.value = store.state.orders.find(o => o.id === id) || null
  if (!order.value) order.value = store.state.currentOrder || store.state.orders[0] || null
})
</script>

<style scoped>
.status-view { min-height: 100vh; background-color: #fbf7f2; color: #291b12; }
.nav-bar {
  display: flex; align-items: center; justify-content: space-between;
  padding: 12px 16px; background: #ffffff; border-bottom: 1px solid #ebdcd0;
}
.nav-back-btn, .nav-exit-btn { background: none; border: none; cursor: pointer; color: #291b12; }
.nav-title { margin: 0; font-size: 16px; font-weight: 800; }
.content-scroll { padding: 16px; display: flex; flex-direction: column; gap: 14px; }

.status-card {
  background: #ffffff; border-radius: 20px; padding: 20px 16px; text-align: center;
  border: 1px solid #ebdcd0; box-shadow: 0 10px 30px rgba(41,27,18,0.06);
}
.tok-label { font-size: 10px; font-weight: 800; color: #8c7362; text-transform: uppercase; }
.tok-num { font-size: 28px; font-weight: 900; color: #6f4e37; margin: 4px 0; }
.est-p { font-size: 12px; font-weight: 700; color: #8c7362; display: block; margin-bottom: 18px; }

.barista-steps { display: flex; align-items: center; justify-content: space-between; padding: 0 6px; }
.b-step { display: flex; flex-direction: column; align-items: center; gap: 4px; font-size: 10px; font-weight: 800; color: #8c7362; }
.b-step.done, .b-step.active { color: #6f4e37; }
.b-icon {
  width: 32px; height: 32px; border-radius: 50%; background: #fdfaf6; border: 1px solid #ebdcd0;
  display: flex; align-items: center; justify-content: center; font-size: 12px;
}
.b-step.done .b-icon { background: #6f4e37; color: white; border-color: #6f4e37; }
.b-step.active .b-icon { background: #ebdcd0; color: #6f4e37; border-color: #6f4e37; }
.b-line { flex: 1; height: 2px; background: #ebdcd0; margin: 0 4px 14px 4px; }
.b-line.active { background: #6f4e37; }

.items-card { background: #ffffff; border-radius: 16px; padding: 14px; border: 1px solid #ebdcd0; }
.items-card h4 { font-size: 13px; font-weight: 800; margin: 0 0 10px 0; }
.items-list { display: flex; flex-direction: column; gap: 6px; font-size: 12px; color: #64748b; }
.it-row { display: flex; justify-content: space-between; }
.it-tot { display: flex; justify-content: space-between; border-top: 1px solid #f8f1eb; margin-top: 8px; padding-top: 8px; font-size: 14px; font-weight: 900; color: #6f4e37; }

.pickup-qr-card {
  background: #ffffff; border-radius: 16px; padding: 16px; border: 1px solid #ebdcd0;
  text-align: center; display: flex; flex-direction: column; align-items: center; gap: 8px;
}
.qr-hint { font-size: 11px; color: #8c7362; margin: 0; }
</style>
