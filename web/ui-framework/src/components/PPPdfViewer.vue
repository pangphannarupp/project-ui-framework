<template>
  <div class="pp-pdf-viewer" :class="[`sidebar-${sidebarPosition}`, { 'sidebar-open': isSidebarOpen }]">
    <div class="pdf-main-wrapper">
      <div class="pdf-sidebar-container" :class="{ closed: !isSidebarOpen }">
        <div v-for="n in totalPages" :key="n" 
             class="thumbnail-wrapper" 
             :class="{ active: currentPage === n }"
             @click="goToPage(n)">
           <canvas :ref="el => setThumbRef(el, n)"></canvas>
           <span class="thumb-page-num">{{ n }}</span>
        </div>
      </div>
      <div class="pdf-container" ref="containerRef"
           @mousedown="onMouseDown"
           @mousemove="onMouseMove"
           @mouseup="onMouseUp"
           @mouseleave="onMouseUp"
           @wheel="onWheel">
        <canvas ref="canvasRef" class="pdf-canvas"></canvas>
      </div>
    </div>
    
    <div class="pdf-controls">
      <div class="controls-group">
        <button class="control-btn" @click="toggleSidebar" title="Toggle Sidebar">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect><line x1="9" y1="3" x2="9" y2="21"></line></svg>
        </button>
        <div class="divider"></div>
        <button class="control-btn" @click="zoomOut" title="Zoom Out" :disabled="isLoading">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line><line x1="8" y1="11" x2="14" y2="11"></line></svg>
        </button>
        <span class="zoom-level">{{ Math.round(state.scale * 100) }}%</span>
        <button class="control-btn" @click="zoomIn" title="Zoom In" :disabled="isLoading">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line><line x1="11" y1="8" x2="11" y2="14"></line><line x1="8" y1="11" x2="14" y2="11"></line></svg>
        </button>
        <button class="control-btn" @click="resetView" title="Reset View" :disabled="isLoading">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path><polyline points="9 22 9 12 15 12 15 22"></polyline></svg>
        </button>
      </div>
      
      <div class="controls-group">
        <button class="control-btn" @click="prevPage" :disabled="currentPage <= 1 || isLoading" title="Previous Page">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="15 18 9 12 15 6"></polyline></svg>
        </button>
        <span class="page-info">{{ currentPage }} / {{ totalPages }}</span>
        <button class="control-btn" @click="nextPage" :disabled="currentPage >= totalPages || isLoading" title="Next Page">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="9 18 15 12 9 6"></polyline></svg>
        </button>
      </div>
    </div>
    
    <div v-if="isLoading" class="loading-overlay">
      <div class="spinner"></div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, watch, onUnmounted, shallowRef } from 'vue';
import * as pdfjsLib from 'pdfjs-dist';
// Import worker directly for modern bundlers
// @ts-ignore
import pdfjsWorker from 'pdfjs-dist/build/pdf.worker.mjs?url';

pdfjsLib.GlobalWorkerOptions.workerSrc = pdfjsWorker;

const props = defineProps({
  src: { type: String, required: true },
  sidebarPosition: { type: String, default: 'left' }
});

const containerRef = ref<HTMLElement | null>(null);
const canvasRef = ref<HTMLCanvasElement | null>(null);

const pdfDocument = shallowRef<pdfjsLib.PDFDocumentProxy | null>(null);
const currentPage = ref(1);
const totalPages = ref(0);
const isLoading = ref(false);
const isSidebarOpen = ref(true);

const thumbRefs = ref<Record<number, HTMLCanvasElement>>({});
const setThumbRef = (el: any, n: number) => {
  if (el) thumbRefs.value[n] = el;
};

const toggleSidebar = () => {
  isSidebarOpen.value = !isSidebarOpen.value;
  if (isSidebarOpen.value) {
    renderThumbnails();
  }
};

let pdfPage: pdfjsLib.PDFPageProxy | null = null;
let renderTask: pdfjsLib.RenderTask | null = null;

const state = ref({
  x: 0,
  y: 0,
  scale: 1,
  baseScale: 1
});

const isDragging = ref(false);
const startPos = ref({ x: 0, y: 0 });

