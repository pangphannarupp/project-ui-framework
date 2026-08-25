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
      <!-- Wash Tier Summary -->
      <div class="section-card tier-summary">
        <span class="t-badge">{{ store.state.selectedTier.badge }}</span>
        <h3 class="t-name">{{ store.state.selectedTier.name.en }}</h3>
        <span class="t-car">Vehicle: {{ store.state.plateNumber }} ({{ store.state.vehicleModel }})</span>
      </div>

      <!-- Bill -->
      <div class="section-card">
        <h4 class="sec-title">Order Total</h4>
        <div class="bill-row"><span>Wash Program</span><span>${{ store.state.selectedTier.price.toFixed(2) }}</span></div>
        <div class="bill-row"><span>Touchless Drying Surcharge</span><span>$0.00 (Included)</span></div>
        <div class="bill-divider"></div>
        <div class="bill-row total"><span>Total to Pay</span><span class="highlight-total">${{ store.state.selectedTier.price.toFixed(2) }}</span></div>
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
        <span v-if="!isPaying">{{ t.pay }} (${{ store.state.selectedTier.price.toFixed(2) }})</span>
        <span v-else>Opening Conveyor Barrier...</span>
      </PPButton>
    </div>

    <!-- PPAlert -->
    <PPAlert
      v-model="showAlert"
      :title="alertTitle"
      :message="alertMessage"
      confirmText="Open Conveyor Ticket"
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
import { useWashStore } from '../store/washStore'
import { useI18n } from '../i18n'
import '@/lib/mini.app.lib.js'

const router = useRouter()
const MiniApp = (window as any).MiniApp
const store = useWashStore()
const { t } = useI18n()

const isPaying = ref(false)
const showExitConfirm = ref(false)
const showAlert = ref(false)
const alertTitle = ref('')
const alertMessage = ref('')
const createdRecordId = ref('')

const handlePay = async () => {
  isPaying.value = true

  const payload = {
    serviceType: MiniApp?.ServiceType?.KHQR_PURCHASE || 'KHQR_PURCHASE',
    prepayId: 'WASH_PREPAY_' + Date.now(),
    amount: store.state.selectedTier.price,
    currency: 'USD',
    partnerCode: 'ULTRA_GLOSS_CARWASH',
    metadata: {
      plate: store.state.plateNumber,
      tier: store.state.selectedTier.name.en
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
      const rec = store.startWashOrder()
      createdRecordId.value = rec.id
      alertTitle.value = t.value.paymentSuccessTitle
      alertMessage.value = `${t.value.paymentReceived} (${rec.washTicket})`
      showAlert.value = true
    } else {
      throw new Error('Payment failed')
    }
  } catch (e: any) {
    alertTitle.value = 'Activation Failed'
    alertMessage.value = e?.message || 'Could not process car wash order'
    showAlert.value = true
  } finally {
    isPaying.value = false
  }
}

const onAlertConfirm = () => {
  router.push(`/confirmation/${createdRecordId.value}`)
}

const confirmExit = () => {
  if (MiniApp?.exit) MiniApp.exit(false)
  else window.history.back()
}
</script>

<style scoped>
.checkout-view { min-height: 100vh; background-color: #0c1821; color: #ffffff; padding-bottom: 84px; }
.nav-bar {
  display: flex; align-items: center; justify-content: space-between;
  padding: 12px 16px; background: #1b2a41; border-bottom: 1px solid #324a5f;
  position: sticky; top: 0; z-index: 50;
}
.nav-back-btn, .nav-exit-btn { background: none; border: none; font-size: 16px; cursor: pointer; color: white; }
.nav-title { margin: 0; font-size: 16px; font-weight: 800; }
.content-scroll { padding: 14px 16px; display: flex; flex-direction: column; gap: 12px; }

.section-card { background: #1b2a41; border-radius: 16px; padding: 16px; border: 1px solid #324a5f; }
.tier-summary { text-align: center; background: #0c1821; border-color: #00b4d8; }
.t-badge { font-size: 9px; font-weight: 900; color: #00b4d8; text-transform: uppercase; }
.t-name { font-size: 18px; font-weight: 900; color: #ffffff; margin: 4px 0; }
.t-car { font-size: 11px; color: #94a3b8; }

.sec-title { font-size: 13px; font-weight: 800; margin: 0 0 10px 0; }
.bill-row { display: flex; justify-content: space-between; font-size: 13px; color: #94a3b8; margin-bottom: 4px; }
.bill-row.total { font-size: 15px; font-weight: 800; color: #ffffff; margin-top: 6px; }
.highlight-total { color: #00b4d8; font-size: 18px; font-weight: 900; }
.bill-divider { height: 1px; background: #324a5f; margin: 6px 0; }

.bottom-action-bar {
  position: fixed; bottom: 0; left: 0; right: 0; background: #1b2a41;
  padding: 12px 16px; border-top: 1px solid #324a5f; z-index: 90;
}
.pay-btn { background: #00b4d8 !important; border-color: #00b4d8 !important; color: black !important; font-weight: 900 !important; }
</style>
