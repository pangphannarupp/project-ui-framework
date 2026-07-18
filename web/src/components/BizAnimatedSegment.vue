<template>
  <div class="biz-animated-segment">
    <div class="segment-header">
      <BizSegment :modelValue="modelValue" @update:modelValue="handleChange">
        <BizSegmentButton v-for="seg in segments" :key="seg.value" :value="seg.value">
          {{ seg.label }}
        </BizSegmentButton>
      </BizSegment>
    </div>

    <div 
      class="segment-content-wrapper"
      @touchstart="handleTouchStart"
      @touchmove="handleTouchMove"
      @touchend="handleTouchEnd"
    >
      <transition :name="transitionName" mode="out-in">
        <div :key="modelValue" class="segment-content">
          <slot :name="`segment-${modelValue}`"></slot>
        </div>
      </transition>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, watch } from 'vue';
import { BizSegment, BizSegmentButton } from '@phanna/ui-framework';

const props = defineProps<{
  modelValue: string | number;
  segments: Array<{ label: string; value: string | number }>;
}>();

const emit = defineEmits(['update:modelValue']);

const transitionName = ref('slide-left');

const handleChange = (newVal: string | number) => {
  if (newVal === props.modelValue) return;
  
  const currentIndex = props.segments.findIndex(s => s.value === props.modelValue);
  const newIndex = props.segments.findIndex(s => s.value === newVal);
  
  if (currentIndex !== -1 && newIndex !== -1) {
    transitionName.value = newIndex > currentIndex ? 'slide-left' : 'slide-right';
  }
  
  emit('update:modelValue', newVal);
};

// Also listen for external v-model changes to animate properly
watch(() => props.modelValue, (newVal, oldVal) => {
  const currentIndex = props.segments.findIndex(s => s.value === oldVal);
  const newIndex = props.segments.findIndex(s => s.value === newVal);
  
  if (currentIndex !== -1 && newIndex !== -1 && currentIndex !== newIndex) {
    transitionName.value = newIndex > currentIndex ? 'slide-left' : 'slide-right';
  }
});

// Swipe Gestures
const touchStartX = ref(0);
const touchEndX = ref(0);
const minSwipeDistance = 50;

const handleTouchStart = (e: TouchEvent) => {
  touchStartX.value = e.changedTouches[0].screenX;
  touchEndX.value = e.changedTouches[0].screenX;
};

const handleTouchMove = (e: TouchEvent) => {
  touchEndX.value = e.changedTouches[0].screenX;
};

const handleTouchEnd = () => {
  const distance = touchEndX.value - touchStartX.value;
  
  if (Math.abs(distance) > minSwipeDistance) {
    const currentIndex = props.segments.findIndex(s => s.value === props.modelValue);
    
    if (distance > 0) {
      // Swiped right (move to previous segment)
      if (currentIndex > 0) {
        handleChange(props.segments[currentIndex - 1].value);
      }
    } else {
      // Swiped left (move to next segment)
      if (currentIndex < props.segments.length - 1) {
        handleChange(props.segments[currentIndex + 1].value);
      }
    }
  }
  
  // Reset values
  touchStartX.value = 0;
  touchEndX.value = 0;
};
</script>

<style scoped>
.biz-animated-segment {
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column;
  overflow: hidden;
  background: var(--ion-background-color, #ffffff);
}

.segment-header {
  padding: 16px;
  background: transparent;
  z-index: 10;
}

.segment-content-wrapper {
  flex: 1;
  position: relative;
  overflow-y: auto;
  overflow-x: hidden;
}

.segment-content {
  width: 100%;
  height: 100%;
}

/* Animations */
.slide-left-enter-active,
.slide-left-leave-active,
.slide-right-enter-active,
.slide-right-leave-active {
  transition: all 0.35s cubic-bezier(0.25, 0.8, 0.25, 1);
}

.slide-left-enter-from {
  opacity: 0;
  transform: translateX(40px);
}
.slide-left-leave-to {
  opacity: 0;
  transform: translateX(-40px);
}

.slide-right-enter-from {
  opacity: 0;
  transform: translateX(-40px);
}
.slide-right-leave-to {
  opacity: 0;
  transform: translateX(40px);
}
</style>
