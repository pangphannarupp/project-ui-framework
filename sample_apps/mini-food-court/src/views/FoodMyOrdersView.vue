<template>
  <div class="orders-history-view">
    <div class="nav-bar">
      <button class="nav-back-btn" @click="$router.push('/')">
        <svg viewBox="0 0 24 24" width="22" height="22" stroke="currentColor" stroke-width="2.5" fill="none">
          <line x1="19" y1="12" x2="5" y2="12"></line>
          <polyline points="12 19 5 12 12 5"></polyline>
        </svg>
      </button>
      <h2 class="nav-title">My Food Orders</h2>
      <button class="nav-exit-btn" @click="$router.push('/')">✕</button>
    </div>

    <div class="content-scroll">
      <div v-if="store.state.orders.length > 0" class="orders-list">
        <div v-for="o in store.state.orders" :key="o.id" class="order-card" @click="$router.push(`/confirmation/${o.id}`)">
          <div class="card-top">
            <span class="code">{{ o.orderCode }}</span>
            <span class="status-badge">{{ o.status }}</span>
          </div>
          <p class="summary-text">{{ o.items.length }} items • Table {{ o.tableNumber }}</p>
          <div class="card-foot">
            <span class="time">{{ o.createdAt }}</span>
            <span class="total">${{ o.total.toFixed(2) }}</span>
          </div>
        </div>
      </div>

      <div v-else class="empty-state">
        <span class="empty-icon">🍜</span>
        <p>No orders placed yet.</p>
        <button class="btn-order" @click="$router.push('/')">Order Food Now</button>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { useFoodStore } from '../store/foodStore'
const store = useFoodStore()
</script>

<style scoped>
.orders-history-view { min-height: 100vh; background-color: #f8fafc; }
.nav-bar {
  display: flex; align-items: center; justify-content: space-between;
  padding: 12px 16px; background: #ffffff; border-bottom: 1px solid #edf2f7;
}
.nav-back-btn, .nav-exit-btn { background: none; border: none; cursor: pointer; }
.nav-title { margin: 0; font-size: 16px; font-weight: 800; }
.content-scroll { padding: 16px; }

.orders-list { display: flex; flex-direction: column; gap: 12px; }
.order-card {
  background: #ffffff; border-radius: 14px; padding: 14px;
  border: 1px solid #e2e8f0; cursor: pointer;
}
.card-top { display: flex; justify-content: space-between; align-items: center; margin-bottom: 4px; }
.code { font-weight: 800; font-size: 14px; color: #0f172a; }
.status-badge { font-size: 10px; font-weight: 800; background: #ffedd5; color: #ea580c; padding: 3px 6px; border-radius: 4px; }
.summary-text { font-size: 12px; color: #64748b; margin: 0 0 8px 0; }
.card-foot { display: flex; justify-content: space-between; font-size: 12px; border-top: 1px solid #f1f5f9; padding-top: 6px; }
.time { color: #94a3b8; }
.total { font-weight: 800; color: #f97316; font-size: 14px; }

.empty-state { text-align: center; padding: 50px 20px; color: #94a3b8; }
.empty-icon { font-size: 40px; display: block; margin-bottom: 8px; }
.btn-order { margin-top: 10px; background: #f97316; color: white; border: none; padding: 8px 16px; border-radius: 10px; font-weight: 700; cursor: pointer; }
</style>
