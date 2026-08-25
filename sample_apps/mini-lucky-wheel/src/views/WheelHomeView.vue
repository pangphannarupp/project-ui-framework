<template>
  <div class="wheel-home-view">
    <!-- Header -->
    <div class="greeting-area">
      <div class="top-row-header">
        <div class="user-greeting">
          <div class="wheel-avatar">🎡</div>
          <div class="chat-bubbles">
            <div class="bubble small">{{ t.appName }}</div>
            <div class="bubble large">{{ userName }}</div>
          </div>
        </div>

        <div class="header-right-actions">
          <button class="wallet-btn" @click="$router.push('/my-tickets')" aria-label="Vouchers">
            <span>🎁</span>
            <span class="count-badge" v-if="store.state.wonPrizes.length > 0">{{ store.state.wonPrizes.length }}</span>
          </button>
          <button class="lang-switch-btn" @click="showLangSheet = true">
            <span>{{ currentLangObj.flag }}</span>
          </button>
          <button class="exit-icon-btn" @click="showExitConfirm = true">✕</button>
        </div>
      </div>

      <!-- Spins Counter Strip -->
      <div class="spins-counter-strip">
        <div class="sc-left">
          <span class="sc-lbl">{{ t.spinsRemaining }}</span>
          <span class="sc-val">🪙 {{ store.state.availableSpins }}</span>
        </div>
        <button class="btn-buy-tokens" @click="$router.push('/checkout')">
          + {{ t.buySpins }}
        </button>
      </div>
    </div>

    <!-- Main Wheel Arena -->
    <div class="wheel-arena">
      <div class="wheel-stage">
        <!-- Pointer Arrow -->
        <div class="wheel-pointer">▼</div>

        <!-- Wheel Canvas/Disk -->
        <div 
          class="wheel-disc" 
          :style="{ transform: `rotate(${rotationDegrees}deg)`, transition: isSpinning ? 'transform 4s cubic-bezier(0.15, 0.9, 0.2, 1)' : 'none' }"
        >
          <div 
            v-for="(p, index) in WHEEL_PRIZES" 
            :key="p.id" 
            class="wheel-slice"
            :style="{
              transform: `rotate(${index * 60}deg)`,
              backgroundColor: p.color,
              color: p.textColor
            }"
          >
            <div class="slice-content">
              <span class="p-icon">{{ p.icon }}</span>
              <span class="p-txt">{{ p.label }}</span>
            </div>
          </div>
        </div>
      </div>

      <!-- Spin Trigger Button -->
      <button 
        class="btn-spin-action" 
        :disabled="isSpinning || store.state.availableSpins <= 0"
        @click="spinWheel"
      >
        <span v-if="!isSpinning && store.state.availableSpins > 0">🎯 {{ t.spinNow }} (1🪙)</span>
        <span v-else-if="isSpinning">Spinning The Fortune Wheel...</span>
        <span v-else>Out of Spins (Get More Tokens)</span>
      </button>
    </div>

    <!-- Spin Packs Quick Buy -->
    <div class="packs-section">
      <h4 class="packs-title">🪙 {{ t.spinPackTitle }}</h4>
      <div class="packs-grid">
        <div 
          v-for="pack in SPIN_PACKS" 
          :key="pack.id" 
          class="pack-card"
          @click="selectPack(pack)"
        >
          <span class="pack-badge">{{ pack.bonus }}</span>
          <div class="pack-spins">{{ pack.spins }} Spins</div>
          <span class="pack-price">${{ pack.price.toFixed(2) }}</span>
        </div>
      </div>
    </div>

    <!-- Won Dialog using PPAlert -->
    <PPAlert
      v-model="showWinAlert"
      :title="t.congratsTitle"
      :message="wonMessage"
      confirmText="Claim Voucher"
      @confirm="showWinAlert = false"
    />

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
import { PPBottomSheet, PPConfirm, PPAlert } from '@phanna/ui-framework'
import { useWheelStore, SPIN_PACKS, SpinPack } from '../store/wheelStore'
import { WHEEL_PRIZES } from '../data/wheelData'
import { useI18n } from '../i18n'
import '@/lib/mini.app.lib.js'

const router = useRouter()
const MiniApp = (window as any).MiniApp
const store = useWheelStore()
const { t, currentLanguage, currentLangObj, supportedLanguages, setLanguage } = useI18n()

const userName = ref('LUCKY PLAYER GUEST')
const showLangSheet = ref(false)
const showExitConfirm = ref(false)
const isSpinning = ref(false)
const rotationDegrees = ref(0)
const showWinAlert = ref(false)
const wonMessage = ref('')

onMounted(async () => {
  try {
    if (MiniApp && typeof MiniApp.getUserProfile === 'function') {
      const p = await MiniApp.getUserProfile()
      if (p?.name) userName.value = p.name
    }
  } catch (e) {}
})

