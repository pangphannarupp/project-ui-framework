<template>
  <div class="pp-animated-tabs-container">
    
    <!-- Tab Content Area -->
    <div class="pp-animated-tabs-content">
      <transition :name="transitionName" mode="out-in">
        <div :key="modelValue" class="pp-tab-pane">
          <slot :name="`tab-${modelValue}`"></slot>
        </div>
      </transition>
    </div>

    <!-- Liquid Glass Tab Bar -->
    <div class="pp-liquid-tab-bar-wrapper">
      <div class="pp-liquid-tab-bar">
        
        <!-- Sliding Active Indicator -->
        <div 
          class="pp-liquid-indicator"
          :style="{
            width: `${100 / tabs.length}%`,
            transform: `translateX(${modelValue * 100}%)`
          }"
        ></div>

        <!-- Tab Items -->
        <div 
          v-for="(tab, index) in tabs" 
          :key="index"
          class="pp-liquid-tab-item"
          :class="{ 'is-active': modelValue === index }"
          @click="selectTab(index)"
        >
          <ion-icon v-if="tab.icon" :icon="tab.icon" class="pp-liquid-icon"></ion-icon>
          <span v-if="tab.label" class="pp-liquid-label">{{ tab.label }}</span>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, watch } from 'vue';
import { IonIcon } from '@ionic/vue';

export interface AnimatedTab {
  label?: string;
  icon?: any;
}

const props = defineProps<{
  modelValue: number;
  tabs: AnimatedTab[];
}>();

const emit = defineEmits<{
  (e: 'update:modelValue', val: number): void;
  (e: 'change', val: number): void;
}>();

const transitionName = ref('slide-right');

watch(() => props.modelValue, (newVal, oldVal) => {
  if (newVal > oldVal) {
    transitionName.value = 'slide-left';
  } else {
    transitionName.value = 'slide-right';
  }
});

const selectTab = (index: number) => {
  emit('update:modelValue', index);
  emit('change', index);
};
</script>

<style scoped>
.pp-animated-tabs-container {
  position: relative;
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column;
  overflow: hidden;
}

.pp-animated-tabs-content {
  flex: 1;
  position: relative;
  overflow: hidden;
}

.pp-tab-pane {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  overflow-y: auto;
}

/* Transitions */
.slide-left-enter-active,
.slide-left-leave-active,
.slide-right-enter-active,
.slide-right-leave-active {
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.slide-left-enter-from {
  opacity: 0;
  transform: translateX(30px);
}
.slide-left-leave-to {
  opacity: 0;
  transform: translateX(-30px);
}

.slide-right-enter-from {
  opacity: 0;
  transform: translateX(-30px);
}
.slide-right-leave-to {
  opacity: 0;
  transform: translateX(30px);
}

/* Liquid Glass Tab Bar */
.pp-liquid-tab-bar-wrapper {
  position: absolute;
  bottom: 24px;
  left: 0;
  width: 100%;
  display: flex;
  justify-content: center;
  padding: 0 20px;
  box-sizing: border-box;
  z-index: 10;
}

.pp-liquid-tab-bar {
  display: flex;
  position: relative;
  width: 100%;
  max-width: 400px;
  height: 64px;
  background: rgba(255, 255, 255, 0.4);
  backdrop-filter: blur(24px);
  -webkit-backdrop-filter: blur(24px);
  border-radius: 32px;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1), inset 0 1px 1px rgba(255, 255, 255, 0.4);
  border: 1px solid rgba(255, 255, 255, 0.5);
  overflow: hidden;
}

.pp-liquid-indicator {
  position: absolute;
  top: 0;
  left: 0;
  height: 100%;
  background: rgba(255, 255, 255, 0.6);
  border-radius: 32px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
  transition: transform 0.4s cubic-bezier(0.34, 1.56, 0.64, 1);
  z-index: 1;
}

.pp-liquid-tab-item {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  z-index: 2;
  -webkit-tap-highlight-color: transparent;
  transition: all 0.3s ease;
}

.pp-liquid-icon {
  font-size: 24px;
  color: rgba(0, 0, 0, 0.5);
  transition: color 0.3s ease;
  margin-bottom: 2px;
}

.pp-liquid-label {
  font-size: 11px;
  font-weight: 600;
  color: rgba(0, 0, 0, 0.5);
  transition: color 0.3s ease;
}

.pp-liquid-tab-item.is-active .pp-liquid-icon,
.pp-liquid-tab-item.is-active .pp-liquid-label {
  color: rgba(0, 0, 0, 0.9);
}
</style>
