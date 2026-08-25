<template>
  <div class="luxury-editorial-root">
    <!-- Editorial Top Masthead -->
    <header class="editorial-masthead">
      <div class="masthead-crest">
        <span class="crest-icon">⚜️</span>
        <span class="crest-brand">THE GRAND CHAMPAGNE</span>
        <span class="crest-loc">HOTEL & RESIDENCES // BOUTIQUE VILLA</span>
      </div>

      <div class="masthead-actions">
        <button class="gold-pill" @click="showLangSheet = true">
          <span>{{ currentLangObj.flag }}</span>
          <span>{{ currentLangObj.code.toUpperCase() }}</span>
        </button>
        <button class="gold-pill key-badge-pill" @click="$router.push('/my-tickets')">
          <span>🔑</span>
          <span class="k-count" v-if="store.state.bookings.length > 0">{{ store.state.bookings.length }}</span>
        </button>
        <button class="gold-pill exit-pill" @click="showExitConfirm = true">✕</button>
      </div>
    </header>

    <main class="editorial-viewport">
      <!-- Full-Bleed Suite Magazine Stage (Hero Visual Swiper) -->
      <section class="suite-magazine-stage">
        <div class="magazine-frame">
          <img :src="currentSuite.imageUrl" :alt="currentSuite.name.en" class="mag-photo" />
          <div class="mag-glass-vignette">
            <span class="mag-tier">{{ currentSuite.tier }}</span>
            <h2 class="mag-suite-title">{{ currentSuite.name[currentLanguage] || currentSuite.name.en }}</h2>
            <p class="mag-suite-desc">{{ currentSuite.description }}</p>

            <div class="mag-specs-strip">
              <span>📐 {{ currentSuite.sqm }} SQM</span>
              <span>🛏️ {{ currentSuite.bedType }}</span>
              <span>🥂 CHAMPAGNE INCLUDED</span>
            </div>
          </div>
        </div>
      </section>

      <!-- Suite Selector Gallery Strip -->
      <section class="suite-gallery-strip">
        <div class="gallery-scroll-track">
          <div 
            v-for="s in HOTEL_SUITES" 
            :key="s.id"
            class="suite-thumb-card"
            :class="{ active: store.state.selectedSuite.id === s.id }"
            @click="store.state.selectedSuite = s"
          >
            <div class="thumb-img-wrap">
              <img :src="s.imageUrl" :alt="s.name.en" />
            </div>
            <div class="thumb-meta">
              <span class="t-name">{{ s.name[currentLanguage] || s.name.en }}</span>
              <span class="t-price">${{ s.pricePerNight.toFixed(0) }} / night</span>
            </div>
          </div>
        </div>
      </section>

      <!-- Stay Dates & Concierge Bar -->
      <section class="dates-concierge-deck">
        <div class="deck-card">
          <div class="dates-row">
            <div class="d-cell">
              <span class="d-tag">CHECK-IN</span>
              <span class="d-date">AUG 25, 2026</span>
            </div>
            <div class="d-center-badge">2 NIGHTS</div>
            <div class="d-cell right">
              <span class="d-tag">CHECK-OUT</span>
              <span class="d-date">AUG 27, 2026</span>
            </div>
          </div>

          <div class="amenities-gold-tags">
            <span v-for="(am, idx) in currentSuite.amenities" :key="idx" class="gold-amenity">
              ⚜️ {{ am }}
            </span>
          </div>
        </div>
      </section>
    </main>

    <!-- Floating Luxury Concierge Reservation Bar -->
    <footer class="editorial-floating-bar">
      <div class="price-col">
        <span class="p-sub">2 Nights Stay Total</span>
        <span class="p-main">${{ (currentSuite.pricePerNight * 2).toFixed(2) }}</span>
      </div>

      <PPButton variant="primary" size="large" @click="handleReserveSuite" class="btn-gold-reserve">
        <span>Reserve & Issue Mobile Key 🔑</span>
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
import { ref, computed } from 'vue'
import { useRouter } from 'vue-router'
import { PPBottomSheet, PPConfirm, PPButton } from '@phanna/ui-framework'
import { useHotelStore } from '../store/hotelStore'
import { HOTEL_SUITES } from '../data/hotelData'
import { useI18n } from '../i18n'
import '@/lib/mini.app.lib.js'

const router = useRouter()
const MiniApp = (window as any).MiniApp
const store = useHotelStore()
const { t, currentLanguage, currentLangObj, supportedLanguages, setLanguage } = useI18n()

const showLangSheet = ref(false)
const showExitConfirm = ref(false)

const currentSuite = computed(() => store.state.selectedSuite || HOTEL_SUITES[0])

const handleReserveSuite = () => {
  router.push('/checkout')
}

const confirmExit = () => {
  if (MiniApp?.exit) MiniApp.exit(false)
  else window.history.back()
}
</script>

<style scoped>
.luxury-editorial-root {
  min-height: 100vh;
  background-color: #0b132b;
  color: #ffffff;
  display: flex;
  flex-direction: column;
  padding-bottom: 96px;
  font-family: -apple-system, BlinkMacSystemFont, "Georgia", "Times New Roman", serif;
}

