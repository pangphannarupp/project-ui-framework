<template>
  <div class="pp-dropdown-wrapper" ref="wrapperRef">
    <!-- Trigger -->
    <div class="dropdown-trigger" @click="toggleDropdown">
      <slot name="trigger"></slot>
    </div>

    <!-- Menu -->
    <transition name="dropdown-fade">
      <div 
        v-if="isOpen"
        class="pp-dropdown-menu"
        :class="[`placement-${placement}`]"
      >
        <ul class="dropdown-list">
          <li 
            v-for="(item, index) in items" 
            :key="index"
            class="dropdown-item"
            :class="{ 'is-disabled': item.disabled, 'is-danger': item.danger }"
            @click="handleItemClick(item)"
          >
            <ion-icon v-if="item.icon" :icon="item.icon" class="item-icon" />
            <span class="item-label">{{ item.label }}</span>
          </li>
        </ul>
      </div>
    </transition>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, onUnmounted } from 'vue';
import { IonIcon } from '@ionic/vue';

export interface DropdownItem {
  label: string;
  value?: any;
  icon?: any;
  disabled?: boolean;
  danger?: boolean;
}

withDefaults(defineProps<{
  items: DropdownItem[];
  placement?: 'bottom-left' | 'bottom-right' | 'top-left' | 'top-right';
}>(), {
  placement: 'bottom-right'
});

const emit = defineEmits(['select']);

const isOpen = ref(false);
const wrapperRef = ref<HTMLElement | null>(null);

const toggleDropdown = () => {
  isOpen.value = !isOpen.value;
};

const handleItemClick = (item: DropdownItem) => {
  if (item.disabled) return;
  emit('select', item);
  isOpen.value = false;
};

const closeOnOutsideClick = (e: MouseEvent) => {
  if (wrapperRef.value && !wrapperRef.value.contains(e.target as Node)) {
    isOpen.value = false;
  }
};

onMounted(() => {
  document.addEventListener('click', closeOnOutsideClick);
});

onUnmounted(() => {
  document.removeEventListener('click', closeOnOutsideClick);
});
</script>

<style scoped>
.pp-dropdown-wrapper {
  position: relative;
  display: inline-block;
}

.dropdown-trigger {
  cursor: pointer;
}

.pp-dropdown-menu {
  position: absolute;
  z-index: 1000;
  background-color: #ffffff;
  border: 1px solid #e2e8f0;
  border-radius: 8px;
  box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
  min-width: 160px;
  padding: 8px 0;
}

/* Placements */
.placement-bottom-right {
  top: calc(100% + 8px);
  right: 0;
}
.placement-bottom-left {
  top: calc(100% + 8px);
  left: 0;
}
.placement-top-right {
  bottom: calc(100% + 8px);
  right: 0;
}
.placement-top-left {
  bottom: calc(100% + 8px);
  left: 0;
}

.dropdown-list {
  list-style: none;
  margin: 0;
  padding: 0;
}

.dropdown-item {
  display: flex;
  align-items: center;
  padding: 8px 16px;
  cursor: pointer;
  color: #475569;
  font-size: 14px;
  transition: background-color 0.2s;
}

.dropdown-item:hover:not(.is-disabled) {
  background-color: #f1f5f9;
}

.dropdown-item.is-disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.dropdown-item.is-danger {
  color: #ef4444;
}

.dropdown-item.is-danger:hover:not(.is-disabled) {
  background-color: #fef2f2;
}

.item-icon {
  margin-right: 12px;
  font-size: 1.2em;
}

/* Transitions */
.dropdown-fade-enter-active,
.dropdown-fade-leave-active {
  transition: opacity 0.2s, transform 0.2s;
}
.dropdown-fade-enter-from,
.dropdown-fade-leave-to {
  opacity: 0;
  transform: translateY(-4px);
}
</style>
