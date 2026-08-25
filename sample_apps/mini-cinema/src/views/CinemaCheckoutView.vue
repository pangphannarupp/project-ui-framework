<template>
  <div class="checkout-view">
    <!-- Compact In-App Nav Bar -->
    <div class="nav-bar">
      <button class="nav-back-btn" @click="$router.back()">
        <svg viewBox="0 0 24 24" width="22" height="22" stroke="currentColor" stroke-width="2.5" fill="none">
          <line x1="19" y1="12" x2="5" y2="12"></line>
          <polyline points="12 19 5 12 12 5"></polyline>
        </svg>
      </button>
      <h2 class="nav-title">{{ t.checkoutTitle }}</h2>
      <button class="nav-exit-btn" @click="showExitConfirm = true">
        <svg viewBox="0 0 24 24" width="20" height="20" stroke="currentColor" stroke-width="2.5" fill="none">
          <line x1="18" y1="6" x2="6" y2="18"></line>
          <line x1="6" y1="6" x2="18" y2="18"></line>
        </svg>
      </button>
    </div>

    <div class="content-scroll">
      <!-- Movie & Showtime Banner -->
      <div class="movie-banner-card">
        <div class="mb-left">
          <h3 class="mb-title">{{ store.state.selectedMovie.title }}</h3>
          <span class="mb-hall">📍 {{ store.state.selectedBranch }}</span>
          <div class="mb-badges">
            <span class="badge-format">{{ store.state.selectedShowtime.format }}</span>
            <span class="badge-time">⏰ {{ store.state.selectedShowtime.time }}</span>
          </div>
        </div>
      </div>

      <!-- Interactive Cinema Seat Selector -->
      <div class="seat-picker-card">
        <div class="screen-curve">
          <div class="screen-glow"></div>
          <span class="screen-text">{{ t.screen }}</span>
        </div>

        <div class="seats-layout-grid">
          <div class="seat-row" v-for="row in seatRows" :key="row">
            <span class="row-label">{{ row }}</span>
            <div class="seats-in-row">
              <button 
                v-for="num in 8" 
                :key="row + num"
                class="seat-btn"
                :class="{
                  selected: store.state.selectedSeats.includes(row + num),
                  booked: isBooked(row + num)
                }"
                :disabled="isBooked(row + num)"
                @click="store.toggleSeat(row + num)"
              >
                {{ num }}
              </button>
            </div>
          </div>
        </div>

        <div class="seats-legend">
          <div class="leg-item"><div class="leg-box available"></div><span>{{ t.available }}</span></div>
          <div class="leg-item"><div class="leg-box selected"></div><span>{{ t.selected }}</span></div>
          <div class="leg-item"><div class="leg-box booked"></div><span>{{ t.booked }}</span></div>
        </div>
      </div>

      <!-- Popcorn & Snacks Combos -->
      <div class="section-card">
        <h4 class="section-title">🍿 {{ t.snacks }}</h4>
        <div class="snacks-list">
          <div v-for="s in SNACKS_LIST" :key="s.id" class="snack-item-row">
            <span class="snack-emoji">{{ s.icon }}</span>
            <div class="snack-info">
              <span class="snack-name">{{ s.name }}</span>
              <span class="snack-price">${{ s.price.toFixed(2) }}</span>
            </div>
            <div class="qty-controller">
              <button class="mini-btn" @click="store.removeSnack(s.id)">−</button>
              <span class="mini-val">{{ store.state.snackQuantities[s.id] || 0 }}</span>
              <button class="mini-btn" @click="store.addSnack(s.id)">+</button>
            </div>
          </div>
        </div>
      </div>

      <!-- Price Breakdown -->
      <div class="section-card">
        <h4 class="section-title">{{ t.subtotal }} & {{ t.total }}</h4>
        <div class="bill-row"><span>Seats ({{ store.state.selectedSeats.length }}x ${{ store.state.selectedShowtime.price.toFixed(2) }})</span><span>${{ store.seatsSubtotal.value.toFixed(2) }}</span></div>
        <div class="bill-row" v-if="store.snacksSubtotal.value > 0"><span>Snacks & Drinks</span><span>${{ store.snacksSubtotal.value.toFixed(2) }}</span></div>
        <div class="bill-row"><span>{{ t.vatTax }}</span><span>${{ store.tax.value.toFixed(2) }}</span></div>
        <div class="bill-divider"></div>
        <div class="bill-row total"><span>{{ t.grandTotal }}</span><span class="grand-val">${{ store.grandTotal.value.toFixed(2) }}</span></div>
      </div>
    </div>

    <!-- Sticky Pay Button with MiniApp.requestPayment -->
    <div class="bottom-action-bar">
      <PPButton 
        variant="primary" 
        block
        :disabled="isPaying || store.state.selectedSeats.length === 0" 
        @click="handlePay"
        class="pay-btn"
      >
        <span v-if="!isPaying">{{ t.pay }} ${{ store.grandTotal.value.toFixed(2) }}</span>
        <span v-else>Processing KHQR Payment...</span>
      </PPButton>
    </div>

    <!-- PPAlert confirmation dialog -->
    <PPAlert
      v-model="showAlert"
      :title="alertTitle"
      :message="alertMessage"
      :confirmText="alertType === 'success' ? 'View Movie Pass' : 'Try Again'"
      @confirm="onAlertConfirm"
    />

    <!-- PPConfirm for Exit -->
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
import { useCinemaStore } from '../store/cinemaStore'
import { SNACKS_LIST } from '../data/cinemaData'
import { useI18n } from '../i18n'
import '@/lib/mini.app.lib.js'