const spinWheel = () => {
  if (store.state.availableSpins <= 0 || isSpinning.value) return
  store.state.availableSpins--
  isSpinning.value = true

  const targetPrizeIndex = Math.floor(Math.random() * WHEEL_PRIZES.length)
  const prize = WHEEL_PRIZES[targetPrizeIndex]
  const fullRounds = 5 * 360
  const prizeAngle = 360 - (targetPrizeIndex * 60 + 30)
  
  rotationDegrees.value += fullRounds + prizeAngle

  setTimeout(() => {
    isSpinning.value = false
    store.recordWin(prize)
    wonMessage.value = `You won: ${prize.icon} ${prize.value}! Saved to your vouchers.`
    showWinAlert.value = true
  }, 4200)
}

const selectPack = (p: SpinPack) => {
  store.state.selectedPack = p
  router.push('/checkout')
}

const confirmExit = () => {
  if (MiniApp?.exit) MiniApp.exit(false)
  else window.history.back()
}
</script>

<style scoped>
.wheel-home-view { min-height: 100vh; background-color: #0f172a; color: #ffffff; padding-bottom: 24px; }
.greeting-area { background: #1e293b; padding: 14px 16px; border-bottom: 1px solid #334155; display: flex; flex-direction: column; gap: 12px; }
.top-row-header { display: flex; justify-content: space-between; align-items: center; }
.user-greeting { display: flex; align-items: center; gap: 10px; }
.wheel-avatar { font-size: 24px; background: #f59e0b; width: 42px; height: 42px; border-radius: 12px; display: flex; align-items: center; justify-content: center; color: black; }
.bubble.small { font-size: 11px; color: #94a3b8; }
.bubble.large { font-size: 15px; font-weight: 800; }
.header-right-actions { display: flex; align-items: center; gap: 6px; }
.wallet-btn, .lang-switch-btn, .exit-icon-btn {
  background: #0f172a; border: 1px solid #334155; border-radius: 10px; height: 36px; padding: 0 10px; cursor: pointer; color: white;
}
.exit-icon-btn { background: #fee2e2; color: #ef4444; border: none; }
.wallet-btn { position: relative; }
.count-badge {
  position: absolute; top: -4px; right: -4px; background: #f59e0b; color: black;
  font-size: 10px; font-weight: 900; width: 16px; height: 16px; border-radius: 50%; display: flex; align-items: center; justify-content: center;
}

.spins-counter-strip {
  background: #0f172a; border: 1px solid #334155; border-radius: 12px; padding: 8px 12px;
  display: flex; justify-content: space-between; align-items: center;
}
.sc-left { display: flex; flex-direction: column; }
.sc-lbl { font-size: 10px; font-weight: 800; color: #94a3b8; }
.sc-val { font-size: 18px; font-weight: 900; color: #f59e0b; }
.btn-buy-tokens {
  background: #f59e0b; color: #000000; border: none; font-size: 11px; font-weight: 800; padding: 6px 12px; border-radius: 8px; cursor: pointer;
}

.wheel-arena { padding: 24px 16px; display: flex; flex-direction: column; align-items: center; }
.wheel-stage { position: relative; width: 260px; height: 260px; margin-bottom: 24px; }
.wheel-pointer {
  position: absolute; top: -14px; left: 50%; transform: translateX(-50%);
  font-size: 24px; color: #f59e0b; z-index: 20; text-shadow: 0 2px 4px rgba(0,0,0,0.5);
}

.wheel-disc {
  width: 100%; height: 100%; border-radius: 50%; position: relative; overflow: hidden;
  border: 6px solid #f59e0b; box-shadow: 0 0 30px rgba(245, 158, 11, 0.3);
}

.wheel-slice {
  position: absolute; width: 100%; height: 100%;
  clip-path: polygon(50% 50%, 25% 0%, 75% 0%);
  display: flex; justify-content: center; align-items: flex-start;
  padding-top: 14px;
}
.slice-content { display: flex; flex-direction: column; align-items: center; gap: 2px; }
.p-icon { font-size: 20px; }
.p-txt { font-size: 9px; font-weight: 800; text-align: center; }

.btn-spin-action {
  width: 100%; max-width: 320px; background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
  color: #000000; border: none; padding: 14px; border-radius: 14px; font-size: 16px; font-weight: 900; cursor: pointer;
}
.btn-spin-action:disabled { opacity: 0.5; cursor: not-allowed; }

.packs-section { padding: 0 16px; }
.packs-title { font-size: 13px; font-weight: 800; margin: 0 0 10px 0; }
.packs-grid { display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 8px; }
.pack-card {
  background: #1e293b; border: 1px solid #334155; border-radius: 12px; padding: 10px 6px;
  text-align: center; display: flex; flex-direction: column; gap: 4px; cursor: pointer; position: relative;
}
.pack-badge { font-size: 8px; font-weight: 800; color: #f59e0b; background: rgba(245, 158, 11, 0.1); padding: 2px; border-radius: 4px; }
.pack-spins { font-size: 13px; font-weight: 800; }
.pack-price { font-size: 12px; font-weight: 900; color: #f59e0b; }

.lang-sheet-box { padding: 16px 20px 24px 20px; background: #1e293b; color: white; }
.l-list { display: flex; flex-direction: column; gap: 8px; margin-top: 10px; }
.l-item { display: flex; justify-content: space-between; padding: 10px; border-radius: 10px; border: 1px solid #334155; cursor: pointer; }
.l-item.active { border-color: #f59e0b; background: #0f172a; color: #f59e0b; font-weight: 700; }
</style>
