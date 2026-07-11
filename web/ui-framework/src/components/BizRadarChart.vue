<template>
  <div class="biz-radar-chart" :style="{ width: size + 'px', height: size + 'px' }">
    <svg viewBox="0 0 100 100" width="100%" height="100%">
      <!-- Background Polygons (Grid) -->
      <polygon 
        v-for="level in levels" 
        :key="'grid-'+level"
        :points="getPolygonPoints(level / levels)"
        fill="transparent"
        stroke="#f0f0f0"
        stroke-width="0.5"
      />
      
      <!-- Axis Lines -->
      <line 
        v-for="(axis, i) in axes" 
        :key="'axis-'+i"
        x1="50"
        y1="50"
        :x2="axis.x"
        :y2="axis.y"
        stroke="#f0f0f0"
        stroke-width="0.5"
      />
      
      <!-- Data Polygon Fill -->
      <polygon 
        :points="dataPointsStr"
        :fill="color"
        opacity="0.3"
      />
      
      <!-- Data Polygon Stroke -->
      <polygon 
        :points="dataPointsStr"
        fill="none"
        :stroke="color"
        stroke-width="2"
        stroke-linejoin="round"
        class="radar-path"
      />
      
      <!-- Data Points -->
      <circle 
        v-for="(pt, i) in dataPoints"
        :key="'pt-'+i"
        :cx="pt.x"
        :cy="pt.y"
        r="2"
        :fill="color"
      />
    </svg>
    
    <!-- Labels (HTML overlay) -->
    <div class="radar-labels">
      <div 
        v-for="(lbl, i) in labels"
        :key="'lbl-'+i"
        class="radar-label"
        :style="getLabelStyle(i)"
      >
        {{ lbl }}
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue';

const props = withDefaults(defineProps<{
  data: number[];
  labels: string[];
  size?: number;
  color?: string;
  levels?: number;
}>(), {
  size: 240,
  color: 'var(--biz-primary-light, #3880ff)',
  levels: 4
});

const maxVal = computed(() => Math.max(...props.data, 0.001));

// Generate standard points for a radius factor (0 to 1)
const getPolygonPoints = (factor: number) => {
  return props.data.map((_, i) => {
    // -PI/2 so the first point is at the top (12 o'clock)
    const angle = (Math.PI * 2 * i / props.data.length) - (Math.PI / 2);
    const r = 40 * factor; // max radius is 40 to leave room for labels
    const x = 50 + r * Math.cos(angle);
    const y = 50 + r * Math.sin(angle);
    return `${x},${y}`;
  }).join(' ');
};

const axes = computed(() => {
  return props.data.map((_, i) => {
    const angle = (Math.PI * 2 * i / props.data.length) - (Math.PI / 2);
    const x = 50 + 40 * Math.cos(angle);
    const y = 50 + 40 * Math.sin(angle);
    return { x, y };
  });
});

const dataPoints = computed(() => {
  return props.data.map((val, i) => {
    const angle = (Math.PI * 2 * i / props.data.length) - (Math.PI / 2);
    const r = 40 * (val / maxVal.value);
    const x = 50 + r * Math.cos(angle);
    const y = 50 + r * Math.sin(angle);
    return { x, y, val };
  });
});

const dataPointsStr = computed(() => {
  return dataPoints.value.map(p => `${p.x},${p.y}`).join(' ');
});

const getLabelStyle = (i: number) => {
  const angle = (Math.PI * 2 * i / props.data.length) - (Math.PI / 2);
  const r = 48; // slightly further than the grid edge
  const x = 50 + r * Math.cos(angle);
  const y = 50 + r * Math.sin(angle);
  
  return {
    left: `${x}%`,
    top: `${y}%`,
    transform: 'translate(-50%, -50%)'
  };
};
</script>

<style scoped>
.biz-radar-chart {
  position: relative;
  display: inline-block;
}

.radar-labels {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  pointer-events: none;
}

.radar-label {
  position: absolute;
  font-size: 11px;
  color: #666;
  white-space: nowrap;
}

.radar-path {
  animation: fade-in 1s ease-out forwards;
}

@keyframes fade-in {
  from { opacity: 0; transform: scale(0.8); transform-origin: 50% 50%; }
  to { opacity: 1; transform: scale(1); transform-origin: 50% 50%; }
}
</style>
