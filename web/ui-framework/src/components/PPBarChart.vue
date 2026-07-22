<template>
  <div class="pp-bar-chart" :style="{ height: height + 'px' }">
    <div class="pp-bar-chart-inner">
      <div 
        v-for="(item, index) in data" 
        :key="index"
        class="pp-bar-wrapper"
      >
        <div class="pp-bar-value" v-if="showValues">{{ item.value }}</div>
        <div 
          class="pp-bar"
          :style="{
            height: `${(item.value / Math.max(maxValue, 0.001)) * 100}%`,
            background: item.gradient ? `linear-gradient(to top, ${item.gradient[0]}, ${item.gradient[1]})` : (item.color || color),
            borderRadius: `${barRadius}px ${barRadius}px 0 0`,
            width: barWidth ? barWidth + 'px' : '100%'
          }"
        ></div>
        <div class="pp-bar-label" v-if="item.label">{{ item.label }}</div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue';

export interface PPBarChartData {
  label?: string;
  value: number;
  color?: string;
  gradient?: [string, string];
}

const props = withDefaults(defineProps<{
  data: PPBarChartData[];
  height?: number;
  color?: string;
  showValues?: boolean;
  barRadius?: number;
  barWidth?: number;
}>(), {
  height: 240,
  color: 'var(--pp-primary-light, #3880ff)',
  showValues: true,
  barRadius: 6
});

const maxValue = computed(() => {
  return Math.max(...props.data.map(d => d.value), 0);
});
</script>

<style scoped>
.pp-bar-chart {
  width: 100%;
  position: relative;
  display: flex;
  flex-direction: column;
}

.pp-bar-chart-inner {
  display: flex;
  align-items: flex-end;
  justify-content: space-around;
  width: 100%;
  height: 100%;
  padding-top: 24px;
  padding-bottom: 24px;
  box-sizing: border-box;
}

.pp-bar-wrapper {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: flex-end;
  height: 100%;
  flex: 1;
  max-width: 60px;
  margin: 0 4px;
}

.pp-bar-value {
  font-size: 12px;
  color: #666;
  margin-bottom: 8px;
  font-weight: 600;
}

.pp-bar {
  min-height: 4px;
  transition: height 0.8s cubic-bezier(0.34, 1.56, 0.64, 1);
}

.pp-bar-label {
  font-size: 12px;
  color: #999;
  margin-top: 12px;
  text-align: center;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  width: 100%;
}
</style>
