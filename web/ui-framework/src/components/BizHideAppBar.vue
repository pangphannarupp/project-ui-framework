<template>
  <div class="biz-hide-appbar-wrapper">
    <!-- Header Layer -->
    <div 
      class="biz-hide-appbar-header"
      :style="{
        transform: `translateY(${headerTranslateY}px)`,
        height: `${headerHeight}px`
      }"
      ref="headerRef"
    >
      <slot name="header"></slot>
    </div>

    <!-- Scrollable Content Layer -->
    <div 
      class="biz-hide-appbar-content"
      @scroll="onScroll"
      ref="scrollArea"
    >
      <div class="biz-hide-appbar-spacer" :style="{ height: `${headerHeight}px` }"></div>
      <slot></slot>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';

const props = withDefaults(defineProps<{
  headerHeight?: number;
}>(), {
  headerHeight: 56
});

const scrollArea = ref<HTMLElement | null>(null);
const headerTranslateY = ref(0);
let lastScrollTop = 0;

const onScroll = (e: Event) => {
  const target = e.target as HTMLElement;
  const currentScrollTop = target.scrollTop;
  const delta = currentScrollTop - lastScrollTop;
  
  // Ignore elastic bounce on iOS at the very top or very bottom
  if (currentScrollTop < 0 || currentScrollTop + target.clientHeight > target.scrollHeight) {
    return;
  }

  if (currentScrollTop <= 0) {
    // We are at the absolute top, ensure header is fully visible
    headerTranslateY.value = 0;
  } else if (delta > 0) {
    // Scrolling DOWN -> Hide Header
    // Translate negatively, but don't go beyond -headerHeight
    headerTranslateY.value = Math.max(-props.headerHeight, headerTranslateY.value - delta);
  } else if (delta < 0) {
    // Scrolling UP -> Show Header
    // Translate positively, but don't go beyond 0
    headerTranslateY.value = Math.min(0, headerTranslateY.value - delta);
  }
  
  lastScrollTop = currentScrollTop;
};
</script>

<style scoped>
.biz-hide-appbar-wrapper {
  position: relative;
  width: 100%;
  height: 100%;
  overflow: hidden;
  display: flex;
  flex-direction: column;
  background-color: #f4f5f8;
}

.biz-hide-appbar-header {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  z-index: 10;
  background-color: #ffffff;
  box-shadow: 0 2px 8px rgba(0,0,0,0.08);
  will-change: transform;
  /* Removed transition so it strictly follows finger scroll */
  /* You can add transition for snapping, but native usually follows exactly */
}

.biz-hide-appbar-content {
  flex: 1;
  overflow-y: auto;
  height: 100%;
  -webkit-overflow-scrolling: touch;
  position: relative;
  z-index: 1;
}

.biz-hide-appbar-spacer {
  width: 100%;
  flex-shrink: 0;
}
</style>
