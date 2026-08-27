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
      <!-- Station Card -->
      <div class="section-card st-card">
        <span class="net">{{ store.state.selectedStation.network }}</span>
        <h4 class="name">{{ store.state.selectedStation.name }}</h4>
        <span class="addr">📍 {{ store.state.selectedStation.address }}</span>
      </div>

      <!-- Battery SoC target -->
      <div class="section-card soc-card">
        <h4 class="section-title">🔋 {{ t.targetSoc }}: {{ store.state.targetPercent }}%</h4>
        <PPSlider 
          v-model="store.state.targetPercent" 
          :min="50" 
          :max="100" 
          :step="5"
        />
        <div class="soc-meta">
          <span>Current: {{ store.state.initialPercent }}%</span>
          <span>Est Energy: {{ store.energyEstimatedKwh.value }} kWh</span>
        </div>
      </div>

      <!-- Price Breakdown -->
      <div class="section-card">
        <h4 class="section-title">Estimated Energy Cost</h4>
        <div class="bill-row"><span>Electricity ({{ store.energyEstimatedKwh.value }} kWh @ ${{ store.state.selectedStation.pricePerKwh.toFixed(2) }})</span><span>${{ store.estimatedCost.value.toFixed(2) }}</span></div>
        <div class="bill-row"><span>Session Activation & Network Fee</span><span>$0.00 (Free)</span></div>
        <div class="bill-divider"></div>
        <div class="bill-row total"><span>Pre-authorized Deposit</span><span class="highlight-total">${{ store.estimatedCost.value.toFixed(2) }}</span></div>
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
        <span v-if="!isPaying">{{ t.pay }} (${{ store.estimatedCost.value.toFixed(2) }})</span>
        <span v-else>Unlocking Supercharger...</span>
      </PPButton>
    </div>

    <!-- PPAlert -->
    <PPAlert
      v-model="showAlert"
      :title="alertTitle"
      :message="alertMessage"
      confirmText="Monitor Live Charging"
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
import { PPAlert, PPConfirm, PPSlider, PPButton } from '@phanna/ui-framework'
import { useEVStore } from '../store/evStore'
import { useI18n } from '../i18n'
import '@/lib/mini.app.lib.js'

const router = useRouter()
const MiniApp = (window as any).MiniApp
const store = useEVStore()
const { t } = useI18n()

const isPaying = ref(false)
const showExitConfirm = ref(false)
const showAlert = ref(false)
const alertTitle = ref('')
const alertMessage = ref('')
const createdSessionId = ref('')

const handlePay = async () => {
  isPaying.value = true

  const payload = {
    serviceType: MiniApp?.ServiceType?.KHQR_PURCHASE || 'KHQR_PURCHASE',
    prepayId: 'EV_PREPAY_' + Date.now(),
    amount: store.estimatedCost.value,
    currency: 'USD',
    partnerCode: '0000000010',
    appId: '0000000010',
    apiKey: 'pk_live_0000000010_1',
    secretKey: 'sk_live_7B94BB9BCF0E4909B2722F7B72A580B9',
    merchantId: "0000000001",
    metadata: {
      station: store.state.selectedStation.name,
      targetSoc: `${store.state.targetPercent}%`
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
      const s = store.startSession()
      createdSessionId.value = s.id
      alertTitle.value = t.value.paymentSuccessTitle
      alertMessage.value = `${t.value.paymentReceived} (${s.sessionCode})`
      showAlert.value = true
    } else {
      throw new Error('Payment failed')
    }
  } catch (e: any) {
    alertTitle.value = 'Authorization Failed'
    alertMessage.value = e?.message || 'Could not initiate session'
    showAlert.value = true
  } finally {
    isPaying.value = false
  }
}

const onAlertConfirm = () => {
  router.push(`/confirmation/${createdSessionId.value}`)
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
.nav-back-btn, .nav-exit-btn { background: none; border: none; cursor: pointer; }
.nav-title { margin: 0; font-size: 16px; font-weight: 800; }
.content-scroll { padding: 14px 16px; display: flex; flex-direction: column; gap: 12px; }

.section-card { background: #ffffff; border-radius: 16px; padding: 16px; border: 1px solid #e2e8f0; }
.st-card { background: #ecfdf5; border-color: #a7f3d0; }
.net { font-size: 10px; font-weight: 800; color: #059669; text-transform: uppercase; }
.name { font-size: 15px; font-weight: 800; margin: 2px 0; }
.addr { font-size: 11px; color: #64748b; }

.soc-card { display: flex; flex-direction: column; gap: 8px; }
.section-title { font-size: 13px; font-weight: 800; margin: 0; }
.soc-slider { width: 100%; accent-color: #10b981; }
.soc-meta { display: flex; justify-content: space-between; font-size: 11px; font-weight: 700; color: #64748b; }

.bill-row { display: flex; justify-content: space-between; font-size: 13px; color: #64748b; margin-bottom: 4px; }
.bill-row.total { font-size: 15px; font-weight: 800; color: #0f172a; margin-top: 6px; }
.highlight-total { color: #10b981; font-size: 17px; font-weight: 900; }
.bill-divider { height: 1px; background: #e2e8f0; margin: 6px 0; }

.bottom-action-bar {
  position: fixed; bottom: 0; left: 0; right: 0; background: #ffffff;
  padding: 12px 16px; border-top: 1px solid #e2e8f0; z-index: 90;
}
.pay-btn {
  width: 100%; background: linear-gradient(135deg, #10b981 0%, #059669 100%);
  color: white; border: none; padding: 12px; border-radius: 12px; font-size: 15px; font-weight: 800; cursor: pointer;
}
</style>
