<template>
  <div class="pp-collapse-item" :class="[
    { 'is-active': isActive, 'is-disabled': disabled },
    `pp-collapse-item--${variant}`
  ]">
    <div 
      class="pp-collapse-item__header" 
      @click="handleHeaderClick"
    >
      <slot name="title">
        <span class="pp-collapse-item__title">{{ title }}</span>
      </slot>
      
      <div class="pp-collapse-item__icon-wrapper" :class="{ 'is-active': isActive }">
        <slot name="icon">
          <svg viewBox="0 0 24 24" width="20" height="20" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round" class="pp-collapse-item__arrow">
            <polyline points="6 9 12 15 18 9"></polyline>
          </svg>
        </slot>
      </div>
    </div>
    
    <div class="pp-collapse-item__wrap" :class="{ 'is-active': isActive }">
      <div class="pp-collapse-item__content">
        <slot></slot>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { inject, computed } from 'vue';

const props = defineProps({
  name: {
    type: [String, Number],
    required: true
  },
  title: {
    type: String,
    default: ''
  },
  disabled: {
    type: Boolean,
    default: false
  }
});

const collapse = inject<any>('pp-collapse', null);

const isActive = computed(() => {
  return collapse?.activeNames.value.includes(props.name) || false;
});

const variant = computed(() => {
  return collapse?.variant?.value || 'default';
});

const handleHeaderClick = () => {
  if (props.disabled) return;
  collapse?.handleItemClick(props.name);
};
</script>

<style scoped>
.pp-collapse-item {
  transition: all 0.3s ease;
}

/* Default & Flush Variant Borders */
.pp-collapse-item--default, .pp-collapse-item--flush {
  border-bottom: 1px solid var(--pp-border-color, #e0e2ec);
}
.pp-collapse-item--default:last-child, .pp-collapse-item--flush:last-child {
  border-bottom: none;
}

/* Separated Variant */
.pp-collapse-item--separated {
  border: 1px solid var(--pp-border-color, #e0e2ec);
  border-radius: 12px;
  background-color: var(--pp-bg-color, #ffffff);
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
  overflow: hidden;
}

/* Filled Variant */
.pp-collapse-item--filled {
  background-color: #f3f4f6; /* light gray bg */
  border-radius: 12px;
  overflow: hidden;
}
.pp-collapse-item--filled .pp-collapse-item__wrap {
  background-color: var(--pp-bg-color, #ffffff); /* white content area */
}

/* Header Styles */
.pp-collapse-item__header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  height: 48px;
  line-height: 48px;
  background-color: transparent;
  color: var(--pp-text-color, #1a1b21);
  cursor: pointer;
  font-size: 14px;
  font-weight: 500;
  transition: border-bottom-color 0.3s, background-color 0.3s;
  outline: none;
  padding: 0 16px;
}

.pp-collapse-item.is-disabled .pp-collapse-item__header {
  color: var(--pp-text-disabled-color, #c4c7c5);
  cursor: not-allowed;
}

.pp-collapse-item__title {
  flex: 1;
}

.pp-collapse-item__icon-wrapper {
  display: flex;
  align-items: center;
  justify-content: center;
  transition: transform 0.3s;
  color: var(--pp-icon-color, #44474f);
}

.pp-collapse-item__icon-wrapper.is-active {
  transform: rotate(180deg);
}

.pp-collapse-item.is-disabled .pp-collapse-item__icon-wrapper {
  color: var(--pp-text-disabled-color, #c4c7c5);
}

/* Wrapper for animating height */
.pp-collapse-item__wrap {
  display: grid;
  grid-template-rows: 0fr;
  transition: grid-template-rows 0.3s cubic-bezier(0.4, 0, 0.2, 1), background-color 0.3s;
  overflow: hidden;
  background-color: transparent;
}

.pp-collapse-item__wrap.is-active {
  grid-template-rows: 1fr;
}

.pp-collapse-item__content {
  min-height: 0; 
  padding: 0 16px;
  color: var(--pp-text-secondary, #44474f);
  font-size: 14px;
  line-height: 1.5;
}

.pp-collapse-item__wrap.is-active .pp-collapse-item__content {
  padding-bottom: 16px;
}
</style>
