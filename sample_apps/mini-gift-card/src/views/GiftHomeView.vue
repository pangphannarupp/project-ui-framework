<template>
  <div class="gift-studio-root">
    <!-- Studio Top Bar -->
    <header class="studio-header">
      <div class="sh-brand">
        <span class="sh-icon">🎁</span>
        <div class="sh-titles">
          <span class="sh-tag">3D GIFT STUDIO // CONFETTI LAB</span>
          <h1 class="sh-name">CELEBRATION DIGITAL GIFTS</h1>
        </div>
      </div>

      <div class="sh-actions">
        <button class="sh-btn" @click="showLangSheet = true">
          <span>{{ currentLangObj.flag }}</span>
          <span>{{ currentLangObj.code.toUpperCase() }}</span>
        </button>
        <button class="sh-btn badge-btn" @click="$router.push('/my-tickets')">
          <span>💌</span>
          <span class="sh-badge" v-if="store.state.orders.length > 0">{{ store.state.orders.length }}</span>
        </button>
        <button class="sh-btn exit-btn" @click="showExitConfirm = true">✕</button>
      </div>
    </header>

    <main class="studio-viewport">
      <!-- 3D Interactive Card Canvas Visualizer -->
      <section class="card-3d-stage">
        <div 
          class="canvas-card-3d" 
          :style="{ background: store.state.selectedTheme.gradient }"
        >
          <!-- Shiny Foil Overlay Layer -->
          <div class="gold-foil-shine"></div>

          <div class="card-3d-top">
            <span class="card-3d-emoji">{{ store.state.selectedTheme.cardArtEmoji }}</span>
            <div class="card-amount-badge">
              <span class="amt-currency">$</span>
              <span class="amt-number">{{ store.state.selectedAmount }}</span>
            </div>
          </div>

          <div class="card-3d-center">
            <h2 class="card-3d-theme-title">{{ store.state.selectedTheme.title }}</h2>
            <p class="card-3d-greeting">"{{ store.state.customMessage || 'Wishing you moments filled with happiness!' }}"</p>
          </div>

          <div class="card-3d-foot">
            <span class="card-to-label">FOR: {{ store.state.recipientName || 'SARAH JENKINS' }}</span>
            <span class="card-verified-tag">★ GOLD VERIFIED PASS</span>
          </div>
        </div>
      </section>

      <!-- Theme Ribbon Selector (Horizontal Foil Palette) -->
      <section class="theme-palette-section">
        <span class="palette-label">1. CHOOSE CARD FOIL FINISH</span>
        <div class="palette-swatches">
          <div 
            v-for="th in GIFT_THEMES" 
            :key="th.id"
            class="foil-swatch-disc"
            :class="{ active: store.state.selectedTheme.id === th.id }"
            :style="{ background: th.gradient }"
            @click="store.state.selectedTheme = th"
          >
            <span class="swatch-emoji">{{ th.cardArtEmoji }}</span>
          </div>
        </div>
      </section>

      <!-- Denomination Buttons -->
      <section class="amounts-palette-section">
        <span class="palette-label">2. CHOOSE GIFT CARD AMOUNT</span>
        <div class="amount-buttons-deck">
          <button 
            v-for="amt in PRESET_AMOUNTS" 
            :key="amt"
            class="amt-capsule"
            :class="{ active: store.state.selectedAmount === amt }"
            @click="store.state.selectedAmount = amt"
          >
            ${{ amt }}
          </button>
        </div>
      </section>

      <!-- Personalization Form -->
      <section class="personalization-section">
        <div class="personal-card">
          <div class="field-item">
            <span class="f-lbl">Recipient Name</span>
            <PPInput v-model="store.state.recipientName" placeholder="e.g. Sarah Jenkins" />
          </div>
          <div class="field-item">
            <span class="f-lbl">Greeting Note</span>
            <PPInput v-model="store.state.customMessage" placeholder="Write custom greeting message..." />
          </div>
        </div>
      </section>
    </main>

    <!-- Floating Send Bar -->
    <footer class="studio-floating-bar">
      <div class="bar-info-col">
        <span class="b-lbl">Gift Card Value</span>
        <span class="b-total">${{ store.state.selectedAmount.toFixed(2) }}</span>
      </div>
      <PPButton variant="primary" size="large" @click="handleCheckout" class="btn-wrap-gift">
        <span>Wrap & Send Gift Card 🎁</span>
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
import { PPBottomSheet, PPConfirm, PPInput, PPButton } from '@phanna/ui-framework'
import { useGiftStore } from '../store/giftStore'
import { GIFT_THEMES, PRESET_AMOUNTS } from '../data/giftData'
import { useI18n } from '../i18n'
import '@/lib/mini.app.lib.js'

