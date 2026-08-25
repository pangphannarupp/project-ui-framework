<template>
  <div class="scooter-volt-root">
    <!-- Top Volt Cyber Bar -->
    <header class="volt-header">
      <div class="volt-brand">
        <span class="bolt-icon">⚡</span>
        <div class="volt-titles">
          <span class="volt-tag">VOLT MICRO-MOBILITY GPS</span>
          <h1 class="volt-name">URBAN SCOOTER RADAR</h1>
        </div>
      </div>

      <div class="volt-actions">
        <button class="volt-pill" @click="showLangSheet = true">
          <span>{{ currentLangObj.flag }}</span>
          <span>{{ currentLangObj.code.toUpperCase() }}</span>
        </button>
        <button class="volt-pill helmet-pill" @click="$router.push('/my-tickets')">
          <span>🛵</span>
          <span class="v-badge" v-if="store.state.trips.length > 0">{{ store.state.trips.length }}</span>
        </button>
        <button class="volt-pill exit-pill" @click="showExitConfirm = true">✕</button>
      </div>
    </header>

    <main class="volt-viewport">
      <!-- GPS Proximity Radar Stage (Circular Radar Grid) -->
      <section class="radar-hud-stage">
        <div class="radar-screen">
          <div class="radar-grid-lines">
            <span class="ring r1"></span>
            <span class="ring r2"></span>
            <span class="ring r3"></span>
            <div class="crosshair-x"></div>
            <div class="crosshair-y"></div>
            <div class="radar-sweep-beam"></div>
          </div>

          <!-- User GPS Center Dot -->
          <div class="user-center-blip">
            <span class="user-pulse"></span>
            <span class="user-tag">YOU</span>
          </div>

          <!-- Nearby Scooter Blips -->
          <div 
            v-for="s in NEARBY_SCOOTERS"
            :key="s.id"
            class="scooter-blip"
            :class="{ active: store.state.selectedScooter.id === s.id }"
            :style="{ transform: `translate(${s.latOffset}px, ${s.lngOffset}px)` }"
            @click="store.state.selectedScooter = s"
          >
            <span class="blip-icon">🛴</span>
            <span class="blip-battery">{{ s.batteryPercent }}%</span>
          </div>
        </div>

        <div class="radar-telemetry-tag">
          <span>RADAR RANGE: 250M • 3 SCOOTERS DETECTED</span>
        </div>
      </section>

      <!-- Active Selected Scooter Telemetry Console -->
      <section class="scooter-telemetry-card">
        <div class="tc-top">
          <div class="tc-title-col">
            <span class="tc-tag">SELECTED SCOOTER</span>
            <h3 class="tc-code">{{ store.state.selectedScooter.code }}</h3>
            <span class="tc-model">{{ store.state.selectedScooter.model }}</span>
          </div>
          <div class="tc-battery-disc">
            <span class="tc-bat-num">{{ store.state.selectedScooter.batteryPercent }}%</span>
            <span class="tc-bat-lbl">BATTERY</span>
          </div>
        </div>

        <div class="tc-metrics-strip">
          <div class="m-box">
            <span class="m-val">{{ store.state.selectedScooter.rangeKm }} KM</span>
            <span class="m-lbl">EST. RANGE</span>
          </div>
          <div class="m-box">
            <span class="m-val">{{ store.state.selectedScooter.distanceMeters }} M</span>
            <span class="m-lbl">WALK DISTANCE</span>
          </div>
          <div class="m-box">
            <span class="m-val">${{ store.state.selectedScooter.pricePerMinute }}/m</span>
            <span class="m-lbl">RIDE RATE</span>
          </div>
        </div>

        <div class="safety-helmet-row">
          <span>🪖 HELMET LOCKER INCLUDED IN FOOTREST</span>
          <span class="ok-tag">PASSED INSPECTION</span>
        </div>
      </section>
    </main>

    <!-- Slide-to-Unlock Floating Bar -->
    <footer class="volt-floating-bar">
      <div class="cost-col">
        <span class="c-lbl">Unlock + Security Deposit</span>
        <span class="c-total">${{ store.initialCost.value.toFixed(2) }}</span>
      </div>
      <PPButton variant="primary" size="large" @click="handleUnlock" class="btn-unlock-scooter">
        <span>Slide to Unlock & Ride ⚡</span>
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
import { useScooterStore } from '../store/scooterStore'
import { NEARBY_SCOOTERS } from '../data/scooterData'
import { useI18n } from '../i18n'
import '@/lib/mini.app.lib.js'

