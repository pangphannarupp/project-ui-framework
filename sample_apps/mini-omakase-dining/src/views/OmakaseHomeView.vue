<template>
  <div class="omakase-wabi-root">
    <!-- Wabi-Sabi Top Navigation -->
    <header class="hinoki-header">
      <div class="hinoki-brand">
        <span class="chopsticks-icon">🍣</span>
        <div class="hinoki-titles">
          <span class="hinoki-tag">MASTER CHEF COUNTER // EDOMAE</span>
          <h1 class="hinoki-name">HINOKI OMAKASE TABLE</h1>
        </div>
      </div>

      <div class="hinoki-actions">
        <button class="hinoki-pill" @click="showLangSheet = true">
          <span>{{ currentLangObj.flag }}</span>
          <span>{{ currentLangObj.code.toUpperCase() }}</span>
        </button>
        <button class="hinoki-pill cup-pill" @click="$router.push('/my-tickets')">
          <span>🍶</span>
          <span class="h-badge" v-if="store.state.bookings.length > 0">{{ store.state.bookings.length }}</span>
        </button>
        <button class="hinoki-pill exit-pill" @click="showExitConfirm = true">✕</button>
      </div>
    </header>

    <main class="hinoki-viewport">
      <!-- Circular Chef's Counter Seating Chart Stage -->
      <section class="counter-seating-stage">
        <div class="counter-frame">
          <div class="chef-prep-stage">
            <span class="chef-badge">🔪 MASTER CHEF PREP BLOCK</span>
          </div>

          <div class="circular-seats-arc">
            <div 
              v-for="s in OMAKASE_SEATS"
              :key="s.seatNumber"
              class="seat-wood-pod"
              :class="{
                reserved: s.isReserved,
                selected: store.state.selectedSeat.seatNumber === s.seatNumber
              }"
              @click="!s.isReserved && (store.state.selectedSeat = s)"
            >
              <span class="seat-cushion-circle"></span>
              <span class="seat-label">SEAT 0{{ s.seatNumber }}</span>
              <span class="pos-tag">{{ s.position === 'CHEF_CENTER' ? '★ CENTER' : 'SIDE' }}</span>
            </div>
          </div>
        </div>
      </section>

      <!-- 12-Course Seasonal Tasting Menu Scroll Deck -->
      <section class="tasting-menu-deck">
        <span class="section-gold-tag">HIGHLIGHTS OF 12-COURSE TASTING</span>
        <div class="courses-scroll-track">
          <div 
            v-for="c in TASTING_COURSES"
            :key="c.courseNumber"
            class="course-scroll-card"
          >
            <div class="c-head-row">
              <span class="course-num">COURSE 0{{ c.courseNumber }}</span>
              <span class="sake-tag">🍶 {{ c.sakePairing }}</span>
            </div>
            <h4 class="course-title">{{ c.name[currentLanguage] || c.name.en }}</h4>
            <span class="course-ingr">{{ c.ingredient }}</span>
          </div>
        </div>
      </section>

      <!-- Junmai Sake Pairing & Guests Console -->
      <section class="sake-guest-console">
        <div class="console-box">
          <div class="c-row">
            <div class="r-info">
              <span class="r-title">JUNMAI DAIGINJO SAKE PAIRING</span>
              <span class="r-sub">6 Rare seasonal sakes curated for each dish</span>
            </div>
            <button 
              class="sake-toggle-btn"
              :class="{ active: store.state.sakePairingIncluded }"
              @click="store.state.sakePairingIncluded = !store.state.sakePairingIncluded"
            >
              {{ store.state.sakePairingIncluded ? '+$65 / GUEST' : 'ADD PAIRING' }}
            </button>
          </div>

          <div class="c-row guest-row">
            <span class="r-title">DINING PARTY SIZE</span>
            <div class="guest-counter">
              <button @click="store.state.guestCount = Math.max(1, store.state.guestCount - 1)">-</button>
              <span>{{ store.state.guestCount }} GUESTS</span>
              <button @click="store.state.guestCount = Math.min(4, store.state.guestCount + 1)">+</button>
            </div>
          </div>
        </div>
      </section>
    </main>

    <!-- Floating Reservation Invitation Bar -->
    <footer class="hinoki-floating-bar">
      <div class="fee-col">
        <span class="f-lbl">{{ store.state.guestCount }} Guests • {{ store.state.selectedSeatingTime.split(' ')[0] }}</span>
        <span class="f-total">${{ store.totalCost.value.toFixed(2) }}</span>
      </div>
      <PPButton variant="primary" size="large" @click="handleProceed" class="btn-reserve-counter">
        <span>Reserve Omakase Table 🍣</span>
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
import { useOmakaseStore } from '../store/omakaseStore'
import { OMAKASE_SEATS, TASTING_COURSES } from '../data/omakaseData'
import { useI18n } from '../i18n'
import '@/lib/mini.app.lib.js'

const MiniApp = (window as any).MiniApp
const store = useOmakaseStore()
const { t, currentLanguage, currentLangObj, supportedLanguages, setLanguage } = useI18n()

const showLangSheet = ref(false)
const showExitConfirm = ref(false)

const handleProceed = () => {
  router.push('/checkout')
}

const confirmExit = () => {
  if (MiniApp?.exit) MiniApp.exit(false)
  else window.history.back()
}
</script>

<style scoped>
.omakase-wabi-root {
  min-height: 100vh;
  background-color: #141210;
  color: #f7f3ee;
  display: flex;
  flex-direction: column;
  padding-bottom: 96px;
  font-family: -apple-system, BlinkMacSystemFont, "Georgia", serif;
}

