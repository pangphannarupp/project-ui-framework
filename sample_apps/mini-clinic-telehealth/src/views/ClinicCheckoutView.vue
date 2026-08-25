<template>
  <div class="clinic-checkout-root">
    <header class="chk-header">
      <button class="back-btn" @click="$router.back()">←</button>
      <h2>{{ t.bookingSummary }}</h2>
      <div style="width: 32px"></div>
    </header>

    <main class="chk-body">
      <div class="summary-doctor-card">
        <img :src="store.state.selectedDoctor.avatarUrl" class="s-avatar" />
        <div class="s-info">
          <h3>{{ store.state.selectedDoctor.name[currentLanguage] || store.state.selectedDoctor.name.en }}</h3>
          <span class="s-spec">{{ store.state.selectedDoctor.specialty[currentLanguage] || store.state.selectedDoctor.specialty.en }}</span>
          <span class="s-time">⚡ Ready at: {{ store.state.selectedDoctor.nextAvailableTime }}</span>
        </div>
      </div>

      <div class="intake-review-card">
        <h4 class="card-head">{{ t.patientIntake }}</h4>
        <div class="rev-item">
          <span>Target Area:</span>
          <strong>{{ store.state.intake.bodyZone }}</strong>
        </div>
        <div class="rev-item">
          <span>Triage Level:</span>
          <strong :class="store.state.intake.urgencyLevel.toLowerCase()">{{ store.state.intake.urgencyLevel }}</strong>
        </div>
        <div class="rev-item">
          <span>Notes:</span>
          <p class="notes-txt">{{ store.state.intake.symptomNotes }}</p>
        </div>
      </div>

      <div class="price-breakdown-card">
        <div class="p-row">
          <span>Specialist Consultation:</span>
          <span>${{ store.state.selectedDoctor.consultFee.toFixed(2) }}</span>
        </div>
        <div class="p-row" v-if="store.state.intake.urgencyLevel === 'URGENT'">
          <span>Urgent Triage Fee:</span>
          <span>+$15.00</span>
        </div>
        <div class="p-row total">
          <span>Total Fee:</span>
          <span>${{ store.totalCost.value.toFixed(2) }}</span>
        </div>
      </div>
    </main>

    <footer class="chk-footer">
      <PPButton variant="primary" block size="large" @click="handlePay">
        {{ t.confirmAndPay }} • ${{ store.totalCost.value.toFixed(2) }} ⚡
      </PPButton>
    </footer>
  </div>
</template>

<script setup lang="ts">
import { useRouter } from 'vue-router'
import { PPButton } from '@phanna/ui-framework'
import { useClinicStore } from '../store/clinicStore'
import { useI18n } from '../i18n'

const router = useRouter()
const store = useClinicStore()
const { t, currentLanguage } = useI18n()

const handlePay = () => {
  store.confirmBooking()
  router.push('/status')
}
</script>

<style scoped>
.clinic-checkout-root {
  min-height: 100vh;
  background: #f8fafc;
  color: #0f172a;
  display: flex;
  flex-direction: column;
  padding-bottom: 96px;
}
.chk-header {
  display: flex; justify-content: space-between; align-items: center; padding: 16px;
  background: white; border-bottom: 1px solid #e2e8f0;
}
.back-btn { background: none; border: none; font-size: 20px; cursor: pointer; }
.chk-header h2 { font-size: 15px; font-weight: 900; margin: 0; }

.chk-body { padding: 16px; display: flex; flex-direction: column; gap: 14px; }
.summary-doctor-card {
  background: white; border-radius: 16px; padding: 14px; display: flex; gap: 12px;
  border: 1px solid #e2e8f0; align-items: center;
}
.s-avatar { width: 50px; height: 50px; border-radius: 12px; object-fit: cover; }
.s-info h3 { font-size: 14px; font-weight: 900; margin: 0; }
.s-spec { font-size: 11px; color: #0284c7; font-weight: 700; }
.s-time { font-size: 10px; color: #16a34a; font-weight: 800; display: block; margin-top: 2px; }

.intake-review-card, .price-breakdown-card {
  background: white; border-radius: 16px; padding: 14px; border: 1px solid #e2e8f0;
  display: flex; flex-direction: column; gap: 8px;
}
.card-head { font-size: 12px; font-weight: 900; color: #64748b; margin: 0 0 4px 0; }
.rev-item { display: flex; justify-content: space-between; font-size: 11px; }
.notes-txt { font-size: 11px; color: #475569; margin: 4px 0 0 0; }

.p-row { display: flex; justify-content: space-between; font-size: 12px; color: #475569; }
.p-row.total { font-size: 16px; font-weight: 900; color: #0f172a; border-top: 1px solid #e2e8f0; padding-top: 8px; }

.chk-footer {
  position: fixed; bottom: 0; left: 0; right: 0; background: white; padding: 16px;
  border-top: 1px solid #e2e8f0;
}
</style>
