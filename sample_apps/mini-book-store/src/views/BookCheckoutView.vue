<template>
  <div class="checkout-view">
    <!-- Navbar -->
    <header class="checkout-nav">
      <button class="back-btn" @click="router.push('/')">
        ← {{ t.appName }}
      </button>
      <h2 class="nav-title">{{ t.checkoutTitle }}</h2>
      <div style="width: 40px"></div>
    </header>

    <main class="checkout-container">
      <div class="checkout-grid">
        <!-- Cart Items & Form Column -->
        <div class="form-col">
          <div class="card cart-card">
            <h3 class="card-title">{{ t.cartTitle }}</h3>
            
            <div v-if="store.state.cart.length === 0" class="empty-state">
              <p>{{ t.emptyCart }}</p>
              <button class="explore-btn" @click="router.push('/')">Explore Books</button>
            </div>

            <div v-else class="cart-items">
              <div v-for="item in store.state.cart" :key="item.book.id + '-' + item.format" class="cart-item">
                <img :src="item.book.coverUrl" :alt="item.book.title" class="item-thumbnail" />
                <div class="item-details">
                  <h4 class="item-title">{{ item.book.title }}</h4>
                  <div class="item-meta">
                    <span class="item-format">{{ item.format }}</span>
                    <span class="item-price">${{ item.price.toFixed(2) }}</span>
                  </div>
                  <div class="quantity-controls">
                    <button class="qty-btn" @click="store.removeFromCart(item.book.id, item.format)">-</button>
                    <span class="qty-val">{{ item.quantity }}</span>
                    <button class="qty-btn" @click="store.addToCart(item.book, item.format)">+</button>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- Customer info card -->
          <div class="card customer-card">
            <h3 class="card-title">Billing & Delivery Info</h3>
            <div class="form-group">
              <label class="form-label">Full Name</label>
              <input 
                type="text" 
                v-model="store.state.passengerName" 
                class="vintage-input"
              />
            </div>
            <div class="form-group">
              <label class="form-label">Phone Number</label>
              <input 
                type="text" 
                v-model="store.state.passengerPhone" 
                class="vintage-input"
              />
            </div>
          </div>
        </div>

        <!-- Order Summary Column -->
        <div class="summary-col">
          <div class="card summary-card">
            <h3 class="card-title">Order Summary</h3>

            <div class="pricing-rows">
              <div class="pricing-row">
                <span>{{ t.subtotal }}</span>
                <span>${{ store.subtotal.value.toFixed(2) }}</span>
              </div>
              <div class="pricing-row text-discount" v-if="store.state.couponDiscount > 0">
                <span>{{ t.couponDiscount }} ({{ store.state.couponDiscount * 100 }}%)</span>
                <span>-${{ store.discountAmount.value.toFixed(2) }}</span>
              </div>
              <div class="pricing-row grand-total-row">
                <span>{{ t.grandTotal }}</span>
                <span>${{ store.grandTotal.value.toFixed(2) }}</span>
              </div>
            </div>

            <!-- Coupon application -->
            <div class="coupon-section">
              <input 
                type="text" 
                v-model="couponInput" 
                placeholder="Enter coupon (e.g. READCOZY10)" 
                class="coupon-input"
                :disabled="store.state.couponDiscount > 0"
              />
              <button 
                class="coupon-btn" 
                @click="handleCouponApply"
                :disabled="store.state.couponDiscount > 0"
              >
                {{ t.applyCoupon }}
              </button>
            </div>
            <p v-if="couponMessage" :class="['coupon-msg', isCouponError ? 'msg-error' : 'msg-success']">
              {{ couponMessage }}
            </p>

            <!-- Pay Action -->
            <button 
              class="pay-btn" 
              :disabled="store.state.cart.length === 0 || isPaying"
              @click="handlePay"
            >
              {{ isPaying ? 'Processing...' : t.pay }}
            </button>
          </div>
        </div>
      </div>
    </main>

    <!-- Custom Alerts -->
    <PPAlert
      v-model="showAlert"
      :title="alertTitle"
      :message="alertMessage"
      confirmText="View Receipt"
      @confirm="onAlertConfirm"
    />
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { PPAlert } from '@phanna/ui-framework'
import { useBookStore } from '../store/bookStore'
import { useI18n } from '../i18n'
import '@/lib/mini.app.lib.js'

const router = useRouter()
const MiniApp = (window as any).MiniApp
const store = useBookStore()
const { t } = useI18n()

const isPaying = ref(false)
const couponInput = ref('')
const couponMessage = ref('')
const isCouponError = ref(false)

const showAlert = ref(false)
const alertTitle = ref('')
const alertMessage = ref('')
const createdOrderId = ref('')

const handleCouponApply = () => {
  const success = store.applyCoupon(couponInput.value)
  if (success) {
    couponMessage.value = t.value.couponSuccess
    isCouponError.value = false
  } else {
    couponMessage.value = t.value.couponError
    isCouponError.value = true
  }
}