const loadPdf = async () => {
  if (!props.src) return;
  isLoading.value = true;
  try {
    const loadingTask = pdfjsLib.getDocument(props.src);
    pdfDocument.value = await loadingTask.promise;
    totalPages.value = pdfDocument.value.numPages;
    currentPage.value = 1;
    await renderPage(currentPage.value);
    
    if (isSidebarOpen.value) {
      renderThumbnails();
    }
  } catch (error) {
    console.error('Error loading PDF:', error);
  } finally {
    isLoading.value = false;
  }
};

const renderedThumbs = new Set<number>();
const renderThumbnails = async () => {
  if (!pdfDocument.value) return;
  for (let i = 1; i <= totalPages.value; i++) {
    if (!isSidebarOpen.value) break;
    if (renderedThumbs.has(i)) continue;
    
    try {
      const page = await pdfDocument.value.getPage(i);
      const canvas = thumbRefs.value[i];
      if (!canvas) continue;
      
      const ctx = canvas.getContext('2d');
      const viewport = page.getViewport({ scale: 0.2 }); // small scale for thumbnail
      
      const dpr = window.devicePixelRatio || 1;
      canvas.width = viewport.width * dpr;
      canvas.height = viewport.height * dpr;
      canvas.style.width = `${viewport.width}px`;
      canvas.style.height = `${viewport.height}px`;
      ctx?.scale(dpr, dpr);
      
      await page.render({
        canvasContext: ctx!,
        viewport: viewport
      }).promise;
      
      renderedThumbs.add(i);
    } catch (e) {
      console.error(e);
    }
  }
};

const renderPage = async (pageNum: number) => {
  if (!pdfDocument.value || !canvasRef.value || !containerRef.value) return;
  
  if (renderTask) {
    await renderTask.promise.catch(() => {});
  }
  
  pdfPage = await pdfDocument.value.getPage(pageNum);
  
  const viewport = pdfPage.getViewport({ scale: 1 });
  const container = containerRef.value;
  
  const scaleX = container.clientWidth / viewport.width;
  const scaleY = container.clientHeight / viewport.height;
  
  state.value.baseScale = Math.min(scaleX, scaleY, 1) * 0.95; // 95% to leave some margin
  state.value.scale = state.value.baseScale;
  
  centerDocument(viewport);
  drawPage();
};

const centerDocument = (viewport: pdfjsLib.PageViewport) => {
  if (!containerRef.value) return;
  const container = containerRef.value;
  
  const displayWidth = viewport.width * state.value.scale;
  const displayHeight = viewport.height * state.value.scale;
  
  state.value.x = (container.clientWidth - displayWidth) / 2;
  state.value.y = (container.clientHeight - displayHeight) / 2;
};

const drawPage = async () => {
  if (!pdfPage || !canvasRef.value || !containerRef.value) return;
  
  const canvas = canvasRef.value;
  const container = containerRef.value;
  const ctx = canvas.getContext('2d');
  if (!ctx) return;
  
  const dpr = window.devicePixelRatio || 1;
  canvas.width = container.clientWidth * dpr;
  canvas.height = container.clientHeight * dpr;
  canvas.style.width = `${container.clientWidth}px`;
  canvas.style.height = `${container.clientHeight}px`;
  ctx.scale(dpr, dpr);
  
  tempRenderCanvas = document.createElement('canvas');
  const tempCtx = tempRenderCanvas.getContext('2d');
  
  const viewport = pdfPage.getViewport({ scale: state.value.scale * dpr });
  tempRenderCanvas.width = viewport.width;
  tempRenderCanvas.height = viewport.height;
  
  if (renderTask) {
    renderTask.cancel();
  }
  
  renderTask = pdfPage.render({
    canvasContext: tempCtx!,
    viewport: viewport
  });
  
  try {
    await renderTask.promise;
  } catch (e: any) {
    if (e.name === 'RenderingCancelledException') return;
    console.error(e);
  }
  
  ctx.clearRect(0, 0, container.clientWidth, container.clientHeight);
  ctx.drawImage(tempRenderCanvas, state.value.x, state.value.y, viewport.width / dpr, viewport.height / dpr);
};

// Pan and Zoom
const onMouseDown = (e: MouseEvent) => {
  isDragging.value = true;
  startPos.value = { x: e.clientX - state.value.x, y: e.clientY - state.value.y };
};

const onMouseMove = (e: MouseEvent) => {
  if (!isDragging.value) return;
  state.value.x = e.clientX - startPos.value.x;
  state.value.y = e.clientY - startPos.value.y;
  
  fastDraw(); // We use fastDraw because full render is too slow for panning
};

