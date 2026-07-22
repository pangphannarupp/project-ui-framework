<template>
  <div class="pp-image-cropper">
    <div class="cropper-container" ref="containerRef"
         @mousedown="onMouseDown"
         @mousemove="onMouseMove"
         @mouseup="onMouseUp"
         @mouseleave="onMouseUp"
         @touchstart="onTouchStart"
         @touchmove="onTouchMove"
         @touchend="onTouchEnd">
      <img
        v-if="imageLoaded"
        ref="imgRef"
        :src="src"
        class="cropper-image"
        :style="{ transform: `translate(calc(-50% + ${panX}px), calc(-50% + ${panY}px)) rotate(${rotation}deg) scale(${scale})` }"
        alt="Crop Target"
      />
      <div class="crop-overlay">
        <div class="crop-window" ref="windowRef" :style="{ aspectRatio: aspectRatio }"></div>
      </div>
    </div>

    <div class="cropper-controls">
      <button class="control-btn" @click="rotateLeft" title="Rotate Left">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M3 12a9 9 0 1 0 9-9 9.75 9.75 0 0 0-6.74 2.74L3 8"/><path d="M3 3v5h5"/></svg>
      </button>
      <button class="control-btn" @click="rotateRight" title="Rotate Right">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 12a9 9 0 1 1-9-9 9.75 9.75 0 0 1 6.74 2.74L21 8"/><path d="M21 3v5h-5"/></svg>
      </button>
      <button class="control-btn" @click="zoomOut" title="Zoom Out">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/><line x1="8" y1="11" x2="14" y2="11"/></svg>
      </button>
      <button class="control-btn" @click="zoomIn" title="Zoom In">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/><line x1="11" y1="8" x2="11" y2="14"/><line x1="8" y1="11" x2="14" y2="11"/></svg>
      </button>
      <button class="control-btn" @click="reset" title="Reset">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M3 12a9 9 0 1 0 9-9 9.75 9.75 0 0 0-6.74 2.74L3 8"/><path d="M3 3v5h5"/></svg>
      </button>
    </div>
    
    <div class="cropper-actions">
      <button class="action-btn cancel-btn" @click="$emit('cancel')">Cancel</button>
      <button class="action-btn crop-btn" @click="crop">Crop Image</button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, watch } from 'vue';

const props = defineProps({
  src: { type: String, required: true },
  aspectRatio: { type: Number, default: 1 }
});

const emit = defineEmits(['crop', 'cancel']);

const containerRef = ref<HTMLElement | null>(null);
const windowRef = ref<HTMLElement | null>(null);
const imgRef = ref<HTMLImageElement | null>(null);

const imageLoaded = ref(false);
const img = new Image();
img.crossOrigin = 'anonymous';

const scale = ref(1);
const rotation = ref(0);
const panX = ref(0);
const panY = ref(0);

let isDragging = false;
let startX = 0;
let startY = 0;

const loadImg = () => {
  imageLoaded.value = false;
  img.src = props.src;
  img.onload = () => {
    imageLoaded.value = true;
    reset();
  };
};

onMounted(() => {
  loadImg();
});

watch(() => props.src, () => {
  loadImg();
});

const reset = () => {
  scale.value = 1;
  rotation.value = 0;
  panX.value = 0;
  panY.value = 0;
  
  if (containerRef.value && img.width && img.height) {
    const container = containerRef.value.getBoundingClientRect();
    const s1 = container.width / img.width;
    const s2 = container.height / img.height;
    scale.value = Math.min(s1, s2) * 0.8; // 80% of container
  }
};

const rotateLeft = () => { rotation.value -= 90; };
const rotateRight = () => { rotation.value += 90; };
const zoomIn = () => { scale.value *= 1.2; };
const zoomOut = () => { scale.value /= 1.2; };

// Mouse drag
const onMouseDown = (e: MouseEvent) => {
  e.preventDefault();
  isDragging = true;
  startX = e.clientX - panX.value;
  startY = e.clientY - panY.value;
};

const onMouseMove = (e: MouseEvent) => {
  if (!isDragging) return;
  panX.value = e.clientX - startX;
  panY.value = e.clientY - startY;
};

const onMouseUp = () => {
  isDragging = false;
};

// Touch drag
let initialDistance = 0;
let initialScale = 1;

const getDistance = (touches: TouchList) => {
  const dx = touches[0].clientX - touches[1].clientX;
  const dy = touches[0].clientY - touches[1].clientY;
  return Math.sqrt(dx * dx + dy * dy);
};

