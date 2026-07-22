<template>
  <div class="pp-secure-keyboard">
    <!-- Row 1: Numbers -->
    <div class="keyboard-row">
      <template v-for="(item, index) in randomizedNumbers" :key="index">
        <button 
          v-if="item !== 'shield'"
          class="kb-key kb-char-key"
          :data-key="item"
          @click="emitPress(item)"
        >
          {{ item }}
        </button>
        <div v-else class="kb-key kb-func-key secure-indicator">
          <svg viewBox="0 0 24 24" width="20" height="20" fill="currentColor">
            <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z" fill="none" stroke="currentColor" stroke-width="2" stroke-linejoin="round"></path>
          </svg>
        </div>
      </template>
    </div>

    <!-- Row 2: Letters/Symbols 1 -->
    <div class="keyboard-row">
      <template v-for="(char, index) in row1Keys" :key="index">
        <button 
          v-if="char !== 'shield'"
          class="kb-key kb-char-key"
          :data-key="formatChar(char)"
          @click="emitPress(char)"
        >
          {{ formatChar(char) }}
        </button>
        <div v-else class="kb-key kb-func-key secure-indicator">
          <svg viewBox="0 0 24 24" width="20" height="20" fill="currentColor">
            <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z" fill="none" stroke="currentColor" stroke-width="2" stroke-linejoin="round"></path>
          </svg>
        </div>
      </template>
    </div>

    <!-- Row 3: Letters/Symbols 2 -->
    <div class="keyboard-row indent-row-3">
      <template v-for="(char, index) in row2Keys" :key="index">
        <button 
          v-if="char !== 'shield'"
          class="kb-key kb-char-key"
          :data-key="formatChar(char)"
          @click="emitPress(char)"
        >
          {{ formatChar(char) }}
        </button>
        <div v-else class="kb-key kb-func-key secure-indicator">
          <svg viewBox="0 0 24 24" width="20" height="20" fill="currentColor">
            <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z" fill="none" stroke="currentColor" stroke-width="2" stroke-linejoin="round"></path>
          </svg>
        </div>
      </template>
    </div>

    <!-- Row 4: Shift, Letters/Symbols 3, Backspace -->
    <div class="keyboard-row">
      <button class="kb-key kb-func-key" @click="toggleShift">
        <svg v-if="!isShifted" viewBox="0 0 24 24" width="24" height="24" fill="currentColor">
          <path d="M12 4l-7 7h4v8h6v-8h4z"/>
        </svg>
        <svg v-else viewBox="0 0 24 24" width="24" height="24" fill="var(--pp-primary, #3880ff)">
          <path d="M12 4l-7 7h4v8h6v-8h4z"/>
        </svg>
      </button>

      <template v-for="(char, index) in row3Keys" :key="index">
        <button 
          v-if="char !== 'shield'"
          class="kb-key kb-char-key"
          :data-key="formatChar(char)"
          @click="emitPress(char)"
        >
          {{ formatChar(char) }}
        </button>
        <div v-else class="kb-key kb-func-key secure-indicator">
          <svg viewBox="0 0 24 24" width="20" height="20" fill="currentColor">
            <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z" fill="none" stroke="currentColor" stroke-width="2" stroke-linejoin="round"></path>
          </svg>
        </div>
      </template>

      <button class="kb-key kb-func-key" @click="emitPress('backspace')">
        <svg viewBox="0 0 24 24" width="24" height="24" fill="currentColor">
          <path d="M21 4H8l-7 8 7 8h13a2 2 0 0 0 2-2V6a2 2 0 0 0-2-2z" fill="none" stroke="currentColor" stroke-width="2" stroke-linejoin="round"></path>
          <line x1="18" y1="9" x2="12" y2="15" stroke="currentColor" stroke-width="2"></line>
          <line x1="12" y1="9" x2="18" y2="15" stroke="currentColor" stroke-width="2"></line>
        </svg>
      </button>
    </div>

    <!-- Row 5: Action Row -->
    <div class="keyboard-row action-row">
      <button class="kb-key kb-func-key kb-toggle-key" @click="toggleSymbols">
        {{ showSymbols ? 'ABC' : '$%?' }}
      </button>
      <button class="kb-key kb-func-key" @click="emitPress('emoji')">
        😊
      </button>
      <button class="kb-key space-key" @click="emitPress(' ')"></button>
      <button class="kb-key kb-func-key" @click="emitPress('.')">
        .
      </button>
      <button class="kb-key kb-func-key" @click="emitPress('enter')">
        <svg viewBox="0 0 24 24" width="24" height="24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <polyline points="9 10 4 15 9 20"></polyline>
          <path d="M20 4v7a4 4 0 0 1-4 4H4"></path>
        </svg>
      </button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue';