// fastDraw only draws the already rendered canvas at new coordinates
let tempRenderCanvas: HTMLCanvasElement | null = null;

const fastDraw = () => {
  if (!canvasRef.value || !pdfPage || !containerRef.value) return;
  const canvas = canvasRef.value;
  const container = containerRef.value;
  const ctx = canvas.getContext('2d');
  if (!ctx) return;
  
  ctx.clearRect(0, 0, container.clientWidth, container.clientHeight);
  
  if (!tempRenderCanvas) {
    drawPage(); // fallback if temp canvas isn't ready
    return;
  }
  
  const dpr = window.devicePixelRatio || 1;
  ctx.drawImage(tempRenderCanvas, state.value.x, state.value.y, tempRenderCanvas.width / dpr, tempRenderCanvas.height / dpr);
};

const fastDrawWithResize = (newWidth: number, newHeight: number) => {
  if (!canvasRef.value || !containerRef.value || !tempRenderCanvas) return;
  const canvas = canvasRef.value;
  const ctx = canvas.getContext('2d');
  if (!ctx) return;
  
  const dpr = window.devicePixelRatio || 1;
  
  if (canvas.width !== newWidth * dpr || canvas.height !== newHeight * dpr) {
    canvas.width = newWidth * dpr;
    canvas.height = newHeight * dpr;
    canvas.style.width = `${newWidth}px`;
    canvas.style.height = `${newHeight}px`;
    ctx.scale(dpr, dpr);
  }
  
  ctx.clearRect(0, 0, newWidth, newHeight);
  ctx.drawImage(tempRenderCanvas, state.value.x, state.value.y, tempRenderCanvas.width / dpr, tempRenderCanvas.height / dpr);
};

// Removed enhancedDrawPage as drawPage now handles it

const onMouseUp = () => {
  isDragging.value = false;
};

const onWheel = (e: WheelEvent) => {
  e.preventDefault();
  const delta = e.deltaY > 0 ? 0.9 : 1.1;
  applyZoom(delta, e.clientX, e.clientY);
};

const zoomIn = () => applyZoomCenter(1.2);
const zoomOut = () => applyZoomCenter(0.8);
const resetView = () => {
  if (!pdfPage) return;
  const viewport = pdfPage.getViewport({ scale: 1 });
  state.value.scale = state.value.baseScale;
  centerDocument(viewport);
  drawPage();
};

const applyZoomCenter = (delta: number) => {
  if (!containerRef.value) return;
  const rect = containerRef.value.getBoundingClientRect();
  applyZoom(delta, rect.left + rect.width / 2, rect.top + rect.height / 2);
};

const applyZoom = (delta: number, clientX: number, clientY: number) => {
  if (!containerRef.value || !pdfPage) return;
  const rect = containerRef.value.getBoundingClientRect();
  
  const mouseX = clientX - rect.left;
  const mouseY = clientY - rect.top;
  
  const newScale = state.value.scale * delta;
  
  if (newScale < 0.2 || newScale > 5) return;
  
  state.value.x = mouseX - (mouseX - state.value.x) * delta;
  state.value.y = mouseY - (mouseY - state.value.y) * delta;
  state.value.scale = newScale;
  
  drawPage();
};

// Pagination
const nextPage = () => {
  if (currentPage.value >= totalPages.value) return;
  currentPage.value++;
  renderPage(currentPage.value);
  scrollToActiveThumbnail();
};

const prevPage = () => {
  if (currentPage.value <= 1) return;
  currentPage.value--;
  renderPage(currentPage.value);
  scrollToActiveThumbnail();
};

const goToPage = (page: number) => {
  if (page < 1 || page > totalPages.value) return;
  currentPage.value = page;
  renderPage(currentPage.value);
};

const scrollToActiveThumbnail = () => {
  setTimeout(() => {
    const activeThumb = document.querySelector('.thumbnail-wrapper.active');
    if (activeThumb) {
      activeThumb.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
    }
  }, 100);
};

let lastWidth = 0;
let lastHeight = 0;
let resizeObserver: ResizeObserver | null = null;

