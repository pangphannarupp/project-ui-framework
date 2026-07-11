<template>
  <div class="biz-progress-gauge" :style="{ width: size + 'px', height: (size / 2) + 'px' }">
    <svg viewBox="0 0 100 50" width="100%" height="100%">
      <defs>
        <linearGradient :id="'gauge-grad-' + chartId" x1="0%" y1="0%" x2="100%" y2="0%">
          <stop offset="0%" :stop-color="gradient ? gradient[0] : color" />
          <stop offset="100%" :stop-color="gradient ? gradient[1] : color" />
        </linearGradient>
      </defs>
      
      <!-- Background Track (Half Circle) -->
      <!-- Center is 50,50. Radius is 40. Arc starts at 10,50 and ends at 90,50 -->
      <path 
        d="M 10 50 A 40 40 0 0 1 90 50"
        fill="none"
        :stroke="trackColor"
        :stroke-width="thickness"
        stroke-linecap="round"
      />
      
      <!-- Value Track -->
      <path 
        d="M 10 50 A 40 40 0 0 1 90 50"
        fill="none"
        :stroke="gradient ? `url(#gauge-grad-${chartId})` : color"
        :stroke-width="thickness"
        stroke-linecap="round"
        :stroke-dasharray="arcLength"
        :stroke-dashoffset="dashOffset"
        class="gauge-path"
      />
    </svg>
    
    <!-- Center Label -->
    <div class="gauge-content">
      <div class="gauge-value" :style="{ color }">{{ formattedValue }}</div>
      <div class="gauge-label" v-if="label">{{ label }}</div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed, ref, onMounted } from 'vue';

const props = withDefaults(defineProps<{
  value: number;
  max?: number;
  size?: number;
  thickness?: number;
  color?: string;
  gradient?: [string, string];
  trackColor?: string;
  label?: string;
  format?: (val: number) => string;
}>(), {
  max: 100,
  size: 200,
  thickness: 8,
  color: 'var(--biz-primary-light, #3880ff)',
  trackColor: '#e0e0e0'
});

const chartId = Math.random().toString(36).substring(2, 9);

// Arc length for r=40 is PI * 40 ≈ 125.6637
const arcLength = 125.6637;

const animated = ref(false);

onMounted(() => {
  setTimeout(() => {
    animated.value = true;
  }, 100);
});

const dashOffset = computed(() => {
  if (!animated.value) return arcLength;
  const percentage = Math.min(Math.max(props.value / props.max, 0), 1);
  // Dash offset goes from arcLength (empty) to 0 (full)
  return arcLength - (percentage * arcLength);
});

const formattedValue = computed(() => {
  if (props.format) return props.format(props.value);
  return props.value.toString();
});
</script>

<style scoped>
.biz-progress-gauge {
  position: relative;
  display: inline-flex;
  flex-direction: column;
  align-items: center;
}

.gauge-path {
  transition: stroke-dashoffset 1.5s cubic-bezier(0.34, 1.56, 0.64, 1);
}

.gauge-content {
  position: absolute;
  bottom: 0;
  left: 0;
  width: 100%;
  text-align: center;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: flex-end;
  padding-bottom: 4px;
}

.gauge-value {
  font-size: 28px;
  font-weight: 700;
  line-height: 1;
}

.gauge-label {
  font-size: 12px;
  color: #999;
  margin-top: 4px;
}
</style>
