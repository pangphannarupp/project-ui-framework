<template>
  <div class="ev-home-view">
    <!-- Header -->
    <div class="greeting-area">
      <div class="top-row-header">
        <div class="user-greeting">
          <div class="ev-avatar">⚡</div>
          <div class="chat-bubbles">
            <div class="bubble small">{{ t.appName }}</div>
            <div class="bubble large">{{ userName }}</div>
          </div>
        </div>

        <div class="header-right-actions">
          <button class="wallet-btn" @click="$router.push('/my-tickets')" aria-label="Charging History">
            <span>🔋</span>
            <span class="count-badge" v-if="store.state.sessions.length > 0">{{ store.state.sessions.length }}</span>
          </button>
          <button class="lang-switch-btn" @click="showLangSheet = true">
            <span>{{ currentLangObj.flag }}</span>
          </button>
          <button class="exit-icon-btn" @click="showExitConfirm = true">✕</button>
        </div>
      </div>
    </div>

    <!-- Stations List -->
    <div class="content-scroll">
      <h3 class="section-title">⚡ {{ t.availableHubs }}</h3>

      <div class="stations-list">
        <div 
          v-for="st in EV_STATIONS" 
          :key="st.id"
          class="station-card"
          :class="{ selected: store.state.selectedStation.id === st.id }"
          @click="store.state.selectedStation = st"
        >
          <div class="st-top">
            <div>
              <span class="st-network">{{ st.network }}</span>
              <h4 class="st-name">{{ st.name }}</h4>
              <span class="st-addr">📍 {{ st.address }}</span>
            </div>
            <span class="st-power-badge">{{ st.speedKw }} kW DC</span>
          </div>

          <div class="st-connectors">
            <span v-for="c in st.connectorTypes" :key="c" class="c-tag">🔌 {{ c }}</span>
          </div>

          <div class="st-foot">
            <div class="rate-col">
              <span class="rate-val">${{ st.pricePerKwh.toFixed(2) }} / kWh</span>
              <span class="ports-avail">{{ st.availablePorts }}/{{ st.totalPorts }} Available</span>
            </div>
            <button class="btn-charge" @click.stop="selectStation(st)">Plug In & Charge →</button>
          </div>
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
import { useRouter } from 'vue-router'
import { PPBottomSheet, PPConfirm } from '@phanna/ui-framework'
import { useEVStore } from '../store/evStore'
import { EV_STATIONS } from '../data/evData'
import { useI18n } from '../i18n'
import type { EVStation } from '../types/ev'
import '@/lib/mini.app.lib.js'

const router = useRouter()
const MiniApp = (window as any).MiniApp
const store = useEVStore()
const { t, currentLanguage, currentLangObj, supportedLanguages, setLanguage } = useI18n()

const userName = ref('EV DRIVER GUEST')
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

const selectStation = (st: EVStation) => {
  store.state.selectedStation = st
  router.push('/checkout')
}

const confirmExit = () => {
  if (MiniApp?.exit) MiniApp.exit(false)
  else window.history.back()
}
</script>

<style scoped>
.ev-home-view { min-height: 100vh; background-color: #f8fafc; padding-bottom: 24px; }
.greeting-area { background: #ffffff; padding: 14px 16px; border-bottom: 1px solid #edf2f7; display: flex; flex-direction: column; gap: 12px; }
.top-row-header { display: flex; justify-content: space-between; align-items: center; }
.user-greeting { display: flex; align-items: center; gap: 10px; }
.ev-avatar { font-size: 24px; background: #10b981; width: 42px; height: 42px; border-radius: 12px; display: flex; align-items: center; justify-content: center; color: white; }
.bubble.small { font-size: 11px; color: #64748b; }
.bubble.large { font-size: 15px; font-weight: 800; }
.header-right-actions { display: flex; align-items: center; gap: 6px; }
.wallet-btn, .lang-switch-btn, .exit-icon-btn {
  background: #f1f5f9; border: 1px solid #e2e8f0; border-radius: 10px; height: 36px; padding: 0 10px; cursor: pointer;
}
.exit-icon-btn { background: #fee2e2; color: #ef4444; border: none; }

.content-scroll { padding: 14px 16px; }
.section-title { font-size: 14px; font-weight: 800; margin: 0 0 12px 0; }
.stations-list { display: flex; flex-direction: column; gap: 12px; }
.station-card {
  background: #ffffff; border-radius: 16px; border: 1px solid #e2e8f0; padding: 14px;
  display: flex; flex-direction: column; gap: 10px; cursor: pointer;
}
.station-card.selected { border-color: #10b981; box-shadow: 0 0 0 1px #10b981; }
.st-top { display: flex; justify-content: space-between; align-items: flex-start; }
.st-network { font-size: 10px; font-weight: 800; color: #059669; text-transform: uppercase; }
.st-name { font-size: 14px; font-weight: 800; margin: 2px 0; }
.st-addr { font-size: 11px; color: #64748b; }
.st-power-badge { background: #ecfdf5; color: #047857; font-size: 11px; font-weight: 800; padding: 3px 8px; border-radius: 6px; }

.st-connectors { display: flex; flex-wrap: wrap; gap: 6px; }
.c-tag { font-size: 10px; font-weight: 700; background: #f8fafc; border: 1px solid #e2e8f0; padding: 2px 6px; border-radius: 4px; color: #475569; }

.st-foot {
  display: flex; justify-content: space-between; align-items: center;
  border-top: 1px solid #f1f5f9; padding-top: 8px;
}
.rate-col { display: flex; flex-direction: column; }
.rate-val { font-size: 14px; font-weight: 900; color: #0f172a; }
.ports-avail { font-size: 10px; font-weight: 700; color: #10b981; }
.btn-charge {
  background: #10b981; color: white; border: none; padding: 8px 14px; border-radius: 8px; font-size: 12px; font-weight: 800; cursor: pointer;
}

.lang-sheet-box { padding: 16px 20px 24px 20px; }
.l-list { display: flex; flex-direction: column; gap: 8px; margin-top: 10px; }
.l-item { display: flex; justify-content: space-between; padding: 10px; border-radius: 10px; border: 1px solid #e2e8f0; cursor: pointer; }
.l-item.active { border-color: #10b981; background: #ecfdf5; color: #047857; font-weight: 700; }
</style>
