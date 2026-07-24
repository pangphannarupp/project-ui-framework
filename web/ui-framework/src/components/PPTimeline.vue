<template>
  <div class="pp-timeline" :class="[
    `pp-timeline--${direction}`, 
    `pp-timeline--align-${align}`,
    { 'is-animated': animated }
  ]">
    <slot></slot>
  </div>
</template>

<script setup lang="ts">
import { provide } from 'vue';

const props = defineProps({
  direction: {
    type: String,
    default: 'vertical', // 'vertical' or 'horizontal'
  },
  align: {
    type: String,
    default: 'left', // 'left', 'right', 'alternate'
  },
  animated: {
    type: Boolean,
    default: false
  }
});

provide('ppTimelineDirection', props.direction);
provide('ppTimelineAlign', props.align);
provide('ppTimelineAnimated', props.animated);
</script>

<style scoped>
.pp-timeline {
  display: flex;
  margin: 0;
  padding: 0;
  list-style: none;
}

.pp-timeline--vertical {
  flex-direction: column;
}

.pp-timeline--horizontal {
  flex-direction: row;
}
</style>
