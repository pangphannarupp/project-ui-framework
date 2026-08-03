<template>
  <div class="pp-ribbon-container" :class="[`pp-ribbon--${variant}`]">
    <!-- Ribbon Headers -->
    <div class="pp-ribbon-header">
      <div class="pp-ribbon-tabs">
        <div 
          v-for="tab in tabs" 
          :key="tab.id"
          :class="[
            'pp-ribbon-tab-header',
            { 'pp-ribbon-tab-header--active': activeTabId === tab.id },
            { 'pp-ribbon-tab-header--special': tab.color === 'primary' }
          ]"
          @click="handleTabClick(tab.id)"
        >
          {{ tab.title }}
        </div>
      </div>
      
      <div class="pp-ribbon-actions" v-if="collapsible">
        <div class="pp-ribbon-collapse-toggle" @click="isCollapsed = !isCollapsed" :title="isCollapsed ? 'Expand Ribbon' : 'Collapse Ribbon'">
          <svg v-if="!isCollapsed" viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><polyline points="18 15 12 9 6 15"></polyline></svg>
          <svg v-else viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><polyline points="6 9 12 15 18 9"></polyline></svg>
        </div>
      </div>
    </div>
    
    <!-- Ribbon Body (Slots for PPRibbonTab) -->
    <div class="pp-ribbon-body" v-show="!isCollapsed">
      <slot></slot>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, provide, watch } from 'vue';

const props = withDefaults(defineProps<{
  modelValue?: string; // Optional controlled active tab ID
  variant?: 'classic' | 'modern' | 'glass';
  collapsible?: boolean;
}>(), {
  variant: 'classic',
  collapsible: true
});

const emit = defineEmits<{
  (e: 'update:modelValue', value: string): void;
}>();

const variant = ref(props.variant);

const tabs = ref<{ id: string; title: string; color?: string }[]>([]);
const activeTabId = ref(props.modelValue || '');
const isCollapsed = ref(false);

const handleTabClick = (id: string) => {
  if (activeTabId.value === id && props.collapsible) {
    isCollapsed.value = !isCollapsed.value;
  } else {
    activeTabId.value = id;
    isCollapsed.value = false;
  }
};

watch(() => props.modelValue, (newVal) => {
  if (newVal) {
    activeTabId.value = newVal;
    isCollapsed.value = false;
  }
});

watch(activeTabId, (newVal) => {
  emit('update:modelValue', newVal);
});

// Provide a way for child tabs to register themselves
provide('ppRibbonRegisterTab', (tab: { id: string; title: string; color?: string }) => {
  tabs.value.push(tab);
  if (!activeTabId.value) {
    activeTabId.value = tab.id;
  }
});

provide('ppRibbonActiveTab', activeTabId);

</script>

<style scoped>
/* BASE STYLES */
.pp-ribbon-container {
  display: flex;
  flex-direction: column;
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  user-select: none;
}

.pp-ribbon-header {
  display: flex;
  align-items: flex-end;
  justify-content: space-between;
}

.pp-ribbon-tabs {
  display: flex;
  align-items: flex-end;
  flex: 1;
}

.pp-ribbon-actions {
  display: flex;
  align-items: center;
  padding-right: 8px;
  padding-bottom: 4px;
}

.pp-ribbon-collapse-toggle {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 24px;
  height: 24px;
  border-radius: 4px;
  cursor: pointer;
  color: #6b7280;
  transition: all 0.2s;
}

.pp-ribbon-collapse-toggle:hover {
  background-color: rgba(0, 0, 0, 0.05);
  color: #111827;
}

.pp-ribbon-tab-header {
  cursor: pointer;
  transition: all 0.2s ease;
}

.pp-ribbon-body {
  display: flex;
}

/* CLASSIC VARIANT */
.pp-ribbon--classic {
  background-color: #f3f4f6; 
  border: 1px solid #d1d5db;
}