const router = useRouter()
const MiniApp = (window as any).MiniApp
const store = useScooterStore()
const { t, currentLanguage, currentLangObj, supportedLanguages, setLanguage } = useI18n()

const showLangSheet = ref(false)
const showExitConfirm = ref(false)

const handleUnlock = () => {
  router.push('/checkout')
}

const confirmExit = () => {
  if (MiniApp?.exit) MiniApp.exit(false)
  else window.history.back()
}
</script>

<style scoped>
.scooter-volt-root {
  min-height: 100vh;
  background-color: #0b0f17;
  color: #f8fafc;
  display: flex;
  flex-direction: column;
  padding-bottom: 96px;
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
}

/* Volt Header */
.volt-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px;
  background: #111827;
  border-bottom: 2px solid #1f2937;
}
.volt-brand { display: flex; align-items: center; gap: 10px; }
.bolt-icon {
  font-size: 18px; background: #ccff00; color: black; width: 36px; height: 36px;
  border-radius: 10px; display: flex; align-items: center; justify-content: center;
  box-shadow: 0 0 15px rgba(204,255,0,0.4);
}
.volt-titles { display: flex; flex-direction: column; }
.volt-tag { font-size: 8px; font-weight: 900; letter-spacing: 1.5px; color: #ccff00; }
.volt-name { font-size: 13px; font-weight: 900; margin: 0; color: #ffffff; }

.volt-actions { display: flex; gap: 6px; }
.volt-pill {
  background: #1f2937;
  border: 1px solid #374151;
  padding: 6px 12px;
  border-radius: 20px;
  font-size: 10px;
  font-weight: 800;
  color: #ccff00;
  cursor: pointer;
  display: flex;
  align-items: center;
  gap: 4px;
}
.helmet-pill { position: relative; }
.v-badge {
  position: absolute; top: -4px; right: -4px;
  background: #ccff00; color: black; font-size: 8px; font-weight: 900;
  width: 14px; height: 14px; border-radius: 50%; display: flex; align-items: center; justify-content: center;
}
.exit-pill { background: #450a0a; color: #ef4444; border: none; }

.volt-viewport { padding: 16px; display: flex; flex-direction: column; gap: 14px; }

/* GPS Proximity Radar Screen */
.radar-screen {
  height: 220px;
  background: radial-gradient(circle at 50% 50%, #111827 0%, #030712 100%);
  border: 2px solid #1f2937;
  border-radius: 22px;
  position: relative;
  overflow: hidden;
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 0 0 25px rgba(0,0,0,0.5);
}
.radar-grid-lines { position: absolute; inset: 0; display: flex; align-items: center; justify-content: center; }
.ring { position: absolute; border-radius: 50%; border: 1px dashed rgba(204,255,0,0.15); }
.ring.r1 { width: 70px; height: 70px; }
.ring.r2 { width: 140px; height: 140px; }
.ring.r3 { width: 200px; height: 200px; }
.crosshair-x { position: absolute; left: 0; right: 0; height: 1px; background: rgba(204,255,0,0.1); }
.crosshair-y { position: absolute; top: 0; bottom: 0; width: 1px; background: rgba(204,255,0,0.1); }

.radar-sweep-beam {
  position: absolute; width: 110px; height: 110px; top: 0; left: 50%;
  transform-origin: bottom left;
  background: linear-gradient(45deg, rgba(204,255,0,0.2) 0%, transparent 80%);
  animation: sweepRadar 3s linear infinite;
}
@keyframes sweepRadar { 100% { transform: rotate(360deg); } }

.user-center-blip { position: relative; z-index: 10; display: flex; flex-direction: column; align-items: center; }
.user-pulse {
  width: 14px; height: 14px; border-radius: 50%; background: #3b82f6;
  box-shadow: 0 0 12px #3b82f6;
}
.user-tag { font-size: 8px; font-weight: 900; color: #93c5fd; margin-top: 2px; }

.scooter-blip {
  position: absolute; z-index: 10; cursor: pointer; display: flex; flex-direction: column; align-items: center;
  transition: transform 0.3s;
}
.scooter-blip.active { transform: scale(1.2); }
.blip-icon {
  font-size: 16px; background: #1f2937; border: 1.5px solid #ccff00; width: 28px; height: 28px;
  border-radius: 50%; display: flex; align-items: center; justify-content: center;
  box-shadow: 0 0 10px rgba(204,255,0,0.3);
}
.blip-battery { font-size: 7px; font-weight: 900; color: #ccff00; background: #030712; padding: 1px 3px; border-radius: 3px; margin-top: -3px; }

.radar-telemetry-tag { font-size: 8px; font-weight: 900; letter-spacing: 1px; color: #6b7280; text-align: center; margin-top: 6px; }

/* Telemetry Card */
.scooter-telemetry-card {
  background: #111827; border: 1.5px solid #1f2937; border-radius: 20px; padding: 16px;
  display: flex; flex-direction: column; gap: 12px;
}
.tc-top { display: flex; justify-content: space-between; align-items: center; }
.tc-title-col { display: flex; flex-direction: column; }
.tc-tag { font-size: 8px; font-weight: 900; color: #ccff00; letter-spacing: 1.5px; }
.tc-code { font-size: 18px; font-weight: 900; margin: 0; color: #ffffff; font-family: monospace; }
.tc-model { font-size: 10px; color: #9ca3af; }

.tc-battery-disc {
  width: 54px; height: 54px; border-radius: 50%; border: 3px solid #ccff00;
  display: flex; flex-direction: column; align-items: center; justify-content: center;
  box-shadow: 0 0 15px rgba(204,255,0,0.2);
}
.tc-bat-num { font-size: 13px; font-weight: 900; color: #ccff00; }
.tc-bat-lbl { font-size: 6px; color: #9ca3af; font-weight: 800; }

.tc-metrics-strip {
  display: grid; grid-template-columns: repeat(3, 1fr); gap: 8px; background: #0b0f17;
  padding: 10px; border-radius: 12px; border: 1px solid #1f2937;
}
.m-box { display: flex; flex-direction: column; align-items: center; }
.m-val { font-size: 12px; font-weight: 900; color: #f8fafc; }
.m-lbl { font-size: 7px; color: #6b7280; font-weight: 800; }

.safety-helmet-row {
  display: flex; justify-content: space-between; font-size: 9px; font-weight: 800; color: #9ca3af;
  border-top: 1px solid #1f2937; padding-top: 8px;
}
.ok-tag { color: #22c55e; }

/* Floating Bar */
.volt-floating-bar {
  position: fixed; bottom: 0; left: 0; right: 0;
  background: rgba(17, 24, 39, 0.95);
  backdrop-filter: blur(14px);
  border-top: 1px solid #1f2937;
  padding: 14px 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  z-index: 90;
}
.cost-col { display: flex; flex-direction: column; }
.c-lbl { font-size: 9px; font-weight: 800; color: #9ca3af; }
.c-total { font-size: 20px; font-weight: 900; color: #ccff00; }
.btn-unlock-scooter { background: #ccff00 !important; border-color: #ccff00 !important; color: black !important; font-weight: 900 !important; }

.lang-sheet-box { padding: 16px 20px 24px 20px; background: #111827; color: white; }
.l-list { display: flex; flex-direction: column; gap: 8px; margin-top: 10px; }
.l-item { display: flex; justify-content: space-between; padding: 10px; border-radius: 10px; border: 1px solid #1f2937; cursor: pointer; }
.l-item.active { border-color: #ccff00; background: #0b0f17; color: #ccff00; font-weight: 700; }
</style>
