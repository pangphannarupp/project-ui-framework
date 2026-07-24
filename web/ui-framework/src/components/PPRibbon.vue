<template>
  <div class="pp-ribbon-container">
    <!-- Ribbon Headers -->
    <div class="pp-ribbon-header">
      <div 
        v-for="tab in tabs" 
        :key="tab.id"
        :class="[
          'pp-ribbon-tab-header',
          { 'pp-ribbon-tab-header--active': activeTabId === tab.id },
          { 'pp-ribbon-tab-header--special': tab.color === 'primary' }
        ]"
        @click="activeTabId = tab.id"
      >
        {{ tab.title }}
      </div>
    </div>
    
    <!-- Ribbon Body (Slots for PPRibbonTab) -->
    <div class="pp-ribbon-body">
      <slot></slot>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, provide, watch } from 'vue';

const props = defineProps<{
  modelValue?: string; // Optional controlled active tab ID
}>();

const emit = defineEmits<{
  (e: 'update:modelValue', value: string): void;
}>();

const tabs = ref<{ id: string; title: string; color?: string }[]>([]);
const activeTabId = ref(props.modelValue || '');

watch(() => props.modelValue, (newVal) => {
  if (newVal) activeTabId.value = newVal;
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
.pp-ribbon-container {
  display: flex;
  flex-direction: column;
  background-color: #f3f4f6; /* Classic Office grey background */
  border: 1px solid #d1d5db;
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  user-select: none;
}

.pp-ribbon-header {
  display: flex;
  align-items: flex-end;
  gap: 2px;
  padding: 4px 8px 0;
  background-color: #ffffff;
  border-bottom: 1px solid #d1d5db;
}

.pp-ribbon-tab-header {
  padding: 6px 16px;
  font-size: 13px;
  color: #4b5563;
  cursor: pointer;
  border: 1px solid transparent;
  border-bottom: none;
  border-radius: 4px 4px 0 0;
  margin-bottom: -1px;
  transition: background-color 0.2s, color 0.2s;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.pp-ribbon-tab-header:hover {
  background-color: #e5e7eb;
}

.pp-ribbon-tab-header--active {
  background-color: #f3f4f6;
  border-color: #d1d5db;
  color: var(--pp-primary-variant, #1a2a5e);
  font-weight: 600;
}

.pp-ribbon-tab-header--special {
  background-color: var(--pp-primary-variant, #1a2a5e);
  color: #ffffff;
  border-color: var(--pp-primary-variant, #1a2a5e);
}

.pp-ribbon-tab-header--special.pp-ribbon-tab-header--active {
  background-color: #f3f4f6;
  color: var(--pp-primary-variant, #1a2a5e);
}

.pp-ribbon-body {
  padding: 8px 12px;
  min-height: 96px;
  background-color: #f3f4f6;
  display: flex;
}
</style>
