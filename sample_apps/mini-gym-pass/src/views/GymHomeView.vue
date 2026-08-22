<template>
  <div class="cyber-terminal-root">
    <!-- Cyber Terminal Status Top Bar -->
    <header class="hud-top-bar">
      <div class="hud-brand">
        <span class="hud-pulse"></span>
        <div class="hud-title-col">
          <span class="hud-tag">TERMINAL // ACCESS NODE 08</span>
          <h1 class="hud-title">CYBER FITNESS HUD</h1>
        </div>
      </div>

      <div class="hud-controls">
        <button class="hud-btn" @click="showLangSheet = true">
          <span>{{ currentLangObj.flag }}</span>
          <span>{{ currentLangObj.code.toUpperCase() }}</span>
        </button>
        <button class="hud-btn badge-btn" @click="$router.push('/my-tickets')">
          <span>⚡</span>
          <span class="badge" v-if="store.state.passes.length > 0">{{ store.state.passes.length }}</span>
        </button>
        <button class="hud-btn exit-btn" @click="showExitConfirm = true">✕</button>
      </div>
    </header>

    <main class="hud-body">
      <!-- Biometric Telemetry Ring Deck -->
      <section class="telemetry-deck">
        <div class="hud-panel telemetry-panel">
          <div class="telemetry-ring">
            <div class="circle-graphic">
              <span class="center-stat">88%</span>
              <span class="center-sub">CAPACITY</span>
            </div>
          </div>
          <div class="telemetry-info">
            <div class="hud-metric">
              <span class="m-lbl">CLUB OCCUPANCY</span>
              <span class="m-val neon-lime">42 / 48 ATHLETES</span>
            </div>
            <div class="hud-metric">
              <span class="m-lbl">AIR PURITY INDEX</span>
              <span class="m-val">99.4% (HEPA+UV)</span>
            </div>
            <div class="hud-metric">
              <span class="m-lbl">TURBO SAUNA TEMP</span>
              <span class="m-val neon-amber">84.2°C READY</span>
            </div>
          </div>
        </div>
      </section>

      <!-- Matrix-style Interactive Class Timetable Grid -->
      <section class="timetable-section">
        <div class="section-hud-header">
          <span class="hud-label-mono">[ 01 ] LIVE STUDIO RADAR</span>
          <span class="hud-badge-live">LIVE FEED</span>
        </div>

        <div class="matrix-schedule-grid">
          <div 
            v-for="cls in TODAY_CLASSES" 
            :key="cls.id"
            class="matrix-row"
            :class="{ extreme: cls.intensity === 'EXTREME' }"
          >
            <div class="time-col">
              <span class="t-main">{{ cls.time.split(' ')[0] }}</span>
              <span class="t-ampm">{{ cls.time.split(' ')[1] }}</span>
            </div>

            <div class="class-info-col">
              <div class="ci-top">
                <span class="ci-name">{{ cls.name }}</span>
                <span class="ci-intensity">{{ cls.intensity }}</span>
              </div>
              <span class="ci-instructor">COACH // {{ cls.instructor.toUpperCase() }} • {{ cls.room }}</span>
            </div>

            <div class="action-col">
              <span class="spots-count">{{ cls.spotsLeft }} SPOTS</span>
              <PPButton variant="primary" size="small" @click="handleClassReserve" class="btn-hud-reserve">
                BOOK
              </PPButton>
            </div>
          </div>
        </div>
      </section>

      <!-- Membership Tiers Hologram Deck -->
      <section class="pass-deck-section">
        <div class="section-hud-header">
          <span class="hud-label-mono">[ 02 ] SECURITY CLEARANCE TIERS</span>
        </div>

        <div class="hologram-cards-stack">
          <div 
            v-for="p in GYM_PASSES" 
            :key="p.id"
            class="holo-card"
            :class="{ active: store.state.selectedPass.id === p.id }"
            @click="store.state.selectedPass = p"
          >
            <div class="holo-header">
              <span class="holo-tier-code">SECURITY LVL {{ p.validity.toUpperCase() }}</span>
              <span class="holo-price">${{ p.price.toFixed(2) }}</span>
            </div>
            <h3 class="holo-title">{{ p.title }}</h3>
            <span class="holo-access">ZONE CLEARANCE: {{ p.accessType }}</span>

            <div class="holo-specs">
              <span v-for="(f, idx) in p.features" :key="idx" class="spec-tag">
                + {{ f }}
              </span>
            </div>

            <PPButton 
              variant="primary" 
              block 
              size="medium" 
              @click.stop="selectPassAndCheckout(p)"
              class="btn-activate-holo"
            >
              INITIALIZE PASS • ${{ p.price.toFixed(2) }}
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
import { useGymStore } from '../store/gymStore'
import { GYM_PASSES, TODAY_CLASSES } from '../data/gymData'
import { useI18n } from '../i18n'
import type { GymPass } from '../types/gym'
import '@/lib/mini.app.lib.js'

