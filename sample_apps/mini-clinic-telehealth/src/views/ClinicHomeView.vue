<template>
  <div class="clinic-telehealth-root">
    <!-- Clean Medical Top Navigation -->
    <header class="clinic-nav-header">
      <div class="clinic-brand">
        <span class="cross-icon">➕</span>
        <div class="clinic-titles">
          <span class="clinic-tag">SWISS TELEHEALTH TELEMETRY</span>
          <h1 class="clinic-name">GENEVA CARE CLINIC</h1>
        </div>
      </div>

      <div class="clinic-actions">
        <button class="clinic-pill" @click="showLangSheet = true">
          <span>{{ currentLangObj.flag }}</span>
          <span>{{ currentLangObj.code.toUpperCase() }}</span>
        </button>
        <button class="clinic-pill rx-pill" @click="$router.push('/my-tickets')">
          <span>🩺</span>
          <span class="rx-badge" v-if="store.state.appointments.length > 0">{{ store.state.appointments.length }}</span>
        </button>
        <button class="clinic-pill exit-pill" @click="showExitConfirm = true">✕</button>
      </div>
    </header>

    <main class="clinic-viewport">
      <!-- 3D Interactive Anatomy Body Map & Symptom Zone Selector -->
      <section class="anatomy-triage-stage">
        <div class="anatomy-card">
          <div class="triage-top">
            <span class="triage-title">🫀 INTERACTIVE ANATOMY TRIAGE</span>
            <span class="triage-sub">TAP BODY ZONE TO LOCATE SPECIALIST</span>
          </div>

          <!-- Anatomical Body Map Selector -->
          <div class="body-zone-grid">
            <button 
              v-for="zone in [
                { id: 'HEAD', label: '🧠 Neuro & Head', icon: '💆' },
                { id: 'CHEST', label: '🫁 Cardio & Lungs', icon: '🫀' },
                { id: 'SKIN', label: '✨ Dermal & Barrier', icon: '🧴' },
                { id: 'JOINTS', label: '🦴 Spine & Joints', icon: '🏃' }
              ]"
              :key="zone.id"
              class="zone-btn"
              :class="{ active: store.state.intake.bodyZone === zone.id }"
              @click="store.state.intake.bodyZone = zone.id as any"
            >
              <span class="z-icon">{{ zone.icon }}</span>
              <span class="z-lbl">{{ zone.label }}</span>
            </button>
          </div>
        </div>
      </section>

      <!-- Live Doctor Queue & Triage Radar -->
      <section class="doctor-radar-section">
        <div class="radar-head">
          <span class="radar-tag">ON-CALL SPECIALISTS (LIVE AVAILABILITY)</span>
          <span class="live-dot">● 4 DOCTORS ONLINE</span>
        </div>

        <div class="doctors-column">
          <div 
            v-for="doc in filteredDoctors" 
            :key="doc.id"
            class="doctor-pod"
            :class="{ active: store.state.selectedDoctor.id === doc.id }"
            @click="store.state.selectedDoctor = doc"
          >
            <div class="doc-avatar-wrap">
              <img :src="doc.avatarUrl" :alt="doc.name.en" />
              <span class="online-indicator"></span>
            </div>

            <div class="doc-info-col">
              <div class="doc-row-1">
                <h3 class="doc-name">{{ doc.name[currentLanguage] || doc.name.en }}</h3>
                <span class="doc-fee">${{ doc.consultFee.toFixed(2) }}</span>
              </div>
              <span class="doc-spec">{{ doc.specialty[currentLanguage] || doc.specialty.en }}</span>
              <span class="doc-hosp">🏥 {{ doc.hospital }}</span>

              <div class="doc-telemetry">
                <span class="rating-tag">★ {{ doc.rating }} ({{ doc.reviewsCount }})</span>
                <span class="avail-tag">⚡ {{ doc.nextAvailableTime }}</span>
              </div>
            </div>
          </div>
        </div>
      </section>

      <!-- Rapid Intake & Urgency Selector -->
      <section class="intake-urgency-section">
        <div class="intake-card">
          <span class="intake-label">SYMPTOM DESCRIPTION</span>
          <PPInput v-model="store.state.intake.symptomNotes" placeholder="Describe symptoms (e.g. fever, headache duration)..." />

          <div class="urgency-row">
            <span class="u-lbl">Triage Priority</span>
            <div class="urgency-pills">
              <button 
                v-for="u in ['LOW', 'NORMAL', 'URGENT']" 
                :key="u" 
                class="u-pill"
                :class="{ active: store.state.intake.urgencyLevel === u, urgent: u === 'URGENT' }"
                @click="store.state.intake.urgencyLevel = u as any"
              >
                {{ u === 'URGENT' ? '🚨 Urgent (+ $15)' : u }}
              </button>
            </div>
          </div>
        </div>
      </section>
    </main>

    <!-- Floating Medical Consult Bar -->
    <footer class="clinic-floating-bar">
      <div class="fee-col">
        <span class="f-lbl">Video Consultation Fee</span>
        <span class="f-total">${{ store.totalCost.value.toFixed(2) }}</span>
      </div>
      <PPButton variant="primary" size="large" @click="handleProceedToConsult" class="btn-doctor-book">
        <span>Connect with Doctor 🩺</span>
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
import { PPBottomSheet, PPConfirm, PPInput, PPButton } from '@phanna/ui-framework'
import { useClinicStore } from '../store/clinicStore'
import { DOCTORS_LIST } from '../data/clinicData'
import { useI18n } from '../i18n'
import '@/lib/mini.app.lib.js'

