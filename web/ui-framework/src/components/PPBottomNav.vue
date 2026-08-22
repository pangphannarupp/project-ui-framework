<template>
  <div class="pp-bottom-nav" :class="`is-variant-${variant}`">
    
    <!-- Sliding Indicator (used by dot, magic-line, curved, and pill-slide) -->
    <div 
      v-if="['dot', 'magic-line', 'curved', 'pill-slide'].includes(variant)"
      class="pp-sliding-indicator"
      :style="indicatorStyle"
    >
      <div class="pp-indicator-inner"></div>
    </div>

    <!-- Cutout Background -->
    <div v-if="variant === 'cutout'" class="pp-cutout-bg"></div>

    <div 
      v-for="(item, index) in items" 
      :key="index"
      :ref="el => setItemRef(el, index)"
      class="pp-bottom-nav-item"
      :class="{ 
        'is-active': modelValue === item.value,
        'is-action-item': item.isAction 
      }"
      :style="{ flex: `1 1 0px` }"
      @click="selectItem(item.value)"
    >
      <div class="pp-nav-indicator" :class="{ 'pp-fab-wrapper': item.isAction }">
        <ion-icon :icon="modelValue === item.value ? (item.activeIcon || item.icon) : item.icon" class="pp-nav-icon"></ion-icon>
      </div>
      <span class="pp-nav-label" v-if="variant !== 'shift' || modelValue === item.value">{{ item.label }}</span>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed, ref, watch, onMounted, nextTick, onBeforeUnmount } from 'vue';
import { IonIcon } from '@ionic/vue';

export interface BottomNavItem {
  label: string;
  value: string;
  icon: any;
  activeIcon?: any;
  isAction?: boolean;
}

const props = withDefaults(defineProps<{
  modelValue: string;
  items: any[];
  variant?: 'material' | 'classic' | 'floating' | 'shift' | 'dot' | 'bubble' | 'magic-line' | 'curved' | 'pill-slide' | 'cutout';
}>(), {
  variant: 'material'
});

const emit = defineEmits<{
  (e: 'update:modelValue', val: string): void;
  (e: 'change', val: string): void;
}>();

const selectItem = (val: string) => {
  emit('update:modelValue', val);
  emit('change', val);
};

// Calculate the active index to position the sliding indicator
const activeIndex = computed(() => {
  const index = props.items.findIndex(item => item.value === props.modelValue);
  return index !== -1 ? index : 0;
});

// Javascript-based pixel-perfect positioning for the sliding indicator
const itemRefs = ref<HTMLElement[]>([]);
const indicatorStyle = ref({
  left: '0px',
  width: '0px'
});

const setItemRef = (el: any, index: number) => {
  if (el) itemRefs.value[index] = el as HTMLElement;
};

const updateIndicator = async () => {
  await nextTick();
  const activeEl = itemRefs.value[activeIndex.value];
  if (activeEl) {
    indicatorStyle.value = {
      left: `${activeEl.offsetLeft}px`,
      width: `${activeEl.offsetWidth}px`
    };
  }
};

onMounted(() => {
  updateIndicator();
  window.addEventListener('resize', updateIndicator);
  // Add a small delay for initial font loads that might shift layout
  setTimeout(updateIndicator, 100);
});

onBeforeUnmount(() => {
  window.removeEventListener('resize', updateIndicator);
});

watch(activeIndex, updateIndicator);
watch(() => props.items, updateIndicator, { deep: true });
</script>

<style scoped>
/* Base styles (shared layout) */
.pp-bottom-nav {
  display: flex;
  align-items: center;
  width: 100%;
  height: 80px;
  background-color: #f4f5f8;
  padding-bottom: env(safe-area-inset-bottom, 0);
  box-shadow: 0 -1px 2px rgba(0,0,0,0.03);
  box-sizing: content-box;
  transition: all 0.3s ease;
  position: relative;
}

.pp-bottom-nav-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  flex: 1 1 0px;
  min-width: 0;
  width: 100%;
  height: 100%;
  cursor: pointer;
  -webkit-tap-highlight-color: transparent;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  z-index: 1; /* keep items above the sliding indicator */
}

.pp-nav-indicator {
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
}