const MiniApp = (window as any).MiniApp
const store = useGymStore()
const { t, currentLanguage, currentLangObj, supportedLanguages, setLanguage } = useI18n()

const showLangSheet = ref(false)
const showExitConfirm = ref(false)

const selectPassAndCheckout = (p: GymPass) => {
  store.state.selectedPass = p
  router.push('/checkout')
}

const handleClassReserve = () => {
  router.push('/checkout')
}

const confirmExit = () => {
  if (MiniApp?.exit) MiniApp.exit(false)
  else window.history.back()
}
</script>

<style scoped>
.cyber-terminal-root {
  min-height: 100vh;
  background-color: #050508;
  color: #f4f4f5;
  display: flex;
  flex-direction: column;
  padding-bottom: 30px;
  font-family: -apple-system, BlinkMacSystemFont, "SF Mono", "Fira Code", monospace;
  position: relative;
}

/* Scanline Overlay Effect */
.cyber-terminal-root::before {
  content: " ";
  position: fixed; inset: 0;
  background: linear-gradient(rgba(18, 16, 16, 0) 50%, rgba(0, 0, 0, 0.25) 50%);
  background-size: 100% 4px;
  pointer-events: none;
  z-index: 100;
  opacity: 0.6;
}

/* Cyber HUD Top Bar */
.hud-top-bar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px;
  background: #0d0d12;
  border-bottom: 1px solid #1f1f2e;
}
.hud-brand { display: flex; align-items: center; gap: 10px; }
.hud-pulse {
  width: 10px; height: 10px; border-radius: 50%;
  background: #84cc16;
  box-shadow: 0 0 10px #84cc16;
  animation: pulse 1.5s infinite;
}
@keyframes pulse { 0%, 100% { opacity: 1; transform: scale(1); } 50% { opacity: 0.4; transform: scale(0.8); } }
.hud-title-col { display: flex; flex-direction: column; }
.hud-tag { font-size: 8px; font-weight: 900; letter-spacing: 1.5px; color: #84cc16; }
.hud-title { font-size: 13px; font-weight: 900; letter-spacing: 1px; margin: 0; color: #ffffff; }

.hud-controls { display: flex; gap: 6px; }
.hud-btn {
  background: #14141e;
  border: 1px solid #272738;
  color: #d4d4d8;
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
.badge {
  position: absolute; top: -4px; right: -4px;
  background: #84cc16; color: black; font-size: 8px; font-weight: 900;
  width: 14px; height: 14px; border-radius: 50%; display: flex; align-items: center; justify-content: center;
}
.exit-btn { background: #3b1111; color: #ef4444; border-color: #5c1d1d; }

.hud-body { padding: 16px; display: flex; flex-direction: column; gap: 18px; }

/* Biometric Telemetry Panel */
.telemetry-panel {
  background: linear-gradient(135deg, #0d0d14 0%, #13131f 100%);
  border: 1px solid #272738;
  border-left: 3px solid #84cc16;
  border-radius: 14px;
  padding: 16px;
  display: flex;
  align-items: center;
  gap: 16px;
  box-shadow: 0 8px 25px rgba(0, 0, 0, 0.5);
}
.telemetry-ring {
  width: 76px; height: 76px; border-radius: 50%;
  border: 3px dashed #84cc16;
  display: flex; align-items: center; justify-content: center;
}
.circle-graphic { display: flex; flex-direction: column; align-items: center; }
.center-stat { font-size: 16px; font-weight: 900; color: #84cc16; }
.center-sub { font-size: 7px; color: #71717a; font-weight: 800; }

.telemetry-info { display: flex; flex-direction: column; gap: 6px; flex: 1; }
.hud-metric { display: flex; justify-content: space-between; font-size: 9px; font-weight: 800; border-bottom: 1px solid #1a1a27; padding-bottom: 3px; }
.m-lbl { color: #71717a; }
.m-val { color: #ffffff; }
.neon-lime { color: #84cc16; }
.neon-amber { color: #f59e0b; }

/* Matrix Schedule Grid */
.section-hud-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px; }
.hud-label-mono { font-size: 10px; font-weight: 900; letter-spacing: 1px; color: #84cc16; }
.hud-badge-live { font-size: 8px; font-weight: 900; background: #84cc1622; color: #84cc16; padding: 2px 6px; border-radius: 4px; }

.matrix-schedule-grid { display: flex; flex-direction: column; gap: 8px; }
.matrix-row {
  background: #0d0d14;
  border: 1px solid #1f1f2e;
  border-radius: 12px;
  padding: 12px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 10px;
}
.matrix-row.extreme { border-color: #84cc1644; background: #0f130a; }

.time-col { display: flex; flex-direction: column; width: 45px; }
.t-main { font-size: 14px; font-weight: 900; color: #84cc16; }
.t-ampm { font-size: 8px; color: #71717a; }

.class-info-col { flex: 1; display: flex; flex-direction: column; gap: 2px; }
.ci-top { display: flex; align-items: center; gap: 6px; }
.ci-name { font-size: 12px; font-weight: 900; color: #ffffff; }
.ci-intensity { font-size: 7px; font-weight: 900; background: #272738; color: #a1a1aa; padding: 1px 4px; border-radius: 3px; }
.ci-instructor { font-size: 9px; color: #71717a; }

.action-col { display: flex; flex-direction: column; align-items: flex-end; gap: 4px; }
.spots-count { font-size: 8px; font-weight: 800; color: #84cc16; }
.btn-hud-reserve { background: #84cc16 !important; border-color: #84cc16 !important; color: black !important; font-weight: 900 !important; }

/* Hologram Cards Stack */
.hologram-cards-stack { display: flex; flex-direction: column; gap: 12px; }
.holo-card {
  background: linear-gradient(135deg, #0d0d14 0%, #151522 100%);
  border: 1.5px solid #272738;
  border-radius: 16px;
  padding: 16px;
  display: flex;
  flex-direction: column;
  gap: 8px;
  cursor: pointer;
  transition: all 0.3s;
}
.holo-card.active { border-color: #84cc16; box-shadow: 0 0 20px rgba(132, 204, 22, 0.2); }
.holo-header { display: flex; justify-content: space-between; align-items: center; }
.holo-tier-code { font-size: 8px; font-weight: 900; color: #84cc16; letter-spacing: 1px; }
.holo-price { font-size: 20px; font-weight: 900; color: #84cc16; }
.holo-title { font-size: 15px; font-weight: 900; margin: 0; color: #ffffff; }
.holo-access { font-size: 10px; color: #a1a1aa; }

.holo-specs { display: flex; flex-direction: column; gap: 3px; border-top: 1px solid #1f1f2e; padding-top: 6px; }
.spec-tag { font-size: 9px; color: #d4d4d8; }

.btn-activate-holo {
  background: #84cc16 !important; border-color: #84cc16 !important; color: black !important; font-weight: 900 !important; margin-top: 6px;
}

.lang-sheet-box { padding: 16px 20px 24px 20px; background: #0d0d14; color: white; }
.l-list { display: flex; flex-direction: column; gap: 8px; margin-top: 10px; }
.l-item { display: flex; justify-content: space-between; padding: 10px; border-radius: 10px; border: 1px solid #272738; cursor: pointer; }
.l-item.active { border-color: #84cc16; background: #050508; color: #84cc16; font-weight: 700; }
</style>
