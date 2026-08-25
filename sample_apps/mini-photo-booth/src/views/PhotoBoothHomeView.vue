<template>
  <div class="photobooth-y2k-root">
    <!-- Top Photo Booth Navigation -->
    <header class="photo-header">
      <div class="photo-brand">
        <span class="camera-icon">📸</span>
        <div class="photo-titles">
          <span class="photo-tag">INSTANT 4-CUT FILM STUDIO</span>
          <h1 class="photo-name">HARMONY PHOTO BOOTH</h1>
        </div>
      </div>

      <div class="photo-actions">
        <button class="photo-pill" @click="showLangSheet = true">
          <span>{{ currentLangObj.flag }}</span>
          <span>{{ currentLangObj.code.toUpperCase() }}</span>
        </button>
        <button class="photo-pill film-pill" @click="$router.push('/my-tickets')">
          <span>🎞️</span>
          <span class="p-badge" v-if="store.state.sessions.length > 0">{{ store.state.sessions.length }}</span>
        </button>
        <button class="photo-pill exit-pill" @click="showExitConfirm = true">✕</button>
      </div>
    </header>

    <main class="photo-viewport">
      <!-- Live 4-Cut Vertical Film Strip Studio Visualizer -->
      <section class="film-strip-studio-stage">
        <div 
          class="vertical-4cut-frame"
          :style="{ background: store.state.selectedTheme.bgPattern }"
        >
          <!-- 4 Photo Cut Snapshots -->
          <div class="photo-cut-boxes">
            <div class="cut-box" :class="store.state.selectedTheme.filterEffect.toLowerCase()">
              <span class="cut-emoji">✌️</span>
            </div>
            <div class="cut-box" :class="store.state.selectedTheme.filterEffect.toLowerCase()">
              <span class="cut-emoji">🥰</span>
            </div>
            <div class="cut-box" :class="store.state.selectedTheme.filterEffect.toLowerCase()">
              <span class="cut-emoji">✨</span>
            </div>
            <div class="cut-box" :class="store.state.selectedTheme.filterEffect.toLowerCase()">
              <span class="cut-emoji">😎</span>
            </div>
          </div>

          <!-- Bottom Film Footer Stamp -->
          <div class="film-bottom-stamp">
            <span class="sticker-ico">{{ store.state.selectedTheme.stickerEmoji }}</span>
            <span class="stamp-txt">{{ store.state.customTextStamp }}</span>
            <span class="sticker-ico">{{ store.state.selectedTheme.stickerEmoji }}</span>
          </div>
        </div>
      </section>

      <!-- Frame & Filter FX Palette -->
      <section class="theme-frame-section">
        <span class="sec-label">{{ t.chooseTheme }}</span>
        <div class="themes-swatches-grid">
          <div 
            v-for="th in FRAME_THEMES" 
            :key="th.id"
            class="theme-swatch-card"
            :class="{ active: store.state.selectedTheme.id === th.id }"
            :style="{ background: th.bgPattern }"
            @click="store.state.selectedTheme = th"
          >
            <span class="swatch-emoji">{{ th.stickerEmoji }}</span>
            <span class="swatch-name">{{ th.name }}</span>
          </div>
        </div>
      </section>

      <!-- Custom Date Stamp Text Console -->
      <section class="stamp-text-section">
        <div class="stamp-card">
          <span class="sec-label">CUSTOM BOTTOM FILM STAMP</span>
          <PPInput v-model="store.state.customTextStamp" placeholder="e.g. BFF REUNION • 2026.08" />
        </div>
      </section>
    </main>

    <!-- Floating Print Order Bar -->
    <footer class="photo-floating-bar">
      <div class="cost-col">
        <span class="c-lbl">2x Physical Strips + HD Download</span>
        <span class="c-total">${{ store.basePricePerPair.toFixed(2) }}</span>
      </div>
      <PPButton variant="primary" size="large" @click="handleProceedToPrint" class="btn-print-strip">
        <span>{{ t.confirmAndPay }}</span>
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
import { usePhotoBoothStore } from '../store/photoboothStore'
import { FRAME_THEMES } from '../data/photoboothData'
import { useI18n } from '../i18n'
import '@/lib/mini.app.lib.js'

const router = useRouter()
const MiniApp = (window as any).MiniApp
const store = usePhotoBoothStore()
const { t, currentLanguage, currentLangObj, supportedLanguages, setLanguage } = useI18n()

const showLangSheet = ref(false)
const showExitConfirm = ref(false)

const handleProceedToPrint = () => {
  router.push('/checkout')
}

const confirmExit = () => {
  if (MiniApp?.exit) MiniApp.exit(false)
  else window.history.back()
}
</script>

