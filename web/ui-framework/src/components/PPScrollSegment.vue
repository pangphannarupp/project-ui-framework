<template>
  <div class="pp-scroll-segment-wrapper" ref="wrapperRef">
    <div 
      class="scroll-btn prev-btn" 
      v-if="canScrollLeft"
      @click="scrollLeft"
    >
      <svg viewBox="0 0 24 24" width="20" height="20" stroke="currentColor" stroke-width="2" fill="none"><path d="M15 18l-6-6 6-6"/></svg>
    </div>
    
    <div 
      class="pp-scroll-segment"
      ref="scrollAreaRef"
      @scroll="checkScroll"
    >
      <slot></slot>
    </div>

    <div 
      class="scroll-btn next-btn" 
      v-if="canScrollRight"
      @click="scrollRight"
    >
      <svg viewBox="0 0 24 24" width="20" height="20" stroke="currentColor" stroke-width="2" fill="none"><path d="M9 18l6-6-6-6"/></svg>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, nextTick } from 'vue';

const scrollAreaRef = ref<HTMLElement | null>(null);
const wrapperRef = ref<HTMLElement | null>(null);

const canScrollLeft = ref(false);
const canScrollRight = ref(false);

const checkScroll = () => {
  if (!scrollAreaRef.value) return;
  const { scrollLeft, scrollWidth, clientWidth } = scrollAreaRef.value;
  canScrollLeft.value = scrollLeft > 0;
  canScrollRight.value = Math.ceil(scrollLeft + clientWidth) < scrollWidth;
};

const scrollLeft = () => {
  if (!scrollAreaRef.value) return;
  scrollAreaRef.value.scrollBy({ left: -150, behavior: 'smooth' });
};

const scrollRight = () => {
  if (!scrollAreaRef.value) return;
  scrollAreaRef.value.scrollBy({ left: 150, behavior: 'smooth' });
};

onMounted(() => {
  nextTick(() => {
    checkScroll();
    if (scrollAreaRef.value && window.ResizeObserver) {
      new ResizeObserver(checkScroll).observe(scrollAreaRef.value);
    }
  });
});
</script>

<style scoped>
.pp-scroll-segment-wrapper {
  position: relative;
  display: flex;
  align-items: center;
  width: 100%;
}

.pp-scroll-segment {
  display: flex;
  align-items: center;
  overflow-x: auto;
  background-color: var(--pp-scroll-segment-bg, transparent);
  border-radius: var(--pp-scroll-segment-border-radius, 0);
  gap: var(--pp-scroll-segment-gap, 12px);
  padding: var(--pp-scroll-segment-padding, 8px 4px 12px 4px);
  scrollbar-width: none;
  -ms-overflow-style: none;
  margin-bottom: var(--pp-scroll-segment-margin-bottom, 16px);
  flex: 1;
}

.pp-scroll-segment::-webkit-scrollbar {
  display: none;
}

.scroll-btn {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
  width: 32px;
  height: 32px;
  border-radius: 50%;
  background-color: white;
  box-shadow: 0 2px 8px rgba(0,0,0,0.15);
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  z-index: 2;
  color: #666;
  margin-top: -10px;
}

.prev-btn {
  left: 0;
}

.next-btn {
  right: 0;
}
</style>
