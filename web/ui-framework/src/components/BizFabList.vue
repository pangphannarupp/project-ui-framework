<template>
  <div 
    class="biz-fab-list"
    :class="[
      `biz-fab-list--${side}`,
      { 'biz-fab-list--active': fabContext?.active.value }
    ]"
  >
    <slot></slot>
  </div>
</template>

<script setup lang="ts">
import { inject } from 'vue';

withDefaults(defineProps<{
  side?: 'top' | 'bottom' | 'left' | 'right';
}>(), {
  side: 'top'
});

const fabContext = inject<{ active: any, position: string } | null>('bizFabContext', null);
</script>

<style scoped>
.biz-fab-list {
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

.biz-fab-list--active {
  opacity: 1;
  visibility: visible;
  pointer-events: auto;
}

/* Positioning logic */
.biz-fab-list--top {
  bottom: 100%;
  margin-bottom: 16px;
  flex-direction: column-reverse;
  transform: translateY(20px) scale(0.9);
}
.biz-fab-list--active.biz-fab-list--top {
  transform: translateY(0) scale(1);
}

.biz-fab-list--bottom {
  top: 100%;
  margin-top: 16px;
  transform: translateY(-20px) scale(0.9);
}
.biz-fab-list--active.biz-fab-list--bottom {
  transform: translateY(0) scale(1);
}

.biz-fab-list--left {
  right: 100%;
  margin-right: 16px;
  flex-direction: row-reverse;
  top: 50%;
  transform: translateY(-50%) translateX(20px) scale(0.9);
}
.biz-fab-list--active.biz-fab-list--left {
  transform: translateY(-50%) translateX(0) scale(1);
}

.biz-fab-list--right {
  left: 100%;
  margin-left: 16px;
  flex-direction: row;
  top: 50%;
  transform: translateY(-50%) translateX(-20px) scale(0.9);
}
.biz-fab-list--active.biz-fab-list--right {
  transform: translateY(-50%) translateX(0) scale(1);
}
</style>
