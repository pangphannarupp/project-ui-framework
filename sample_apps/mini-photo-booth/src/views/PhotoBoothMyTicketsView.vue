<template>
  <div class="photo-tickets-root">
    <header class="t-header">
      <button class="back-btn" @click="$router.push('/')">←</button>
      <h2>{{ t.myPasses }}</h2>
      <div style="width: 32px"></div>
    </header>

    <main class="t-body">
      <div v-if="store.state.sessions.length === 0" class="no-tickets-box">
        <span class="empty-emoji">🎞️</span>
        <p>{{ t.noPasses }}</p>
        <PPButton variant="primary" size="medium" @click="$router.push('/')">
          {{ t.bookFirst }}
        </PPButton>
      </div>

      <div v-else class="strips-column">
        <div 
          v-for="s in store.state.sessions" 
          :key="s.id"
          class="photo-session-card"
        >
          <div class="sc-head">
            <span class="sc-code">{{ s.printPassCode }}</span>
            <span class="sc-status">{{ s.status }}</span>
          </div>
          <div class="sc-info">
            <h4>{{ s.theme.name }}</h4>
            <span>{{ s.timestamp }} • 2x Strips</span>
          </div>
          <div class="sc-foot">
            <span class="sc-price">${{ s.totalPrice.toFixed(2) }}</span>
            <PPButton variant="primary" size="small" @click="store.state.latestSession = s; $router.push('/status')">
              Show Print Pass 📸
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
import { usePhotoBoothStore } from '../store/photoboothStore'
import { useI18n } from '../i18n'

const router = useRouter()
const store = usePhotoBoothStore()
const { t } = useI18n()
</script>

<style scoped>
.photo-tickets-root { min-height: 100vh; background: #fdf4ff; color: #581c87; }
.t-header {
  display: flex; justify-content: space-between; align-items: center; padding: 16px;
  background: white; border-bottom: 1px solid #f0abfc;
}
.back-btn { background: none; border: none; font-size: 20px; color: #581c87; cursor: pointer; }
.t-header h2 { font-size: 15px; font-weight: 900; margin: 0; }

.t-body { padding: 16px; }
.no-tickets-box { display: flex; flex-direction: column; align-items: center; gap: 10px; margin-top: 40px; }
.empty-emoji { font-size: 40px; }

.strips-column { display: flex; flex-direction: column; gap: 12px; }
.photo-session-card {
  background: white; border-radius: 16px; padding: 14px; border: 1px solid #f0abfc;
  display: flex; flex-direction: column; gap: 8px;
}
.sc-head { display: flex; justify-content: space-between; font-size: 10px; font-weight: 800; }
.sc-code { font-family: monospace; color: #c026d3; }
.sc-status { color: #16a34a; background: #dcfce7; padding: 2px 6px; border-radius: 4px; }
.sc-info h4 { font-size: 13px; font-weight: 900; margin: 0; color: #581c87; }
.sc-info span { font-size: 10px; color: #86198f; }
.sc-foot { display: flex; justify-content: space-between; align-items: center; border-top: 1px solid #fdf4ff; padding-top: 8px; }
.sc-price { font-size: 14px; font-weight: 900; color: #c026d3; }
</style>