const router = useRouter()
const MiniApp = (window as any).MiniApp
const store = useCinemaStore()
const { t } = useI18n()

const seatRows = ['A', 'B', 'C', 'D', 'E', 'F']
const bookedSeats = ['A3', 'A4', 'C1', 'C2', 'D5', 'D6']

const isPaying = ref(false)
const showExitConfirm = ref(false)
const showAlert = ref(false)
const alertType = ref<'success' | 'failed'>('success')
const alertTitle = ref('')
const alertMessage = ref('')
const createdBookingId = ref('')

const isBooked = (seat: string) => bookedSeats.includes(seat)

const handlePay = async () => {
  if (store.state.selectedSeats.length === 0) return
  isPaying.value = true

  const payload = {
    serviceType: MiniApp?.ServiceType?.KHQR_PURCHASE || 'KHQR_PURCHASE',
    prepayId: 'CINE_PREPAY_' + Date.now(),
    amount: store.grandTotal.value,
    currency: 'USD',
    partnerCode: 'CINEPASS_CINEMA',
    metadata: {
      movie: store.state.selectedMovie.title,
      seats: store.state.selectedSeats.join(',')
    }
  }

  try {
    let res: any
    if (MiniApp && typeof MiniApp.requestPayment === 'function') {
      res = await MiniApp.requestPayment(payload)
    } else {
      await new Promise(r => setTimeout(r, 700))
      res = { status: 'SUCCESS' }
    }

    if (res?.status === 'SUCCESS' || res?.success) {
      const b = store.createBooking()
      createdBookingId.value = b.id
      alertType.value = 'success'
      alertTitle.value = t.value.paymentSuccessTitle
      alertMessage.value = `${t.value.paymentReceived} (${b.bookingCode})`
      showAlert.value = true
    } else {
      throw new Error('Payment failed')
    }
  } catch (e: any) {
    alertType.value = 'failed'
    alertTitle.value = 'Payment Failed'
    alertMessage.value = e?.message || 'Transaction could not be completed'
    showAlert.value = true
  } finally {
    isPaying.value = false
  }
}

const onAlertConfirm = () => {
  if (alertType.value === 'success') {
    router.push(`/confirmation/${createdBookingId.value}`)
  }
}

const confirmExit = () => {
  if (MiniApp?.exit) MiniApp.exit(false)
  else window.history.back()
}
</script>

<style scoped>
.checkout-view {
  min-height: 100vh;
  background-color: #0f172a;
  color: #ffffff;
  padding-bottom: 84px;
}

.nav-bar {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 12px 16px;
  background-color: #1e293b;
  border-bottom: 1px solid #334155;
  position: sticky;
  top: 0;
  z-index: 50;
}

