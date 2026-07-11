<template>
  <div 
    class="biz-ptr-wrapper"
    @touchstart="onTouchStart"
    @touchmove="onTouchMove"
    @touchend="onTouchEnd"
  >
    <div 
      class="biz-ptr-indicator"
      :style="{
        height: `${pullDistance}px`,
        transition: isRefreshing || isRestoring ? 'height 0.3s cubic-bezier(0.4, 0.0, 0.2, 1)' : 'none'
      }"
    >
      <div class="biz-ptr-indicator-content" :style="{ opacity: pullProgress }">
        <div v-if="isRefreshing" class="biz-ptr-spinner">
          <svg viewBox="0 0 50 50">
            <circle cx="25" cy="25" r="20" fill="none" stroke-width="4" stroke="currentColor"></circle>
          </svg>
        </div>
        <div 
          v-else 
          class="biz-ptr-arrow"
          :style="{ transform: `rotate(${pullProgress >= 1 ? 180 : 0}deg)` }"
        >
          <svg viewBox="0 0 24 24" width="24" height="24" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round">
            <line x1="12" y1="5" x2="12" y2="19"></line>
            <polyline points="19 12 12 19 5 12"></polyline>
          </svg>
        </div>
      </div>
    </div>
    
    <div 
      class="biz-ptr-content"
      @scroll="onScroll"
      ref="contentRef"
    >
      <slot></slot>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

const emit = defineEmits(['refresh']);

const THRESHOLD = 60;
const MAX_PULL = 100;

const startY = ref(0);
const pullDistance = ref(0);
const isPulling = ref(false);
const isRefreshing = ref(false);
const isRestoring = ref(false);
const scrollTop = ref(0);
const contentRef = ref<HTMLElement | null>(null);

const pullProgress = computed(() => {
  return Math.min(pullDistance.value / THRESHOLD, 1);
});

const onScroll = (e: Event) => {
  const target = e.target as HTMLElement;
  scrollTop.value = target.scrollTop;
};

const onTouchStart = (e: TouchEvent) => {
  if (scrollTop.value > 0 || isRefreshing.value) return;
  startY.value = e.touches[0].clientY;
  isPulling.value = true;
  isRestoring.value = false;
};

const onTouchMove = (e: TouchEvent) => {
  if (!isPulling.value) return;
  
  const y = e.touches[0].clientY;
  const deltaY = y - startY.value;
  
  if (deltaY > 0 && scrollTop.value <= 0) {
    // Add resistance
    pullDistance.value = Math.min(deltaY * 0.5, MAX_PULL);
    if (e.cancelable) e.preventDefault();
  } else {
    pullDistance.value = 0;
  }
};

const onTouchEnd = () => {
  if (!isPulling.value) return;
  isPulling.value = false;
  
  if (pullDistance.value >= THRESHOLD) {
    isRefreshing.value = true;
    pullDistance.value = THRESHOLD;
    emit('refresh', completeRefresh);
  } else {
    isRestoring.value = true;
    pullDistance.value = 0;
    setTimeout(() => { 
      isRestoring.value = false; 
    }, 300);
  }
};

const completeRefresh = () => {
  isRefreshing.value = false;
  isRestoring.value = true;
  pullDistance.value = 0;
  setTimeout(() => { 
    isRestoring.value = false; 
  }, 300);
};
</script>

<style scoped>
.biz-ptr-wrapper {
  display: flex;
  flex-direction: column;
  height: 100%;
  width: 100%;
  overflow: hidden;
  position: relative;
  background-color: #f4f5f8;
}

.biz-ptr-indicator {
  display: flex;
  justify-content: center;
  align-items: flex-end;
  overflow: hidden;
  width: 100%;
  background-color: transparent;
}

.biz-ptr-indicator-content {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 60px; /* Threshold height */
  width: 100%;
  color: var(--biz-primary-variant, #1a2a5e);
}

.biz-ptr-arrow {
  transition: transform 0.2s ease;
  display: flex;
  align-items: center;
  justify-content: center;
  width: 32px;
  height: 32px;
  border-radius: 50%;
  background: white;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.biz-ptr-spinner {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 32px;
  height: 32px;
  border-radius: 50%;
  background: white;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.biz-ptr-spinner svg {
  width: 20px;
  height: 20px;
  animation: rotate 2s linear infinite;
}

.biz-ptr-spinner circle {
  stroke: currentColor;
  stroke-dasharray: 1, 200;
  stroke-dashoffset: 0;
  animation: dash 1.5s ease-in-out infinite;
  stroke-linecap: round;
}

@keyframes rotate {
  100% {
    transform: rotate(360deg);
  }
}

@keyframes dash {
  0% {
    stroke-dasharray: 1, 200;
    stroke-dashoffset: 0;
  }
  50% {
    stroke-dasharray: 90, 200;
    stroke-dashoffset: -35px;
  }
  100% {
    stroke-dasharray: 90, 200;
    stroke-dashoffset: -124px;
  }
}

.biz-ptr-content {
  flex: 1;
  overflow-y: auto;
  height: 100%;
  -webkit-overflow-scrolling: touch;
  position: relative;
}
</style>
