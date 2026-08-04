<template>
  <div class="pp-material-app" :class="[theme, { 'has-drawer': $slots.drawer, 'has-bottom-nav': shouldShowBottomNav }]">
    <!-- Drawer (Sidebar) -->
    <aside 
      v-if="$slots.drawer" 
      class="pp-material-drawer" 
      :class="{ 
        'is-overlay': isOverlay, 
        'is-mini': isMini,
        'is-open': props.drawerOpen 
      }"
    >
      <slot name="drawer"></slot>
    </aside>
    
    <!-- Backdrop for overlay drawer -->
    <div class="pp-material-backdrop" :class="{ 'is-visible': props.drawerOpen && $slots.drawer && isOverlay }" @click="$emit('close-drawer')"></div>

    <div class="pp-material-main-container" :style="{ '--header-height': headerHeight + 'px', '--bottom-nav-height': bottomNavHeight + 'px' }">
      <!-- App Bar (Header) -->
      <header v-if="$slots.header" ref="headerRef" class="pp-material-header" :class="{ 'is-hidden': isAppBarHidden }">
        <slot name="header"></slot>
      </header>

      <!-- Main Content Area -->
      <main class="pp-material-content" :class="{ 'with-header': $slots.header, 'with-bottom-nav': shouldShowBottomNav }">
        <div class="pp-material-scroll-area" ref="scrollArea">
          <div v-if="$slots.header" class="pp-material-header-spacer" :style="{ height: headerHeight + 'px', flexShrink: 0 }"></div>
          
          <slot></slot>

          <div v-if="shouldShowBottomNav" class="pp-material-bottom-spacer" :style="{ height: bottomNavHeight + 'px', flexShrink: 0 }"></div>
        </div>
        
        <!-- FAB Overlay -->
        <div v-if="$slots.fab" class="pp-material-fab-container" :class="[`fab-${actualFabPosition}`, { 'is-hidden': isBottomNavHidden, 'has-bottom-nav': shouldShowBottomNav }]">
          <slot name="fab"></slot>
        </div>

        <!-- Snackbar Container -->
        <div v-if="$slots.snackbar" class="pp-material-snackbar-container" :class="{ 'has-bottom-nav': shouldShowBottomNav, 'has-fab': $slots.fab && actualFabPosition !== 'center-docked', 'is-hidden': isBottomNavHidden }">
          <slot name="snackbar"></slot>
        </div>
      </main>

      <!-- Bottom Navigation -->
      <footer v-if="shouldShowBottomNav" ref="bottomNavRef" class="pp-material-bottom-nav" :class="{ 'is-hidden': isBottomNavHidden }">
        <slot name="bottom-nav"></slot>
      </footer>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted, onBeforeUnmount, useSlots, watch } from 'vue';

const props = withDefaults(defineProps<{
  theme?: 'light' | 'dark';
  drawerOverlay?: boolean;
  drawerOpen?: boolean;
  responsive?: boolean;
  drawerVariant?: 'default' | 'overlay' | 'mini';
  hideAppBarOnScroll?: boolean;
  hideBottomNavOnScroll?: boolean;
  fabPosition?: 'bottom-right' | 'center-docked' | 'center-float';
}>(), {
  theme: 'light',
  drawerOverlay: true,
  drawerOpen: false,
  responsive: false,
  drawerVariant: 'default',
  hideAppBarOnScroll: false,
  hideBottomNavOnScroll: false,
  fabPosition: 'bottom-right'
});

const emit = defineEmits(['close-drawer']);
const slots = useSlots();

const scrollArea = ref<HTMLElement | null>(null);
const headerRef = ref<HTMLElement | null>(null);
const bottomNavRef = ref<HTMLElement | null>(null);

const isAppBarHidden = ref(false);
const isBottomNavHidden = ref(false);
const isMobile = ref(false);
const headerHeight = ref(0);
const bottomNavHeight = ref(0);
let lastScrollTop = 0;
let resizeObserver: ResizeObserver | null = null;

