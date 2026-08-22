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
      <div class="status-tracker-card">
        <span class="token-num">{{ order.orderCode }}</span>
        <span class="order-table">{{ order.orderType === 'DINE_IN' ? 'Table ' + order.tableNumber : 'Takeaway Pickup' }}</span>

        <!-- Step tracker using PPStepper / Status Indicators -->
        <div class="stepper-track">
          <div class="step-point done">
            <div class="dot">✓</div>
            <span>Received</span>
          </div>
          <div class="step-line active"></div>
          <div class="step-point active">
            <div class="dot">👨‍🍳</div>
            <span>Cooking</span>
          </div>
          <div class="step-line"></div>
          <div class="step-point">
            <div class="dot">🔔</div>
            <span>Ready</span>
          </div>
        </div>
      </div>

      <div class="order-details-card">
        <h4>Items in Order</h4>
        <div class="items-list">
          <div v-for="c in order.items" :key="c.item.id" class="order-row">
            <span>{{ c.quantity }}x {{ c.item.name.en }}</span>
            <span>${{ (c.unitPrice * c.quantity).toFixed(2) }}</span>
          </div>
        </div>
        <div class="total-bar">
          <span>Paid Total</span>
          <span class="paid-val">${{ order.total.toFixed(2) }}</span>
        </div>
      </div>

      <div class="qr-pickup-card">
        <p class="pickup-hint">Scan at kitchen counter when order is called</p>
        <PPQRCode :value="order.qrValue" :size="120" foreground="#0f172a" background="#ffffff" />
      </div>

      <button class="btn-new-order" @click="$router.push('/')">+ Order More Food</button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import { PPQRCode } from '@phanna/ui-framework'
import { useFoodStore } from '../store/foodStore'
import { useI18n } from '../i18n'
import type { FoodOrderRecord } from '../types/food'

const route = useRoute()
const store = useFoodStore()
const { t } = useI18n()
const order = ref<FoodOrderRecord | null>(null)

onMounted(() => {
  const id = route.params.id as string
  if (id) order.value = store.state.orders.find(o => o.id === id) || null
  if (!order.value) order.value = store.state.currentOrder || store.state.orders[0] || null
})
</script>

<style scoped>
.status-view { min-height: 100vh; background-color: #f8fafc; }
.nav-bar {
  display: flex; align-items: center; justify-content: space-between;
  padding: 12px 16px; background: #ffffff; border-bottom: 1px solid #edf2f7;
}
.nav-back-btn, .nav-exit-btn { background: none; border: none; cursor: pointer; }
.nav-title { margin: 0; font-size: 16px; font-weight: 800; }
.content-scroll { padding: 16px; display: flex; flex-direction: column; gap: 14px; }

.status-tracker-card {
  background: #ffffff; border-radius: 16px; padding: 20px 16px;
  text-align: center; border: 1px solid #e2e8f0;
}
.token-num { font-size: 24px; font-weight: 900; color: #f97316; display: block; }
.order-table { font-size: 12px; color: #64748b; font-weight: 700; display: block; margin-bottom: 18px; }

.stepper-track { display: flex; align-items: center; justify-content: space-between; padding: 0 10px; }
.step-point { display: flex; flex-direction: column; align-items: center; gap: 4px; font-size: 11px; font-weight: 700; color: #94a3b8; }
.step-point.done { color: #10b981; }
.step-point.active { color: #f97316; }

.dot {
  width: 32px; height: 32px; border-radius: 50%; background: #f1f5f9;
  display: flex; align-items: center; justify-content: center; font-size: 14px;
}
.step-point.done .dot { background: #dcfce7; color: #166534; }
.step-point.active .dot { background: #ffedd5; color: #ea580c; border: 2px solid #f97316; }

.step-line { flex: 1; height: 2px; background: #e2e8f0; margin: 0 6px 14px 6px; }
.step-line.active { background: #f97316; }

.order-details-card { background: #ffffff; border-radius: 16px; padding: 16px; border: 1px solid #e2e8f0; }
.order-details-card h4 { margin: 0 0 10px 0; font-size: 13px; font-weight: 800; }
.items-list { display: flex; flex-direction: column; gap: 6px; font-size: 13px; color: #334155; }
.order-row { display: flex; justify-content: space-between; }
.total-bar {
  display: flex; justify-content: space-between; border-top: 1px solid #f1f5f9;
  padding-top: 10px; margin-top: 10px; font-weight: 800; font-size: 14px;
}
.paid-val { color: #f97316; font-size: 16px; }

.qr-pickup-card {
  background: #ffffff; border-radius: 16px; padding: 16px; text-align: center;
  border: 1px solid #e2e8f0; display: flex; flex-direction: column; align-items: center; gap: 8px;
}
.pickup-hint { font-size: 11px; color: #64748b; margin: 0; }

.btn-new-order {
  background: #f97316; color: white; border: none; padding: 12px;
  border-radius: 12px; font-size: 14px; font-weight: 800; cursor: pointer;
}
</style>
