<template>
  <div 
    class="pp-sidebar"
    :class="[
      `theme-${theme}`, 
      `variant-${variant}`, 
      { collapsed }
    ]"
    :style="{ 
      width: collapsed ? collapsedWidth : width 
    }"
  >
    <div v-if="$slots.header" class="sidebar-header">
      <slot name="header"></slot>
    </div>
    
    <div class="sidebar-scroll">
      <template v-for="(group, _index) in items" :key="group.groupLabel || _index">
        <div class="nav-section">
          <div v-if="group.groupLabel && !collapsed" class="nav-section-title">
            {{ group.groupLabel }}
          </div>
          
          <nav class="sidebar-nav">
            <template v-for="item in group.items" :key="item.id">
              <div class="nav-item-wrapper">
                <a 
                  href="#" 
                  class="nav-item"
                  :class="{ 
                    active: isItemActive(item), 
                    disabled: item.disabled,
                    'is-parent': item.children && item.children.length
                  }"
                  @click.prevent="handleItemClick(item)"
                >
                  <div class="nav-item-content">
                    <ion-icon v-if="item.icon" :icon="item.icon" class="nav-icon" />
                    <span v-if="!collapsed" class="nav-label">{{ item.label }}</span>
                  </div>
                  
                  <ion-icon 
                    v-if="item.children && item.children.length && !collapsed" 
                    :icon="internalExpanded.includes(item.id) ? chevronDownOutline : chevronForwardOutline" 
                    class="nav-chevron"
                  />
                </a>

                <div 
                  v-show="item.children && item.children.length && !collapsed && internalExpanded.includes(item.id)" 
                  class="nav-subitems"
                >
                  <a 
                    v-for="sub in item.children" 
                    :key="sub.id"
                    href="#"
                    class="nav-item sub-item"
                    :class="{ active: modelValue === sub.id, disabled: sub.disabled }"
                    @click.prevent="handleSubItemClick(sub)"
                  >
                    <span class="nav-label">{{ sub.label }}</span>
                  </a>
                </div>
              </div>
            </template>
          </nav>
        </div>
      </template>
    </div>

    <div v-if="$slots.footer" class="sidebar-footer">
      <slot name="footer"></slot>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, watch } from 'vue';
import { IonIcon } from '@ionic/vue';
import { chevronDownOutline, chevronForwardOutline } from 'ionicons/icons';

type SidebarItem = {
  id: string;
  label: string;
  icon?: any;
  children?: Omit<SidebarItem, 'icon' | 'children'>[];
  disabled?: boolean;
};

type SidebarGroup = {
  groupLabel?: string;
  items: SidebarItem[];
};

const props = withDefaults(defineProps<{
  modelValue?: string;
  expandedItems?: string[];
  items: SidebarGroup[];
  theme?: 'light' | 'dark';
  variant?: 'pill' | 'indicator' | 'flat' | 'm3-rail';
  collapsed?: boolean;
  width?: string;
  collapsedWidth?: string;
  showToggle?: boolean;
}>(), {
  modelValue: '',
  theme: 'dark',
  variant: 'indicator',
  collapsed: false,
  width: '260px',
  collapsedWidth: '80px',
  showToggle: false
});

const emit = defineEmits<{
  (e: 'update:modelValue', id: string): void;
  (e: 'update:collapsed', val: boolean): void;
  (e: 'update:expandedItems', val: string[]): void;
}>();

const internalExpanded = ref<string[]>(props.expandedItems || []);

watch(() => props.expandedItems, (newVal) => {
  if (newVal) {
    internalExpanded.value = [...newVal];
  }
}, { deep: true });

watch(() => props.modelValue, (newVal) => {
  for (const group of props.items) {
    for (const item of group.items) {
      if (item.children?.some(child => child.id === newVal)) {
        if (!internalExpanded.value.includes(item.id)) {
          internalExpanded.value.push(item.id);
          emit('update:expandedItems', internalExpanded.value);
        }
      }
    }
  }
}, { immediate: true });

function isItemActive(item: SidebarItem) {
  if (props.modelValue === item.id) return true;
  if (item.children?.some(child => child.id === props.modelValue)) return true;
  return false;
}

