<template>
  <div class="checkout-view">
    <!-- Compact In-App Navigation Bar (matching mini-pos) -->
    <div class="checkout-nav-bar">
      <button class="nav-back-btn" @click="$router.back()" aria-label="Back to Menu">
        <svg viewBox="0 0 24 24" width="22" height="22" stroke="currentColor" stroke-width="2.5" fill="none">
          <line x1="19" y1="12" x2="5" y2="12"></line>
          <polyline points="12 19 5 12 12 5"></polyline>
        </svg>
      </button>
      <h2 class="nav-title">{{ t.checkoutTitle }}</h2>
      <button class="nav-exit-btn" @click="handleExit" aria-label="Exit App">
        <svg viewBox="0 0 24 24" width="20" height="20" stroke="currentColor" stroke-width="2.5" fill="none">
          <line x1="18" y1="6" x2="6" y2="18"></line>
          <line x1="6" y1="6" x2="18" y2="18"></line>
        </svg>
      </button>
    </div>

    <div class="content-scroll">
      <!-- Visit Date & Time Info Card -->
      <div class="section-card visit-badge-card">
        <div class="visit-meta-row">
          <div>
            <span class="v-label">{{ t.visitDate }}</span>
            <span class="v-val">📅 {{ store.state.selectedVisitDate }}</span>
          </div>
          <div class="v-slot-badge">
            <span>⏰ {{ store.state.selectedTimeSlot.split(' ')[0] }}</span>
          </div>
        </div>
      </div>

      <!-- Order Items Card (Tickets + Addons) -->
      <div class="section-card">
        <div class="section-header">
          <h3 class="section-title">{{ t.orderItems }} ({{ store.totalCount.value }})</h3>
          <button class="clear-btn" @click="store.clearSelection" v-if="store.totalCount.value > 0">{{ t.clearAll }}</button>
        </div>

        <div class="cart-list" v-if="store.totalCount.value > 0">
          <!-- Tickets list -->
          <div class="cart-item" v-for="item in store.selectedTicketsList.value" :key="item.ticket.id">
            <div class="item-icon-box">{{ item.ticket.icon }}</div>
            <div class="item-details">
              <span class="item-name">{{ item.ticket.name }}</span>
              <span class="item-price">${{ item.ticket.price.toFixed(2) }}</span>
            </div>
            
            <div class="quantity-controller">
              <button class="qty-btn" @click="store.removeTicket(item.ticket.id)">−</button>
              <span class="qty-num">{{ item.quantity }}</span>
              <button class="qty-btn" @click="store.addTicket(item.ticket.id)">+</button>
            </div>
          </div>

          <!-- Addons list -->
          <div class="cart-item addon-item" v-for="item in store.selectedAddonsList.value" :key="item.addon.id">
            <div class="item-icon-box addon-icon">{{ item.addon.icon }}</div>
            <div class="item-details">
              <span class="item-name">{{ item.addon.name }}</span>
              <span class="item-price">${{ item.addon.price.toFixed(2) }}</span>
            </div>
            
            <div class="quantity-controller">
              <button class="qty-btn" @click="store.removeAddon(item.addon.id)">−</button>
              <span class="qty-num">{{ item.quantity }}</span>
              <button class="qty-btn" @click="store.addAddon(item.addon.id)">+</button>
            </div>
          </div>
        </div>

        <div v-else class="empty-cart">
          <p>{{ t.emptyCart }}</p>
          <button class="return-menu-btn" @click="$router.push('/')">{{ t.browseTickets }}</button>
        </div>
      </div>

      <!-- Visitor Contact Inputs (pre-filled from native MiniApp) -->
      <div class="section-card" v-if="store.totalCount.value > 0">
        <h3 class="section-title">Visitor Information</h3>
        
        <div class="input-row">
          <label class="form-label">Full Name</label>
          <input 
            type="text" 
            v-model="store.state.visitor.fullName" 
            placeholder="e.g. Sokha Chan" 
            class="mini-input"
          />
        </div>

        <div class="input-row">
          <label class="form-label">Phone Number</label>
          <input 
            type="tel" 
            v-model="store.state.visitor.phone" 
            placeholder="012 345 678" 
            class="mini-input"
          />
        </div>
      </div>

      <!-- Order Summary Card -->
      <div class="section-card" v-if="store.totalCount.value > 0">
        <h3 class="section-title">{{ t.subtotal }} & {{ t.total }}</h3>
        <div class="bill-row">
          <span>{{ t.subtotal }}</span>
          <span>${{ store.subtotal.value.toFixed(2) }}</span>
        </div>
        <div class="bill-row" v-if="store.discountAmount.value > 0">
          <span>Promo Discount</span>
          <span class="discount-val">-${{ store.discountAmount.value.toFixed(2) }}</span>
        </div>
        <div class="bill-row">
          <span>{{ t.vatTax }}</span>
          <span>${{ store.tax.value.toFixed(2) }}</span>
        </div>
        <div class="bill-divider"></div>
        <div class="bill-row total">
          <span>{{ t.grandTotal }}</span>
          <span class="highlight-total">${{ store.grandTotal.value.toFixed(2) }}</span>
        </div>
      </div>
    </div>

    <!-- Sticky Pay Button with native MiniApp.requestPayment integration -->
    <div class="bottom-action-bar" v-if="store.totalCount.value > 0">
      <button class="pay-btn" :disabled="isPaying" @click="handlePay">
        <svg viewBox="0 0 24 24" width="20" height="20" stroke="currentColor" stroke-width="2" fill="none">
          <rect x="1" y="4" width="22" height="16" rx="2" ry="2"></rect>
          <line x1="1" y1="10" x2="23" y2="10"></line>
        </svg>
        <span v-if="!isPaying">{{ t.pay }} ${{ store.grandTotal.value.toFixed(2) }}</span>
        <span v-else>Processing Payment...</span>
      </button>
    </div>

    <!-- Alert Modal for Success or Failed Payment (PPAlert from ui-framework) -->
    <PPAlert
      v-model="showAlert"
      :title="alertTitle"
      :message="alertMessage"
      :confirmText="alertType === 'success' ? t.newBooking : t.tryAgain"
      @confirm="onAlertConfirm"
    >
      <template #icon>
        <div class="alert-status-icon" :class="alertType">
          <svg v-if="alertType === 'success'" viewBox="0 0 24 24" width="48" height="48" fill="none" stroke="currentColor" stroke-width="2">
            <path stroke-linecap="round" stroke-linejoin="round" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
          </svg>
          <svg v-else viewBox="0 0 24 24" width="48" height="48" fill="none" stroke="currentColor" stroke-width="2">
            <path stroke-linecap="round" stroke-linejoin="round" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
          </svg>
        </div>
      </template>
    </PPAlert>

    <!-- UI-Framework Confirmation Dialog for Exit App -->
    <PPConfirm
      v-model="showExitConfirm"
      :title="t.exitTitle"
      :message="t.exitMessage"
      :confirmText="t.yesExit"
      :cancelText="t.stay"
      confirmVariant="primary"
      @confirm="confirmExit"
    />
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { PPAlert, PPConfirm } from '@phanna/ui-framework'
import { useZooStore } from '../store/zooStore'
import { useI18n } from '../i18n'
import '@/lib/mini.app.lib.js'

