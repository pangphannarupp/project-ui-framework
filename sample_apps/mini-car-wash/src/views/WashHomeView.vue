<template>
  <div class="conveyor-hud-root">
    <!-- Tunnel Dashboard Header -->
    <header class="tunnel-header">
      <div class="th-logo">
        <span class="th-light"></span>
        <div class="th-titles">
          <span class="th-tag">EXPRESS TUNNEL // BAY 01 ACTIVE</span>
          <h1 class="th-name">ULTRA GLOSS CONVEYOR</h1>
        </div>
      </div>

      <div class="th-actions">
        <button class="th-btn" @click="showLangSheet = true">
          <span>{{ currentLangObj.flag }}</span>
          <span>{{ currentLangObj.code.toUpperCase() }}</span>
        </button>
        <button class="th-btn badge-btn" @click="$router.push('/my-tickets')">
          <span>🚗</span>
          <span class="th-badge" v-if="store.state.records.length > 0">{{ store.state.records.length }}</span>
        </button>
        <button class="th-btn exit-btn" @click="showExitConfirm = true">✕</button>
      </div>
    </header>

    <main class="tunnel-viewport">
      <!-- Interactive Conveyor Tunnel Track Simulator (Windshield Simulator) -->
      <section class="conveyor-track-stage">
        <div class="tunnel-tube">
          <div class="overhead-arch-lights">
            <span class="arch-led red"></span>
            <span class="arch-led yellow"></span>
            <span class="arch-led green active"></span>
          </div>

          <!-- Car on track with foam splatter -->
          <div class="car-on-conveyor">
            <div class="foam-spray-emitter">
              <span class="bubble-burst b1">🫧</span>
              <span class="bubble-burst b2">✨</span>
              <span class="bubble-burst b3">🫧</span>
            </div>
            <div class="vehicle-silhouette">
              <span class="car-emoji">🏎️</span>
              <span class="car-plate-strip">{{ store.state.plateNumber }}</span>
            </div>
            <div class="conveyor-moving-rollers"></div>
          </div>

          <div class="tunnel-telemetry-bar">
            <span>STAGE: PRE-SOAK & TRIPLE LAVA FOAM</span>
            <span class="timer-tag">0 MIN WAIT</span>
          </div>
        </div>
      </section>

      <!-- Interactive Wash Tier Comparison Wheel -->
      <section class="tiers-wheel-section">
        <div class="section-tag-row">
          <span class="sec-tag">SELECT WASH PROGRAM & POLISH TIER</span>
        </div>

        <div class="tier-cards-column">
          <div 
            v-for="tier in WASH_TIERS" 
            :key="tier.id"
            class="conveyor-tier-card"
            :class="{ active: store.state.selectedTier.id === tier.id }"
            @click="store.state.selectedTier = tier"
          >
            <div class="tier-card-top">
              <span class="t-badge-cyan">{{ tier.badge }}</span>
              <span class="t-price-cyan">${{ tier.price.toFixed(2) }}</span>
            </div>

            <h3 class="t-tier-name">{{ tier.name[currentLanguage] || tier.name.en }}</h3>
            <span class="t-duration">⏱️ Tunnel Run Time: {{ tier.durationMins }} Minutes</span>

            <div class="t-features-pills">
              <span v-for="(f, idx) in tier.features" :key="idx" class="f-pill">
                ✓ {{ f }}
              </span>
            </div>

            <PPButton 
              variant="primary" 
              block 
              size="medium" 
              @click.stop="handleSelectTier(tier)"
              class="btn-engage-bay"
            >
              ENGAGE BAY 01 • ${{ tier.price.toFixed(2) }}
            </PPButton>
          </div>
        </div>
      </section>
    </main>

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
import { useWashStore } from '../store/washStore'
import { WASH_TIERS } from '../data/washData'
import { useI18n } from '../i18n'
import type { WashTier } from '../types/wash'
import '@/lib/mini.app.lib.js'

const MiniApp = (window as any).MiniApp
const store = useWashStore()
const { t, currentLanguage, currentLangObj, supportedLanguages, setLanguage } = useI18n()

const showLangSheet = ref(false)
const showExitConfirm = ref(false)

const handleSelectTier = (tier: WashTier) => {
  store.state.selectedTier = tier
  router.push('/checkout')
}

const confirmExit = () => {
  if (MiniApp?.exit) MiniApp.exit(false)
  else window.history.back()
}
</script>

<style scoped>
.conveyor-hud-root {
  min-height: 100vh;
  background-color: #08121a;
  color: #f0fdf4;
  display: flex;
  flex-direction: column;
  padding-bottom: 24px;
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
}

