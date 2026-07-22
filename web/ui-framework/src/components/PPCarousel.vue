<template>
  <div 
    class="pp-carousel-container" 
    @mouseenter="onMouseEnter" 
    @mouseleave="onMouseLeave"
    :style="cssVars"
  >
    <!-- Arrow Prev -->
    <button 
      v-if="showArrows" 
      class="pp-carousel-arrow is-prev" 
      @click="prev"
      aria-label="Previous Slide"
    >
      <svg viewBox="0 0 24 24" width="24" height="24" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><polyline points="15 18 9 12 15 6"></polyline></svg>
    </button>

    <!-- Track -->
    <div 
      ref="trackRef" 
      class="pp-carousel-track" 
      @scroll="onScroll"
      @mousedown="onMouseDown"
      @mousemove="onMouseMove"
      @mouseup="onMouseUp"
      @mouseleave="onMouseUp"
    >
      <slot></slot>
    </div>

    <!-- Arrow Next -->
    <button 
      v-if="showArrows" 
      class="pp-carousel-arrow is-next" 
      @click="next"
      aria-label="Next Slide"
    >
      <svg viewBox="0 0 24 24" width="24" height="24" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><polyline points="9 18 15 12 9 6"></polyline></svg>
    </button>

    <!-- Dots Pagination -->
    <div v-if="showDots && totalDots > 1" class="pp-carousel-dots">
      <button 
        v-for="index in totalDots" 
        :key="index"
        class="pp-carousel-dot"
        :class="{ 'is-active': activeIndex === (index - 1) }"
        @click="goTo(index - 1)"
        :aria-label="`Go to slide ${index}`"
      ></button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted, onUnmounted, provide } from 'vue';

const props = defineProps({
  autoplay: {
    type: Boolean,
    default: false
  },
  interval: {
    type: Number,
    default: 3000
  },
  showArrows: {
    type: Boolean,
    default: true
  },
  showDots: {
    type: Boolean,
    default: true
  },
  itemsPerView: {
    type: Number,
    default: 1
  },
  gap: {
    type: String,
    default: '16px'
  },
  loop: {
    type: Boolean,
    default: false
  }
});

provide('bizCarouselContext', {
  itemsPerView: computed(() => props.itemsPerView),
  gap: computed(() => props.gap)
});

const trackRef = ref<HTMLElement | null>(null);
const activeIndex = ref(0);
const totalItems = ref(0);

const cssVars = computed(() => {
  return {
    '--carousel-gap': props.gap,
    '--carousel-items': props.itemsPerView
  };
});

const totalDots = computed(() => {
  if (totalItems.value <= props.itemsPerView) return 0;
  return Math.ceil(totalItems.value / props.itemsPerView);
});

// Autoplay logic
let autoplayTimer: number | null = null;
let isHovered = false;

const startAutoplay = () => {
  if (props.autoplay && !autoplayTimer && !isHovered) {
    autoplayTimer = window.setInterval(() => {
      next();
    }, props.interval);
  }
};

const stopAutoplay = () => {
  if (autoplayTimer) {
    window.clearInterval(autoplayTimer);
    autoplayTimer = null;
  }
};

const onMouseEnter = () => {
  isHovered = true;
  stopAutoplay();
};

const onMouseLeave = () => {
  isHovered = false;
  if (!isDragging.value) {
    startAutoplay();
  }
};

// Scroll and Navigation logic
let scrollTimeout: number | null = null;

const onScroll = () => {
  if (!trackRef.value) return;
  
  if (scrollTimeout) window.clearTimeout(scrollTimeout);
  
  scrollTimeout = window.setTimeout(() => {
    if (!trackRef.value) return;
    const { scrollLeft, clientWidth } = trackRef.value;
    const index = Math.round(scrollLeft / clientWidth);
    activeIndex.value = index;
  }, 100);
};

const next = () => {
  if (!trackRef.value) return;
  const { scrollLeft, clientWidth, scrollWidth } = trackRef.value;
  
  const maxScroll = scrollWidth - clientWidth;
  if (scrollLeft >= maxScroll - 10) {
    if (props.loop) {
      trackRef.value.scrollTo({ left: 0, behavior: 'smooth' });
    }
  } else {
    trackRef.value.scrollBy({ left: clientWidth, behavior: 'smooth' });
  }
};