const handleScroll = (e: Event) => {
  if (!props.hideAppBarOnScroll && !props.hideBottomNavOnScroll) return;
  const target = e.target as HTMLElement;
  const st = target.scrollTop;
  
  if (st > lastScrollTop && st > 60) {
    if (props.hideAppBarOnScroll) isAppBarHidden.value = true;
    if (props.hideBottomNavOnScroll) isBottomNavHidden.value = true;
  } else {
    if (props.hideAppBarOnScroll) isAppBarHidden.value = false;
    if (props.hideBottomNavOnScroll) isBottomNavHidden.value = false;
  }
  lastScrollTop = st;
};

const handleResize = () => {
  if (!props.responsive) return;
  isMobile.value = window.innerWidth < 768;
};

onMounted(() => {
  if (props.responsive) {
    handleResize();
    window.addEventListener('resize', handleResize);
  }
  if (scrollArea.value) {
    scrollArea.value.addEventListener('scroll', handleScroll, { passive: true });
  }

  resizeObserver = new ResizeObserver((entries) => {
    for (const entry of entries) {
      if (entry.target === headerRef.value) {
        headerHeight.value = entry.borderBoxSize?.[0]?.blockSize ?? entry.contentRect.height;
      }
      if (entry.target === bottomNavRef.value) {
        bottomNavHeight.value = entry.borderBoxSize?.[0]?.blockSize ?? entry.contentRect.height;
      }
    }
  });

  if (headerRef.value) resizeObserver.observe(headerRef.value);
  if (bottomNavRef.value) resizeObserver.observe(bottomNavRef.value);
});

onBeforeUnmount(() => {
  if (props.responsive) {
    window.removeEventListener('resize', handleResize);
  }
  if (scrollArea.value) {
    scrollArea.value.removeEventListener('scroll', handleScroll);
  }
  if (resizeObserver) {
    resizeObserver.disconnect();
  }
});

watch(() => props.hideAppBarOnScroll, (newVal) => {
  if (!newVal) isAppBarHidden.value = false;
});

watch(() => props.hideBottomNavOnScroll, (newVal) => {
  if (!newVal) isBottomNavHidden.value = false;
});

const actualDrawerVariant = computed(() => {
  if (props.responsive && isMobile.value) return 'overlay';
  if (props.drawerVariant !== 'default') return props.drawerVariant;
  return props.drawerOverlay ? 'overlay' : 'default';
});

const isOverlay = computed(() => actualDrawerVariant.value === 'overlay');
const isMini = computed(() => actualDrawerVariant.value === 'mini');

const shouldShowBottomNav = computed(() => {
  return !!slots['bottom-nav'];
});

const actualFabPosition = computed(() => {
  if (props.fabPosition === 'center-docked' && !shouldShowBottomNav.value) {
    return 'bottom-right';
  }
  return props.fabPosition;
});
</script>

<style scoped>
.pp-material-app {
  display: flex;
  height: 100%;
  width: 100%;
  overflow: hidden;
  position: relative;
  font-family: inherit;
}

.pp-material-app.light {
  background-color: #f8fafc;
  color: #0f172a;
}

.pp-material-app.dark {
  background-color: #0f172a;
  color: #f8fafc;
}

/* Drawer / Sidebar */
.pp-material-drawer {
  flex-shrink: 0;
  height: 100%;
  z-index: 40;
  transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1), margin-left 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  background-color: var(--pp-surface, #ffffff);
}

.pp-material-drawer.is-overlay {
  position: absolute;
  top: 0;
  left: 0;
  bottom: 0;
  transform: translateX(-100%);
  box-shadow: 0 0 0 rgba(0,0,0,0);
  transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1), box-shadow 0.3s ease;
}

.pp-material-drawer.is-overlay.is-open {
  transform: translateX(0);
  box-shadow: 4px 0 16px rgba(0,0,0,0.1);
}

