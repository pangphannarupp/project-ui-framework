<template>
  <div 
    class="pp-math-keyboard" 
    :class="[`${theme}-theme`, `variant-${variant}`]"
    :style="backgroundColor ? { backgroundColor } : {}"
  >
    <div class="keyboard-row" v-for="(row, rIdx) in currentRows" :key="rIdx">
      <button 
        v-for="(keyObj, idx) in row" 
        :key="idx"
        class="kb-key"
        :class="keyObj.isAction ? 'kb-action-key' : 'kb-char-key'"
        @pointerdown="startPress($event, keyObj)"
        @pointerup="endPress($event, keyObj)"
        @pointerleave="cancelPress"
        @contextmenu.prevent
      >
        <span class="key-main">{{ keyObj.main }}</span>
        
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

interface KeyDef {
  main: string;
  shift?: string;
  popup?: string[];
  shiftPopup?: string[];
  isAction?: boolean;
}

const mathLayout: KeyDef[][] = [
  // Row 0
  [
    { main: '7' }, { main: '8' }, { main: '9' }, { main: '÷' }, { main: 'C', isAction: true }
  ],
  // Row 1
  [
    { main: '4' }, { main: '5' }, { main: '6' }, { main: '×' }, { main: '√' }
  ],
  // Row 2
  [
    { main: '1' }, { main: '2' }, { main: '3' }, { main: '-' }, { main: '^' }
  ],
  // Row 3
  [
    { main: '0' }, { main: '.' }, { main: '=' }, { main: '+' }, { main: 'π' }
  ]
];

const currentRows = computed(() => {
  return mathLayout;
});

const emitPress = (val: string) => {
  if (val === 'C') {
    emit('delete');
    emit('press', 'backspace');
  } else {
    emit('input', val);
    emit('press', val);
  }
};

// Long press & sliding popup logic
let pressTimer: any = null;
const activePopupKey = ref<string | null>(null);
const activePopupOptions = ref<string[]>([]);
const hoveredPopupIndex = ref<number>(-1);
let hasLongPressed = false;

const startPress = (_e: Event, keyObj: KeyDef) => {
  hasLongPressed = false;
  activePopupKey.value = null;
  activePopupOptions.value = [];
  hoveredPopupIndex.value = -1;
  
  let options = [keyObj.main];
  if (keyObj.popup) {
    options = keyObj.popup;
  }
  
  window.addEventListener('pointermove', onPointerMove, { passive: false });
  window.addEventListener('pointerup', onGlobalPointerUp);
  
  pressTimer = setTimeout(() => {
    hasLongPressed = true;
    activePopupKey.value = keyObj.main;
    activePopupOptions.value = options;
    hoveredPopupIndex.value = options.length - 1;
  }, 350); 
};

const onPointerMove = (e: PointerEvent) => {
  if (!hasLongPressed || !activePopupKey.value) return;
  e.preventDefault();
  
  const el = document.elementFromPoint(e.clientX, e.clientY);
  if (el && el.classList.contains('popup-option')) {
    const idx = el.getAttribute('data-idx');
    if (idx !== null) {
      hoveredPopupIndex.value = parseInt(idx, 10);
    }
  }
};

const onGlobalPointerUp = (e: PointerEvent) => {
  window.removeEventListener('pointermove', onPointerMove);
  window.removeEventListener('pointerup', onGlobalPointerUp);
  
  if (pressTimer) clearTimeout(pressTimer);
  
  if (hasLongPressed && activePopupKey.value) {
    if (hoveredPopupIndex.value >= 0 && hoveredPopupIndex.value < activePopupOptions.value.length) {
      emitPress(activePopupOptions.value[hoveredPopupIndex.value]);
    } else {
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

const endPress = (e: Event, keyObj: KeyDef) => {
  if (hasLongPressed) {
    e.preventDefault();
    return;
  }
  
  if (pressTimer) clearTimeout(pressTimer);
  emitPress(keyObj.main);
};

const cancelPress = () => {
  if (pressTimer) clearTimeout(pressTimer);
  if (!hasLongPressed) {
    activePopupKey.value = null;
  }
};
</script>

<style scoped>
.pp-math-keyboard {
  width: 100%;
  padding: 8px 4px 32px;
  border-top-left-radius: 24px;
  border-top-right-radius: 24px;
  user-select: none;
  touch-action: manipulation;
}

.pp-math-keyboard.light-theme {
  background-color: var(--pp-keyboard-bg, #d1d4d9);
}

.pp-math-keyboard.dark-theme {
  background-color: #1e1e1e;
}

/* Base key styles */
.kb-key {
  border: none;
  border-radius: 6px;
  height: 52px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  position: relative;
  cursor: pointer;
  box-shadow: 0 1px 0 rgba(0,0,0,0.3);
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
  margin: 0 3px;
  -webkit-tap-highlight-color: transparent;
  flex: 1;
}

/* Theme variations for keys */
.light-theme .kb-char-key {
  background-color: #ffffff;
  color: #000000;
}
.light-theme .kb-func-key, .light-theme .kb-action-key {
  background-color: #b3b8c0;
  color: #000000;
}

.dark-theme .kb-char-key {
  background-color: #4b4b4b;
  color: #ffffff;
  box-shadow: 0 1px 0 rgba(0,0,0,0.5);
}
.dark-theme .kb-func-key, .dark-theme .kb-action-key {
  background-color: #323232;
  color: #ffffff;
  box-shadow: 0 1px 0 rgba(0,0,0,0.5);
}

/* Flat Variant */
.variant-flat .kb-key {
  box-shadow: none !important;
  border-radius: 4px;
}

/* Glass Variant */
.pp-math-keyboard.variant-glass {
  background-color: rgba(30, 30, 30, 0.4) !important;
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
}
.pp-math-keyboard.light-theme.variant-glass {
  background-color: rgba(209, 212, 217, 0.4) !important;
}

.variant-glass .kb-char-key {
  background-color: rgba(255, 255, 255, 0.1) !important;
  box-shadow: none !important;
  color: white;
}
.light-theme.variant-glass .kb-char-key {
  background-color: rgba(255, 255, 255, 0.5) !important;
  color: #111;
}

.variant-glass .kb-func-key, .variant-glass .kb-action-key {
  background-color: rgba(255, 255, 255, 0.05) !important;
  box-shadow: none !important;
  color: white;
}
.light-theme.variant-glass .kb-func-key, .light-theme.variant-glass .kb-action-key {
  background-color: rgba(0, 0, 0, 0.1) !important;
  color: #111;
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
