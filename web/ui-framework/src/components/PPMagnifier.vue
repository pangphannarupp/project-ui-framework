<template>
  <div 
    class="pp-magnifier-container" 
    @mousemove="onMouseMove" 
    @mouseenter="showMagnifier = true"
    @mouseleave="showMagnifier = false"
  >
    <img :src="src" :alt="alt" class="base-image" ref="imageRef" />
    
    <div 
      v-show="showMagnifier" 
      class="magnifier-lens"
      :style="{
        width: `${lensSize}px`,
        height: `${lensSize}px`,
        left: `${lensPos.x}px`,
        top: `${lensPos.y}px`,
        backgroundImage: `url(${src})`,
        backgroundPosition: `${bgPos.x}% ${bgPos.y}%`,
        backgroundSize: `${bgSize.w}px ${bgSize.h}px`
      }"
    ></div>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive } from 'vue';

const props = withDefaults(defineProps<{
  src: string;
  alt?: string;
  zoom?: number;
  lensSize?: number;
}>(), {
  zoom: 2.5,
  lensSize: 120
});

const imageRef = ref<HTMLImageElement | null>(null);
const showMagnifier = ref(false);

const lensPos = reactive({ x: 0, y: 0 });
const bgPos = reactive({ x: 0, y: 0 });
const bgSize = reactive({ w: 0, h: 0 });

const onMouseMove = (e: MouseEvent) => {
  if (!imageRef.value) return;
  
  const rect = imageRef.value.getBoundingClientRect();
  const x = e.clientX - rect.left;
  const y = e.clientY - rect.top;

  // Position of lens (centered on cursor)
  lensPos.x = x - (props.lensSize / 2);
  lensPos.y = y - (props.lensSize / 2);

  // Calculate background position percentages
  const xPercent = (x / rect.width) * 100;
  const yPercent = (y / rect.height) * 100;

  bgPos.x = xPercent;
  bgPos.y = yPercent;
  
  bgSize.w = rect.width * props.zoom;
  bgSize.h = rect.height * props.zoom;
};
</script>

<style scoped>
.pp-magnifier-container {
  position: relative;
  display: inline-block;
  cursor: crosshair;
  border-radius: 8px;
  overflow: hidden;
}

.base-image {
  display: block;
  max-width: 100%;
  height: auto;
}

.magnifier-lens {
  position: absolute;
  border: 2px solid white;
  border-radius: 50%;
  pointer-events: none;
  box-shadow: 0 4px 12px rgba(0,0,0,0.3);
  background-repeat: no-repeat;
  /* background-size is handled by inline style */
}
</style>
