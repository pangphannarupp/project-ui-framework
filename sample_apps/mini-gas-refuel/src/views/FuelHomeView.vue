<template>
  <div class="gas-nitro-root">
    <!-- Top Nitro Station Navigation -->
    <header class="nitro-header">
      <div class="nitro-brand">
        <span class="pump-icon">⛽</span>
        <div class="nitro-titles">
          <span class="nitro-tag">STATION ISLAND BAY #01</span>
          <h1 class="nitro-name">NITRO SMART REFUEL</h1>
        </div>
      </div>

      <div class="nitro-actions">
        <button class="nitro-pill" @click="showLangSheet = true">
          <span>{{ currentLangObj.flag }}</span>
          <span>{{ currentLangObj.code.toUpperCase() }}</span>
        </button>
        <button class="nitro-pill drop-pill" @click="$router.push('/my-tickets')">
          <span>🧾</span>
          <span class="n-badge" v-if="store.state.transactions.length > 0">{{ store.state.transactions.length }}</span>
        </button>
        <button class="nitro-pill exit-pill" @click="showExitConfirm = true">✕</button>
      </div>
    </header>

    <main class="nitro-viewport">
      <!-- Station Island Pump Matrix Blueprint -->
      <section class="pump-matrix-stage">
        <div class="stage-tag-row">
          <span class="s-tag">1. SELECT ISLAND PUMP BAY</span>
          <span class="s-live">🟢 PUMPS READY</span>
        </div>

        <div class="pumps-island-grid">
          <div 
            v-for="p in FUEL_PUMPS" 
            :key="p.id"
            class="pump-bay-pod"
            :class="{
              selected: store.state.selectedPump.id === p.id,
              occupied: p.status === 'OCCUPIED'
            }"
            @click="p.status !== 'OCCUPIED' && (store.state.selectedPump = p)"
          >
            <div class="pump-nozzle-head"></div>
            <div class="pump-display-screen">
              <span class="p-num">PUMP 0{{ p.pumpNumber }}</span>
              <span class="p-stat" :class="p.status.toLowerCase()">{{ p.status }}</span>
            </div>
          </div>
        </div>
      </section>

      <!-- Fuel Grade Octane Selector -->
      <section class="octane-selector-section">
        <span class="s-tag">2. CHOOSE FUEL OCTANE GRADE</span>
        <div class="octane-cards-deck">
          <div 
            v-for="g in FUEL_GRADES" 
            :key="g.id"
            class="octane-card"
            :class="{ active: store.state.selectedGrade.id === g.id }"
            @click="store.state.selectedGrade = g"
          >
            <div class="oct-badge" :style="{ background: g.badgeColor }">
              {{ g.octane }} OCTANE
            </div>
            <h4 class="oct-name">{{ g.name }}</h4>
            <span class="oct-price">${{ g.pricePerLiter.toFixed(2) }} / Liter</span>
          </div>
        </div>
      </section>

      <!-- Smart Fuel Meter Dispenser Console (Preset Dollars / Liters) -->
      <section class="dispenser-console-card">
        <div class="dispenser-head">
          <span class="s-tag">3. FUEL DISPENSER AMOUNT</span>
          <span class="liters-live">{{ store.calculatedLiters.value.toFixed(2) }} LITERS</span>
        </div>

        <div class="dispenser-digits-display">
          <span class="currency-sym">$</span>
          <span class="dollars-big">{{ store.state.fuelPresetDollars.toFixed(2) }}</span>
        </div>

        <!-- Preset Amount Pills -->
        <div class="preset-dollar-pills">
          <button 
            v-for="amt in [10, 20, 30, 50, 75]" 
            :key="amt"
            class="p-pill"
            :class="{ active: store.state.fuelPresetDollars === amt }"
            @click="store.state.fuelPresetDollars = amt"
          >
            ${{ amt }}
          </button>
        </div>
      </section>
    </main>

    <!-- Floating Dispense Fuel Bar -->
    <footer class="nitro-floating-bar">
      <div class="dispense-col">
        <span class="d-lbl">Pump #0{{ store.state.selectedPump.pumpNumber }} • {{ store.calculatedLiters.value.toFixed(1) }}L {{ store.state.selectedGrade.name }}</span>
        <span class="d-total">${{ store.state.fuelPresetDollars.toFixed(2) }}</span>
      </div>
      <PPButton variant="primary" size="large" @click="handleProceedToFuel" class="btn-authorize-pump">
        <span>Authorize & Dispense ⚡</span>
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
import { useFuelStore } from '../store/fuelStore'
import { FUEL_PUMPS, FUEL_GRADES } from '../data/fuelData'
import { useI18n } from '../i18n'
import '@/lib/mini.app.lib.js'

const MiniApp = (window as any).MiniApp
const store = useFuelStore()
const { t, currentLanguage, currentLangObj, supportedLanguages, setLanguage } = useI18n()

const showLangSheet = ref(false)
const showExitConfirm = ref(false)

const handleProceedToFuel = () => {
  router.push('/checkout')
}

const confirmExit = () => {
  if (MiniApp?.exit) MiniApp.exit(false)
  else window.history.back()
}
</script>

<style scoped>
.gas-nitro-root {
  min-height: 100vh;
  background-color: #0c0a09;
  color: #fafaf9;
  display: flex;
  flex-direction: column;
  padding-bottom: 96px;
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
}

