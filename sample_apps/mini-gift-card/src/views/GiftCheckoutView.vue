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
      <!-- Gift Summary -->
      <div class="section-card gift-summary" :style="{ background: store.state.selectedTheme.gradient }">
        <span class="g-theme">{{ store.state.selectedTheme.title }}</span>
        <h2 class="g-val">${{ store.state.selectedAmount }}</h2>
        <span class="g-to">To: {{ store.state.recipientName }}</span>
      </div>

      <!-- Bill -->
      <div class="section-card">
        <h4 class="sec-title">Order Total</h4>
        <div class="bill-row"><span>Gift Value</span><span>${{ store.state.selectedAmount.toFixed(2) }}</span></div>
        <div class="bill-row"><span>Card Generation & Delivery</span><span>$0.00 (Free)</span></div>
        <div class="bill-divider"></div>
        <div class="bill-row total"><span>Total to Pay</span><span class="highlight-total">${{ store.state.selectedAmount.toFixed(2) }}</span></div>
      </div>
    </div>

    <!-- Sticky Pay Bar -->
    <div class="bottom-action-bar">
      <PPButton 
        variant="primary" 
        block 
        :disabled="isPaying" 
        @click="handlePay"
        class="pay-btn"
      >
        <span v-if="!isPaying">{{ t.pay }} (${{ store.state.selectedAmount.toFixed(2) }})</span>
        <span v-else>Delivering Gift Voucher...</span>
      </PPButton>
    </div>

    <!-- PPAlert -->
    <PPAlert
      v-model="showAlert"
      :title="alertTitle"
      :message="alertMessage"
      confirmText="Open Gift Voucher"
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
import { useGiftStore } from '../store/giftStore'
import { useI18n } from '../i18n'
import '@/lib/mini.app.lib.js'

const MiniApp = (window as any).MiniApp
const store = useGiftStore()
const { t } = useI18n()

const isPaying = ref(false)
const showExitConfirm = ref(false)
const showAlert = ref(false)
const alertTitle = ref('')
const alertMessage = ref('')
const createdOrderId = ref('')

const handlePay = async () => {
  isPaying.value = true

  const payload = {
    serviceType: MiniApp?.ServiceType?.KHQR_PURCHASE || 'KHQR_PURCHASE',
    prepayId: 'GIFT_PREPAY_' + Date.now(),
    amount: store.state.selectedAmount,
    currency: 'USD',
    partnerCode: 'DIGITAL_GIFT_CARDS',
    metadata: {
      recipient: store.state.recipientName,
      amount: store.state.selectedAmount
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
      const g = store.purchaseGiftCard()
      createdOrderId.value = g.id
      alertTitle.value = t.value.paymentSuccessTitle
      alertMessage.value = `${t.value.paymentReceived} (${g.voucherCode})`
      showAlert.value = true
    } else {
      throw new Error('Payment failed')
    }
  } catch (e: any) {
    alertTitle.value = 'Purchase Failed'
    alertMessage.value = e?.message || 'Could not process gift card order'
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
.checkout-view { min-height: 100vh; background-color: #fff1f2; color: #881337; padding-bottom: 84px; }
.nav-bar {
  display: flex; align-items: center; justify-content: space-between;
  padding: 12px 16px; background: #ffffff; border-bottom: 1px solid #fecdd3;
  position: sticky; top: 0; z-index: 50;
}
.nav-back-btn, .nav-exit-btn { background: none; border: none; font-size: 16px; cursor: pointer; color: #881337; }
.nav-title { margin: 0; font-size: 16px; font-weight: 800; }
.content-scroll { padding: 14px 16px; display: flex; flex-direction: column; gap: 12px; }

.section-card { background: #ffffff; border-radius: 16px; padding: 16px; border: 1px solid #fecdd3; }
.gift-summary { text-align: center; color: white; border: none; }
.g-theme { font-size: 11px; font-weight: 800; opacity: 0.9; text-transform: uppercase; }
.g-val { font-size: 32px; font-weight: 900; margin: 4px 0; }
.g-to { font-size: 12px; opacity: 0.95; }

.sec-title { font-size: 13px; font-weight: 800; margin: 0 0 10px 0; }
.bill-row { display: flex; justify-content: space-between; font-size: 13px; color: #9f1239; margin-bottom: 4px; }
.bill-row.total { font-size: 15px; font-weight: 800; color: #881337; margin-top: 6px; }
.highlight-total { color: #e11d48; font-size: 18px; font-weight: 900; }
.bill-divider { height: 1px; background: #fecdd3; margin: 6px 0; }

.bottom-action-bar {
  position: fixed; bottom: 0; left: 0; right: 0; background: #ffffff;
  padding: 12px 16px; border-top: 1px solid #fecdd3; z-index: 90;
}
.pay-btn { background: #e11d48 !important; border-color: #e11d48 !important; color: white !important; font-weight: 900 !important; }
</style>
