<template>
  <div 
    class="biz-skeleton-item" 
    :class="[`variant-${variant}`]"
    :style="computedStyle"
  ></div>
</template>

<script setup lang="ts">
import { computed } from 'vue';

const props = withDefaults(defineProps<{
  variant?: 'text' | 'rect' | 'circle' | 'image';
  width?: string;
  height?: string;
}>(), {
  variant: 'text'
});

const computedStyle = computed(() => {
  const style: Record<string, string> = {};
  if (props.width) style.width = props.width;
  if (props.height) style.height = props.height;
  return style;
});
</script>

<style scoped>
.biz-skeleton-item {
  background: #f0f0f0; /* Fallback without animation */
  flex-shrink: 0;
}

.variant-text {
  width: 100%;
  height: 16px;
  border-radius: 4px;
}

.variant-rect {
  width: 100%;
  height: 100%;
  border-radius: 8px;
}

.variant-circle {
  border-radius: 50%;
  width: 48px;
  height: 48px;
}

.variant-image {
  width: 100%;
  height: 200px;
  border-radius: 0;
}
</style>
