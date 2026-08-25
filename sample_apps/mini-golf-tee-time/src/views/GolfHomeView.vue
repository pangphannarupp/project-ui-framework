<template>
  <div class="golf-augusta-root">
    <!-- Top Augusta Golf Navigation Header -->
    <header class="golf-nav-header">
      <div class="golf-brand">
        <span class="flag-icon">⛳</span>
        <div class="golf-titles">
          <span class="golf-tag">CHAMPIONSHIP COURSE // EST. 1934</span>
          <h1 class="golf-name">AUGUSTA LINKS GOLF CLUB</h1>
        </div>
      </div>

      <div class="golf-actions">
        <button class="golf-pill" @click="showLangSheet = true">
          <span>{{ currentLangObj.flag }}</span>
          <span>{{ currentLangObj.code.toUpperCase() }}</span>
        </button>
        <button class="golf-pill tee-pill" @click="$router.push('/my-tickets')">
          <span>🏌️</span>
          <span class="g-badge" v-if="store.state.bookings.length > 0">{{ store.state.bookings.length }}</span>
        </button>
        <button class="golf-pill exit-pill" @click="showExitConfirm = true">✕</button>
      </div>
    </header>

    <main class="golf-viewport">
      <!-- 18-Hole Topographic Fairway Map Stage -->
      <section class="fairway-topography-stage">
        <div class="topography-frame">
          <div class="hole-header-row">
            <span class="h-title">HOLE #{{ store.state.selectedHole.holeNumber }} // PAR {{ store.state.selectedHole.par }}</span>
            <span class="h-yards">📐 {{ store.state.selectedHole.distanceYards }} YARDS</span>
          </div>

          <!-- Topographic Map Canvas -->
          <div class="green-terrain-visual">
            <div class="sand-trap trap-left"><span>SAND</span></div>
            <div class="fairway-strip">
              <span class="tee-marker">⚪ TEE</span>
              <div class="ball-trajectory"></div>
              <span class="pin-flag">⛳ PIN</span>
            </div>
            <div class="sand-trap trap-right"><span>WATER</span></div>
          </div>

          <div class="weather-wind-hud">
            <span>💨 WIND: 8 KTS NE</span>
            <span>⚡ STIMP: {{ store.state.selectedHole.stimpMeterSpeed }} FAST</span>
            <span>☀️ SUNSET: 6:45 PM</span>
          </div>
        </div>

        <!-- Hole Selector Deck -->
        <div class="hole-selector-pills">
          <button 
            v-for="h in GOLF_HOLES" 
            :key="h.holeNumber"
            class="h-pill"
            :class="{ active: store.state.selectedHole.holeNumber === h.holeNumber }"
            @click="store.state.selectedHole = h"
          >
            Hole {{ h.holeNumber }}
          </button>
        </div>
      </section>

      <!-- Round Customizer Console (Holes, Players, Caddie) -->
      <section class="round-customizer-card">
        <div class="round-row">
          <span class="r-label">COURSE ROUND</span>
          <div class="round-segmented">
            <button 
              class="seg-btn"
              :class="{ active: store.state.holesCount === 9 }"
              @click="store.state.holesCount = 9"
            >
              9 Holes ($55/ea)
            </button>
            <button 
              class="seg-btn"
              :class="{ active: store.state.holesCount === 18 }"
              @click="store.state.holesCount = 18"
            >
              18 Holes ($95/ea)
            </button>
          </div>
        </div>

        <div class="round-row">
          <span class="r-label">PLAYERS IN FLIGHT</span>
          <div class="player-stepper">
            <button class="step-b" @click="store.state.playersCount = Math.max(1, store.state.playersCount - 1)">-</button>
            <span class="player-num">{{ store.state.playersCount }} GOLFERS</span>
            <button class="step-b" @click="store.state.playersCount = Math.min(4, store.state.playersCount + 1)">+</button>
          </div>
        </div>

        <div class="caddie-section">
          <span class="r-label">ASSIGN MASTER CADDIE</span>
          <div class="caddie-options-deck">
            <div 
              v-for="c in CADDIES" 
              :key="c.id"
              class="caddie-pod"
              :class="{ active: store.state.selectedCaddie?.id === c.id }"
              @click="store.state.selectedCaddie = c"
            >
              <div class="c-top">
                <span class="c-name">{{ c.name }}</span>
                <span class="c-fee">+${{ c.fee }}</span>
              </div>
              <span class="c-spec">{{ c.specialty }}</span>
            </div>
          </div>
        </div>
      </section>
    </main>

    <!-- Floating Tee-Time Order Bar -->
    <footer class="golf-floating-bar">
      <div class="fee-col">
        <span class="f-lbl">{{ store.state.playersCount }} Golfers • {{ store.state.holesCount }} Holes</span>
        <span class="f-total">${{ store.baseGreenFee.value.toFixed(2) }}</span>
      </div>
      <PPButton variant="primary" size="large" @click="handleProceedToTeeTime" class="btn-lock-tee">
        <span>Reserve Tee-Time ⛳</span>
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
import { useGolfStore } from '../store/golfStore'
import { GOLF_HOLES, CADDIES } from '../data/golfData'
import { useI18n } from '../i18n'
import '@/lib/mini.app.lib.js'