/* Nitro Header */
.nitro-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px;
  background: #1c1917;
  border-bottom: 2px solid #292524;
}
.nitro-brand { display: flex; align-items: center; gap: 10px; }
.pump-icon {
  font-size: 18px; background: #f59e0b; color: black; width: 36px; height: 36px;
  border-radius: 10px; display: flex; align-items: center; justify-content: center;
}
.nitro-titles { display: flex; flex-direction: column; }
.nitro-tag { font-size: 8px; font-weight: 900; letter-spacing: 1.5px; color: #f59e0b; }
.nitro-name { font-size: 13px; font-weight: 900; margin: 0; color: #ffffff; }

.nitro-actions { display: flex; gap: 6px; }
.nitro-pill {
  background: #292524;
  border: 1px solid #44403c;
  padding: 6px 12px;
  border-radius: 20px;
  font-size: 10px;
  font-weight: 800;
  color: #f59e0b;
  cursor: pointer;
  display: flex;
  align-items: center;
  gap: 4px;
}
.drop-pill { position: relative; }
.n-badge {
  position: absolute; top: -4px; right: -4px;
  background: #f59e0b; color: black; font-size: 8px; font-weight: 900;
  width: 14px; height: 14px; border-radius: 50%; display: flex; align-items: center; justify-content: center;
}
.exit-pill { background: #450a0a; color: #ef4444; border: none; }

.nitro-viewport { padding: 16px; display: flex; flex-direction: column; gap: 14px; }
.s-tag { font-size: 9px; font-weight: 900; letter-spacing: 1px; color: #a8a29e; }
.stage-tag-row { display: flex; justify-content: space-between; align-items: center; }
.s-live { font-size: 8px; font-weight: 800; color: #22c55e; }

/* Pumps Island Grid */
.pumps-island-grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 10px; }
.pump-bay-pod {
  background: #1c1917; border: 2px solid #292524; border-radius: 16px; padding: 12px;
  display: flex; flex-direction: column; align-items: center; gap: 6px; cursor: pointer; transition: all 0.2s;
}
.pump-bay-pod.selected { border-color: #f59e0b; box-shadow: 0 0 15px rgba(245,158,11,0.3); transform: translateY(-2px); }
.pump-bay-pod.occupied { opacity: 0.4; cursor: not-allowed; }

.pump-nozzle-head { width: 30px; height: 6px; background: #44403c; border-radius: 3px; }
.pump-display-screen { display: flex; flex-direction: column; align-items: center; }
.p-num { font-size: 14px; font-weight: 900; color: #ffffff; font-family: monospace; }
.p-stat { font-size: 8px; font-weight: 800; }
.p-stat.available { color: #22c55e; }
.p-stat.occupied { color: #ef4444; }

/* Octane Cards */
.octane-cards-deck { display: flex; flex-direction: column; gap: 8px; }
.octane-card {
  background: #1c1917; border: 1.5px solid #292524; border-radius: 14px; padding: 12px;
  display: flex; justify-content: space-between; align-items: center; cursor: pointer; transition: all 0.2s;
}
.octane-card.active { border-color: #f59e0b; background: #292524; }
.oct-badge { font-size: 8px; font-weight: 900; color: white; padding: 3px 6px; border-radius: 4px; }
.oct-name { font-size: 12px; font-weight: 900; margin: 0; color: #ffffff; flex: 1; margin-left: 10px; }
.oct-price { font-size: 11px; font-weight: 900; color: #f59e0b; }

/* Dispenser Console */
.dispenser-console-card {
  background: #1c1917; border: 1.5px solid #292524; border-radius: 18px; padding: 16px;
  display: flex; flex-direction: column; gap: 10px;
}
.dispenser-head { display: flex; justify-content: space-between; align-items: center; }
.liters-live { font-size: 12px; font-weight: 900; color: #f59e0b; font-family: monospace; }

.dispenser-digits-display {
  background: #0c0a09; border: 1.5px solid #292524; border-radius: 14px; padding: 14px;
  display: flex; justify-content: center; align-items: baseline; gap: 4px;
}
.currency-sym { font-size: 20px; font-weight: 900; color: #f59e0b; }
.dollars-big { font-size: 36px; font-weight: 900; color: #ffffff; font-family: monospace; }

.preset-dollar-pills { display: flex; gap: 6px; }
.p-pill {
  flex: 1; border: 1px solid #44403c; background: #292524; color: #fafaf9; padding: 8px 0;
  border-radius: 8px; font-size: 11px; font-weight: 900; cursor: pointer; text-align: center;
}
.p-pill.active { background: #f59e0b; color: black; border-color: #f59e0b; }

/* Floating Bar */
.nitro-floating-bar {
  position: fixed; bottom: 0; left: 0; right: 0;
  background: rgba(28, 25, 23, 0.95);
  backdrop-filter: blur(14px);
  border-top: 1px solid #292524;
  padding: 14px 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  z-index: 90;
}
.dispense-col { display: flex; flex-direction: column; }
.d-lbl { font-size: 9px; font-weight: 800; color: #a8a29e; }
.d-total { font-size: 20px; font-weight: 900; color: #f59e0b; }
.btn-authorize-pump { background: #f59e0b !important; border-color: #f59e0b !important; color: black !important; font-weight: 900 !important; }

.lang-sheet-box { padding: 16px 20px 24px 20px; background: #1c1917; color: white; }
.l-list { display: flex; flex-direction: column; gap: 8px; margin-top: 10px; }
.l-item { display: flex; justify-content: space-between; padding: 10px; border-radius: 10px; border: 1px solid #292524; cursor: pointer; }
.l-item.active { border-color: #f59e0b; background: #0c0a09; color: #f59e0b; font-weight: 700; }
</style>