.pp-nav-icon {
  font-size: 24px;
  color: #5f6368;
  transition: color 0.25s cubic-bezier(0.4, 0, 0.2, 1);
}

.pp-nav-label {
  font-size: 12px;
  font-weight: 500;
  color: #5f6368;
  transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
  white-space: nowrap;
}

/* ========================================================== */
/* SLIDING INDICATOR BASE                                     */
/* ========================================================== */
.pp-sliding-indicator {
  position: absolute;
  top: 0;
  height: 100%;
  pointer-events: none;
  transition: left 0.4s cubic-bezier(0.34, 1.56, 0.64, 1); /* spring effect */
  display: flex;
  justify-content: center;
  z-index: 0;
}

/* ========================================================== */
/* VARIANT: MATERIAL (Default MD3)                            */
/* ========================================================== */
.is-variant-material .pp-nav-indicator {
  width: 64px;
  height: 32px;
  border-radius: 16px;
  margin-bottom: 4px;
}
.is-variant-material .pp-bottom-nav-item.is-active .pp-nav-indicator {
  background-color: #d3e3fd; /* Light blue */
  transform: scale(1.05);
}
.is-variant-material .pp-bottom-nav-item.is-active .pp-nav-icon {
  color: #041e49; /* Dark blue */
}
.is-variant-material .pp-bottom-nav-item.is-active .pp-nav-label {
  color: #1a1a1a;
  font-weight: 700;
}

