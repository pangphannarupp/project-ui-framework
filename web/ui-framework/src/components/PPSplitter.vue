<template>
  <div 
    class="pp-splitter" 
    :class="direction"
    ref="containerRef"
  >
    <div class="pp-pane pp-pane-1" :style="pane1Style">
      <slot name="primary"></slot>
    </div>
    
    <div 
      class="pp-resizer" 
      @mousedown="startDrag" 
      @touchstart="startDrag"
    >
      <div class="resizer-handle"></div>
    </div>
    
    <div class="pp-pane pp-pane-2" :style="pane2Style">
      <slot name="secondary"></slot>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onUnmounted } from 'vue';

const props = withDefaults(defineProps<{
  direction?: 'horizontal' | 'vertical';
  initialSplit?: number; // percentage (e.g., 50 for 50%)
  min?: number; // min percentage for either pane
}>(), {
  direction: 'horizontal',
  initialSplit: 50,
  min: 10
});

const splitPercent = ref(props.initialSplit);
const containerRef = ref<HTMLElement | null>(null);
const isDragging = ref(false);

const pane1Style = computed(() => {
  if (props.direction === 'horizontal') {
    return { width: `${splitPercent.value}%` };
  } else {
    return { height: `${splitPercent.value}%` };
  }
});

const pane2Style = computed(() => {
  if (props.direction === 'horizontal') {
    return { width: `${100 - splitPercent.value}%` };
  } else {
    return { height: `${100 - splitPercent.value}%` };
  }
});

const startDrag = (e: MouseEvent | TouchEvent) => {
  e.preventDefault();
  isDragging.value = true;
  document.body.style.cursor = props.direction === 'horizontal' ? 'col-resize' : 'row-resize';
  document.body.style.userSelect = 'none'; // prevent text selection during drag
  
  document.addEventListener('mousemove', onDrag);
  document.addEventListener('touchmove', onDrag, { passive: false });
  document.addEventListener('mouseup', stopDrag);
  document.addEventListener('touchend', stopDrag);
};

const onDrag = (e: MouseEvent | TouchEvent) => {
  if (!isDragging.value || !containerRef.value) return;
  e.preventDefault();

  const rect = containerRef.value.getBoundingClientRect();
  
  let pos = 0;
  let total = 0;

  const clientX = 'touches' in e ? e.touches[0].clientX : (e as MouseEvent).clientX;
  const clientY = 'touches' in e ? e.touches[0].clientY : (e as MouseEvent).clientY;

  if (props.direction === 'horizontal') {
    pos = clientX - rect.left;
    total = rect.width;
  } else {
    pos = clientY - rect.top;
    total = rect.height;
  }

  let newPercent = (pos / total) * 100;
  
  // Constrain to min/max
  if (newPercent < props.min) newPercent = props.min;
  if (newPercent > (100 - props.min)) newPercent = (100 - props.min);
  
  splitPercent.value = newPercent;
};

const stopDrag = () => {
  isDragging.value = false;
  document.body.style.cursor = '';
  document.body.style.userSelect = '';
  
  document.removeEventListener('mousemove', onDrag);
  document.removeEventListener('touchmove', onDrag);
  document.removeEventListener('mouseup', stopDrag);
  document.removeEventListener('touchend', stopDrag);
};

onUnmounted(() => {
  stopDrag();
});
</script>

<style scoped>
.pp-splitter {
  display: flex;
  width: 100%;
  height: 100%;
  overflow: hidden;
  border-radius: 8px;
  border: 1px solid #e2e8f0;
  background: white;
}

.pp-splitter.vertical {
  flex-direction: column;
}

.pp-pane {
  overflow: auto;
  position: relative;
}

.pp-resizer {
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: #f1f5f9;
  z-index: 10;
  transition: background-color 0.2s;
}

.pp-resizer:hover, .pp-resizer:active {
  background-color: #cbd5e1;
}

.pp-splitter.horizontal .pp-resizer {
  width: 6px;
  cursor: col-resize;
}

.pp-splitter.vertical .pp-resizer {
  height: 6px;
  cursor: row-resize;
}

.resizer-handle {
  background-color: #94a3b8;
  border-radius: 4px;
}

.pp-splitter.horizontal .resizer-handle {
  width: 2px;
  height: 24px;
}

.pp-splitter.vertical .resizer-handle {
  width: 24px;
  height: 2px;
}
</style>
