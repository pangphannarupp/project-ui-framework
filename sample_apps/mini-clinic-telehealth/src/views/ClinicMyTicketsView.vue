<template>
  <div class="clinic-tickets-root">
    <header class="t-header">
      <button class="back-btn" @click="$router.push('/')">←</button>
      <h2>{{ t.myPasses }}</h2>
      <div style="width: 32px"></div>
    </header>

    <main class="t-body">
      <div v-if="store.state.appointments.length === 0" class="no-tickets-box">
        <span class="empty-emoji">🩺</span>
        <p>{{ t.noPasses }}</p>
        <PPButton variant="primary" size="medium" @click="$router.push('/')">
          {{ t.bookFirst }}
        </PPButton>
      </div>

      <div v-else class="tickets-column">
        <div 
          v-for="a in store.state.appointments" 
          :key="a.id"
          class="appt-ticket-card"
        >
          <div class="card-head">
            <span class="order-ref">{{ a.orderNumber }}</span>
            <span class="status-badge">{{ a.status }}</span>
          </div>

          <div class="card-doctor">
            <img :src="a.doctor.avatarUrl" class="c-avatar" />
            <div class="c-meta">
              <h4>{{ a.doctor.name[currentLanguage] || a.doctor.name.en }}</h4>
              <span>{{ a.doctor.specialty[currentLanguage] || a.doctor.specialty.en }}</span>
            </div>
          </div>

          <div class="card-footer">
            <span class="fee-text">${{ a.totalFee.toFixed(2) }}</span>
            <PPButton variant="primary" size="small" @click="store.state.latestAppointment = a; $router.push('/status')">
              Open Room 🩺
            </PPButton>
          </div>
        </div>
      </div>
    </main>
  </div>
</template>

<script setup lang="ts">
import { useRouter } from 'vue-router'
import { PPButton } from '@phanna/ui-framework'
import { useClinicStore } from '../store/clinicStore'
import { useI18n } from '../i18n'

const store = useClinicStore()
const { t, currentLanguage } = useI18n()
</script>

<style scoped>
.clinic-tickets-root { min-height: 100vh; background: #f8fafc; color: #0f172a; }
.t-header {
  display: flex; justify-content: space-between; align-items: center; padding: 16px;
  background: white; border-bottom: 1px solid #e2e8f0;
}
.back-btn { background: none; border: none; font-size: 20px; cursor: pointer; }
.t-header h2 { font-size: 15px; font-weight: 900; margin: 0; }

.t-body { padding: 16px; }
.no-tickets-box { display: flex; flex-direction: column; align-items: center; gap: 10px; margin-top: 40px; }
.empty-emoji { font-size: 40px; }

.tickets-column { display: flex; flex-direction: column; gap: 12px; }
.appt-ticket-card {
  background: white; border-radius: 16px; padding: 14px; border: 1px solid #e2e8f0;
  display: flex; flex-direction: column; gap: 10px;
}
.card-head { display: flex; justify-content: space-between; font-size: 10px; font-weight: 800; }
.order-ref { font-family: monospace; color: #64748b; }
.status-badge { color: #16a34a; background: #dcfce7; padding: 2px 6px; border-radius: 4px; }

.card-doctor { display: flex; gap: 10px; align-items: center; }
.c-avatar { width: 40px; height: 40px; border-radius: 10px; object-fit: cover; }
.c-meta h4 { font-size: 12px; font-weight: 900; margin: 0; }
.c-meta span { font-size: 10px; color: #0284c7; }

.card-footer {
  display: flex; justify-content: space-between; align-items: center;
  border-top: 1px solid #f1f5f9; padding-top: 8px;
}
.fee-text { font-size: 13px; font-weight: 900; color: #0f172a; }
</style>
