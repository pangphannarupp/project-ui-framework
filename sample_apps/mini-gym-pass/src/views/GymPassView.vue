<template>
  <div class="pass-view">
    <div class="nav-bar">
      <button class="nav-back-btn" @click="$router.push('/')">
        <svg viewBox="0 0 24 24" width="22" height="22" stroke="currentColor" stroke-width="2.5" fill="none">
          <line x1="19" y1="12" x2="5" y2="12"></line>
          <polyline points="12 19 5 12 12 5"></polyline>
        </svg>
      </button>
      <h2 class="nav-title">Turnstile Access Pass</h2>
      <button class="nav-exit-btn" @click="$router.push('/')">✕</button>
    </div>

    <div class="content-scroll" v-if="pass">
      <div class="turnstile-card">
        <div class="tc-top">
          <span class="tc-status">● TURNSTILE SCANNER READY</span>
          <h3 class="tc-plan">{{ pass.planName }}</h3>
          <span class="tc-id">{{ pass.memberId }}</span>
        </div>

        <div class="tc-qr-body">
          <p class="tc-hint">Hold screen against turnstile reader for automatic unlock</p>
          <PPQRCode :value="pass.turnstileQr" :size="140" foreground="#09090b" background="#ffffff" />
          <span class="tc-code">{{ pass.passCode }}</span>
        </div>

        <div class="tc-foot">
          <span>{{ pass.validUntil }}</span>
        </div>
      </div>

      <PPButton variant="primary" block size="large" @click="$router.push('/')">
        Back to Fitness Home
      </PPButton>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import { PPQRCode, PPButton } from '@phanna/ui-framework'
import { useGymStore } from '../store/gymStore'
import type { GymMembershipRecord } from '../types/gym'

const route = useRoute()
const store = useGymStore()
const pass = ref<GymMembershipRecord | null>(null)

onMounted(() => {
  const id = route.params.id as string
  if (id) pass.value = store.state.passes.find(p => p.id === id) || null
  if (!pass.value) pass.value = store.state.currentPass || store.state.passes[0] || null
})
</script>

<style scoped>
.pass-view { min-height: 100vh; background-color: #09090b; color: #ffffff; }
.nav-bar {
  display: flex; align-items: center; justify-content: space-between;
  padding: 12px 16px; background: #18181b; border-bottom: 1px solid #27272a;
}
.nav-back-btn, .nav-exit-btn { background: none; border: none; cursor: pointer; color: white; }
.nav-title { margin: 0; font-size: 16px; font-weight: 800; }
.content-scroll { padding: 20px 16px; display: flex; flex-direction: column; gap: 16px; }

.turnstile-card {
  background: #18181b; border-radius: 20px; overflow: hidden;
  border: 1.5px solid #84cc16; box-shadow: 0 10px 30px rgba(132,204,22,0.15); text-align: center;
}

.tc-top { background: #84cc16; color: black; padding: 18px; }
.tc-status { font-size: 9px; font-weight: 900; background: rgba(0,0,0,0.15); padding: 3px 8px; border-radius: 4px; }
.tc-plan { font-size: 20px; font-weight: 900; margin: 6px 0 2px 0; }
.tc-id { font-size: 11px; font-weight: 800; font-family: monospace; }

.tc-qr-body { padding: 20px 16px; display: flex; flex-direction: column; align-items: center; gap: 8px; background: #ffffff; }
.tc-hint { font-size: 11px; color: #71717a; margin: 0; }
.tc-code { font-family: monospace; font-size: 12px; font-weight: 900; color: #09090b; }

.tc-foot { background: #18181b; padding: 12px; font-size: 11px; color: #a1a1aa; font-weight: 700; border-top: 1px solid #27272a; }
</style>