const router = useRouter()
const MiniApp = (window as any).MiniApp
const store = useZooStore()
const { t } = useI18n()

const isPaying = ref(false)
const showExitConfirm = ref(false)

// Alert State
const showAlert = ref(false)
const alertType = ref<'success' | 'failed'>('success')
const alertTitle = ref('')
const alertMessage = ref('')
const createdBookingId = ref('')

onMounted(async () => {
  try {
    if (MiniApp && typeof MiniApp.getUserProfile === 'function') {
      const profile = await MiniApp.getUserProfile()
      if (profile) {
        if (!store.state.visitor.fullName && profile.name) {
          store.state.visitor.fullName = profile.name
        }
        if (!store.state.visitor.phone && profile.phoneNumber) {
          store.state.visitor.phone = profile.phoneNumber
        }
        if (!store.state.visitor.email && profile.email) {
          store.state.visitor.email = profile.email
        }
      }
    }
  } catch (e) {
    console.warn('MiniApp profile fetch error', e)
  }
})

const handleExit = () => {
  showExitConfirm.value = true
}

const confirmExit = () => {
  if (MiniApp && typeof MiniApp.exit === 'function') {
    MiniApp.exit(false)
  } else {
    window.history.back()
  }
}

const handlePay = async () => {
  if (store.totalCount.value === 0) return

  isPaying.value = true

  const prepayId = 'ZOO_PREPAY_' + Date.now()
  const payload = {
    serviceType: MiniApp?.ServiceType?.KHQR_PURCHASE || 'KHQR_PURCHASE',
    prepayId: prepayId,
    amount: store.grandTotal.value,
    currency: 'USD',
    partnerCode: 'WILD_SAFARI_ZOO',
    metadata: {
      visitDate: store.state.selectedVisitDate,
      timeSlot: store.state.selectedTimeSlot,
      ticketsCount: store.totalCount.value
    }
  }

  try {
    let paymentResult: any
    if (MiniApp && typeof MiniApp.requestPayment === 'function') {
      paymentResult = await MiniApp.requestPayment(payload)
    } else {
      // Fallback
      await new Promise(resolve => setTimeout(resolve, 800))
      paymentResult = { status: 'SUCCESS', transactionId: 'TXN_' + Date.now() }
    }

    if (paymentResult && (paymentResult.status === 'SUCCESS' || paymentResult.success)) {
      const booking = store.createBooking(paymentResult)
      createdBookingId.value = booking.id

      alertType.value = 'success'
      alertTitle.value = t.value.paymentSuccessTitle
      alertMessage.value = `${t.value.paymentReceived} ${t.value.bookingCode}: ${booking.bookingCode}`
      showAlert.value = true
    } else {
      throw new Error(paymentResult?.errorMessage || 'Payment failed')
    }
  } catch (error: any) {
    alertType.value = 'failed'
    alertTitle.value = t.value.paymentFailedTitle
    alertMessage.value = error?.errorMessage || error?.message || 'Payment could not be completed.'
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
</script>

<style scoped>
.checkout-view {
  display: flex;
  flex-direction: column;
  min-height: 100vh;
  background-color: var(--zoo-bg);
  padding-bottom: 84px;
}

/* Compact Nav Bar (matching mini-pos) */
.checkout-nav-bar {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 12px 16px;
  background-color: var(--zoo-card-bg);
  border-bottom: 1px solid #edf2f7;
  position: sticky;
  top: 0;
  z-index: 50;
}

.nav-back-btn,
.nav-exit-btn {
  background: none;
  border: none;
  color: var(--text-main);
  padding: 4px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
}

.nav-exit-btn {
  color: #ef4444;
}

.nav-title {
  margin: 0;
  font-size: 16px;
  font-weight: 800;
  color: var(--text-main);
}

.content-scroll {
  padding: 14px 16px;
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.section-card {
  background-color: var(--zoo-card-bg);
  border-radius: 16px;
  padding: 16px;
  border: 1px solid #e2e8f0;
}

.visit-badge-card {
  background: #f0fdf4;
  border-color: #bbf7d0;
}

.visit-meta-row {
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.v-label {
  font-size: 10px;
  font-weight: 800;
  color: #047857;
  display: block;
}

.v-val {
  font-size: 13px;
  font-weight: 800;
  color: var(--text-main);
}

.v-slot-badge {
  background: #ffffff;
  border: 1px solid #a7f3d0;
  padding: 4px 8px;
  border-radius: 8px;
  font-size: 11px;
  font-weight: 700;
  color: #047857;
}

.section-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 12px;
}

.section-title {
  margin: 0;
  font-size: 14px;
  font-weight: 800;
  color: var(--text-main);
}

.clear-btn {
  background: none;
  border: none;
  color: #ef4444;
  font-size: 12px;
  font-weight: 700;
  cursor: pointer;
}

.cart-list {
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.cart-item {
  display: flex;
  align-items: center;
  gap: 12px;
  padding-bottom: 10px;
  border-bottom: 1px solid #f1f5f9;
}

.cart-item:last-child {
  border-bottom: none;
  padding-bottom: 0;
}

.item-icon-box {
  width: 38px;
  height: 38px;
  border-radius: 10px;
  background: #f1f5f9;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 20px;
  flex-shrink: 0;
}

.item-icon-box.addon-icon {
  background: #fffbeb;
}

.item-details {
  flex: 1;
  display: flex;
  flex-direction: column;
}

.item-name {
  font-size: 13px;
  font-weight: 700;
  color: var(--text-main);
}

.item-price {
  font-size: 12px;
  font-weight: 700;
  color: var(--zoo-primary-dark);
}

.quantity-controller {
  display: flex;
  align-items: center;
  background-color: #f1f5f9;
  border-radius: 8px;
  padding: 2px;
}

.qty-btn {
  background: #ffffff;
  border: 1px solid #cbd5e1;
  border-radius: 6px;
  width: 26px;
  height: 26px;
  font-size: 14px;
  font-weight: 800;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
}

.qty-num {
  font-size: 12px;
  font-weight: 800;
  min-width: 20px;
  text-align: center;
}

.empty-cart {
  text-align: center;
  padding: 24px 0;
}

.empty-cart p {
  color: var(--text-secondary);
  font-size: 13px;
  margin-bottom: 12px;
}

.return-menu-btn {
  background-color: var(--zoo-primary);
  color: #ffffff;
  border: none;
  padding: 8px 16px;
  border-radius: 10px;
  font-size: 13px;
  font-weight: 700;
  cursor: pointer;
}

/* Visitor Input rows */
.input-row {
  display: flex;
  flex-direction: column;
  gap: 4px;
  margin-top: 8px;
}

.form-label {
  font-size: 11px;
  font-weight: 700;
  color: var(--text-secondary);
}

.mini-input {
  width: 100%;
  padding: 8px 10px;
  border-radius: 10px;
  border: 1.5px solid #cbd5e1;
  font-size: 13px;
  outline: none;
}

.mini-input:focus {
  border-color: var(--zoo-primary);
}

/* Bill rows */
.bill-row {
  display: flex;
  justify-content: space-between;
  font-size: 13px;
  color: var(--text-secondary);
  margin-bottom: 6px;
}

.bill-row.total {
  font-size: 15px;
  font-weight: 800;
  color: var(--text-main);
  margin-top: 6px;
  margin-bottom: 0;
}

.discount-val {
  color: #059669;
  font-weight: 700;
}

.highlight-total {
  color: var(--zoo-primary-dark);
  font-size: 17px;
  font-weight: 900;
}

.bill-divider {
  height: 1px;
  background-color: #e2e8f0;
  margin: 8px 0;
}

/* Bottom Pay Bar (matching mini-pos) */
.bottom-action-bar {
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  background-color: #ffffff;
  padding: 12px 16px;
  border-top: 1px solid #e2e8f0;
  box-shadow: 0 -4px 16px rgba(0, 0, 0, 0.08);
  z-index: 90;
}

.pay-btn {
  width: 100%;
  background: linear-gradient(135deg, #10b981 0%, #047857 100%);
  color: #ffffff;
  border: none;
  padding: 12px;
  border-radius: 14px;
  font-size: 15px;
  font-weight: 800;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  cursor: pointer;
  box-shadow: 0 4px 12px rgba(16, 185, 129, 0.35);
}

.pay-btn:disabled {
  opacity: 0.7;
  cursor: not-allowed;
}

.alert-status-icon.success {
  color: #10b981;
}

.alert-status-icon.failed {
  color: #ef4444;
}
</style>