/* Editorial Masthead */
.editorial-masthead {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px 20px;
  background: #080e21;
  border-bottom: 1px solid #1c2541;
}
.masthead-crest { display: flex; flex-direction: column; gap: 1px; }
.crest-icon { font-size: 16px; color: #d4af37; }
.crest-brand { font-size: 13px; font-weight: 900; letter-spacing: 2px; color: #d4af37; }
.crest-loc { font-size: 8px; font-weight: 700; letter-spacing: 1px; color: #64748b; font-family: sans-serif; }

.masthead-actions { display: flex; gap: 6px; }
.gold-pill {
  background: #1c2541;
  border: 1px solid #3a506b;
  color: #d4af37;
  padding: 6px 12px;
  border-radius: 20px;
  font-size: 10px;
  font-weight: 800;
  cursor: pointer;
  display: flex;
  align-items: center;
  gap: 4px;
  font-family: sans-serif;
}
.key-badge-pill { position: relative; }
.k-count {
  position: absolute; top: -4px; right: -4px;
  background: #d4af37; color: black; font-size: 8px; font-weight: 900;
  width: 14px; height: 14px; border-radius: 50%; display: flex; align-items: center; justify-content: center;
}
.exit-pill { background: #450a0a; color: #ef4444; border: none; }

.editorial-viewport { display: flex; flex-direction: column; gap: 14px; padding: 14px; }

/* Magazine Frame Stage */
.magazine-frame {
  position: relative;
  border-radius: 20px;
  overflow: hidden;
  height: 260px;
  border: 1.5px solid #d4af37;
  box-shadow: 0 10px 30px rgba(0,0,0,0.5);
}
.mag-photo { width: 100%; height: 100%; object-fit: cover; }
.mag-glass-vignette {
  position: absolute; inset: 0;
  background: linear-gradient(180deg, rgba(11,19,43,0.1) 0%, rgba(11,19,43,0.95) 100%);
  padding: 16px;
  display: flex;
  flex-direction: column;
  justify-content: flex-end;
  gap: 4px;
}
.mag-tier { font-size: 8px; font-weight: 900; letter-spacing: 2px; color: #d4af37; text-transform: uppercase; font-family: sans-serif; }
.mag-suite-title { font-size: 20px; font-weight: 900; margin: 0; color: #ffffff; line-height: 1.2; }
.mag-suite-desc { font-size: 11px; color: #cbd5e1; margin: 0; font-family: sans-serif; line-height: 1.3; opacity: 0.9; }

.mag-specs-strip { display: flex; gap: 10px; font-size: 9px; font-weight: 800; color: #d4af37; margin-top: 4px; font-family: sans-serif; }

/* Suite Selector Gallery Strip */
.gallery-scroll-track { display: flex; gap: 10px; overflow-x: auto; padding: 4px 0; }
.suite-thumb-card {
  display: flex;
  align-items: center;
  gap: 10px;
  background: #1c2541;
  border: 1.5px solid #3a506b;
  padding: 6px 12px 6px 6px;
  border-radius: 24px;
  cursor: pointer;
  white-space: nowrap;
  transition: all 0.3s;
  font-family: sans-serif;
}
.suite-thumb-card.active {
  border-color: #d4af37;
  background: #080e21;
  box-shadow: 0 4px 15px rgba(212,175,55,0.2);
}
.thumb-img-wrap { width: 36px; height: 36px; border-radius: 50%; overflow: hidden; }
.thumb-img-wrap img { width: 100%; height: 100%; object-fit: cover; }
.thumb-meta { display: flex; flex-direction: column; }
.t-name { font-size: 11px; font-weight: 800; }
.t-price { font-size: 9px; color: #d4af37; }

/* Dates & Amenities Deck */
.deck-card {
  background: #1c2541; border: 1px solid #3a506b; border-radius: 18px; padding: 14px;
  display: flex; flex-direction: column; gap: 12px; font-family: sans-serif;
}
.dates-row { display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #3a506b; padding-bottom: 10px; }
.d-cell { display: flex; flex-direction: column; }
.d-cell.right { text-align: right; }
.d-tag { font-size: 8px; font-weight: 800; color: #94a3b8; letter-spacing: 1px; }
.d-date { font-size: 13px; font-weight: 900; color: #d4af37; }
.d-center-badge { font-size: 9px; font-weight: 900; background: #0b132b; color: #ffffff; padding: 4px 10px; border-radius: 8px; border: 1px solid #3a506b; }

.amenities-gold-tags { display: flex; flex-wrap: wrap; gap: 6px; }
.gold-amenity { font-size: 9px; font-weight: 800; color: #d4af37; background: #0b132b; padding: 4px 8px; border-radius: 6px; }

/* Floating Bar */
.editorial-floating-bar {
  position: fixed; bottom: 0; left: 0; right: 0;
  background: rgba(8, 14, 33, 0.95);
  backdrop-filter: blur(14px);
  border-top: 1px solid #3a506b;
  padding: 14px 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  z-index: 90;
  font-family: sans-serif;
}
.price-col { display: flex; flex-direction: column; }
.p-sub { font-size: 9px; color: #94a3b8; font-weight: 800; }
.p-main { font-size: 20px; font-weight: 900; color: #d4af37; }
.btn-gold-reserve { background: #d4af37 !important; border-color: #d4af37 !important; color: black !important; font-weight: 900 !important; }

.lang-sheet-box { padding: 16px 20px 24px 20px; background: #1c2541; color: white; }
.l-list { display: flex; flex-direction: column; gap: 8px; margin-top: 10px; }
.l-item { display: flex; justify-content: space-between; padding: 10px; border-radius: 10px; border: 1px solid #3a506b; cursor: pointer; }
.l-item.active { border-color: #d4af37; background: #0b132b; color: #d4af37; font-weight: 700; }
</style>
