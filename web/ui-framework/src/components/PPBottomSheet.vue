<template>
  <Teleport to="body">
    <transition name="pp-bottom-sheet-fade">
      <div v-if="modelValue" class="pp-bottom-sheet-backdrop" @click="close"></div>
    </transition>
    
    <transition 
      name="pp-bottom-sheet-slide"
      @after-leave="resetDragState"
    >
      <div 
        v-if="modelValue" 
        class="pp-bottom-sheet-container" 
        :class="sheetClass"
        role="dialog" 
        aria-modal="true"
        ref="sheetRef"
        :style="{ transform: sheetTransform, transition: isDragging ? 'none' : '' }"
        @touchstart="onTouchStart"
        @touchmove="onTouchMove"
        @touchend="onTouchEnd"
        @mousedown="onMouseDown"
      >
        <div class="pp-bottom-sheet-handle-wrap">
          <div class="pp-bottom-sheet-handle"></div>
        </div>
        
        <div class="pp-bottom-sheet-header" v-if="$slots.header">
          <slot name="header"></slot>
        </div>
        
        <div class="pp-bottom-sheet-content" @touchstart="onContentTouchStart" @mousedown="onContentMouseDown">
          <slot></slot>
        </div>
        
        <div class="pp-bottom-sheet-footer" v-if="$slots.footer">
          <slot name="footer"></slot>
        </div>
      </div>
    </transition>
  </Teleport>
</template>

<script setup lang="ts">
import { ref, watch, onUnmounted, computed } from 'vue';

const props = withDefaults(defineProps<{
  modelValue: boolean;
  enableSwipeToClose?: boolean;
  sheetClass?: string;
}>(), {
  enableSwipeToClose: true,
  sheetClass: ''
});

const emit = defineEmits(['update:modelValue', 'close']);

const sheetRef = ref<HTMLElement | null>(null);

// Drag State
const isDragging = ref(false);
const startY = ref(0);
const currentY = ref(0);

const sheetTransform = computed(() => {
  if (!isDragging.value && currentY.value === 0) return '';
  return `translateY(${currentY.value}px)`;
});

const close = () => {
  emit('update:modelValue', false);
  emit('close');
};

const resetDragState = () => {
  isDragging.value = false;
  startY.value = 0;
  currentY.value = 0;
};

// Touch Handlers
const onTouchStart = (e: TouchEvent) => {
  if (!props.enableSwipeToClose) return;
  isDragging.value = true;
  startY.value = e.touches[0].clientY;
};

const onTouchMove = (e: TouchEvent) => {
  if (!isDragging.value) return;
  const deltaY = e.touches[0].clientY - startY.value;
  // Only allow dragging down
  if (deltaY > 0) {
    currentY.value = deltaY;
    e.preventDefault(); // Prevent scrolling while dragging sheet
  }
};

const onTouchEnd = () => {
  if (!isDragging.value) return;
  isDragging.value = false;
  
  // If dragged down more than 100px, close it
  if (currentY.value > 100) {
    close();
  } else {
    // Snap back
    currentY.value = 0;
  }
};

// Mouse Handlers (for desktop testing)
const onMouseDown = (e: MouseEvent) => {
  if (!props.enableSwipeToClose) return;
  isDragging.value = true;
  startY.value = e.clientY;
  document.addEventListener('mousemove', onMouseMove);
  document.addEventListener('mouseup', onMouseUp);
};

const onMouseMove = (e: MouseEvent) => {
  if (!isDragging.value) return;
  const deltaY = e.clientY - startY.value;
  if (deltaY > 0) {
    currentY.value = deltaY;
  }
};

const onMouseUp = () => {
  if (!isDragging.value) return;
  isDragging.value = false;
  document.removeEventListener('mousemove', onMouseMove);
  document.removeEventListener('mouseup', onMouseUp);
  
  if (currentY.value > 100) {
    close();
  } else {
    currentY.value = 0;
  }
};

// Prevent body scroll when open
watch(() => props.modelValue, (isOpen) => {
  if (typeof window !== 'undefined') {
    if (isOpen) {
      document.body.style.overflow = 'hidden';
    } else {
      document.body.style.overflow = '';
      if (!isDragging.value) {
        resetDragState();
      }
    }
  }
});

const onContentTouchStart = (e: TouchEvent) => {
  const target = e.currentTarget as HTMLElement;
  if (target && target.scrollTop > 0) {
    e.stopPropagation();
  }
};

const onContentMouseDown = (e: MouseEvent) => {
  const target = e.currentTarget as HTMLElement;
  if (target && target.scrollTop > 0) {
    e.stopPropagation();
  }
};

onUnmounted(() => {
  if (typeof window !== 'undefined') {
    document.body.style.overflow = '';
  }
  document.removeEventListener('mousemove', onMouseMove);
  document.removeEventListener('mouseup', onMouseUp);
});
</script>

<style scoped>
.pp-bottom-sheet-backdrop {
  position: fixed;
  inset: 0;
  background-color: var(--pp-bottom-sheet-backdrop, rgba(0, 0, 0, 0.4));
  z-index: 1000;
}

.pp-bottom-sheet-container {
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  background-color: var(--pp-bottom-sheet-bg, #ffffff);
  border-radius: var(--pp-bottom-sheet-radius, 24px) var(--pp-bottom-sheet-radius, 24px) 0 0;
  z-index: 1001;
  display: flex;
  flex-direction: column;
  max-height: 90vh;
  box-shadow: 0 -4px 16px rgba(0, 0, 0, 0.1);
  padding: 16px 0px 16px;
  /* Will-change helps with smooth animation during drag */
  will-change: transform;
}

@media (min-width: 768px) {
  .pp-bottom-sheet-container {
    max-width: 800px;
    margin: 0 auto;
  }
}

.pp-bottom-sheet-handle-wrap {
  display: flex;
  justify-content: center;
  padding-bottom: 16px;
  cursor: grab;
}

.pp-bottom-sheet-handle-wrap:active {
  cursor: grabbing;
}

.pp-bottom-sheet-handle {
  width: 40px;
  height: 4px;
  border-radius: 2px;
  background-color: var(--pp-bottom-sheet-handle-color, #e0e0e0);
}

.pp-bottom-sheet-header {
  margin-bottom: 16px;
}

.pp-bottom-sheet-content {
  flex: 1;
  overflow-y: auto;
  /* Ensure scrolling inside the content doesn't trigger sheet drag by default */
  overscroll-behavior-y: contain;
}

.pp-bottom-sheet-footer {
  margin-top: 24px;
  padding-bottom: env(safe-area-inset-bottom, 0px);
}

/* Transitions */
.pp-bottom-sheet-fade-enter-active,
.pp-bottom-sheet-fade-leave-active {
  transition: opacity 0.3s ease;
}

.pp-bottom-sheet-fade-enter-from,
.pp-bottom-sheet-fade-leave-to {
  opacity: 0;
}

.pp-bottom-sheet-slide-enter-active {
  transition: transform 0.3s cubic-bezier(0.2, 0.8, 0.2, 1);
}

.pp-bottom-sheet-slide-leave-active {
  transition: transform 0.25s cubic-bezier(0.4, 0, 0.2, 1);
}

.pp-bottom-sheet-slide-enter-from,
.pp-bottom-sheet-slide-leave-to {
  transform: translateY(100%);
}

@media (prefers-color-scheme: dark) {
  .pp-bottom-sheet-container {
    background-color: var(--pp-bottom-sheet-bg, #1e1e1e);
    color: #ffffff;
  }
}
</style>
