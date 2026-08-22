<template>
  <div class="parking-home-view">
    <!-- Header -->
    <div class="greeting-area">
      <div class="top-row-header">
        <div class="user-greeting">
          <div class="park-avatar">🅿️</div>
          <div class="chat-bubbles">
            <div class="bubble small">{{ t.appName }}</div>
            <div class="bubble large">{{ userName }}</div>
          </div>
        </div>

        <div class="header-right-actions">
          <button class="wallet-btn" @click="$router.push('/my-tickets')">
            <span>🚗</span>
          </button>
          <button class="lang-switch-btn" @click="showLangSheet = true">
            <span>{{ currentLangObj.flag }}</span>
          </button>
          <button class="exit-icon-btn" @click="showExitConfirm = true">✕</button>
        </div>
      </div>

      <!-- Plate Search Box -->
      <div class="plate-search-card">
        <span class="ps-label">🔍 {{ t.plateSearch }}</span>
        <div class="ps-input-row">
          <PPInput v-model="store.state.plateInput" placeholder="2BK-8899" class="custom-pp-plate-input" />
          <PPButton variant="primary" size="medium" @click="store.searchPlate(store.state.plateInput)">Search</PPButton>
        </div>
      </div>
    </div>

    <!-- Active Parking Card -->
    <div class="content-scroll" v-if="store.state.activeSession">
      <div class="session-card">
        <div class="card-head">
          <div class="plate-badge">{{ store.state.activeSession.plateNumber }}</div>
          <span class="status-tag" :class="store.state.activeSession.status.toLowerCase()">
            {{ store.state.activeSession.status }}
          </span>
        </div>

        <div class="lot-location">
          <span>📍 {{ store.state.activeSession.location }}</span>
        </div>

        <div class="session-stats-grid">
          <div class="stat-box">
            <span class="s-lbl">ENTRY TIME</span>
            <span class="s-val">{{ store.state.activeSession.entryTime }}</span>
          </div>
          <div class="stat-box">
            <span class="s-lbl">DURATION</span>
            <span class="s-val highlight">{{ store.state.activeSession.durationHours }} Hours</span>
          </div>
          <div class="stat-box">
            <span class="s-lbl">RATE</span>
            <span class="s-val">${{ store.state.activeSession.hourlyRate.toFixed(2) }}/h</span>
          </div>
          <div class="stat-box">
            <span class="s-lbl">TOTAL FEE</span>
            <span class="s-val fee">${{ store.state.activeSession.totalFee.toFixed(2) }}</span>
          </div>
        </div>

        <button 
          v-if="store.state.activeSession.status === 'UNPAID'" 
          class="btn-pay-exit"
          @click="$router.push('/checkout')"
        >
          💳 {{ t.reviewAndPay }} (${{ store.state.activeSession.totalFee.toFixed(2) }})
        </button>
        <button 
          v-else 
          class="btn-view-pass"
          @click="$router.push('/confirmation')"
        >
          View Barrier Exit QR Code
        </button>
      </div>

      <!-- Season Pass Plans -->
      <div class="season-section">
        <h4 class="season-title">🎟️ Monthly Season Pass Topup</h4>
        <div class="season-card" v-for="plan in SEASON_PLANS" :key="plan.id">
          <div class="sc-left">
            <h5 class="sc-name">{{ plan.name }}</h5>
            <span class="sc-price">${{ plan.price.toFixed(2) }} / {{ plan.period }}</span>
          </div>
          <button class="btn-buy-pass" @click="$router.push('/checkout')">Subscribe</button>
        </div>
      </div>
    </div>

    <!-- PPBottomSheet Language -->
    <PPBottomSheet v-model="showLangSheet">
      <div class="lang-sheet-box">
        <h3>{{ t.selectLanguage }}</h3>
        <div class="l-list">
          <div 
            v-for="l in supportedLanguages" 
            :key="l.code"
            class="l-item"
            :class="{ active: currentLanguage === l.code }"
            @click="setLanguage(l.code); showLangSheet = false"
          >
            <span>{{ l.flag }} {{ l.name }}</span>
            <span v-if="currentLanguage === l.code">✓</span>
          </div>
        </div>
      </div>
    </PPBottomSheet>

    <!-- PPConfirm Exit -->
    <PPConfirm
      v-model="showExitConfirm"
      :title="t.exitTitle"
      :message="t.exitMessage"
      :confirmText="t.yesExit"
      :cancelText="t.stay"
      @confirm="confirmExit"
    />
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { PPBottomSheet, PPConfirm, PPInput, PPButton } from '@phanna/ui-framework'
import { useParkingStore } from '../store/parkingStore'
import { SEASON_PLANS } from '../data/parkingData'
import { useI18n } from '../i18n'
import '@/lib/mini.app.lib.js'

const MiniApp = (window as any).MiniApp
const store = useParkingStore()
const { t, currentLanguage, currentLangObj, supportedLanguages, setLanguage } = useI18n()

const userName = ref('DRIVER GUEST')
const showLangSheet = ref(false)
const showExitConfirm = ref(false)

