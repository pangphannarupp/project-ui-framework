<template>
  <div class="pp-timeline" :class="[`pp-timeline--${direction}`]">
    <slot></slot>
  </div>
</template>

<script setup lang="ts">
import { provide } from 'vue';

const props = defineProps({
  direction: {
    type: String,
    default: 'vertical', // 'vertical' or 'horizontal'
  }
});

provide('bizTimelineDirection', props.direction);
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