/* Hinoki Header */
.hinoki-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px;
  background: #1c1917;
  border-bottom: 2px solid #292524;
}
.hinoki-brand { display: flex; align-items: center; gap: 10px; }
.chopsticks-icon {
  font-size: 18px; background: #c2a688; color: black; width: 36px; height: 36px;
  border-radius: 10px; display: flex; align-items: center; justify-content: center;
}
.hinoki-titles { display: flex; flex-direction: column; }
.hinoki-tag { font-size: 8px; font-weight: 900; letter-spacing: 1.5px; color: #c2a688; }
.hinoki-name { font-size: 13px; font-weight: 900; margin: 0; color: #ffffff; }

.hinoki-actions { display: flex; gap: 6px; }
.hinoki-pill {
  background: #292524;
  border: 1px solid #44403c;
  padding: 6px 12px;
  border-radius: 20px;
  font-size: 10px;
  font-weight: 800;
  color: #c2a688;
  cursor: pointer;
  display: flex;
  align-items: center;
  gap: 4px;
}
.cup-pill { position: relative; }
.h-badge {
  position: absolute; top: -4px; right: -4px;
  background: #c2a688; color: black; font-size: 8px; font-weight: 900;
  width: 14px; height: 14px; border-radius: 50%; display: flex; align-items: center; justify-content: center;
}
.exit-pill { background: #450a0a; color: #ef4444; border: none; }

.hinoki-viewport { padding: 16px; display: flex; flex-direction: column; gap: 14px; }

/* Counter Seating Stage */
.counter-frame {
  background: #1c1917; border: 2px solid #292524; border-radius: 20px; padding: 16px;
  display: flex; flex-direction: column; align-items: center; gap: 14px;
}
.chef-prep-stage {
  background: #292524; border: 1px dashed #c2a688; padding: 6px 16px; border-radius: 20px;
}
.chef-badge { font-size: 9px; font-weight: 900; color: #c2a688; letter-spacing: 1px; }

.circular-seats-arc { display: grid; grid-template-columns: repeat(3, 1fr); gap: 10px; width: 100%; }
.seat-wood-pod {
  background: #141210; border: 1.5px solid #292524; border-radius: 14px; padding: 10px;
  display: flex; flex-direction: column; align-items: center; gap: 4px; cursor: pointer; transition: all 0.2s;
}
.seat-wood-pod.selected { border-color: #c2a688; box-shadow: 0 0 15px rgba(194,166,136,0.3); transform: translateY(-2px); }
.seat-wood-pod.reserved { opacity: 0.4; cursor: not-allowed; }

.seat-cushion-circle { width: 24px; height: 24px; border-radius: 50%; background: #44403c; }
.seat-label { font-size: 11px; font-weight: 900; color: #ffffff; font-family: monospace; }
.pos-tag { font-size: 8px; color: #c2a688; }

/* Tasting Menu Deck */
.section-gold-tag { font-size: 9px; font-weight: 900; letter-spacing: 1.5px; color: #c2a688; }
.courses-scroll-track { display: flex; gap: 10px; overflow-x: auto; padding: 4px 0; }
.course-scroll-card {
  background: #1c1917; border: 1px solid #292524; border-radius: 16px; padding: 14px;
  min-width: 220px; display: flex; flex-direction: column; gap: 6px;
}
.c-head-row { display: flex; justify-content: space-between; font-size: 8px; font-weight: 900; }
.course-num { color: #c2a688; }
.sake-tag { color: #a8a29e; }
.course-title { font-size: 13px; font-weight: 900; margin: 0; color: #ffffff; }
.course-ingr { font-size: 10px; color: #a8a29e; font-family: sans-serif; }

/* Console */
.console-box { background: #1c1917; border-radius: 18px; padding: 16px; border: 1px solid #292524; display: flex; flex-direction: column; gap: 12px; }
.c-row { display: flex; justify-content: space-between; align-items: center; }
.r-info { display: flex; flex-direction: column; }
.r-title { font-size: 10px; font-weight: 900; color: #c2a688; }
.r-sub { font-size: 9px; color: #a8a29e; font-family: sans-serif; }
.sake-toggle-btn {
  border: 1px solid #c2a688; background: #141210; color: #c2a688; padding: 6px 12px;
  border-radius: 8px; font-size: 9px; font-weight: 900; cursor: pointer;
}
.sake-toggle-btn.active { background: #c2a688; color: black; }

.guest-counter { display: flex; align-items: center; gap: 8px; background: #141210; padding: 4px 8px; border-radius: 8px; }
.guest-counter button { background: none; border: none; font-size: 16px; color: #c2a688; font-weight: 900; cursor: pointer; }
.guest-counter span { font-size: 10px; font-weight: 900; color: white; font-family: sans-serif; }

/* Floating Bar */
.hinoki-floating-bar {
  position: fixed; bottom: 0; left: 0; right: 0;
  background: rgba(28, 25, 23, 0.95);
  backdrop-filter: blur(14px);
  border-top: 1px solid #292524;
  padding: 14px 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  z-index: 90;
}
.fee-col { display: flex; flex-direction: column; }
.f-lbl { font-size: 9px; font-weight: 800; color: #a8a29e; font-family: sans-serif; }
.f-total { font-size: 20px; font-weight: 900; color: #c2a688; }
.btn-reserve-counter { background: #c2a688 !important; border-color: #c2a688 !important; color: black !important; font-weight: 900 !important; }

.lang-sheet-box { padding: 16px 20px 24px 20px; background: #1c1917; color: white; }
.l-list { display: flex; flex-direction: column; gap: 8px; margin-top: 10px; }
.l-item { display: flex; justify-content: space-between; padding: 10px; border-radius: 10px; border: 1px solid #292524; cursor: pointer; }
.l-item.active { border-color: #c2a688; background: #141210; color: #c2a688; font-weight: 700; }
</style>