const onTouchStart = (e: TouchEvent) => {
  if (e.touches.length === 1) {
    isDragging = true;
    startX = e.touches[0].clientX - panX.value;
    startY = e.touches[0].clientY - panY.value;
  } else if (e.touches.length === 2) {
    isDragging = false;
    initialDistance = getDistance(e.touches);
    initialScale = scale.value;
  }
};

const onTouchMove = (e: TouchEvent) => {
  if (e.touches.length === 1 && isDragging) {
    e.preventDefault();
    panX.value = e.touches[0].clientX - startX;
    panY.value = e.touches[0].clientY - startY;
  } else if (e.touches.length === 2) {
    e.preventDefault();
    const currentDistance = getDistance(e.touches);
    scale.value = initialScale * (currentDistance / initialDistance);
  }
};

const onTouchEnd = () => {
  isDragging = false;
};

const crop = () => {
  if (!windowRef.value || !containerRef.value) return;
  const canvas = document.createElement('canvas');
  const ctx = canvas.getContext('2d');
  if (!ctx) return;

  const cropWin = windowRef.value.getBoundingClientRect();

  canvas.width = cropWin.width;
  canvas.height = cropWin.height;

  // Move to center of canvas
  ctx.translate(canvas.width / 2, canvas.height / 2);
  ctx.rotate(rotation.value * Math.PI / 180);
  ctx.scale(scale.value, scale.value);
  
  // Draw the image
  ctx.drawImage(
    img, 
    -img.width / 2 + panX.value / scale.value, 
    -img.height / 2 + panY.value / scale.value
  );

  const dataUrl = canvas.toDataURL('image/jpeg', 0.9);
  emit('crop', dataUrl);
};
</script>

<style scoped>
.pp-image-cropper {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 16px;
  width: 100%;
  background: #111;
  border-radius: 12px;
  padding: 16px;
  box-sizing: border-box;
}

.cropper-container {
  position: relative;
  width: 100%;
  height: 300px;
  background: #000;
  overflow: hidden;
  border-radius: 8px;
  cursor: grab;
  touch-action: none;
}

.cropper-container:active {
  cursor: grabbing;
}

.cropper-image {
  position: absolute;
  top: 50%;
  left: 50%;
  transform-origin: center;
  pointer-events: none;
}

.crop-overlay {
  position: absolute;
  top: 0; left: 0; right: 0; bottom: 0;
  pointer-events: none;
  background: rgba(0,0,0,0.5);
  display: flex;
  align-items: center;
  justify-content: center;
}

.crop-window {
  width: 200px;
  height: 200px;
  box-shadow: 0 0 0 9999px rgba(0,0,0,0.5);
  border: 2px solid #fff;
  border-radius: 4px;
  position: relative;
}

/* Inner grid lines */
.crop-window::before, .crop-window::after {
  content: '';
  position: absolute;
  background: rgba(255,255,255,0.3);
}
.crop-window::before {
  top: 33.33%; bottom: 33.33%; left: 0; right: 0;
  border-top: 1px solid rgba(255,255,255,0.3);
  border-bottom: 1px solid rgba(255,255,255,0.3);
  background: transparent;
}
.crop-window::after {
  left: 33.33%; right: 33.33%; top: 0; bottom: 0;
  border-left: 1px solid rgba(255,255,255,0.3);
  border-right: 1px solid rgba(255,255,255,0.3);
  background: transparent;
}

.cropper-controls {
  display: flex;
  gap: 12px;
}

.control-btn {
  background: #333;
  border: none;
  border-radius: 50%;
  width: 40px;
  height: 40px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  cursor: pointer;
  transition: 0.2s;
}

.control-btn:hover {
  background: #444;
}

.control-btn svg {
  width: 20px;
  height: 20px;
}

.cropper-actions {
  display: flex;
  gap: 12px;
  width: 100%;
}

.action-btn {
  flex: 1;
  padding: 12px;
  border: none;
  border-radius: 8px;
  font-weight: 600;
  cursor: pointer;
  transition: 0.2s;
}

.cancel-btn {
  background: #333;
  color: white;
}

.cancel-btn:hover {
  background: #444;
}

.crop-btn {
  background: var(--pp-primary-variant, #1a2a5e);
  color: white;
}

.crop-btn:hover {
  background: var(--pp-primary-light, #3880ff);
}
</style>
