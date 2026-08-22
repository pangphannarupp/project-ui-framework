<template>
  <div class="pass-view">
    <div class="nav-bar">
      <button class="nav-back-btn" @click="$router.push('/')">
        <svg viewBox="0 0 24 24" width="22" height="22" stroke="currentColor" stroke-width="2.5" fill="none">
          <line x1="19" y1="12" x2="5" y2="12"></line>
          <polyline points="12 19 5 12 12 5"></polyline>
        </svg>
      </button>
      <h2 class="nav-title">Locker Access Key</h2>
      <button class="nav-exit-btn" @click="$router.push('/')">✕</button>
    </div>

    <div class="content-scroll" v-if="action">
      <div class="locker-pass-card">
        <div class="lp-top">
          <span class="lp-status">🔓 COMPARTMENT DOOR POPPED OPEN</span>
          <h3 class="lp-bay">{{ action.lockerBay }}</h3>
          <span class="lp-size">{{ action.size }} COMPARTMENT</span>
        </div>

        <div class="lp-body">
          <div class="pin-box">
            <span class="pin-lbl">RECIPIENT PICKUP PIN</span>
            <h1 class="big-pin">{{ action.pinCode }}</h1>
          </div>
          <p class="lp-hint">Share this 4-digit PIN code with the recipient to collect the parcel</p>
          <PPQRCode :value="action.qrValue" :size="130" foreground="#0f172a" background="#ffffff" />
        </div>

        <div class="lp-foot">
          <span>Dropoff time: {{ action.createdAt }}</span>
        </div>
      </div>

      <PPButton variant="primary" block size="large" @click="$router.push('/')">
        Back to Locker Hub
      </PPButton>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import { PPQRCode, PPButton } from '@phanna/ui-framework'
import { useParcelStore } from '../store/parcelStore'
import type { ParcelActionRecord } from '../types/parcel'

const route = useRoute()
const store = useParcelStore()
const action = ref<ParcelActionRecord | null>(null)

onMounted(() => {
  const id = route.params.id as string
  if (id) action.value = store.state.actions.find(a => a.id === id) || null
  if (!action.value) action.value = store.state.currentAction || store.state.actions[0] || null
})
</script>

<style scoped>
.pass-view { min-height: 100vh; background-color: #f8fafc; color: #0f172a; }
.nav-bar {
  display: flex; align-items: center; justify-content: space-between;
  padding: 12px 16px; background: #ffffff; border-bottom: 1px solid #e2e8f0;
}
.nav-back-btn, .nav-exit-btn { background: none; border: none; cursor: pointer; color: #0f172a; }
.nav-title { margin: 0; font-size: 16px; font-weight: 800; }
.content-scroll { padding: 20px 16px; display: flex; flex-direction: column; gap: 16px; }

.locker-pass-card {
  background: #ffffff; border-radius: 20px; overflow: hidden;
  border: 1.5px solid #eab308; box-shadow: 0 10px 30px rgba(234,179,8,0.15); text-align: center;
}

.lp-top { background: #facc15; color: #0f172a; padding: 18px; }
.lp-status { font-size: 9px; font-weight: 900; background: rgba(0,0,0,0.1); padding: 3px 8px; border-radius: 4px; }
.lp-bay { font-size: 22px; font-weight: 900; margin: 6px 0 2px 0; }
.lp-size { font-size: 11px; font-weight: 800; }

.lp-body { padding: 20px 16px; display: flex; flex-direction: column; align-items: center; gap: 10px; }
.pin-box { background: #fef08a; padding: 12px 24px; border-radius: 12px; border: 1px dashed #ca8a04; }
.pin-lbl { font-size: 9px; font-weight: 900; color: #854d0e; }
.big-pin { font-size: 32px; font-weight: 900; letter-spacing: 8px; color: #0f172a; margin: 4px 0 0 0; }
.lp-hint { font-size: 11px; color: #64748b; margin: 0; max-width: 240px; }

.lp-foot { background: #f8fafc; padding: 12px; font-size: 11px; color: #64748b; font-weight: 700; border-top: 1px solid #e2e8f0; }
</style>
