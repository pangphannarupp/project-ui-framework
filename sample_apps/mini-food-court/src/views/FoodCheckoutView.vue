<template>
  <div class="checkout-view">
    <div class="nav-bar">
      <button class="nav-back-btn" @click="$router.back()">
        <svg viewBox="0 0 24 24" width="22" height="22" stroke="currentColor" stroke-width="2.5" fill="none">
          <line x1="19" y1="12" x2="5" y2="12"></line>
          <polyline points="12 19 5 12 12 5"></polyline>
        </svg>
      </button>
      <h2 class="nav-title">{{ t.checkoutTitle }}</h2>
      <button class="nav-exit-btn" @click="showExitConfirm = true">✕</button>
    </div>

    <div class="content-scroll">
      <!-- Order Mode Header -->
      <div class="mode-header-card">
        <div class="mode-info">
          <span class="m-tag">{{ store.state.orderType === 'DINE_IN' ? '🍽️ Dine-In Order' : '🛍️ Takeaway Pick-up' }}</span>
          <span class="m-table" v-if="store.state.orderType === 'DINE_IN'">Table No: {{ store.state.tableNumber }}</span>
        </div>
      </div>

      <!-- Items List -->
      <div class="section-card">
        <div class="section-header">
          <h3 class="section-title">{{ t.orderSummary }} ({{ store.totalCount.value }})</h3>
          <button class="clear-btn" @click="store.clearCart" v-if="store.totalCount.value > 0">Clear</button>
        </div>

        <div class="cart-list" v-if="store.totalCount.value > 0">
          <div class="cart-item" v-for="c in store.state.cart" :key="c.item.id">
            <img :src="c.item.imageUrl" :alt="getFoodName(c.item)" class="item-img" />
            <div class="item-details">
              <span class="item-name">{{ getFoodName(c.item) }}</span>
              <span class="item-price">${{ c.unitPrice.toFixed(2) }}</span>
            </div>
            <div class="qty-controller">
              <button class="qty-btn" @click="store.removeFromCart(c.item.id)">−</button>
              <span class="qty-num">{{ c.quantity }}</span>
              <button class="qty-btn" @click="store.addToCart(c.item)">+</button>
            </div>
          </div>
        </div>
      </div>

      <!-- Bill -->
      <div class="section-card" v-if="store.totalCount.value > 0">
        <div class="bill-row"><span>{{ t.subtotal }}</span><span>${{ store.subtotal.value.toFixed(2) }}</span></div>
        <div class="bill-row"><span>{{ t.vatTax }}</span><span>${{ store.tax.value.toFixed(2) }}</span></div>
        <div class="bill-divider"></div>
        <div class="bill-row total"><span>{{ t.grandTotal }}</span><span class="highlight-total">${{ store.grandTotal.value.toFixed(2) }}</span></div>
      </div>
    </div>

    <!-- Sticky Pay Button -->
    <div class="bottom-action-bar" v-if="store.totalCount.value > 0">
      <button class="pay-btn" :disabled="isPaying" @click="handlePay">
        <span v-if="!isPaying">{{ t.pay }} ${{ store.grandTotal.value.toFixed(2) }}</span>
        <span v-else>Placing Order...</span>
      </button>
    </div>

    <!-- PPAlert -->
    <PPAlert
      v-model="showAlert"
      :title="alertTitle"
      :message="alertMessage"
      confirmText="Track Live Order"
      @confirm="onAlertConfirm"
    />

    <!-- PPConfirm -->
    <PPConfirm
      v-model="showExitConfirm"
      :title="t.exitTitle"
      :message="t.exitMessage"
      :confirmText="t.yesExit"
      :cancelText="t.stay"
      @confirm="confirmExit"
    />
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { PPAlert, PPConfirm } from '@phanna/ui-framework'
import { useFoodStore } from '../store/foodStore'
import { useI18n } from '../i18n'
import type { FoodItem } from '../types/food'
import '@/lib/mini.app.lib.js'

const router = useRouter()
const MiniApp = (window as any).MiniApp
const store = useFoodStore()
const { t, currentLanguage } = useI18n()

const isPaying = ref(false)
const showExitConfirm = ref(false)
const showAlert = ref(false)
const alertTitle = ref('')
const alertMessage = ref('')
const createdOrderId = ref('')

const getFoodName = (f: FoodItem) => f.name[currentLanguage.value] || f.name.en