onMounted(async () => {
  try {
    if (MiniApp && typeof MiniApp.getUserProfile === 'function') {
      const p = await MiniApp.getUserProfile()
      if (p?.name) userName.value = p.name
    }
  } catch (e) {}
})

const confirmExit = () => {
  if (MiniApp?.exit) MiniApp.exit(false)
  else window.history.back()
}
</script>

<style scoped>
.parking-home-view { min-height: 100vh; background-color: #f8fafc; padding-bottom: 24px; }
.greeting-area { background: #ffffff; padding: 14px 16px; border-bottom: 1px solid #edf2f7; display: flex; flex-direction: column; gap: 12px; }
.top-row-header { display: flex; justify-content: space-between; align-items: center; }
.user-greeting { display: flex; align-items: center; gap: 10px; }
.park-avatar { font-size: 24px; background: #0284c7; width: 42px; height: 42px; border-radius: 12px; display: flex; align-items: center; justify-content: center; }
.bubble.small { font-size: 11px; color: #64748b; }
.bubble.large { font-size: 15px; font-weight: 800; }
.header-right-actions { display: flex; align-items: center; gap: 6px; }
.wallet-btn, .lang-switch-btn, .exit-icon-btn {
  background: #f1f5f9; border: 1px solid #e2e8f0; border-radius: 10px; height: 36px; padding: 0 10px; cursor: pointer;
}
.exit-icon-btn { background: #fee2e2; color: #ef4444; border: none; }

.plate-search-card { background: #f0f9ff; border: 1px solid #bae6fd; border-radius: 14px; padding: 12px; }
.ps-label { font-size: 11px; font-weight: 800; color: #0369a1; display: block; margin-bottom: 6px; }
.ps-input-row { display: flex; gap: 8px; }
.plate-field {
  flex: 1; padding: 8px 12px; border-radius: 8px; border: 1.5px solid #7dd3fc;
  font-size: 14px; font-weight: 900; text-transform: uppercase; background: #ffffff; outline: none;
}
.btn-search-plate {
  background: #0284c7; color: white; border: none; padding: 8px 16px; border-radius: 8px; font-weight: 800; font-size: 12px; cursor: pointer;
}

.content-scroll { padding: 14px 16px; display: flex; flex-direction: column; gap: 14px; }
.session-card {
  background: #ffffff; border-radius: 16px; border: 1px solid #e2e8f0; padding: 16px; display: flex; flex-direction: column; gap: 12px;
}
.card-head { display: flex; justify-content: space-between; align-items: center; }
.plate-badge {
  background: #0f172a; color: #ffffff; font-family: monospace; font-size: 16px; font-weight: 900;
  padding: 4px 12px; border-radius: 8px; border: 2px solid #334155;
}
.status-tag { font-size: 10px; font-weight: 800; padding: 3px 8px; border-radius: 6px; }
.status-tag.unpaid { background: #fee2e2; color: #dc2626; }
.status-tag.paid { background: #dcfce7; color: #166534; }
.lot-location { font-size: 12px; color: #64748b; font-weight: 700; }

.session-stats-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 8px; }
.stat-box { background: #f8fafc; padding: 10px; border-radius: 10px; border: 1px solid #e2e8f0; display: flex; flex-direction: column; }
.s-lbl { font-size: 9px; font-weight: 800; color: #94a3b8; }
.s-val { font-size: 13px; font-weight: 800; color: #0f172a; }
.s-val.highlight { color: #0284c7; }
.s-val.fee { color: #dc2626; font-size: 16px; }

.btn-pay-exit {
  background: linear-gradient(135deg, #0284c7 0%, #0369a1 100%);
  color: white; border: none; padding: 12px; border-radius: 12px; font-size: 14px; font-weight: 800; cursor: pointer;
}
.btn-view-pass {
  background: #10b981; color: white; border: none; padding: 12px; border-radius: 12px; font-size: 14px; font-weight: 800; cursor: pointer;
}

.season-section { display: flex; flex-direction: column; gap: 10px; margin-top: 6px; }
.season-title { font-size: 13px; font-weight: 800; margin: 0; color: #0f172a; }
.season-card {
  background: #ffffff; border-radius: 14px; border: 1px solid #e2e8f0; padding: 12px 14px;
  display: flex; justify-content: space-between; align-items: center;
}
.sc-name { font-size: 13px; font-weight: 800; margin: 0 0 2px 0; }
.sc-price { font-size: 12px; color: #0284c7; font-weight: 800; }
.btn-buy-pass {
  background: #f1f5f9; border: 1px solid #cbd5e1; font-size: 11px; font-weight: 700; padding: 6px 12px; border-radius: 8px; cursor: pointer;
}

.lang-sheet-box { padding: 16px 20px 24px 20px; }
.l-list { display: flex; flex-direction: column; gap: 8px; margin-top: 10px; }
.l-item { display: flex; justify-content: space-between; padding: 10px; border-radius: 10px; border: 1px solid #e2e8f0; cursor: pointer; }
.l-item.active { border-color: #0284c7; background: #f0f9ff; color: #0369a1; font-weight: 700; }
</style>
