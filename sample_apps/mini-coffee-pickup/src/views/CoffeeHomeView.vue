<template>
  <div class="nordic-coffee-experience">
    <!-- Minimalist Artisan Top Navigation -->
    <header class="artisan-nav">
      <div class="brand-badge">
        <span class="bean-icon">☕</span>
        <div class="brand-text">
          <span class="brand-tag">NORDIC ROASTERY</span>
          <h1 class="brand-title">SLOW BAR & BEANS</h1>
        </div>
      </div>

      <div class="nav-controls">
        <button class="icon-pill" @click="showLangSheet = true">
          <span>{{ currentLangObj.flag }}</span>
          <span class="lang-text">{{ currentLangObj.code.toUpperCase() }}</span>
        </button>
        <button class="icon-pill bag-pill" @click="$router.push('/my-tickets')">
          <span>🥤</span>
          <span class="bag-count" v-if="store.state.orders.length > 0">{{ store.state.orders.length }}</span>
        </button>
        <button class="icon-pill exit-pill" @click="showExitConfirm = true">✕</button>
      </div>
    </header>

    <!-- Visual Interactive 3D Drink Stage (Hero Visualizer) -->
    <main class="experience-stage">
      <div class="drink-visual-hero">
        <!-- Floating Visual Aroma & Notes Tags -->
        <div class="floating-aroma-left">
          <span class="aroma-pill">🌿 {{ currentActiveItem.notes.split(',')[0] }}</span>
          <span class="aroma-pill">🔥 {{ currentActiveItem.roastLevel }}</span>
        </div>

        <!-- Animated Cup Stage (Dynamically reacts to cup size & milk) -->
        <div class="cup-canvas-wrapper" :class="'size-' + store.state.currentCustom.cupSize.toLowerCase()">
          <div class="glow-disc"></div>
          <div class="cup-glass-body">
            <div class="steam-vapors">
              <span class="vapor s1">~</span>
              <span class="vapor s2">~</span>
              <span class="vapor s3">~</span>
            </div>
            <div class="foam-head" :style="{ height: store.state.currentCustom.milkType.includes('Oat') ? '18px' : '14px' }"></div>
            <div class="liquid-brew" :style="{ opacity: 0.85 + (store.state.currentCustom.extraShots * 0.05) }"></div>
          </div>
          <span class="cup-size-label">{{ store.state.currentCustom.cupSize === 'S' ? '8 oz Ristretto' : store.state.currentCustom.cupSize === 'M' ? '12 oz Standard' : '16 oz Grande' }}</span>
        </div>

        <div class="floating-price-right">
          <span class="price-chip">${{ currentItemPrice.toFixed(2) }}</span>
          <span class="roast-origin">ETHIOPIA YIRGACHEFFE</span>
        </div>
      </div>

      <!-- Drink Details Carousel Ribbon -->
      <section class="drink-selector-ribbon">
        <div class="drink-track">
          <div 
            v-for="c in COFFEE_ITEMS" 
            :key="c.id"
            class="drink-capsule"
            :class="{ active: currentActiveItem.id === c.id }"
            @click="store.state.activeCustomItem = c"
          >
            <div class="capsule-thumb">
              <img :src="c.imageUrl" :alt="c.name.en" />
            </div>
            <div class="capsule-meta">
              <span class="c-title">{{ c.name[currentLanguage] || c.name.en }}</span>
              <span class="c-price">${{ c.price.toFixed(2) }}</span>
            </div>
          </div>
        </div>
      </section>

      <!-- Live Cup Sculptor Console (Direct Customization Controls) -->
      <section class="sculptor-console">
        <div class="console-card">
          <div class="console-row">
            <span class="console-label">{{ t.cupSize }}</span>
            <div class="size-segmented-dial">
              <button 
                v-for="sz in ['S', 'M', 'L']" 
                :key="sz" 
                class="dial-btn"
                :class="{ active: store.state.currentCustom.cupSize === sz }"
                @click="store.state.currentCustom.cupSize = sz as any"
              >
                {{ sz }}
              </button>
            </div>
          </div>

          <div class="console-row slider-row">
            <div class="label-with-val">
              <span class="console-label">{{ t.sweetness }}</span>
              <span class="val-highlight">{{ store.state.currentCustom.sweetness }}%</span>
            </div>
            <PPSlider v-model="store.state.currentCustom.sweetness" :min="0" :max="100" :step="25" />
          </div>

          <div class="console-row">
            <span class="console-label">{{ t.milkType }}</span>
            <div class="milk-chips-grid">
              <button 
                v-for="m in ['Whole Milk', 'Oat Milk (+0.5)', 'Almond Milk (+0.5)']" 
                :key="m"
                class="milk-chip"
                :class="{ active: store.state.currentCustom.milkType === m }"
                @click="store.state.currentCustom.milkType = m as any"
              >
                {{ m.replace(' (+0.5)', '') }}
              </button>
            </div>
          </div>
        </div>
      </section>
    </main>

    <!-- Floating Artisan Order Bar -->
    <footer class="artisan-floating-bar">
      <div class="bar-summary">
        <span class="bar-label">Total to Brew</span>
        <span class="bar-amount">${{ currentItemPrice.toFixed(2) }}</span>
      </div>

      <div class="bar-actions">
        <PPButton variant="primary" size="large" @click="handleOrderDirect" class="btn-brew-now">
          <span>Add & Brew Order ⚡</span>
        </PPButton>
      </div>
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
import { ref, computed } from 'vue'
import { useRouter } from 'vue-router'
import { PPBottomSheet, PPConfirm, PPSlider, PPButton } from '@phanna/ui-framework'
import { useCoffeeStore } from '../store/coffeeStore'
import { COFFEE_ITEMS } from '../data/coffeeData'
import { useI18n } from '../i18n'
import '@/lib/mini.app.lib.js'

