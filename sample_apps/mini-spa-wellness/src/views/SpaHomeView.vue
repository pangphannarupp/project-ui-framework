<template>
  <div class="spa-lotus-root">
    <!-- Top Lotus Zen Navigation -->
    <header class="lotus-header">
      <div class="lotus-brand">
        <span class="lotus-icon">🪷</span>
        <div class="lotus-titles">
          <span class="lotus-tag">THERMAL ONSEN & SANCTUARY</span>
          <h1 class="lotus-name">LOTUS ZEN WELLNESS</h1>
        </div>
      </div>

      <div class="lotus-actions">
        <button class="lotus-pill" @click="showLangSheet = true">
          <span>{{ currentLangObj.flag }}</span>
          <span>{{ currentLangObj.code.toUpperCase() }}</span>
        </button>
        <button class="lotus-pill tea-pill" @click="$router.push('/my-tickets')">
          <span>🍵</span>
          <span class="l-badge" v-if="store.state.reservations.length > 0">{{ store.state.reservations.length }}</span>
        </button>
        <button class="lotus-pill exit-pill" @click="showExitConfirm = true">✕</button>
      </div>
    </header>

    <main class="lotus-viewport">
      <!-- Step-by-Step Thermal Therapy Ritual Pathway Stage -->
      <section class="pathway-stage">
        <div class="ritual-hero-card">
          <div class="rh-top">
            <span class="rh-tag">SELECTED HEALING RITUAL</span>
            <span class="rh-price">${{ store.state.selectedRitual.price.toFixed(2) }}</span>
          </div>

          <h3 class="rh-name">{{ store.state.selectedRitual.name[currentLanguage] || store.state.selectedRitual.name.en }}</h3>
          <span class="rh-dur">⏱️ {{ store.state.selectedRitual.durationMins }} Minutes Thermal Sanctuary Access</span>

          <!-- Step-by-Step Pathway Chain -->
          <div class="ritual-steps-chain">
            <div 
              v-for="(step, idx) in store.state.selectedRitual.steps"
              :key="idx"
              class="step-node"
            >
              <div class="step-circle">{{ idx + 1 }}</div>
              <span class="step-text">{{ step }}</span>
            </div>
          </div>
        </div>

        <!-- Ritual Toggles -->
        <div class="ritual-selector-deck">
          <button 
            v-for="r in SPA_RITUALS" 
            :key="r.id"
            class="r-capsule"
            :class="{ active: store.state.selectedRitual.id === r.id }"
            @click="store.state.selectedRitual = r"
          >
            {{ r.name.en.split('&')[0] }}
          </button>
        </div>
      </section>

      <!-- Essential Oil Aroma Customizer Console -->
      <section class="aroma-mixer-section">
        <div class="aroma-card">
          <span class="aroma-label">{{ t.aromaMixer }}</span>
          <div class="oil-blends-grid">
            <div 
              v-for="oil in [
                { name: 'French Lavender & Chamomile', note: 'Calm & Sleep', emoji: '🪻' },
                { name: 'Eucalyptus & Peppermint Mist', note: 'Deep Breathing', emoji: '🌿' },
                { name: 'Sandalwood & Warm Amber', note: 'Grounding Meditation', emoji: '🪵' },
                { name: 'Lotus Blossom & Rose Water', note: 'Radiant Glow', emoji: '🌸' }
              ]"
              :key="oil.name"
              class="oil-blend-pod"
              :class="{ active: store.state.selectedOil === oil.name }"
              @click="store.state.selectedOil = oil.name"
            >
              <span class="oil-emoji">{{ oil.emoji }}</span>
              <div class="oil-text-col">
                <span class="oil-name">{{ oil.name }}</span>
                <span class="oil-note">{{ oil.note }}</span>
              </div>
            </div>
          </div>
        </div>
      </section>
    </main>

    <!-- Floating Sanctuary Booking Bar -->
    <footer class="lotus-floating-bar">
      <div class="fee-col">
        <span class="f-lbl">{{ store.state.selectedRitual.durationMins }}m Ritual • Locker & Tea Included</span>
        <span class="f-total">${{ store.totalCost.value.toFixed(2) }}</span>
      </div>
      <PPButton variant="primary" size="large" @click="handleProceedToSpa" class="btn-book-sanctuary">
        <span>Reserve Sanctuary Pass 🌿</span>
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
import { useSpaStore } from '../store/spaStore'
import { SPA_RITUALS } from '../data/spaData'
import { useI18n } from '../i18n'
import '@/lib/mini.app.lib.js'

const MiniApp = (window as any).MiniApp
const store = useSpaStore()
const { t, currentLanguage, currentLangObj, supportedLanguages, setLanguage } = useI18n()

const showLangSheet = ref(false)
const showExitConfirm = ref(false)

const handleProceedToSpa = () => {
  router.push('/checkout')
}

const confirmExit = () => {
  if (MiniApp?.exit) MiniApp.exit(false)
  else window.history.back()
}
</script>

