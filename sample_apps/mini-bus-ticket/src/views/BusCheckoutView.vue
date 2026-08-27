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
      <!-- Route Overview -->
      <div class="section-card route-summary">
        <h4 class="op-name">{{ store.state.selectedRoute.operator }}</h4>
        <div class="journey-row">
          <span>{{ store.state.selectedRoute.origin }}</span>
          <span>➔</span>
          <span>{{ store.state.selectedRoute.destination }}</span>
        </div>
        <span class="j-time">📅 {{ store.state.selectedDate }} at {{ store.state.selectedRoute.departureTime }}</span>
      </div>

      <!-- Bus Sleeper Bunk / Seat Layout -->
      <div class="section-card sleeper-seat-card">
        <h4 class="section-title">{{ t.selectSeats }}</h4>
        
        <div class="deck-columns">
          <!-- Lower Deck -->
          <div class="deck-col">
            <span class="deck-lbl">{{ t.deckLower }}</span>
            <div class="bunk-grid">
              <button 
                v-for="bunk in ['A01', 'A02', 'A03', 'A04', 'A05', 'A06']"
                :key="bunk"
                class="bunk-btn"
                :class="{ selected: store.state.selectedSeats.includes(bunk) }"
                @click="store.toggleSeat(bunk)"
              >
                🛏️ {{ bunk }}
              </button>
            </div>
          </div>

          <!-- Upper Deck -->
          <div class="deck-col">
            <span class="deck-lbl">{{ t.deckUpper }}</span>
            <div class="bunk-grid">
              <button 
                v-for="bunk in ['B01', 'B02', 'B03', 'B04', 'B05', 'B06']"
                :key="bunk"
                class="bunk-btn"
                :class="{ selected: store.state.selectedSeats.includes(bunk) }"
                @click="store.toggleSeat(bunk)"
              >
                🛏️ {{ bunk }}
              </button>
            </div>
          </div>
        </div>
      </div>

      <!-- Passenger Details -->
      <div class="section-card">
        <h4 class="section-title">Passenger Information</h4>
        <div class="form-row">
          <label>Full Name</label>
          <input type="text" v-model="store.state.passengerName" class="form-input" />
        </div>
        <div class="form-row">
          <label>Phone Number</label>
          <input type="tel" v-model="store.state.passengerPhone" class="form-input" />
        </div>
      </div>

      <!-- Price Breakdown -->
      <div class="section-card">
        <div class="bill-row"><span>Seats ({{ store.state.selectedSeats.length }}x ${{ store.state.selectedRoute.price.toFixed(2) }})</span><span>${{ store.subtotal.value.toFixed(2) }}</span></div>
        <div class="bill-row"><span>{{ t.vatTax }}</span><span>${{ store.tax.value.toFixed(2) }}</span></div>
        <div class="bill-divider"></div>
        <div class="bill-row total"><span>{{ t.grandTotal }}</span><span class="highlight-total">${{ store.grandTotal.value.toFixed(2) }}</span></div>
      </div>
    </div>

    <!-- Sticky Pay Bar -->
    <div class="bottom-action-bar">
      <button class="pay-btn" :disabled="isPaying || store.state.selectedSeats.length === 0" @click="handlePay">
        <span v-if="!isPaying">{{ t.pay }} ${{ store.grandTotal.value.toFixed(2) }}</span>
        <span v-else>Issuing Boarding Pass...</span>
      </button>
    </div>

    <!-- PPAlert Confirmation -->
    <PPAlert
      v-model="showAlert"
      :title="alertTitle"
      :message="alertMessage"
      confirmText="View Boarding Pass"
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
import { useBusStore } from '../store/busStore'
import { useI18n } from '../i18n'
import '@/lib/mini.app.lib.js'

const router = useRouter()
const MiniApp = (window as any).MiniApp
const store = useBusStore()
const { t } = useI18n()

const isPaying = ref(false)
const showExitConfirm = ref(false)
const showAlert = ref(false)
const alertTitle = ref('')
const alertMessage = ref('')
const createdBookingId = ref('')

