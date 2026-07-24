<template>
  <div class="pp-timeline-item" :class="[
    `pp-timeline-item--${direction}`, 
    `pp-timeline-item--align-${align}`,
    { 'is-dashed': dashed, 'is-animated': animated }
  ]">
    <div class="pp-timeline-item__tail"></div>
    
    <div class="pp-timeline-item__node" :class="[
      `pp-timeline-item__node--${type}`, 
      `pp-timeline-item__node--${size}`,
      `pp-timeline-item__node--${variant}`,
      { 'is-active': active }
    ]">
      <slot name="icon">
        <slot name="dot">
          <div class="pp-timeline-item__node-dot"></div>
        </slot>
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
  },
  variant: {
    type: String,
    default: 'solid' // 'solid', 'hollow'
  },
  dashed: {
    type: Boolean,
    default: false
  },
  active: {
    type: Boolean,
    default: false
  }
});

const direction = inject('ppTimelineDirection', 'vertical');
const align = inject('ppTimelineAlign', 'left');
const animated = inject('ppTimelineAnimated', false);
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

/* Hollow Variant */
.pp-timeline-item__node--hollow {
  background-color: white !important;
  border-width: 2px;
  border-style: solid;
}
.pp-timeline-item__node--primary.pp-timeline-item__node--hollow { border-color: #1a2a5e; }
.pp-timeline-item__node--success.pp-timeline-item__node--hollow { border-color: #4caf50; }
.pp-timeline-item__node--warning.pp-timeline-item__node--hollow { border-color: #ff9800; }
.pp-timeline-item__node--danger.pp-timeline-item__node--hollow { border-color: #f44336; }
.pp-timeline-item__node--info.pp-timeline-item__node--hollow { border-color: #909399; }

/* Dashed Tail */
.pp-timeline-item.is-dashed .pp-timeline-item__tail {
  border-style: dashed;
}

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

/* Alternate Alignment (Vertical Only) */
.pp-timeline-item--vertical.pp-timeline-item--align-alternate {
  width: 50%;
  margin-left: auto;
  margin-right: auto;
}
.pp-timeline-item--vertical.pp-timeline-item--align-alternate:nth-child(odd) {
  margin-left: 0;
  text-align: right;
}
.pp-timeline-item--vertical.pp-timeline-item--align-alternate:nth-child(odd) .pp-timeline-item__tail {
  left: 100%;
  margin-left: -1px;
}
.pp-timeline-item--vertical.pp-timeline-item--align-alternate:nth-child(odd) .pp-timeline-item__node {
  left: 100%;
  transform: translateX(-50%);
}
.pp-timeline-item--vertical.pp-timeline-item--align-alternate:nth-child(odd) .pp-timeline-item__wrapper {
  padding-left: 0;
  padding-right: 24px;
}
.pp-timeline-item--vertical.pp-timeline-item--align-alternate:nth-child(even) {
  margin-left: 50%;
  margin-right: 0;
  text-align: left;
}
.pp-timeline-item--vertical.pp-timeline-item--align-alternate:nth-child(even) .pp-timeline-item__tail {
  left: 0;
  margin-left: -1px;
}
.pp-timeline-item--vertical.pp-timeline-item--align-alternate:nth-child(even) .pp-timeline-item__node {
  left: 0;
  transform: translateX(-50%);
}
.pp-timeline-item--vertical.pp-timeline-item--align-alternate:nth-child(even) .pp-timeline-item__wrapper {
  padding-left: 24px;
  padding-right: 0;
}

/* Animations */
@keyframes tail-draw {
  from { height: 0; opacity: 0; }
  to { height: 100%; opacity: 1; }
}

@keyframes node-pop {
  0% { transform: scale(0); opacity: 0; }
  50% { transform: scale(1.2); opacity: 1; }
  100% { transform: scale(1); opacity: 1; }
}

/* Node centering in alternate needs combining with node-pop for scale */
@keyframes node-pop-alternate {
  0% { transform: translateX(-50%) scale(0); opacity: 0; }
  50% { transform: translateX(-50%) scale(1.2); opacity: 1; }
  100% { transform: translateX(-50%) scale(1); opacity: 1; }
}

.is-animated .pp-timeline-item__tail {
  animation: tail-draw 0.6s ease forwards;
  opacity: 0;
  height: 0;
}

.is-animated .pp-timeline-item__node {
  animation: node-pop 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275) forwards;
  opacity: 0;
}

.is-animated.pp-timeline-item--align-alternate .pp-timeline-item__node {
  animation-name: node-pop-alternate;
}

/* Stagger delays */
.is-animated:nth-child(1) .pp-timeline-item__tail { animation-delay: 0.1s; }
.is-animated:nth-child(1) .pp-timeline-item__node { animation-delay: 0s; }
.is-animated:nth-child(2) .pp-timeline-item__tail { animation-delay: 0.5s; }
.is-animated:nth-child(2) .pp-timeline-item__node { animation-delay: 0.4s; }
.is-animated:nth-child(3) .pp-timeline-item__tail { animation-delay: 0.9s; }
.is-animated:nth-child(3) .pp-timeline-item__node { animation-delay: 0.8s; }
.is-animated:nth-child(4) .pp-timeline-item__tail { animation-delay: 1.3s; }
.is-animated:nth-child(4) .pp-timeline-item__node { animation-delay: 1.2s; }
.is-animated:nth-child(5) .pp-timeline-item__tail { animation-delay: 1.7s; }
.is-animated:nth-child(5) .pp-timeline-item__node { animation-delay: 1.6s; }
.is-animated:nth-child(6) .pp-timeline-item__tail { animation-delay: 2.1s; }
.is-animated:nth-child(6) .pp-timeline-item__node { animation-delay: 2.0s; }
.is-animated:nth-child(7) .pp-timeline-item__tail { animation-delay: 2.5s; }
.is-animated:nth-child(7) .pp-timeline-item__node { animation-delay: 2.4s; }

/* Pulse Animation for Active Nodes */
@keyframes pulse-ring {
  0% { box-shadow: 0 0 0 0 rgba(0, 0, 0, 0.2); }
  100% { box-shadow: 0 0 0 10px rgba(0, 0, 0, 0); }
}

.pp-timeline-item__node.is-active {
  animation: pulse-ring 1.5s infinite cubic-bezier(0.215, 0.61, 0.355, 1);
}
.pp-timeline-item__node--primary.is-active { animation-name: pulse-ring-primary; }
.pp-timeline-item__node--success.is-active { animation-name: pulse-ring-success; }
.pp-timeline-item__node--warning.is-active { animation-name: pulse-ring-warning; }
.pp-timeline-item__node--danger.is-active { animation-name: pulse-ring-danger; }
.pp-timeline-item__node--info.is-active { animation-name: pulse-ring-info; }

@keyframes pulse-ring-primary { 0% { box-shadow: 0 0 0 0 rgba(26, 42, 94, 0.4); } 100% { box-shadow: 0 0 0 10px rgba(26, 42, 94, 0); } }
@keyframes pulse-ring-success { 0% { box-shadow: 0 0 0 0 rgba(76, 175, 80, 0.4); } 100% { box-shadow: 0 0 0 10px rgba(76, 175, 80, 0); } }
@keyframes pulse-ring-warning { 0% { box-shadow: 0 0 0 0 rgba(255, 152, 0, 0.4); } 100% { box-shadow: 0 0 0 10px rgba(255, 152, 0, 0); } }
@keyframes pulse-ring-danger { 0% { box-shadow: 0 0 0 0 rgba(244, 67, 54, 0.4); } 100% { box-shadow: 0 0 0 10px rgba(244, 67, 54, 0); } }
@keyframes pulse-ring-info { 0% { box-shadow: 0 0 0 0 rgba(144, 147, 153, 0.4); } 100% { box-shadow: 0 0 0 10px rgba(144, 147, 153, 0); } }

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
