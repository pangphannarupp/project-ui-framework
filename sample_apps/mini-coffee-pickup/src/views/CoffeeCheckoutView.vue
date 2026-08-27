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
      <!-- Order Items List -->
      <div class="section-card">
        <h4 class="sec-t">Coffee Drinks ({{ store.state.cart.length }})</h4>
        <div class="cart-items-list">
          <div v-for="(item, idx) in store.state.cart" :key="idx" class="cart-row">
            <div class="c-main">
              <span class="c-name">{{ item.item.name.en }}</span>
              <span class="c-spec">{{ item.customization.cupSize }} Cup • {{ item.customization.milkType }} • Sweetness: {{ item.customization.sweetness }}%</span>
            </div>
            <div class="c-right">
              <span class="c-p">${{ (item.unitPrice * item.quantity).toFixed(2) }}</span>
              <button class="btn-del" @click="store.removeCartItem(idx)">✕</button>
            </div>
          </div>
        </div>
      </div>

      <!-- Pickup Estimation -->
      <div class="section-card pickup-card">
        <span class="p-title">⏱️ Estimated Pickup Time</span>
        <span class="p-time">Ready in 6 to 8 minutes at Barista Counter</span>
      </div>

      <!-- Bill -->
      <div class="section-card">
        <div class="bill-row"><span>Subtotal</span><span>${{ store.subtotal.value.toFixed(2) }}</span></div>
        <div class="bill-row"><span>Tax (8%)</span><span>${{ store.tax.value.toFixed(2) }}</span></div>
        <div class="bill-divider"></div>
        <div class="bill-row total"><span>Total to Pay</span><span class="highlight-total">${{ store.grandTotal.value.toFixed(2) }}</span></div>
      </div>
    </div>

    <!-- Sticky Pay Bar -->
    <div class="bottom-action-bar">
      <PPButton 
        variant="primary" 
        block 
        :disabled="isPaying || store.state.cart.length === 0" 
        @click="handlePay"
        class="pay-btn"
      >
        <span v-if="!isPaying">{{ t.pay }} (${{ store.grandTotal.value.toFixed(2) }})</span>
        <span v-else>Sending Order to Barista...</span>
      </PPButton>
    </div>

    <!-- PPAlert -->
    <PPAlert
      v-model="showAlert"
      :title="alertTitle"
      :message="alertMessage"
      confirmText="Track Barista Brewing"
      @confirm="onAlertConfirm"
    />

    <!-- PPConfirm Exit -->
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
import { PPAlert, PPConfirm, PPButton } from '@phanna/ui-framework'
import { useCoffeeStore } from '../store/coffeeStore'
import { useI18n } from '../i18n'
import '@/lib/mini.app.lib.js'

const router = useRouter()
const MiniApp = (window as any).MiniApp
const store = useCoffeeStore()
const { t } = useI18n()

const isPaying = ref(false)
const showExitConfirm = ref(false)
const showAlert = ref(false)
const alertTitle = ref('')
const alertMessage = ref('')
const createdOrderId = ref('')

const handlePay = async () => {
  if (store.state.cart.length === 0) return
  isPaying.value = true

  const payload = {
    serviceType: MiniApp?.ServiceType?.KHQR_PURCHASE || 'KHQR_PURCHASE',
    prepayId: 'COFFEE_PREPAY_' + Date.now(),
    amount: store.grandTotal.value,
    currency: 'USD',
    partnerCode: 'NORDIC_COFFEE',
    appId: "0000000016",
    apiKey: "pk_live_0000000016_1",
    secretKey: "sk_live_561756573A6B4777907EDF6932131B93",
    merchantId: "0000000001",
    metadata: {
      itemsCount: store.state.cart.length
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
      alertMessage.value = `${t.value.paymentReceived} (${ord.orderNumber})`
      showAlert.value = true
    } else {
      throw new Error('Payment failed')
    }
  } catch (e: any) {
    alertTitle.value = 'Order Failed'
    alertMessage.value = e?.message || 'Could not complete coffee order'
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
.checkout-view { min-height: 100vh; background-color: #fbf7f2; color: #291b12; padding-bottom: 84px; }
.nav-bar {
  display: flex; align-items: center; justify-content: space-between;
  padding: 12px 16px; background: #ffffff; border-bottom: 1px solid #ebdcd0;
  position: sticky; top: 0; z-index: 50;
}
.nav-back-btn, .nav-exit-btn { background: none; border: none; font-size: 16px; cursor: pointer; color: #291b12; }
.nav-title { margin: 0; font-size: 16px; font-weight: 800; }
.content-scroll { padding: 14px 16px; display: flex; flex-direction: column; gap: 12px; }

.section-card { background: #ffffff; border-radius: 16px; padding: 16px; border: 1px solid #ebdcd0; }
.sec-t { font-size: 13px; font-weight: 800; margin: 0 0 10px 0; }
.cart-items-list { display: flex; flex-direction: column; gap: 10px; }
.cart-row { display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #f8f1eb; padding-bottom: 8px; }
.cart-row:last-child { border-bottom: none; }
.c-main { display: flex; flex-direction: column; }
.c-name { font-size: 13px; font-weight: 800; }
.c-spec { font-size: 11px; color: #8c7362; }
.c-right { display: flex; align-items: center; gap: 8px; }
.c-p { font-size: 14px; font-weight: 900; color: #6f4e37; }
.btn-del { background: #fee2e2; color: #ef4444; border: none; border-radius: 50%; width: 20px; height: 20px; font-size: 10px; cursor: pointer; }

.pickup-card { background: #fdfaf6; border-color: #d7c1b0; }
.p-title { font-size: 12px; font-weight: 800; color: #6f4e37; display: block; }
.p-time { font-size: 11px; color: #8c7362; }

.bill-row { display: flex; justify-content: space-between; font-size: 13px; color: #8c7362; margin-bottom: 4px; }
.bill-row.total { font-size: 15px; font-weight: 800; color: #291b12; margin-top: 6px; }
.highlight-total { color: #6f4e37; font-size: 18px; font-weight: 900; }
.bill-divider { height: 1px; background: #ebdcd0; margin: 6px 0; }

.bottom-action-bar {
  position: fixed; bottom: 0; left: 0; right: 0; background: #ffffff;
  padding: 12px 16px; border-top: 1px solid #ebdcd0; z-index: 90;
}
.pay-btn { background: #6f4e37 !important; border-color: #6f4e37 !important; color: white !important; }
</style>
