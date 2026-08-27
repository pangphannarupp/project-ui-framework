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
      <!-- Locker Summary -->
      <div class="section-card locker-summary">
        <span class="l-size">{{ store.state.selectedLocker.size }} LOCKER</span>
        <h3 class="l-name">{{ store.state.selectedLocker.bayNumber }}</h3>
        <span class="l-dim">{{ store.state.selectedLocker.dimensions }} • Max {{ store.state.selectedLocker.maxWeightKg }}kg</span>
      </div>

      <!-- Phone Number Inputs with PPInput -->
      <div class="section-card">
        <h4 class="sec-title">Contact Verification</h4>
        <div class="inputs-stack">
          <div class="input-field-wrap">
            <span class="f-lbl">{{ t.senderPhone }}</span>
            <PPInput v-model="store.state.senderPhone" placeholder="012 345 678" />
          </div>
          <div class="input-field-wrap">
            <span class="f-lbl">{{ t.recipientPhone }}</span>
            <PPInput v-model="store.state.recipientPhone" placeholder="098 765 432" />
          </div>
        </div>
      </div>

      <!-- Bill -->
      <div class="section-card">
        <div class="bill-row"><span>24-Hour Rental</span><span>${{ store.state.selectedLocker.price.toFixed(2) }}</span></div>
        <div class="bill-row"><span>SMS Notification to Recipient</span><span>$0.00 (Included)</span></div>
        <div class="bill-divider"></div>
        <div class="bill-row total"><span>Total to Pay</span><span class="highlight-total">${{ store.state.selectedLocker.price.toFixed(2) }}</span></div>
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
        <span v-if="!isPaying">{{ t.pay }} (${{ store.state.selectedLocker.price.toFixed(2) }})</span>
        <span v-else>Unlocking Locker Door...</span>
      </PPButton>
    </div>

    <!-- PPAlert -->
    <PPAlert
      v-model="showAlert"
      :title="alertTitle"
      :message="alertMessage"
      confirmText="View Locker Door Pass"
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
import { PPAlert, PPConfirm, PPInput, PPButton } from '@phanna/ui-framework'
import { useParcelStore } from '../store/parcelStore'
import { useI18n } from '../i18n'
import '@/lib/mini.app.lib.js'

const router = useRouter()
const MiniApp = (window as any).MiniApp
const store = useParcelStore()
const { t } = useI18n()

const isPaying = ref(false)
const showExitConfirm = ref(false)
const showAlert = ref(false)
const alertTitle = ref('')
const alertMessage = ref('')
const createdActionId = ref('')

const handlePay = async () => {
  isPaying.value = true

  const payload = {
    serviceType: MiniApp?.ServiceType?.KHQR_PURCHASE || 'KHQR_PURCHASE',
    prepayId: 'LOCKER_PREPAY_' + Date.now(),
    amount: store.state.selectedLocker.price,
    currency: 'USD',
    partnerCode: 'PARCEL_LOCKER',
    appId: "0000000016",
    apiKey: "pk_live_0000000016_1",
    secretKey: "sk_live_561756573A6B4777907EDF6932131B93",
    merchantId: "0000000001",
    metadata: {
      bay: store.state.selectedLocker.bayNumber
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
      const act = store.rentLocker()
      createdActionId.value = act.id
      alertTitle.value = t.value.paymentSuccessTitle
      alertMessage.value = `${t.value.paymentReceived} (${act.lockerBay} • PIN: ${act.pinCode})`
      showAlert.value = true
    } else {
      throw new Error('Payment failed')
    }
  } catch (e: any) {
    alertTitle.value = 'Rental Failed'
    alertMessage.value = e?.message || 'Could not process locker rental payment'
    showAlert.value = true
  } finally {
    isPaying.value = false
  }
}

const onAlertConfirm = () => {
  router.push(`/confirmation/${createdActionId.value}`)
}

const confirmExit = () => {
  if (MiniApp?.exit) MiniApp.exit(false)
  else window.history.back()
}
</script>

<style scoped>
.checkout-view { min-height: 100vh; background-color: #f8fafc; color: #0f172a; padding-bottom: 84px; }
.nav-bar {
  display: flex; align-items: center; justify-content: space-between;
  padding: 12px 16px; background: #ffffff; border-bottom: 1px solid #e2e8f0;
  position: sticky; top: 0; z-index: 50;
}
.nav-back-btn, .nav-exit-btn { background: none; border: none; font-size: 16px; cursor: pointer; color: #0f172a; }
.nav-title { margin: 0; font-size: 16px; font-weight: 800; }
.content-scroll { padding: 14px 16px; display: flex; flex-direction: column; gap: 12px; }

.section-card { background: #ffffff; border-radius: 16px; padding: 16px; border: 1px solid #e2e8f0; }
.locker-summary { text-align: center; background: #fef08a; border-color: #fde047; }
.l-size { font-size: 9px; font-weight: 900; color: #854d0e; text-transform: uppercase; }
.l-name { font-size: 20px; font-weight: 900; color: #0f172a; margin: 4px 0; }
.l-dim { font-size: 11px; color: #713f12; }

.sec-title { font-size: 13px; font-weight: 800; margin: 0 0 10px 0; }
.inputs-stack { display: flex; flex-direction: column; gap: 10px; }
.input-field-wrap { display: flex; flex-direction: column; gap: 4px; }
.f-lbl { font-size: 11px; font-weight: 700; color: #64748b; }

.bill-row { display: flex; justify-content: space-between; font-size: 13px; color: #64748b; margin-bottom: 4px; }
.bill-row.total { font-size: 15px; font-weight: 800; color: #0f172a; margin-top: 6px; }
.highlight-total { color: #854d0e; font-size: 18px; font-weight: 900; }
.bill-divider { height: 1px; background: #e2e8f0; margin: 6px 0; }

.bottom-action-bar {
  position: fixed; bottom: 0; left: 0; right: 0; background: #ffffff;
  padding: 12px 16px; border-top: 1px solid #e2e8f0; z-index: 90;
}
.pay-btn { background: #eab308 !important; border-color: #eab308 !important; color: black !important; font-weight: 900 !important; }
</style>
