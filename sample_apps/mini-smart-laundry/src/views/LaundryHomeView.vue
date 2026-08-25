<template>
  <div class="laundromat-floor-root">
    <!-- Blueprint Top Header -->
    <header class="blueprint-header">
      <div class="header-main">
        <span class="bp-icon">🧼</span>
        <div class="bp-titles">
          <span class="bp-tag">FACILITY TELEMETRY & LIVE BAYS</span>
          <h1 class="bp-name">AQUA SMART LAUNDROMAT</h1>
        </div>
      </div>

      <div class="bp-actions">
        <button class="bp-pill" @click="showLangSheet = true">
          <span>{{ currentLangObj.flag }}</span>
          <span>{{ currentLangObj.code.toUpperCase() }}</span>
        </button>
        <button class="bp-pill drum-active-pill" @click="$router.push('/my-tickets')">
          <span>🧺</span>
          <span class="bubble-count" v-if="store.state.sessions.length > 0">{{ store.state.sessions.length }}</span>
        </button>
        <button class="bp-pill exit-pill" @click="showExitConfirm = true">✕</button>
      </div>
    </header>

    <main class="floorplan-container">
      <!-- Architectural Laundromat Bay Floor Layout -->
      <section class="floor-plan-map">
        <div class="map-legend-row">
          <span class="legend-title">🗺️ INTERACTIVE FLOOR PLAN</span>
          <div class="legend-keys">
            <span class="key-dot available">● Free</span>
            <span class="key-dot running">● Spinning</span>
          </div>
        </div>

        <div class="laundromat-bay-grid">
          <div 
            v-for="m in LAUNDRY_MACHINES" 
            :key="m.id"
            class="bay-station-pod"
            :class="{
              selected: store.state.selectedMachine.id === m.id,
              spinning: m.status === 'RUNNING'
            }"
            @click="selectBay(m)"
          >
            <div class="pod-header">
              <span class="pod-tag">{{ m.type === 'WASHER' ? '💧 WASH' : '💨 DRY' }}</span>
              <span class="pod-state" :class="m.status.toLowerCase()">{{ m.status === 'RUNNING' ? `${m.remainingMinutes}m` : 'IDLE' }}</span>
            </div>

            <!-- Rotating Drum Window -->
            <div class="drum-window-frame">
              <div class="inner-drum-rotor" :class="{ rotating: m.status === 'RUNNING' }">
                <span class="drum-water">{{ m.type === 'WASHER' ? '🫧' : '🌀' }}</span>
              </div>
            </div>

            <div class="pod-info">
              <span class="pod-num">{{ m.number }}</span>
              <span class="pod-cap">{{ m.capacityKg }}kg • ${{ m.pricePerCycle.toFixed(2) }}</span>
            </div>
          </div>
        </div>
      </section>

      <!-- Tactical Drum Sculptor Console (Configure Cycle) -->
      <section class="cycle-sculptor-panel">
        <div class="sculptor-box">
          <div class="sculptor-head">
            <div class="selected-bay-badge">
              <span class="sb-type">{{ store.state.selectedMachine.type }}</span>
              <h3 class="sb-name">{{ store.state.selectedMachine.number }} ({{ store.state.selectedMachine.capacityKg }}kg)</h3>
            </div>
            <span class="sb-price">${{ store.totalCost.value.toFixed(2) }}</span>
          </div>

          <!-- Water Temp Rotary Selector -->
          <div class="param-row">
            <span class="p-label">{{ t.waterTemp }}</span>
            <div class="dial-strip">
              <button 
                v-for="tmp in ['Cold (Eco)', 'Warm 40°C', 'Hot 60°C (Sanitize)']"
                :key="tmp"
                class="dial-pill"
                :class="{ active: store.state.config.waterTemp === tmp }"
                @click="store.state.config.waterTemp = tmp as any"
              >
                {{ tmp.split(' ')[0] }}
              </button>
            </div>
          </div>

          <!-- Spin Speed Extraction Dial -->
          <div class="param-row">
            <span class="p-label">{{ t.spinSpeed }}</span>
            <div class="dial-strip">
              <button 
                v-for="spd in ['Delicate (600 RPM)', 'Standard (1000 RPM)', 'Turbo (1400 RPM)']"
                :key="spd"
                class="dial-pill"
                :class="{ active: store.state.config.spinSpeed === spd }"
                @click="store.state.config.spinSpeed = spd as any"
              >
                {{ spd.split(' ')[0] }}
              </button>
            </div>
          </div>

          <!-- Addon Cards -->
          <div class="addons-grid">
            <div 
              class="addon-card" 
              :class="{ on: store.state.config.extraRinse }"
              @click="store.state.config.extraRinse = !store.state.config.extraRinse"
            >
              <span>💧 Extra Hygiene Rinse</span>
              <span class="addon-cost">+$0.50</span>
            </div>
            <div 
              class="addon-card" 
              :class="{ on: store.state.config.scentBooster }"
              @click="store.state.config.scentBooster = !store.state.config.scentBooster"
            >
              <span>🌸 Floral Scent Booster</span>
              <span class="addon-cost">+$0.50</span>
            </div>
          </div>
        </div>
      </section>
    </main>

    <!-- Floating Start Drum Bar -->
    <footer class="floor-floating-bar">
      <div class="bar-cost-col">
        <span class="b-lbl">Estimated Session Total</span>
        <span class="b-total">${{ store.totalCost.value.toFixed(2) }}</span>
      </div>
      <PPButton variant="primary" size="large" @click="handleLockAndStart" class="btn-drum-start">
        <span>Engage Drum & Pay ⚡</span>
      </PPButton>
    </footer>

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
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { PPBottomSheet, PPConfirm, PPButton } from '@phanna/ui-framework'
import { useLaundryStore } from '../store/laundryStore'
import { LAUNDRY_MACHINES } from '../data/laundryData'
import { useI18n } from '../i18n'
import type { LaundryMachine } from '../types/laundry'
import '@/lib/mini.app.lib.js'

