<template>
  <div class="omakase-tickets-root">
    <header class="t-header">
      <button class="back-btn" @click="$router.push('/')">←</button>
      <h2>{{ t.myPasses }}</h2>
      <div style="width: 32px"></div>
    </header>

    <main class="t-body">
      <div v-if="store.state.bookings.length === 0" class="no-tickets-box">
        <span class="empty-emoji">🍣</span>
        <p>{{ t.noPasses }}</p>
        <PPButton variant="primary" size="medium" @click="$router.push('/')">
          {{ t.bookFirst }}
        </PPButton>
      </div>

      <div v-else class="invitations-column">
        <div 
          v-for="b in store.state.bookings" 
          :key="b.id"
          class="inv-card-item"
        >
          <div class="ic-head">
            <span class="ic-code">{{ b.invitationCode }}</span>
            <span class="ic-status">{{ b.status }}</span>
          </div>
          <div class="ic-info">
            <h4>{{ b.experienceName }}</h4>
            <span>{{ b.selectedDate }} • {{ b.seatingTime }}</span>
          </div>
          <div class="ic-foot">
            <span class="ic-price">${{ b.totalPrice.toFixed(2) }}</span>
            <PPButton variant="primary" size="small" @click="store.state.latestBooking = b; $router.push('/status')">
              Show Invitation 🍣
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
import { useOmakaseStore } from '../store/omakaseStore'
import { useI18n } from '../i18n'

const store = useOmakaseStore()
const { t } = useI18n()
</script>

<style scoped>
.omakase-tickets-root { min-height: 100vh; background: #141210; color: #f7f3ee; }
.t-header {
  display: flex; justify-content: space-between; align-items: center; padding: 16px;
  background: #1c1917; border-bottom: 1px solid #292524;
}
.back-btn { background: none; border: none; font-size: 20px; color: #f7f3ee; cursor: pointer; }
.t-header h2 { font-size: 15px; font-weight: 900; margin: 0; }

.t-body { padding: 16px; }
.no-tickets-box { display: flex; flex-direction: column; align-items: center; gap: 10px; margin-top: 40px; }
.empty-emoji { font-size: 40px; }

.invitations-column { display: flex; flex-direction: column; gap: 12px; }
.inv-card-item {
  background: #1c1917; border-radius: 16px; padding: 14px; border: 1px solid #292524;
  display: flex; flex-direction: column; gap: 8px;
}
.ic-head { display: flex; justify-content: space-between; font-size: 10px; font-weight: 800; }
.ic-code { font-family: monospace; color: #c2a688; }
.ic-status { color: #22c55e; background: #052e16; padding: 2px 6px; border-radius: 4px; }
.ic-info h4 { font-size: 13px; font-weight: 900; margin: 0; color: #ffffff; }
.ic-info span { font-size: 10px; color: #a8a29e; }
.ic-foot { display: flex; justify-content: space-between; align-items: center; border-top: 1px solid #292524; padding-top: 8px; }
.ic-price { font-size: 14px; font-weight: 900; color: #c2a688; }
</style>
