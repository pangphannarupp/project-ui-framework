<template>
  <div class="pp-badge-wrapper">
    <slot></slot>
    
    <span 
      v-if="!hidden"
      class="pp-badge"
      :class="[
        `color-${color}`, 
        `placement-${placement}`,
        { 'is-dot': dot, 'has-border': bordered }
      ]"
      :style="customStyle"
    >
      <template v-if="!dot">
        {{ displayValue }}
      </template>
    </span>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue';

const props = withDefaults(defineProps<{
  value?: string | number;
  max?: number;
  dot?: boolean;
  color?: 'primary' | 'secondary' | 'success' | 'warning' | 'danger' | 'info';
  placement?: 'top-right' | 'top-left' | 'bottom-right' | 'bottom-left';
  hidden?: boolean;
  bordered?: boolean;
  bgColor?: string;
  textColor?: string;
}>(), {
  color: 'danger',
  placement: 'top-right',
  dot: false,
  hidden: false,
  bordered: true
});

const displayValue = computed(() => {
  if (props.max && typeof props.value === 'number' && props.value > props.max) {
    return `${props.max}+`;
  }
  return props.value;
});

const customStyle = computed(() => {
  const styles: any = {};
  if (props.bgColor) styles.backgroundColor = props.bgColor;
  if (props.textColor) styles.color = props.textColor;
  return styles;
});
</script>

<style scoped>
.pp-badge-wrapper {
  position: relative;
  display: inline-block;
}

.pp-badge {
  position: absolute;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  border-radius: 9999px;
  font-weight: 600;
  white-space: nowrap;
  transition: all 0.2s ease;
  z-index: 10;
  
  /* Size for text badge */
  padding: 0 6px;
  height: 20px;
  min-width: 20px;
  font-size: 12px;
  line-height: 1;
}

.pp-badge.is-dot {
  padding: 0;
  height: 10px;
  min-width: 10px;
}

.pp-badge.has-border {
  border: 2px solid #ffffff;
}

/* Placements */
.placement-top-right {
  top: 0;
  right: 0;
  transform: translate(50%, -50%);
}
.placement-top-left {
  top: 0;
  left: 0;
  transform: translate(-50%, -50%);
}
.placement-bottom-right {
  bottom: 0;
  right: 0;
  transform: translate(50%, 50%);
}
.placement-bottom-left {
  bottom: 0;
  left: 0;
  transform: translate(-50%, 50%);
}

/* Colors */
.color-primary { background-color: #3b82f6; color: white; }
.color-secondary { background-color: #64748b; color: white; }
.color-success { background-color: #10b981; color: white; }
.color-warning { background-color: #f59e0b; color: white; }
.color-danger { background-color: #ef4444; color: white; }
.color-info { background-color: #0ea5e9; color: white; }
</style>
