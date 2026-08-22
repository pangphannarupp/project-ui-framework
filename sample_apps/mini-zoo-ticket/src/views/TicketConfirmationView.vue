<template>
  <div class="confirmation-view">
    <!-- Compact Top Bar -->
    <div class="nav-bar">
      <button class="nav-back-btn" @click="$router.push('/')" aria-label="Back">
        <svg viewBox="0 0 24 24" width="22" height="22" stroke="currentColor" stroke-width="2.5" fill="none">
          <line x1="19" y1="12" x2="5" y2="12"></line>
          <polyline points="12 19 5 12 12 5"></polyline>
        </svg>
      </button>
      <h2 class="nav-title">{{ t.paymentSuccessTitle }}</h2>
      <button class="nav-exit-btn" @click="handleExit" aria-label="Exit">
        <svg viewBox="0 0 24 24" width="20" height="20" stroke="currentColor" stroke-width="2.5" fill="none">
          <line x1="18" y1="6" x2="6" y2="18"></line>
          <line x1="6" y1="6" x2="18" y2="18"></line>
        </svg>
      </button>
    </div>

    <div class="content-scroll" v-if="booking">
      <!-- Success Icon Ring -->
      <div class="success-top-card">
        <div class="icon-circle">🦁</div>
        <h3 class="success-header">{{ t.paymentReceived }}</h3>
        <p class="success-sub">ID: {{ booking.bookingCode }}</p>
      </div>

      <!-- Compact E-Ticket Display Card -->
      <div class="ticket-container">
        <DigitalTicketCard :booking="booking" @show-scan-modal="showScanModal = true" />
      </div>

      <!-- Action Buttons -->
      <div class="action-buttons-wrap">
        <button class="btn-wallet" @click="$router.push('/my-tickets')">
          🎟️ {{ t.myTickets }}
        </button>
        <button class="btn-new-booking" @click="$router.push('/')">
          + {{ t.newBooking }}
        </button>
      </div>
    </div>

    <div v-else class="content-scroll empty-view">
      <p>No booking record found.</p>
      <button class="btn-new-booking" @click="$router.push('/')">{{ t.browseTickets }}</button>
    </div>

    <!-- UI-Framework Turnstile Simulator Modal -->
    <PPBottomSheet v-model="showScanModal">
      <div class="scanner-sheet">
        <h3 class="sheet-title">Turnstile Gate Scanner</h3>
        <p class="sheet-sub">Simulating park gate entry scanner</p>

        <div class="scanner-window">
          <div class="scan-beam"></div>
          <span class="scanned-code">{{ booking?.bookingCode }}</span>
        </div>

        <button class="btn-confirm-admit" @click="handleMarkUsed">
          Mark as USED (Admit Visitor)
        </button>
      </div>
    </PPBottomSheet>

    <!-- UI-Framework Confirmation Dialog for Exit App -->
    <PPConfirm
      v-model="showExitConfirm"
      :title="t.exitTitle"
      :message="t.exitMessage"
      :confirmText="t.yesExit"
      :cancelText="t.stay"
      confirmVariant="primary"
      @confirm="confirmExit"
    />
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { PPBottomSheet, PPConfirm } from '@phanna/ui-framework'
import DigitalTicketCard from '../components/DigitalTicketCard.vue'
import { useZooStore } from '../store/zooStore'
import { useI18n } from '../i18n'
import type { BookedTicketRecord } from '../types/zoo'
import '@/lib/mini.app.lib.js'

const route = useRoute()
const store = useZooStore()
const { t } = useI18n()
const MiniApp = (window as any).MiniApp

const bookingId = computed(() => route.params.id as string)
const booking = ref<BookedTicketRecord | null>(null)
const showScanModal = ref(false)
const showExitConfirm = ref(false)

