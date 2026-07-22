<template>
  <div class="pp-pie-chart" :style="{ width: size + 'px', height: size + 'px' }">
    <svg viewBox="0 0 100 100" width="100%" height="100%">
      <path 
        v-for="(seg, index) in segments" 
        :key="index"
        :d="seg.path"
        :fill="seg.color"
        class="pie-slice"
      />
    </svg>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue';

export interface PPPieSegment {
  value: number;
  color: string;
}

const props = withDefaults(defineProps<{
  data: PPPieSegment[];
  size?: number;
}>(), {
  size: 200
});

const getCoordinatesForPercent = (percent: number) => {
  const x = Math.cos(2 * Math.PI * percent) * 50;
  const y = Math.sin(2 * Math.PI * percent) * 50;
  return { x, y };
};

const segments = computed(() => {
  const total = Math.max(props.data.reduce((sum, d) => sum + d.value, 0), 0.001);
  
  let cumulativePercent = 0;
  
  return props.data.map(d => {
    const percent = d.value / total;
    
    // If it's exactly 100%, render a circle
    if (percent === 1) {
      return {
        color: d.color,
        path: `M 50,50 m -50,0 a 50,50 0 1,0 100,0 a 50,50 0 1,0 -100,0`
      };
    }
    
    // Start coordinate
    const startX = getCoordinatesForPercent(cumulativePercent).x + 50;
    const startY = getCoordinatesForPercent(cumulativePercent).y + 50;
    
    cumulativePercent += percent;
    
    // End coordinate
    const endX = getCoordinatesForPercent(cumulativePercent).x + 50;
    const endY = getCoordinatesForPercent(cumulativePercent).y + 50;
    
    // Large arc flag
    const largeArcFlag = percent > 0.5 ? 1 : 0;
    
    // Path (M: move to center, L: line to start, A: arc to end, Z: close path)
    const path = `M 50 50 L ${startX} ${startY} A 50 50 0 ${largeArcFlag} 1 ${endX} ${endY} Z`;
    
    return {
      color: d.color,
      path
    };
  });
});
</script>

<style scoped>
.pp-pie-chart {
  display: inline-block;
}

.pie-slice {
  transition: all 0.3s ease;
  stroke: #ffffff;
  stroke-width: 1;
}

.pie-slice:hover {
  transform: scale(1.02);
  transform-origin: 50% 50%;
  cursor: pointer;
}
</style>
