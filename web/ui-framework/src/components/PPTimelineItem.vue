<template>
  <div class="pp-timeline-item" :class="[`pp-timeline-item--${direction}`]">
    <div class="pp-timeline-item__tail"></div>
    
    <div class="pp-timeline-item__node" :class="[`pp-timeline-item__node--${type}`, `pp-timeline-item__node--${size}`]">
      <slot name="dot">
        <div class="pp-timeline-item__node-dot"></div>
      </slot>
    </div>

    <div class="pp-timeline-item__wrapper">
      <div v-if="timestamp && timestampPlacement === 'top'" class="pp-timeline-item__timestamp is-top">
        {{ timestamp }}
      </div>
      
      <div class="pp-timeline-item__content">
        <slot></slot>
      </div>
      
      <div v-if="timestamp && timestampPlacement === 'bottom'" class="pp-timeline-item__timestamp is-bottom">
        {{ timestamp }}
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { inject } from 'vue';

defineProps({
  timestamp: {
    type: String,
    default: ''
  },
  timestampPlacement: {
    type: String,
    default: 'bottom' // 'top', 'bottom'
  },
  type: {
    type: String,
    default: 'primary' // 'primary', 'success', 'warning', 'danger', 'info'
  },
  size: {
    type: String,
    default: 'normal' // 'normal', 'large'
  }
});

const direction = inject('bizTimelineDirection', 'vertical');
</script>

<style scoped>
.pp-timeline-item {
  position: relative;
  padding-bottom: 20px;
}

.pp-timeline-item--vertical {
  padding-bottom: 20px;
}

.pp-timeline-item--horizontal {
  padding-bottom: 0;
  padding-right: 20px;
  display: inline-block;
  flex: 1;
}

.pp-timeline-item__tail {
  position: absolute;
  background-color: #e4e7ed;
}

.pp-timeline-item--vertical .pp-timeline-item__tail {
  left: 5px;
  top: 12px;
  height: 100%;
  border-left: 2px solid #e4e7ed;
}

.pp-timeline-item--horizontal .pp-timeline-item__tail {
  top: 5px;
  left: 12px;
  width: 100%;
  border-top: 2px solid #e4e7ed;
}

/* Hide tail on last item */
.pp-timeline-item:last-child .pp-timeline-item__tail {
  display: none;
}

.pp-timeline-item__node {
  position: absolute;
  background-color: #e4e7ed;
  border-radius: 50%;
  display: flex;
  justify-content: center;
  align-items: center;
}

.pp-timeline-item--vertical .pp-timeline-item__node {
  left: -1px;
  top: 0;
}

.pp-timeline-item--horizontal .pp-timeline-item__node {
  top: -1px;
  left: 0;
}

.pp-timeline-item__node--normal {
  width: 12px;
  height: 12px;
  left: 0;
}

.pp-timeline-item__node--large {
  width: 16px;
  height: 16px;
  left: -2px; /* Adjust for larger size */
}

/* Colors */
.pp-timeline-item__node--primary { background-color: #1a2a5e; }
.pp-timeline-item__node--success { background-color: #4caf50; }
.pp-timeline-item__node--warning { background-color: #ff9800; }
.pp-timeline-item__node--danger { background-color: #f44336; }
.pp-timeline-item__node--info { background-color: #909399; }

.pp-timeline-item__wrapper {
  position: relative;
}

.pp-timeline-item--vertical .pp-timeline-item__wrapper {
  padding-left: 24px;
  top: -4px;
}

.pp-timeline-item--horizontal .pp-timeline-item__wrapper {
  padding-top: 24px;
  left: -4px;
}

.pp-timeline-item__content {
  color: #333;
  font-size: 14px;
}

.pp-timeline-item__timestamp {
  color: #666;
  font-size: 13px;
}
.pp-timeline-item__timestamp.is-top {
  margin-bottom: 8px;
}
.pp-timeline-item__timestamp.is-bottom {
  margin-top: 8px;
}
</style>
