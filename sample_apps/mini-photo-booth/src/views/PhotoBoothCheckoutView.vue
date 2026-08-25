<template>
  <div class="photo-checkout-root">
    <header class="chk-header">
      <button class="back-btn" @click="$router.back()">←</button>
      <h2>Photo Print Summary</h2>
      <div style="width: 32px"></div>
    </header>

    <main class="chk-body">
      <div class="summary-photo-card">
        <h3>2x Physical 4-Cut Strips</h3>
        <span>🎨 Theme: {{ store.state.selectedTheme.name }}</span>
        <span>✨ Filter: {{ store.state.selectedTheme.filterEffect }}</span>
        <span>🏷️ Stamp: "{{ store.state.customTextStamp }}"</span>
      </div>

      <div class="pricing-card">
        <div class="p-row">
          <span>2x Physical Film Strips:</span>
          <span>$4.00</span>
        </div>
        <div class="p-row">
          <span>High-Res Digital Cloud GIF:</span>
          <span>+$1.00</span>
        </div>
        <div class="p-row total">
          <span>Total Payable:</span>
          <span>${{ store.basePricePerPair.toFixed(2) }}</span>
        </div>
      </div>
    </main>

    <footer class="chk-footer">
      <PPButton variant="primary" block size="large" @click="handleConfirm">
        {{ t.confirmAndPay }} • ${{ store.basePricePerPair.toFixed(2) }} 📸
      </PPButton>
    </footer>
  </div>
</template>

<script setup lang="ts">
import { useRouter } from 'vue-router'
import { PPButton } from '@phanna/ui-framework'
import { usePhotoBoothStore } from '../store/photoboothStore'
import { useI18n } from '../i18n'

const router = useRouter()
const store = usePhotoBoothStore()
const { t } = useI18n()

const handleConfirm = () => {
  store.shootAndPrint()
  router.push('/status')
}
</script>

<style scoped>
.photo-checkout-root { min-height: 100vh; background: #fdf4ff; color: #581c87; padding-bottom: 96px; }
.chk-header {
  display: flex; justify-content: space-between; align-items: center; padding: 16px;
  background: white; border-bottom: 1px solid #f0abfc;
}
.back-btn { background: none; border: none; font-size: 20px; color: #581c87; cursor: pointer; }
.chk-header h2 { font-size: 15px; font-weight: 900; margin: 0; }

.chk-body { padding: 16px; display: flex; flex-direction: column; gap: 14px; }
.summary-photo-card, .pricing-card {
  background: white; border-radius: 16px; padding: 16px; border: 1px solid #f0abfc;
  display: flex; flex-direction: column; gap: 8px;
}
.summary-photo-card h3 { font-size: 15px; font-weight: 900; margin: 0; color: #c026d3; }
.summary-photo-card span { font-size: 11px; color: #86198f; }

.p-row { display: flex; justify-content: space-between; font-size: 12px; color: #86198f; }
.p-row.total { font-size: 16px; font-weight: 900; color: #c026d3; border-top: 1px solid #f0abfc; padding-top: 8px; }

.chk-footer { position: fixed; bottom: 0; left: 0; right: 0; background: white; padding: 16px; border-top: 1px solid #f0abfc; }
</style>
