<template>
  <div class="spa-tickets-root">
    <header class="t-header">
      <button class="back-btn" @click="$router.push('/')">←</button>
      <h2>{{ t.myPasses }}</h2>
      <div style="width: 32px"></div>
    </header>

    <main class="t-body">
      <div v-if="store.state.reservations.length === 0" class="no-tickets-box">
        <span class="empty-emoji">🪷</span>
        <p>{{ t.noPasses }}</p>
        <PPButton variant="primary" size="medium" @click="$router.push('/')">
          {{ t.bookFirst }}
        </PPButton>
      </div>

      <div v-else class="passes-column">
        <div 
          v-for="r in store.state.reservations" 
          :key="r.id"
          class="spa-res-card"
        >
          <div class="rc-head">
            <span class="rc-code">{{ r.sanctuaryPassCode }}</span>
            <span class="rc-status">{{ r.status }}</span>
          </div>
          <div class="rc-info">
            <h4>{{ r.ritual.name[currentLanguage] || r.ritual.name.en }}</h4>
            <span>{{ r.selectedDate }} • {{ r.selectedTime }} (Locker #{{ r.lockerNumber }})</span>
          </div>
          <div class="rc-foot">
            <span class="rc-price">${{ r.totalPrice.toFixed(2) }}</span>
            <PPButton variant="primary" size="small" @click="store.state.latestReservation = r; $router.push('/status')">
              Locker Key 🪷
            </PPButton>
          </div>
        </div>
      </div>
    </main>
  </div>
</template>

<script setup lang="ts">
import { useRouter } from 'vue-router'
import { PPButton } from '@phanna/ui-framework'
import { useSpaStore } from '../store/spaStore'
import { useI18n } from '../i18n'

const store = useSpaStore()
const { t, currentLanguage } = useI18n()
</script>

<style scoped>
.spa-tickets-root { min-height: 100vh; background: #1c1917; color: #fafaf9; }
.t-header {
  display: flex; justify-content: space-between; align-items: center; padding: 16px;
  background: #292524; border-bottom: 1px solid #44403c;
}
.back-btn { background: none; border: none; font-size: 20px; color: #fafaf9; cursor: pointer; }
.t-header h2 { font-size: 15px; font-weight: 900; margin: 0; }

.t-body { padding: 16px; }
.no-tickets-box { display: flex; flex-direction: column; align-items: center; gap: 10px; margin-top: 40px; }
.empty-emoji { font-size: 40px; }

.passes-column { display: flex; flex-direction: column; gap: 12px; }
.spa-res-card {
  background: #292524; border-radius: 16px; padding: 14px; border: 1px solid #44403c;
  display: flex; flex-direction: column; gap: 8px;
}
.rc-head { display: flex; justify-content: space-between; font-size: 10px; font-weight: 800; }
.rc-code { font-family: monospace; color: #f43f5e; }
.rc-status { color: #22c55e; background: #064e3b; padding: 2px 6px; border-radius: 4px; }
.rc-info h4 { font-size: 13px; font-weight: 900; margin: 0; color: #ffffff; }
.rc-info span { font-size: 10px; color: #a8a29e; }
.rc-foot { display: flex; justify-content: space-between; align-items: center; border-top: 1px solid #44403c; padding-top: 8px; }
.rc-price { font-size: 14px; font-weight: 900; color: #f43f5e; }
</style>
