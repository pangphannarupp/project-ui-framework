<template>
  <div 
    class="pp-phone-keyboard"
    :class="[`${theme}-theme`, `variant-${variant}`]"
    :style="backgroundColor ? { backgroundColor } : {}"
  >
    <div class="keypad-grid">
      <!-- Numbers 1-9 -->
      <button 
        v-for="num in 9" 
        :key="num" 
        class="keypad-btn num-btn"
        @click="emitPress(num.toString())"
      >
        <div class="key-content">
          <span class="key-num">{{ num }}</span>
          <span class="key-alpha">{{ lettersMap[num.toString()] }}</span>
        </div>
      </button>

      <!-- Star -->
      <button class="keypad-btn num-btn" @click="emitPress('*')">
        <div class="key-content">
          <span class="key-num" style="font-size: 32px; transform: translateY(6px);">*</span>
        </div>
      </button>

      <!-- Zero -->
      <button class="keypad-btn num-btn" @click="emitPress('0')">
        <div class="key-content">
          <span class="key-num">0</span>
          <span class="key-alpha">+</span>
        </div>
      </button>

      <!-- Hash -->
      <button class="keypad-btn num-btn" @click="emitPress('#')">
        <div class="key-content">
          <span class="key-num">#</span>
        </div>
      </button>
      
      <!-- Blank -->
      <div class="keypad-btn empty-btn"></div>
      
      <!-- Call Button (optional) -->
      <button class="keypad-btn call-btn" @click="$emit('call')">
        <svg viewBox="0 0 24 24" fill="currentColor" width="28" height="28">
          <path d="M6.62 10.79c1.44 2.83 3.76 5.14 6.59 6.59l2.2-2.2c.27-.27.67-.36 1.02-.24 1.12.37 2.33.57 3.57.57.55 0 1 .45 1 1V20c0 .55-.45 1-1 1-9.39 0-17-7.61-17-17 0-.55.45-1 1-1h3.5c.55 0 1 .45 1 1 0 1.25.2 2.45.57 3.57.11.35.03.74-.25 1.02l-2.2 2.2z"/>
        </svg>
      </button>
      
      <!-- Backspace -->
      <button class="keypad-btn icon-btn" @click="emitPress('backspace')">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" width="24" height="24">
          <path d="M21 4H8l-7 8 7 8h13a2 2 0 0 0 2-2V6a2 2 0 0 0-2-2z"></path>
          <line x1="18" y1="9" x2="12" y2="15"></line>
          <line x1="12" y1="9" x2="18" y2="15"></line>
        </svg>
      </button>
    </div>
  </div>
</template>

<script setup lang="ts">
const emit = defineEmits(['press', 'call']);

defineProps({
  theme: {
    type: String as () => 'light' | 'dark',
    default: 'light'
  },
  variant: {
    type: String as () => 'default' | 'flat' | 'glass',
    default: 'default'
  },
  backgroundColor: {
    type: String,
    default: ''
  }
});

const lettersMap: Record<string, string> = {
  '1': '', '2': 'ABC', '3': 'DEF',
  '4': 'GHI', '5': 'JKL', '6': 'MNO',
  '7': 'PQRS', '8': 'TUV', '9': 'WXYZ'
};

const emitPress = (val: string) => {
  emit('press', val);
};
</script>

<style scoped>
.pp-phone-keyboard {
  width: 100%;
  padding: 16px 20px 32px;
  border-top-left-radius: 24px;
  border-top-right-radius: 24px;
}

.pp-phone-keyboard.light-theme {
  background-color: var(--pp-keypad-bg, #e5e7eb);
}

.pp-phone-keyboard.dark-theme {
  background-color: #1e1e1e;
}

.pp-phone-keyboard.dark-theme .keypad-btn {
  background-color: #333;
  color: white;
}

.pp-phone-keyboard.dark-theme .empty-btn {
  background-color: transparent !important;
  box-shadow: none !important;
}

/* Glass Variant */
.pp-phone-keyboard.variant-glass {
  background-color: rgba(30, 30, 30, 0.4) !important;
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
}
.pp-phone-keyboard.light-theme.variant-glass {
  background-color: rgba(209, 212, 217, 0.4) !important;
}

.variant-glass .keypad-btn {
  background-color: rgba(255, 255, 255, 0.1) !important;
  box-shadow: none !important;
  color: white;
}
.light-theme.variant-glass .keypad-btn {
  background-color: rgba(255, 255, 255, 0.5) !important;
  color: #111;
}

.variant-glass .empty-btn {
  background-color: transparent !important;
}

/* Flat Variant */
.variant-flat .keypad-btn {
  box-shadow: none !important;
  border-radius: 4px;
}

.keypad-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 12px;
}

.keypad-btn {
  background-color: white;
  border: none;
  border-radius: 8px;
  height: 54px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 24px;
  font-weight: 500;
  color: #111;
  box-shadow: 0 1px 3px rgba(0,0,0,0.1);
  cursor: pointer;
  transition: background-color 0.1s;
  /* Disable double-tap zoom on iOS */
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
  background-color: #f0f0f0;
}

.empty-btn {
  background-color: transparent !important;
  box-shadow: none !important;
  cursor: default;
}
.empty-btn:active {
  background-color: transparent;
}

.icon-btn {
  color: #333;
}
.icon-btn svg {
  width: 24px;
  height: 24px;
}
.call-btn {
  background-color: #34c759 !important; /* iOS Green */
  color: white !important;
  border-radius: 50% !important; /* Make it circular */
  width: 54px;
  margin: 0 auto;
}
.call-btn:active {
  background-color: #2eb050 !important;
}
</style>
