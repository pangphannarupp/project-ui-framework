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
      <div class="section-card pack-summary">
        <span class="bonus">{{ store.state.selectedPack.bonus }}</span>
        <h3 class="spins-amount">🪙 {{ store.state.selectedPack.spins }} Spin Tokens</h3>
        <span class="desc">Unlimited validity on all lucky spins</span>
      </div>

      <div class="section-card">
        <h4 class="section-title">Order Total</h4>
        <div class="bill-row"><span>Token Package</span><span>${{ store.state.selectedPack.price.toFixed(2) }}</span></div>
        <div class="bill-row"><span>Transaction Surcharge</span><span>$0.00</span></div>
        <div class="bill-divider"></div>
        <div class="bill-row total"><span>Total to Pay</span><span class="highlight-total">${{ store.state.selectedPack.price.toFixed(2) }}</span></div>
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
        <span v-if="!isPaying">{{ t.pay }} (${{ store.state.selectedPack.price.toFixed(2) }})</span>
        <span v-else>Crediting Tokens...</span>
      </PPButton>
    </div>

    <!-- PPAlert -->
    <PPAlert
      v-model="showAlert"
      :title="alertTitle"
      :message="alertMessage"
      confirmText="Start Spinning Now"
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
import { useWheelStore } from '../store/wheelStore'
import { useI18n } from '../i18n'
import '@/lib/mini.app.lib.js'

const router = useRouter()
const MiniApp = (window as any).MiniApp
const store = useWheelStore()
const { t } = useI18n()

const isPaying = ref(false)
const showExitConfirm = ref(false)
const showAlert = ref(false)
const alertTitle = ref('')
const alertMessage = ref('')

const handlePay = async () => {
  isPaying.value = true

  const payload = {
    serviceType: MiniApp?.ServiceType?.KHQR_PURCHASE || 'KHQR_PURCHASE',
    prepayId: 'WHEEL_PREPAY_' + Date.now(),
    amount: store.state.selectedPack.price,
    currency: 'USD',
    partnerCode: 'LUCKY_WHEEL_GAME',
    metadata: {
      pack: `${store.state.selectedPack.spins}_SPINS`
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
      const rec = store.addSpins(store.state.selectedPack)
      alertTitle.value = t.value.paymentSuccessTitle
      alertMessage.value = `${t.value.paymentReceived} (${rec.code})`
      showAlert.value = true
    } else {
      throw new Error('Payment failed')
    }
  } catch (e: any) {
    alertTitle.value = 'Payment Failed'
    alertMessage.value = e?.message || 'Could not complete token purchase'
    showAlert.value = true
  } finally {
    isPaying.value = false
  }
}

const onAlertConfirm = () => {
  router.push('/')
}

const confirmExit = () => {
  if (MiniApp?.exit) MiniApp.exit(false)
  else window.history.back()
}
</script>

<style scoped>
.checkout-view { min-height: 100vh; background-color: #0f172a; color: #ffffff; padding-bottom: 84px; }
.nav-bar {
  display: flex; align-items: center; justify-content: space-between;
  padding: 12px 16px; background: #1e293b; border-bottom: 1px solid #334155;
  position: sticky; top: 0; z-index: 50;
}
.nav-back-btn, .nav-exit-btn { background: none; border: none; color: white; cursor: pointer; }
.nav-title { margin: 0; font-size: 16px; font-weight: 800; }
.content-scroll { padding: 14px 16px; display: flex; flex-direction: column; gap: 12px; }

.section-card { background: #1e293b; border-radius: 16px; padding: 16px; border: 1px solid #334155; }
.pack-summary { text-align: center; }
.bonus { font-size: 10px; font-weight: 800; color: #f59e0b; background: rgba(245, 158, 11, 0.15); padding: 3px 8px; border-radius: 4px; }
.spins-amount { font-size: 20px; font-weight: 900; color: #f59e0b; margin: 8px 0 2px 0; }
.desc { font-size: 11px; color: #94a3b8; }

.section-title { font-size: 13px; font-weight: 800; margin: 0 0 10px 0; }
.bill-row { display: flex; justify-content: space-between; font-size: 13px; color: #94a3b8; margin-bottom: 4px; }
.bill-row.total { font-size: 15px; font-weight: 800; color: #ffffff; margin-top: 6px; }
.highlight-total { color: #f59e0b; font-size: 18px; font-weight: 900; }
.bill-divider { height: 1px; background: #334155; margin: 6px 0; }

.bottom-action-bar {
  position: fixed; bottom: 0; left: 0; right: 0; background: #1e293b;
  padding: 12px 16px; border-top: 1px solid #334155; z-index: 90;
}
.pay-btn {
  width: 100%; background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
  color: #000000; border: none; padding: 12px; border-radius: 12px; font-size: 15px; font-weight: 900; cursor: pointer;
}
</style>
