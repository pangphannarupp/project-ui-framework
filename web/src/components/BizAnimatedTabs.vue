<template>
  <div class="pp-animated-tabs">
    <!-- Content Area -->
    <div 
      class="tab-content-wrapper"
      @touchstart="handleTouchStart"
      @touchmove="handleTouchMove"
      @touchend="handleTouchEnd"
    >
      <transition :name="transitionName" mode="out-in">
        <div :key="modelValue" class="tab-content">
          <slot :name="`tab-${modelValue}`"></slot>
        </div>
      </transition>
    </div>

    <!-- Liquid Glass Tab Bar -->
    <div class="liquid-glass-container">
      <div class="liquid-glass-tab-bar">
        <button 
          v-for="(tab, index) in tabs" 
          :key="index"
          class="tab-btn"
          :class="{ active: modelValue === index }"
          @click="selectTab(index)"
        >
          <ion-icon v-if="tab.icon" :icon="tab.icon" />
          <span>{{ tab.label }}</span>
        </button>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { IonIcon } from '@ionic/vue';

const props = defineProps<{
  modelValue: number;
  tabs: Array<{ label: string; icon?: any }>;
}>();

const emit = defineEmits(['update:modelValue']);

// Determines if we slide left or right based on index change
const transitionName = ref('slide-left');

const selectTab = (index: number) => {
  if (index === props.modelValue) return;
  
  // Animate left if moving to a higher index, right if moving to a lower index
  transitionName.value = index > props.modelValue ? 'slide-left' : 'slide-right';
  emit('update:modelValue', index);
};

// Swipe Gestures
const touchStartX = ref(0);
const touchEndX = ref(0);
const minSwipeDistance = 50;

const handleTouchStart = (e: TouchEvent) => {
  touchStartX.value = e.changedTouches[0].screenX;
  touchEndX.value = e.changedTouches[0].screenX;
};

const handleTouchMove = (e: TouchEvent) => {
  touchEndX.value = e.changedTouches[0].screenX;
};

const handleTouchEnd = () => {
  const distance = touchEndX.value - touchStartX.value;
  
  if (Math.abs(distance) > minSwipeDistance) {
    if (distance > 0) {
      // Swiped right (move to previous tab)
      if (props.modelValue > 0) {
        selectTab(props.modelValue - 1);
      }
    } else {
      // Swiped left (move to next tab)
      if (props.modelValue < props.tabs.length - 1) {
        selectTab(props.modelValue + 1);
      }
    }
  }
  
  // Reset values
  touchStartX.value = 0;
  touchEndX.value = 0;
};
</script>

<style scoped>
.pp-animated-tabs {
  position: relative;
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column;
  overflow: hidden;
}

.tab-content-wrapper {
  flex: 1;
  position: relative;
  overflow-y: auto;
  overflow-x: hidden;
  padding-bottom: 90px; /* Space for the floating tab bar */
}

.tab-content {
  width: 100%;
  height: 100%;
}

/* Animations */
.slide-left-enter-active,
.slide-left-leave-active,
.slide-right-enter-active,
.slide-right-leave-active {
  transition: all 0.35s cubic-bezier(0.25, 0.8, 0.25, 1);
}

.slide-left-enter-from {
  opacity: 0;
  transform: translateX(40px);
}
.slide-left-leave-to {
  opacity: 0;
  transform: translateX(-40px);
}

.slide-right-enter-from {
  opacity: 0;
  transform: translateX(-40px);
}
.slide-right-leave-to {
  opacity: 0;
  transform: translateX(40px);
}

/* Liquid Glass Tab Bar Styles */
.liquid-glass-container {
  position: absolute;
  bottom: 24px;
  left: 0;
  right: 0;
  display: flex;
  justify-content: center;
  pointer-events: none;
  z-index: 100;
}

.liquid-glass-tab-bar {
  display: flex;
  align-items: center;
  justify-content: space-around;
  width: 90%;
  max-width: 400px;
  height: 64px;
  border-radius: 32px;
  pointer-events: auto;
  
  background: rgba(255, 255, 255, 0.4);
  backdrop-filter: blur(24px) saturate(150%);
  -webkit-backdrop-filter: blur(24px) saturate(150%);
  border: 1px solid rgba(255, 255, 255, 0.6);
  box-shadow: 
    0 8px 32px rgba(0, 0, 0, 0.15),
    inset 0 1px 1px rgba(255, 255, 255, 0.8),
    inset 0 -1px 1px rgba(255, 255, 255, 0.1);
  overflow: hidden;
}

.tab-btn {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  width: 100%;
  height: 100%;
  background: transparent;
  border: none;
  outline: none;
  color: #555;
  cursor: pointer;
  transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
  border-radius: 20px;
  gap: 4px;
  padding: 0;
}

.tab-btn ion-icon {
  font-size: 22px;
  transition: transform 0.3s ease;
}

.tab-btn span {
  font-size: 11px;
  font-weight: 500;
  opacity: 0.8;
  transition: opacity 0.3s ease;
}

/* Active State */
.tab-btn.active {
  color: #007aff;
}

.tab-btn.active ion-icon {
  transform: translateY(-2px) scale(1.1);
}

.tab-btn.active span {
  opacity: 1;
  font-weight: 600;
}

@media (hover: hover) {
  .tab-btn:hover {
    background: rgba(255, 255, 255, 0.2);
  }
}

/* Dark Mode Support */
@media (prefers-color-scheme: dark) {
  .liquid-glass-tab-bar {
    background: rgba(30, 30, 30, 0.45);
    border: 1px solid rgba(255, 255, 255, 0.15);
    box-shadow: 
      0 8px 32px rgba(0, 0, 0, 0.4),
      inset 0 1px 1px rgba(255, 255, 255, 0.15),
      inset 0 -1px 1px rgba(0, 0, 0, 0.3);
  }
  
  .tab-btn {
    color: #bbb;
  }
  
  .tab-btn.active {
    color: #4da6ff;
  }
  
  @media (hover: hover) {
    .tab-btn:hover {
      background: rgba(255, 255, 255, 0.05);
    }
  }
}
</style>
