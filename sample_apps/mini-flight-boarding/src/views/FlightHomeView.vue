<template>
  <div class="aviation-suite-root">
    <!-- Top Aviation Navigation Header -->
    <header class="flight-nav-header">
      <div class="flight-brand">
        <span class="plane-icon">✈️</span>
        <div class="flight-titles">
          <span class="flight-tag">SINGAPORE AIRLINES // SKYSUITE</span>
          <h1 class="flight-name">{{ store.state.flight.flightNumber }} ({{ store.state.flight.originCode }} → {{ store.state.flight.destCode }})</h1>
        </div>
      </div>

      <div class="flight-actions">
        <button class="flight-pill" @click="showLangSheet = true">
          <span>{{ currentLangObj.flag }}</span>
          <span>{{ currentLangObj.code.toUpperCase() }}</span>
        </button>
        <button class="flight-pill pass-pill" @click="$router.push('/my-tickets')">
          <span>🎟️</span>
          <span class="f-badge" v-if="store.state.boardingPasses.length > 0">{{ store.state.boardingPasses.length }}</span>
        </button>
        <button class="flight-pill exit-pill" @click="showExitConfirm = true">✕</button>
      </div>
    </header>

    <main class="aviation-viewport">
      <!-- Flight Route Telemetry Strip -->
      <section class="flight-route-strip">
        <div class="route-point">
          <span class="iata-code">{{ store.state.flight.originCode }}</span>
          <span class="city-name">{{ store.state.flight.originCity }}</span>
          <span class="dep-time">{{ store.state.flight.departureTime }}</span>
        </div>

        <div class="route-flight-path">
          <span class="plane-marker">✈️</span>
          <div class="dash-path"></div>
          <span class="duration-tag">13H 10M NON-STOP</span>
        </div>

        <div class="route-point right">
          <span class="iata-code">{{ store.state.flight.destCode }}</span>
          <span class="city-name">{{ store.state.flight.destCity }}</span>
          <span class="dep-time">{{ store.state.flight.arrivalTime }}</span>
        </div>
      </section>

      <!-- 3D Cabin Fuselage Seat Cross-Section Blueprint -->
      <section class="fuselage-cabin-stage">
        <div class="cabin-fuselage-frame">
          <div class="cockpit-nose">
            <span>✈️ NOSE // A380 UPPER DECK SUITES</span>
          </div>

          <div class="fuselage-seats-grid">
            <div 
              v-for="s in store.state.flight.seats"
              :key="s.seatNumber"
              class="seat-pod"
              :class="{
                occupied: s.isOccupied,
                selected: store.state.selectedSeat.seatNumber === s.seatNumber,
                first: s.cabinClass === 'FIRST',
                business: s.cabinClass === 'BUSINESS'
              }"
              @click="!s.isOccupied && (store.state.selectedSeat = s)"
            >
              <div class="seat-headrest"></div>
              <div class="seat-cushion">
                <span class="seat-num">{{ s.seatNumber }}</span>
                <span class="seat-type">{{ s.type === 'WINDOW' ? '🪟' : '🚶' }}</span>
              </div>
              <span class="seat-price">${{ s.price.toFixed(0) }}</span>
            </div>
          </div>

          <div class="fuselage-legend">
            <span>🪟 WINDOW SUITE • 🚪 SLIDING PRIVACY DOOR • 🛏️ FULL FLAT BED</span>
          </div>
        </div>
      </section>

      <!-- First Class Concierge & Lounge Deck -->
      <section class="lounge-perks-deck">
        <div class="lounge-card">
          <div class="lounge-row">
            <div class="l-left">
              <span class="l-tag">SILVERKRIS FIRST CLASS LOUNGE</span>
              <span class="l-desc">Private chef dining & private shower suite access</span>
            </div>
            <button 
              class="toggle-lounge-btn"
              :class="{ active: store.state.loungeAccess }"
              @click="store.state.loungeAccess = !store.state.loungeAccess"
            >
              {{ store.state.loungeAccess ? 'INCLUDED (+$45)' : 'ADD PASS' }}
            </button>
          </div>
        </div>
      </section>
    </main>

    <!-- Floating Boarding Pass Order Bar -->
    <footer class="aviation-floating-bar">
      <div class="fare-col">
        <span class="f-lbl">Suite Upgrade Total</span>
        <span class="f-total">${{ store.totalCost.value.toFixed(2) }}</span>
      </div>
      <PPButton variant="primary" size="large" @click="handleProceedToPass" class="btn-issue-boarding">
        <span>Lock Seat & Issue Pass 🎟️</span>
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
import { useFlightStore } from '../store/flightStore'
import { useI18n } from '../i18n'
import '@/lib/mini.app.lib.js'

const MiniApp = (window as any).MiniApp
const store = useFlightStore()
const { t, currentLanguage, currentLangObj, supportedLanguages, setLanguage } = useI18n()

const showLangSheet = ref(false)
const showExitConfirm = ref(false)

const handleProceedToPass = () => {
  router.push('/checkout')
}

const confirmExit = () => {
  if (MiniApp?.exit) MiniApp.exit(false)
  else window.history.back()
}
</script>

<style scoped>
.aviation-suite-root {
  min-height: 100vh;
  background-color: #0b1329;
  color: #f8fafc;
  display: flex;
  flex-direction: column;
  padding-bottom: 96px;
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
}

