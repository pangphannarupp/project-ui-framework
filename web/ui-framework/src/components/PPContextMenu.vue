<template>
  <div class="pp-context-menu-wrapper" ref="wrapperRef">
    <div class="trigger" @click.stop="toggleMenu" @contextmenu.prevent="handleRightClick">
      <slot name="trigger"></slot>
    </div>

    <Teleport to="body">
      <transition name="menu-fade">
        <div
          v-if="isOpen"
          class="pp-context-menu"
          :style="menuStyle"
          ref="menuRef"
        >
          <context-menu-list :items="items" @select="handleSelect" />
        </div>
      </transition>
    </Teleport>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, onUnmounted, computed, h, defineComponent, resolveComponent } from 'vue';
import type { CSSProperties } from 'vue';
import { chevronForwardOutline } from 'ionicons/icons';

export interface ContextMenuItem {
  label?: string;
  icon?: any;
  iconSvg?: string;
  divider?: boolean;
  disabled?: boolean;
  children?: ContextMenuItem[];
  action?: () => void;
  value?: any;
}

const props = withDefaults(defineProps<{
  items: ContextMenuItem[];
  triggerMode?: 'click' | 'contextmenu';
  placement?: 'bottom-left' | 'bottom-right';
}>(), {
  triggerMode: 'click',
  placement: 'bottom-left'
});

const emit = defineEmits(['select']);

const isOpen = ref(false);
const wrapperRef = ref<HTMLElement | null>(null);
const menuRef = ref<HTMLElement | null>(null);

const menuX = ref(0);
const menuY = ref(0);

const menuStyle = computed<CSSProperties>(() => {
  return {
    position: 'fixed',
    top: `${menuY.value}px`,
    left: `${menuX.value}px`,
    transform: props.triggerMode === 'click' && props.placement === 'bottom-right' ? 'translateX(-100%)' : 'none',
  };
});

const toggleMenu = () => {
  if (props.triggerMode === 'click') {
    if (!isOpen.value && wrapperRef.value) {
      const rect = wrapperRef.value.getBoundingClientRect();
      menuX.value = props.placement === 'bottom-left' ? rect.left : rect.right;
      menuY.value = rect.bottom + 4;
    }
    isOpen.value = !isOpen.value;
  }
};

const handleRightClick = (e: MouseEvent) => {
  if (props.triggerMode === 'contextmenu') {
    e.preventDefault();
    isOpen.value = true;
    menuX.value = e.clientX;
    menuY.value = e.clientY;
  }
};

const closeMenu = () => {
  isOpen.value = false;
};

const handleSelect = (item: ContextMenuItem) => {
  if (item.disabled || item.divider || (item.children && item.children.length)) return;
  if (item.action) {
    item.action();
  }
  emit('select', item);
  closeMenu();
};

const closeOnOutsideClick = (e: MouseEvent) => {
  if (wrapperRef.value && !wrapperRef.value.contains(e.target as Node)) {
    closeMenu();
  }
};

onMounted(() => {
  document.addEventListener('click', closeOnOutsideClick);
});

onUnmounted(() => {
  document.removeEventListener('click', closeOnOutsideClick);
});
</script>

<script lang="ts">
// Nested component for recursive rendering
const ContextMenuList: any = defineComponent({
  name: 'ContextMenuList',
  props: {
    items: {
      type: Array as () => ContextMenuItem[],
      required: true
    }
  },
  emits: ['select'],
  setup(props, { emit }): () => any {
    const hoveredIndex = ref<number | null>(null);

    return () => {
      return h('ul', { class: 'context-menu-list' }, props.items.map((item, index) => {
        if (item.divider) {
          return h('li', { class: 'context-menu-divider' });
        }

        const hasChildren = item.children && item.children.length > 0;
        
        const renderIcon = () => {
          if (item.icon) {
            return h(resolveComponent('ion-icon'), { icon: item.icon, class: 'item-icon' });
          } else if (item.iconSvg) {
            return h('span', { class: 'item-icon icon-fallback', innerHTML: item.iconSvg });
          }
          return null;
        };

        const renderChevron = () => {
          if (hasChildren) {
            return h(resolveComponent('ion-icon'), { icon: chevronForwardOutline, class: 'item-chevron' });
          }
          return null;
        };

        const content = h('div', {
          class: ['context-menu-item', { 'is-disabled': item.disabled }],
          onMouseenter: () => {
            if (!item.disabled) hoveredIndex.value = index;
          },
          onMouseleave: () => {
            if (!item.disabled && hoveredIndex.value === index) {
               // Give a small delay before hiding to allow mouse moving to submenu
            }
          },
          onClick: (e: MouseEvent) => {
            e.stopPropagation();
            if (!item.disabled && !hasChildren) {
              emit('select', item);
            }
          }
        }, [
          h('div', { class: 'item-left' }, [
            renderIcon(),
            h('span', { class: 'item-label' }, item.label)
          ]),
          renderChevron()
        ]);

        const submenu = (hasChildren && hoveredIndex.value === index)
          ? h('div', { class: 'context-submenu' }, [
              h(ContextMenuList, { items: item.children!, onSelect: (val: any) => emit('select', val) })
            ])
          : null;

        return h('li', { class: 'context-menu-list-item', onMouseleave: () => { hoveredIndex.value = null } }, [content, submenu]);
      }));
    };
  }
});
</script>

<style scoped>
.pp-context-menu-wrapper {
  position: relative;
  display: inline-block;
}

.trigger {
  cursor: pointer;
}

.pp-context-menu {
  z-index: 1000;
  background-color: #ffffff;
  border: 1px solid #d1d5db;
  border-radius: 4px;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
  min-width: 220px;
  padding: 4px 0;
  font-family: inherit;
}

:deep(.context-menu-list) {
  list-style: none;
  margin: 0;
  padding: 0;
}

:deep(.context-menu-list-item) {
  position: relative;
}

:deep(.context-menu-divider) {
  height: 1px;
  background-color: #e5e7eb;
  margin: 4px 0;
}

:deep(.context-menu-item) {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 6px 12px;
  cursor: pointer;
  color: #374151;
  font-size: 14px;
  transition: background-color 0.15s;
}

:deep(.context-menu-item:hover:not(.is-disabled)) {
  background-color: #f3f4f6;
}

:deep(.context-menu-item.is-disabled) {
  opacity: 0.5;
  cursor: not-allowed;
}

:deep(.item-left) {
  display: flex;
  align-items: center;
  gap: 12px;
}

:deep(.item-icon) {
  font-size: 18px;
  color: #6b7280;
  width: 20px;
  display: flex;
  justify-content: center;
}

:deep(.icon-fallback) {
  display: inline-block;
  width: 1em;
  height: 1em;
  background: currentColor;
  mask-size: contain;
  mask-repeat: no-repeat;
  mask-position: center;
  -webkit-mask-size: contain;
  -webkit-mask-repeat: no-repeat;
  -webkit-mask-position: center;
}

:deep(.item-chevron) {
  font-size: 16px;
  color: #9ca3af;
}

:deep(.context-submenu) {
  position: absolute;
  top: -4px;
  left: 100%;
  background-color: #ffffff;
  border: 1px solid #d1d5db;
  border-radius: 4px;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
  min-width: 200px;
  padding: 4px 0;
  z-index: 1001;
}

/* Transitions */
.menu-fade-enter-active,
.menu-fade-leave-active {
  transition: opacity 0.15s, transform 0.15s;
}
.menu-fade-enter-from,
.menu-fade-leave-to {
  opacity: 0;
  transform: translateY(-2px);
}
</style>
