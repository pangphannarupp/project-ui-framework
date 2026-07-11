<template>
  <div class="biz-image-transition">
    <div 
      v-if="isExpanded || isAnimating" 
      class="biz-image-placeholder"
      :style="{ width: rect.width + 'px', height: rect.height + 'px' }"
    ></div>
    
    <div 
      class="biz-image-container" 
      :class="{ 'is-expanded': isExpanded, 'is-animating': isAnimating }"
      :style="containerStyle"
      @click="expand"
      ref="containerRef"
    >
      <div class="biz-image-wrapper" :style="wrapperStyle">
        <slot name="image" :isExpanded="isExpanded"></slot>
        
        <!-- Optional Back button overlaid on image when expanded -->
        <div 
          v-if="isExpanded || isAnimating"
          class="biz-image-back-btn"
          :style="{ opacity: isExpanded ? 1 : 0 }"
          @click.stop="collapse"
        >
          <svg viewBox="0 0 24 24" width="24" height="24" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round">
            <line x1="19" y1="12" x2="5" y2="12"></line>
            <polyline points="12 19 5 12 12 5"></polyline>
          </svg>
        </div>
      </div>
      
      <div class="biz-image-detail" v-if="isExpanded || isAnimating" :style="detailStyle">
        <slot name="detail" :collapse="collapse"></slot>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

const props = defineProps<{
  expandedImageHeight?: string;
  backgroundColor?: string;
}>();

const isExpanded = ref(false);
const isAnimating = ref(false);
const rect = ref({ top: 0, left: 0, width: 0, height: 0 });
const containerRef = ref<HTMLElement | null>(null);

const expand = () => {
  if (isExpanded.value || isAnimating.value) return;
  
  const domRect = containerRef.value!.getBoundingClientRect();
  rect.value = {
    top: domRect.top,
    left: domRect.left,
    width: domRect.width,
    height: domRect.height
  };
  
  isAnimating.value = true;
  
  // Wait for the DOM to update and the browser to paint the fixed position
  setTimeout(() => {
    isExpanded.value = true;
    setTimeout(() => {
      isAnimating.value = false;
    }, 400);
  }, 20);
};

const collapse = () => {
  if (!isExpanded.value || isAnimating.value) return;
  
  isAnimating.value = true;
  isExpanded.value = false;
  setTimeout(() => {
    isAnimating.value = false;
    rect.value = { top: 0, left: 0, width: 0, height: 0 };
  }, 400);
};

const containerStyle = computed(() => {
  if (!isExpanded.value && !isAnimating.value) {
    return {
      position: 'relative' as const,
      width: '100%',
      height: '100%',
      cursor: 'pointer'
    };
  }
  
  return {
    position: 'fixed' as const,
    top: isExpanded.value ? '0' : `${rect.value.top}px`,
    left: isExpanded.value ? '0' : `${rect.value.left}px`,
    width: isExpanded.value ? '100vw' : `${rect.value.width}px`,
    height: isExpanded.value ? '100vh' : `${rect.value.height}px`,
    zIndex: 99999,
    transition: 'all 0.4s cubic-bezier(0.4, 0, 0.2, 1)',
    backgroundColor: isExpanded.value ? (props.backgroundColor || '#ffffff') : 'transparent',
    overflow: isExpanded.value ? 'auto' : 'hidden',
    borderRadius: isExpanded.value ? '0' : 'inherit'
  };
});

const wrapperStyle = computed(() => {
  if (!isExpanded.value && !isAnimating.value) {
    return { width: '100%', height: '100%', position: 'relative' as const };
  }
  
  return {
    position: 'relative' as const,
    width: isExpanded.value ? '100vw' : `${rect.value.width}px`,
    height: isExpanded.value ? (props.expandedImageHeight || '350px') : `${rect.value.height}px`,
    transition: 'all 0.4s cubic-bezier(0.4, 0, 0.2, 1)'
  };
});

const detailStyle = computed(() => {
  return {
    opacity: isExpanded.value ? 1 : 0,
    transition: 'all 0.3s ease',
    transitionDelay: isExpanded.value ? '0.2s' : '0s',
    pointerEvents: (isExpanded.value ? 'auto' : 'none') as any,
    transform: isExpanded.value ? 'translateY(0)' : 'translateY(20px)'
  };
});
</script>

<style scoped>
.biz-image-transition {
  display: block;
  width: 100%;
  height: 100%;
}

.biz-image-container :deep(img) {
  width: 100% !important;
  height: 100% !important;
  object-fit: cover !important;
  margin: 0 !important;
  border-radius: inherit;
}

.biz-image-container.is-expanded :deep(img) {
  border-radius: 0;
}

.biz-image-back-btn {
  position: absolute;
  top: 16px;
  left: 16px;
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background: rgba(0,0,0,0.4);
  color: white;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: opacity 0.3s ease;
  z-index: 10;
  backdrop-filter: blur(4px);
}

.biz-image-detail {
  background: transparent;
  flex: 1;
}
</style>