const prev = () => {
  if (!trackRef.value) return;
  const { scrollLeft, clientWidth, scrollWidth } = trackRef.value;
  
  if (scrollLeft <= 10) {
    if (props.loop) {
      trackRef.value.scrollTo({ left: scrollWidth, behavior: 'smooth' });
    }
  } else {
    trackRef.value.scrollBy({ left: -clientWidth, behavior: 'smooth' });
  }
};

const goTo = (index: number) => {
  if (!trackRef.value) return;
  const { clientWidth } = trackRef.value;
  trackRef.value.scrollTo({ left: index * clientWidth, behavior: 'smooth' });
};

// Manual Drag logic (Mouse)
const isDragging = ref(false);
let startX = 0;
let scrollLeftStart = 0;

const onMouseDown = (e: MouseEvent) => {
  isDragging.value = true;
  if (trackRef.value) {
    trackRef.value.style.scrollSnapType = 'none'; // Disable snap during drag
    trackRef.value.style.scrollBehavior = 'auto';
    startX = e.pageX - trackRef.value.offsetLeft;
    scrollLeftStart = trackRef.value.scrollLeft;
  }
  stopAutoplay();
};

const onMouseMove = (e: MouseEvent) => {
  if (!isDragging.value || !trackRef.value) return;
  e.preventDefault();
  const x = e.pageX - trackRef.value.offsetLeft;
  const walk = (x - startX) * 2; // scroll-fast multiplier
  trackRef.value.scrollLeft = scrollLeftStart - walk;
};

const onMouseUp = () => {
  if (!isDragging.value) return;
  isDragging.value = false;
  if (trackRef.value) {
    trackRef.value.style.scrollSnapType = 'x mandatory';
    trackRef.value.style.scrollBehavior = 'smooth';
    // Small nudge to trigger snapping
    trackRef.value.scrollBy({ left: 1, behavior: 'smooth' });
  }
  if (!isHovered) startAutoplay();
};

onMounted(() => {
  if (trackRef.value) {
    // Count items by looking at children that are not text nodes
    totalItems.value = trackRef.value.children.length;
    
    // Set up MutationObserver to watch for dynamic slot changes
    const observer = new MutationObserver(() => {
      if (trackRef.value) {
        totalItems.value = trackRef.value.children.length;
      }
    });
    observer.observe(trackRef.value, { childList: true });
  }
  
  startAutoplay();
});

onUnmounted(() => {
  stopAutoplay();
});
</script>

<style scoped>
.pp-carousel-container {
  position: relative;
  width: 100%;
  display: flex;
  flex-direction: column;
}

.pp-carousel-track {
  display: flex;
  overflow-x: auto;
  scroll-snap-type: x mandatory;
  scroll-behavior: smooth;
  gap: var(--carousel-gap, 16px);
  -webkit-overflow-scrolling: touch;
  /* Hide scrollbar */
  scrollbar-width: none; /* Firefox */
}
.pp-carousel-track::-webkit-scrollbar {
  display: none; /* Safari and Chrome */
}

/* Arrows */
.pp-carousel-arrow {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
  z-index: 10;
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.9);
  border: 1px solid #eaeaea;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  color: #333;
  transition: all 0.2s ease;
}

.pp-carousel-arrow:hover {
  background: #ffffff;
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.15);
  color: #003399;
}

.pp-carousel-arrow.is-prev {
  left: 16px;
}
.pp-carousel-arrow.is-next {
  right: 16px;
}

/* Dots */
.pp-carousel-dots {
  display: flex;
  justify-content: center;
  gap: 8px;
  margin-top: 16px;
}

.pp-carousel-dot {
  width: 8px;
  height: 8px;
  border-radius: 50%;
  background: #d1d5db;
  border: none;
  padding: 0;
  cursor: pointer;
  transition: all 0.3s ease;
}

.pp-carousel-dot.is-active {
  background: #003399;
  width: 24px;
  border-radius: 4px;
}
</style>