.pp-ribbon--classic .pp-ribbon-header {
  gap: 2px;
  padding: 4px 8px 0;
  background-color: #ffffff;
  border-bottom: 1px solid #d1d5db;
}

.pp-ribbon--classic .pp-ribbon-tab-header {
  padding: 6px 16px;
  font-size: 13px;
  color: #4b5563;
  border: 1px solid transparent;
  border-bottom: none;
  border-radius: 4px 4px 0 0;
  margin-bottom: -1px;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.pp-ribbon--classic .pp-ribbon-tab-header:hover {
  background-color: #e5e7eb;
}

.pp-ribbon--classic .pp-ribbon-tab-header--active {
  background-color: #f3f4f6;
  border-color: #d1d5db;
  color: var(--pp-primary-variant, #1a2a5e);
  font-weight: 600;
}

.pp-ribbon--classic .pp-ribbon-tab-header--special {
  background-color: var(--pp-primary-variant, #1a2a5e);
  color: #ffffff;
  border-color: var(--pp-primary-variant, #1a2a5e);
}

.pp-ribbon--classic .pp-ribbon-tab-header--special.pp-ribbon-tab-header--active {
  background-color: #f3f4f6;
  color: var(--pp-primary-variant, #1a2a5e);
}

.pp-ribbon--classic .pp-ribbon-body {
  padding: 8px 12px;
  min-height: 96px;
  background-color: #f3f4f6;
}


/* MODERN VARIANT */
.pp-ribbon--modern {
  background-color: #ffffff;
  border: 1px solid #e5e7eb;
}

.pp-ribbon--modern .pp-ribbon-header {
  gap: 16px;
  padding: 0 16px;
  border-bottom: 1px solid #e5e7eb;
  background-color: #ffffff;
}

.pp-ribbon--modern .pp-ribbon-tab-header {
  padding: 12px 4px;
  margin-bottom: -1px;
  font-size: 14px;
  color: #6b7280;
  font-weight: 500;
  border-bottom: 2px solid transparent;
}

.pp-ribbon--modern .pp-ribbon-tab-header:hover {
  color: #111827;
}

.pp-ribbon--modern .pp-ribbon-tab-header--active {
  color: var(--pp-primary-variant, #1a2a5e);
  border-bottom-color: var(--pp-primary-variant, #1a2a5e);
}

.pp-ribbon--modern .pp-ribbon-tab-header--special {
  color: var(--pp-primary-variant, #1a2a5e);
  font-weight: 700;
}

.pp-ribbon--modern .pp-ribbon-body {
  padding: 8px 16px;
  min-height: 80px;
  background-color: #ffffff;
}


/* GLASS VARIANT */
.pp-ribbon--glass {
  background-color: rgba(255, 255, 255, 0.5);
  backdrop-filter: blur(12px);
  -webkit-backdrop-filter: blur(12px);
  border: 1px solid rgba(255, 255, 255, 0.4);
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.05);
  border-radius: 12px;
  overflow: hidden;
}

.pp-ribbon--glass .pp-ribbon-header {
  gap: 16px;
  padding: 0 16px;
  background-color: rgba(255, 255, 255, 0.2);
  border-bottom: 1px solid rgba(255, 255, 255, 0.5);
}

.pp-ribbon--glass .pp-ribbon-tab-header {
  padding: 12px 4px;
  margin-bottom: -1px;
  font-size: 14px;
  color: rgba(17, 24, 39, 0.7);
  font-weight: 600;
  border-bottom: 2px solid transparent;
}

.pp-ribbon--glass .pp-ribbon-tab-header:hover {
  color: rgba(17, 24, 39, 0.9);
}

.pp-ribbon--glass .pp-ribbon-tab-header--active {
  color: var(--pp-primary-variant, #1a2a5e);
  border-bottom-color: var(--pp-primary-variant, #1a2a5e);
}

.pp-ribbon--glass .pp-ribbon-body {
  padding: 8px 16px;
  min-height: 80px;
  background-color: transparent;
}
</style>
