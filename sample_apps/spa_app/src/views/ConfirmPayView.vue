<template>
  <div class="confirm-view">
    <div class="header">
      <button class="icon-btn" @click="$router.back()"><ion-icon name="chevron-back-outline"></ion-icon></button>
      <h2>Confirm & Pay</h2>
      <button class="icon-btn close-btn" @click="() => handleExit()" aria-label="Close"><ion-icon name="close-outline"></ion-icon></button>
    </div>
    
    <div class="content" v-if="service">
      <div class="card">
        <p class="section-label">Booking details</p>
        <div class="service-item">
          <img :src="service.imageUrl" alt="service" />
          <div class="service-details">
            <h4>{{ service.duration }} | {{ service.title }}</h4>
            <p>Any expert</p>
          </div>
          <div class="price">{{ service.originalPrice.toFixed(2) }} USD</div>
        </div>

        <div class="detail-row">
          <span class="label"><ion-icon name="location-outline"></ion-icon> Location</span>
          <span class="value">Anantara Spa</span>
        </div>
        <div class="detail-row">
          <span class="label"><ion-icon name="calendar-outline"></ion-icon> Schedule date</span>
          <span class="value">Thu, 13 Aug 2026</span>
        </div>
        <div class="detail-row">
          <span class="label"><ion-icon name="time-outline"></ion-icon> Starting time</span>
          <span class="value">10:00 AM</span>
        </div>
      </div>

      <div class="order-summary">
        <h3>Order summary</h3>
        <div class="summary-row">
          <span>Subtotal</span>
          <span>{{ service.originalPrice.toFixed(2) }} USD</span>
        </div>
        <div class="summary-row discount">
          <span>Discount</span>
          <span>-{{ (service.originalPrice - service.price).toFixed(2) }} USD</span>
        </div>
        <div class="summary-row total">
          <span>Total</span>
          <span>{{ service.price.toFixed(2) }} USD</span>
        </div>
      </div>

      <p class="terms">
        By proceeding, you agree to <a>Anantara Spa's Terms & Conditions</a>.
      </p>

      <button class="primary-btn" :disabled="isPaying" @click="pay">
        <ion-icon name="card-outline"></ion-icon>
        <span>Pay {{ service.price.toFixed(2) }} USD</span>
      </button>
    </div>

    <!-- Alert Modal for Payment Success or Failed -->
    <PPAlert
      v-model="showAlert"
      :title="alertTitle"
      :message="alertMessage"
      :confirmText="alertType === 'success' ? 'Done' : 'Try Again'"
      @confirm="onAlertConfirm"
    >
      <template #icon>
        <div class="alert-status-icon" :class="alertType">
          <ion-icon :name="alertType === 'success' ? 'checkmark-circle' : 'alert-circle'"></ion-icon>
        </div>
      </template>
    </PPAlert>

    <!-- Confirmation Dialog for Exit App -->
    <PPConfirm
      v-model="showExitConfirm"
      title="Exit Anantara Spa"
      message="Are you sure you want to exit the app?"
      confirmText="Yes, Exit"
      cancelText="Stay"
      confirmVariant="primary"
      @confirm="confirmExit"
    />
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { PPAlert, PPConfirm } from '@phanna/ui-framework'
import { services } from '../data/mockData'
import '@/lib/mini.app.lib.js'

const router = useRouter()
const MiniApp = (window as any).MiniApp

const isPaying = ref(false)
const userProfile = ref<any>(null)
const showExitConfirm = ref(false)

// Alert State
const showAlert = ref(false)
const alertType = ref<'success' | 'failed'>('success')
const alertTitle = ref('')
const alertMessage = ref('')

// Hardcoded for demo purposes as we don't have a state manager
const service = computed(() => services[0])

onMounted(async () => {
  try {
    const profile = await MiniApp.getUserProfile({ appKey: 'SPA_MINIAPP_CLIENT_KEY' })
    if (profile) {
      userProfile.value = profile
    }
  } catch (err) {
    console.error('Failed to get user profile in checkout:', err)
  }
})

const handleExit = () => {
  showExitConfirm.value = true
}

const confirmExit = () => {
  MiniApp.exit(false)
}

const onAlertConfirm = () => {
  if (alertType.value === 'success') {
    router.push('/')
  }
}

