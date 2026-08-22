<template>
  <div class="my-passes-view">
    <div class="nav-bar">
      <button class="nav-back-btn" @click="$router.push('/')">
        <svg viewBox="0 0 24 24" width="22" height="22" stroke="currentColor" stroke-width="2.5" fill="none">
          <line x1="19" y1="12" x2="5" y2="12"></line>
          <polyline points="12 19 5 12 12 5"></polyline>
        </svg>
      </button>
      <h2 class="nav-title">{{ t.myPasses }}</h2>
      <button class="nav-exit-btn" @click="$router.push('/')">✕</button>
    </div>

    <div class="content-scroll">
      <div v-if="store.state.bookings.length > 0" class="passes-list">
        <div v-for="b in store.state.bookings" :key="b.id" class="pass-mini-card" @click="$router.push(`/confirmation/${b.id}`)">
          <div class="pass-left">
            <span class="p-emoji">🎬</span>
            <div class="p-info">
              <span class="p-title">{{ b.movie.title }}</span>
              <span class="p-seats">Seats: {{ b.seats.join(', ') }} • {{ b.showtime.time }}</span>
              <span class="p-date">{{ b.visitDate }} • {{ b.cinemaBranch }}</span>
            </div>
          </div>
          <span class="p-arrow">→</span>
        </div>
      </div>

      <div v-else class="empty-passes">
        <span class="empty-icon">🎟️</span>
        <p>No movie tickets booked yet.</p>
        <button class="btn-book-now" @click="$router.push('/')">{{ t.nowShowing }}</button>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { useCinemaStore } from '../store/cinemaStore'
import { useI18n } from '../i18n'

const store = useCinemaStore()
const { t } = useI18n()
</script>

<style scoped>
.my-passes-view { min-height: 100vh; background-color: #0f172a; color: #ffffff; }
.nav-bar {
  display: flex; align-items: center; justify-content: space-between;
  padding: 12px 16px; background-color: #1e293b; border-bottom: 1px solid #334155;
}
.nav-back-btn, .nav-exit-btn { background: none; border: none; color: white; cursor: pointer; }
.nav-title { margin: 0; font-size: 16px; font-weight: 800; }
.content-scroll { padding: 16px; }

.passes-list { display: flex; flex-direction: column; gap: 12px; }
.pass-mini-card {
  background: #1e293b; border-radius: 14px; padding: 12px 14px;
  display: flex; align-items: center; justify-content: space-between;
  border: 1px solid #334155; cursor: pointer;
}
.pass-left { display: flex; align-items: center; gap: 10px; }
.p-emoji { font-size: 24px; }
.p-info { display: flex; flex-direction: column; }
.p-title { font-size: 14px; font-weight: 800; color: #f8fafc; }
.p-seats { font-size: 11px; color: #f59e0b; font-weight: 700; }
.p-date { font-size: 10px; color: #94a3b8; }
.p-arrow { color: #64748b; font-size: 16px; font-weight: 800; }

.empty-passes { text-align: center; padding: 50px 20px; color: #94a3b8; }
.empty-icon { font-size: 40px; display: block; margin-bottom: 8px; }
.btn-book-now {
  margin-top: 12px; background: #f59e0b; color: #000000;
  border: none; padding: 8px 16px; border-radius: 10px; font-weight: 800; cursor: pointer;
}
</style>
