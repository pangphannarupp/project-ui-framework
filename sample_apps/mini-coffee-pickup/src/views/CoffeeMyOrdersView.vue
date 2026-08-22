<template>
  <div class="my-coffee-view">
    <div class="nav-bar">
      <button class="nav-back-btn" @click="$router.push('/')">
        <svg viewBox="0 0 24 24" width="22" height="22" stroke="currentColor" stroke-width="2.5" fill="none">
          <line x1="19" y1="12" x2="5" y2="12"></line>
          <polyline points="12 19 5 12 12 5"></polyline>
        </svg>
      </button>
      <h2 class="nav-title">My Coffee Orders</h2>
      <button class="nav-exit-btn" @click="$router.push('/')">✕</button>
    </div>

    <div class="content-scroll">
      <div v-if="store.state.orders.length > 0" class="orders-list">
        <div v-for="o in store.state.orders" :key="o.id" class="order-card" @click="$router.push(`/confirmation/${o.id}`)">
          <div class="oc-top">
            <span class="oc-num">{{ o.orderNumber }}</span>
            <span class="oc-status">{{ o.status }}</span>
          </div>
          <span class="oc-items">{{ o.items.length }} drink(s) ordered</span>
          <div class="oc-foot">
            <span>{{ o.createdAt }}</span>
            <span class="oc-price">${{ o.total.toFixed(2) }}</span>
          </div>
        </div>
      </div>
      <div v-else class="empty-state">
        <p>No coffee orders yet.</p>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { useCoffeeStore } from '../store/coffeeStore'
const store = useCoffeeStore()
</script>

<style scoped>
.my-coffee-view { min-height: 100vh; background-color: #fbf7f2; color: #291b12; }
.nav-bar {
  display: flex; align-items: center; justify-content: space-between;
  padding: 12px 16px; background: #ffffff; border-bottom: 1px solid #ebdcd0;
}
.nav-back-btn, .nav-exit-btn { background: none; border: none; cursor: pointer; color: #291b12; }
.nav-title { margin: 0; font-size: 16px; font-weight: 800; }
.content-scroll { padding: 16px; }

.orders-list { display: flex; flex-direction: column; gap: 12px; }
.order-card {
  background: #ffffff; border-radius: 14px; padding: 14px; border: 1px solid #ebdcd0; cursor: pointer;
}
.oc-top { display: flex; justify-content: space-between; margin-bottom: 4px; }
.oc-num { font-size: 14px; font-weight: 900; color: #6f4e37; }
.oc-status { font-size: 10px; font-weight: 800; background: #ebdcd0; color: #6f4e37; padding: 2px 6px; border-radius: 4px; }
.oc-items { font-size: 12px; color: #8c7362; margin-bottom: 8px; display: block; }
.oc-foot { display: flex; justify-content: space-between; font-size: 12px; color: #8c7362; border-top: 1px solid #f8f1eb; padding-top: 6px; }
.oc-price { font-weight: 900; color: #6f4e37; }
.empty-state { text-align: center; padding: 40px; color: #8c7362; }
</style>
