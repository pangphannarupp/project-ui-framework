<template>
  <div class="biz-secure-keypad">
    <div class="keypad-header" v-if="showHeader">
      <ion-icon :icon="shieldCheckmark" class="shield-icon"></ion-icon>
      <span>Secure Keypad Active</span>
    </div>
    <div class="keypad-grid">
      <!-- 11 Slots for 10 Numbers + 1 Shield -->
      <template v-for="(item, index) in shuffledKeys" :key="index">
        <button 
          v-if="item !== 'shield'"
          class="keypad-btn num-btn kb-char-key"
          :data-key="item"
          @click="emitPress(item)"
        >
          <div class="key-content">
            <span class="key-num">{{ item }}</span>
            <span class="key-alpha">{{ lettersMap[item] || ' ' }}</span>
          </div>
        </button>

        <div v-else class="keypad-btn icon-btn secure-indicator">
          <ion-icon :icon="shieldHalf"></ion-icon>
        </div>
      </template>

      <!-- Bottom Right: Backspace -->
      <button 
        class="keypad-btn icon-btn"
        @click="emitPress('backspace')"
      >
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
          <path d="M21 4H8l-7 8 7 8h13a2 2 0 0 0 2-2V6a2 2 0 0 0-2-2z"></path>
          <line x1="18" y1="9" x2="12" y2="15"></line>
          <line x1="12" y1="9" x2="18" y2="15"></line>
        </svg>
      </button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { IonIcon } from '@ionic/vue';
import { shieldCheckmark, shieldHalf } from 'ionicons/icons';

withDefaults(defineProps<{
  showHeader?: boolean;
}>(), {
  showHeader: true
});

const emit = defineEmits(['press']);

const shuffledKeys = ref<string[]>([]);

const lettersMap: Record<string, string> = {
  '1': '', '2': 'ABC', '3': 'DEF',
  '4': 'GHI', '5': 'JKL', '6': 'MNO',
  '7': 'PQRS', '8': 'TUV', '9': 'WXYZ',
  '0': '+'
};

const randomizeKeys = () => {
  const nums = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'];
  const shieldIndex = Math.floor(Math.random() * 11);
  nums.splice(shieldIndex, 0, 'shield');
  shuffledKeys.value = nums;
};

// Randomize on mount
onMounted(() => {
  randomizeKeys();
});

// Expose randomize method to parent if they want to re-shuffle dynamically
defineExpose({ randomizeKeys });

const emitPress = (val: string) => {
  emit('press', val);
  // Optionally re-randomize on every press for extreme security
  // randomizeKeys(); 
};
</script>

<style scoped>
.biz-secure-keypad {
  width: 100%;
  background-color: var(--biz-background, #f4f6fa);
  padding: 12px 20px 32px;
  border-top-left-radius: 24px;
  border-top-right-radius: 24px;
  box-shadow: 0 -4px 12px rgba(0,0,0,0.05);
}

.keypad-header {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  padding-bottom: 16px;
  color: var(--biz-primary, #003399);
  font-size: 14px;
  font-weight: 600;
}

.shield-icon {
  font-size: 18px;
  color: var(--biz-primary-light, #3880ff);
}

.keypad-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 12px;
}

.keypad-btn {
  background-color: white;
  border: 1px solid #e2e8f0;
  border-radius: 12px;
  height: 56px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 26px;
  font-weight: 600;
  color: var(--biz-primary-variant, #1a2a5e);
  box-shadow: 0 2px 4px rgba(0,0,0,0.02);
  cursor: pointer;
  transition: all 0.15s ease;
  touch-action: manipulation;
}

.key-content {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  line-height: 1;
}
.key-num {
  font-size: 26px;
}
.key-alpha {
  font-size: 10px;
  font-weight: 600;
  color: #718096;
  margin-top: 2px;
  letter-spacing: 1px;
  min-height: 10px;
}

.keypad-btn:active {
  background-color: var(--biz-primary, #003399);
  color: white;
}
.keypad-btn:active .key-alpha {
  color: rgba(255, 255, 255, 0.7);
}

.kb-char-key {
  position: relative;
  overflow: visible;
}

.kb-char-key::after {
  content: attr(data-key);
  position: absolute;
  top: -70px;
  left: 50%;
  transform: translateX(-50%);
  width: 60px;
  height: 70px;
  background-color: var(--biz-primary, #003399);
  color: #fff;
  border-radius: 12px;
  font-size: 40px;
  font-weight: 600;
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 0 6px 16px rgba(0,0,0,0.4);
  opacity: 0;
  pointer-events: none;
  z-index: 1000;
  transition: opacity 0.05s;
}

.kb-char-key:active::after {
  opacity: 1;
}

.secure-indicator {
  background-color: transparent;
  border: none;
  box-shadow: none;
  color: #a0aec0;
  cursor: default;
}
.secure-indicator:active {
  background-color: transparent;
  color: #a0aec0;
  transform: none;
}

.icon-btn {
  color: var(--biz-primary-variant, #1a2a5e);
}
.icon-btn svg {
  width: 26px;
  height: 26px;
}
.icon-btn:active svg {
  stroke: white;
}
</style>
