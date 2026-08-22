<template>
  <div class="parcel-kiosk-root">
    <!-- Physical Terminal Top Bar -->
    <header class="kiosk-terminal-header">
      <div class="kiosk-logo">
        <span class="kiosk-hardware-light"></span>
        <div class="kiosk-title-col">
          <span class="kiosk-node-id">TERMINAL BAY #402 // CENTRAL HUB</span>
          <h1 class="kiosk-brand">SMART PARCEL LOCKER</h1>
        </div>
      </div>

      <div class="kiosk-actions">
        <button class="kiosk-btn" @click="showLangSheet = true">
          <span>{{ currentLangObj.flag }}</span>
          <span>{{ currentLangObj.code.toUpperCase() }}</span>
        </button>
        <button class="kiosk-btn badge-btn" @click="$router.push('/my-tickets')">
          <span>📦</span>
          <span class="k-badge" v-if="store.state.actions.length > 0">{{ store.state.actions.length }}</span>
        </button>
        <button class="kiosk-btn exit-btn" @click="showExitConfirm = true">✕</button>
      </div>
    </header>

    <main class="kiosk-viewport">
      <!-- Mode Toggle Switch (Physical hardware buttons) -->
      <div class="kiosk-hardware-switch">
        <button 
          class="switch-btn" 
          :class="{ active: currentMode === 'DROPOFF' }" 
          @click="currentMode = 'DROPOFF'"
        >
          <span>📥 DEPOSIT PARCEL</span>
        </button>
        <button 
          class="switch-btn" 
          :class="{ active: currentMode === 'PICKUP' }" 
          @click="currentMode = 'PICKUP'"
        >
          <span>📤 RETRIEVE PARCEL</span>
        </button>
      </div>

      <!-- Deposit Mode: Physical Locker Wall Blueprint -->
      <section v-if="currentMode === 'DROPOFF'" class="locker-wall-section">
        <div class="wall-header-row">
          <span class="wall-lbl">TAP PHYSICAL COMPARTMENT TO RESERVE</span>
          <span class="wall-avail">3 OF 5 BAYS FREE</span>
        </div>

        <!-- Realistic Locker Door Matrix -->
        <div class="physical-locker-matrix">
          <div 
            v-for="l in PARCEL_LOCKERS" 
            :key="l.id"
            class="locker-metal-door"
            :class="{
              size_s: l.size === 'SMALL',
              size_m: l.size === 'MEDIUM',
              size_l: l.size === 'LARGE',
              selected: store.state.selectedLocker.id === l.id,
              occupied: l.status === 'OCCUPIED'
            }"
            @click="selectLocker(l)"
          >
            <div class="door-vent-slots">
              <span></span><span></span><span></span>
            </div>

            <div class="door-center-plate">
              <span class="door-bay-id">{{ l.bayNumber }}</span>
              <span class="door-status-led" :class="l.status.toLowerCase()"></span>
            </div>

            <div class="door-keyhole">
              <div class="keyhole-slot"></div>
              <span class="door-price">${{ l.price.toFixed(2) }}</span>
            </div>
          </div>
        </div>

        <!-- Selected Locker Telemetry & Reserve Action -->
        <div class="selected-locker-spec-card">
          <div class="spec-left">
            <span class="spec-tag">{{ store.state.selectedLocker.size }} BAY</span>
            <h3 class="spec-bay">{{ store.state.selectedLocker.bayNumber }}</h3>
            <span class="spec-dim">📐 {{ store.state.selectedLocker.dimensions }} • Max {{ store.state.selectedLocker.maxWeightKg }}kg</span>
          </div>

          <PPButton variant="primary" size="medium" @click="$router.push('/checkout')" class="btn-pop-open">
            Rent & Pop Door (${{ store.state.selectedLocker.price.toFixed(2) }})
          </PPButton>
        </div>
      </section>

      <!-- Retrieve Mode: Physical Touch Keypad Kiosk -->
      <section v-else class="keypad-kiosk-section">
        <div class="pin-terminal-screen">
          <span class="screen-prompt">ENTER 4-DIGIT RECIPIENT PIN</span>
          <div class="screen-digits">
            <span v-for="i in 4" :key="i" class="digit-box">
              {{ pickupPin[i-1] ? pickupPin[i-1] : '_' }}
            </span>
          </div>
          <span class="screen-helper">CHECK YOUR SMS FOR THE DISPATCH CODE</span>
        </div>

        <!-- Metal Industrial Keypad Grid -->
        <div class="metal-keypad-grid">
          <button v-for="n in [1,2,3,4,5,6,7,8,9]" :key="n" class="metal-key" @click="pressKey(String(n))">
            {{ n }}
          </button>
          <button class="metal-key key-clear" @click="pickupPin = ''">CLR</button>
          <button class="metal-key" @click="pressKey('0')">0</button>
          <button class="metal-key key-del" @click="pickupPin = pickupPin.slice(0, -1)">⌫</button>
        </div>

        <PPButton 
          variant="primary" 
          block 
          size="large" 
          :disabled="pickupPin.length !== 4"
          @click="handleUnlockDoor"
          class="btn-hardware-unlock"
        >
          UNLOCK & POP COMPARTMENT ⚡
        </PPButton>
      </section>
    </main>

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
import { ref } from 'vue'
import { PPBottomSheet, PPConfirm, PPButton } from '@phanna/ui-framework'
import { useParcelStore } from '../store/parcelStore'
import { PARCEL_LOCKERS } from '../data/parcelData'
import { useI18n } from '../i18n'
import type { ParcelLocker } from '../types/parcel'
import '@/lib/mini.app.lib.js'