const router = useRouter()
const MiniApp = (window as any).MiniApp
const store = useGolfStore()
const { t, currentLanguage, currentLangObj, supportedLanguages, setLanguage } = useI18n()

const showLangSheet = ref(false)
const showExitConfirm = ref(false)

const handleProceedToTeeTime = () => {
  router.push('/checkout')
}

const confirmExit = () => {
  if (MiniApp?.exit) MiniApp.exit(false)
  else window.history.back()
}
</script>

<style scoped>
.golf-augusta-root {
  min-height: 100vh;
  background: radial-gradient(circle at 50% 10%, #0d2818 0%, #05140c 100%);
  color: #f8fafc;
  display: flex;
  flex-direction: column;
  padding-bottom: 96px;
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
}

/* Golf Nav Header */
.golf-nav-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px;
  background: #091d12;
  border-bottom: 2px solid #1c402b;
}
.golf-brand { display: flex; align-items: center; gap: 10px; }
.flag-icon {
  font-size: 18px; background: #d4af37; color: black; width: 36px; height: 36px;
  border-radius: 10px; display: flex; align-items: center; justify-content: center;
}
.golf-titles { display: flex; flex-direction: column; }
.golf-tag { font-size: 8px; font-weight: 900; letter-spacing: 1.5px; color: #d4af37; }
.golf-name { font-size: 13px; font-weight: 900; margin: 0; color: #ffffff; }

.golf-actions { display: flex; gap: 6px; }
.golf-pill {
  background: #133320;
  border: 1px solid #1c402b;
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
.tee-pill { position: relative; }
.g-badge {
  position: absolute; top: -4px; right: -4px;
  background: #d4af37; color: black; font-size: 8px; font-weight: 900;
  width: 14px; height: 14px; border-radius: 50%; display: flex; align-items: center; justify-content: center;
}
.exit-pill { background: #450a0a; color: #ef4444; border: none; }

.golf-viewport { padding: 16px; display: flex; flex-direction: column; gap: 14px; }

/* Fairway Topography Stage */
.topography-frame {
  background: #091d12; border: 2px solid #1c402b; border-radius: 20px; padding: 16px;
  display: flex; flex-direction: column; gap: 12px; box-shadow: 0 10px 25px rgba(0,0,0,0.4);
}
.hole-header-row { display: flex; justify-content: space-between; align-items: center; }
.h-title { font-size: 12px; font-weight: 900; color: #d4af37; }
.h-yards { font-size: 10px; color: #a7f3d0; font-weight: 800; }

.green-terrain-visual {
  height: 120px; background: #133320; border-radius: 14px; border: 1px dashed #1c402b;
  display: flex; justify-content: space-between; align-items: center; padding: 0 20px; position: relative;
}
.sand-trap { font-size: 8px; font-weight: 900; background: #b45309; color: #fde68a; padding: 4px 8px; border-radius: 12px; }
.fairway-strip { display: flex; align-items: center; gap: 10px; flex: 1; justify-content: space-around; }
.ball-trajectory { height: 1px; flex: 1; border-bottom: 2px dashed #d4af37; margin: 0 10px; }
.tee-marker { font-size: 10px; font-weight: 900; color: #f8fafc; }
.pin-flag { font-size: 14px; }

.weather-wind-hud {
  display: flex; justify-content: space-between; font-size: 8px; font-weight: 900; color: #6ee7b7;
  border-top: 1px solid #1c402b; padding-top: 8px;
}

.hole-selector-pills { display: flex; gap: 8px; overflow-x: auto; padding: 4px 0; }
.h-pill {
  border: 1px solid #1c402b; background: #091d12; color: #a7f3d0; padding: 6px 14px;
  border-radius: 12px; font-size: 10px; font-weight: 800; cursor: pointer; white-space: nowrap;
}
.h-pill.active { background: #d4af37; color: black; border-color: #d4af37; font-weight: 900; }

/* Customizer Card */
.round-customizer-card {
  background: #091d12; border-radius: 18px; padding: 16px; border: 1px solid #1c402b;
  display: flex; flex-direction: column; gap: 14px;
}
.round-row { display: flex; justify-content: space-between; align-items: center; }
.r-label { font-size: 9px; font-weight: 900; letter-spacing: 1px; color: #a7f3d0; }

.round-segmented { display: flex; gap: 6px; }
.seg-btn {
  border: 1px solid #1c402b; background: #133320; color: #f8fafc; padding: 6px 10px;
  border-radius: 8px; font-size: 10px; font-weight: 800; cursor: pointer;
}
.seg-btn.active { background: #d4af37; color: black; border-color: #d4af37; }

.player-stepper { display: flex; align-items: center; gap: 8px; background: #133320; padding: 4px 8px; border-radius: 8px; }
.step-b { background: none; border: none; font-size: 16px; color: #d4af37; font-weight: 900; cursor: pointer; }
.player-num { font-size: 11px; font-weight: 900; color: #ffffff; }

.caddie-section { display: flex; flex-direction: column; gap: 8px; }
.caddie-options-deck { display: flex; flex-direction: column; gap: 8px; }
.caddie-pod {
  background: #133320; border: 1.5px solid #1c402b; border-radius: 12px; padding: 10px;
  display: flex; flex-direction: column; gap: 2px; cursor: pointer; transition: all 0.2s;
}
.caddie-pod.active { border-color: #d4af37; background: #1a422a; }
.c-top { display: flex; justify-content: space-between; }
.c-name { font-size: 12px; font-weight: 900; color: #ffffff; }
.c-fee { font-size: 11px; font-weight: 900; color: #d4af37; }
.c-spec { font-size: 9px; color: #a7f3d0; }

/* Floating Bar */
.golf-floating-bar {
  position: fixed; bottom: 0; left: 0; right: 0;
  background: rgba(9, 29, 18, 0.95);
  backdrop-filter: blur(14px);
  border-top: 1px solid #1c402b;
  padding: 14px 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  z-index: 90;
}
.fee-col { display: flex; flex-direction: column; }
.f-lbl { font-size: 9px; font-weight: 800; color: #a7f3d0; }
.f-total { font-size: 20px; font-weight: 900; color: #d4af37; }
.btn-lock-tee { background: #d4af37 !important; border-color: #d4af37 !important; color: black !important; font-weight: 900 !important; }

.lang-sheet-box { padding: 16px 20px 24px 20px; background: #091d12; color: white; }
.l-list { display: flex; flex-direction: column; gap: 8px; margin-top: 10px; }
.l-item { display: flex; justify-content: space-between; padding: 10px; border-radius: 10px; border: 1px solid #1c402b; cursor: pointer; }
.l-item.active { border-color: #d4af37; background: #05140c; color: #d4af37; font-weight: 700; }
</style>
