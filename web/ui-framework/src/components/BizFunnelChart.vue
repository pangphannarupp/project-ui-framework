<template>
  <div class="biz-funnel-chart" :style="{ height: height + 'px' }">
    <svg viewBox="0 0 100 100" preserveAspectRatio="none" width="100%" height="100%">
      <polygon 
        v-for="(seg, index) in segments" 
        :key="index"
        :points="seg.points"
        :fill="seg.color"
        class="funnel-segment"
        :style="{ animationDelay: (index * 0.1) + 's' }"
      />
    </svg>
    
    <!-- Overlay Labels -->
    <div class="funnel-labels">
      <div 
        v-for="(seg, index) in segments"
        :key="'lbl-'+index"
        class="funnel-label"
        :style="{ top: `${seg.centerY}%` }"
      >
        <span class="funnel-label-title">{{ seg.label }}</span>
        <span class="funnel-label-value">{{ seg.value }}</span>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue';

export interface BizFunnelData {
  label: string;
  value: number;
  color?: string;
}

const props = withDefaults(defineProps<{
  data: BizFunnelData[];
  height?: number;
  colors?: string[];
}>(), {
  height: 240,
  colors: () => ['var(--biz-primary-light, #3880ff)', '#3dc2ff', '#2dd36f', '#ffc409', '#eb445a']
});

const segments = computed(() => {
  if (!props.data || props.data.length === 0) return [];
  
  // Assume data is sorted highest to lowest, or we sort it?
  // Usually funnel data is provided in order of steps.
  const maxValue = Math.max(...props.data.map(d => d.value), 0.001);
  const layerHeight = 100 / props.data.length;
  
  return props.data.map((d, i) => {
    const topWidth = i === 0 ? 100 : (props.data[i-1].value / maxValue) * 100;
    const bottomWidth = (d.value / maxValue) * 100;
    
    const topY = i * layerHeight;
    const bottomY = (i + 1) * layerHeight;
    
    // Add a tiny gap between layers
    const adjustedBottomY = bottomY - 1;
    
    const topLeftX = 50 - (topWidth / 2);
    const topRightX = 50 + (topWidth / 2);
    const bottomLeftX = 50 - (bottomWidth / 2);
    const bottomRightX = 50 + (bottomWidth / 2);
    
    const points = `${topLeftX},${topY} ${topRightX},${topY} ${bottomRightX},${adjustedBottomY} ${bottomLeftX},${adjustedBottomY}`;
    
    return {
      ...d,
      points,
      color: d.color || props.colors[i % props.colors.length],
      centerY: topY + (layerHeight / 2)
    };
  });
});
</script>

<style scoped>
.biz-funnel-chart {
  width: 100%;
  position: relative;
  display: flex;
  flex-direction: column;
}

.funnel-segment {
  opacity: 0;
  animation: drop-in 0.6s cubic-bezier(0.34, 1.56, 0.64, 1) forwards;
  transform-origin: 50% 0%;
  transition: opacity 0.3s ease;
}

.funnel-segment:hover {
  opacity: 0.8 !important;
}

@keyframes drop-in {
  from { opacity: 0; transform: scaleY(0); }
  to { opacity: 1; transform: scaleY(1); }
}

.funnel-labels {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  pointer-events: none;
}

.funnel-label {
  position: absolute;
  left: 50%;
  transform: translate(-50%, -50%);
  display: flex;
  flex-direction: column;
  align-items: center;
  color: white;
  text-shadow: 0 1px 3px rgba(0,0,0,0.4);
}

.funnel-label-title {
  font-size: 12px;
  font-weight: 500;
}

.funnel-label-value {
  font-size: 16px;
  font-weight: 700;
}
</style>
