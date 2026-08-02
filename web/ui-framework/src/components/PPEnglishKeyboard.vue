<template>
  <div 
    class="pp-english-keyboard" 
    :class="[`${theme}-theme`, `variant-${variant}`]"
    :style="backgroundColor ? { backgroundColor } : {}"
  >
    <!-- Row 0: Numbers -->
    <div class="keyboard-row">
      <button 
        v-for="(keyObj, idx) in currentRows[0]" 
        :key="idx"
        class="kb-key kb-char-key"
        @pointerdown="startPress($event, keyObj)"
        @pointerup="endPress($event, keyObj)"
        @pointerleave="cancelPress"
        @contextmenu.prevent
      >
        <span class="key-main">{{ isShifted ? (keyObj.shift || keyObj.main) : keyObj.main }}</span>
        <span v-if="keyObj.shift && !isShifted && !showSymbols" class="key-hint">{{ keyObj.shift }}</span>
        
        <div v-if="activePopupKey === keyObj.main" class="key-popup">
          <div 
            v-for="(opt, oIdx) in activePopupOptions" 
            :key="oIdx"
            class="popup-option" 
            :class="{ 'hovered': hoveredPopupIndex === oIdx }"
            :data-idx="oIdx"
          >{{ opt }}</div>
        </div>
      </button>
    </div>

    <!-- Row 1: Letters 1 -->
    <div class="keyboard-row">
      <button 
        v-for="(keyObj, idx) in currentRows[1]" 
        :key="idx"
        class="kb-key kb-char-key"
        @pointerdown="startPress($event, keyObj)"
        @pointerup="endPress($event, keyObj)"
        @pointerleave="cancelPress"
        @contextmenu.prevent
      >
        <span class="key-main">{{ isShifted ? (keyObj.shift || keyObj.main) : keyObj.main }}</span>
        <span v-if="keyObj.shift && !isShifted && !showSymbols" class="key-hint">{{ keyObj.shift }}</span>
        
        <div v-if="activePopupKey === keyObj.main" class="key-popup">
          <div 
            v-for="(opt, oIdx) in activePopupOptions" 
            :key="oIdx"
            class="popup-option" 
            :class="{ 'hovered': hoveredPopupIndex === oIdx }"
            :data-idx="oIdx"
          >{{ opt }}</div>
        </div>
      </button>
    </div>

    <!-- Row 2: Letters 2 with Shift and Backspace -->
    <div class="keyboard-row">
      <button class="kb-key kb-func-key" @click="toggleShift" :class="{ 'shifted': isShifted }">
        <svg v-if="!showSymbols && !isShifted" viewBox="0 0 24 24" width="24" height="24" fill="currentColor">
          <path d="M12 4l-7 7h4v8h6v-8h4z"/>
        </svg>
        <svg v-else-if="!showSymbols && isShifted" viewBox="0 0 24 24" width="24" height="24" fill="var(--pp-primary, #007aff)">
          <path d="M12 4l-7 7h4v8h6v-8h4z"/>
        </svg>
        <span v-else>#+=</span>
      </button>

      <button 
        v-for="(keyObj, idx) in currentRows[2]" 
        :key="idx"
        class="kb-key kb-char-key"
        @pointerdown="startPress($event, keyObj)"
        @pointerup="endPress($event, keyObj)"
        @pointerleave="cancelPress"
        @contextmenu.prevent
      >
        <span class="key-main">{{ isShifted ? (keyObj.shift || keyObj.main) : keyObj.main }}</span>
        <span v-if="keyObj.shift && !isShifted && !showSymbols" class="key-hint">{{ keyObj.shift }}</span>
        
        <div v-if="activePopupKey === keyObj.main" class="key-popup">
          <div 
            v-for="(opt, oIdx) in activePopupOptions" 
            :key="oIdx"
            class="popup-option" 
            :class="{ 'hovered': hoveredPopupIndex === oIdx }"
            :data-idx="oIdx"
          >{{ opt }}</div>
        </div>
      </button>

      <button class="kb-key kb-func-key" @click="emitDelete">
        <svg viewBox="0 0 24 24" width="24" height="24" fill="currentColor">
          <path d="M21 4H8l-7 8 7 8h13a2 2 0 002-2V6a2 2 0 00-2-2zm-2.5 12.5L16 14l-2.5 2.5-1.5-1.5 2.5-2.5-2.5-2.5 1.5-1.5 2.5 2.5 2.5-2.5 1.5 1.5-2.5 2.5 2.5 2.5-1.5 1.5z"></path>
        </svg>
      </button>
    </div>

    <!-- Row 4: Action Row -->
    <div class="keyboard-row action-row">
      <button class="kb-key kb-func-key" @click="toggleSymbols" style="flex: 1.5;">
        {{ showSymbols ? 'ABC' : '?123' }}
      </button>
      
      <button class="kb-key kb-func-key" @click="emitPress(',')" style="flex: 1;">
        ,
      </button>
      
      <button class="kb-key kb-func-key" @click="$emit('emoji')" style="flex: 1.2;">
        <svg viewBox="0 0 24 24" width="22" height="22" fill="currentColor">
          <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.41 0-8-3.59-8-8s3.59-8 8-8 8 3.59 8 8-3.59 8-8 8zm3.5-9c.83 0 1.5-.67 1.5-1.5S16.33 8 15.5 8 14 8.67 14 9.5s.67 1.5 1.5 1.5zm-7 0c.83 0 1.5-.67 1.5-1.5S9.33 8 8.5 8 7 8.67 7 9.5 7.67 11 8.5 11zm3.5 6.5c2.33 0 4.31-1.46 5.11-3.5H6.89c.8 2.04 2.78 3.5 5.11 3.5z"/>
        </svg>
      </button>

      <button class="kb-key kb-space-key" @click="emitPress(' ')" style="flex: 4;">
        English
      </button>

      <button class="kb-key kb-func-key" @click="emitPress('.')" style="flex: 1;">
        .
      </button>
      
      <button class="kb-key kb-func-key kb-enter-key" @click="emitEnter" style="flex: 1.5;">
        <svg viewBox="0 0 24 24" width="24" height="24" fill="currentColor">
          <path d="M19 7v4H5.83l3.58-3.59L8 6l-6 6 6 6 1.41-1.41L5.83 13H21V7h-2z"></path>
        </svg>
      </button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