.nav-back-btn, .nav-exit-btn {
  background: none;
  border: none;
  color: white;
  cursor: pointer;
}
.nav-exit-btn { color: #ef4444; }
.nav-title { margin: 0; font-size: 16px; font-weight: 800; }

.content-scroll {
  padding: 14px 16px;
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.movie-banner-card {
  background: #1e293b;
  padding: 14px;
  border-radius: 14px;
  border: 1px solid #334155;
}

.mb-title { font-size: 15px; font-weight: 800; margin: 0 0 4px 0; color: #f59e0b; }
.mb-hall { font-size: 11px; color: #94a3b8; display: block; margin-bottom: 6px; }
.mb-badges { display: flex; gap: 6px; }
.badge-format, .badge-time {
  font-size: 10px;
  font-weight: 700;
  background: #0f172a;
  padding: 3px 8px;
  border-radius: 6px;
  border: 1px solid #475569;
}

.seat-picker-card {
  background: #1e293b;
  padding: 16px;
  border-radius: 16px;
  border: 1px solid #334155;
  text-align: center;
}

.screen-curve {
  position: relative;
  height: 24px;
  border-top: 3px solid #f59e0b;
  border-radius: 50% 50% 0 0;
  margin-bottom: 16px;
}
.screen-glow {
  position: absolute;
  inset: 0;
  background: linear-gradient(180deg, rgba(245, 158, 11, 0.15), transparent);
}
.screen-text { font-size: 9px; font-weight: 800; color: #94a3b8; letter-spacing: 0.1em; }

.seats-layout-grid {
  display: flex;
  flex-direction: column;
  gap: 6px;
  align-items: center;
  margin-bottom: 14px;
}

.seat-row {
  display: flex;
  align-items: center;
  gap: 8px;
}

.row-label { font-size: 10px; font-weight: 800; color: #94a3b8; width: 12px; }
.seats-in-row { display: flex; gap: 5px; }

.seat-btn {
  width: 26px;
  height: 26px;
  border-radius: 6px;
  background: #0f172a;
  border: 1px solid #475569;
  color: #94a3b8;
  font-size: 10px;
  font-weight: 700;
  cursor: pointer;
}

.seat-btn.selected {
  background: #f59e0b;
  color: #000000;
  border-color: #f59e0b;
}

.seat-btn.booked {
  background: #334155;
  color: #64748b;
  border-color: #334155;
  cursor: not-allowed;
}

.seats-legend {
  display: flex;
  justify-content: center;
  gap: 16px;
  font-size: 10px;
  color: #94a3b8;
}

.leg-item { display: flex; align-items: center; gap: 4px; }
.leg-box { width: 12px; height: 12px; border-radius: 3px; }
.leg-box.available { background: #0f172a; border: 1px solid #475569; }
.leg-box.selected { background: #f59e0b; }
.leg-box.booked { background: #334155; }

.section-card {
  background: #1e293b;
  border-radius: 16px;
  padding: 14px;
  border: 1px solid #334155;
}

.section-title { font-size: 13px; font-weight: 800; margin: 0 0 10px 0; }

.snacks-list { display: flex; flex-direction: column; gap: 8px; }
.snack-item-row {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 6px 0;
  border-bottom: 1px solid #334155;
}
.snack-item-row:last-child { border-bottom: none; }

.snack-emoji { font-size: 20px; }
.snack-info { flex: 1; margin-left: 8px; display: flex; flex-direction: column; }
.snack-name { font-size: 12px; font-weight: 700; }
.snack-price { font-size: 11px; color: #f59e0b; font-weight: 700; }

.qty-controller {
  display: flex;
  align-items: center;
  background: #0f172a;
  border-radius: 6px;
  padding: 2px;
  gap: 4px;
}

.mini-btn {
  background: #334155;
  border: none;
  color: white;
  border-radius: 4px;
  width: 22px;
  height: 22px;
  font-weight: 800;
  cursor: pointer;
}
.mini-val { font-size: 11px; min-width: 14px; text-align: center; }

.bill-row {
  display: flex;
  justify-content: space-between;
  font-size: 12px;
  color: #94a3b8;
  margin-bottom: 4px;
}
.bill-row.total { font-size: 14px; font-weight: 800; color: #ffffff; margin-top: 6px; }
.grand-val { color: #f59e0b; font-size: 16px; }
.bill-divider { height: 1px; background: #334155; margin: 6px 0; }

.bottom-action-bar {
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  background: #1e293b;
  border-top: 1px solid #334155;
  padding: 12px 16px;
  z-index: 90;
}

.pay-btn {
  width: 100%;
  background: #f59e0b;
  color: #000000;
  border: none;
  padding: 12px;
  border-radius: 12px;
  font-size: 15px;
  font-weight: 800;
  cursor: pointer;
}
.pay-btn:disabled { opacity: 0.5; cursor: not-allowed; }
</style>
