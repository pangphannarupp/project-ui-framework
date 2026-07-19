<template>
  <div 
    class="biz-marquee-container" 
    :class="{ 
      'is-vertical': vertical,
      'has-fade': fade,
      'pause-on-hover': pauseOnHover
    }"
  >
    <div 
      class="biz-marquee-track"
      :class="`dir-${direction}`"
      :style="{ '--marquee-duration': duration }"
    >
      <div class="biz-marquee-content">
        <slot></slot>
      </div>
      <!-- Duplicate content for seamless looping -->
      <div class="biz-marquee-content" aria-hidden="true">
        <slot></slot>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { PropType } from 'vue';

defineProps({
  direction: {
    type: String as PropType<'left' | 'right' | 'up' | 'down'>,
    default: 'left',
    validator: (value: string) => ['left', 'right', 'up', 'down'].includes(value)
  },
  duration: {
    type: String,
    default: '30s'
  },
  pauseOnHover: {
    type: Boolean,
    default: true
  },
  fade: {
    type: Boolean,
    default: false
  },
  vertical: {
    type: Boolean,
    default: false
  }
});
</script>

<style scoped>
.biz-marquee-container {
  overflow: hidden;
  position: relative;
  display: flex;
  width: 100%;
}

.biz-marquee-container.is-vertical {
  height: 100%;
  flex-direction: column;
}

/* Fade effects */
.biz-marquee-container.has-fade:not(.is-vertical) {
  mask-image: linear-gradient(to right, transparent, black 10%, black 90%, transparent);
  -webkit-mask-image: linear-gradient(to right, transparent, black 10%, black 90%, transparent);
}

.biz-marquee-container.has-fade.is-vertical {
  mask-image: linear-gradient(to bottom, transparent, black 10%, black 90%, transparent);
  -webkit-mask-image: linear-gradient(to bottom, transparent, black 10%, black 90%, transparent);
}

.biz-marquee-track {
  display: flex;
  flex: 0 0 auto;
  min-width: 100%;
  /* Fallback in case var isn't set somehow */
  animation-duration: var(--marquee-duration, 30s);
  animation-timing-function: linear;
  animation-iteration-count: infinite;
}

.biz-marquee-container.is-vertical .biz-marquee-track {
  flex-direction: column;
  min-height: 100%;
}

.biz-marquee-content {
  display: flex;
  flex: 0 0 auto;
  min-width: 100%;
}

.biz-marquee-container.is-vertical .biz-marquee-content {
  flex-direction: column;
  min-height: 100%;
}

/* Pause on hover */
.biz-marquee-container.pause-on-hover:hover .biz-marquee-track {
  animation-play-state: paused;
}

/* Animations */
.biz-marquee-track.dir-left {
  animation-name: marquee-horizontal;
}
.biz-marquee-track.dir-right {
  animation-name: marquee-horizontal-reverse;
}
.biz-marquee-track.dir-up {
  animation-name: marquee-vertical;
}
.biz-marquee-track.dir-down {
  animation-name: marquee-vertical-reverse;
}

@keyframes marquee-horizontal {
  0% { transform: translateX(0); }
  100% { transform: translateX(-50%); }
}

@keyframes marquee-horizontal-reverse {
  0% { transform: translateX(-50%); }
  100% { transform: translateX(0); }
}

@keyframes marquee-vertical {
  0% { transform: translateY(0); }
  100% { transform: translateY(-50%); }
}

@keyframes marquee-vertical-reverse {
  0% { transform: translateY(-50%); }
  100% { transform: translateY(0); }
}
</style>
