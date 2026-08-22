<template>
  <div class="my-gift-view">
    <div class="nav-bar">
      <button class="nav-back-btn" @click="$router.push('/')">
        <svg viewBox="0 0 24 24" width="22" height="22" stroke="currentColor" stroke-width="2.5" fill="none">
          <line x1="19" y1="12" x2="5" y2="12"></line>
          <polyline points="12 19 5 12 12 5"></polyline>
        </svg>
      </button>
      <h2 class="nav-title">Gift Card Wallet</h2>
      <button class="nav-exit-btn" @click="$router.push('/')">✕</button>
    </div>

    <div class="content-scroll">
      <div v-if="store.state.orders.length > 0" class="orders-list">
        <div v-for="o in store.state.orders" :key="o.id" class="order-card" @click="$router.push(`/confirmation/${o.id}`)">
          <div class="oc-top">
            <span class="oc-code">{{ o.voucherCode }}</span>
            <span class="oc-stat">AVAILABLE</span>
          </div>
          <span class="oc-rec">To: {{ o.recipientName }} ({{ o.theme.title }})</span>
          <div class="oc-foot">
            <span>{{ o.createdAt }}</span>
            <span class="oc-val">${{ o.amount.toFixed(2) }}</span>
          </div>
        </div>
      </div>
      <div v-else class="empty-state">
        <p>No gift cards purchased yet.</p>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { useGiftStore } from '../store/giftStore'
const store = useGiftStore()
</script>

<style scoped>
.my-gift-view { min-height: 100vh; background-color: #fff1f2; color: #881337; }
.nav-bar {
  display: flex; align-items: center; justify-content: space-between;
  padding: 12px 16px; background: #ffffff; border-bottom: 1px solid #fecdd3;
}
.nav-back-btn, .nav-exit-btn { background: none; border: none; color: #881337; cursor: pointer; }
.nav-title { margin: 0; font-size: 16px; font-weight: 800; }
.content-scroll { padding: 16px; }

.orders-list { display: flex; flex-direction: column; gap: 12px; }
.order-card { background: #ffffff; border-radius: 14px; padding: 14px; border: 1px solid #fecdd3; cursor: pointer; }
.oc-top { display: flex; justify-content: space-between; margin-bottom: 4px; }
.oc-code { font-weight: 900; font-size: 13px; color: #e11d48; }
.oc-stat { font-size: 10px; font-weight: 800; background: #fff1f2; color: #e11d48; padding: 2px 6px; border-radius: 4px; }
.oc-rec { font-size: 11px; color: #9f1239; margin-bottom: 8px; display: block; }
.oc-foot { display: flex; justify-content: space-between; font-size: 12px; color: #9f1239; border-top: 1px solid #fff1f2; padding-top: 6px; }
.oc-val { font-weight: 900; color: #881337; }
.empty-state { text-align: center; padding: 40px; color: #9f1239; }
</style>
