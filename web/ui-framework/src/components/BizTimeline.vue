<template>
  <div class="biz-timeline" :class="[`biz-timeline--${direction}`]">
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
.biz-timeline {
  display: flex;
  margin: 0;
  padding: 0;
  list-style: none;
}

.biz-timeline--vertical {
  flex-direction: column;
}

.biz-timeline--horizontal {
  flex-direction: row;
}
</style>
