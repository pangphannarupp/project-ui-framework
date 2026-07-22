<template>
  <div class="pp-navigation-rail">
    <div class="rail-header">
      <div class="rail-menu-toggle" v-if="showMenu" @click="emit('menu-click')">
        <ion-icon :icon="menuOutline" class="rail-item-icon"></ion-icon>
      </div>
      <slot name="header"></slot>
    </div>
    
    <div class="rail-content">
      <slot>
        <div 
          v-for="(item, index) in items" 
          :key="index"
          class="rail-item"
          :class="{ 'is-active': item.active }"
          @click="handleItemClick(item)"
        >
          <div class="rail-item-icon-container" v-if="item.icon || $slots.icon || item.badge">
            <div class="rail-item-icon" v-if="item.icon || $slots.icon">
              <slot name="icon" :item="item">
                <ion-icon :icon="item.icon"></ion-icon>
              </slot>
            </div>
            <div class="rail-item-badge" v-if="item.badge">{{ item.badge }}</div>
          </div>
          <div class="rail-item-label">{{ item.label }}</div>
        </div>
      </slot>
    </div>

    <div class="rail-footer" v-if="$slots.footer">
      <slot name="footer"></slot>
    </div>
  </div>
</template>

<script setup lang="ts">
import { IonIcon } from '@ionic/vue';
import { menuOutline } from 'ionicons/icons';

export interface RailItem {
  label: string;
  icon?: any;
  active?: boolean;
  badge?: string | number;
  value?: any;
}

defineProps({
  items: {
    type: Array as () => RailItem[],
    default: () => []
  },
  showMenu: {
    type: Boolean,
    default: false
  }
});

const emit = defineEmits(['item-click', 'menu-click']);

const handleItemClick = (item: RailItem) => {
  emit('item-click', item);
};
</script>

<style scoped>
.pp-navigation-rail {
  display: flex;
  flex-direction: column;
  width: 80px;
  height: 100%;
  min-height: 100%; /* For full height layouts */
  background-color: var(--pp-rail-bg, #f3f4f9); /* M3 Surface container */
  border-right: 1px solid var(--pp-border-color, #e0e2ec);
  padding: 16px 0;
  box-sizing: border-box;
  align-items: center;
  z-index: 100;
}

.rail-header {
  margin-bottom: 24px;
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 100%;
}

.rail-menu-toggle {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 48px;
  height: 48px;
  border-radius: 50%;
  cursor: pointer;
  margin-bottom: 8px;
  color: var(--pp-rail-item-color, #44474f);
  transition: background-color 0.2s;
}

.rail-menu-toggle:hover {
  background-color: rgba(26, 27, 33, 0.08);
}

.rail-content {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 12px;
  width: 100%;
  overflow-y: auto;
  /* Hide scrollbar */
  scrollbar-width: none;
}
.rail-content::-webkit-scrollbar {
  display: none;
}

.rail-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  width: 100%;
  min-height: 56px;
  cursor: pointer;
  color: var(--pp-rail-item-color, #44474f); /* M3 On-surface variant */
  text-decoration: none;
  outline: none;
}

.rail-item-icon-container {
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
  width: 56px;
  height: 32px;
  border-radius: 16px; /* Pill shape */
  transition: background-color 0.2s, color 0.2s;
  margin-bottom: 4px;
}

.rail-item:hover .rail-item-icon-container {
  background-color: rgba(26, 27, 33, 0.08); /* Hover state */
}

.rail-item.is-active .rail-item-icon-container {
  background-color: var(--pp-rail-active-bg, #d8e2ff); /* Secondary container */
  color: var(--pp-rail-active-color, #001a41); /* On-secondary container */
}

.rail-item-icon {
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 24px;
}

.rail-item.is-active {
  color: var(--pp-rail-active-label, #1a1b21); /* On-surface */
}

.rail-item-label {
  font-size: 12px;
  font-weight: 500;
  line-height: 16px;
  text-align: center;
  padding: 0 4px;
  word-break: break-word;
}

.rail-item-badge {
  position: absolute;
  top: -4px;
  right: 4px;
  background-color: var(--pp-rail-badge-bg, #b3261e);
  color: var(--pp-rail-badge-color, #ffffff);
  font-size: 11px;
  font-weight: 500;
  padding: 0 4px;
  border-radius: 8px;
  min-width: 16px;
  text-align: center;
  border: 2px solid var(--pp-rail-bg, #f3f4f9); /* Outline to match rail bg */
}

.rail-footer {
  margin-top: 16px;
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 100%;
}

:deep(.rail-item-icon svg),
:deep(.rail-item-icon ion-icon) {
  width: 24px;
  height: 24px;
  color: inherit;
}
</style>
