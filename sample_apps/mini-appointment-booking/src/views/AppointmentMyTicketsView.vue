<template>
  <div class="my-appointments-view">
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
      <div v-if="store.state.appointments.length > 0" class="apt-list">
        <div v-for="a in store.state.appointments" :key="a.id" class="apt-mini-card" @click="$router.push(`/confirmation/${a.id}`)">
          <div class="apt-head">
            <span class="srv-tag">{{ a.service.category }}</span>
            <span class="badge-status">CONFIRMED</span>
          </div>
          <h4 class="srv-n">{{ a.service.name }}</h4>
          <div class="apt-foot">
            <span>📅 {{ a.appointmentDate }} @ {{ a.timeSlot }}</span>
            <span>Deposit Paid: ${{ a.depositPaid.toFixed(2) }}</span>
          </div>
        </div>
      </div>
      <div v-else class="empty-state">
        <p>No appointments booked yet.</p>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { useAppointmentStore } from '../store/appointmentStore'
import { useI18n } from '../i18n'
const store = useAppointmentStore()
const { t } = useI18n()
</script>

<style scoped>
.my-appointments-view { min-height: 100vh; background-color: #f8fafc; }
.nav-bar {
  display: flex; align-items: center; justify-content: space-between;
  padding: 12px 16px; background: #ffffff; border-bottom: 1px solid #edf2f7;
}
.nav-back-btn, .nav-exit-btn { background: none; border: none; cursor: pointer; }
.nav-title { margin: 0; font-size: 16px; font-weight: 800; }
.content-scroll { padding: 16px; }

.apt-list { display: flex; flex-direction: column; gap: 12px; }
.apt-mini-card {
  background: #ffffff; border-radius: 14px; padding: 14px;
  border: 1px solid #e2e8f0; cursor: pointer;
}
.apt-head { display: flex; justify-content: space-between; margin-bottom: 4px; }
.srv-tag { font-size: 10px; font-weight: 800; color: #0d9488; text-transform: uppercase; }
.badge-status { font-size: 10px; font-weight: 800; background: #dcfce7; color: #166534; padding: 2px 6px; border-radius: 4px; }
.srv-n { font-size: 14px; font-weight: 800; margin: 0 0 6px 0; }
.apt-foot { display: flex; justify-content: space-between; font-size: 11px; color: #64748b; border-top: 1px solid #f1f5f9; padding-top: 6px; }
.empty-state { text-align: center; padding: 40px; color: #94a3b8; }
</style>
