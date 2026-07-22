<template>
  <div class="pp-image-preview">
    <div class="preview-container" ref="containerRef"
         @mousedown="onMouseDown"
         @mousemove="onMouseMove"
         @mouseup="onMouseUp"
         @mouseleave="onMouseUp"
         @wheel="onWheel">
      <canvas ref="canvasRef" class="preview-canvas"></canvas>
    </div>
    
    <div class="controls-overlay">
      <button class="control-btn" @click="resetView" title="Reset View">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path><polyline points="9 22 9 12 15 12 15 22"></polyline></svg>
      </button>
      <button class="control-btn" @click="zoomOut" title="Zoom Out">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line><line x1="8" y1="11" x2="14" y2="11"></line></svg>
      </button>
      <button class="control-btn" @click="zoomIn" title="Zoom In">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line><line x1="11" y1="8" x2="11" y2="14"></line><line x1="8" y1="11" x2="14" y2="11"></line></svg>
      </button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, watch, onUnmounted } from 'vue';

const props = defineProps({
  src: { type: String, required: true }
});

const containerRef = ref<HTMLElement | null>(null);
const canvasRef = ref<HTMLCanvasElement | null>(null);

let imageObj = new Image();
let ctx: CanvasRenderingContext2D | null = null;
let animationFrameId: number;

const state = ref({
  x: 0,
  y: 0,
  scale: 1
});

const isDragging = ref(false);
const startPos = ref({ x: 0, y: 0 });

const initCanvas = () => {
  if (!canvasRef.value || !containerRef.value) return;
  const canvas = canvasRef.value;
  const container = containerRef.value;
  
  canvas.width = container.clientWidth;
  canvas.height = container.clientHeight;
  ctx = canvas.getContext('2d');
  
  render();
};

const loadImage = () => {
  imageObj = new Image();
  imageObj.crossOrigin = "anonymous";
  imageObj.onload = () => {
    resetView();
  };
  imageObj.src = props.src;
};

const resetView = () => {
  if (!canvasRef.value || !imageObj.width) return;
  const canvas = canvasRef.value;
  
  const scaleX = canvas.width / imageObj.width;
  const scaleY = canvas.height / imageObj.height;
  
  state.value.scale = Math.min(scaleX, scaleY, 1);
  state.value.x = (canvas.width - imageObj.width * state.value.scale) / 2;
  state.value.y = (canvas.height - imageObj.height * state.value.scale) / 2;
  
  render();
};

const render = () => {
  if (!ctx || !canvasRef.value || !imageObj.width) return;
  const canvas = canvasRef.value;
  
  ctx.clearRect(0, 0, canvas.width, canvas.height);
  
  ctx.save();
  ctx.translate(state.value.x, state.value.y);
  ctx.scale(state.value.scale, state.value.scale);
  ctx.drawImage(imageObj, 0, 0);
  ctx.restore();
};

const onMouseDown = (e: MouseEvent) => {
  isDragging.value = true;
  startPos.value = { x: e.clientX - state.value.x, y: e.clientY - state.value.y };
};

const onMouseMove = (e: MouseEvent) => {
  if (!isDragging.value) return;
  state.value.x = e.clientX - startPos.value.x;
  state.value.y = e.clientY - startPos.value.y;
  
  if (animationFrameId) cancelAnimationFrame(animationFrameId);
  animationFrameId = requestAnimationFrame(render);
};

const onMouseUp = () => {
  isDragging.value = false;
};

const onWheel = (e: WheelEvent) => {
  e.preventDefault();
  const delta = e.deltaY > 0 ? 0.9 : 1.1;
  
  if (!canvasRef.value) return;
  const canvas = canvasRef.value;
  const rect = canvas.getBoundingClientRect();
  
  const mouseX = e.clientX - rect.left;
  const mouseY = e.clientY - rect.top;
  
  const newScale = state.value.scale * delta;
  
  if (newScale < 0.1 || newScale > 10) return;
  
  state.value.x = mouseX - (mouseX - state.value.x) * delta;
  state.value.y = mouseY - (mouseY - state.value.y) * delta;
  state.value.scale = newScale;
  
  if (animationFrameId) cancelAnimationFrame(animationFrameId);
  animationFrameId = requestAnimationFrame(render);
};

const zoomIn = () => {
  const delta = 1.2;
  applyZoomCenter(delta);
};

const zoomOut = () => {
  const delta = 0.8;
  applyZoomCenter(delta);
};

const applyZoomCenter = (delta: number) => {
  if (!canvasRef.value) return;
  const canvas = canvasRef.value;
  
  const centerX = canvas.width / 2;
  const centerY = canvas.height / 2;
  
  const newScale = state.value.scale * delta;
  if (newScale < 0.1 || newScale > 10) return;
  
  state.value.x = centerX - (centerX - state.value.x) * delta;
  state.value.y = centerY - (centerY - state.value.y) * delta;
  state.value.scale = newScale;
  
  render();
};

const handleResize = () => {
  initCanvas();
  render();
};

watch(() => props.src, loadImage);

onMounted(() => {
  initCanvas();
  loadImage();
  window.addEventListener('resize', handleResize);
});

onUnmounted(() => {
  window.removeEventListener('resize', handleResize);
  if (animationFrameId) cancelAnimationFrame(animationFrameId);
});
</script>

<style scoped>
.pp-image-preview {
  display: flex;
  flex-direction: column;
  width: 100%;
  height: 600px;
  background: #000;
  border-radius: 8px;
  overflow: hidden;
  position: relative;
}

.preview-container {
  flex: 1;
  position: relative;
  overflow: hidden;
  cursor: grab;
}

.preview-container:active {
  cursor: grabbing;
}

.preview-canvas {
  display: block;
  width: 100%;
  height: 100%;
}

.controls-overlay {
  position: absolute;
  bottom: 24px;
  left: 50%;
  transform: translateX(-50%);
  display: flex;
  gap: 16px;
  background: rgba(0, 0, 0, 0.7);
  padding: 12px 24px;
  border-radius: 30px;
  backdrop-filter: blur(4px);
}

.control-btn {
  background: rgba(255, 255, 255, 0.1);
  border: none;
  border-radius: 50%;
  width: 44px;
  height: 44px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #fff;
  cursor: pointer;
  transition: all 0.2s ease;
}

.control-btn:hover {
  background: rgba(255, 255, 255, 0.2);
  transform: scale(1.05);
}

.control-btn svg {
  width: 20px;
  height: 20px;
}
</style>