function handleItemClick(item: SidebarItem) {
  if (item.disabled) return;
  
  if (item.children && item.children.length) {
    if (internalExpanded.value.includes(item.id)) {
      internalExpanded.value = internalExpanded.value.filter(id => id !== item.id);
    } else {
      internalExpanded.value.push(item.id);
    }
    emit('update:expandedItems', internalExpanded.value);
  } else {
    emit('update:modelValue', item.id);
  }
}

function handleSubItemClick(sub: Omit<SidebarItem, 'icon' | 'children'>) {
  if (sub.disabled) return;
  emit('update:modelValue', sub.id);
}
</script>

<style scoped>
.pp-sidebar {
  display: flex;
  flex-direction: column;
  height: 100%;
  transition: width 0.3s ease;
  overflow: hidden;
  flex-shrink: 0;
  box-sizing: border-box;
}

.sidebar-header {
  flex-shrink: 0;
  padding: 24px;
}

.sidebar-footer {
  flex-shrink: 0;
  padding: 16px;
  border-top: 1px solid var(--sidebar-border-color);
}

.sidebar-scroll {
  flex: 1;
  overflow-y: auto;
  overflow-x: hidden;
  padding: 16px 0;
  display: flex;
  flex-direction: column;
  gap: 24px;
}
.sidebar-scroll::-webkit-scrollbar {
  width: 4px;
}
.sidebar-scroll::-webkit-scrollbar-track {
  background: transparent;
}
.sidebar-scroll::-webkit-scrollbar-thumb {
  background: var(--sidebar-scroll-thumb);
  border-radius: 4px;
}