const handlePay = async () => {
  if (store.totalCount.value === 0) return
  isPaying.value = true

  const payload = {
    serviceType: MiniApp?.ServiceType?.KHQR_PURCHASE || 'KHQR_PURCHASE',
    prepayId: 'FOOD_PREPAY_' + Date.now(),
    amount: store.grandTotal.value,
    currency: 'USD',
    partnerCode: 'SMART_FOOD_COURT',
    metadata: {
      orderType: store.state.orderType,
      table: store.state.tableNumber
    }
  }

  try {
    let res: any
    if (MiniApp && typeof MiniApp.requestPayment === 'function') {
      res = await MiniApp.requestPayment(payload)
    } else {
      await new Promise(r => setTimeout(r, 600))
      res = { status: 'SUCCESS' }
    }

    if (res?.status === 'SUCCESS' || res?.success) {
      const ord = store.createOrder()
      createdOrderId.value = ord.id
      alertTitle.value = t.value.paymentSuccessTitle
      alertMessage.value = `${t.value.paymentReceived} (${ord.orderCode})`
      showAlert.value = true
    } else {
      throw new Error('Payment failed')
    }
  } catch (e: any) {
    alertTitle.value = 'Payment Failed'
    alertMessage.value = e?.message || 'Could not complete order'
    showAlert.value = true
  } finally {
    isPaying.value = false
  }
}

const onAlertConfirm = () => {
  router.push(`/confirmation/${createdOrderId.value}`)
}

const confirmExit = () => {
  if (MiniApp?.exit) MiniApp.exit(false)
  else window.history.back()
}
</script>

<style scoped>
.checkout-view { min-height: 100vh; background-color: #f8fafc; padding-bottom: 84px; }
.nav-bar {
  display: flex; align-items: center; justify-content: space-between;
  padding: 12px 16px; background: #ffffff; border-bottom: 1px solid #edf2f7;
  position: sticky; top: 0; z-index: 50;
}
.nav-back-btn, .nav-exit-btn { background: none; border: none; font-size: 16px; cursor: pointer; }
.nav-title { margin: 0; font-size: 16px; font-weight: 800; }
.content-scroll { padding: 14px 16px; display: flex; flex-direction: column; gap: 12px; }

.mode-header-card {
  background: #fff7ed; border: 1px solid #ffedd5; border-radius: 12px; padding: 12px;
}
.mode-info { display: flex; justify-content: space-between; align-items: center; font-weight: 800; font-size: 13px; color: #ea580c; }

.section-card { background: #ffffff; border-radius: 16px; padding: 16px; border: 1px solid #e2e8f0; }
.section-header { display: flex; justify-content: space-between; margin-bottom: 10px; }
.section-title { font-size: 14px; font-weight: 800; margin: 0; }
.clear-btn { background: none; border: none; color: #ef4444; font-size: 12px; font-weight: 700; cursor: pointer; }

.cart-list { display: flex; flex-direction: column; gap: 10px; }
.cart-item { display: flex; align-items: center; gap: 10px; padding-bottom: 8px; border-bottom: 1px solid #f1f5f9; }
.item-img { width: 44px; height: 44px; border-radius: 8px; object-fit: cover; }
.item-details { flex: 1; display: flex; flex-direction: column; }
.item-name { font-size: 13px; font-weight: 700; }
.item-price { font-size: 12px; font-weight: 800; color: #f97316; }

.qty-controller { display: flex; align-items: center; background: #f1f5f9; border-radius: 8px; padding: 2px; }
.qty-btn { background: #ffffff; border: 1px solid #cbd5e1; border-radius: 6px; width: 24px; height: 24px; font-weight: 800; cursor: pointer; }
.qty-num { font-size: 12px; font-weight: 800; min-width: 20px; text-align: center; }

.bill-row { display: flex; justify-content: space-between; font-size: 13px; color: #64748b; margin-bottom: 4px; }
.bill-row.total { font-size: 15px; font-weight: 800; color: #0f172a; margin-top: 6px; }
.highlight-total { color: #f97316; font-size: 17px; font-weight: 900; }
.bill-divider { height: 1px; background: #e2e8f0; margin: 6px 0; }

.bottom-action-bar {
  position: fixed; bottom: 0; left: 0; right: 0; background: #ffffff;
  padding: 12px 16px; border-top: 1px solid #e2e8f0; z-index: 90;
}
.pay-btn {
  width: 100%; background: linear-gradient(135deg, #f97316 0%, #ea580c 100%);
  color: white; border: none; padding: 12px; border-radius: 12px; font-size: 15px; font-weight: 800; cursor: pointer;
}
</style>