const handleResizeFrame = () => {
  if (!containerRef.value) return;
  const newWidth = containerRef.value.clientWidth;
  const newHeight = containerRef.value.clientHeight;
  
  if (lastWidth === 0 || lastHeight === 0) {
    lastWidth = newWidth;
    lastHeight = newHeight;
    return;
  }
  
  const dx = newWidth - lastWidth;
  const dy = newHeight - lastHeight;
  
  if (dx === 0 && dy === 0) return;
  
  state.value.x += dx / 2;
  state.value.y += dy / 2;
  
  lastWidth = newWidth;
  lastHeight = newHeight;
  
  fastDrawWithResize(newWidth, newHeight);
};

watch(() => props.src, loadPdf);

onMounted(() => {
  loadPdf();
  
  if (containerRef.value) {
    lastWidth = containerRef.value.clientWidth;
    lastHeight = containerRef.value.clientHeight;
    
    resizeObserver = new ResizeObserver(() => {
      requestAnimationFrame(handleResizeFrame);
    });
    resizeObserver.observe(containerRef.value);
  }
});

onUnmounted(() => {
  if (resizeObserver) {
    resizeObserver.disconnect();
  }
  if (renderTask) {
    renderTask.cancel();
  }
});
</script>

<style scoped>
.pp-pdf-viewer {
  display: flex;
  flex-direction: column;
  width: 100%;
  height: 600px;
  background: #f0f0f0;
  border-radius: 8px;
  overflow: hidden;
  position: relative;
}

.pdf-main-wrapper {
  display: flex;
  flex: 1;
  overflow: hidden;
}

.pp-pdf-viewer.sidebar-right .pdf-main-wrapper {
  flex-direction: row-reverse;
}

.pdf-sidebar-container {
  width: 200px;
  min-width: 200px;
  background: #fafafa;
  border-right: 1px solid #eee;
  overflow-y: auto;
  padding: 16px 12px;
  display: flex;
  flex-direction: column;
  gap: 16px;
  transition: all 0.3s ease;
  box-sizing: border-box;
}

.pdf-sidebar-container.closed {
  width: 0;
  min-width: 0;
  padding-left: 0;
  padding-right: 0;
  border-right-width: 0;
  border-left-width: 0;
  opacity: 0;
}

.pp-pdf-viewer.sidebar-right .pdf-sidebar-container {
  border-right: none;
  border-left: 1px solid #eee;
}

.thumbnail-wrapper {
  display: flex;
  flex-direction: column;
  align-items: center;
  cursor: pointer;
  padding: 8px;
  border-radius: 6px;
  transition: background 0.2s;
}

.thumbnail-wrapper:hover {
  background: #eee;
}

.thumbnail-wrapper.active {
  background: #e0e0e0;
}

.thumbnail-wrapper canvas {
  background: #fff;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
  margin-bottom: 8px;
  max-width: 100%;
  height: auto !important; /* Let CSS resize proportional */
}

.thumb-page-num {
  font-size: 12px;
  color: #666;
  font-weight: 500;
}

.pdf-container {
  flex: 1;
  position: relative;
  overflow: hidden;
  cursor: grab;
}

.pdf-container:active {
  cursor: grabbing;
}

.pdf-canvas {
  position: absolute;
  top: 0;
  left: 0;
  transform-origin: 0 0;
}

.pdf-controls {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 12px 24px;
  background: #fff;
  border-top: 1px solid #eee;
  z-index: 10;
}

.controls-group {
  display: flex;
  align-items: center;
  gap: 12px;
}

.divider {
  width: 1px;
  height: 24px;
  background: #ddd;
  margin: 0 4px;
}

.control-btn {
  background: #f5f5f5;
  border: 1px solid #ddd;
  border-radius: 6px;
  width: 36px;
  height: 36px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #333;
  cursor: pointer;
  transition: all 0.2s ease;
}

.control-btn:hover:not(:disabled) {
  background: #e0e0e0;
}

.control-btn:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.control-btn svg {
  width: 18px;
  height: 18px;
}

.zoom-level, .page-info {
  font-size: 14px;
  font-weight: 500;
  color: #555;
  min-width: 60px;
  text-align: center;
}

.loading-overlay {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(255,255,255,0.7);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 20;
}

.spinner {
  width: 40px;
  height: 40px;
  border: 4px solid #f3f3f3;
  border-top: 4px solid #3498db;
  border-radius: 50%;
  animation: spin 1s linear infinite;
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}
</style>