const pay = async () => {
  if (isPaying.value || !service.value) return
  isPaying.value = true

  try {
    const result = await MiniApp.requestPayment({
      serviceType: MiniApp.ServiceType.CARD_PAYMENT,
      prepayId: 'PREPAY_SPA_' + Date.now(),
      amount: service.value.price,
      currency: 'USD',
      partnerCode: 'ANANTARA_SPA',
    appId: "0000000016",
    apiKey: "pk_live_0000000016_1",
    secretKey: "sk_live_561756573A6B4777907EDF6932131B93",
    merchantId: "0000000001",
      metadata: {
        orderId: 'SPA_ORD_' + Date.now(),
        serviceId: service.value.id,
        serviceTitle: service.value.title,
        customerName: userProfile.value?.name || 'Guest User',
        customerPhone: userProfile.value?.phoneNumber || ''
      }
    })

    console.log('Payment success:', result)
    alertType.value = 'success'
    alertTitle.value = 'Payment Successful'
    alertMessage.value = `Your payment of ${service.value.price.toFixed(2)} USD was successful!\nTransaction ID: ${result.transactionId || 'SUCCESS'}`
    showAlert.value = true
  } catch (error: any) {
    console.error('Payment failed or was cancelled:', error)
    alertType.value = 'failed'
    alertTitle.value = 'Payment Failed'
    alertMessage.value = error?.errorMessage || error?.message || 'Payment was cancelled or could not be processed. Please try again.'
    showAlert.value = true
  } finally {
    isPaying.value = false
  }
}
</script>

<style scoped>
.confirm-view {
  background-color: #f7f7f7;
  min-height: 100vh;
  display: flex;
  flex-direction: column;
}
.header {
  background: white;
  padding: 16px;
  display: flex;
  align-items: center;
  gap: 16px;
  border-top-left-radius: 24px;
  border-top-right-radius: 24px;
}
.icon-btn {
  background: none;
  border: none;
  font-size: 24px;
  cursor: pointer;
}
.header h2 {
  font-size: 20px;
  margin: 0;
  flex: 1;
}
.close-btn {
  margin-left: auto;
}
.content {
  padding: 16px;
  flex: 1;
  display: flex;
  flex-direction: column;
  background: white;
}
.card {
  border: 1px solid #eee;
  border-radius: 12px;
  padding: 16px;
  margin-bottom: 24px;
}
.section-label {
  font-size: 14px;
  color: #666;
  margin-bottom: 12px;
}
.service-item {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-bottom: 16px;
  padding-bottom: 16px;
  border-bottom: 1px dashed #eee;
}
.service-item img {
  width: 50px;
  height: 50px;
  border-radius: 8px;
  object-fit: cover;
}
.service-details h4 {
  font-size: 14px;
  margin: 0 0 4px 0;
}
.service-details p {
  margin: 0;
  font-size: 14px;
  color: #999;
}
.price {
  margin-left: auto;
  font-weight: 600;
  font-size: 14px;
}
.detail-row {
  display: flex;
  justify-content: space-between;
  margin-bottom: 12px;
  font-size: 14px;
}
.detail-row:last-child {
  margin-bottom: 0;
}
.detail-row .label {
  color: #666;
  display: flex;
  align-items: center;
  gap: 8px;
}
.detail-row .value {
  font-weight: 600;
}
.order-summary {
  margin-bottom: 24px;
}
.order-summary h3 {
  font-size: 16px;
  margin-bottom: 16px;
}
.summary-row {
  display: flex;
  justify-content: space-between;
  margin-bottom: 12px;
  font-size: 14px;
}
.summary-row.total {
  font-weight: bold;
  font-size: 16px;
  border-top: 1px solid #eee;
  padding-top: 12px;
}
.terms {
  font-size: 12px;
  color: #999;
  text-align: center;
  margin-bottom: 24px;
}
.terms a {
  color: #666;
  text-decoration: underline;
}
.primary-btn {
  background: #b5a092;
  color: white;
  border: none;
  padding: 16px;
  border-radius: 12px;
  font-size: 16px;
  font-weight: bold;
  width: 100%;
  cursor: pointer;
  margin-top: auto;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
}
.primary-btn:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

.alert-status-icon {
  font-size: 48px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.alert-status-icon.success {
  color: #52c41a;
}

.alert-status-icon.failed {
  color: #ff4d4f;
}
</style>
