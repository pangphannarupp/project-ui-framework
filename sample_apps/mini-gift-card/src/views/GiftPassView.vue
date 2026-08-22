<template>
  <div class="pass-view">
    <div class="nav-bar">
      <button class="nav-back-btn" @click="$router.push('/')">
        <svg viewBox="0 0 24 24" width="22" height="22" stroke="currentColor" stroke-width="2.5" fill="none">
          <line x1="19" y1="12" x2="5" y2="12"></line>
          <polyline points="12 19 5 12 12 5"></polyline>
        </svg>
      </button>
      <h2 class="nav-title">{{ t.statusTitle }}</h2>
      <button class="nav-exit-btn" @click="$router.push('/')">✕</button>
    </div>

    <div class="content-scroll" v-if="order">
      <div class="gift-voucher-card">
        <div class="gv-top" :style="{ background: order.theme.gradient }">
          <span class="gv-emoji">{{ order.theme.cardArtEmoji }}</span>
          <h2 class="gv-amount">${{ order.amount }}</h2>
          <span class="gv-to">For: {{ order.recipientName }}</span>
        </div>

        <div class="gv-body">
          <p class="gv-msg">"{{ order.customMessage }}"</p>
          <PPQRCode :value="order.qrValue" :size="130" foreground="#881337" background="#ffffff" />
          <span class="gv-code">{{ order.voucherCode }}</span>
        </div>

        <div class="gv-foot">
          <span>Issued on {{ order.createdAt }}</span>
        </div>
      </div>

      <PPButton variant="primary" block size="large" @click="$router.push('/')">
        Create Another Gift Card
      </PPButton>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import { PPQRCode, PPButton } from '@phanna/ui-framework'
import { useGiftStore } from '../store/giftStore'
import { useI18n } from '../i18n'
import type { GiftCardOrderRecord } from '../types/gift'

const route = useRoute()
const store = useGiftStore()
const { t } = useI18n()
const order = ref<GiftCardOrderRecord | null>(null)

onMounted(() => {
  const id = route.params.id as string
  if (id) order.value = store.state.orders.find(o => o.id === id) || null
  if (!order.value) order.value = store.state.currentOrder || store.state.orders[0] || null
})
</script>

<style scoped>
.pass-view { min-height: 100vh; background-color: #fff1f2; color: #881337; }
.nav-bar {
  display: flex; align-items: center; justify-content: space-between;
  padding: 12px 16px; background: #ffffff; border-bottom: 1px solid #fecdd3;
}
.nav-back-btn, .nav-exit-btn { background: none; border: none; cursor: pointer; color: #881337; }
.nav-title { margin: 0; font-size: 16px; font-weight: 800; }
.content-scroll { padding: 20px 16px; display: flex; flex-direction: column; gap: 16px; }

.gift-voucher-card {
  background: #ffffff; border-radius: 20px; overflow: hidden;
  border: 1px solid #fecdd3; box-shadow: 0 10px 30px rgba(244,63,94,0.15); text-align: center;
}

.gv-top { color: white; padding: 20px; display: flex; flex-direction: column; align-items: center; gap: 4px; }
.gv-emoji { font-size: 32px; }
.gv-amount { font-size: 32px; font-weight: 900; margin: 0; }
.gv-to { font-size: 12px; font-weight: 700; opacity: 0.95; }

.gv-body { padding: 20px 16px; display: flex; flex-direction: column; align-items: center; gap: 10px; }
.gv-msg { font-size: 12px; font-style: italic; color: #9f1239; margin: 0 0 6px 0; }
.gv-code { font-family: monospace; font-size: 12px; font-weight: 900; color: #e11d48; }

.gv-foot { background: #fff1f2; padding: 12px; font-size: 11px; color: #9f1239; font-weight: 700; border-top: 1px solid #fecdd3; }
</style>
