<template>
  <Teleport to="body">
    <transition name="drawer-fade">
      <div v-if="modelValue && type === 'modal'" class="biz-drawer-backdrop" @click="closeDrawer"></div>
    </transition>
    
    <transition name="drawer-slide">
      <div v-if="modelValue || type === 'standard'" class="biz-navigation-drawer" :class="[type, { 'is-open': modelValue }]">
        <div class="drawer-header" v-if="title || $slots.header">
          <slot name="header">
            <h2 class="drawer-title">{{ title }}</h2>
          </slot>
        </div>
        
        <div class="drawer-content">
          <slot>
            <div 
              v-for="(item, index) in items" 
              :key="index"
              class="drawer-item"
              :class="{ 'is-active': item.active }"
              @click="handleItemClick(item)"
            >
              <div class="drawer-item-icon" v-if="item.icon || $slots.icon">
                <slot name="icon" :item="item">
                  <i :class="item.icon"></i>
                </slot>
              </div>
              <div class="drawer-item-label">{{ item.label }}</div>
              <div class="drawer-item-badge" v-if="item.badge">{{ item.badge }}</div>
            </div>
          </slot>
        </div>
        
        <div class="drawer-footer" v-if="$slots.footer">
          <slot name="footer"></slot>
        </div>
      </div>
    </transition>
  </Teleport>
</template>

<script setup lang="ts">
export interface DrawerItem {
  label: string;
  icon?: string;
  active?: boolean;
  badge?: string | number;
  value?: any;
}

const props = defineProps({
  modelValue: {
    type: Boolean,
    default: false
  },
  title: {
    type: String,
    default: ''
  },
  items: {
    type: Array as () => DrawerItem[],
    default: () => []
  },
  type: {
    type: String,
    default: 'modal', // 'modal' or 'standard'
    validator: (value: string) => ['modal', 'standard'].includes(value)
  }
});

const emit = defineEmits(['update:modelValue', 'item-click']);

const closeDrawer = () => {
  emit('update:modelValue', false);
};

const handleItemClick = (item: DrawerItem) => {
  emit('item-click', item);
  if (props.type === 'modal') {
    closeDrawer();
  }
};
</script>

<style scoped>
.biz-drawer-backdrop {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: rgba(0, 0, 0, 0.32); /* M3 Scrim */
  z-index: 100;
}

.biz-navigation-drawer {
  position: fixed;
  top: 0;
  left: 0;
  bottom: 0;
  width: 360px;
  max-width: 85vw;
  background-color: var(--biz-drawer-bg, #f3f4f9); /* M3 Surface container low */
  z-index: 101;
  display: flex;
  flex-direction: column;
  border-top-right-radius: 16px;
  border-bottom-right-radius: 16px;
  overflow: hidden;
  box-shadow: 0px 8px 24px rgba(0, 0, 0, 0.15); /* M3 Elevation 1 */
}

.biz-navigation-drawer.standard {
  position: relative;
  border-radius: 0;
  box-shadow: none;
  border-right: 1px solid var(--biz-border-color, #e0e2ec);
  transform: none; /* Reset transform for standard */
  display: none;
}

.biz-navigation-drawer.standard.is-open {
  display: flex;
}

.drawer-header {
  padding: 24px 16px 16px;
  min-height: 64px;
}

.drawer-title {
  margin: 0;
  font-size: 14px;
  font-weight: 500;
  color: var(--biz-drawer-title-color, #44474f); /* M3 On-surface variant */
  text-transform: capitalize;
}

.drawer-content {
  flex: 1;
  overflow-y: auto;
  padding: 0 12px;
}

.drawer-item {
  display: flex;
  align-items: center;
  padding: 0 16px;
  height: 56px;
  border-radius: 28px; /* M3 fully rounded */
  margin-bottom: 4px;
  cursor: pointer;
  transition: background-color 0.2s, color 0.2s;
  color: var(--biz-drawer-item-color, #1a1b21); /* M3 On-surface */
}

.drawer-item:hover {
  background-color: rgba(26, 27, 33, 0.08); /* M3 On-surface hovered */
}

.drawer-item.is-active {
  background-color: var(--biz-drawer-active-bg, #d8e2ff); /* M3 Secondary container */
  color: var(--biz-drawer-active-color, #001a41); /* M3 On-secondary container */
}

.drawer-item.is-active .drawer-item-icon {
  color: inherit;
}

.drawer-item-icon {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 24px;
  height: 24px;
  margin-right: 12px;
  color: var(--biz-drawer-icon-color, #44474f); /* M3 On-surface variant */
}

.drawer-item-label {
  flex: 1;
  font-size: 14px;
  font-weight: 500;
  line-height: 20px;
}

.drawer-item-badge {
  background-color: var(--biz-drawer-badge-bg, #b3261e);
  color: var(--biz-drawer-badge-color, #ffffff);
  font-size: 11px;
  font-weight: 500;
  padding: 0 6px;
  border-radius: 8px;
  min-width: 16px;
  text-align: center;
}

.drawer-footer {
  padding: 16px;
  border-top: 1px solid rgba(0, 0, 0, 0.1);
}

/* Transitions */
.drawer-fade-enter-active,
.drawer-fade-leave-active {
  transition: opacity 0.3s ease;
}

.drawer-fade-enter-from,
.drawer-fade-leave-to {
  opacity: 0;
}

.drawer-slide-enter-active,
.drawer-slide-leave-active {
  transition: transform 0.3s cubic-bezier(0.2, 0, 0, 1);
}

.drawer-slide-enter-from,
.drawer-slide-leave-to {
  transform: translateX(-100%);
}
</style>