/* ========================================================== */
/* VARIANT: CLASSIC                                           */
/* ========================================================== */
.is-variant-classic {
  height: 60px;
  background-color: #ffffff;
  box-shadow: 0 -2px 10px rgba(0,0,0,0.05);
}
.is-variant-classic .pp-nav-indicator {
  margin-bottom: 2px;
  background: transparent !important;
}
.is-variant-classic .pp-bottom-nav-item.is-active .pp-nav-icon {
  color: var(--pp-primary, #007aff);
}
.is-variant-classic .pp-bottom-nav-item.is-active .pp-nav-label {
  color: var(--pp-primary, #007aff);
}

/* ========================================================== */
/* VARIANT: FLOATING                                          */
/* ========================================================== */
.is-variant-floating {
  /* Requires parent to have appropriate spacing */
  bottom: calc(20px + env(safe-area-inset-bottom, 0));
  width: calc(100% - 40px);
  max-width: 400px;
  height: 64px;
  border-radius: 32px;
  background-color: #ffffff;
  box-shadow: 0 8px 32px rgba(0,0,0,0.12);
  padding-bottom: 0;
  margin: 20px auto;
}
.is-variant-floating .pp-nav-indicator {
  width: 48px;
  height: 48px;
  border-radius: 24px;
}
.is-variant-floating .pp-nav-label {
  display: none; /* Hide labels for minimal look */
}
.is-variant-floating .pp-bottom-nav-item.is-active .pp-nav-indicator {
  background-color: var(--pp-primary-light, #e6f0ff);
  box-shadow: inset 0 0 0 2px var(--pp-primary, #007aff);
}
.is-variant-floating .pp-bottom-nav-item.is-active .pp-nav-icon {
  color: var(--pp-primary, #007aff);
}

/* ========================================================== */
/* VARIANT: SHIFT                                             */
/* ========================================================== */
.is-variant-shift {
  background-color: #ffffff;
  box-shadow: 0 -4px 20px rgba(0,0,0,0.05);
  height: 64px;
}
.is-variant-shift .pp-bottom-nav-item {
  flex-direction: row;
  padding: 0 16px;
  border-radius: 20px;
  height: 40px;
  margin: 0 4px;
  flex: 1;
}
.is-variant-shift .pp-bottom-nav-item.is-active {
  flex: 2;
  background-color: var(--pp-primary-light, #e6f0ff);
  justify-content: center;
}
.is-variant-shift .pp-nav-indicator {
  margin-right: 0;
}
.is-variant-shift .pp-bottom-nav-item.is-active .pp-nav-indicator {
  margin-right: 8px;
}
.is-variant-shift .pp-bottom-nav-item.is-active .pp-nav-icon {
  color: var(--pp-primary, #007aff);
}
.is-variant-shift .pp-nav-label {
  font-size: 14px;
  font-weight: 600;
  color: var(--pp-primary, #007aff);
  opacity: 0;
  transform: translateX(-10px);
  animation: slideFadeIn 0.3s forwards;
}

@keyframes slideFadeIn {
  to {
    opacity: 1;
    transform: translateX(0);
  }
}

/* ========================================================== */
/* VARIANT: DOT                                               */
/* ========================================================== */
.is-variant-dot {
  background-color: #ffffff;
  height: 60px;
}
.is-variant-dot .pp-sliding-indicator {
  align-items: flex-end;
  padding-bottom: calc(10px + env(safe-area-inset-bottom, 0));
}
.is-variant-dot .pp-indicator-inner {
  width: 6px;
  height: 6px;
  border-radius: 50%;
  background-color: var(--pp-primary, #007aff);
}
.is-variant-dot .pp-nav-indicator {
  background: transparent !important;
}
.is-variant-dot .pp-nav-label {
  display: none;
}
.is-variant-dot .pp-bottom-nav-item.is-active .pp-nav-icon {
  color: var(--pp-primary, #007aff);
  animation: bounce 0.5s cubic-bezier(0.34, 1.56, 0.64, 1);
}

@keyframes bounce {
  0% { transform: translateY(0); }
  50% { transform: translateY(-8px); }
  100% { transform: translateY(0); }
}

/* ========================================================== */
/* VARIANT: BUBBLE                                            */
/* ========================================================== */
.is-variant-bubble {
  background-color: #ffffff;
  box-shadow: 0 -2px 10px rgba(0,0,0,0.05);
  height: 60px;
}
.is-variant-bubble .pp-nav-indicator {
  width: 48px;
  height: 48px;
  border-radius: 24px;
  background: transparent;
  transition: all 0.4s cubic-bezier(0.34, 1.56, 0.64, 1);
}
.is-variant-bubble .pp-nav-label {
  display: none;
}
.is-variant-bubble .pp-bottom-nav-item.is-active .pp-nav-indicator {
  background-color: var(--pp-primary, #007aff);
  transform: translateY(-12px) scale(1.1);
  box-shadow: 0 4px 12px rgba(0, 122, 255, 0.3);
}
.is-variant-bubble .pp-bottom-nav-item.is-active .pp-nav-icon {
  color: #ffffff;
}

/* ========================================================== */
/* VARIANT: MAGIC-LINE                                        */
/* ========================================================== */
.is-variant-magic-line {
  background-color: #1a1a24; /* Dark sleek background */
  box-shadow: 0 -4px 20px rgba(0,0,0,0.2);
  height: 60px;
}
.is-variant-magic-line .pp-sliding-indicator {
  align-items: flex-start;
}
.is-variant-magic-line .pp-indicator-inner {
  width: 50%;
  height: 3px;
  border-radius: 0 0 4px 4px;
  background-color: var(--pp-primary-light, #4da3ff);
  box-shadow: 0 2px 10px var(--pp-primary, #007aff);
}
.is-variant-magic-line .pp-nav-indicator {
  background: transparent !important;
}
.is-variant-magic-line .pp-nav-icon,
.is-variant-magic-line .pp-nav-label {
  color: #888899;
}
.is-variant-magic-line .pp-bottom-nav-item.is-active .pp-nav-icon {
  color: var(--pp-primary-light, #4da3ff);
  filter: drop-shadow(0 0 8px rgba(77, 163, 255, 0.6));
  transform: translateY(-2px);
}
.is-variant-magic-line .pp-bottom-nav-item.is-active .pp-nav-label {
  color: #ffffff;
}

/* ========================================================== */
/* VARIANT: CURVED (The Cutout)                               */
/* ========================================================== */
.is-variant-curved {
  background-color: #ffffff;
  height: 64px;
  border-top-left-radius: 16px;
  border-top-right-radius: 16px;
  box-shadow: 0 -4px 20px rgba(0,0,0,0.06);
}
.is-variant-curved .pp-sliding-indicator {
  align-items: flex-start;
  z-index: 2; /* Put above the background */
}
.is-variant-curved .pp-indicator-inner {
  /* Creates a floating circle with a border matching the page background */
  width: 56px;
  height: 56px;
  border-radius: 50%;
  background-color: var(--pp-primary, #007aff);
  border: 6px solid #f9f9fc; /* Assuming page background is slightly gray or white */
  transform: translateY(-24px); /* Float up */
  box-shadow: 0 8px 16px rgba(0, 122, 255, 0.4);
}
.is-variant-curved .pp-bottom-nav-item {
  z-index: 3; /* Keep icons above the floating circle */
}
.is-variant-curved .pp-nav-indicator {
  background: transparent !important;
  margin-bottom: 2px;
}
.is-variant-curved .pp-nav-label {
  display: none;
}
.is-variant-curved .pp-bottom-nav-item.is-active .pp-nav-icon {
  color: #ffffff;
  transform: translateY(-24px);
  animation: floatUp 0.4s cubic-bezier(0.34, 1.56, 0.64, 1);
}

@keyframes floatUp {
  0% { transform: translateY(0) scale(0.8); }
  100% { transform: translateY(-24px) scale(1); }
}

/* ========================================================== */
/* VARIANT: PILL-SLIDE (Segmented Control)                    */
/* ========================================================== */
.is-variant-pill-slide {
  height: 56px;
  background-color: #eef0f4;
  border-radius: 28px;
  margin: 12px 16px calc(12px + env(safe-area-inset-bottom, 0)) 16px;
  width: calc(100% - 32px);
  box-shadow: inset 0 2px 4px rgba(0,0,0,0.03);
  box-sizing: border-box;
  padding-bottom: 0;
}
.is-variant-pill-slide .pp-sliding-indicator {
  padding: 4px;
  box-sizing: border-box;
}
.is-variant-pill-slide .pp-indicator-inner {
  width: 100%;
  height: 100%;
  border-radius: 24px;
  background-color: #ffffff;
  box-shadow: 0 2px 8px rgba(0,0,0,0.08);
}
.is-variant-pill-slide .pp-nav-indicator {
  margin-bottom: 2px;
  background: transparent !important;
}
.is-variant-pill-slide .pp-bottom-nav-item {
  z-index: 1; /* keep above the slide */
}
.is-variant-pill-slide .pp-nav-icon {
  font-size: 20px;
  color: #8c939d;
}
.is-variant-pill-slide .pp-nav-label {
  font-size: 10px;
  color: #8c939d;
}
.is-variant-pill-slide .pp-bottom-nav-item.is-active .pp-nav-icon,
.is-variant-pill-slide .pp-bottom-nav-item.is-active .pp-nav-label {
  color: #1a1a1a;
  font-weight: 700;
}

/* ========================================================== */
/* VARIANT: CUTOUT (Centered FAB style)                       */
/* ========================================================== */
.is-variant-cutout {
  background-color: transparent;
  box-shadow: none;
  height: 90px; /* Make taller to accommodate the FAB cutout */
  align-items: flex-end;
}
.pp-cutout-bg {
  position: absolute;
  top: 10px; 
  left: 0; 
  right: 0; 
  bottom: 0;
  background-color: #ffffff;
  border-top-left-radius: 32px;
  border-top-right-radius: 32px;
  filter: drop-shadow(0 -4px 10px rgba(0,0,0,0.06));
  z-index: 0;
}
.pp-cutout-bg::before {
  content: '';
  position: absolute;
  top: -40px;
  left: 50%;
  transform: translateX(-50%);
  width: 80px;
  height: 80px;
  background-color: #ffffff;
  border-radius: 50%;
}
.is-variant-cutout .pp-bottom-nav-item {
  z-index: 1;
  height: 80px; /* Align to bottom */
}
.is-variant-cutout .pp-nav-indicator {
  background: transparent !important;
}
.is-variant-cutout .is-action-item {
  position: relative;
}
.is-variant-cutout .is-action-item .pp-fab-wrapper {
  position: absolute;
  top: -32px; /* Lift up */
  width: 64px;
  height: 64px;
  border-radius: 50%;
  background-color: var(--pp-primary, #007aff);
  box-shadow: 0 6px 16px rgba(0, 122, 255, 0.4);
  display: flex;
  align-items: center;
  justify-content: center;
}
.is-variant-cutout .is-action-item .pp-nav-icon {
  color: #ffffff !important;
  font-size: 28px;
}
.is-variant-cutout .is-action-item .pp-nav-label {
  margin-top: 40px; /* Push label below the FAB */
  font-weight: 600;
}
</style>
