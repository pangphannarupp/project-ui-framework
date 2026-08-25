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
      <!-- Pass Selection Summary -->
      <div class="section-card pass-summary">
        <span class="p-tier">{{ store.state.selectedPass.badge }}</span>
        <h3 class="p-name">{{ store.state.selectedPass.title }}</h3>
        <span class="p-acc">Access: {{ store.state.selectedPass.accessType }}</span>
      </div>

      <!-- Bill -->
      <div class="section-card">
        <h4 class="sec-title">Membership Cost</h4>
        <div class="bill-row"><span>Pass Fee</span><span>${{ store.state.selectedPass.price.toFixed(2) }}</span></div>
        <div class="bill-row"><span>Club Induction & Key Setup</span><span>$0.00 (Waived)</span></div>
        <div class="bill-divider"></div>
        <div class="bill-row total"><span>Total to Pay</span><span class="highlight-total">${{ store.state.selectedPass.price.toFixed(2) }}</span></div>
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
        <span v-if="!isPaying">{{ t.pay }} (${{ store.state.selectedPass.price.toFixed(2) }})</span>
        <span v-else>Activating Turnstile Pass...</span>
      </PPButton>
    </div>

    <!-- PPAlert -->
    <PPAlert
      v-model="showAlert"
      :title="alertTitle"
      :message="alertMessage"
      confirmText="Open Turnstile Pass"
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
import { useGymStore } from '../store/gymStore'
import { useI18n } from '../i18n'
import '@/lib/mini.app.lib.js'

const router = useRouter()
const MiniApp = (window as any).MiniApp
const store = useGymStore()
const { t } = useI18n()

const isPaying = ref(false)
const showExitConfirm = ref(false)
const showAlert = ref(false)
const alertTitle = ref('')
const alertMessage = ref('')
const createdPassId = ref('')

const handlePay = async () => {
  isPaying.value = true

  const payload = {
    serviceType: MiniApp?.ServiceType?.KHQR_PURCHASE || 'KHQR_PURCHASE',
    prepayId: 'GYM_PREPAY_' + Date.now(),
    amount: store.state.selectedPass.price,
    currency: 'USD',
    partnerCode: 'CYBER_FITNESS',
    metadata: {
      plan: store.state.selectedPass.title
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
      const p = store.purchasePass()
      createdPassId.value = p.id
      alertTitle.value = t.value.paymentSuccessTitle
      alertMessage.value = `${t.value.paymentReceived} (${p.passCode})`
      showAlert.value = true
    } else {
      throw new Error('Payment failed')
    }
  } catch (e: any) {
    alertTitle.value = 'Activation Failed'
    alertMessage.value = e?.message || 'Could not process gym pass payment'
    showAlert.value = true
  } finally {
    isPaying.value = false
  }
}

const onAlertConfirm = () => {
  router.push(`/confirmation/${createdPassId.value}`)
}

const confirmExit = () => {
  if (MiniApp?.exit) MiniApp.exit(false)
  else window.history.back()
}
</script>

<style scoped>
.checkout-view { min-height: 100vh; background-color: #09090b; color: #ffffff; padding-bottom: 84px; }
.nav-bar {
  display: flex; align-items: center; justify-content: space-between;
  padding: 12px 16px; background: #18181b; border-bottom: 1px solid #27272a;
  position: sticky; top: 0; z-index: 50;
}
.nav-back-btn, .nav-exit-btn { background: none; border: none; color: white; cursor: pointer; }
.nav-title { margin: 0; font-size: 16px; font-weight: 800; }
.content-scroll { padding: 14px 16px; display: flex; flex-direction: column; gap: 12px; }

.section-card { background: #18181b; border-radius: 16px; padding: 16px; border: 1px solid #27272a; }
.pass-summary { text-align: center; }
.p-tier { font-size: 9px; font-weight: 900; color: #84cc16; background: rgba(132, 204, 22, 0.15); padding: 3px 8px; border-radius: 4px; text-transform: uppercase; }
.p-name { font-size: 20px; font-weight: 900; color: #ffffff; margin: 8px 0 2px 0; }
.p-acc { font-size: 11px; color: #a1a1aa; }

.sec-title { font-size: 13px; font-weight: 800; margin: 0 0 10px 0; }
.bill-row { display: flex; justify-content: space-between; font-size: 13px; color: #a1a1aa; margin-bottom: 4px; }
.bill-row.total { font-size: 15px; font-weight: 900; color: #ffffff; margin-top: 6px; }
.highlight-total { color: #84cc16; font-size: 18px; font-weight: 900; }
.bill-divider { height: 1px; background: #27272a; margin: 6px 0; }

.bottom-action-bar {
  position: fixed; bottom: 0; left: 0; right: 0; background: #18181b;
  padding: 12px 16px; border-top: 1px solid #27272a; z-index: 90;
}
.pay-btn { background: #84cc16 !important; border-color: #84cc16 !important; color: black !important; font-weight: 900 !important; }
</style>
