<template>
  <div class="my-tickets-view">
    <!-- Compact In-App Nav Bar -->
    <div class="nav-bar">
      <button class="nav-back-btn" @click="$router.push('/')" aria-label="Back">
        <svg viewBox="0 0 24 24" width="22" height="22" stroke="currentColor" stroke-width="2.5" fill="none">
          <line x1="19" y1="12" x2="5" y2="12"></line>
          <polyline points="12 19 5 12 12 5"></polyline>
        </svg>
      </button>
      <h2 class="nav-title">{{ t.myTickets }}</h2>
      <button class="nav-exit-btn" @click="handleExit" aria-label="Exit">
        <svg viewBox="0 0 24 24" width="20" height="20" stroke="currentColor" stroke-width="2.5" fill="none">
          <line x1="18" y1="6" x2="6" y2="18"></line>
          <line x1="6" y1="6" x2="18" y2="18"></line>
        </svg>
      </button>
    </div>

    <!-- Filter Category Chips -->
    <div class="category-scroll">
      <button 
        class="category-chip"
        :class="{ active: activeFilter === 'ALL' }"
        @click="activeFilter = 'ALL'"
      >
        All Passes ({{ store.state.bookedTickets.length }})
      </button>
      <button 
        class="category-chip"
        :class="{ active: activeFilter === 'CONFIRMED' }"
        @click="activeFilter = 'CONFIRMED'"
      >
        Valid / Active
      </button>
      <button 
        class="category-chip"
        :class="{ active: activeFilter === 'USED' }"
        @click="activeFilter = 'USED'"
      >
        Used
      </button>
      <button 
        class="category-chip"
        :class="{ active: activeFilter === 'CANCELLED' }"
        @click="activeFilter = 'CANCELLED'"
      >
        Cancelled
      </button>
    </div>

    <!-- Passes List -->
    <div class="content-scroll">
      <div v-if="filteredBookings.length > 0" class="tickets-list">
        <div v-for="b in filteredBookings" :key="b.id" class="pass-wrapper">
          <DigitalTicketCard :booking="b" @show-scan-modal="handleScanRequest" />
          
          <div class="pass-footer-action" v-if="b.status === 'CONFIRMED'">
            <button class="btn-cancel" @click="store.cancelBooking(b.id)">
              Cancel Ticket
            </button>
          </div>
        </div>
      </div>

      <div v-else class="empty-view">
        <div class="empty-icon">🎟️</div>
        <p>No passes in this category.</p>
        <button class="btn-buy" @click="$router.push('/')">{{ t.browseTickets }}</button>
      </div>
    </div>

    <!-- UI-Framework Turnstile Simulator Sheet -->
    <PPBottomSheet v-model="showScannerModal">
      <div class="scanner-sheet">
        <h3 class="sheet-title">Turnstile Gate Scanner</h3>
        <p class="sheet-sub">Simulating park gate entry scanner</p>

        <div class="scanner-window">
          <div class="scan-beam"></div>
          <span class="scanned-code">{{ activeScanBooking?.bookingCode }}</span>
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
import { ref, computed } from 'vue'
import { PPBottomSheet, PPConfirm } from '@phanna/ui-framework'
import DigitalTicketCard from '../components/DigitalTicketCard.vue'
import { useZooStore } from '../store/zooStore'
import { useI18n } from '../i18n'
import type { BookedTicketRecord } from '../types/zoo'
import '@/lib/mini.app.lib.js'

const store = useZooStore()
const { t } = useI18n()
const MiniApp = (window as any).MiniApp

const activeFilter = ref<'ALL' | 'CONFIRMED' | 'USED' | 'CANCELLED'>('ALL')
const showScannerModal = ref(false)
const showExitConfirm = ref(false)
const activeScanBooking = ref<BookedTicketRecord | null>(null)

const filteredBookings = computed(() => {
  if (activeFilter.value === 'ALL') return store.state.bookedTickets
  return store.state.bookedTickets.filter(b => b.status === activeFilter.value)
})

const handleScanRequest = (b: BookedTicketRecord) => {
  activeScanBooking.value = b
  showScannerModal.value = true
}

const handleMarkUsed = () => {
  if (activeScanBooking.value) {
    activeScanBooking.value.status = 'USED'
    store.showToast('✅ Pass Scanned: Welcome to WildSafari!', 'success')
  }
  showScannerModal.value = false
}

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
</script>

<style scoped>
.my-tickets-view {
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

/* Category Chips */
.category-scroll {
  display: flex;
  gap: 8px;
  overflow-x: auto;
  padding: 10px 16px;
  background-color: var(--zoo-card-bg);
  border-bottom: 1px solid #edf2f7;
  scrollbar-width: none;
}
.category-scroll::-webkit-scrollbar {
  display: none;
}

.category-chip {
  padding: 6px 14px;
  border-radius: 18px;
  border: 1px solid #e2e8f0;
  background-color: #ffffff;
  color: var(--text-secondary);
  font-size: 12px;
  font-weight: 600;
  white-space: nowrap;
  cursor: pointer;
}

.category-chip.active {
  background-color: var(--zoo-primary);
  color: #ffffff;
  border-color: var(--zoo-primary);
}

.content-scroll {
  padding: 14px 16px;
}

.tickets-list {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.pass-wrapper {
  display: flex;
  flex-direction: column;
  gap: 6px;
}

.pass-footer-action {
  display: flex;
  justify-content: flex-end;
}

.btn-cancel {
  background: none;
  border: none;
  color: #ef4444;
  font-size: 12px;
  font-weight: 700;
  cursor: pointer;
}

.empty-view {
  text-align: center;
  padding: 50px 20px;
  color: var(--text-secondary);
}

.empty-icon {
  font-size: 40px;
  margin-bottom: 8px;
}

.btn-buy {
  margin-top: 10px;
  background-color: var(--zoo-primary);
  color: #ffffff;
  border: none;
  padding: 8px 16px;
  border-radius: 10px;
  font-size: 13px;
  font-weight: 700;
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
