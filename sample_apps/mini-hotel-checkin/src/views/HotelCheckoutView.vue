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
      <!-- Suite Summary -->
      <div class="section-card suite-summary">
        <span class="s-tier">{{ store.state.selectedSuite.tier }}</span>
        <h3 class="s-name">{{ store.state.selectedSuite.name.en }}</h3>
        <span class="s-dates">{{ store.state.checkInDate }} → {{ store.state.checkOutDate }} ({{ store.state.nights }} Nights)</span>
      </div>

      <!-- Guest Input -->
      <div class="section-card">
        <h4 class="sec-title">Guest of Honor</h4>
        <PPInput v-model="store.state.guestName" placeholder="Enter Primary Guest Name" />
      </div>

      <!-- Price Breakdown -->
      <div class="section-card">
        <div class="bill-row"><span>Suite Rate ({{ store.state.nights }} Nights @ ${{ store.state.selectedSuite.pricePerNight.toFixed(2) }})</span><span>${{ (store.state.selectedSuite.pricePerNight * store.state.nights).toFixed(2) }}</span></div>
        <div class="bill-row"><span>Concierge & Champagne Amenity</span><span>$0.00 (Complimentary)</span></div>
        <div class="bill-divider"></div>
        <div class="bill-row total"><span>Total to Pay</span><span class="highlight-total">${{ (store.state.selectedSuite.pricePerNight * store.state.nights).toFixed(2) }}</span></div>
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
        <span v-if="!isPaying">{{ t.pay }} (${{ (store.state.selectedSuite.pricePerNight * store.state.nights).toFixed(2) }})</span>
        <span v-else>Generating Keyless NFC Pass...</span>
      </PPButton>
    </div>

    <!-- PPAlert -->
    <PPAlert
      v-model="showAlert"
      :title="alertTitle"
      :message="alertMessage"
      confirmText="Open Digital Room Key"
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
import { useHotelStore } from '../store/hotelStore'
import { useI18n } from '../i18n'
import '@/lib/mini.app.lib.js'

const MiniApp = (window as any).MiniApp
const store = useHotelStore()
const { t } = useI18n()

const isPaying = ref(false)
const showExitConfirm = ref(false)
const showAlert = ref(false)
const alertTitle = ref('')
const alertMessage = ref('')
const createdBookingId = ref('')

const handlePay = async () => {
  isPaying.value = true

  const total = store.state.selectedSuite.pricePerNight * store.state.nights
  const payload = {
    serviceType: MiniApp?.ServiceType?.KHQR_PURCHASE || 'KHQR_PURCHASE',
    prepayId: 'HOTEL_PREPAY_' + Date.now(),
    amount: total,
    currency: 'USD',
    partnerCode: 'GRAND_CHAMPAGNE',
    metadata: {
      suite: store.state.selectedSuite.name.en
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
      const b = store.bookSuite()
      createdBookingId.value = b.id
      alertTitle.value = t.value.paymentSuccessTitle
      alertMessage.value = `${t.value.paymentReceived} (${b.roomNumber})`
      showAlert.value = true
    } else {
      throw new Error('Payment failed')
    }
  } catch (e: any) {
    alertTitle.value = 'Booking Failed'
    alertMessage.value = e?.message || 'Could not complete hotel reservation'
    showAlert.value = true
  } finally {
    isPaying.value = false
  }
}

const onAlertConfirm = () => {
  router.push(`/confirmation/${createdBookingId.value}`)
}

const confirmExit = () => {
  if (MiniApp?.exit) MiniApp.exit(false)
  else window.history.back()
}
</script>

<style scoped>
.checkout-view { min-height: 100vh; background-color: #0b132b; color: #ffffff; padding-bottom: 84px; }
.nav-bar {
  display: flex; align-items: center; justify-content: space-between;
  padding: 12px 16px; background: #1c2541; border-bottom: 1px solid #3a506b;
  position: sticky; top: 0; z-index: 50;
}
.nav-back-btn, .nav-exit-btn { background: none; border: none; font-size: 16px; cursor: pointer; color: white; }
.nav-title { margin: 0; font-size: 16px; font-weight: 800; }
.content-scroll { padding: 14px 16px; display: flex; flex-direction: column; gap: 12px; }

.section-card { background: #1c2541; border-radius: 16px; padding: 16px; border: 1px solid #3a506b; }
.suite-summary { text-align: center; background: #0b132b; border-color: #d4af37; }
.s-tier { font-size: 9px; font-weight: 900; color: #d4af37; text-transform: uppercase; }
.s-name { font-size: 20px; font-weight: 900; color: #ffffff; margin: 4px 0; }
.s-dates { font-size: 11px; color: #a1a1aa; }

.sec-title { font-size: 13px; font-weight: 800; margin: 0 0 10px 0; }

.bill-row { display: flex; justify-content: space-between; font-size: 13px; color: #a1a1aa; margin-bottom: 4px; }
.bill-row.total { font-size: 15px; font-weight: 800; color: #ffffff; margin-top: 6px; }
.highlight-total { color: #d4af37; font-size: 18px; font-weight: 900; }
.bill-divider { height: 1px; background: #3a506b; margin: 6px 0; }

.bottom-action-bar {
  position: fixed; bottom: 0; left: 0; right: 0; background: #1c2541;
  padding: 12px 16px; border-top: 1px solid #3a506b; z-index: 90;
}
.pay-btn { background: #d4af37 !important; border-color: #d4af37 !important; color: black !important; font-weight: 900 !important; }
</style>