const handlePay = async () => {
  if (store.state.selectedSeats.length === 0) return
  isPaying.value = true

  const payload = {
    serviceType: MiniApp?.ServiceType?.KHQR_PURCHASE || 'KHQR_PURCHASE',
    prepayId: 'BUS_PREPAY_' + Date.now(),
    amount: store.grandTotal.value,
    currency: 'USD',
    partnerCode: 'EXPRESS_TRANSIT',
    appId: "0000000016",
    apiKey: "pk_live_0000000016_1",
    secretKey: "sk_live_561756573A6B4777907EDF6932131B93",
    merchantId: "0000000001",
    metadata: {
      route: `${store.state.selectedRoute.origin}-${store.state.selectedRoute.destination}`,
      seats: store.state.selectedSeats.join(',')
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
      const b = store.createBooking()
      createdBookingId.value = b.id
      alertTitle.value = t.value.paymentSuccessTitle
      alertMessage.value = `${t.value.paymentReceived} (${b.ticketCode})`
      showAlert.value = true
    } else {
      throw new Error('Payment failed')
    }
  } catch (e: any) {
    alertTitle.value = 'Payment Failed'
    alertMessage.value = e?.message || 'Transaction could not be completed'
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
.checkout-view { min-height: 100vh; background-color: #f8fafc; padding-bottom: 84px; }
.nav-bar {
  display: flex; align-items: center; justify-content: space-between;
  padding: 12px 16px; background: #ffffff; border-bottom: 1px solid #edf2f7;
  position: sticky; top: 0; z-index: 50;
}
.nav-back-btn, .nav-exit-btn { background: none; border: none; font-size: 16px; cursor: pointer; }
.nav-title { margin: 0; font-size: 16px; font-weight: 800; }
.content-scroll { padding: 14px 16px; display: flex; flex-direction: column; gap: 12px; }

.section-card { background: #ffffff; border-radius: 16px; padding: 16px; border: 1px solid #e2e8f0; }
.route-summary { background: #eff6ff; border-color: #bfdbfe; }
.op-name { font-size: 14px; font-weight: 800; color: #1e40af; margin: 0 0 4px 0; }
.journey-row { display: flex; gap: 8px; font-size: 15px; font-weight: 900; color: #0f172a; }
.j-time { font-size: 11px; color: #64748b; font-weight: 700; margin-top: 4px; display: block; }

.sleeper-seat-card { text-align: center; }
.section-title { font-size: 14px; font-weight: 800; margin: 0 0 12px 0; }
.deck-columns { display: grid; grid-template-columns: 1fr 1fr; gap: 12px; }
.deck-col { background: #f8fafc; padding: 10px; border-radius: 12px; border: 1px solid #e2e8f0; }
.deck-lbl { font-size: 11px; font-weight: 800; color: #2563eb; display: block; margin-bottom: 8px; }
.bunk-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 6px; }
.bunk-btn {
  background: #ffffff; border: 1.5px solid #cbd5e1; border-radius: 8px; padding: 8px 4px;
  font-size: 11px; font-weight: 800; color: #334155; cursor: pointer;
}
.bunk-btn.selected { background: #2563eb; color: #ffffff; border-color: #2563eb; }

.form-row { display: flex; flex-direction: column; gap: 4px; margin-bottom: 8px; }
.form-row label { font-size: 11px; font-weight: 700; color: #64748b; }
.form-input { padding: 8px 10px; border-radius: 8px; border: 1px solid #cbd5e1; font-size: 13px; outline: none; }

.bill-row { display: flex; justify-content: space-between; font-size: 13px; color: #64748b; margin-bottom: 4px; }
.bill-row.total { font-size: 15px; font-weight: 800; color: #0f172a; margin-top: 6px; }
.highlight-total { color: #2563eb; font-size: 17px; font-weight: 900; }
.bill-divider { height: 1px; background: #e2e8f0; margin: 6px 0; }

.bottom-action-bar {
  position: fixed; bottom: 0; left: 0; right: 0; background: #ffffff;
  padding: 12px 16px; border-top: 1px solid #e2e8f0; z-index: 90;
}
.pay-btn {
  width: 100%; background: linear-gradient(135deg, #2563eb 0%, #1d4ed8 100%);
  color: white; border: none; padding: 12px; border-radius: 12px; font-size: 15px; font-weight: 800; cursor: pointer;
}
.pay-btn:disabled { opacity: 0.5; cursor: not-allowed; }
</style>
