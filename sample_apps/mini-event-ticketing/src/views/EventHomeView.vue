<template>
  <div class="arena-spotlight-root">
    <!-- Spotlight Top Bar -->
    <header class="spotlight-header">
      <div class="sh-brand">
        <span class="laser-flare"></span>
        <div class="sh-titles">
          <span class="sh-tag">ARENA PASS // STAGE SCANNER READY</span>
          <h1 class="sh-name">LIVE ARENA TICKETS</h1>
        </div>
      </div>

      <div class="sh-actions">
        <button class="sh-btn" @click="showLangSheet = true">
          <span>{{ currentLangObj.flag }}</span>
          <span>{{ currentLangObj.code.toUpperCase() }}</span>
        </button>
        <button class="sh-btn badge-btn" @click="$router.push('/my-tickets')">
          <span>🎟️</span>
          <span class="sh-badge" v-if="store.state.passes.length > 0">{{ store.state.passes.length }}</span>
        </button>
        <button class="sh-btn exit-btn" @click="showExitConfirm = true">✕</button>
      </div>
    </header>

    <main class="spotlight-viewport">
      <!-- Interactive Stadium Arena Stage Map (Top-Down Stadium Visualizer) -->
      <section class="stadium-map-stage">
        <div class="arena-bowl-blueprint">
          <!-- Main Concert Stage Arch -->
          <div class="stage-spotlight-beam">
            <div class="main-stage-pod">
              <span class="stage-label">⚡ MAIN CONCERT STAGE</span>
              <div class="stage-lights-bar">
                <span></span><span></span><span></span><span></span><span></span>
              </div>
            </div>
          </div>

          <!-- Color-Coded Seating Tiers Map -->
          <div class="stadium-zones-matrix">
            <!-- VIP Golden Circle Barricade -->
            <div 
              class="arena-zone-sector vip-sector"
              :class="{ active: store.state.selectedZone.id === 'z-vip' }"
              @click="selectZoneById('z-vip')"
            >
              <span class="sector-tag">GOLDEN CIRCLE (VIP)</span>
              <span class="sector-price">$150</span>
            </div>

            <!-- GA Floor Standing Area -->
            <div 
              class="arena-zone-sector ga-sector"
              :class="{ active: store.state.selectedZone.id === 'z-standing' }"
              @click="selectZoneById('z-standing')"
            >
              <span class="sector-tag">FLOOR GA (STANDING)</span>
              <span class="sector-price">$65</span>
            </div>

            <!-- Grandstand Upper Tier -->
            <div 
              class="arena-zone-sector seated-sector"
              :class="{ active: store.state.selectedZone.id === 'z-tier-seat' }"
              @click="selectZoneById('z-tier-seat')"
            >
              <span class="sector-tag">UPPER BOWL (SEATED)</span>
              <span class="sector-price">$40</span>
            </div>
          </div>

          <div class="arena-legend">
            <span>📍 DIAMOND ISLAND ARENA • TAP SECTOR TO SELECT TIER</span>
          </div>
        </div>
      </section>

      <!-- Selected Zone Hologram Pass Deck -->
      <section class="selected-zone-deck">
        <div class="zone-hologram-card">
          <div class="zh-top">
            <span class="zh-badge" :style="{ color: store.state.selectedZone.color }">
              {{ store.state.selectedZone.badge }}
            </span>
            <span class="zh-price">${{ store.state.selectedZone.price.toFixed(2) }}</span>
          </div>

          <h3 class="zh-title">{{ store.state.selectedZone.name[currentLanguage] || store.state.selectedZone.name.en }}</h3>
          <span class="zh-event">{{ store.state.currentEvent.title }}</span>

          <div class="zh-perks">
            <span v-for="(p, idx) in store.state.selectedZone.perks" :key="idx" class="perk-tag">
              ★ {{ p }}
            </span>
          </div>

          <PPButton 
            variant="primary" 
            block 
            size="large" 
            @click="handleCheckoutTicket"
            class="btn-issue-pass"
          >
            LOCK PASS & CHECKOUT (${{ store.state.selectedZone.price.toFixed(2) }}) ⚡
          </PPButton>
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
import { useEventStore } from '../store/eventStore'
import { useI18n } from '../i18n'
import '@/lib/mini.app.lib.js'

const router = useRouter()
const MiniApp = (window as any).MiniApp
const store = useEventStore()
const { t, currentLanguage, currentLangObj, supportedLanguages, setLanguage } = useI18n()

const showLangSheet = ref(false)
const showExitConfirm = ref(false)

const selectZoneById = (id: string) => {
  const z = store.state.currentEvent.zones.find(zone => zone.id === id)
  if (z) store.state.selectedZone = z
}

const handleCheckoutTicket = () => {
  router.push('/checkout')
}

const confirmExit = () => {
  if (MiniApp?.exit) MiniApp.exit(false)
  else window.history.back()
}
</script>

<style scoped>
.arena-spotlight-root {
  min-height: 100vh;
  background-color: #06020b;
  color: #ffffff;
  display: flex;
  flex-direction: column;
  padding-bottom: 24px;
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
}