/* Tunnel Header */
.tunnel-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px;
  background: #0f1e2c;
  border-bottom: 2px solid #164e63;
}
.th-logo { display: flex; align-items: center; gap: 10px; }
.th-light {
  width: 12px; height: 12px; border-radius: 50%;
  background: #00b4d8;
  box-shadow: 0 0 10px #00b4d8;
}
.th-titles { display: flex; flex-direction: column; }
.th-tag { font-size: 8px; font-weight: 900; letter-spacing: 1.5px; color: #00b4d8; }
.th-name { font-size: 13px; font-weight: 900; margin: 0; color: #ffffff; }

.th-actions { display: flex; gap: 6px; }
.th-btn {
  background: #08121a;
  border: 1px solid #164e63;
  color: #67e8f9;
  padding: 6px 10px;
  border-radius: 8px;
  font-size: 10px;
  font-weight: 800;
  cursor: pointer;
  display: flex;
  align-items: center;
  gap: 4px;
}
.badge-btn { position: relative; }
.th-badge {
  position: absolute; top: -4px; right: -4px;
  background: #00b4d8; color: black; font-size: 8px; font-weight: 900;
  width: 14px; height: 14px; border-radius: 50%; display: flex; align-items: center; justify-content: center;
}
.exit-btn { background: #450a0a; color: #ef4444; border-color: #7f1d1d; }

.tunnel-viewport { padding: 16px; display: flex; flex-direction: column; gap: 16px; }

/* Conveyor Track Simulator Stage */
.conveyor-track-stage { display: flex; flex-direction: column; }
.tunnel-tube {
  background: linear-gradient(180deg, #0f1e2c 0%, #08121a 100%);
  border: 2px solid #00b4d8;
  border-radius: 20px;
  padding: 16px;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 12px;
  box-shadow: 0 0 25px rgba(0,180,216,0.15);
  position: relative;
  overflow: hidden;
}
.overhead-arch-lights { display: flex; gap: 8px; }
.arch-led { width: 10px; height: 10px; border-radius: 50%; opacity: 0.3; }
.arch-led.red { background: #ef4444; }
.arch-led.yellow { background: #eab308; }
.arch-led.green { background: #22c55e; }
.arch-led.green.active { opacity: 1; box-shadow: 0 0 10px #22c55e; }

.car-on-conveyor {
  display: flex; flex-direction: column; align-items: center; position: relative; width: 100%;
}
.foam-spray-emitter { position: absolute; top: -10px; display: flex; gap: 20px; }
.bubble-burst { font-size: 20px; animation: bubbleFloat 1.5s infinite ease-in-out; }
.bubble-burst.b2 { animation-delay: 0.5s; }
.bubble-burst.b3 { animation-delay: 1.0s; }
@keyframes bubbleFloat { 0%, 100% { transform: translateY(0); opacity: 0.5; } 50% { transform: translateY(-8px); opacity: 1; } }

.vehicle-silhouette { display: flex; flex-direction: column; align-items: center; }
.car-emoji { font-size: 48px; }
.car-plate-strip {
  font-family: monospace; font-size: 12px; font-weight: 900; color: #00b4d8;
  background: #04090d; border: 1px solid #164e63; padding: 2px 8px; border-radius: 4px; margin-top: -6px;
}

.conveyor-moving-rollers {
  width: 100%; height: 6px; background: repeating-linear-gradient(90deg, #164e63, #164e63 10px, #00b4d8 10px, #00b4d8 20px);
  margin-top: 10px; border-radius: 3px; animation: rollConveyor 1s linear infinite;
}
@keyframes rollConveyor { 100% { background-position: 20px 0; } }

.tunnel-telemetry-bar {
  width: 100%; display: flex; justify-content: space-between; font-size: 8px; font-weight: 900; color: #67e8f9;
  border-top: 1px solid #164e63; padding-top: 8px;
}
.timer-tag { color: #4ade80; }

/* Tier Comparison Column */
.section-tag-row { margin-bottom: 8px; }
.sec-tag { font-size: 9px; font-weight: 900; letter-spacing: 1px; color: #00b4d8; }

.tier-cards-column { display: flex; flex-direction: column; gap: 12px; }
.conveyor-tier-card {
  background: #0f1e2c;
  border: 1.5px solid #164e63;
  border-radius: 16px;
  padding: 16px;
  display: flex;
  flex-direction: column;
  gap: 8px;
  cursor: pointer;
  transition: all 0.3s;
}
.conveyor-tier-card.active { border-color: #00b4d8; box-shadow: 0 0 20px rgba(0,180,216,0.25); }

.tier-card-top { display: flex; justify-content: space-between; align-items: center; }
.t-badge-cyan { font-size: 8px; font-weight: 900; background: #00b4d822; color: #00b4d8; padding: 3px 8px; border-radius: 4px; }
.t-price-cyan { font-size: 22px; font-weight: 900; color: #00b4d8; }
.t-tier-name { font-size: 15px; font-weight: 900; margin: 0; color: #ffffff; }
.t-duration { font-size: 10px; color: #67e8f9; }

.t-features-pills { display: flex; flex-wrap: wrap; gap: 4px; border-top: 1px solid #164e63; padding-top: 8px; }
.f-pill { font-size: 9px; color: #cbd5e1; background: #08121a; padding: 2px 6px; border-radius: 4px; }

.btn-engage-bay {
  background: #00b4d8 !important; border-color: #00b4d8 !important; color: black !important; font-weight: 900 !important; margin-top: 6px;
}

.lang-sheet-box { padding: 16px 20px 24px 20px; background: #0f1e2c; color: white; }
.l-list { display: flex; flex-direction: column; gap: 8px; margin-top: 10px; }
.l-item { display: flex; justify-content: space-between; padding: 10px; border-radius: 10px; border: 1px solid #164e63; cursor: pointer; }
.l-item.active { border-color: #00b4d8; background: #08121a; color: #00b4d8; font-weight: 700; }
</style>