<style scoped>
.spa-lotus-root {
  min-height: 100vh;
  background: radial-gradient(circle at 50% 10%, #292524 0%, #1c1917 100%);
  color: #fafaf9;
  display: flex;
  flex-direction: column;
  padding-bottom: 96px;
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
}

/* Lotus Header */
.lotus-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px;
  background: #1c1917;
  border-bottom: 2px solid #44403c;
}
.lotus-brand { display: flex; align-items: center; gap: 10px; }
.lotus-icon {
  font-size: 18px; background: #f43f5e; color: white; width: 36px; height: 36px;
  border-radius: 10px; display: flex; align-items: center; justify-content: center;
}
.lotus-titles { display: flex; flex-direction: column; }
.lotus-tag { font-size: 8px; font-weight: 900; letter-spacing: 1.5px; color: #f43f5e; }
.lotus-name { font-size: 13px; font-weight: 900; margin: 0; color: #ffffff; }

.lotus-actions { display: flex; gap: 6px; }
.lotus-pill {
  background: #292524;
  border: 1px solid #44403c;
  padding: 6px 12px;
  border-radius: 20px;
  font-size: 10px;
  font-weight: 800;
  color: #f43f5e;
  cursor: pointer;
  display: flex;
  align-items: center;
  gap: 4px;
}
.tea-pill { position: relative; }
.l-badge {
  position: absolute; top: -4px; right: -4px;
  background: #f43f5e; color: white; font-size: 8px; font-weight: 900;
  width: 14px; height: 14px; border-radius: 50%; display: flex; align-items: center; justify-content: center;
}
.exit-pill { background: #450a0a; color: #ef4444; border: none; }

.lotus-viewport { padding: 16px; display: flex; flex-direction: column; gap: 14px; }

/* Pathway Stage */
.ritual-hero-card {
  background: #1c1917; border: 2px solid #44403c; border-radius: 20px; padding: 16px;
  display: flex; flex-direction: column; gap: 10px; box-shadow: 0 10px 30px rgba(0,0,0,0.5);
}
.rh-top { display: flex; justify-content: space-between; align-items: center; }
.rh-tag { font-size: 8px; font-weight: 900; letter-spacing: 1.5px; color: #f43f5e; }
.rh-price { font-size: 22px; font-weight: 900; color: #f43f5e; }
.rh-name { font-size: 15px; font-weight: 900; margin: 0; color: #ffffff; }
.rh-dur { font-size: 10px; color: #a8a29e; }

.ritual-steps-chain { display: flex; flex-direction: column; gap: 8px; border-top: 1px solid #44403c; padding-top: 10px; }
.step-node { display: flex; align-items: center; gap: 10px; }
.step-circle {
  width: 20px; height: 20px; border-radius: 50%; background: #f43f5e; color: white;
  font-size: 10px; font-weight: 900; display: flex; align-items: center; justify-content: center; flex-shrink: 0;
}
.step-text { font-size: 11px; color: #e7e5e4; }

.ritual-selector-deck { display: flex; gap: 8px; }
.r-capsule {
  flex: 1; padding: 8px; border-radius: 10px; border: 1px solid #44403c; background: #1c1917;
  color: #a8a29e; font-size: 10px; font-weight: 800; cursor: pointer;
}
.r-capsule.active { background: #f43f5e; color: white; border-color: #f43f5e; }

/* Aroma Mixer */
.aroma-card {
  background: #1c1917; border-radius: 18px; padding: 16px; border: 1px solid #44403c;
  display: flex; flex-direction: column; gap: 10px;
}
.aroma-label { font-size: 9px; font-weight: 900; letter-spacing: 1px; color: #f43f5e; }

.oil-blends-grid { display: flex; flex-direction: column; gap: 8px; }
.oil-blend-pod {
  background: #292524; border: 1.5px solid #44403c; border-radius: 12px; padding: 10px;
  display: flex; align-items: center; gap: 10px; cursor: pointer; transition: all 0.2s;
}
.oil-blend-pod.active { border-color: #f43f5e; background: #44403c; }
.oil-emoji { font-size: 20px; }
.oil-text-col { display: flex; flex-direction: column; }
.oil-name { font-size: 11px; font-weight: 900; color: #ffffff; }
.oil-note { font-size: 9px; color: #a8a29e; }

/* Floating Bar */
.lotus-floating-bar {
  position: fixed; bottom: 0; left: 0; right: 0;
  background: rgba(28, 25, 23, 0.95);
  backdrop-filter: blur(14px);
  border-top: 1px solid #44403c;
  padding: 14px 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  z-index: 90;
}
.fee-col { display: flex; flex-direction: column; }
.f-lbl { font-size: 9px; font-weight: 800; color: #a8a29e; }
.f-total { font-size: 20px; font-weight: 900; color: #f43f5e; }
.btn-book-sanctuary { background: #f43f5e !important; border-color: #f43f5e !important; color: white !important; font-weight: 900 !important; }

.lang-sheet-box { padding: 16px 20px 24px 20px; background: #1c1917; color: white; }
.l-list { display: flex; flex-direction: column; gap: 8px; margin-top: 10px; }
.l-item { display: flex; justify-content: space-between; padding: 10px; border-radius: 10px; border: 1px solid #44403c; cursor: pointer; }
.l-item.active { border-color: #f43f5e; background: #292524; color: #f43f5e; font-weight: 700; }
</style>