const router = useRouter()
const MiniApp = (window as any).MiniApp
const store = useLaundryStore()
const { t, currentLanguage, currentLangObj, supportedLanguages, setLanguage } = useI18n()

const showLangSheet = ref(false)
const showExitConfirm = ref(false)

const selectBay = (m: LaundryMachine) => {
  if (m.status === 'RUNNING') return
  store.state.selectedMachine = m
}

const handleLockAndStart = () => {
  router.push('/checkout')
}

const confirmExit = () => {
  if (MiniApp?.exit) MiniApp.exit(false)
  else window.history.back()
}
</script>

<style scoped>
.laundromat-floor-root {
  min-height: 100vh;
  background: radial-gradient(circle at 50% 10%, #e0f2fe 0%, #bae6fd 100%);
  color: #0369a1;
  display: flex;
  flex-direction: column;
  padding-bottom: 96px;
}

/* Blueprint Header */
.blueprint-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px;
  background: rgba(255, 255, 255, 0.7);
  backdrop-filter: blur(10px);
  border-bottom: 1px solid rgba(255, 255, 255, 0.9);
}
.header-main { display: flex; align-items: center; gap: 10px; }
.bp-icon {
  font-size: 20px; background: #0284c7; color: white; width: 38px; height: 38px;
  border-radius: 12px; display: flex; align-items: center; justify-content: center;
  box-shadow: 0 4px 12px rgba(2,132,199,0.2);
}
.bp-titles { display: flex; flex-direction: column; }
.bp-tag { font-size: 8px; font-weight: 900; letter-spacing: 1.5px; color: #0284c7; }
.bp-name { font-size: 13px; font-weight: 900; margin: 0; color: #0c4a6e; }

.bp-actions { display: flex; gap: 6px; }
.bp-pill {
  background: rgba(255, 255, 255, 0.85);
  border: 1px solid rgba(255, 255, 255, 0.9);
  padding: 6px 12px;
  border-radius: 20px;
  font-size: 10px;
  font-weight: 800;
  color: #0369a1;
  cursor: pointer;
  display: flex;
  align-items: center;
  gap: 4px;
}
.drum-active-pill { position: relative; }
.bubble-count {
  position: absolute; top: -4px; right: -4px;
  background: #0284c7; color: white; font-size: 8px; font-weight: 900;
  width: 14px; height: 14px; border-radius: 50%; display: flex; align-items: center; justify-content: center;
}
.exit-pill { background: #fee2e2; color: #ef4444; border: none; }

.floorplan-container { padding: 16px; display: flex; flex-direction: column; gap: 16px; }

/* Interactive Floor Plan Map */
.map-legend-row { display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px; }
.legend-title { font-size: 11px; font-weight: 900; color: #0c4a6e; }
.legend-keys { display: flex; gap: 8px; font-size: 10px; font-weight: 800; }
.key-dot.available { color: #16a34a; }
.key-dot.running { color: #ea580c; }

.laundromat-bay-grid {
  display: grid; grid-template-columns: repeat(3, 1fr); gap: 10px;
}
.bay-station-pod {
  background: rgba(255, 255, 255, 0.85);
  backdrop-filter: blur(8px);
  border: 1.5px solid rgba(255, 255, 255, 0.9);
  border-radius: 16px;
  padding: 10px 8px;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 6px;
  cursor: pointer;
  transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
  box-shadow: 0 4px 12px rgba(3,105,161,0.06);
}
.bay-station-pod.selected {
  border-color: #0284c7;
  transform: translateY(-3px);
  box-shadow: 0 8px 20px rgba(2,132,199,0.25);
  background: #ffffff;
}
.bay-station-pod.spinning { opacity: 0.75; }

.pod-header { width: 100%; display: flex; justify-content: space-between; font-size: 8px; font-weight: 900; }
.pod-tag { color: #0284c7; }
.pod-state.available { color: #16a34a; }
.pod-state.running { color: #ea580c; }

.drum-window-frame {
  width: 52px; height: 52px; border-radius: 50%;
  border: 3px solid #7dd3fc;
  display: flex; align-items: center; justify-content: center;
  background: #f0f9ff;
}
.inner-drum-rotor { font-size: 20px; transition: transform 0.3s; }
.inner-drum-rotor.rotating { animation: spinRotor 1.8s linear infinite; }
@keyframes spinRotor { 100% { transform: rotate(360deg); } }

.pod-info { display: flex; flex-direction: column; align-items: center; }
.pod-num { font-size: 11px; font-weight: 900; color: #0c4a6e; }
.pod-cap { font-size: 8px; color: #64748b; font-weight: 700; }

/* Cycle Sculptor Panel */
.sculptor-box {
  background: rgba(255, 255, 255, 0.9);
  backdrop-filter: blur(12px);
  border: 1px solid rgba(255, 255, 255, 0.9);
  border-radius: 20px;
  padding: 16px;
  display: flex;
  flex-direction: column;
  gap: 12px;
  box-shadow: 0 8px 24px rgba(3,105,161,0.08);
}
.sculptor-head { display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #e0f2fe; padding-bottom: 8px; }
.sb-type { font-size: 8px; font-weight: 900; color: #0284c7; text-transform: uppercase; }
.sb-name { font-size: 14px; font-weight: 900; color: #0c4a6e; margin: 0; }
.sb-price { font-size: 18px; font-weight: 900; color: #0284c7; }

.param-row { display: flex; flex-direction: column; gap: 6px; }
.p-label { font-size: 9px; font-weight: 900; letter-spacing: 1px; color: #64748b; text-transform: uppercase; }
.dial-strip { display: flex; gap: 6px; }
.dial-pill {
  flex: 1; border: 1px solid #bae6fd; background: #f0f9ff; padding: 8px 4px;
  border-radius: 10px; font-size: 10px; font-weight: 800; color: #0369a1; cursor: pointer; text-align: center;
}
.dial-pill.active { background: #0284c7; color: white; border-color: #0284c7; }

.addons-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 8px; }
.addon-card {
  border: 1px solid #bae6fd; background: #f8fafc; border-radius: 12px; padding: 8px 10px;
  display: flex; flex-direction: column; font-size: 10px; font-weight: 800; color: #0369a1; cursor: pointer;
}
.addon-card.on { background: #e0f2fe; border-color: #0284c7; font-weight: 900; }
.addon-cost { font-size: 9px; color: #64748b; margin-top: 2px; }

/* Floating Bottom Bar */
.floor-floating-bar {
  position: fixed; bottom: 0; left: 0; right: 0;
  background: rgba(255, 255, 255, 0.9);
  backdrop-filter: blur(14px);
  border-top: 1px solid rgba(255, 255, 255, 0.9);
  padding: 14px 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  z-index: 90;
}
.bar-cost-col { display: flex; flex-direction: column; }
.b-lbl { font-size: 9px; font-weight: 800; color: #64748b; }
.b-total { font-size: 20px; font-weight: 900; color: #0c4a6e; }
.btn-drum-start { background: #0284c7 !important; border-color: #0284c7 !important; color: white !important; font-weight: 900 !important; }

.lang-sheet-box { padding: 16px 20px 24px 20px; }
.l-list { display: flex; flex-direction: column; gap: 8px; margin-top: 10px; }
.l-item { display: flex; justify-content: space-between; padding: 10px; border-radius: 10px; border: 1px solid #e0f2fe; cursor: pointer; }
.l-item.active { border-color: #0284c7; background: #e0f2fe; color: #0284c7; font-weight: 700; }
</style>