/* Backdrop */
.pp-material-backdrop {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: rgba(0, 0, 0, 0.4);
  z-index: 35;
  opacity: 0;
  visibility: hidden;
  transition: opacity 0.3s ease, visibility 0.3s ease;
}

.pp-material-backdrop.is-visible {
  opacity: 1;
  visibility: visible;
}

/* Main Container (Everything right of drawer) */
.pp-material-main-container {
  flex: 1;
  display: flex;
  flex-direction: column;
  min-width: 0;
  height: 100%;
  position: relative;
}

/* Header */
.pp-material-header {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  z-index: 20;
  transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.pp-material-header.is-hidden {
  transform: translateY(-100%);
}

/* Main Content Area */
.pp-material-content {
  flex: 1;
  position: relative;
  display: flex;
  flex-direction: column;
  min-height: 0;
}

/* Scrollable Inner Area */
.pp-material-scroll-area {
  flex: 1;
  overflow-y: auto;
  overflow-x: hidden;
  height: 100%;
}

/* Custom Scrollbar */
.pp-material-scroll-area::-webkit-scrollbar {
  width: 6px;
}
.pp-material-scroll-area::-webkit-scrollbar-track {
  background: transparent;
}
.pp-material-scroll-area::-webkit-scrollbar-thumb {
  background: rgba(150, 150, 150, 0.3);
  border-radius: 10px;
}
.pp-material-app.dark .pp-material-scroll-area::-webkit-scrollbar-thumb {
  background: rgba(255, 255, 255, 0.2);
}

/* Bottom Navigation */
.pp-material-bottom-nav {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  z-index: 15;
  transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}
.pp-material-bottom-nav.is-hidden {
  transform: translateY(100%);
}

/* FAB Container */
.pp-material-fab-container {
  position: absolute;
  z-index: 25;
  pointer-events: none;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  display: flex;
  align-items: center;
  justify-content: center;
}
/* Reset inner PPFab absolute positioning so it perfectly centers */
.pp-material-fab-container :deep(.pp-fab) {
  position: relative !important;
  right: auto !important;
  left: auto !important;
  bottom: auto !important;
  top: auto !important;
  transform: none !important;
}
.pp-material-fab-container.fab-bottom-right {
  right: 24px;
  bottom: 24px;
}
.pp-material-fab-container.fab-bottom-right.has-bottom-nav {
  bottom: calc(24px + var(--bottom-nav-height, 0px));
}
.pp-material-fab-container.fab-center-docked {
  left: 50%;
  bottom: 12px;
  transform: translateX(-50%);
}
.pp-material-fab-container.fab-center-float {
  left: 50%;
  bottom: 24px;
  transform: translateX(-50%);
}
.pp-material-fab-container.fab-center-float.has-bottom-nav {
  bottom: calc(24px + var(--bottom-nav-height, 0px));
}
.pp-material-fab-container.is-hidden {
  transform: translateY(200px) translateX(-50%);
}
.pp-material-fab-container.fab-bottom-right.is-hidden {
  transform: translateY(200px);
}
.pp-material-fab-container > * {
  pointer-events: auto;
}

/* Snackbar Container */
.pp-material-snackbar-container {
  position: absolute;
  left: 50%;
  bottom: 24px;
  transform: translateX(-50%);
  z-index: 50;
  pointer-events: none;
  transition: bottom 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}
.pp-material-snackbar-container.has-fab {
  bottom: 96px;
}
.pp-material-snackbar-container.has-bottom-nav {
  bottom: 96px; /* give space for bottom nav */
}
.pp-material-snackbar-container.has-bottom-nav.has-fab {
  bottom: 96px; /* if docked, it's roughly the same height */
}
.pp-material-snackbar-container.is-hidden {
  transform: translateY(150px) translateX(-50%);
}
.pp-material-snackbar-container > * {
  pointer-events: auto;
}
</style>
