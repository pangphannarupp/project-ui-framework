<template>
  <div class="my-vouchers-view">
    <div class="nav-bar">
      <button class="nav-back-btn" @click="$router.push('/')">
        <svg viewBox="0 0 24 24" width="22" height="22" stroke="currentColor" stroke-width="2.5" fill="none">
          <line x1="19" y1="12" x2="5" y2="12"></line>
          <polyline points="12 19 5 12 12 5"></polyline>
        </svg>
      </button>
      <h2 class="nav-title">{{ t.prizesWon }}</h2>
      <button class="nav-exit-btn" @click="$router.push('/')">✕</button>
    </div>

    <div class="content-scroll">
      <div v-if="store.state.wonPrizes.length > 0" class="vouchers-list">
        <div v-for="(v, idx) in store.state.wonPrizes" :key="idx" class="voucher-card">
          <div class="v-left">
            <span class="v-icon">{{ v.icon }}</span>
            <div class="v-info">
              <h4 class="v-title">{{ v.value }}</h4>
              <span class="v-label">{{ v.label }}</span>
            </div>
          </div>
          <button class="btn-redeem" @click="openQR(v)">Redeem</button>
        </div>
      </div>
      <div v-else class="empty-state">
        <span class="empty-icon">🎁</span>
        <p>No rewards won yet. Spin the wheel to win prizes!</p>
        <button class="btn-spin-now" @click="$router.push('/')">Spin Wheel Now</button>
      </div>
    </div>

    <!-- QR Sheet -->
    <PPBottomSheet v-model="showQRSheet">
      <div class="qr-sheet-box" v-if="selectedVoucher">
        <h3>{{ selectedVoucher.value }}</h3>
        <p class="qr-sub">Show this barcode to the cashier to redeem</p>
        <PPQRCode :value="`VOUCHER|${selectedVoucher.id}|${Date.now()}`" :size="140" foreground="#0f172a" background="#ffffff" />
      </div>
    </PPBottomSheet>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { PPBottomSheet, PPQRCode } from '@phanna/ui-framework'
import { useWheelStore } from '../store/wheelStore'
import { useI18n } from '../i18n'
import type { WheelPrize } from '../types/wheel'

const store = useWheelStore()
const { t } = useI18n()

const showQRSheet = ref(false)
const selectedVoucher = ref<WheelPrize | null>(null)

const openQR = (v: WheelPrize) => {
  selectedVoucher.value = v
  showQRSheet.value = true
}
</script>

<style scoped>
.my-vouchers-view { min-height: 100vh; background-color: #0f172a; color: #ffffff; }
.nav-bar {
  display: flex; align-items: center; justify-content: space-between;
  padding: 12px 16px; background: #1e293b; border-bottom: 1px solid #334155;
}
.nav-back-btn, .nav-exit-btn { background: none; border: none; color: white; cursor: pointer; }
.nav-title { margin: 0; font-size: 16px; font-weight: 800; }
.content-scroll { padding: 16px; }

.vouchers-list { display: flex; flex-direction: column; gap: 12px; }
.voucher-card {
  background: #1e293b; border-radius: 14px; padding: 14px;
  border: 1px solid #334155; display: flex; justify-content: space-between; align-items: center;
}
.v-left { display: flex; align-items: center; gap: 10px; }
.v-icon { font-size: 26px; }
.v-info { display: flex; flex-direction: column; }
.v-title { font-size: 14px; font-weight: 800; color: #f59e0b; margin: 0; }
.v-label { font-size: 11px; color: #94a3b8; }
.btn-redeem {
  background: #f59e0b; color: #000000; border: none; font-size: 11px; font-weight: 800;
  padding: 6px 12px; border-radius: 8px; cursor: pointer;
}

.empty-state { text-align: center; padding: 50px 20px; color: #94a3b8; }
.empty-icon { font-size: 40px; display: block; margin-bottom: 8px; }
.btn-spin-now { margin-top: 12px; background: #f59e0b; color: black; border: none; padding: 10px 18px; border-radius: 10px; font-weight: 800; cursor: pointer; }

.qr-sheet-box { padding: 20px; text-align: center; background: #1e293b; color: white; display: flex; flex-direction: column; align-items: center; gap: 8px; }
.qr-sub { font-size: 11px; color: #94a3b8; }
</style>