const emit = defineEmits(['press']);

const isShifted = ref(false);
const showSymbols = ref(false);

const defaultNumbers = ['1','2','3','4','5','6','7','8','9','0'];
const defaultLetters = ['q','w','e','r','t','y','u','i','o','p','a','s','d','f','g','h','j','k','l','z','x','c','v','b','n','m'];
const defaultSymbols = ['!','@','#','$','%','^','&','*','(',')','-','+','_','=','{','}','[',']',':',';','"','\'','<','>','?','/'];

const shieldPositions = ref<number[]>([0, 0, 0, 0]);

const randomizeKeys = () => {
  shieldPositions.value = [
    Math.floor(Math.random() * 11), // row 0: 10 + 1 slots
    Math.floor(Math.random() * 11), // row 1: 10 + 1 slots
    Math.floor(Math.random() * 10), // row 2: 9 + 1 slots
    Math.floor(Math.random() * 8)   // row 3: 7 + 1 slots
  ];
};

onMounted(() => {
  randomizeKeys();
});

const randomizedNumbers = computed(() => {
  const nums = [...defaultNumbers];
  nums.splice(shieldPositions.value[0], 0, 'shield');
  return nums;
});

const row1Keys = computed(() => {
  const source = showSymbols.value ? defaultSymbols : defaultLetters;
  const keys = source.slice(0, 10);
  keys.splice(shieldPositions.value[1], 0, 'shield');
  return keys;
});

const row2Keys = computed(() => {
  const source = showSymbols.value ? defaultSymbols : defaultLetters;
  const keys = source.slice(10, 19);
  keys.splice(shieldPositions.value[2], 0, 'shield');
  return keys;
});

const row3Keys = computed(() => {
  const source = showSymbols.value ? defaultSymbols : defaultLetters;
  const keys = source.slice(19, 26);
  keys.splice(shieldPositions.value[3], 0, 'shield');
  return keys;
});

const formatChar = (char: string) => {
  if (showSymbols.value) return char;
  return isShifted.value ? char.toUpperCase() : char;
};

const toggleShift = () => {
  isShifted.value = !isShifted.value;
};

const toggleSymbols = () => {
  showSymbols.value = !showSymbols.value;
  // Turn off shift when switching to symbols
  if (showSymbols.value) isShifted.value = false;
};

const emitPress = (val: string) => {
  // Apply shift if it's a letter
  if (val.length === 1 && /[a-z]/.test(val) && !showSymbols.value && isShifted.value) {
    emit('press', val.toUpperCase());
  } else {
    emit('press', val);
  }
};

defineExpose({ randomizeKeys });
</script>

<style scoped>
.pp-secure-keyboard {
  width: 100%;
  background-color: #1a1b1e; /* Deep dark theme from screenshot */
  padding: 8px 4px 24px;
  box-sizing: border-box;
}

.keyboard-row {
  display: flex;
  justify-content: center;
  gap: 6px;
  margin-bottom: 8px;
  width: 100%;
}

.indent-row-3 {
  padding: 0 16px;
}

.kb-key {
  flex: 1;
  background-color: #2c2d31;
  border: none;
  border-radius: 8px;
  height: 48px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 20px;
  font-weight: 500;
  color: #ffffff;
  cursor: pointer;
  touch-action: manipulation;
  min-width: 0; /* allows flex box to shrink properly */
  max-width: 40px;
  transition: background-color 0.1s;
  box-shadow: 0 1px 1px rgba(0,0,0,0.2);
}

.kb-key:active {
  background-color: #4a4b50;
}

.kb-char-key {
  position: relative;
  overflow: visible;
}

.kb-char-key::after {
  content: attr(data-key);
  position: absolute;
  top: -60px;
  left: 50%;
  transform: translateX(-50%);
  width: 48px;
  height: 60px;
  background-color: #4a4b50;
  color: #fff;
  border-radius: 8px;
  font-size: 32px;
  font-weight: 500;
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 0 4px 12px rgba(0,0,0,0.5);
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
  box-shadow: none;
  color: #5f6368;
  cursor: default;
}
.secure-indicator:active {
  background-color: transparent;
}

/* Functional Keys (Shift, Backspace, Symbols) */
.kb-func-key {
  background-color: #202124;
  color: #e8eaed;
  max-width: 54px;
}

.kb-func-key svg {
  opacity: 0.9;
}

/* The Toggle (Symbols/ABC) Key is a bit wider */
.kb-toggle-key {
  max-width: 64px;
  font-size: 16px;
  font-weight: 600;
}

/* Spacebar */
.space-key {
  flex: 3;
  max-width: none;
}
</style>