const MiniApp = (window as any).MiniApp
const store = useParcelStore()
const { t, currentLanguage, currentLangObj, supportedLanguages, setLanguage } = useI18n()

const currentMode = ref<'DROPOFF' | 'PICKUP'>('DROPOFF')
const pickupPin = ref('')
const showLangSheet = ref(false)
const showExitConfirm = ref(false)

const selectLocker = (l: ParcelLocker) => {
  if (l.status === 'OCCUPIED') return
  store.state.selectedLocker = l
}

const pressKey = (n: string) => {
  if (pickupPin.value.length < 4) pickupPin.value += n
}

const handleUnlockDoor = () => {
  alert('Door ' + store.state.selectedLocker.bayNumber + ' Popped Open for PIN: ' + pickupPin.value)
  pickupPin.value = ''
}

const confirmExit = () => {
  if (MiniApp?.exit) MiniApp.exit(false)
  else window.history.back()
}
</script>

<style scoped>
.parcel-kiosk-root {
  min-height: 100vh;
  background-color: #0f172a;
  color: #f8fafc;
  display: flex;
  flex-direction: column;
  padding-bottom: 24px;
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
}

/* Physical Terminal Header */
.kiosk-terminal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px;
  background: #1e293b;
  border-bottom: 2px solid #334155;
}
.kiosk-logo { display: flex; align-items: center; gap: 10px; }
.kiosk-hardware-light {
  width: 12px; height: 12px; border-radius: 50%;
  background: #facc15;
  box-shadow: 0 0 10px #facc15;
}
.kiosk-title-col { display: flex; flex-direction: column; }
.kiosk-node-id { font-size: 8px; font-weight: 900; letter-spacing: 1.5px; color: #facc15; }
.kiosk-brand { font-size: 13px; font-weight: 900; margin: 0; color: #ffffff; }

.kiosk-actions { display: flex; gap: 6px; }
.kiosk-btn {
  background: #0f172a;
  border: 1px solid #334155;
  color: #cbd5e1;
  padding: 6px 10px;
  border-radius: 8px;
  font-size: 10px;
  font-weight: 800;
  cursor: pointer;
  display: flex;
  align-items: center;
  gap: 4px;
}
.badge-btn { position: relative; }
.k-badge {
  position: absolute; top: -4px; right: -4px;
  background: #facc15; color: black; font-size: 8px; font-weight: 900;
  width: 14px; height: 14px; border-radius: 50%; display: flex; align-items: center; justify-content: center;
}
.exit-btn { background: #450a0a; color: #ef4444; border-color: #7f1d1d; }

.kiosk-viewport { padding: 16px; display: flex; flex-direction: column; gap: 16px; }

/* Hardware Mode Switcher */
.kiosk-hardware-switch {
  display: grid; grid-template-columns: 1fr 1fr; gap: 8px; background: #1e293b; padding: 4px; border-radius: 12px;
}
.switch-btn {
  border: none; background: transparent; padding: 10px; font-size: 11px; font-weight: 900;
  color: #94a3b8; border-radius: 8px; cursor: pointer; transition: all 0.2s;
}
.switch-btn.active { background: #facc15; color: #0f172a; box-shadow: 0 4px 12px rgba(250,204,21,0.25); }

/* Physical Locker Matrix Wall */
.wall-header-row { display: flex; justify-content: space-between; font-size: 9px; font-weight: 900; color: #94a3b8; }
.wall-avail { color: #facc15; }

.physical-locker-matrix {
  display: grid; grid-template-columns: repeat(2, 1fr); gap: 10px;
}
.locker-metal-door {
  background: linear-gradient(180deg, #1e293b 0%, #0f172a 100%);
  border: 2px solid #334155;
  border-radius: 14px;
  padding: 12px 10px;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  cursor: pointer;
  transition: all 0.3s;
  box-shadow: inset 0 2px 4px rgba(255,255,255,0.05), 0 4px 10px rgba(0,0,0,0.3);
}
.locker-metal-door.size_s { min-height: 80px; }
.locker-metal-door.size_m { min-height: 100px; }
.locker-metal-door.size_l { min-height: 120px; grid-column: span 2; }
.locker-metal-door.selected { border-color: #facc15; box-shadow: 0 0 15px rgba(250,204,21,0.25); transform: translateY(-2px); }
.locker-metal-door.occupied { opacity: 0.5; }

.door-vent-slots { display: flex; gap: 4px; }
.door-vent-slots span { width: 14px; height: 2px; background: #334155; border-radius: 2px; }

.door-center-plate { display: flex; justify-content: space-between; align-items: center; margin: 8px 0; }
.door-bay-id { font-size: 13px; font-weight: 900; color: #f8fafc; font-family: monospace; }
.door-status-led { width: 8px; height: 8px; border-radius: 50%; }
.door-status-led.available { background: #22c55e; box-shadow: 0 0 8px #22c55e; }
.door-status-led.occupied { background: #ef4444; box-shadow: 0 0 8px #ef4444; }

.door-keyhole { display: flex; justify-content: space-between; align-items: center; }
.keyhole-slot { width: 4px; height: 8px; background: #0f172a; border-radius: 2px; }
.door-price { font-size: 11px; font-weight: 900; color: #facc15; }

.selected-locker-spec-card {
  background: #1e293b; border-radius: 16px; padding: 14px; border: 1px solid #334155;
  display: flex; justify-content: space-between; align-items: center;
}
.spec-left { display: flex; flex-direction: column; }
.spec-tag { font-size: 8px; font-weight: 900; color: #facc15; }
.spec-bay { font-size: 16px; font-weight: 900; margin: 0; color: #ffffff; }
.spec-dim { font-size: 10px; color: #94a3b8; }
.btn-pop-open { background: #facc15 !important; border-color: #facc15 !important; color: #0f172a !important; font-weight: 900 !important; }

/* Retrieve Keypad Kiosk */
.pin-terminal-screen {
  background: #020617; border: 2px solid #334155; border-radius: 16px; padding: 20px;
  display: flex; flex-direction: column; align-items: center; gap: 8px; text-align: center;
}
.screen-prompt { font-size: 9px; font-weight: 900; letter-spacing: 1.5px; color: #facc15; }
.screen-digits { display: flex; gap: 12px; margin: 8px 0; }
.digit-box {
  width: 44px; height: 50px; background: #0f172a; border: 1.5px solid #334155; border-radius: 10px;
  display: flex; align-items: center; justify-content: center; font-size: 24px; font-weight: 900; color: #facc15; font-family: monospace;
}
.screen-helper { font-size: 9px; color: #64748b; font-weight: 700; }

.metal-keypad-grid {
  display: grid; grid-template-columns: repeat(3, 1fr); gap: 10px; max-width: 260px; margin: 0 auto;
}
.metal-key {
  height: 52px; background: linear-gradient(180deg, #334155 0%, #1e293b 100%);
  border: 1.5px solid #475569; border-radius: 12px; font-size: 20px; font-weight: 900; color: #f8fafc;
  cursor: pointer; box-shadow: 0 4px 6px rgba(0,0,0,0.3); transition: transform 0.1s;
}
.metal-key:active { transform: translateY(2px); }
.metal-key.key-clear { color: #ef4444; font-size: 12px; }
.metal-key.key-del { color: #facc15; font-size: 14px; }

.btn-hardware-unlock {
  background: #facc15 !important; border-color: #facc15 !important; color: #0f172a !important; font-weight: 900 !important;
}

.lang-sheet-box { padding: 16px 20px 24px 20px; background: #1e293b; color: white; }
.l-list { display: flex; flex-direction: column; gap: 8px; margin-top: 10px; }
.l-item { display: flex; justify-content: space-between; padding: 10px; border-radius: 10px; border: 1px solid #334155; cursor: pointer; }
.l-item.active { border-color: #facc15; background: #0f172a; color: #facc15; font-weight: 700; }
</style>
