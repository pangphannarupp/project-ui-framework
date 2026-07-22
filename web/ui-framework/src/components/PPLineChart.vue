<template>
  <div class="pp-line-chart" :style="{ height: height + 'px' }">
    <div class="svg-container">
      <svg viewBox="0 0 100 100" preserveAspectRatio="none" width="100%" height="100%">
        <defs>
          <linearGradient :id="'line-grad-' + chartId" x1="0%" y1="0%" x2="100%" y2="0%">
            <stop offset="0%" :stop-color="gradient ? gradient[0] : color" />
            <stop offset="100%" :stop-color="gradient ? gradient[1] : color" />
          </linearGradient>
          <linearGradient :id="'area-grad-' + chartId" x1="0%" y1="0%" x2="0%" y2="100%">
            <stop offset="0%" :stop-color="fillColor" stop-opacity="0.6" />
            <stop offset="100%" :stop-color="fillColor" stop-opacity="0.0" />
          </linearGradient>
        </defs>
        
        <!-- Grid lines -->
        <template v-if="showGrid">
          <line v-for="n in 5" :key="'grid-'+n" x1="0" :y1="(100/4)*(n-1)" x2="100" :y2="(100/4)*(n-1)" stroke="#f0f0f0" stroke-width="0.5" :stroke-dasharray="dashedGrid ? '2,2' : 'none'" />
        </template>
        
        <!-- Area fill -->
        <path v-if="fillArea" :d="areaPath" :fill="`url(#area-grad-${chartId})`" />
        
        <!-- Line -->
        <path 
          :d="linePath" 
          :stroke="gradient ? `url(#line-grad-${chartId})` : color" 
          :stroke-width="strokeWidth" 
          fill="none" 
          class="line-path" 
          stroke-linejoin="round" 
          stroke-linecap="round"
          :stroke-dasharray="dashed ? '3,3' : 'none'"
        />
      </svg>
      
      <!-- Data points -->
      <template v-if="showPoints">
        <div 
          v-for="(p, i) in points"
          :key="'pt-'+i"
          class="data-point"
          :style="{ 
            left: `${p.x}%`, 
            top: `${p.y}%`, 
            backgroundColor: pointColor || color,
            width: pointSize + 'px',
            height: pointSize + 'px'
          }"
        ></div>
      </template>
    </div>
    
    <!-- X Axis labels -->
    <div class="x-axis" v-if="labels && labels.length">
      <div v-for="(l, i) in labels" :key="i" class="x-label" :style="{ left: `${(i / Math.max(1, labels.length - 1)) * 100}%` }">
        {{ l }}
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue';

const props = withDefaults(defineProps<{
  data: number[];
  labels?: string[];
  height?: number;
  color?: string;
  gradient?: [string, string];
  fillColor?: string;
  fillArea?: boolean;
  strokeWidth?: number;
  smooth?: boolean;
  dashed?: boolean;
  showPoints?: boolean;
  pointSize?: number;
  pointColor?: string;
  showGrid?: boolean;
  dashedGrid?: boolean;
}>(), {
  height: 240,
  color: 'var(--pp-primary-light, #3880ff)',
  fillColor: 'var(--pp-primary-light, #3880ff)',
  fillArea: true,
  strokeWidth: 2,
  smooth: true,
  dashed: false,
  showPoints: true,
  pointSize: 8,
  showGrid: true,
  dashedGrid: false
});

const chartId = Math.random().toString(36).substring(2, 9);

const points = computed(() => {
  const max = Math.max(...props.data, 0.001);
  const min = Math.min(...props.data, 0);
  const range = max - min;
  
  return props.data.map((val, i) => {
    const x = props.data.length > 1 ? (i / (props.data.length - 1)) * 100 : 50;
    const y = 100 - (((val - min) / range) * 100);
    const paddedY = 5 + (y * 0.9);
    return { x, y: paddedY, val };
  });
});

const linePath = computed(() => {
  if (points.value.length === 0) return '';
  if (points.value.length === 1) return `M0,${points.value[0].y} L100,${points.value[0].y}`;
  
  let path = `M ${points.value[0].x} ${points.value[0].y}`;
  
  if (props.smooth) {
    for (let i = 0; i < points.value.length - 1; i++) {
      const curr = points.value[i];
      const next = points.value[i + 1];
      const cpX = (curr.x + next.x) / 2;
      path += ` C ${cpX} ${curr.y}, ${cpX} ${next.y}, ${next.x} ${next.y}`;
    }
  } else {
    for (let i = 1; i < points.value.length; i++) {
      path += ` L ${points.value[i].x} ${points.value[i].y}`;
    }
  }
  return path;
});

const areaPath = computed(() => {
  if (!linePath.value) return '';
  return `${linePath.value} L 100 100 L 0 100 Z`;
});
</script>

<style scoped>
.pp-line-chart {
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

.line-path {
  animation: dash 1.5s ease-out forwards;
}

@keyframes dash {
  from {
    stroke-dasharray: 400;
    stroke-dashoffset: 400;
  }
  to {
    stroke-dasharray: 400;
    stroke-dashoffset: 0;
  }
}

.data-point {
  position: absolute;
  border-radius: 50%;
  border: 2px solid white;
  transform: translate(-50%, -50%);
  box-shadow: 0 1px 3px rgba(0,0,0,0.1);
  z-index: 2;
}

.x-axis {
  position: relative;
  height: 24px;
  width: 100%;
  margin-top: 8px;
}

.x-label {
  position: absolute;
  transform: translateX(-50%);
  font-size: 12px;
  color: #999;
  white-space: nowrap;
}
</style>
