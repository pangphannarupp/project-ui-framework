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
      <!-- Machine Summary -->
      <div class="section-card machine-summary">
        <span class="m-type">{{ store.state.selectedMachine.type }}</span>
        <h3 class="m-name">{{ store.state.selectedMachine.number }}</h3>
        <span class="m-cap">{{ store.state.selectedMachine.capacityKg }}kg Capacity Drum</span>
      </div>

      <!-- Water Temp Config -->
      <div class="section-card">
        <h4 class="sec-title">{{ t.waterTemp }}</h4>
        <div class="options-grid">
          <button 
            v-for="tmp in ['Cold (Eco)', 'Warm 40°C', 'Hot 60°C (Sanitize)']"
            :key="tmp"
            class="opt-btn"
            :class="{ active: store.state.config.waterTemp === tmp }"
            @click="store.state.config.waterTemp = tmp as any"
          >
            {{ tmp }}
          </button>
        </div>
      </div>

      <!-- Spin Extraction Speed -->
      <div class="section-card">
        <h4 class="sec-title">{{ t.spinSpeed }}</h4>
        <div class="options-grid">
          <button 
            v-for="spd in ['Delicate (600 RPM)', 'Standard (1000 RPM)', 'Turbo (1400 RPM)']"
            :key="spd"
            class="opt-btn"
            :class="{ active: store.state.config.spinSpeed === spd }"
            @click="store.state.config.spinSpeed = spd as any"
          >
            {{ spd }}
          </button>
        </div>
      </div>

      <!-- Addon Toggles -->
      <div class="section-card addons-card">
        <div class="addon-row">
          <span>{{ t.extraRinse }}</span>
          <input type="checkbox" v-model="store.state.config.extraRinse" class="chk-box" />
        </div>
        <div class="addon-row">
          <span>{{ t.scentBooster }}</span>
          <input type="checkbox" v-model="store.state.config.scentBooster" class="chk-box" />
        </div>
      </div>

      <!-- Bill -->
      <div class="section-card">
        <div class="bill-row"><span>Base Cycle</span><span>${{ store.state.selectedMachine.pricePerCycle.toFixed(2) }}</span></div>
        <div class="bill-row" v-if="store.state.config.extraRinse"><span>Hygiene Extra Rinse</span><span>$0.50</span></div>
        <div class="bill-row" v-if="store.state.config.scentBooster"><span>Floral Scent Booster</span><span>$0.50</span></div>
        <div class="bill-divider"></div>
        <div class="bill-row total"><span>Total to Pay</span><span class="highlight-total">${{ store.totalCost.value.toFixed(2) }}</span></div>
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
        <span v-if="!isPaying">{{ t.pay }} (${{ store.totalCost.value.toFixed(2) }})</span>
        <span v-else>Starting Machine Drum...</span>
      </PPButton>
    </div>

    <!-- PPAlert -->
    <PPAlert
      v-model="showAlert"
      :title="alertTitle"
      :message="alertMessage"
      confirmText="Track Live Washing"
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
import { useLaundryStore } from '../store/laundryStore'
import { useI18n } from '../i18n'
import '@/lib/mini.app.lib.js'

const router = useRouter()
const MiniApp = (window as any).MiniApp
const store = useLaundryStore()
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
    prepayId: 'LAUNDRY_PREPAY_' + Date.now(),
    amount: store.totalCost.value,
    currency: 'USD',
    partnerCode: '0000000010',
    appId: "0000000010",
    apiKey: "pk_live_0000000010_1",
    secretKey: "sk_live_7B94BB9BCF0E4909B2722F7B72A580B9",
    merchantId: "0000000001",
    metadata: {
      machine: store.state.selectedMachine.number
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
      const s = store.startCycle()
      createdSessionId.value = s.id
      alertTitle.value = t.value.paymentSuccessTitle
      alertMessage.value = `${t.value.paymentReceived} (${s.sessionToken})`
      showAlert.value = true
    } else {
      throw new Error('Payment failed')
    }
  } catch (e: any) {
    alertTitle.value = 'Start Failed'
    alertMessage.value = e?.message || 'Could not start machine cycle'
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
.checkout-view { min-height: 100vh; background-color: #f0f9ff; color: #0f172a; padding-bottom: 84px; }
.nav-bar {
  display: flex; align-items: center; justify-content: space-between;
  padding: 12px 16px; background: #ffffff; border-bottom: 1px solid #bae6fd;
  position: sticky; top: 0; z-index: 50;
}
.nav-back-btn, .nav-exit-btn { background: none; border: none; font-size: 16px; cursor: pointer; color: #0f172a; }
.nav-title { margin: 0; font-size: 16px; font-weight: 800; }
.content-scroll { padding: 14px 16px; display: flex; flex-direction: column; gap: 12px; }

.section-card { background: #ffffff; border-radius: 16px; padding: 16px; border: 1px solid #e0f2fe; }
.machine-summary { text-align: center; background: #e0f2fe; border-color: #bae6fd; }
.m-type { font-size: 9px; font-weight: 900; color: #0284c7; text-transform: uppercase; }
.m-name { font-size: 18px; font-weight: 900; color: #0f172a; margin: 4px 0; }
.m-cap { font-size: 11px; color: #64748b; }

.sec-title { font-size: 13px; font-weight: 800; margin: 0 0 10px 0; }
.options-grid { display: flex; flex-direction: column; gap: 6px; }
.opt-btn {
  background: #f8fafc; border: 1px solid #e2e8f0; padding: 10px; border-radius: 10px;
  font-size: 12px; font-weight: 700; text-align: left; cursor: pointer; color: #0f172a;
}
.opt-btn.active { border-color: #0ea5e9; background: #f0f9ff; color: #0284c7; font-weight: 800; }

.addons-card { display: flex; flex-direction: column; gap: 10px; }
.addon-row { display: flex; justify-content: space-between; align-items: center; font-size: 12px; font-weight: 700; }
.chk-box { width: 18px; height: 18px; accent-color: #0ea5e9; }

.bill-row { display: flex; justify-content: space-between; font-size: 13px; color: #64748b; margin-bottom: 4px; }
.bill-row.total { font-size: 15px; font-weight: 800; color: #0f172a; margin-top: 6px; }
.highlight-total { color: #0284c7; font-size: 18px; font-weight: 900; }
.bill-divider { height: 1px; background: #e0f2fe; margin: 6px 0; }

.bottom-action-bar {
  position: fixed; bottom: 0; left: 0; right: 0; background: #ffffff;
  padding: 12px 16px; border-top: 1px solid #bae6fd; z-index: 90;
}
.pay-btn { background: #0ea5e9 !important; border-color: #0ea5e9 !important; color: white !important; }
</style>