const MiniApp = (window as any).MiniApp
const store = useGiftStore()
const { t, currentLanguage, currentLangObj, supportedLanguages, setLanguage } = useI18n()

const showLangSheet = ref(false)
const showExitConfirm = ref(false)

const handleCheckout = () => {
  router.push('/checkout')
}

const confirmExit = () => {
  if (MiniApp?.exit) MiniApp.exit(false)
  else window.history.back()
}
</script>

<style scoped>
.gift-studio-root {
  min-height: 100vh;
  background: radial-gradient(circle at 50% 15%, #ffe4e6 0%, #fecdd3 100%);
  color: #881337;
  display: flex;
  flex-direction: column;
  padding-bottom: 96px;
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
}

/* Studio Header */
.studio-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px;
  background: rgba(255, 255, 255, 0.8);
  backdrop-filter: blur(12px);
  border-bottom: 1px solid rgba(255, 255, 255, 0.9);
}
.sh-brand { display: flex; align-items: center; gap: 10px; }
.sh-icon {
  font-size: 20px; background: #e11d48; color: white; width: 38px; height: 38px;
  border-radius: 12px; display: flex; align-items: center; justify-content: center;
  box-shadow: 0 4px 12px rgba(225,29,72,0.25);
}
.sh-titles { display: flex; flex-direction: column; }
.sh-tag { font-size: 8px; font-weight: 900; letter-spacing: 1.5px; color: #e11d48; }
.sh-name { font-size: 13px; font-weight: 900; margin: 0; color: #881337; }

.sh-actions { display: flex; gap: 6px; }
.sh-btn {
  background: rgba(255, 255, 255, 0.9);
  border: 1px solid #fecdd3;
  padding: 6px 12px;
  border-radius: 20px;
  font-size: 10px;
  font-weight: 800;
  color: #881337;
  cursor: pointer;
  display: flex;
  align-items: center;
  gap: 4px;
}
.badge-btn { position: relative; }
.sh-badge {
  position: absolute; top: -4px; right: -4px;
  background: #e11d48; color: white; font-size: 8px; font-weight: 900;
  width: 14px; height: 14px; border-radius: 50%; display: flex; align-items: center; justify-content: center;
}
.exit-btn { background: #fee2e2; color: #ef4444; border: none; }

.studio-viewport { padding: 16px; display: flex; flex-direction: column; gap: 14px; }

/* 3D Interactive Card Canvas */
.card-3d-stage { perspective: 1000px; display: flex; justify-content: center; }
.canvas-card-3d {
  width: 100%;
  border-radius: 22px;
  padding: 20px;
  color: white;
  position: relative;
  overflow: hidden;
  box-shadow: 0 15px 35px rgba(225,29,72,0.3);
  display: flex;
  flex-direction: column;
  gap: 12px;
  transform: rotateX(4deg);
  transition: transform 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
}
.canvas-card-3d:hover { transform: rotateX(0deg) scale(1.02); }

.gold-foil-shine {
  position: absolute; inset: -50%;
  background: linear-gradient(45deg, transparent 40%, rgba(255,255,255,0.4) 50%, transparent 60%);
  pointer-events: none;
}

.card-3d-top { display: flex; justify-content: space-between; align-items: center; }
.card-3d-emoji { font-size: 36px; }
.card-amount-badge {
  background: rgba(255, 255, 255, 0.25);
  backdrop-filter: blur(8px);
  padding: 4px 14px;
  border-radius: 16px;
  display: flex;
  align-items: baseline;
  gap: 2px;
}
.amt-currency { font-size: 16px; font-weight: 900; }
.amt-number { font-size: 26px; font-weight: 900; }

.card-3d-center { display: flex; flex-direction: column; gap: 4px; }
.card-3d-theme-title { font-size: 17px; font-weight: 900; margin: 0; }
.card-3d-greeting { font-size: 11px; font-style: italic; opacity: 0.95; margin: 0; line-height: 1.3; }

.card-3d-foot {
  display: flex; justify-content: space-between; font-size: 10px; font-weight: 800;
  border-top: 1px solid rgba(255,255,255,0.3); padding-top: 8px; margin-top: 4px;
}

/* Palette Swatches */
.palette-label { font-size: 9px; font-weight: 900; letter-spacing: 1px; color: #9f1239; margin-bottom: 6px; display: block; }
.palette-swatches { display: flex; gap: 10px; justify-content: space-between; }
.foil-swatch-disc {
  flex: 1; height: 46px; border-radius: 14px; display: flex; align-items: center; justify-content: center;
  cursor: pointer; border: 2px solid transparent; transition: all 0.2s;
  box-shadow: 0 4px 10px rgba(0,0,0,0.1);
}
.foil-swatch-disc.active { border-color: #881337; transform: scale(1.08); box-shadow: 0 8px 18px rgba(225,29,72,0.3); }
.swatch-emoji { font-size: 18px; }

/* Denomination Capsules */
.amount-buttons-deck { display: flex; gap: 6px; }
.amt-capsule {
  flex: 1; padding: 10px 0; border-radius: 12px; border: 1.5px solid #fecdd3; background: #ffffff;
  font-size: 13px; font-weight: 900; color: #881337; cursor: pointer;
}
.amt-capsule.active { background: #e11d48; color: white; border-color: #e11d48; box-shadow: 0 4px 12px rgba(225,29,72,0.25); }

/* Personalization Card */
.personal-card {
  background: rgba(255, 255, 255, 0.9);
  backdrop-filter: blur(10px);
  border-radius: 18px;
  padding: 14px;
  border: 1px solid rgba(255, 255, 255, 0.9);
  display: flex;
  flex-direction: column;
  gap: 10px;
}
.field-item { display: flex; flex-direction: column; gap: 4px; }
.f-lbl { font-size: 10px; font-weight: 800; color: #9f1239; }

/* Floating Bar */
.studio-floating-bar {
  position: fixed; bottom: 0; left: 0; right: 0;
  background: rgba(255, 255, 255, 0.92);
  backdrop-filter: blur(14px);
  border-top: 1px solid #fecdd3;
  padding: 14px 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  z-index: 90;
}
.bar-info-col { display: flex; flex-direction: column; }
.b-lbl { font-size: 9px; font-weight: 800; color: #9f1239; }
.b-total { font-size: 20px; font-weight: 900; color: #e11d48; }
.btn-wrap-gift { background: #e11d48 !important; border-color: #e11d48 !important; color: white !important; font-weight: 900 !important; }

.lang-sheet-box { padding: 16px 20px 24px 20px; }
.l-list { display: flex; flex-direction: column; gap: 8px; margin-top: 10px; }
.l-item { display: flex; justify-content: space-between; padding: 10px; border-radius: 10px; border: 1px solid #fecdd3; cursor: pointer; }
.l-item.active { border-color: #e11d48; background: #fff1f2; color: #e11d48; font-weight: 700; }
</style>
