<template>
  <div class="pass-view">
    <div class="nav-bar">
      <button class="nav-back-btn" @click="$router.push('/')">
        <svg viewBox="0 0 24 24" width="22" height="22" stroke="currentColor" stroke-width="2.5" fill="none">
          <line x1="19" y1="12" x2="5" y2="12"></line>
          <polyline points="12 19 5 12 12 5"></polyline>
        </svg>
      </button>
      <h2 class="nav-title">Appointment Confirmed</h2>
      <button class="nav-exit-btn" @click="$router.push('/')">✕</button>
    </div>

    <div class="content-scroll" v-if="apt">
      <div class="apt-card">
        <div class="apt-top">
          <span class="apt-badge">{{ apt.service.clinicName }}</span>
          <h3 class="apt-srv-title">{{ apt.service.name }}</h3>
          <span class="apt-spec">Specialist: {{ apt.service.specialist }}</span>
        </div>

        <div class="apt-body">
          <div class="meta-grid">
            <div class="meta-item">
              <span class="lbl">PATIENT</span>
              <span class="val">{{ apt.patientName }}</span>
            </div>
            <div class="meta-item">
              <span class="lbl">DATE & TIME</span>
              <span class="val highlight">{{ apt.appointmentDate }} @ {{ apt.timeSlot }}</span>
            </div>
            <div class="meta-item">
              <span class="lbl">DEPOSIT PAID</span>
              <span class="val">${{ apt.depositPaid.toFixed(2) }}</span>
            </div>
            <div class="meta-item">
              <span class="lbl">STATUS</span>
              <span class="val status-ok">CONFIRMED</span>
            </div>
          </div>

          <div class="qr-box">
            <p class="qr-hint">Scan at clinic front desk for fast check-in</p>
            <PPQRCode :value="apt.qrValue" :size="120" foreground="#0f172a" background="#ffffff" />
            <span class="apt-code">{{ apt.appointmentCode }}</span>
          </div>
        </div>
      </div>

      <div class="action-buttons">
        <button class="btn-wallet" @click="$router.push('/my-tickets')">{{ t.myPasses }}</button>
        <button class="btn-home" @click="$router.push('/')">Book Another Service</button>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import { PPQRCode } from '@phanna/ui-framework'
import { useAppointmentStore } from '../store/appointmentStore'
import { useI18n } from '../i18n'
import type { AppointmentRecord } from '../types/appointment'

const route = useRoute()
const store = useAppointmentStore()
const { t } = useI18n()
const apt = ref<AppointmentRecord | null>(null)

onMounted(() => {
  const id = route.params.id as string
  if (id) apt.value = store.state.appointments.find(a => a.id === id) || null
  if (!apt.value) apt.value = store.state.currentAppointment || store.state.appointments[0] || null
})
</script>

<style scoped>
.pass-view { min-height: 100vh; background-color: #f8fafc; }
.nav-bar {
  display: flex; align-items: center; justify-content: space-between;
  padding: 12px 16px; background: #ffffff; border-bottom: 1px solid #edf2f7;
}
.nav-back-btn, .nav-exit-btn { background: none; border: none; cursor: pointer; }
.nav-title { margin: 0; font-size: 16px; font-weight: 800; }
.content-scroll { padding: 16px; display: flex; flex-direction: column; gap: 16px; }

.apt-card {
  background: #ffffff; border-radius: 20px; overflow: hidden;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08); border: 1px solid #e2e8f0;
}

.apt-top { background: linear-gradient(135deg, #0d9488 0%, #0f766e 100%); color: white; padding: 18px; }
.apt-badge { font-size: 10px; font-weight: 800; background: rgba(255,255,255,0.2); padding: 3px 6px; border-radius: 4px; }
.apt-srv-title { font-size: 16px; font-weight: 900; margin: 6px 0 2px 0; }
.apt-spec { font-size: 11px; opacity: 0.9; }

.apt-body { padding: 16px; }
.meta-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 10px; margin-bottom: 16px; }
.meta-item { display: flex; flex-direction: column; }
.lbl { font-size: 9px; font-weight: 800; color: #94a3b8; }
.val { font-size: 12px; font-weight: 800; color: #0f172a; }
.val.highlight { color: #0d9488; }
.val.status-ok { color: #166534; }

.qr-box { display: flex; flex-direction: column; align-items: center; gap: 6px; }
.qr-hint { font-size: 11px; color: #64748b; margin: 0; }
.apt-code { font-family: monospace; font-size: 12px; font-weight: 800; color: #64748b; }

.action-buttons { display: flex; flex-direction: column; gap: 8px; }
.btn-wallet { background: #ffffff; border: 1px solid #cbd5e1; padding: 12px; border-radius: 12px; font-weight: 700; cursor: pointer; }
.btn-home { background: #0d9488; color: white; border: none; padding: 12px; border-radius: 12px; font-weight: 800; cursor: pointer; }
</style>
