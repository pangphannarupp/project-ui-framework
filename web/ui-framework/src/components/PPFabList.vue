<template>
  <div 
    class="pp-fab-list"
    :class="[
      `pp-fab-list--${side}`,
      { 'pp-fab-list--active': fabContext?.active.value }
    ]"
    ref="listRef"
  >
    <slot></slot>
  </div>
</template>

<script setup lang="ts">
import { inject, ref, onMounted, onUpdated, watch } from 'vue';

const props = withDefaults(defineProps<{
  side?: 'top' | 'bottom' | 'left' | 'right' | 'circle';
  circleStartAngle?: number;
  circleEndAngle?: number;
  circleRadius?: number;
}>(), {
  side: 'top',
  circleStartAngle: 0,
  circleEndAngle: 360,
  circleRadius: 70
});

const fabContext = inject<{ active: any, position: string } | null>('ppFabContext', null);
const listRef = ref<HTMLElement | null>(null);

const updateChildren = () => {
  if (!listRef.value || props.side !== 'circle') return;
  
  const children = Array.from(listRef.value.children) as HTMLElement[];
  const count = children.length;
  if (count === 0) return;
  
  const isFullCircle = Math.abs(props.circleEndAngle - props.circleStartAngle) === 360;
  // For full circle, divide by count. For partial (e.g. semi-circle), divide by count - 1 to reach the edges.
  const step = isFullCircle 
    ? (props.circleEndAngle - props.circleStartAngle) / count
    : count > 1 ? (props.circleEndAngle - props.circleStartAngle) / (count - 1) : 0;
    
  children.forEach((child, index) => {
    const angle = props.circleStartAngle + index * step;
    child.style.setProperty('--angle', `${angle}deg`);
    child.style.setProperty('--radius', `${props.circleRadius}px`);
  });
};

onMounted(updateChildren);
onUpdated(updateChildren);
watch(() => [props.side, props.circleStartAngle, props.circleEndAngle, props.circleRadius], updateChildren);
</script>

<style scoped>
.pp-fab-list {
  position: absolute;
  display: flex;
  flex-direction: column;
  gap: 12px;
  opacity: 0;
  visibility: hidden;
  pointer-events: none;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  z-index: -1;
}

.pp-fab-list--active {
  opacity: 1;
  visibility: visible;
  pointer-events: auto;
}

/* Positioning logic */
.pp-fab-list--top {
  bottom: 100%;
  margin-bottom: 16px;
  flex-direction: column-reverse;
  transform: translateY(20px) scale(0.9);
}
.pp-fab-list--active.pp-fab-list--top {
  transform: translateY(0) scale(1);
}

.pp-fab-list--bottom {
  top: 100%;
  margin-top: 16px;
  transform: translateY(-20px) scale(0.9);
}
.pp-fab-list--active.pp-fab-list--bottom {
  transform: translateY(0) scale(1);
}

.pp-fab-list--left {
  right: 100%;
  margin-right: 16px;
  flex-direction: row-reverse;
  top: 50%;
  transform: translateY(-50%) translateX(20px) scale(0.9);
}
.pp-fab-list--active.pp-fab-list--left {
  transform: translateY(-50%) translateX(0) scale(1);
}

.pp-fab-list--right {
  left: 100%;
  margin-left: 16px;
  flex-direction: row;
  top: 50%;
  transform: translateY(-50%) translateX(-20px) scale(0.9);
}
.pp-fab-list--active.pp-fab-list--right {
  transform: translateY(-50%) translateX(0) scale(1);
}

/* Circle Layout */
.pp-fab-list--circle {
  position: absolute;
  top: 50%;
  left: 50%;
  width: 0;
  height: 0;
  display: block;
}

.pp-fab-list--circle :deep(> *) {
  position: absolute;
  top: -20px; /* Assuming child is 40x40. If child size varies, this may need tweaking */
  left: -20px;
  transform: scale(0.5);
  opacity: 0;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  /* The rotation angles are dynamically set by the script using CSS variables */
}

.pp-fab-list--active.pp-fab-list--circle :deep(> *) {
  transform: rotate(var(--angle)) translateY(calc(-1 * var(--radius))) rotate(calc(-1 * var(--angle))) scale(1) !important;
  opacity: 1;
  pointer-events: auto;
}
</style>
