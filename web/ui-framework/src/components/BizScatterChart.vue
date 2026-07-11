<template>
  <div class="biz-scatter-chart" :style="{ height: height + 'px' }">
    <div class="svg-container">
      <!-- Grid lines via SVG -->
      <svg viewBox="0 0 100 100" preserveAspectRatio="none" width="100%" height="100%">
        <template v-if="showGrid">
          <line v-for="n in 5" :key="'grid-y-'+n" x1="0" :y1="(100/4)*(n-1)" x2="100" :y2="(100/4)*(n-1)" stroke="#f0f0f0" stroke-width="0.5" />
          <line v-for="n in 5" :key="'grid-x-'+n" :x1="(100/4)*(n-1)" y1="0" :x2="(100/4)*(n-1)" y2="100" stroke="#f0f0f0" stroke-width="0.5" />
        </template>
      </svg>
      
      <!-- Data points (overlay as divs to prevent aspect ratio warping) -->
      <div 
        v-for="(p, i) in points"
        :key="'pt-'+i"
        class="scatter-point"
        :style="{ 
          left: `${p.posX}%`, 
          top: `${p.posY}%`, 
          backgroundColor: p.color || color,
          width: (p.r || defaultRadius) * 2 + 'px',
          height: (p.r || defaultRadius) * 2 + 'px',
          opacity: 0.8
        }"
      ></div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue';

export interface BizScatterData {
  x: number;
  y: number;
  r?: number;
  color?: string;
  label?: string;
}

const props = withDefaults(defineProps<{
  data: BizScatterData[];
  height?: number;
  color?: string;
  defaultRadius?: number;
  showGrid?: boolean;
  maxX?: number;
  maxY?: number;
}>(), {
  height: 240,
  color: 'var(--biz-primary-light, #3880ff)',
  defaultRadius: 6,
  showGrid: true
});

const points = computed(() => {
  if (!props.data || props.data.length === 0) return [];
  
  const computedMaxX = props.maxX || Math.max(...props.data.map(d => d.x), 0.001);
  const computedMaxY = props.maxY || Math.max(...props.data.map(d => d.y), 0.001);
  
  return props.data.map((d) => {
    // Map X and Y to 0-100 percentage
    // Y is inverted because top is 0%
    // We add a 5% padding so points don't clip outside the edges
    const posX = 5 + ((d.x / computedMaxX) * 90);
    const posY = 95 - ((d.y / computedMaxY) * 90);
    
    return { ...d, posX, posY };
  });
});
</script>

<style scoped>
.biz-scatter-chart {
  width: 100%;
  position: relative;
  display: flex;
  flex-direction: column;
}

.svg-container {
  position: relative;
  flex: 1;
  width: 100%;
}

.scatter-point {
  position: absolute;
  border-radius: 50%;
  border: 1px solid rgba(255,255,255,0.5);
  transform: translate(-50%, -50%);
  box-shadow: 0 1px 4px rgba(0,0,0,0.15);
  z-index: 2;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  animation: pop-in 0.6s cubic-bezier(0.34, 1.56, 0.64, 1) backwards;
}

.scatter-point:hover {
  transform: translate(-50%, -50%) scale(1.2);
  opacity: 1 !important;
  z-index: 10;
}

@keyframes pop-in {
  from { transform: translate(-50%, -50%) scale(0); opacity: 0; }
  to { transform: translate(-50%, -50%) scale(1); opacity: 0.8; }
}
</style>