<style scoped>
.photobooth-y2k-root {
  min-height: 100vh;
  background: radial-gradient(circle at 50% 10%, #fdf4ff 0%, #fae8ff 100%);
  color: #581c87;
  display: flex;
  flex-direction: column;
  padding-bottom: 96px;
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
}

/* Photo Header */
.photo-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px;
  background: rgba(255, 255, 255, 0.85);
  backdrop-filter: blur(12px);
  border-bottom: 1px solid rgba(255, 255, 255, 0.9);
}
.photo-brand { display: flex; align-items: center; gap: 10px; }
.camera-icon {
  font-size: 18px; background: #c026d3; color: white; width: 36px; height: 36px;
  border-radius: 10px; display: flex; align-items: center; justify-content: center;
  box-shadow: 0 4px 12px rgba(192,38,211,0.25);
}
.photo-titles { display: flex; flex-direction: column; }
.photo-tag { font-size: 8px; font-weight: 900; letter-spacing: 1.5px; color: #c026d3; }
.photo-name { font-size: 13px; font-weight: 900; margin: 0; color: #581c87; }

.photo-actions { display: flex; gap: 6px; }
.photo-pill {
  background: rgba(255, 255, 255, 0.9);
  border: 1px solid #f0abfc;
  padding: 6px 12px;
  border-radius: 20px;
  font-size: 10px;
  font-weight: 800;
  color: #c026d3;
  cursor: pointer;
  display: flex;
  align-items: center;
  gap: 4px;
}
.film-pill { position: relative; }
.p-badge {
  position: absolute; top: -4px; right: -4px;
  background: #c026d3; color: white; font-size: 8px; font-weight: 900;
  width: 14px; height: 14px; border-radius: 50%; display: flex; align-items: center; justify-content: center;
}
.exit-pill { background: #fee2e2; color: #ef4444; border: none; }

.photo-viewport { padding: 16px; display: flex; flex-direction: column; gap: 14px; align-items: center; }

/* 4-Cut Vertical Film Strip Stage */
.vertical-4cut-frame {
  width: 170px; border-radius: 12px; padding: 10px 8px; box-shadow: 0 10px 30px rgba(192,38,211,0.25);
  display: flex; flex-direction: column; gap: 6px; border: 2px solid white;
}
.photo-cut-boxes { display: flex; flex-direction: column; gap: 6px; }
.cut-box {
  width: 100%; height: 80px; background: #ffffff; border-radius: 6px;
  display: flex; align-items: center; justify-content: center;
}
.cut-emoji { font-size: 28px; }

.film-bottom-stamp {
  display: flex; justify-content: space-between; align-items: center; font-size: 7px;
  font-weight: 900; color: #581c87; padding-top: 4px;
}

/* Theme Swatches */
.theme-frame-section, .stamp-text-section { width: 100%; }
.sec-label { font-size: 9px; font-weight: 900; letter-spacing: 1px; color: #86198f; margin-bottom: 6px; display: block; }

.themes-swatches-grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 8px; }
.theme-swatch-card {
  padding: 10px; border-radius: 12px; display: flex; align-items: center; gap: 8px;
  border: 1.5px solid transparent; cursor: pointer; transition: all 0.2s;
  box-shadow: 0 4px 10px rgba(0,0,0,0.05);
}
.theme-swatch-card.active { border-color: #c026d3; transform: scale(1.03); box-shadow: 0 6px 16px rgba(192,38,211,0.2); }
.swatch-emoji { font-size: 16px; }
.swatch-name { font-size: 10px; font-weight: 900; color: #581c87; }

.stamp-card { background: rgba(255, 255, 255, 0.9); border-radius: 16px; padding: 12px; border: 1px solid rgba(255, 255, 255, 0.9); }

/* Floating Bar */
.photo-floating-bar {
  position: fixed; bottom: 0; left: 0; right: 0;
  background: rgba(255, 255, 255, 0.92);
  backdrop-filter: blur(14px);
  border-top: 1px solid #f0abfc;
  padding: 14px 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  z-index: 90;
}
.cost-col { display: flex; flex-direction: column; }
.c-lbl { font-size: 9px; font-weight: 800; color: #86198f; }
.c-total { font-size: 20px; font-weight: 900; color: #c026d3; }
.btn-print-strip { background: #c026d3 !important; border-color: #c026d3 !important; color: white !important; font-weight: 900 !important; }

.lang-sheet-box { padding: 16px 20px 24px 20px; }
.l-list { display: flex; flex-direction: column; gap: 8px; margin-top: 10px; }
.l-item { display: flex; justify-content: space-between; padding: 10px; border-radius: 10px; border: 1px solid #f0abfc; cursor: pointer; }
.l-item.active { border-color: #c026d3; background: #fdf4ff; color: #c026d3; font-weight: 700; }
</style>
