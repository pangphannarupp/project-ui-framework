<template>
  <div class="cinema-home-view">
    <!-- Top Greeting Area -->
    <div class="greeting-area">
      <div class="top-row-header">
        <div class="user-greeting">
          <div class="cinema-avatar">🎬</div>
          <div class="chat-bubbles">
            <div class="bubble small">{{ t.appName }}</div>
            <div class="bubble large">{{ userName }}</div>
          </div>
        </div>

        <div class="header-right-actions">
          <button class="wallet-btn" @click="$router.push('/my-tickets')" aria-label="My Passes">
            <span>🎟️</span>
            <span class="count-badge" v-if="store.state.bookings.length > 0">{{ store.state.bookings.length }}</span>
          </button>

          <button class="lang-switch-btn" @click="showLangSheet = true">
            <span>{{ currentLangObj.flag }}</span>
            <span>{{ currentLangObj.name }}</span>
          </button>

          <button class="exit-icon-btn" @click="showExitConfirm = true">
            <svg viewBox="0 0 24 24" width="18" height="18" stroke="currentColor" stroke-width="2.5" fill="none">
              <line x1="18" y1="6" x2="6" y2="18"></line>
              <line x1="6" y1="6" x2="18" y2="18"></line>
            </svg>
          </button>
        </div>
      </div>

      <!-- Cinema Branch & Date -->
      <div class="cinema-branch-select">
        <span class="icon">📍</span>
        <select v-model="store.state.selectedBranch" class="select-branch">
          <option v-for="b in CINEMA_BRANCHES" :key="b" :value="b">{{ b }}</option>
        </select>
      </div>
    </div>

    <!-- Category Tabs -->
    <div class="category-scroll">
      <button class="category-chip active">{{ t.nowShowing }}</button>
      <button class="category-chip">{{ t.comingSoon }}</button>
    </div>

    <!-- Movies List -->
    <div class="movies-container">
      <div class="movie-card" v-for="movie in MOVIES_LIST" :key="movie.id" @click="selectMovie(movie)">
        <div class="poster-wrap">
          <img :src="movie.poster" :alt="movie.title" loading="lazy" />
          <span class="rating-badge">{{ movie.rating }}</span>
          <span class="duration-badge">{{ movie.duration }}</span>
        </div>

        <div class="movie-info">
          <h4 class="movie-title">{{ movie.title }}</h4>
          <span class="movie-genre">{{ movie.genre }}</span>
          
          <!-- Showtimes chips -->
          <div class="showtimes-row">
            <button 
              v-for="st in SHOWTIME_SLOTS.slice(0, 3)" 
              :key="st.id" 
              class="showtime-chip"
              :class="{ selected: store.state.selectedMovie.id === movie.id && store.state.selectedShowtime.id === st.id }"
              @click.stop="selectShowtime(movie, st)"
            >
              <span class="st-time">{{ st.time }}</span>
              <span class="st-price">${{ st.price.toFixed(2) }}</span>
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- Sticky Bottom Bar -->
    <div class="bottom-checkout-bar">
      <div class="cart-info">
        <div class="items-count-badge">
          <span>{{ store.state.selectedSeats.length }} {{ t.seats }}</span>
        </div>
        <div class="total-price-text">
          <span class="label">{{ t.total }}:</span>
          <span class="val">${{ store.grandTotal.value.toFixed(2) }}</span>
        </div>
      </div>
      <button class="checkout-btn" @click="$router.push('/checkout')">
        <span>{{ t.selectSeats }}</span>
        <svg viewBox="0 0 24 24" width="18" height="18" stroke="currentColor" stroke-width="2" fill="none">
          <line x1="5" y1="12" x2="19" y2="12"></line>
          <polyline points="12 5 19 12 12 19"></polyline>
        </svg>
      </button>
    </div>

    <!-- Language Sheet -->
    <PPBottomSheet v-model="showLangSheet">
      <div class="pos-lang-sheet">
        <h3>{{ t.selectLanguage }}</h3>
        <div class="lang-items-list">
          <div 
            v-for="l in supportedLanguages" 
            :key="l.code" 
            class="lang-item-row"
            :class="{ active: currentLanguage === l.code }"
            @click="setLanguage(l.code); showLangSheet = false"
          >
            <span>{{ l.flag }} {{ l.name }}</span>
            <div class="dot" v-if="currentLanguage === l.code"></div>
          </div>
        </div>
      </div>
    </PPBottomSheet>

    <!-- Exit confirm -->
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
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { PPBottomSheet, PPConfirm } from '@phanna/ui-framework'
import { useCinemaStore } from '../store/cinemaStore'
import { MOVIES_LIST, SHOWTIME_SLOTS, CINEMA_BRANCHES } from '../data/cinemaData'
import { useI18n } from '../i18n'
import type { MovieItem, ShowtimeSlot } from '../types/cinema'
import '@/lib/mini.app.lib.js'

const MiniApp = (window as any).MiniApp
const store = useCinemaStore()
const { t, currentLanguage, currentLangObj, supportedLanguages, setLanguage } = useI18n()

const userName = ref('MOVIE PASS GUEST')
const showLangSheet = ref(false)
const showExitConfirm = ref(false)

onMounted(async () => {
  try {
    if (MiniApp && typeof MiniApp.getUserProfile === 'function') {
      const p = await MiniApp.getUserProfile()
      if (p?.name) userName.value = p.name
    }
  } catch (e) {}
})

const selectMovie = (m: MovieItem) => {
  store.state.selectedMovie = m
}

const selectShowtime = (m: MovieItem, st: ShowtimeSlot) => {
  store.state.selectedMovie = m
  store.state.selectedShowtime = st
  router.push('/checkout')
}

