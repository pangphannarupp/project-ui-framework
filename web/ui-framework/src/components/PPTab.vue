<template>
  <button 
    class="pp-tab" 
    :class="[
      { 'is-active': isActive },
      `pp-tab--${variant}`
    ]"
    @click="handleClick"
  >
    <slot></slot>
  </button>
</template>

<script setup lang="ts">
import { inject, computed } from 'vue';

const props = defineProps<{
  value: string | number;
}>();

const tabsContext = inject('ppTabsContext') as any;

const isActive = computed(() => {
  return tabsContext?.activeTab.value === props.value;
});

const variant = computed(() => {
  return tabsContext?.variant || 'standard';
});

const handleClick = () => {
  if (tabsContext && tabsContext.setActiveTab) {
    tabsContext.setActiveTab(props.value);
  }
};
</script>

<style scoped>
.pp-tab {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: 10px 16px;
  font-size: 15px;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.2s ease;
  white-space: nowrap;
  background: transparent;
  border: none;
  outline: none;
  color: #6b7280;
}

/* Standard Variant */
.pp-tab--standard {
  border-bottom: 2px solid transparent;
}
.pp-tab--standard:hover {
  color: #374151;
}
.pp-tab--standard.is-active {
  color: var(--pp-primary-variant, #1a2a5e);
  border-bottom-color: var(--pp-primary-variant, #1a2a5e);
}

/* Pills Variant */
.pp-tab--pills {
  border-radius: 20px;
  background-color: transparent;
}
.pp-tab--pills:hover:not(.is-active) {
  background-color: #f3f4f6;
  color: #374151;
}
.pp-tab--pills.is-active {
  background-color: var(--pp-primary-variant, #1a2a5e);
  color: #ffffff;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

/* Segmented Variant */
.pp-tab--segmented {
  flex: 1;
  border-radius: 8px;
  padding: 8px 12px;
}
.pp-tab--segmented:hover:not(.is-active) {
  background-color: rgba(0,0,0,0.05);
}
.pp-tab--segmented.is-active {
  background-color: #ffffff;
  color: var(--pp-primary-variant, #1a2a5e);
  box-shadow: 0 1px 3px rgba(0,0,0,0.1);
}

/* Outlined Variant */
.pp-tab--outlined {
  border: 1px solid #d1d5db;
  border-radius: 20px;
  background-color: transparent;
  color: #6b7280;
}
.pp-tab--outlined:hover:not(.is-active) {
  border-color: #9ca3af;
  color: #374151;
}
.pp-tab--outlined.is-active {
  border-color: var(--pp-primary-variant, #1a2a5e);
  color: var(--pp-primary-variant, #1a2a5e);
  background-color: #eff6ff; /* soft blue background */
}

/* Minimal Variant */
.pp-tab--minimal {
  background-color: transparent;
  font-weight: 600;
  padding: 8px 12px;
  color: #9ca3af;
  border-radius: 8px;
}
.pp-tab--minimal:hover:not(.is-active) {
  color: #4b5563;
}
.pp-tab--minimal.is-active {
  color: #111827;
  background-color: #f3f4f6;
}
</style>
