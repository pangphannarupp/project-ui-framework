<template>
  <div class="confirmation-view" v-if="order">
    <!-- Navbar -->
    <header class="confirm-nav">
      <div style="width: 40px"></div>
      <h2 class="nav-title">{{ t.appName }}</h2>
      <button class="exit-btn" @click="showExitConfirm = true">✕</button>
    </header>

    <main class="confirm-container">
      <div class="success-card">
        <div class="success-icon">✓</div>
        <h1 class="success-title">{{ t.paymentSuccessTitle }}</h1>
        <p class="success-desc">Your order has been logged and processed successfully.</p>
        
        <div class="receipt-flourish">❦</div>

        <!-- Receipt details -->
        <div class="receipt-details">
          <div class="receipt-row">
            <span class="label">Date</span>
            <span class="value">{{ order.orderDate }}</span>
          </div>
          <div class="receipt-row">
            <span class="label">{{ t.receiptCode }}</span>
            <span class="value code-val">{{ order.receiptCode }}</span>
          </div>
          <div class="receipt-row">
            <span class="label">Customer</span>
            <span class="value">{{ order.customerName }}</span>
          </div>
          <div class="receipt-row">
            <span class="label">Phone</span>
            <span class="value">{{ order.customerPhone }}</span>
          </div>

          <div class="divider"></div>

          <h3 class="items-title">Purchased Items</h3>
          <div class="items-list">
            <div v-for="item in order.items" :key="item.book.id + '-' + item.format" class="receipt-item">
              <div class="item-desc">
                <span class="title">{{ item.book.title }}</span>
                <span class="format">Format: {{ item.format }} (x{{ item.quantity }})</span>
              </div>
              <span class="price">${{ (item.price * item.quantity).toFixed(2) }}</span>
            </div>
          </div>

          <div class="divider"></div>

          <div class="receipt-row total-row">
            <span class="label">Total Paid</span>
            <span class="value total-val">${{ order.totalAmount.toFixed(2) }}</span>
          </div>
        </div>

        <div class="receipt-actions">
          <button class="browse-btn" @click="router.push('/')">
            📖 Browse Another Book
          </button>
        </div>
      </div>
    </main>

    <!-- Exit App Confirmation -->
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
import { ref, onMounted } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { PPConfirm } from '@phanna/ui-framework'
import { useBookStore } from '../store/bookStore'
import { useI18n } from '../i18n'
import type { BookOrder } from '../types/book'
import '@/lib/mini.app.lib.js'

const router = useRouter()
const route = useRoute()
const store = useBookStore()
const { t } = useI18n()

const order = ref<BookOrder | null>(null)
const showExitConfirm = ref(false)

onMounted(() => {
  const ordId = route.params.id as string
  const foundOrder = store.state.orders.find(o => o.id === ordId)
  if (foundOrder) {
    order.value = foundOrder
  } else {
    router.push('/')
  }
})

const confirmExit = () => {
  const MiniApp = (window as any).MiniApp
  if (MiniApp?.exit) MiniApp.exit(false)
  else window.history.back()
}
</script>

<style scoped>
.confirmation-view {
  min-height: 100vh;
  background-color: #FAF7F2;
  color: #26211C;
  padding-bottom: 40px;
}

.confirm-nav {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px 20px;
  background-color: #26211C;
  color: #FAF7F2;
  border-bottom: 4px solid #8A3535;
}

.nav-title {
  font-size: 1.25rem;
  font-weight: 700;
}

.exit-btn {
  background: none;
  border: none;
  color: #FAF7F2;
  font-size: 1.4rem;
  cursor: pointer;
}

.confirm-container {
  max-width: 540px;
  margin: 32px auto 0 auto;
  padding: 0 20px;
}

.success-card {
  background-color: #fff;
  border: 1px solid #e2dacd;
  border-radius: 8px;
  padding: 30px 24px;
  box-shadow: 0 8px 30px rgba(38, 33, 28, 0.05);
  display: flex;
  flex-direction: column;
  align-items: center;
}

.success-icon {
  background-color: #2D4A3E;
  color: #fff;
  width: 54px;
  height: 54px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 1.8rem;
  font-weight: bold;
  margin-bottom: 16px;
}

.success-title {
  font-size: 1.6rem;
  color: #26211C;
  text-align: center;
  margin-bottom: 8px;
}

.success-desc {
  font-size: 0.95rem;
  color: #706254;
  text-align: center;
  margin-bottom: 12px;
}

.receipt-flourish {
  color: #8A3535;
  font-size: 1.4rem;
  margin-bottom: 20px;
}

.receipt-details {
  width: 100%;
  background-color: #FAF7F2;
  border: 1px solid #e2dacd;
  border-radius: 6px;
  padding: 20px;
  margin-bottom: 24px;
}

.receipt-row {
  display: flex;
  justify-content: space-between;
  margin-bottom: 8px;
  font-size: 0.9rem;
}

.receipt-row .label {
  color: #706254;
}

.receipt-row .value {
  font-weight: 600;
}

.code-val {
  font-family: monospace;
  font-size: 1rem;
  color: #8A3535;
}

.divider {
  height: 1px;
  background-color: #e2dacd;
  margin: 16px 0;
}

.items-title {
  font-family: 'Playfair Display', serif;
  font-size: 1rem;
  margin-bottom: 12px;
}

.items-list {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.receipt-item {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  font-size: 0.9rem;
}

.item-desc {
  display: flex;
  flex-direction: column;
}

.item-desc .title {
  font-weight: 600;
}

.item-desc .format {
  font-size: 0.75rem;
  color: #706254;
}

.receipt-item .price {
  font-weight: bold;
}

.total-row {
  font-size: 1.1rem;
  font-weight: bold;
}

.total-val {
  color: #2D4A3E;
  font-size: 1.15rem;
}

.receipt-actions {
  width: 100%;
}

.browse-btn {
  width: 100%;
  background-color: #2D4A3E;
  color: #fff;
  border: none;
  padding: 12px;
  border-radius: 6px;
  font-family: 'Playfair Display', serif;
  font-weight: bold;
  font-size: 1rem;
  cursor: pointer;
}
</style>
