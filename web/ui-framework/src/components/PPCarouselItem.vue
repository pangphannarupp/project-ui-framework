<template>
  <div class="pp-carousel-item" :style="itemStyle">
    <slot></slot>
  </div>
</template>

<script setup lang="ts">
import { computed, inject } from 'vue';

const context = inject('bizCarouselContext', {
  itemsPerView: { value: 1 },
  gap: { value: '16px' }
}) as any;

const itemStyle = computed(() => {
  const itemsPerView = context.itemsPerView.value;
  const gap = context.gap.value;
  
  if (itemsPerView === 1) {
    return {
      flex: '0 0 100%',
      minWidth: '100%'
    };
  }
  
  // Calculate width taking gap into account
  // width = (100% - (gap * (itemsPerView - 1))) / itemsPerView
  return {
    flex: `0 0 calc((100% - (${gap} * ${itemsPerView - 1})) / ${itemsPerView})`,
    minWidth: `calc((100% - (${gap} * ${itemsPerView - 1})) / ${itemsPerView})`
  };
});
</script>

<style scoped>
.pp-carousel-item {
  scroll-snap-align: start;
  /* Ensure children don't overflow inappropriately */
  box-sizing: border-box;
}
</style>
