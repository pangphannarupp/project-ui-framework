<template>
  <div class="bus-home-view">
    <!-- Top Greeting Area -->
    <div class="greeting-area">
      <div class="top-row-header">
        <div class="user-greeting">
          <div class="bus-avatar">🚌</div>
          <div class="chat-bubbles">
            <div class="bubble small">{{ t.appName }}</div>
            <div class="bubble large">{{ userName }}</div>
          </div>
        </div>

        <div class="header-right-actions">
          <button class="wallet-btn" @click="$router.push('/my-tickets')" aria-label="Passes">
            <span>🎫</span>
            <span class="count-badge" v-if="store.state.bookings.length > 0">{{ store.state.bookings.length }}</span>
          </button>
          <button class="lang-switch-btn" @click="showLangSheet = true">
            <span>{{ currentLangObj.flag }}</span>
          </button>
          <button class="exit-icon-btn" @click="showExitConfirm = true">✕</button>
        </div>
      </div>

      <!-- Route Search Selector Card -->
      <div class="search-route-card">
        <div class="city-selector-row">
          <div class="city-col">
            <span class="c-lbl">{{ t.fromCity }}</span>
            <PPSelect 
              v-model="store.state.origin" 
              :options="cityOptions"
              variant="filled"
              class="custom-pp-select"
            />
          </div>
          <div class="swap-icon">⇄</div>
          <div class="city-col">
            <span class="c-lbl">{{ t.toCity }}</span>
            <PPSelect 
              v-model="store.state.destination" 
              :options="cityOptions"
              variant="filled"
              class="custom-pp-select"
            />
          </div>
        </div>

        <div class="date-pick-row">
          <span class="d-icon">📅</span>
          <PPDatePicker 
            v-model="selectedDateObj"
            placeholder="Select Departure Date"
            class="custom-pp-datepicker"
          />
        </div>
      </div>
    </div>

    <!-- Routes list -->
    <div class="routes-container">
      <div class="route-card" v-for="r in filteredRoutes" :key="r.id" @click="selectRoute(r)">
        <div class="route-top">
          <div class="operator-row">
            <span class="r-icon">{{ r.icon }}</span>
            <div>
              <h4 class="r-operator">{{ r.operator }}</h4>
              <span class="r-type">{{ r.busType }}</span>
            </div>
          </div>
          <span class="r-price">${{ r.price.toFixed(2) }}</span>
        </div>

        <div class="time-schedule-bar">
          <div class="time-point">
            <span class="t-val">{{ r.departureTime }}</span>
            <span class="t-loc">{{ r.origin }}</span>
          </div>
          <div class="duration-pill">
            <span>⏱️ {{ r.duration }}</span>
          </div>
          <div class="time-point">
            <span class="t-val">{{ r.arrivalTime }}</span>
            <span class="t-loc">{{ r.destination }}</span>
          </div>
        </div>

        <div class="route-bottom">
          <span class="seats-left">💺 {{ r.availableSeats }} seats left</span>
          <PPButton variant="primary" size="small" @click.stop="selectRoute(r)">Select Seats →</PPButton>
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
import { ref, computed, watch, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { PPBottomSheet, PPConfirm, PPDatePicker, PPSelect, PPButton } from '@phanna/ui-framework'
import { useBusStore } from '../store/busStore'
import { BUS_ROUTES, CITIES_LIST } from '../data/busData'
import { useI18n } from '../i18n'
import type { BusRoute } from '../types/bus'
import '@/lib/mini.app.lib.js'

const MiniApp = (window as any).MiniApp
const store = useBusStore()
const { t, currentLanguage, currentLangObj, supportedLanguages, setLanguage } = useI18n()

const userName = ref('PASSENGER GUEST')
const showLangSheet = ref(false)
const showExitConfirm = ref(false)
const selectedDateObj = ref<Date | null>(new Date())

const cityOptions = CITIES_LIST.map(c => ({ label: c, value: c }))

watch(selectedDateObj, (newVal) => {
  if (newVal) {
    store.state.selectedDate = newVal.toISOString().split('T')[0]
  }
})

onMounted(async () => {
  try {
    if (MiniApp && typeof MiniApp.getUserProfile === 'function') {
      const p = await MiniApp.getUserProfile()
      if (p?.name) {
        userName.value = p.name
        store.state.passengerName = p.name
      }
      if (p?.phoneNumber) store.state.passengerPhone = p.phoneNumber
    }
  } catch (e) {}
})

const filteredRoutes = computed(() => {
  return BUS_ROUTES
})

const selectRoute = (r: BusRoute) => {
  store.state.selectedRoute = r
  router.push('/checkout')
}

const confirmExit = () => {
  if (MiniApp?.exit) MiniApp.exit(false)
  else window.history.back()
}
</script>

<style scoped>
.bus-home-view { min-height: 100vh; background-color: #f8fafc; padding-bottom: 24px; }
.greeting-area { background: #ffffff; padding: 14px 16px; border-bottom: 1px solid #edf2f7; display: flex; flex-direction: column; gap: 12px; }
.top-row-header { display: flex; justify-content: space-between; align-items: center; }
.user-greeting { display: flex; align-items: center; gap: 10px; }
.bus-avatar { font-size: 24px; background: #3b82f6; width: 42px; height: 42px; border-radius: 12px; display: flex; align-items: center; justify-content: center; }
.bubble.small { font-size: 11px; color: #64748b; }
.bubble.large { font-size: 15px; font-weight: 800; }
.header-right-actions { display: flex; align-items: center; gap: 6px; }

.wallet-btn {
  position: relative; background: #f1f5f9; border: 1px solid #e2e8f0; border-radius: 10px;
  width: 36px; height: 36px; display: flex; align-items: center; justify-content: center; cursor: pointer;
}
.count-badge {
  position: absolute; top: -4px; right: -4px; background: #3b82f6; color: white;
  font-size: 10px; font-weight: 800; width: 16px; height: 16px; border-radius: 50%; display: flex; align-items: center; justify-content: center;
}
.lang-switch-btn, .exit-icon-btn {
  background: #f1f5f9; border: 1px solid #e2e8f0; border-radius: 10px; height: 36px; padding: 0 10px; cursor: pointer;
}
.exit-icon-btn { background: #fee2e2; color: #ef4444; border: none; }

.search-route-card {
  background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 14px; padding: 12px; display: flex; flex-direction: column; gap: 10px;
}
.city-selector-row { display: flex; align-items: center; justify-content: space-between; gap: 8px; }
.city-col { flex: 1; display: flex; flex-direction: column; }
.c-lbl { font-size: 10px; font-weight: 800; color: #64748b; text-transform: uppercase; }
.city-select { background: transparent; border: none; font-size: 13px; font-weight: 800; color: #0f172a; outline: none; }
.swap-icon { font-size: 16px; color: #3b82f6; font-weight: 800; }
.date-pick-row { display: flex; align-items: center; gap: 8px; border-top: 1px solid #e2e8f0; padding-top: 8px; }
.date-field { border: none; background: transparent; font-size: 12px; font-weight: 700; color: #0f172a; outline: none; }

.routes-container { padding: 14px 16px; display: flex; flex-direction: column; gap: 12px; }
.route-card {
  background: #ffffff; border-radius: 16px; border: 1px solid #e2e8f0; padding: 14px; display: flex; flex-direction: column; gap: 12px; cursor: pointer;
}
.route-top { display: flex; justify-content: space-between; align-items: flex-start; }
.operator-row { display: flex; align-items: center; gap: 8px; }
.r-icon { font-size: 22px; }
.r-operator { font-size: 14px; font-weight: 800; margin: 0; }
.r-type { font-size: 11px; color: #64748b; }
.r-price { font-size: 16px; font-weight: 900; color: #2563eb; }

.time-schedule-bar { display: flex; justify-content: space-between; align-items: center; background: #f8fafc; padding: 10px 12px; border-radius: 10px; }
.time-point { display: flex; flex-direction: column; }
.t-val { font-size: 13px; font-weight: 800; }
.t-loc { font-size: 10px; color: #64748b; }
.duration-pill { font-size: 10px; font-weight: 700; color: #2563eb; background: #eff6ff; padding: 3px 8px; border-radius: 6px; }

.route-bottom { display: flex; justify-content: space-between; align-items: center; }
.seats-left { font-size: 11px; font-weight: 700; color: #059669; }
.btn-select-seats {
  background: #2563eb; color: white; border: none; font-size: 12px; font-weight: 700; padding: 6px 12px; border-radius: 8px; cursor: pointer;
}

.lang-sheet-box { padding: 16px 20px 24px 20px; }
.l-list { display: flex; flex-direction: column; gap: 8px; margin-top: 10px; }
.l-item { display: flex; justify-content: space-between; padding: 10px; border-radius: 10px; border: 1px solid #e2e8f0; cursor: pointer; }
.l-item.active { border-color: #2563eb; background: #eff6ff; color: #1d4ed8; font-weight: 700; }
</style>