.nav-section {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.nav-section-title {
  padding: 0 24px;
  font-size: 11px;
  font-weight: 700;
  letter-spacing: 0.5px;
  text-transform: uppercase;
  color: var(--sidebar-title-color);
}

.sidebar-nav {
  display: flex;
  flex-direction: column;
}

.nav-item-wrapper {
  display: flex;
  flex-direction: column;
}

.nav-item {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 12px 24px;
  text-decoration: none;
  font-size: 14px;
  font-weight: 500;
  color: var(--sidebar-text-color);
  transition: all 0.2s ease;
  position: relative;
  cursor: pointer;
}

.nav-item.disabled {
  opacity: 0.5;
  cursor: not-allowed;
  pointer-events: none;
}

.nav-item-content {
  display: flex;
  align-items: center;
  gap: 12px;
}

.nav-icon {
  font-size: 20px;
  transition: color 0.2s;
}

.nav-chevron {
  font-size: 16px;
  opacity: 0.5;
  transition: transform 0.2s;
}

.nav-subitems {
  display: flex;
  flex-direction: column;
  margin-top: 4px;
  margin-bottom: 8px;
}

.sub-item {
  padding-left: 56px;
  padding-top: 8px;
  padding-bottom: 8px;
  font-size: 13px;
}

/* === Collapsed State === */
.collapsed .nav-item {
  padding: 12px 0;
  justify-content: center;
}
.collapsed .nav-item-content {
  justify-content: center;
  width: 100%;
}
.collapsed .nav-icon {
  font-size: 24px;
}
.collapsed .nav-section-title,
.collapsed .nav-chevron,
.collapsed .nav-subitems,
.collapsed .nav-label {
  display: none;
}
.collapsed .sidebar-header,
.collapsed .sidebar-footer {
  padding: 16px;
  display: flex;
  justify-content: center;
}

/* =========================================
   THEMES
========================================= */

/* DARK THEME */
.theme-dark {
  background: #1c2434;
  --sidebar-text-color: #8a99af;
  --sidebar-text-active: #ffffff;
  --sidebar-title-color: #0dcaf0;
  --sidebar-bg-hover: rgba(255, 255, 255, 0.05);
  --sidebar-bg-active: rgba(13, 202, 240, 0.1);
  --sidebar-accent: #0dcaf0;
  --sidebar-border-color: rgba(255,255,255,0.05);
  --sidebar-scroll-thumb: rgba(255,255,255,0.1);
}

/* LIGHT THEME */
.theme-light {
  background: #ffffff;
  border-right: 1px solid #e2e8f0;
  --sidebar-text-color: #64748b;
  --sidebar-text-active: #0f172a;
  --sidebar-title-color: #94a3b8;
  --sidebar-bg-hover: #f1f5f9;
  --sidebar-bg-active: #eff6ff;
  --sidebar-accent: #3b82f6;
  --sidebar-border-color: #e2e8f0;
  --sidebar-scroll-thumb: rgba(0,0,0,0.1);
}

/* =========================================
   VARIANTS (Hover & Active Styles)
========================================= */

/* Default hover for all variants */
.nav-item:hover {
  color: var(--sidebar-text-active);
  background: var(--sidebar-bg-hover);
}
.nav-item:hover .nav-icon {
  color: var(--sidebar-accent);
}

/* Variant: Indicator (Vertical bar on left) */
.variant-indicator .nav-item.active {
  color: var(--sidebar-text-active);
  background: var(--sidebar-bg-hover);
}
.variant-indicator .nav-item.active .nav-icon {
  color: var(--sidebar-accent);
}
.variant-indicator .nav-item.active::before {
  content: '';
  position: absolute;
  left: 0;
  top: 0;
  bottom: 0;
  width: 3px;
  background: var(--sidebar-accent);
}

/* Variant: Flat (Full subtle background) */
.variant-flat .nav-item.active {
  color: var(--sidebar-accent);
  background: var(--sidebar-bg-active);
  border-right: 3px solid var(--sidebar-accent);
}
.variant-flat .nav-item.active .nav-icon {
  color: var(--sidebar-accent);
}

/* Variant: Pill (Rounded internal background) */
.variant-pill .nav-item {
  margin: 0 12px;
  border-radius: 8px;
  padding: 10px 12px;
}
.variant-pill .sub-item {
  padding-left: 44px;
}
.variant-pill .nav-item.active {
  color: #fff;
  background: var(--sidebar-accent);
}
.variant-pill .nav-item.active .nav-icon {
  color: #fff;
}
.variant-pill.theme-light .nav-item.active {
  color: #fff;
}
.variant-pill.theme-light .nav-item.active .nav-icon {
  color: #fff;
}
.variant-pill.collapsed .nav-item {
  margin: 0 8px;
}

/* Variant: M3 Rail (Material 3 Rail Navigation) */
.variant-m3-rail {
  background: #fdfcff;
  border-right: none;
  --sidebar-text-color: #49454f;
  --sidebar-text-active: #1d192b;
  --sidebar-bg-hover: rgba(29, 25, 43, 0.08);
  --sidebar-bg-active: #e8def8; /* M3 Secondary Container */
  --sidebar-accent: #1d192b; /* M3 On Secondary Container */
}
.variant-m3-rail .nav-item {
  flex-direction: column;
  padding: 12px 4px;
  margin: 4px 12px;
  border-radius: 16px;
  justify-content: center;
}
.variant-m3-rail .nav-item-content {
  flex-direction: column;
  gap: 4px;
  width: 100%;
  justify-content: center;
}
.variant-m3-rail .nav-icon {
  font-size: 24px;
  padding: 4px 16px;
  border-radius: 16px;
  transition: all 0.2s ease;
}
.variant-m3-rail .nav-label {
  font-size: 12px;
  font-weight: 600;
  display: block !important; /* Force show label even if 'collapsed' */
}
.variant-m3-rail .nav-item.active {
  background: transparent;
  color: var(--sidebar-text-active);
}
.variant-m3-rail .nav-item.active .nav-icon {
  background: var(--sidebar-bg-active);
  color: var(--sidebar-accent);
}
.variant-m3-rail .nav-chevron, 
.variant-m3-rail .nav-section-title {
  display: none;
}
.variant-m3-rail.theme-dark {
  background: #141218;
  --sidebar-text-color: #cac4d0;
  --sidebar-text-active: #e6e0e9;
  --sidebar-bg-hover: rgba(230, 224, 233, 0.08);
  --sidebar-bg-active: #4a4458;
  --sidebar-accent: #e8def8;
}

</style>
