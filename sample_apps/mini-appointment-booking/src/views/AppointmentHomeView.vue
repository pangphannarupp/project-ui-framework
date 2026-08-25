<template>
  <div class="apt-home-view">
    <!-- Greeting area -->
    <div class="greeting-area">
      <div class="top-row-header">
        <div class="user-greeting">
          <div class="clinic-avatar">🩺</div>
          <div class="chat-bubbles">
            <div class="bubble small">{{ t.appName }}</div>
            <div class="bubble large">{{ userName }}</div>
          </div>
        </div>

        <div class="header-right-actions">
          <button class="wallet-btn" @click="$router.push('/my-tickets')" aria-label="Bookings">
            <span>📅</span>
            <span class="count-badge" v-if="store.state.appointments.length > 0">{{ store.state.appointments.length }}</span>
          </button>
          <button class="lang-switch-btn" @click="showLangSheet = true">
            <span>{{ currentLangObj.flag }}</span>
          </button>
          <button class="exit-icon-btn" @click="showExitConfirm = true">✕</button>
        </div>
      </div>
    </div>

    <!-- Services list -->
    <div class="content-scroll">
      <div class="services-list">
        <div 
          v-for="srv in CLINIC_SERVICES" 
          :key="srv.id" 
          class="service-card"
          :class="{ selected: store.state.selectedService.id === srv.id }"
          @click="store.state.selectedService = srv"
        >
          <div class="srv-top">
            <span class="srv-avatar">{{ srv.avatar }}</span>
            <div class="srv-meta">
              <span class="srv-cat">{{ srv.category }}</span>
              <h4 class="srv-name">{{ srv.name }}</h4>
              <span class="srv-doc">👨‍⚕️ {{ srv.specialist }} ({{ srv.clinicName }})</span>
            </div>
          </div>

          <p class="srv-desc">{{ srv.description }}</p>

          <div class="srv-foot">
            <div class="price-col">
              <span class="p-total">${{ srv.price.toFixed(2) }} ({{ srv.duration }})</span>
              <span class="p-deposit">Deposit: ${{ srv.deposit.toFixed(2) }}</span>
            </div>
            <button class="btn-select" @click.stop="selectService(srv)">Book Slot →</button>
          </div>
        </div>
      </div>
    </div>

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
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { PPBottomSheet, PPConfirm } from '@phanna/ui-framework'
import { useAppointmentStore } from '../store/appointmentStore'
import { CLINIC_SERVICES } from '../data/appointmentData'
import { useI18n } from '../i18n'
import type { ClinicService } from '../types/appointment'
import '@/lib/mini.app.lib.js'

const router = useRouter()
const MiniApp = (window as any).MiniApp
const store = useAppointmentStore()
const { t, currentLanguage, currentLangObj, supportedLanguages, setLanguage } = useI18n()

const userName = ref('PATIENT GUEST')
const showLangSheet = ref(false)
const showExitConfirm = ref(false)

onMounted(async () => {
  try {
    if (MiniApp && typeof MiniApp.getUserProfile === 'function') {
      const p = await MiniApp.getUserProfile()
      if (p?.name) {
        userName.value = p.name
        store.state.patientName = p.name
      }
      if (p?.phoneNumber) store.state.patientPhone = p.phoneNumber
    }
  } catch (e) {}
})

const selectService = (srv: ClinicService) => {
  store.state.selectedService = srv
  router.push('/checkout')
}

const confirmExit = () => {
  if (MiniApp?.exit) MiniApp.exit(false)
  else window.history.back()
}
</script>

<style scoped>
.apt-home-view { min-height: 100vh; background-color: #f8fafc; padding-bottom: 24px; }
.greeting-area { background: #ffffff; padding: 14px 16px; border-bottom: 1px solid #edf2f7; display: flex; flex-direction: column; gap: 12px; }
.top-row-header { display: flex; justify-content: space-between; align-items: center; }
.user-greeting { display: flex; align-items: center; gap: 10px; }
.clinic-avatar { font-size: 24px; background: #0d9488; width: 42px; height: 42px; border-radius: 12px; display: flex; align-items: center; justify-content: center; }
.bubble.small { font-size: 11px; color: #64748b; }
.bubble.large { font-size: 15px; font-weight: 800; }
.header-right-actions { display: flex; align-items: center; gap: 6px; }
.wallet-btn, .lang-switch-btn, .exit-icon-btn {
  background: #f1f5f9; border: 1px solid #e2e8f0; border-radius: 10px; height: 36px; padding: 0 10px; cursor: pointer;
}
.exit-icon-btn { background: #fee2e2; color: #ef4444; border: none; }

.content-scroll { padding: 14px 16px; }
.services-list { display: flex; flex-direction: column; gap: 12px; }
.service-card {
  background: #ffffff; border-radius: 16px; border: 1px solid #e2e8f0; padding: 14px;
  display: flex; flex-direction: column; gap: 10px; cursor: pointer;
}
.service-card.selected { border-color: #0d9488; box-shadow: 0 0 0 1px #0d9488; }
.srv-top { display: flex; gap: 10px; }
.srv-avatar { font-size: 28px; }
.srv-meta { display: flex; flex-direction: column; }
.srv-cat { font-size: 10px; font-weight: 800; color: #0d9488; text-transform: uppercase; }
.srv-name { font-size: 14px; font-weight: 800; margin: 2px 0; }
.srv-doc { font-size: 11px; color: #64748b; }
.srv-desc { font-size: 11px; color: #64748b; margin: 0; }

.srv-foot {
  display: flex; justify-content: space-between; align-items: center;
  border-top: 1px solid #f1f5f9; padding-top: 8px;
}
.price-col { display: flex; flex-direction: column; }
.p-total { font-size: 14px; font-weight: 900; color: #0f172a; }
.p-deposit { font-size: 10px; font-weight: 800; color: #0d9488; }
.btn-select {
  background: #0d9488; color: white; border: none; padding: 8px 14px; border-radius: 8px; font-size: 12px; font-weight: 800; cursor: pointer;
}

.lang-sheet-box { padding: 16px 20px 24px 20px; }
.l-list { display: flex; flex-direction: column; gap: 8px; margin-top: 10px; }
.l-item { display: flex; justify-content: space-between; padding: 10px; border-radius: 10px; border: 1px solid #e2e8f0; cursor: pointer; }
.l-item.active { border-color: #0d9488; background: #f0fdfa; color: #0f766e; font-weight: 700; }
</style>
