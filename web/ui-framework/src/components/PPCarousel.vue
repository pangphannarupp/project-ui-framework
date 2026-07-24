<template>
  <div 
    class="pp-carousel-container" 
    :class="[`is-${variant}`]"
    @mouseenter="onMouseEnter" 
    @mouseleave="onMouseLeave"
    :style="cssVars"
  >
    <!-- Arrow Prev -->
    <button 
      v-if="showArrows && variant !== 'story' && variant !== 'reel'" 
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
      v-if="showArrows && variant !== 'story' && variant !== 'reel'" 
      class="pp-carousel-arrow is-next" 
      @click="next"
      aria-label="Next Slide"
    >
      <svg viewBox="0 0 24 24" width="24" height="24" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><polyline points="9 18 15 12 9 6"></polyline></svg>
    </button>

    <!-- Story Progress Bars -->
    <div v-if="variant === 'story' && totalDots > 1" class="pp-carousel-story-bars">
      <div 
        v-for="index in totalDots" 
        :key="`story-${index}`"
        class="pp-carousel-story-bar-bg"
        @click="goTo(index - 1)"
      >
        <div 
          class="pp-carousel-story-bar-fill"
          :class="{
            'is-completed': (index - 1) < activeIndex,
            'is-active': (index - 1) === activeIndex && autoplay
          }"
        ></div>
      </div>
    </div>

    <!-- Story Navigation Zones -->
    <div v-if="variant === 'story'" class="pp-carousel-story-nav">
      <div class="story-nav-left" @click="prev"></div>
      <div class="story-nav-right" @click="next"></div>
    </div>

    <!-- Dots Pagination -->
    <div v-if="showDots && variant !== 'story' && totalDots > 1" class="pp-carousel-dots">
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
  },
  variant: {
    type: String,
    default: 'standard' // 'standard', 'story', 'reel'
  }
});

provide('ppCarouselContext', {
  itemsPerView: computed(() => props.itemsPerView),
  gap: computed(() => props.gap),
  variant: computed(() => props.variant)
});

const trackRef = ref<HTMLElement | null>(null);
const activeIndex = ref(0);
const totalItems = ref(0);

const cssVars = computed(() => {
  return {
    '--carousel-gap': props.gap,
    '--carousel-items': props.itemsPerView,
    '--carousel-interval': `${props.interval}ms`
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
    const isReel = props.variant === 'reel';
    const { scrollLeft, scrollTop, clientWidth, clientHeight } = trackRef.value;
    const scrollPos = isReel ? scrollTop : scrollLeft;
    const clientSize = isReel ? clientHeight : clientWidth;
    const index = Math.round(scrollPos / clientSize);
    activeIndex.value = index;
  }, 100);
};

const next = () => {
  if (!trackRef.value) return;
  const isReel = props.variant === 'reel';
  const { scrollLeft, scrollTop, clientWidth, clientHeight, scrollWidth, scrollHeight } = trackRef.value;
  
  const scrollPos = isReel ? scrollTop : scrollLeft;
  const clientSize = isReel ? clientHeight : clientWidth;
  const scrollSize = isReel ? scrollHeight : scrollWidth;
  
  const maxScroll = scrollSize - clientSize;
  if (scrollPos >= maxScroll - 10) {
    if (props.loop) {
      trackRef.value.scrollTo({ 
        left: isReel ? 0 : 0, 
        top: isReel ? 0 : 0, 
        behavior: 'smooth' 
      });
    }
  } else {
    trackRef.value.scrollBy({ 
      left: isReel ? 0 : clientSize, 
      top: isReel ? clientSize : 0, 
      behavior: 'smooth' 
    });
  }
};