const MiniApp = (window as any).MiniApp
const store = useCoffeeStore()
const { t, currentLanguage, currentLangObj, supportedLanguages, setLanguage } = useI18n()

const showLangSheet = ref(false)
const showExitConfirm = ref(false)

const currentActiveItem = computed(() => store.state.activeCustomItem || COFFEE_ITEMS[0])

const currentItemPrice = computed(() => {
  return store.calculateItemPrice(currentActiveItem.value, store.state.currentCustom)
})

const handleOrderDirect = () => {
  store.addToCart(currentActiveItem.value, store.state.currentCustom)
  router.push('/checkout')
}

const confirmExit = () => {
  if (MiniApp?.exit) MiniApp.exit(false)
  else window.history.back()
}
</script>

<style scoped>
.nordic-coffee-experience {
  min-height: 100vh;
  background: radial-gradient(circle at 50% 20%, #f7ede2 0%, #ecd7c5 100%);
  color: #3d2b1f;
  display: flex;
  flex-direction: column;
  padding-bottom: 96px;
  position: relative;
  overflow-x: hidden;
}

/* Minimalist Artisan Top Navigation */
.artisan-nav {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px 20px;
}
.brand-badge { display: flex; align-items: center; gap: 10px; }
.bean-icon {
  font-size: 20px;
  background: #3d2b1f;
  color: #f7ede2;
  width: 38px;
  height: 38px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 0 4px 12px rgba(61, 43, 31, 0.15);
}
.brand-tag { font-size: 8px; font-weight: 900; letter-spacing: 2px; color: #8c6d58; }
.brand-title { font-size: 13px; font-weight: 900; letter-spacing: 1px; margin: 0; color: #3d2b1f; }

.nav-controls { display: flex; gap: 8px; align-items: center; }
.icon-pill {
  background: rgba(255, 255, 255, 0.7);
  backdrop-filter: blur(8px);
  border: 1px solid rgba(255, 255, 255, 0.9);
  padding: 6px 12px;
  border-radius: 20px;
  font-size: 11px;
  font-weight: 800;
  color: #3d2b1f;
  cursor: pointer;
  display: flex;
  align-items: center;
  gap: 4px;
}
.bag-pill { position: relative; }
.bag-count {
  position: absolute; top: -4px; right: -4px;
  background: #3d2b1f; color: #f7ede2; font-size: 9px; font-weight: 900;
  width: 16px; height: 16px; border-radius: 50%; display: flex; align-items: center; justify-content: center;
}
.exit-pill { background: #fee2e2; color: #ef4444; border: none; }

/* 3D Visual Drink Hero Stage */
.experience-stage { display: flex; flex-direction: column; gap: 16px; padding: 0 16px; }
.drink-visual-hero {
  position: relative;
  height: 220px;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-top: 6px;
}

.floating-aroma-left {
  position: absolute; left: 0; top: 20px;
  display: flex; flex-direction: column; gap: 6px; z-index: 2;
}
.aroma-pill {
  background: rgba(255, 255, 255, 0.85);
  backdrop-filter: blur(6px);
  border: 1px solid rgba(255, 255, 255, 0.9);
  padding: 6px 10px;
  border-radius: 12px;
  font-size: 10px;
  font-weight: 800;
  color: #3d2b1f;
  box-shadow: 0 4px 10px rgba(61,43,31,0.06);
}

.floating-price-right {
  position: absolute; right: 0; bottom: 20px;
  display: flex; flex-direction: column; align-items: flex-end; gap: 2px; z-index: 2;
}
.price-chip {
  font-size: 26px;
  font-weight: 900;
  color: #3d2b1f;
  background: #ffffff;
  padding: 4px 14px;
  border-radius: 16px;
  box-shadow: 0 6px 16px rgba(61,43,31,0.1);
}
.roast-origin { font-size: 8px; font-weight: 900; letter-spacing: 1px; color: #8c6d58; }

/* Cup Canvas Stage */
.cup-canvas-wrapper {
  position: relative;
  display: flex;
  flex-direction: column;
  align-items: center;
  transition: transform 0.4s cubic-bezier(0.34, 1.56, 0.64, 1);
}
.cup-canvas-wrapper.size-s { transform: scale(0.85); }
.cup-canvas-wrapper.size-m { transform: scale(1.0); }
.cup-canvas-wrapper.size-l { transform: scale(1.15); }

.glow-disc {
  position: absolute; width: 140px; height: 140px; border-radius: 50%;
  background: radial-gradient(circle, rgba(255,255,255,0.8) 0%, rgba(255,255,255,0) 70%);
  z-index: 0;
}
.cup-glass-body {
  width: 90px; height: 120px;
  background: linear-gradient(180deg, rgba(255,255,255,0.4) 0%, rgba(255,255,255,0.1) 100%);
  border: 3px solid rgba(255,255,255,0.9);
  border-top: none;
  border-radius: 0 0 30px 30px;
  position: relative;
  backdrop-filter: blur(4px);
  overflow: hidden;
  display: flex;
  flex-direction: column;
  justify-content: flex-end;
  box-shadow: 0 15px 30px rgba(61,43,31,0.15);
  z-index: 1;
}
.liquid-brew {
  width: 100%; height: 80px;
  background: linear-gradient(180deg, #603813 0%, #3d2b1f 100%);
  transition: opacity 0.3s;
}
.foam-head {
  width: 100%; height: 16px;
  background: #fdfaf6;
  border-radius: 4px;
}
.steam-vapors { position: absolute; top: -20px; left: 0; right: 0; display: flex; justify-content: space-around; }
.vapor { font-size: 16px; color: rgba(255,255,255,0.7); animation: floatUp 2s infinite ease-in-out; }
.vapor.s2 { animation-delay: 0.6s; }
.vapor.s3 { animation-delay: 1.2s; }
@keyframes floatUp { 0% { opacity: 0; transform: translateY(0); } 50% { opacity: 0.8; } 100% { opacity: 0; transform: translateY(-16px); } }
.cup-size-label { font-size: 10px; font-weight: 800; color: #8c6d58; margin-top: 8px; z-index: 1; }

/* Horizontal Drink Carousel Ribbon */
.drink-selector-ribbon { overflow-x: auto; padding: 4px 0; margin-bottom: 4px; }
.drink-track { display: flex; gap: 10px; }
.drink-capsule {
  display: flex;
  align-items: center;
  gap: 10px;
  background: rgba(255, 255, 255, 0.7);
  backdrop-filter: blur(8px);
  border: 1.5px solid rgba(255, 255, 255, 0.9);
  padding: 6px 12px 6px 6px;
  border-radius: 28px;
  cursor: pointer;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  white-space: nowrap;
}
.drink-capsule.active {
  background: #3d2b1f;
  color: #f7ede2;
  border-color: #3d2b1f;
  box-shadow: 0 8px 18px rgba(61,43,31,0.2);
}
.capsule-thumb { width: 34px; height: 34px; border-radius: 50%; overflow: hidden; }
.capsule-thumb img { width: 100%; height: 100%; object-fit: cover; }
.capsule-meta { display: flex; flex-direction: column; }
.c-title { font-size: 11px; font-weight: 800; }
.c-price { font-size: 10px; opacity: 0.8; }

/* Sculptor Console */
.sculptor-console { display: flex; flex-direction: column; }
.console-card {
  background: rgba(255, 255, 255, 0.8);
  backdrop-filter: blur(12px);
  border: 1px solid rgba(255, 255, 255, 0.9);
  border-radius: 20px;
  padding: 16px;
  display: flex;
  flex-direction: column;
  gap: 14px;
  box-shadow: 0 10px 25px rgba(61,43,31,0.06);
}
.console-row { display: flex; justify-content: space-between; align-items: center; }
.console-row.slider-row { flex-direction: column; align-items: stretch; gap: 8px; }
.console-label { font-size: 10px; font-weight: 900; letter-spacing: 1px; color: #8c6d58; text-transform: uppercase; }
.label-with-val { display: flex; justify-content: space-between; }
.val-highlight { font-size: 12px; font-weight: 900; color: #3d2b1f; }

.size-segmented-dial {
  display: flex; background: rgba(61,43,31,0.06); padding: 3px; border-radius: 12px; gap: 4px;
}
.dial-btn {
  border: none; background: none; padding: 6px 14px; font-size: 11px; font-weight: 900;
  border-radius: 9px; cursor: pointer; color: #8c6d58; transition: all 0.2s;
}
.dial-btn.active { background: #3d2b1f; color: #f7ede2; box-shadow: 0 2px 6px rgba(61,43,31,0.2); }

.milk-chips-grid { display: flex; gap: 6px; }
.milk-chip {
  border: 1px solid rgba(61,43,31,0.15); background: #ffffff; padding: 6px 10px;
  border-radius: 10px; font-size: 10px; font-weight: 800; color: #3d2b1f; cursor: pointer;
}
.milk-chip.active { background: #3d2b1f; color: #f7ede2; border-color: #3d2b1f; }

/* Floating Bar */
.artisan-floating-bar {
  position: fixed; bottom: 0; left: 0; right: 0;
  background: rgba(255, 255, 255, 0.9);
  backdrop-filter: blur(14px);
  border-top: 1px solid rgba(255, 255, 255, 0.9);
  padding: 14px 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  z-index: 90;
  box-shadow: 0 -10px 25px rgba(61,43,31,0.06);
}
.bar-summary { display: flex; flex-direction: column; }
.bar-label { font-size: 10px; font-weight: 800; color: #8c6d58; }
.bar-amount { font-size: 20px; font-weight: 900; color: #3d2b1f; }
.btn-brew-now { background: #3d2b1f !important; border-color: #3d2b1f !important; color: #f7ede2 !important; font-weight: 900 !important; }

.lang-sheet-box { padding: 16px 20px 24px 20px; }
.l-list { display: flex; flex-direction: column; gap: 8px; margin-top: 10px; }
.l-item { display: flex; justify-content: space-between; padding: 10px; border-radius: 10px; border: 1px solid #ebdcd0; cursor: pointer; }
.l-item.active { border-color: #3d2b1f; background: #fdfaf6; color: #3d2b1f; font-weight: 700; }
</style>
