<template>
  <div class="pp-signature-pad-container" ref="containerRef" :style="{ backgroundColor: backgroundColor === 'transparent' ? '' : backgroundColor }">
    <canvas
      ref="canvasRef"
      class="pp-signature-canvas"
      @mousedown.stop="startDrawing"
      @mousemove.stop="draw"
      @mouseup.stop="stopDrawing"
      @mouseleave.stop="stopDrawing"
      @touchstart.stop.prevent="startDrawing"
      @touchmove.stop.prevent="draw"
      @touchend.stop.prevent="stopDrawing"
      @touchcancel.stop.prevent="stopDrawing"
    ></canvas>
    
    <div v-if="placeholder && isEmptyState" class="pp-signature-placeholder">
      {{ placeholder }}
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, onBeforeUnmount, watch } from 'vue';

const props = defineProps({
  strokeColor: {
    type: String,
    default: '#000000'
  },
  lineWidth: {
    type: Number,
    default: 2
  },
  placeholder: {
    type: String,
    default: 'Sign here'
  },
  readonly: {
    type: Boolean,
    default: false
  },
  backgroundColor: {
    type: String,
    default: 'transparent'
  }
});

const emit = defineEmits(['begin', 'end', 'change']);

const containerRef = ref<HTMLElement | null>(null);
const canvasRef = ref<HTMLCanvasElement | null>(null);

let ctx: CanvasRenderingContext2D | null = null;
let isDrawing = false;
const isEmptyState = ref(true);

let resizeObserver: ResizeObserver | null = null;

const initCanvas = () => {
  if (!canvasRef.value || !containerRef.value) return;
  const canvas = canvasRef.value;
  const container = containerRef.value;

  // Set display size (css pixels)
  const rect = container.getBoundingClientRect();
  
  // Set actual size in memory (scaled to account for extra pixel density)
  const dpr = window.devicePixelRatio || 1;
  canvas.width = rect.width * dpr;
  canvas.height = rect.height * dpr;
  
  // Normalize coordinate system to use css pixels
  ctx = canvas.getContext('2d');
  if (ctx) {
    ctx.scale(dpr, dpr);
    ctx.lineCap = 'round';
    ctx.lineJoin = 'round';
    ctx.strokeStyle = props.strokeColor;
    ctx.lineWidth = props.lineWidth;
    
    if (props.backgroundColor !== 'transparent') {
      ctx.fillStyle = props.backgroundColor;
      ctx.fillRect(0, 0, rect.width, rect.height);
    }
  }
};

const handleResize = () => {
  // Save current image data
  const data = getData();
  initCanvas();
  // Restore if not empty (restoring properly requires an image object load)
  if (data && !isEmptyState.value && ctx && canvasRef.value) {
    const img = new Image();
    img.onload = () => {
      ctx?.drawImage(img, 0, 0, canvasRef.value!.width / (window.devicePixelRatio || 1), canvasRef.value!.height / (window.devicePixelRatio || 1));
    };
    img.src = data;
  }
};

onMounted(() => {
  initCanvas();
  if (containerRef.value) {
    resizeObserver = new ResizeObserver(() => {
      handleResize();
    });
    resizeObserver.observe(containerRef.value);
  }
});

onBeforeUnmount(() => {
  if (resizeObserver && containerRef.value) {
    resizeObserver.unobserve(containerRef.value);
    resizeObserver.disconnect();
  }
});

watch(() => props.strokeColor, (newColor) => {
  if (ctx) ctx.strokeStyle = newColor;
});
watch(() => props.lineWidth, (newWidth) => {
  if (ctx) ctx.lineWidth = newWidth;
});

const getCoordinates = (event: MouseEvent | TouchEvent) => {
  if (!canvasRef.value) return { x: 0, y: 0 };
  const rect = canvasRef.value.getBoundingClientRect();
  
  let clientX, clientY;
  if ('touches' in event) {
    clientX = event.touches[0].clientX;
    clientY = event.touches[0].clientY;
  } else {
    clientX = (event as MouseEvent).clientX;
    clientY = (event as MouseEvent).clientY;
  }
  
  return {
    x: clientX - rect.left,
    y: clientY - rect.top
  };
};

const startDrawing = (event: MouseEvent | TouchEvent) => {
  if (props.readonly || !ctx) return;
  isDrawing = true;
  isEmptyState.value = false;
  
  const { x, y } = getCoordinates(event);
  ctx.beginPath();
  ctx.moveTo(x, y);
  
  emit('begin');
};

const draw = (event: MouseEvent | TouchEvent) => {
  if (!isDrawing || props.readonly || !ctx) return;
  
  const { x, y } = getCoordinates(event);
  ctx.lineTo(x, y);
  ctx.stroke();
  
  emit('change');
};

const stopDrawing = () => {
  if (!isDrawing || props.readonly || !ctx) return;
  isDrawing = false;
  ctx.closePath();
  
  emit('end');
};

const clear = () => {
  if (!ctx || !canvasRef.value || !containerRef.value) return;
  const rect = containerRef.value.getBoundingClientRect();
  ctx.clearRect(0, 0, rect.width, rect.height);
  
  if (props.backgroundColor !== 'transparent') {
    ctx.fillStyle = props.backgroundColor;
    ctx.fillRect(0, 0, rect.width, rect.height);
  }
  
  isEmptyState.value = true;
  emit('change');
};

const getData = (type = 'image/png'): string | null => {
  if (!canvasRef.value || isEmptyState.value) return null;
  return canvasRef.value.toDataURL(type);
};

const isEmpty = () => {
  return isEmptyState.value;
};

defineExpose({
  clear,
  getData,
  isEmpty
});

</script>

<style scoped>
.pp-signature-pad-container {
  position: relative;
  width: 100%;
  height: 200px; /* Default height */
  border: 1px solid var(--pp-border-color, #e0e0e0);
  border-radius: 8px;
  /* background-color is set dynamically via style binding */
  overflow: hidden;
  touch-action: none; /* Prevent scrolling on mobile while drawing */
}

.pp-signature-canvas {
  display: block;
  width: 100%;
  height: 100%;
  cursor: crosshair;
}

.pp-signature-placeholder {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  color: #9e9e9e;
  font-size: 24px;
  font-weight: 500;
  pointer-events: none;
  user-select: none;
  opacity: 0.5;
}
</style>