/* Flight Nav Header */
.flight-nav-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px;
  background: #101c3d;
  border-bottom: 2px solid #1e293b;
}
.flight-brand { display: flex; align-items: center; gap: 10px; }
.plane-icon {
  font-size: 18px; background: #d4af37; color: black; width: 36px; height: 36px;
  border-radius: 10px; display: flex; align-items: center; justify-content: center;
}
.flight-titles { display: flex; flex-direction: column; }
.flight-tag { font-size: 8px; font-weight: 900; letter-spacing: 1.5px; color: #d4af37; }
.flight-name { font-size: 13px; font-weight: 900; margin: 0; color: #ffffff; }

.flight-actions { display: flex; gap: 6px; }
.flight-pill {
  background: #1e293b;
  border: 1px solid #334155;
  padding: 6px 12px;
  border-radius: 20px;
  font-size: 10px;
  font-weight: 800;
  color: #d4af37;
  cursor: pointer;
  display: flex;
  align-items: center;
  gap: 4px;
}
.pass-pill { position: relative; }
.f-badge {
  position: absolute; top: -4px; right: -4px;
  background: #d4af37; color: black; font-size: 8px; font-weight: 900;
  width: 14px; height: 14px; border-radius: 50%; display: flex; align-items: center; justify-content: center;
}
.exit-pill { background: #450a0a; color: #ef4444; border: none; }

.aviation-viewport { padding: 16px; display: flex; flex-direction: column; gap: 14px; }

/* Flight Route Strip */
.flight-route-strip {
  background: #101c3d; border-radius: 18px; padding: 14px 16px; border: 1px solid #1e293b;
  display: flex; justify-content: space-between; align-items: center;
}
.route-point { display: flex; flex-direction: column; }
.route-point.right { text-align: right; }
.iata-code { font-size: 20px; font-weight: 900; color: #d4af37; font-family: monospace; }
.city-name { font-size: 9px; color: #94a3b8; }
.dep-time { font-size: 11px; font-weight: 800; color: #f8fafc; margin-top: 2px; }

.route-flight-path { display: flex; flex-direction: column; align-items: center; flex: 1; padding: 0 12px; }
.dash-path { width: 100%; height: 1px; border-bottom: 1.5px dashed #334155; margin: 4px 0; }
.duration-tag { font-size: 7px; font-weight: 800; color: #d4af37; }

/* Fuselage Cabin Stage */
.cabin-fuselage-frame {
  background: #101c3d; border: 2px solid #334155; border-radius: 24px; padding: 16px;
  display: flex; flex-direction: column; align-items: center; gap: 12px;
}
.cockpit-nose { font-size: 9px; font-weight: 900; color: #d4af37; letter-spacing: 1px; }

.fuselage-seats-grid {
  display: grid; grid-template-columns: repeat(2, 1fr); gap: 12px; width: 100%;
}
.seat-pod {
  background: #0b1329; border: 1.5px solid #1e293b; border-radius: 14px; padding: 10px;
  display: flex; flex-direction: column; align-items: center; gap: 4px; cursor: pointer; transition: all 0.3s;
}
.seat-pod.selected { border-color: #d4af37; box-shadow: 0 0 15px rgba(212,175,55,0.3); transform: translateY(-2px); }
.seat-pod.occupied { opacity: 0.4; cursor: not-allowed; }

.seat-headrest { width: 30px; height: 6px; background: #334155; border-radius: 3px; }
.seat-cushion { display: flex; gap: 6px; align-items: center; }
.seat-num { font-size: 13px; font-weight: 900; color: #ffffff; font-family: monospace; }
.seat-price { font-size: 10px; font-weight: 900; color: #d4af37; }

.fuselage-legend { font-size: 8px; font-weight: 800; color: #94a3b8; text-align: center; }

/* Lounge Perks */
.lounge-card { background: #101c3d; border-radius: 16px; padding: 14px; border: 1px solid #1e293b; }
.lounge-row { display: flex; justify-content: space-between; align-items: center; }
.l-left { display: flex; flex-direction: column; }
.l-tag { font-size: 10px; font-weight: 900; color: #d4af37; }
.l-desc { font-size: 9px; color: #94a3b8; }
.toggle-lounge-btn {
  border: 1px solid #334155; background: #0b1329; color: #94a3b8; padding: 6px 12px;
  border-radius: 8px; font-size: 10px; font-weight: 800; cursor: pointer;
}
.toggle-lounge-btn.active { background: #d4af37; color: black; border-color: #d4af37; }

/* Floating Bar */
.aviation-floating-bar {
  position: fixed; bottom: 0; left: 0; right: 0;
  background: rgba(16, 28, 61, 0.95);
  backdrop-filter: blur(14px);
  border-top: 1px solid #1e293b;
  padding: 14px 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  z-index: 90;
}
.fare-col { display: flex; flex-direction: column; }
.f-lbl { font-size: 9px; font-weight: 800; color: #94a3b8; }
.f-total { font-size: 20px; font-weight: 900; color: #d4af37; }
.btn-issue-boarding { background: #d4af37 !important; border-color: #d4af37 !important; color: black !important; font-weight: 900 !important; }

.lang-sheet-box { padding: 16px 20px 24px 20px; background: #101c3d; color: white; }
.l-list { display: flex; flex-direction: column; gap: 8px; margin-top: 10px; }
.l-item { display: flex; justify-content: space-between; padding: 10px; border-radius: 10px; border: 1px solid #1e293b; cursor: pointer; }
.l-item.active { border-color: #d4af37; background: #0b1329; color: #d4af37; font-weight: 700; }
</style>
