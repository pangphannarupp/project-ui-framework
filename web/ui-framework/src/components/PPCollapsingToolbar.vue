<template>
  <div class="pp-collapsing-wrapper">
    <!-- Header Layer -->
    <div 
      class="pp-collapsing-header"
      :style="{
        height: `calc(${currentHeight}px + var(--ion-safe-area-top, 0px))`
      }"
    >
      <!-- Background (fades out as it shrinks) -->
      <div 
        class="pp-collapsing-bg"
        :style="{ opacity: progress }"
      >
        <slot name="background"></slot>
      </div>

    </div>

    <!-- Scrollable Content -->
    <div 
      class="pp-collapsing-content"
      @scroll="onScroll"
      ref="scrollArea"
    >
      <div class="pp-collapsing-spacer" :style="{ height: `calc(${expandedHeight}px + var(--ion-safe-area-top, 0px))` }"></div>
      <div class="pp-collapsing-inner-content">
        <slot></slot>
      </div>
    </div>

    <!-- Toolbar Layer (always at top) -->
    <div 
      class="pp-collapsing-toolbar"
      :style="{ 
        height: `calc(${collapsedHeight}px + var(--ion-safe-area-top, 0px))`,
        paddingTop: `var(--ion-safe-area-top, 0px)`
      }"
    >
      <div class="pp-toolbar-start">
        <slot name="start"></slot>
      </div>
      
      <!-- Profile moving and shrinking -->
      <div 
        v-if="$slots.profile"
        class="pp-collapsing-profile"
        :style="{
          transform: `translate(${profileX}px, ${profileY}px) scale(${profileScale})`,
        }"
      >
        <slot name="profile"></slot>
      </div>

      <!-- Title moving and shrinking -->
      <div 
        class="pp-collapsing-title"
        :style="titleStyle"
      >
        <slot name="title">{{ title }}</slot>
      </div>

      <div class="pp-toolbar-end">
        <slot name="end"></slot>
      </div>
    </div>

  </div>
</template>

<script setup lang="ts">
import { ref, computed, useSlots } from 'vue';

const props = withDefaults(defineProps<{
  title?: string;
  expandedHeight?: number;
  collapsedHeight?: number;
  centerTitleOnCollapse?: boolean;
}>(), {
  title: '',
  expandedHeight: 250,
  collapsedHeight: 56,
  centerTitleOnCollapse: false
});

const slots = useSlots();
const hasProfile = computed(() => !!slots.profile);

const scrollArea = ref<HTMLElement | null>(null);
const scrollTop = ref(0);

const onScroll = (e: Event) => {
  const target = e.target as HTMLElement;
  scrollTop.value = target.scrollTop;
};

const currentHeight = computed(() => {
  return Math.max(props.expandedHeight - scrollTop.value, props.collapsedHeight);
});

// 1.0 when fully expanded, 0.0 when fully collapsed
const progress = computed(() => {
  const range = props.expandedHeight - props.collapsedHeight;
  if (range <= 0) return 0;
  const currentRange = currentHeight.value - props.collapsedHeight;
  return Math.max(0, Math.min(1, currentRange / range));
});

// Profile Animation Logic
const profileScale = computed(() => {
  return 1 + (1.5 * progress.value); // Scale from 2.5 to 1.0
});

const profileY = computed(() => {
  // Starts higher above the title when expanded to prevent overlap with large scaled image
  // We want it right above the title, not at the top of the header!
  const expandedY = props.expandedHeight - props.collapsedHeight - 64; 
  const collapsedY = 0;
  return collapsedY + (expandedY * progress.value);
});

const profileX = computed(() => {
  const expandedX = -40; // Align with title at the left edge
  const collapsedX = 0;
  return collapsedX + ((expandedX - collapsedX) * progress.value);
});

// Title Animation Logic
const titleScale = computed(() => {
  return 1 + (0.5 * progress.value);
});

const titleY = computed(() => {
  const expandedY = props.expandedHeight - props.collapsedHeight;
  const collapsedY = 0;
  return collapsedY + (expandedY * progress.value);
});

const titleX = computed(() => {
  // When expanded (progress=1), we want it at the far left edge (e.g. 16px total)
  // Since CSS left is 56px, we need an offset of -40px to reach 16px.
  const expandedX = -40;
  // If we have a profile, we need to leave room for it when collapsed.
  const collapsedX = hasProfile.value ? 44 : 0;
  return collapsedX + ((expandedX - collapsedX) * progress.value);
});

const titleStyle = computed(() => {
  if (props.centerTitleOnCollapse) {
    // When expanded (progress=1), left is 16px.
    // When collapsed (progress=0), left is 50%.
    return {
      left: `calc(16px * ${progress.value} + 50% * ${1 - progress.value})`,
      transform: `translate(calc(-50% * ${1 - progress.value}), ${titleY.value}px) scale(${titleScale.value})`,
      transformOrigin: `calc(0% + 50% * ${1 - progress.value}) center`
    };
  }
  return {
    transform: `translate(${titleX.value}px, ${titleY.value}px) scale(${titleScale.value})`
  };
});
</script>

<style scoped>
.pp-collapsing-wrapper {
  position: relative;
  width: 100%;
  height: 100%;
  overflow: hidden;
  display: flex;
  flex-direction: column;
  background-color: #f4f5f8;
}

.pp-collapsing-header {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  z-index: 1;
  background-color: var(--pp-primary-variant, #1a2a5e);
  color: #ffffff;
  overflow: hidden;
  will-change: height;
}

.pp-collapsing-bg {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  object-fit: cover;
  z-index: 1;
}

/* Ensure slotted images fill the background */
.pp-collapsing-bg :deep(img) {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.pp-collapsing-toolbar {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  display: flex;
  align-items: center;
  padding: 0 16px;
  z-index: 10;
  box-sizing: border-box;
}

.pp-toolbar-start {
  display: flex;
  align-items: center;
  margin-right: 16px;
  z-index: 3;
}

.pp-toolbar-end {
  display: flex;
  align-items: center;
  margin-left: auto;
  z-index: 3;
}

.pp-collapsing-profile {
  position: absolute;
  left: 56px; /* Align with back button offset */
  transform-origin: left center;
  will-change: transform;
  z-index: 2;
  display: flex;
  align-items: center;
}

.pp-collapsing-title {
  position: absolute;
  left: 56px; /* Offset for a typical back button */
  transform-origin: left center;
  font-size: 18px;
  font-weight: 600;
  white-space: nowrap;
  will-change: transform;
  z-index: 2;
}

.pp-collapsing-content {
  flex: 1;
  overflow-y: auto;
  overflow-x: hidden;
  z-index: 2;
  -webkit-overflow-scrolling: touch;
  position: relative;
}

.pp-collapsing-spacer {
  width: 100%;
  flex-shrink: 0;
}

.pp-collapsing-inner-content {
  position: relative;
  background-color: #ffffff;
  min-height: calc(100% - 56px); /* Fill remaining space if short */
  border-top-left-radius: 16px;
  border-top-right-radius: 16px;
  box-shadow: 0 -4px 10px rgba(0,0,0,0.05);
}
</style>