/* Spotlight Header */
.spotlight-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px;
  background: #11051c;
  border-bottom: 2px solid #2e1065;
}
.sh-brand { display: flex; align-items: center; gap: 10px; }
.laser-flare {
  width: 12px; height: 12px; border-radius: 50%;
  background: #f59e0b;
  box-shadow: 0 0 12px #f59e0b;
}
.sh-titles { display: flex; flex-direction: column; }
.sh-tag { font-size: 8px; font-weight: 900; letter-spacing: 1.5px; color: #f59e0b; }
.sh-name { font-size: 13px; font-weight: 900; margin: 0; color: #ffffff; }

.sh-actions { display: flex; gap: 6px; }
.sh-btn {
  background: #06020b;
  border: 1px solid #2e1065;
  color: #e9d5ff;
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
.sh-badge {
  position: absolute; top: -4px; right: -4px;
  background: #f59e0b; color: black; font-size: 8px; font-weight: 900;
  width: 14px; height: 14px; border-radius: 50%; display: flex; align-items: center; justify-content: center;
}
.exit-btn { background: #450a0a; color: #ef4444; border-color: #7f1d1d; }

.spotlight-viewport { padding: 16px; display: flex; flex-direction: column; gap: 16px; }

/* Stadium Blueprint Stage */
.arena-bowl-blueprint {
  background: radial-gradient(circle at 50% 10%, #200938 0%, #0c0217 100%);
  border: 1.5px solid #2e1065;
  border-radius: 20px;
  padding: 16px;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 12px;
  box-shadow: 0 0 30px rgba(168,85,247,0.15);
}

.stage-spotlight-beam { display: flex; justify-content: center; width: 100%; }
.main-stage-pod {
  background: #2e1065;
  border: 2px solid #a855f7;
  border-radius: 12px;
  padding: 8px 16px;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 4px;
  box-shadow: 0 0 15px rgba(168,85,247,0.4);
}
.stage-label { font-size: 9px; font-weight: 900; color: #f59e0b; letter-spacing: 1px; }
.stage-lights-bar { display: flex; gap: 4px; }
.stage-lights-bar span { width: 8px; height: 3px; background: #f59e0b; border-radius: 2px; }

.stadium-zones-matrix { display: flex; flex-direction: column; gap: 8px; width: 100%; }
.arena-zone-sector {
  border-radius: 12px;
  padding: 10px 14px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  cursor: pointer;
  transition: all 0.3s;
  border: 1.5px solid transparent;
}
.vip-sector { background: rgba(245, 158, 11, 0.15); border-color: rgba(245, 158, 11, 0.3); color: #f59e0b; }
.vip-sector.active { border-color: #f59e0b; background: rgba(245, 158, 11, 0.3); box-shadow: 0 0 15px rgba(245,158,11,0.3); }

.ga-sector { background: rgba(168, 85, 247, 0.15); border-color: rgba(168, 85, 247, 0.3); color: #c084fc; }
.ga-sector.active { border-color: #a855f7; background: rgba(168, 85, 247, 0.3); box-shadow: 0 0 15px rgba(168,85,247,0.3); }

.seated-sector { background: rgba(59, 130, 246, 0.15); border-color: rgba(59, 130, 246, 0.3); color: #60a5fa; }
.seated-sector.active { border-color: #3b82f6; background: rgba(59, 130, 246, 0.3); box-shadow: 0 0 15px rgba(59,130,246,0.3); }

.sector-tag { font-size: 11px; font-weight: 900; }
.sector-price { font-size: 14px; font-weight: 900; }

.arena-legend { font-size: 8px; font-weight: 800; color: #94a3b8; }

/* Zone Hologram Card */
.zone-hologram-card {
  background: #11051c;
  border: 1.5px solid #2e1065;
  border-radius: 18px;
  padding: 16px;
  display: flex;
  flex-direction: column;
  gap: 10px;
  box-shadow: 0 10px 25px rgba(0,0,0,0.5);
}
.zh-top { display: flex; justify-content: space-between; align-items: center; }
.zh-badge { font-size: 9px; font-weight: 900; text-transform: uppercase; background: #2e1065; padding: 2px 6px; border-radius: 4px; }
.zh-price { font-size: 22px; font-weight: 900; color: #f59e0b; }
.zh-title { font-size: 16px; font-weight: 900; margin: 0; color: #ffffff; }
.zh-event { font-size: 11px; color: #c084fc; font-weight: 700; }

.zh-perks { display: flex; flex-direction: column; gap: 4px; border-top: 1px solid #2e1065; padding-top: 8px; }
.perk-tag { font-size: 10px; color: #e9d5ff; }

.btn-issue-pass {
  background: #f59e0b !important; border-color: #f59e0b !important; color: black !important; font-weight: 900 !important; margin-top: 6px;
}

.lang-sheet-box { padding: 16px 20px 24px 20px; background: #11051c; color: white; }
.l-list { display: flex; flex-direction: column; gap: 8px; margin-top: 10px; }
.l-item { display: flex; justify-content: space-between; padding: 10px; border-radius: 10px; border: 1px solid #2e1065; cursor: pointer; }
.l-item.active { border-color: #f59e0b; background: #06020b; color: #f59e0b; font-weight: 700; }
</style>
