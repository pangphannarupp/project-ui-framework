<template>
  <div class="biz-timeline-item" :class="[`biz-timeline-item--${direction}`]">
    <div class="biz-timeline-item__tail"></div>
    
    <div class="biz-timeline-item__node" :class="[`biz-timeline-item__node--${type}`, `biz-timeline-item__node--${size}`]">
      <slot name="dot">
        <div class="biz-timeline-item__node-dot"></div>
      </slot>
    </div>

    <div class="biz-timeline-item__wrapper">
      <div v-if="timestamp && timestampPlacement === 'top'" class="biz-timeline-item__timestamp is-top">
        {{ timestamp }}
      </div>
      
      <div class="biz-timeline-item__content">
        <slot></slot>
      </div>
      
      <div v-if="timestamp && timestampPlacement === 'bottom'" class="biz-timeline-item__timestamp is-bottom">
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
.biz-timeline-item {
  position: relative;
  padding-bottom: 20px;
}

.biz-timeline-item--vertical {
  padding-bottom: 20px;
}

.biz-timeline-item--horizontal {
  padding-bottom: 0;
  padding-right: 20px;
  display: inline-block;
  flex: 1;
}

.biz-timeline-item__tail {
  position: absolute;
  background-color: #e4e7ed;
}

.biz-timeline-item--vertical .biz-timeline-item__tail {
  left: 5px;
  top: 12px;
  height: 100%;
  border-left: 2px solid #e4e7ed;
}

.biz-timeline-item--horizontal .biz-timeline-item__tail {
  top: 5px;
  left: 12px;
  width: 100%;
  border-top: 2px solid #e4e7ed;
}

/* Hide tail on last item */
.biz-timeline-item:last-child .biz-timeline-item__tail {
  display: none;
}

.biz-timeline-item__node {
  position: absolute;
  background-color: #e4e7ed;
  border-radius: 50%;
  display: flex;
  justify-content: center;
  align-items: center;
}

.biz-timeline-item--vertical .biz-timeline-item__node {
  left: -1px;
  top: 0;
}

.biz-timeline-item--horizontal .biz-timeline-item__node {
  top: -1px;
  left: 0;
}

.biz-timeline-item__node--normal {
  width: 12px;
  height: 12px;
  left: 0;
}

.biz-timeline-item__node--large {
  width: 16px;
  height: 16px;
  left: -2px; /* Adjust for larger size */
}

/* Colors */
.biz-timeline-item__node--primary { background-color: #1a2a5e; }
.biz-timeline-item__node--success { background-color: #4caf50; }
.biz-timeline-item__node--warning { background-color: #ff9800; }
.biz-timeline-item__node--danger { background-color: #f44336; }
.biz-timeline-item__node--info { background-color: #909399; }

.biz-timeline-item__wrapper {
  position: relative;
}

.biz-timeline-item--vertical .biz-timeline-item__wrapper {
  padding-left: 24px;
  top: -4px;
}

.biz-timeline-item--horizontal .biz-timeline-item__wrapper {
  padding-top: 24px;
  left: -4px;
}

.biz-timeline-item__content {
  color: #333;
  font-size: 14px;
}

.biz-timeline-item__timestamp {
  color: #666;
  font-size: 13px;
}
.biz-timeline-item__timestamp.is-top {
  margin-bottom: 8px;
}
.biz-timeline-item__timestamp.is-bottom {
  margin-top: 8px;
}
</style>
