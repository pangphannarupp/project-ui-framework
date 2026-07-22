<template>
  <div class="pp-donut-chart" :style="{ width: size + 'px', height: size + 'px' }">
    <svg viewBox="0 0 100 100" width="100%" height="100%">
      <!-- Background track -->
      <circle 
        cx="50" cy="50" 
        :r="radius" 
        fill="transparent" 
        :stroke="trackColor" 
        :stroke-width="thickness" 
      />
      <!-- Segments -->
      <circle 
        v-for="(seg, index) in segments" 
        :key="index"
        cx="50" cy="50" 
        :r="radius" 
        fill="transparent" 
        :stroke="seg.color" 
        :stroke-width="thickness" 
        :stroke-dasharray="circumference"
        :stroke-dashoffset="seg.offset"
        :stroke-linecap="rounded ? 'round' : 'butt'"
        :style="{ transformOrigin: '50px 50px', transform: `rotate(${seg.rotation}deg)`, transition: 'stroke-dashoffset 1.2s cubic-bezier(0.4, 0, 0.2, 1)' }"
      />
    </svg>
    <!-- Center Content -->
    <div class="pp-donut-center" v-if="$slots.default || label || value">
      <slot>
        <div class="pp-donut-value" v-if="value" :style="{ fontSize: (size * 0.15) + 'px' }">{{ value }}</div>
        <div class="pp-donut-label" v-if="label" :style="{ fontSize: (size * 0.08) + 'px' }">{{ label }}</div>
      </slot>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed, ref, onMounted } from 'vue';

export interface PPDonutSegment {
  value: number;
  color: string;
}

const props = withDefaults(defineProps<{
  data: PPDonutSegment[];
  size?: number;
  thickness?: number;
  trackColor?: string;
  label?: string;
  value?: string;
  rounded?: boolean;
}>(), {
  size: 200,
  thickness: 16,
  trackColor: '#f0f0f0',
  rounded: false
});

const radius = computed(() => 50 - (props.thickness / 2));
const circumference = computed(() => 2 * Math.PI * radius.value);

// Used for animation
const animated = ref(false);

onMounted(() => {
  setTimeout(() => {
    animated.value = true;
  }, 50);
});

const segments = computed(() => {
  const total = Math.max(props.data.reduce((sum, d) => sum + d.value, 0), 0.001);
  
  let currentRotation = -90;
  
  return props.data.map(d => {
    const percentage = d.value / total;
    // Leave a tiny gap if rounded to prevent overlap visual glitch
    const gap = (props.rounded && props.data.length > 1) ? 2 : 0;
    const visualPercentage = Math.max(0, percentage - (gap / 100));
    
    const dashOffset = animated.value ? circumference.value - (visualPercentage * circumference.value) : circumference.value;
    
    const segment = {
      color: d.color,
      offset: dashOffset,
      rotation: currentRotation
    };
    
    currentRotation += (percentage * 360);
    return segment;
  });
});
</script>

<style scoped>
.pp-donut-chart {
  position: relative;
  display: inline-flex;
  align-items: center;
  justify-content: center;
}

.pp-donut-center {
  position: absolute;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  text-align: center;
  width: 70%;
  height: 70%;
  border-radius: 50%;
}

.pp-donut-value {
  font-weight: 700;
  color: #333;
  line-height: 1.2;
}

.pp-donut-label {
  color: #999;
  margin-top: 4px;
}
</style>
