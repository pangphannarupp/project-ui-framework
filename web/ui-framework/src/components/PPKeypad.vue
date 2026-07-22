<template>
  <div class="pp-keypad">
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

      <!-- Empty Space -->
      <div class="keypad-btn empty-btn"></div>

      <!-- Zero -->
      <button 
        class="keypad-btn num-btn"
        @click="emitPress('0')"
      >
        <div class="key-content">
          <span class="key-num">0</span>
          <span class="key-alpha">+</span>
        </div>
      </button>

      <!-- Backspace -->
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
const emit = defineEmits(['press']);

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
.pp-keypad {
  width: 100%;
  background-color: var(--pp-keypad-bg, #e5e7eb);
  padding: 16px 20px 32px;
  border-top-left-radius: 24px;
  border-top-right-radius: 24px;
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
  background-color: transparent;
  box-shadow: none;
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
</style>
