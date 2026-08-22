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

    <div class="content-scroll" v-if="record">
      <div class="conveyor-card">
        <div class="cc-top">
          <span class="cc-status">● CONVEYOR BARRIER ACTIVE</span>
          <h3 class="cc-bay">{{ record.bayAssigned }}</h3>
          <span class="cc-car">{{ record.vehiclePlate }} • {{ record.vehicleModel }}</span>
        </div>

        <div class="cc-body">
          <p class="cc-hint">Scan ticket at conveyor entry scanner to start auto-pull</p>
          <PPQRCode :value="record.qrValue" :size="140" foreground="#0c1821" background="#ffffff" />
          <span class="cc-code">{{ record.washTicket }}</span>
        </div>

        <div class="cc-foot">
          <span>{{ record.tier.name.en }} • ${{ record.totalPaid.toFixed(2) }}</span>
        </div>
      </div>

      <PPButton variant="primary" block size="large" @click="$router.push('/')">
        Back to Car Wash Home
      </PPButton>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import { PPQRCode, PPButton } from '@phanna/ui-framework'
import { useWashStore } from '../store/washStore'
import { useI18n } from '../i18n'
import type { CarWashRecord } from '../types/wash'

const route = useRoute()
const store = useWashStore()
const { t } = useI18n()
const record = ref<CarWashRecord | null>(null)

onMounted(() => {
  const id = route.params.id as string
  if (id) record.value = store.state.records.find(r => r.id === id) || null
  if (!record.value) record.value = store.state.currentRecord || store.state.records[0] || null
})
</script>

<style scoped>
.pass-view { min-height: 100vh; background-color: #0c1821; color: #ffffff; }
.nav-bar {
  display: flex; align-items: center; justify-content: space-between;
  padding: 12px 16px; background: #1b2a41; border-bottom: 1px solid #324a5f;
}
.nav-back-btn, .nav-exit-btn { background: none; border: none; cursor: pointer; color: white; }
.nav-title { margin: 0; font-size: 16px; font-weight: 800; }
.content-scroll { padding: 20px 16px; display: flex; flex-direction: column; gap: 16px; }

.conveyor-card {
  background: #1b2a41; border-radius: 20px; overflow: hidden;
  border: 1.5px solid #00b4d8; box-shadow: 0 10px 30px rgba(0,180,216,0.15); text-align: center;
}

.cc-top { background: #00b4d8; color: black; padding: 18px; }
.cc-status { font-size: 9px; font-weight: 900; background: rgba(0,0,0,0.15); padding: 3px 8px; border-radius: 4px; }
.cc-bay { font-size: 22px; font-weight: 900; margin: 6px 0 2px 0; }
.cc-car { font-size: 11px; font-weight: 800; }

.cc-body { padding: 20px 16px; display: flex; flex-direction: column; align-items: center; gap: 8px; background: #ffffff; }
.cc-hint { font-size: 11px; color: #64748b; margin: 0; max-width: 240px; }
.cc-code { font-family: monospace; font-size: 12px; font-weight: 900; color: #0c1821; }

.cc-foot { background: #1b2a41; padding: 12px; font-size: 11px; color: #cbd5e1; font-weight: 700; border-top: 1px solid #324a5f; }
</style>