const emit = defineEmits<{
  (e: 'input', value: string): void;
  (e: 'delete'): void;
  (e: 'enter'): void;
  (e: 'press', value: string): void;
  (e: 'emoji'): void;
}>();

defineProps({
  theme: {
    type: String as () => 'light' | 'dark',
    default: 'dark'
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

const isShifted = ref(false);
const showSymbols = ref(false);

interface KeyDef {
  main: string;
  shift?: string;
  popup?: string[];
  shiftPopup?: string[];
}
const englishLayout: KeyDef[][] = [
  // Row 0
  [
    { main: 'q', shift: 'Q' }, 
    { main: 'w', shift: 'W' }, 
    { main: 'e', shift: 'E' }, 
    { main: 'r', shift: 'R' },
    { main: 't', shift: 'T' }, 
    { main: 'y', shift: 'Y' }, 
    { main: 'u', shift: 'U' }, 
    { main: 'i', shift: 'I' },
    { main: 'o', shift: 'O' }, 
    { main: 'p', shift: 'P' }
  ],
  // Row 1
  [
    { main: 'a', shift: 'A' }, 
    { main: 's', shift: 'S' }, 
    { main: 'd', shift: 'D' }, 
    { main: 'f', shift: 'F' },
    { main: 'g', shift: 'G' }, 
    { main: 'h', shift: 'H' }, 
    { main: 'j', shift: 'J' }, 
    { main: 'k', shift: 'K' },
    { main: 'l', shift: 'L' }
  ],
  // Row 2
  [
    { main: 'z', shift: 'Z' }, 
    { main: 'x', shift: 'X' }, 
    { main: 'c', shift: 'C' }, 
    { main: 'v', shift: 'V' },
    { main: 'b', shift: 'B' }, 
    { main: 'n', shift: 'N' }, 
    { main: 'm', shift: 'M' }
  ]
];

// Simple symbols layout for demonstration
const symbolsLayout: KeyDef[][] = [
  [{ main: '1' },{ main: '2' },{ main: '3' },{ main: '4' },{ main: '5' },{ main: '6' },{ main: '7' },{ main: '8' },{ main: '9' },{ main: '0' }],
  [{ main: '-' },{ main: '/' },{ main: ':' },{ main: ';' },{ main: '(' },{ main: ')' },{ main: '$' },{ main: '&' },{ main: '@' },{ main: '"' }],
  [{ main: '.' },{ main: ',' },{ main: '?' },{ main: '!' },{ main: '\'' }]
];

const extraSymbolsLayout: KeyDef[][] = [
  [{ main: '[' },{ main: ']' },{ main: '{' },{ main: '}' },{ main: '#' },{ main: '%' },{ main: '^' },{ main: '*' },{ main: '+' },{ main: '=' }],
  [{ main: '_' },{ main: '\\' },{ main: '|' },{ main: '~' },{ main: '<' },{ main: '>' },{ main: '€' },{ main: '£' },{ main: '¥' },{ main: '•' }],
  [{ main: '.' },{ main: ',' },{ main: '?' },{ main: '!' },{ main: '\'' }]
];

const currentRows = computed(() => {
  return showSymbols.value 
    ? (isShifted.value ? extraSymbolsLayout : symbolsLayout) 
    : englishLayout;
});

const toggleShift = () => {
  isShifted.value = !isShifted.value;
  if (showSymbols.value) showSymbols.value = false;
};

const toggleSymbols = () => {
  showSymbols.value = !showSymbols.value;
  if (showSymbols.value) isShifted.value = false;
};

const emitPress = (val: string) => {
  emit('input', val);
  emit('press', val);
  if (isShifted.value && !showSymbols.value) {
    isShifted.value = false;
  }
};

const emitDelete = () => {
  emit('delete');
  emit('press', 'backspace');
};

const emitEnter = () => {
  emit('enter');
  emit('press', 'enter');
};

// Long press & sliding popup logic
let pressTimer: any = null;
const activePopupKey = ref<string | null>(null);
const activePopupOptions = ref<string[]>([]);
const hoveredPopupIndex = ref<number>(-1);
let hasLongPressed = false;

const startPress = (_e: Event, keyObj: KeyDef) => {
  // We use pointerdown instead of touchstart so we can capture mouse and touch easily
  hasLongPressed = false;
  activePopupKey.value = null;
  activePopupOptions.value = [];
  hoveredPopupIndex.value = -1;
  
  const useShift = isShifted.value && !showSymbols.value;
  const currentKey = useShift ? (keyObj.shift || keyObj.main) : keyObj.main;
  
  let options = [currentKey];
  if (useShift && keyObj.shiftPopup) {
    options = keyObj.shiftPopup;
  } else if (!useShift && keyObj.popup) {
    options = keyObj.popup;
  }
  
  // Set up global pointermove listener
  window.addEventListener('pointermove', onPointerMove, { passive: false });
  window.addEventListener('pointerup', onGlobalPointerUp);
  
  pressTimer = setTimeout(() => {
    hasLongPressed = true;
    activePopupKey.value = keyObj.main;
    activePopupOptions.value = options;
    hoveredPopupIndex.value = options.length - 1; // Default to rightmost (main key)
  }, 350); 
};

const onPointerMove = (e: PointerEvent) => {
  if (!hasLongPressed || !activePopupKey.value) return;
  // Prevent scrolling while sliding over popup
  e.preventDefault();
  
  const el = document.elementFromPoint(e.clientX, e.clientY);
  if (el && el.classList.contains('popup-option')) {
    const idx = el.getAttribute('data-idx');
    if (idx !== null) {
      hoveredPopupIndex.value = parseInt(idx, 10);
    }
  } else {
    // If finger moves out of bounds, maybe reset or keep last hovered. We keep last.
  }
};

const onGlobalPointerUp = (e: PointerEvent) => {
  window.removeEventListener('pointermove', onPointerMove);
  window.removeEventListener('pointerup', onGlobalPointerUp);
  
  if (pressTimer) clearTimeout(pressTimer);
  
  if (hasLongPressed && activePopupKey.value) {
    // Determine which key to type
    if (hoveredPopupIndex.value >= 0 && hoveredPopupIndex.value < activePopupOptions.value.length) {
      emitPress(activePopupOptions.value[hoveredPopupIndex.value]);
    } else {
      // Fallback
      emitPress(activePopupOptions.value[activePopupOptions.value.length - 1]);
    }
    
    activePopupKey.value = null;
    activePopupOptions.value = [];
    hasLongPressed = false;
    e.preventDefault();
    return;
  }
  
  activePopupKey.value = null;
  hasLongPressed = false;
};

// Local pointerup for short taps
const endPress = (e: Event, keyObj: KeyDef) => {
  if (hasLongPressed) {
    e.preventDefault(); // Handled by global pointerup
    return;
  }
  
  if (pressTimer) clearTimeout(pressTimer);
  const valToType = isShifted.value ? (keyObj.shift || keyObj.main) : keyObj.main;
  emitPress(valToType);
};

const cancelPress = () => {
  if (pressTimer) clearTimeout(pressTimer);
  // Don't cancel if already long pressed and sliding, global listener handles it
  if (!hasLongPressed) {
    activePopupKey.value = null;
  }
};
</script>

<style scoped>
.pp-english-keyboard {
  user-select: none;
  touch-action: manipulation;
  width: 100%;
  max-width: 600px;
  margin: 0 auto;
  padding: 8px 4px 16px 4px;
  border-radius: 8px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
  display: flex;
  flex-direction: column;
  gap: 8px;
  box-sizing: border-box;
}

.pp-english-keyboard.dark-theme {
  background-color: #1e1e1e;
}

.pp-english-keyboard.light-theme {
  background-color: #d1d4d9;
}

/* Glass Variant */
.pp-english-keyboard.variant-glass {
  background-color: rgba(30, 30, 30, 0.4) !important;
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
}
.pp-english-keyboard.light-theme.variant-glass {
  background-color: rgba(209, 212, 217, 0.4) !important;
}

.variant-glass .kb-key {
  background-color: rgba(255, 255, 255, 0.1) !important;
  box-shadow: none !important;
}
.light-theme.variant-glass .kb-key {
  background-color: rgba(255, 255, 255, 0.5) !important;
}

.variant-glass .kb-func-key, .variant-glass .kb-space-key {
  background-color: rgba(0, 0, 0, 0.2) !important;
}
.light-theme.variant-glass .kb-func-key, .light-theme.variant-glass .kb-space-key {
  background-color: rgba(0, 0, 0, 0.1) !important;
}

/* Flat Variant */
.variant-flat .kb-key {
  box-shadow: none !important;
  border-radius: 4px;
}

.keyboard-row {
  display: flex;
  justify-content: center;
  gap: 4px;
  margin-bottom: 8px;
  width: 100%;
}

.action-row {
  margin-top: 4px;
}

.kb-key {
  flex: 1;
  background-color: #3b3b3b;
  border: none;
  border-radius: 6px;
  height: 48px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  touch-action: manipulation;
  min-width: 0;
  transition: background-color 0.1s;
  position: relative;
  overflow: visible;
}

.dark-theme .kb-key {
  color: #ffffff;
  background-color: #3b3b3b;
  box-shadow: 0 1px 1px rgba(0,0,0,0.5);
}

.light-theme .kb-key {
  color: #000000;
  background-color: #ffffff;
  box-shadow: 0 1px 1px rgba(0,0,0,0.2);
}

.dark-theme .kb-key:active {
  background-color: #555555;
}

.light-theme .kb-key:active {
  background-color: #b3b8c0;
}

.key-main {
  font-size: 22px;
  font-weight: 400;
}

.key-hint {
  position: absolute;
  top: 4px;
  right: 4px;
  font-size: 10px;
}

.dark-theme .key-hint {
  color: #999999;
}

.light-theme .key-hint {
  color: #777777;
}

/* Long press popup */
.key-popup {
  position: absolute;
  top: -65px;
  left: 50%;
  transform: translateX(-50%);
  width: max-content;
  min-width: 48px;
  height: 60px;
  border-radius: 8px;
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1000;
  padding: 0 4px;
}

.dark-theme .key-popup {
  background-color: #4a4a4a;
  box-shadow: 0 4px 12px rgba(0,0,0,0.5);
}

.light-theme .key-popup {
  background-color: #ffffff;
  box-shadow: 0 4px 12px rgba(0,0,0,0.2);
}

.popup-option {
  font-size: 30px;
  font-weight: 500;
  padding: 0 10px;
  height: 48px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 6px;
  margin: 0 2px;
}

.dark-theme .popup-option {
  color: #fff;
}

.light-theme .popup-option {
  color: #000;
}

.dark-theme .popup-option.hovered {
  background-color: #a8c7fa;
  color: #000;
}

.light-theme .popup-option.hovered {
  background-color: #007aff;
  color: #fff;
}

/* Triangle pointer for popup */
.key-popup::after {
  content: '';
  position: absolute;
  bottom: -6px;
  left: 50%;
  transform: translateX(-50%);
  border-width: 6px 6px 0;
  border-style: solid;
}

.dark-theme .key-popup::after {
  border-color: #4a4a4a transparent transparent transparent;
}

.light-theme .key-popup::after {
  border-color: #ffffff transparent transparent transparent;
}

.kb-func-key {
  font-size: 14px;
  font-weight: 500;
}

.dark-theme .kb-func-key {
  background-color: #2b2b2b;
  color: #ffffff;
}

.light-theme .kb-func-key {
  background-color: #b3b8c0;
  color: #000000;
}

.dark-theme .kb-func-key:active {
  background-color: #444444;
}

.light-theme .kb-func-key:active {
  background-color: #9aa0a6;
}

.dark-theme .shifted {
  background-color: #e5e5e5;
  color: #000;
}

.light-theme .shifted {
  background-color: #ffffff;
  color: #000;
}

.kb-space-key {
  font-size: 14px;
  font-weight: 400;
}

.dark-theme .kb-space-key {
  background-color: #3b3b3b;
}

.light-theme .kb-enter-key {
  font-size: 14px;
  font-weight: 500;
}

.dark-theme .kb-enter-key {
  background-color: #1a73e8;
  color: #ffffff;
}

.light-theme .kb-enter-key {
  background-color: #007aff;
  color: #ffffff;
}

.dark-theme .kb-enter-key:active {
  background-color: #1765cc;
}

.light-theme .kb-enter-key:active {
  background-color: #0062cc;
}
</style>