onMounted(() => {
  if (bookingId.value) {
    booking.value = store.getBookingById(bookingId.value) || null
  }
  if (!booking.value && store.state.currentBooking) {
    booking.value = store.state.currentBooking
  }
  if (!booking.value && store.state.bookedTickets.length > 0) {
    booking.value = store.state.bookedTickets[0]
  }
})

const handleExit = () => {
  showExitConfirm.value = true
}

const confirmExit = () => {
  if (MiniApp && typeof MiniApp.exit === 'function') {
    MiniApp.exit(false)
  } else {
    window.history.back()
  }
}

const handleMarkUsed = () => {
  if (booking.value) {
    booking.value.status = 'USED'
    store.showToast('✅ Pass Scanned: Welcome to WildSafari!', 'success')
  }
  showScanModal.value = false
}
</script>

<style scoped>
.confirmation-view {
  display: flex;
  flex-direction: column;
  min-height: 100vh;
  background-color: var(--zoo-bg);
}

.nav-bar {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 12px 16px;
  background-color: var(--zoo-card-bg);
  border-bottom: 1px solid #edf2f7;
  position: sticky;
  top: 0;
  z-index: 50;
}

.nav-back-btn,
.nav-exit-btn {
  background: none;
  border: none;
  color: var(--text-main);
  padding: 4px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
}

.nav-exit-btn {
  color: #ef4444;
}

.nav-title {
  margin: 0;
  font-size: 16px;
  font-weight: 800;
  color: var(--text-main);
}

.content-scroll {
  padding: 16px;
  display: flex;
  flex-direction: column;
  gap: 14px;
}

.success-top-card {
  text-align: center;
  background: #ffffff;
  border-radius: 16px;
  padding: 18px 16px;
  border: 1px solid #e2e8f0;
}

.icon-circle {
  font-size: 32px;
  background: #ecfdf5;
  width: 56px;
  height: 56px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto 8px auto;
  border: 2px solid #a7f3d0;
}

.success-header {
  font-size: 16px;
  font-weight: 800;
  color: var(--text-main);
  margin: 0 0 2px 0;
}

.success-sub {
  font-size: 12px;
  color: var(--text-secondary);
  font-weight: 600;
  margin: 0;
}

.action-buttons-wrap {
  display: flex;
  flex-direction: column;
  gap: 8px;
  margin-top: 6px;
}

.btn-wallet {
  background: #ffffff;
  border: 1.5px solid #cbd5e1;
  color: var(--text-main);
  font-weight: 700;
  padding: 11px;
  border-radius: 12px;
  font-size: 13px;
  cursor: pointer;
}

.btn-new-booking {
  background: linear-gradient(135deg, #10b981 0%, #047857 100%);
  color: #ffffff;
  border: none;
  font-weight: 800;
  padding: 12px;
  border-radius: 12px;
  font-size: 14px;
  cursor: pointer;
}

/* Scanner sheet */
.scanner-sheet {
  padding: 16px 20px 28px 20px;
  text-align: center;
}

.sheet-title {
  font-size: 16px;
  font-weight: 800;
  margin: 0 0 4px 0;
}

.sheet-sub {
  font-size: 12px;
  color: var(--text-secondary);
  margin: 0 0 16px 0;
}

.scanner-window {
  background: #0f172a;
  height: 140px;
  border-radius: 14px;
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #34d399;
  font-family: monospace;
  font-size: 16px;
  font-weight: 800;
  margin-bottom: 16px;
  overflow: hidden;
}

.scan-beam {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 3px;
  background: #10b981;
  box-shadow: 0 0 12px #10b981;
  animation: beam 1.5s infinite alternate;
}

@keyframes beam {
  0% { top: 15%; }
  100% { top: 85%; }
}

.btn-confirm-admit {
  width: 100%;
  background: #10b981;
  color: white;
  border: none;
  font-weight: 700;
  padding: 12px;
  border-radius: 12px;
  font-size: 14px;
  cursor: pointer;
}
</style>
