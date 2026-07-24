<template>
  <div 
    class="pp-tooltip-wrapper" 
    @mouseenter="show" 
    @mouseleave="hide"
    @focus="show"
    @blur="hide"
  >
    <slot></slot>
    <div 
      v-if="isVisible"
      class="pp-tooltip"
      :class="[`placement-${placement}`, `theme-${theme}`]"
      :style="customStyle"
    >
      {{ content }}
      <div class="tooltip-arrow"></div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

const props = withDefaults(defineProps<{
  content: string;
  placement?: 'top' | 'bottom' | 'left' | 'right';
  theme?: 'dark' | 'light';
  delay?: number;
  bgColor?: string;
  textColor?: string;
}>(), {
  placement: 'top',
  theme: 'dark',
  delay: 200
});

const isVisible = ref(false);
let timeoutId: any = null;

const show = () => {
  if (timeoutId) clearTimeout(timeoutId);
  timeoutId = setTimeout(() => {
    isVisible.value = true;
  }, props.delay);
};

const hide = () => {
  if (timeoutId) clearTimeout(timeoutId);
  isVisible.value = false;
};

const customStyle = computed(() => {
  const styles: any = {};
  if (props.bgColor) styles['--tooltip-bg'] = props.bgColor;
  if (props.textColor) styles['--tooltip-text'] = props.textColor;
  return styles;
});
</script>

<style scoped>
.pp-tooltip-wrapper {
  position: relative;
  display: inline-block;
}

.pp-tooltip {
  position: absolute;
  z-index: 1000;
  padding: 6px 12px;
  border-radius: 6px;
  font-size: 12px;
  font-weight: 500;
  white-space: nowrap;
  pointer-events: none;
  opacity: 0;
  animation: fadeIn 0.2s forwards;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
}

@keyframes fadeIn {
  to { opacity: 1; }
}

/* Themes */
.theme-dark {
  --tooltip-bg: #1e293b;
  --tooltip-text: #f8fafc;
}
.theme-light {
  --tooltip-bg: #ffffff;
  --tooltip-text: #1e293b;
  border: 1px solid #e2e8f0;
}

.pp-tooltip {
  background-color: var(--tooltip-bg);
  color: var(--tooltip-text);
}

.tooltip-arrow {
  position: absolute;
  width: 8px;
  height: 8px;
  background-color: var(--tooltip-bg);
  transform: rotate(45deg);
}
.theme-light .tooltip-arrow {
  border: 1px solid #e2e8f0;
}

/* Placements */
.placement-top {
  bottom: 100%;
  left: 50%;
  transform: translateX(-50%) translateY(-8px);
}
.placement-top .tooltip-arrow {
  bottom: -4px;
  left: calc(50% - 4px);
  border-top: none;
  border-left: none;
}

.placement-bottom {
  top: 100%;
  left: 50%;
  transform: translateX(-50%) translateY(8px);
}
.placement-bottom .tooltip-arrow {
  top: -4px;
  left: calc(50% - 4px);
  border-bottom: none;
  border-right: none;
}

.placement-left {
  right: 100%;
  top: 50%;
  transform: translateY(-50%) translateX(-8px);
}
.placement-left .tooltip-arrow {
  right: -4px;
  top: calc(50% - 4px);
  border-bottom: none;
  border-left: none;
}

.placement-right {
  left: 100%;
  top: 50%;
  transform: translateY(-50%) translateX(8px);
}
.placement-right .tooltip-arrow {
  left: -4px;
  top: calc(50% - 4px);
  border-top: none;
  border-right: none;
}
</style>