const router = useRouter()
const MiniApp = (window as any).MiniApp
const store = useClinicStore()
const { t, currentLanguage, currentLangObj, supportedLanguages, setLanguage } = useI18n()

const showLangSheet = ref(false)
const showExitConfirm = ref(false)

const filteredDoctors = computed(() => {
  return DOCTORS_LIST.filter(d => d.focusBodyZone === store.state.intake.bodyZone)
})

const handleProceedToConsult = () => {
  router.push('/checkout')
}

const confirmExit = () => {
  if (MiniApp?.exit) MiniApp.exit(false)
  else window.history.back()
}
</script>

<style scoped>
.clinic-telehealth-root {
  min-height: 100vh;
  background: radial-gradient(circle at 50% 10%, #f0fdfa 0%, #e0f2fe 100%);
  color: #0f172a;
  display: flex;
  flex-direction: column;
  padding-bottom: 96px;
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
}

/* Clinic Nav Header */
.clinic-nav-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px;
  background: rgba(255, 255, 255, 0.85);
  backdrop-filter: blur(12px);
  border-bottom: 1px solid rgba(255, 255, 255, 0.9);
}
.clinic-brand { display: flex; align-items: center; gap: 10px; }
.cross-icon {
  font-size: 18px; background: #0284c7; color: white; width: 36px; height: 36px;
  border-radius: 10px; display: flex; align-items: center; justify-content: center;
  box-shadow: 0 4px 12px rgba(2,132,199,0.25);
}
.clinic-titles { display: flex; flex-direction: column; }
.clinic-tag { font-size: 8px; font-weight: 900; letter-spacing: 1.5px; color: #0284c7; }
.clinic-name { font-size: 13px; font-weight: 900; margin: 0; color: #0c4a6e; }

.clinic-actions { display: flex; gap: 6px; }
.clinic-pill {
  background: rgba(255, 255, 255, 0.9);
  border: 1px solid #bae6fd;
  padding: 6px 12px;
  border-radius: 20px;
  font-size: 10px;
  font-weight: 800;
  color: #0284c7;
  cursor: pointer;
  display: flex;
  align-items: center;
  gap: 4px;
}
.rx-pill { position: relative; }
.rx-badge {
  position: absolute; top: -4px; right: -4px;
  background: #0284c7; color: white; font-size: 8px; font-weight: 900;
  width: 14px; height: 14px; border-radius: 50%; display: flex; align-items: center; justify-content: center;
}
.exit-pill { background: #fee2e2; color: #ef4444; border: none; }

.clinic-viewport { padding: 16px; display: flex; flex-direction: column; gap: 14px; }

/* Anatomy Triage Stage */
.anatomy-card {
  background: rgba(255, 255, 255, 0.9);
  backdrop-filter: blur(10px);
  border-radius: 18px;
  padding: 14px;
  border: 1px solid rgba(255, 255, 255, 0.9);
  display: flex;
  flex-direction: column;
  gap: 10px;
  box-shadow: 0 4px 16px rgba(2,132,199,0.06);
}
.triage-top { display: flex; flex-direction: column; gap: 2px; }
.triage-title { font-size: 11px; font-weight: 900; color: #0284c7; }
.triage-sub { font-size: 9px; font-weight: 800; color: #64748b; }

.body-zone-grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 8px; }
.zone-btn {
  border: 1.5px solid #e0f2fe; background: #f8fafc; border-radius: 12px; padding: 10px;
  display: flex; align-items: center; gap: 8px; cursor: pointer; transition: all 0.2s;
}
.zone-btn.active { background: #e0f2fe; border-color: #0284c7; box-shadow: 0 4px 12px rgba(2,132,199,0.15); }
.z-icon { font-size: 20px; }
.z-lbl { font-size: 10px; font-weight: 900; color: #0c4a6e; }

/* Doctor Radar */
.radar-head { display: flex; justify-content: space-between; font-size: 9px; font-weight: 900; color: #64748b; }
.live-dot { color: #16a34a; }

.doctors-column { display: flex; flex-direction: column; gap: 10px; }
.doctor-pod {
  background: rgba(255, 255, 255, 0.95);
  border: 1.5px solid #e0f2fe;
  border-radius: 16px;
  padding: 12px;
  display: flex;
  gap: 12px;
  cursor: pointer;
  transition: all 0.3s;
  box-shadow: 0 4px 12px rgba(2,132,199,0.05);
}
.doctor-pod.active { border-color: #0284c7; box-shadow: 0 8px 20px rgba(2,132,199,0.18); transform: translateY(-2px); }

.doc-avatar-wrap { position: relative; width: 56px; height: 56px; border-radius: 14px; overflow: hidden; flex-shrink: 0; }
.doc-avatar-wrap img { width: 100%; height: 100%; object-fit: cover; }
.online-indicator {
  position: absolute; bottom: 2px; right: 2px; width: 10px; height: 10px; border-radius: 50%;
  background: #22c55e; border: 2px solid white;
}

.doc-info-col { flex: 1; display: flex; flex-direction: column; gap: 2px; }
.doc-row-1 { display: flex; justify-content: space-between; align-items: center; }
.doc-name { font-size: 13px; font-weight: 900; margin: 0; color: #0c4a6e; }
.doc-fee { font-size: 14px; font-weight: 900; color: #0284c7; }
.doc-spec { font-size: 10px; font-weight: 800; color: #0284c7; }
.doc-hosp { font-size: 9px; color: #64748b; }

.doc-telemetry { display: flex; gap: 8px; font-size: 9px; font-weight: 800; margin-top: 4px; }
.rating-tag { color: #d97706; }
.avail-tag { color: #16a34a; }

/* Intake Card */
.intake-card {
  background: rgba(255, 255, 255, 0.9);
  border-radius: 16px; padding: 14px; border: 1px solid rgba(255, 255, 255, 0.9);
  display: flex; flex-direction: column; gap: 8px;
}
.intake-label { font-size: 9px; font-weight: 900; color: #64748b; }
.urgency-row { display: flex; justify-content: space-between; align-items: center; margin-top: 4px; }
.u-lbl { font-size: 10px; font-weight: 800; color: #0c4a6e; }
.urgency-pills { display: flex; gap: 4px; }
.u-pill {
  border: 1px solid #bae6fd; background: #f0f9ff; padding: 4px 8px; border-radius: 8px;
  font-size: 9px; font-weight: 800; color: #0284c7; cursor: pointer;
}
.u-pill.active { background: #0284c7; color: white; }
.u-pill.urgent.active { background: #ef4444; border-color: #ef4444; }

/* Floating Bar */
.clinic-floating-bar {
  position: fixed; bottom: 0; left: 0; right: 0;
  background: rgba(255, 255, 255, 0.92);
  backdrop-filter: blur(14px);
  border-top: 1px solid #bae6fd;
  padding: 14px 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  z-index: 90;
}
.fee-col { display: flex; flex-direction: column; }
.f-lbl { font-size: 9px; font-weight: 800; color: #64748b; }
.f-total { font-size: 20px; font-weight: 900; color: #0284c7; }
.btn-doctor-book { background: #0284c7 !important; border-color: #0284c7 !important; color: white !important; font-weight: 900 !important; }

.lang-sheet-box { padding: 16px 20px 24px 20px; }
.l-list { display: flex; flex-direction: column; gap: 8px; margin-top: 10px; }
.l-item { display: flex; justify-content: space-between; padding: 10px; border-radius: 10px; border: 1px solid #bae6fd; cursor: pointer; }
.l-item.active { border-color: #0284c7; background: #e0f2fe; color: #0284c7; font-weight: 700; }
</style>
