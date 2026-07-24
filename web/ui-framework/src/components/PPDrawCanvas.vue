<template>
  <div class="pp-draw-canvas-container">
    <div class="toolbar">
      <div class="colors">
        <button 
          v-for="color in colors" 
          :key="color"
          class="color-btn"
          :class="{ active: strokeColor === color }"
          :style="{ background: color }"
          @click="strokeColor = color; isEraser = false"
        ></button>
      </div>
      <div class="actions">
        <button class="action-btn" :class="{ active: isEraser }" @click="isEraser = true">Eraser</button>
        <button class="action-btn clear-btn" @click="clearCanvas">Clear</button>
      </div>
    </div>
    
    <div class="canvas-wrapper">
      <canvas 
        ref="canvasRef"
        :width="width"
        :height="height"
        @mousedown="startDrawing"
        @mousemove="draw"
        @mouseup="stopDrawing"
        @mouseleave="stopDrawing"
        @touchstart="startDrawingTouch"
        @touchmove.prevent="drawTouch"
        @touchend="stopDrawing"
      ></canvas>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue';

withDefaults(defineProps<{
  width?: number;
  height?: number;
}>(), {
  width: 600,
  height: 400
});

const canvasRef = ref<HTMLCanvasElement | null>(null);
const isDrawing = ref(false);
const isEraser = ref(false);
const strokeColor = ref('#000000');
const lineWidth = ref(3);

const colors = ['#000000', '#ef4444', '#3b82f6', '#22c55e', '#f59e0b', '#a855f7'];

let ctx: CanvasRenderingContext2D | null = null;

onMounted(() => {
  if (canvasRef.value) {
    ctx = canvasRef.value.getContext('2d');
    if (ctx) {
      ctx.lineCap = 'round';
      ctx.lineJoin = 'round';
      clearCanvas(); // Fill with white background initially
    }
  }
});

const startDrawing = (e: MouseEvent) => {
  if (!ctx || !canvasRef.value) return;
  isDrawing.value = true;
  ctx.beginPath();
  ctx.moveTo(e.offsetX, e.offsetY);
};

const draw = (e: MouseEvent) => {
  if (!isDrawing.value || !ctx) return;
  setupStroke();
  ctx.lineTo(e.offsetX, e.offsetY);
  ctx.stroke();
};

const startDrawingTouch = (e: TouchEvent) => {
  if (!ctx || !canvasRef.value) return;
  const rect = canvasRef.value.getBoundingClientRect();
  isDrawing.value = true;
  ctx.beginPath();
  ctx.moveTo(e.touches[0].clientX - rect.left, e.touches[0].clientY - rect.top);
};

const drawTouch = (e: TouchEvent) => {
  if (!isDrawing.value || !ctx || !canvasRef.value) return;
  const rect = canvasRef.value.getBoundingClientRect();
  setupStroke();
  ctx.lineTo(e.touches[0].clientX - rect.left, e.touches[0].clientY - rect.top);
  ctx.stroke();
};

const setupStroke = () => {
  if (!ctx) return;
  if (isEraser.value) {
    ctx.strokeStyle = '#ffffff';
    ctx.lineWidth = lineWidth.value * 5;
  } else {
    ctx.strokeStyle = strokeColor.value;
    ctx.lineWidth = lineWidth.value;
  }
};

const stopDrawing = () => {
  isDrawing.value = false;
  if (ctx) ctx.closePath();
};

const clearCanvas = () => {
  if (ctx && canvasRef.value) {
    ctx.fillStyle = '#ffffff';
    ctx.fillRect(0, 0, canvasRef.value.width, canvasRef.value.height);
  }
};
</script>

<style scoped>
.pp-draw-canvas-container {
  background: white;
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 4px 12px rgba(0,0,0,0.05);
  display: inline-block;
  border: 1px solid #e2e8f0;
}

.toolbar {
  padding: 12px 16px;
  background: #f8fafc;
  border-bottom: 1px solid #e2e8f0;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.colors {
  display: flex;
  gap: 8px;
}

.color-btn {
  width: 24px;
  height: 24px;
  border-radius: 50%;
  border: 2px solid transparent;
  cursor: pointer;
  padding: 0;
  transition: transform 0.2s;
}

.color-btn:hover {
  transform: scale(1.1);
}

.color-btn.active {
  border-color: #333;
  box-shadow: 0 0 0 2px white inset;
}

.actions {
  display: flex;
  gap: 8px;
}

.action-btn {
  padding: 6px 12px;
  border: 1px solid #cbd5e1;
  background: white;
  border-radius: 6px;
  font-size: 13px;
  font-weight: 600;
  color: #475569;
  cursor: pointer;
}
.action-btn:hover {
  background: #f1f5f9;
}
.action-btn.active {
  background: #334155;
  color: white;
  border-color: #334155;
}
.action-btn.clear-btn {
  color: #ef4444;
  border-color: #fca5a5;
  background: #fef2f2;
}
.action-btn.clear-btn:hover {
  background: #fee2e2;
}

.canvas-wrapper {
  touch-action: none; /* Prevents scrolling when drawing on touch devices */
}

canvas {
  display: block;
  cursor: crosshair;
}
</style>