const confirmExit = () => {
  if (MiniApp?.exit) MiniApp.exit(false)
  else window.history.back()
}
</script>

<style scoped>
.cinema-home-view {
  min-height: 100vh;
  background-color: #0f172a;
  color: #ffffff;
  padding-bottom: 84px;
}

.greeting-area {
  background-color: #1e293b;
  padding: 14px 16px;
  border-bottom: 1px solid #334155;
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.top-row-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.user-greeting {
  display: flex;
  align-items: center;
  gap: 10px;
}

.cinema-avatar {
  font-size: 24px;
  background: #f59e0b;
  width: 42px;
  height: 42px;
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.bubble.small { font-size: 11px; color: #94a3b8; }
.bubble.large { font-size: 15px; font-weight: 800; }

.header-right-actions { display: flex; align-items: center; gap: 8px; }

.wallet-btn {
  position: relative;
  background: #334155;
  border: none;
  border-radius: 10px;
  width: 36px;
  height: 36px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  color: white;
}

.count-badge {
  position: absolute;
  top: -4px;
  right: -4px;
  background: #ef4444;
  color: white;
  font-size: 10px;
  font-weight: 800;
  width: 16px;
  height: 16px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
}

.lang-switch-btn {
  display: flex;
  align-items: center;
  gap: 4px;
  background: #334155;
  border: 1px solid #475569;
  padding: 6px 10px;
  border-radius: 18px;
  font-size: 12px;
  color: white;
  cursor: pointer;
}

.exit-icon-btn {
  background: #fee2e2;
  border: none;
  color: #ef4444;
  width: 34px;
  height: 34px;
  border-radius: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
}

.cinema-branch-select {
  background: #0f172a;
  border: 1px solid #334155;
  border-radius: 10px;
  padding: 6px 10px;
  display: flex;
  align-items: center;
  gap: 6px;
}

.select-branch {
  background: transparent;
  border: none;
  color: #f1f5f9;
  font-size: 12px;
  font-weight: 700;
  width: 100%;
  outline: none;
}

.category-scroll {
  display: flex;
  gap: 8px;
  padding: 10px 16px;
  background: #1e293b;
  border-bottom: 1px solid #334155;
}

.category-chip {
  padding: 6px 14px;
  border-radius: 18px;
  border: 1px solid #475569;
  background: #0f172a;
  color: #94a3b8;
  font-size: 12px;
  font-weight: 700;
  cursor: pointer;
}

.category-chip.active {
  background: #f59e0b;
  color: #000000;
  border-color: #f59e0b;
}

.movies-container {
  padding: 14px 16px;
  display: flex;
  flex-direction: column;
  gap: 14px;
}

.movie-card {
  background: #1e293b;
  border-radius: 16px;
  overflow: hidden;
  display: flex;
  gap: 12px;
  padding: 12px;
  border: 1px solid #334155;
  cursor: pointer;
}

.poster-wrap {
  width: 90px;
  height: 130px;
  border-radius: 10px;
  overflow: hidden;
  position: relative;
  flex-shrink: 0;
}

.poster-wrap img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.rating-badge {
  position: absolute;
  top: 4px;
  left: 4px;
  background: rgba(0,0,0,0.7);
  font-size: 9px;
  font-weight: 800;
  padding: 2px 4px;
  border-radius: 4px;
}

.duration-badge {
  position: absolute;
  bottom: 4px;
  right: 4px;
  background: rgba(0,0,0,0.7);
  font-size: 9px;
  padding: 2px 4px;
  border-radius: 4px;
}

.movie-info {
  flex: 1;
  display: flex;
  flex-direction: column;
}

.movie-title {
  font-size: 15px;
  font-weight: 800;
  margin: 0 0 2px 0;
  color: #f8fafc;
}

.movie-genre {
  font-size: 11px;
  color: #f59e0b;
  margin-bottom: 8px;
}

.showtimes-row {
  display: flex;
  gap: 6px;
  flex-wrap: wrap;
  margin-top: auto;
}

.showtime-chip {
  background: #0f172a;
  border: 1px solid #475569;
  border-radius: 8px;
  padding: 4px 8px;
  display: flex;
  flex-direction: column;
  align-items: center;
  cursor: pointer;
  color: white;
}

.showtime-chip.selected {
  border-color: #f59e0b;
  background: rgba(245, 158, 11, 0.2);
}

.st-time { font-size: 11px; font-weight: 800; }
.st-price { font-size: 9px; color: #94a3b8; }

.bottom-checkout-bar {
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  background: #1e293b;
  border-top: 1px solid #334155;
  padding: 12px 16px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  z-index: 90;
}

.items-count-badge {
  background: rgba(245, 158, 11, 0.2);
  color: #f59e0b;
  font-size: 11px;
  font-weight: 800;
  padding: 4px 8px;
  border-radius: 6px;
}

.total-price-text { display: flex; flex-direction: column; }
.total-price-text .label { font-size: 10px; color: #94a3b8; }
.total-price-text .val { font-size: 16px; font-weight: 900; color: #f59e0b; }

.checkout-btn {
  background: #f59e0b;
  color: #000000;
  border: none;
  padding: 10px 18px;
  border-radius: 12px;
  font-size: 14px;
  font-weight: 800;
  display: flex;
  align-items: center;
  gap: 6px;
  cursor: pointer;
}

.pos-lang-sheet { padding: 16px 20px 24px 20px; }
.lang-items-list { display: flex; flex-direction: column; gap: 8px; margin-top: 12px; }
.lang-item-row {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 10px;
  border-radius: 10px;
  border: 1px solid #e2e8f0;
  cursor: pointer;
}
.lang-item-row.active { border-color: #f59e0b; background: #fffbeb; }
.dot { width: 8px; height: 8px; border-radius: 50%; background: #f59e0b; }
</style>