const handlePay = async () => {
  if (store.state.cart.length === 0) return
  isPaying.value = true

  const payload = {
    serviceType: MiniApp?.ServiceType?.KHQR_PURCHASE || 'KHQR_PURCHASE',
    prepayId: 'BOOK_PREPAY_' + Date.now(),
    amount: store.grandTotal.value,
    currency: 'USD',
    partnerCode: 'COZY_BOOKSTORE',
    metadata: {
      items: store.state.cart.map(i => `${i.book.title} (${i.format})`).join(', ')
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
      const order = store.createOrder()
      createdOrderId.value = order.id
      alertTitle.value = t.value.paymentSuccessTitle
      alertMessage.value = `${t.value.paymentReceived} (${order.receiptCode})`
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
  if (createdOrderId.value) {
    router.push(`/confirmation/${createdOrderId.value}`)
  } else {
    router.push('/')
  }
}
</script>

<style scoped>
.checkout-view {
  min-height: 100vh;
  background-color: #FAF7F2;
  color: #26211C;
  padding-bottom: 40px;
}

.checkout-nav {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px 20px;
  max-width: 900px;
  margin: 0 auto;
}

.back-btn {
  background: none;
  border: none;
  font-family: 'Playfair Display', serif;
  font-size: 1.1rem;
  color: #8A3535;
  cursor: pointer;
  font-weight: bold;
}

.nav-title {
  font-size: 1.2rem;
  font-weight: 700;
}

.checkout-container {
  max-width: 900px;
  margin: 20px auto 0 auto;
  padding: 0 20px;
}

.checkout-grid {
  display: grid;
  grid-template-columns: 1fr;
  gap: 24px;
}

@media (min-width: 768px) {
  .checkout-grid {
    grid-template-columns: 1.5fr 1fr;
  }
}

.card {
  background-color: #fff;
  border: 1px solid #e2dacd;
  border-radius: 6px;
  padding: 20px;
  margin-bottom: 20px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.02);
}

.card-title {
  font-family: 'Playfair Display', serif;
  font-size: 1.25rem;
  margin-bottom: 16px;
  border-bottom: 1px solid #FAF7F2;
  padding-bottom: 8px;
  color: #8A3535;
}

.empty-state {
  text-align: center;
  padding: 30px 10px;
  color: #706254;
}

.explore-btn {
  background-color: #2D4A3E;
  color: #fff;
  border: none;
  padding: 8px 16px;
  border-radius: 4px;
  margin-top: 12px;
  cursor: pointer;
}

.cart-items {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.cart-item {
  display: flex;
  gap: 12px;
  border-bottom: 1px dashed #e2dacd;
  padding-bottom: 16px;
}

.cart-item:last-child {
  border-bottom: none;
  padding-bottom: 0;
}

.item-thumbnail {
  width: 50px;
  height: 75px;
  object-fit: cover;
  border-radius: 4px;
}

.item-details {
  flex: 1;
  display: flex;
  flex-direction: column;
}

.item-title {
  font-family: 'Playfair Display', serif;
  font-size: 0.95rem;
  margin-bottom: 4px;
}

.item-meta {
  display: flex;
  justify-content: space-between;
  font-size: 0.85rem;
  color: #706254;
  margin-bottom: 8px;
}

.item-format {
  font-weight: 500;
}

.item-price {
  font-weight: bold;
}

.quantity-controls {
  display: flex;
  align-items: center;
  gap: 12px;
}

.qty-btn {
  background-color: #FAF7F2;
  border: 1px solid #e2dacd;
  width: 24px;
  height: 24px;
  border-radius: 4px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  font-weight: bold;
}

.qty-val {
  font-size: 0.9rem;
  font-weight: bold;
}

.form-group {
  display: flex;
  flex-direction: column;
  gap: 6px;
  margin-bottom: 16px;
}

.form-label {
  font-size: 0.85rem;
  color: #706254;
  font-weight: 600;
}

.vintage-input {
  width: 100%;
  padding: 10px 14px;
  border: 1.5px solid #e2dacd;
  border-radius: 6px;
  font-family: inherit;
  outline: none;
}

.vintage-input:focus {
  border-color: #8A3535;
}

.pricing-rows {
  display: flex;
  flex-direction: column;
  gap: 10px;
  margin-bottom: 20px;
}

.pricing-row {
  display: flex;
  justify-content: space-between;
  font-size: 0.95rem;
}

.text-discount {
  color: #8A3535;
  font-weight: 600;
}

.grand-total-row {
  border-top: 1px solid #e2dacd;
  padding-top: 10px;
  font-weight: bold;
  font-size: 1.15rem;
  color: #2D4A3E;
}

.coupon-section {
  display: flex;
  gap: 8px;
  margin-bottom: 12px;
}

.coupon-input {
  flex: 1;
  padding: 8px 12px;
  border: 1.5px solid #e2dacd;
  border-radius: 4px;
  font-size: 0.85rem;
  text-transform: uppercase;
}

.coupon-btn {
  background-color: #2D4A3E;
  color: #fff;
  border: none;
  padding: 8px 12px;
  border-radius: 4px;
  cursor: pointer;
}

.coupon-btn:disabled {
  opacity: 0.5;
}

.coupon-msg {
  font-size: 0.8rem;
  margin-bottom: 12px;
}

.msg-success {
  color: #2D4A3E;
}

.msg-error {
  color: #8A3535;
}

.pay-btn {
  width: 100%;
  background-color: #8A3535;
  color: #fff;
  border: none;
  padding: 14px;
  border-radius: 6px;
  font-size: 1.05rem;
  font-weight: bold;
  cursor: pointer;
  transition: opacity 0.2s;
}

.pay-btn:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

@media (max-width: 600px) {
  .checkout-nav {
    padding: 12px 14px;
  }
  .nav-title {
    font-size: 1.1rem;
  }
  .checkout-container {
    padding: 0 12px;
  }
  .card {
    padding: 16px;
    margin-bottom: 16px;
  }
  .item-title {
    font-size: 0.9rem;
  }
  .item-meta {
    font-size: 0.8rem;
  }
}
</style>
