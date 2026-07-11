<template>
  <div 
    class="biz-swipe-wrapper"
    @touchstart="onTouchStart"
    @touchmove="onTouchMove"
    @touchend="onTouchEnd"
  >
    <div class="biz-swipe-actions left" ref="leftActionsRef">
      <slot name="left"></slot>
    </div>
    
    <div class="biz-swipe-actions right" ref="rightActionsRef">
      <slot name="right"></slot>
    </div>

    <div 
      class="biz-swipe-content" 
      :style="contentStyle"
    >
      <slot></slot>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

const leftActionsRef = ref<HTMLElement | null>(null);
const rightActionsRef = ref<HTMLElement | null>(null);

const translateX = ref(0);
const isSwiping = ref(false);
const isHorizontalScroll = ref<boolean | null>(null);

let startX = 0;
let startY = 0;
let currentX = 0;

// Expose method to close the swipe item
const close = () => {
  translateX.value = 0;
};

defineExpose({ close });

const onTouchStart = (e: TouchEvent) => {
  startX = e.touches[0].clientX;
  startY = e.touches[0].clientY;
  currentX = translateX.value;
  isSwiping.value = true;
  isHorizontalScroll.value = null;
};

const onTouchMove = (e: TouchEvent) => {
  if (!isSwiping.value) return;
  
  const dx = e.touches[0].clientX - startX;
  const dy = e.touches[0].clientY - startY;
  
  // Determine scroll direction on first movement
  if (isHorizontalScroll.value === null) {
    if (Math.abs(dx) > Math.abs(dy)) {
      isHorizontalScroll.value = true;
    } else {
      isHorizontalScroll.value = false;
    }
  }
  
  // If scrolling vertically, abort swipe handling
  if (isHorizontalScroll.value === false) return;
  
  // Prevent vertical scrolling while swiping horizontally
  if (e.cancelable) {
    e.preventDefault();
  }
  
  let newX = currentX + dx;
  
  const leftWidth = leftActionsRef.value?.clientWidth || 0;
  const rightWidth = rightActionsRef.value?.clientWidth || 0;
  
  const hasLeft = leftActionsRef.value?.children.length ? true : false;
  const hasRight = rightActionsRef.value?.children.length ? true : false;
  
  if (newX > 0 && !hasLeft) {
    newX = newX * 0.1; // extreme resistance
  } else if (newX < 0 && !hasRight) {
    newX = newX * 0.1;
  } else {
    // Normal resistance when pulled past limits
    if (newX > leftWidth) {
      newX = leftWidth + (newX - leftWidth) * 0.2;
    }
    if (newX < -rightWidth) {
      newX = -rightWidth + (newX + rightWidth) * 0.2;
    }
  }
  
  translateX.value = newX;
};

const onTouchEnd = () => {
  if (!isSwiping.value || isHorizontalScroll.value === false) {
    isSwiping.value = false;
    return;
  }
  
  isSwiping.value = false;
  
  const leftWidth = leftActionsRef.value?.clientWidth || 0;
  const rightWidth = rightActionsRef.value?.clientWidth || 0;
  
  const THRESHOLD = 40;
  
  if (translateX.value > THRESHOLD && leftWidth > 0) {
    translateX.value = leftWidth;
  } else if (translateX.value < -THRESHOLD && rightWidth > 0) {
    translateX.value = -rightWidth;
  } else {
    translateX.value = 0;
  }
};

const contentStyle = computed(() => ({
  transform: `translate3d(${translateX.value}px, 0, 0)`,
  transition: isSwiping.value ? 'none' : 'transform 0.3s cubic-bezier(0.4, 0.0, 0.2, 1)'
}));
</script>

<style scoped>
.biz-swipe-wrapper {
  position: relative;
  width: 100%;
  overflow: hidden;
  background: #f4f5f8;
}

.biz-swipe-actions {
  position: absolute;
  top: 0;
  bottom: 0;
  display: flex;
  align-items: stretch;
}

.biz-swipe-actions.left {
  left: 0;
}

.biz-swipe-actions.right {
  right: 0;
}

/* Common style for buttons inside slots to stretch full height */
.biz-swipe-actions :deep(> *) {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 100%;
  border: none;
  padding: 0 20px;
  cursor: pointer;
  color: white;
}

.biz-swipe-content {
  position: relative;
  width: 100%;
  background: white;
  z-index: 1;
  will-change: transform;
}
</style>