const prev = () => {
  if (!trackRef.value) return;
  const isReel = props.variant === 'reel';
  const { scrollLeft, scrollTop, clientWidth, clientHeight, scrollWidth, scrollHeight } = trackRef.value;
  
  const scrollPos = isReel ? scrollTop : scrollLeft;
  const clientSize = isReel ? clientHeight : clientWidth;
  const scrollSize = isReel ? scrollHeight : scrollWidth;
  
  if (scrollPos <= 10) {
    if (props.loop) {
      trackRef.value.scrollTo({ 
        left: isReel ? 0 : scrollSize, 
        top: isReel ? scrollSize : 0, 
        behavior: 'smooth' 
      });
    }
  } else {
    trackRef.value.scrollBy({ 
      left: isReel ? 0 : -clientSize, 
      top: isReel ? -clientSize : 0, 
      behavior: 'smooth' 
    });
  }
};

const goTo = (index: number) => {
  if (!trackRef.value) return;
  const isReel = props.variant === 'reel';
  const { clientWidth, clientHeight } = trackRef.value;
  trackRef.value.scrollTo({ 
    left: isReel ? 0 : index * clientWidth, 
    top: isReel ? index * clientHeight : 0,
    behavior: 'smooth' 
  });
};

// Manual Drag logic (Mouse)
const isDragging = ref(false);
let startX = 0;
let scrollLeftStart = 0;

const onMouseDown = (e: MouseEvent) => {
  isDragging.value = true;
  if (trackRef.value) {
    const isReel = props.variant === 'reel';
    trackRef.value.style.scrollSnapType = 'none'; // Disable snap during drag
    trackRef.value.style.scrollBehavior = 'auto';
    startX = isReel ? (e.pageY - trackRef.value.offsetTop) : (e.pageX - trackRef.value.offsetLeft);
    scrollLeftStart = isReel ? trackRef.value.scrollTop : trackRef.value.scrollLeft;
  }
  stopAutoplay();
};

const onMouseMove = (e: MouseEvent) => {
  if (!isDragging.value || !trackRef.value) return;
  e.preventDefault();
  const isReel = props.variant === 'reel';
  const x = isReel ? (e.pageY - trackRef.value.offsetTop) : (e.pageX - trackRef.value.offsetLeft);
  const walk = (x - startX) * 2; // scroll-fast multiplier
  if (isReel) {
    trackRef.value.scrollTop = scrollLeftStart - walk;
  } else {
    trackRef.value.scrollLeft = scrollLeftStart - walk;
  }
};

const onMouseUp = () => {
  if (!isDragging.value) return;
  isDragging.value = false;
  if (trackRef.value) {
    const isReel = props.variant === 'reel';
    trackRef.value.style.scrollSnapType = isReel ? 'y mandatory' : 'x mandatory';
    trackRef.value.style.scrollBehavior = 'smooth';
    // Small nudge to trigger snapping
    trackRef.value.scrollBy({ left: isReel ? 0 : 1, top: isReel ? 1 : 0, behavior: 'smooth' });
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

/* Reel Variant */
.pp-carousel-container.is-reel {
  height: 100%;
}
.pp-carousel-container.is-reel .pp-carousel-track {
  flex-direction: column;
  overflow-y: auto;
  overflow-x: hidden;
  scroll-snap-type: y mandatory;
}

/* Story Nav Zones */
.pp-carousel-story-nav {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  display: flex;
  z-index: 5;
  pointer-events: none;
}
.story-nav-left, .story-nav-right {
  flex: 1;
  pointer-events: auto;
  cursor: pointer;
}

/* Story Progress Bars */
.pp-carousel-story-bars {
  position: absolute;
  top: 8px;
  left: 8px;
  right: 8px;
  display: flex;
  gap: 4px;
  z-index: 10;
}
.pp-carousel-story-bar-bg {
  flex: 1;
  height: 4px;
  background: rgba(255, 255, 255, 0.4);
  border-radius: 2px;
  overflow: hidden;
  cursor: pointer;
}
.pp-carousel-story-bar-fill {
  height: 100%;
  width: 0%;
  background: white;
  border-radius: 2px;
}
.pp-carousel-story-bar-fill.is-completed {
  width: 100%;
}
.pp-carousel-story-bar-fill.is-active {
  width: 100%;
  transition: width var(--carousel-interval) linear;
}
</style>
