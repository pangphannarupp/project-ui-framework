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

    <div class="content-scroll" v-if="store.state.activeSession">
      <div class="section-card plate-summary">
        <span class="ps-label">LICENSE PLATE</span>
        <div class="plate-number">{{ store.state.activeSession.plateNumber }}</div>
        <span class="loc">{{ store.state.activeSession.location }}</span>
      </div>

      <div class="section-card">
        <h4 class="section-title">Fee Breakdown</h4>
        <div class="bill-row"><span>Time Parked</span><span>{{ store.state.activeSession.durationHours }} Hours</span></div>
        <div class="bill-row"><span>Hourly Rate</span><span>${{ store.state.activeSession.hourlyRate.toFixed(2) }}</span></div>
        <div class="bill-divider"></div>
        <div class="bill-row total"><span>Total to Pay</span><span class="highlight-total">${{ store.state.activeSession.totalFee.toFixed(2) }}</span></div>
      </div>
    </div>

    <div class="bottom-action-bar">
      <button class="pay-btn" :disabled="isPaying" @click="handlePay">
        <span v-if="!isPaying">{{ t.pay }} (${{ store.state.activeSession?.totalFee.toFixed(2) }})</span>
        <span v-else>Settling Parking Fee...</span>
      </button>
    </div>

    <!-- PPAlert -->
    <PPAlert
      v-model="showAlert"
      :title="alertTitle"
      :message="alertMessage"
      confirmText="Open Barrier Gate Pass"
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
import { PPAlert, PPConfirm } from '@phanna/ui-framework'
import { useParkingStore } from '../store/parkingStore'
import { useI18n } from '../i18n'
import '@/lib/mini.app.lib.js'

const MiniApp = (window as any).MiniApp
const store = useParkingStore()
const { t } = useI18n()

const isPaying = ref(false)
const showExitConfirm = ref(false)
const showAlert = ref(false)
const alertTitle = ref('')
const alertMessage = ref('')

const handlePay = async () => {
  if (!store.state.activeSession) return
  isPaying.value = true

  const payload = {
    serviceType: MiniApp?.ServiceType?.KHQR_PURCHASE || 'KHQR_PURCHASE',
    prepayId: 'PARK_PREPAY_' + Date.now(),
    amount: store.state.activeSession.totalFee,
    currency: 'USD',
    partnerCode: 'SMART_PARKING',
    metadata: {
      plate: store.state.activeSession.plateNumber,
      ticket: store.state.activeSession.ticketNumber
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
      store.markPaid()
      alertTitle.value = t.value.paymentSuccessTitle
      alertMessage.value = t.value.paymentReceived
      showAlert.value = true
    } else {
      throw new Error('Payment failed')
    }
  } catch (e: any) {
    alertTitle.value = 'Payment Failed'
    alertMessage.value = e?.message || 'Could not settle fee'
    showAlert.value = true
  } finally {
    isPaying.value = false
  }
}

const onAlertConfirm = () => {
  router.push('/confirmation')
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
}
.nav-back-btn, .nav-exit-btn { background: none; border: none; cursor: pointer; }
.nav-title { margin: 0; font-size: 16px; font-weight: 800; }
.content-scroll { padding: 14px 16px; display: flex; flex-direction: column; gap: 12px; }

.section-card { background: #ffffff; border-radius: 16px; padding: 16px; border: 1px solid #e2e8f0; }
.plate-summary { text-align: center; background: #0f172a; color: white; border: none; }
.ps-label { font-size: 10px; font-weight: 800; color: #94a3b8; }
.plate-number { font-size: 24px; font-weight: 900; font-family: monospace; color: #38bdf8; margin: 4px 0; }
.loc { font-size: 11px; color: #cbd5e1; }

.section-title { font-size: 14px; font-weight: 800; margin: 0 0 10px 0; }
.bill-row { display: flex; justify-content: space-between; font-size: 13px; color: #64748b; margin-bottom: 4px; }
.bill-row.total { font-size: 15px; font-weight: 800; color: #0f172a; margin-top: 6px; }
.highlight-total { color: #0284c7; font-size: 18px; font-weight: 900; }
.bill-divider { height: 1px; background: #e2e8f0; margin: 6px 0; }

.bottom-action-bar {
  position: fixed; bottom: 0; left: 0; right: 0; background: #ffffff;
  padding: 12px 16px; border-top: 1px solid #e2e8f0; z-index: 90;
}
.pay-btn {
  width: 100%; background: linear-gradient(135deg, #0284c7 0%, #0369a1 100%);
  color: white; border: none; padding: 12px; border-radius: 12px; font-size: 15px; font-weight: 800; cursor: pointer;
}
</style>
