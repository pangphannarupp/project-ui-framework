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
      <!-- Zone Summary -->
      <div class="section-card zone-summary">
        <span class="z-badge">{{ store.state.selectedZone.badge }}</span>
        <h3 class="z-name">{{ store.state.selectedZone.name.en }}</h3>
        <span class="z-event">{{ store.state.currentEvent.title }}</span>
        <span class="z-date">📅 {{ store.state.currentEvent.date }} • {{ store.state.currentEvent.time }}</span>
      </div>

      <!-- Bill -->
      <div class="section-card">
        <h4 class="sec-title">Order Total</h4>
        <div class="bill-row"><span>1x Arena Pass Ticket</span><span>${{ store.state.selectedZone.price.toFixed(2) }}</span></div>
        <div class="bill-row"><span>E-Ticket Facility Service Fee</span><span>$0.00 (Waived)</span></div>
        <div class="bill-divider"></div>
        <div class="bill-row total"><span>Total to Pay</span><span class="highlight-total">${{ store.state.selectedZone.price.toFixed(2) }}</span></div>
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
        <span v-if="!isPaying">{{ t.pay }} (${{ store.state.selectedZone.price.toFixed(2) }})</span>
        <span v-else>Issuing Arena Gate Pass...</span>
      </PPButton>
    </div>

    <!-- PPAlert -->
    <PPAlert
      v-model="showAlert"
      :title="alertTitle"
      :message="alertMessage"
      confirmText="Open Arena Gate Pass"
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
import { useEventStore } from '../store/eventStore'
import { useI18n } from '../i18n'
import '@/lib/mini.app.lib.js'

const router = useRouter()
const MiniApp = (window as any).MiniApp
const store = useEventStore()
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
    prepayId: 'CONCERT_PREPAY_' + Date.now(),
    amount: store.state.selectedZone.price,
    currency: 'USD',
    partnerCode: 'NEON_ODYSSEY_ARENA',
    metadata: {
      zone: store.state.selectedZone.name.en
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
      const p = store.purchaseTicket()
      createdPassId.value = p.id
      alertTitle.value = t.value.paymentSuccessTitle
      alertMessage.value = `${t.value.paymentReceived} (${p.ticketNumber})`
      showAlert.value = true
    } else {
      throw new Error('Payment failed')
    }
  } catch (e: any) {
    alertTitle.value = 'Booking Failed'
    alertMessage.value = e?.message || 'Could not process concert ticket checkout'
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
.checkout-view { min-height: 100vh; background-color: #0d0614; color: #ffffff; padding-bottom: 84px; }
.nav-bar {
  display: flex; align-items: center; justify-content: space-between;
  padding: 12px 16px; background: #1a0b2e; border-bottom: 1px solid #2e1065;
  position: sticky; top: 0; z-index: 50;
}
.nav-back-btn, .nav-exit-btn { background: none; border: none; font-size: 16px; cursor: pointer; color: white; }
.nav-title { margin: 0; font-size: 16px; font-weight: 800; }
.content-scroll { padding: 14px 16px; display: flex; flex-direction: column; gap: 12px; }

.section-card { background: #1a0b2e; border-radius: 16px; padding: 16px; border: 1px solid #2e1065; }
.zone-summary { text-align: center; background: #0d0614; border-color: #f59e0b; }
.z-badge { font-size: 9px; font-weight: 900; color: #f59e0b; text-transform: uppercase; }
.z-name { font-size: 18px; font-weight: 900; color: #ffffff; margin: 4px 0; }
.z-event { font-size: 12px; color: #c084fc; font-weight: 700; display: block; margin-bottom: 2px; }
.z-date { font-size: 10px; color: #94a3b8; }

.sec-title { font-size: 13px; font-weight: 800; margin: 0 0 10px 0; }
.bill-row { display: flex; justify-content: space-between; font-size: 13px; color: #94a3b8; margin-bottom: 4px; }
.bill-row.total { font-size: 15px; font-weight: 800; color: #ffffff; margin-top: 6px; }
.highlight-total { color: #f59e0b; font-size: 18px; font-weight: 900; }
.bill-divider { height: 1px; background: #2e1065; margin: 6px 0; }

.bottom-action-bar {
  position: fixed; bottom: 0; left: 0; right: 0; background: #1a0b2e;
  padding: 12px 16px; border-top: 1px solid #2e1065; z-index: 90;
}
.pay-btn { background: #f59e0b !important; border-color: #f59e0b !important; color: black !important; font-weight: 900 !important; }
</style>
