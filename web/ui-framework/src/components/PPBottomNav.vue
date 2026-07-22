<template>
  <div class="pp-bottom-nav">
    <div 
      v-for="(item, index) in items" 
      :key="index"
      class="pp-bottom-nav-item"
      :class="{ 'is-active': modelValue === item.value }"
      @click="selectItem(item.value)"
    >
      <div class="pp-nav-indicator">
        <ion-icon :icon="modelValue === item.value ? (item.activeIcon || item.icon) : item.icon" class="pp-nav-icon"></ion-icon>
      </div>
      <span class="pp-nav-label">{{ item.label }}</span>
    </div>
  </div>
</template>

<script setup lang="ts">
import { IonIcon } from '@ionic/vue';

export interface BottomNavItem {
  label: string;
  value: string;
  icon: any;
  activeIcon?: any;
}

defineProps<{
  modelValue: string;
  items: any[];
}>();

const emit = defineEmits(['update:modelValue', 'change']);

const selectItem = (val: string) => {
  emit('update:modelValue', val);
  emit('change', val);
};
</script>

<style scoped>
.pp-bottom-nav {
  display: flex;
  align-items: center;
  justify-content: space-around;
  width: 100%;
  height: 80px;
  background-color: #f4f5f8;
  /* padding-bottom env handles iPhone X safe areas */
  padding-bottom: env(safe-area-inset-bottom, 0);
  box-shadow: 0 -1px 2px rgba(0,0,0,0.03);
  box-sizing: content-box;
}

.pp-bottom-nav-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  flex: 1;
  height: 100%;
  cursor: pointer;
  -webkit-tap-highlight-color: transparent;
}

.pp-nav-indicator {
  width: 64px;
  height: 32px;
  border-radius: 16px;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
  margin-bottom: 4px;
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
}

.pp-bottom-nav-item.is-active .pp-nav-indicator {
  background-color: #d3e3fd; /* Light blue */
  transform: scale(1.05);
}

.pp-bottom-nav-item.is-active .pp-nav-icon {
  color: #041e49; /* Dark blue */
}

.pp-bottom-nav-item.is-active .pp-nav-label {
  color: #1a1a1a;
  font-weight: 700;
}
</style>
