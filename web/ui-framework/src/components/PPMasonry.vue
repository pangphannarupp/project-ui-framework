<template>
  <div class="pp-masonry" :style="{ columnCount: columns, columnGap: gap + 'px' }">
    <slot></slot>
  </div>
</template>

<script setup lang="ts">
withDefaults(defineProps<{
  columns?: number;
  gap?: number;
}>(), {
  columns: 3,
  gap: 16
});
</script>

<style scoped>
.pp-masonry {
  width: 100%;
}

/* Ensure direct children break correctly */
.pp-masonry > :deep(*) {
  break-inside: avoid;
  margin-bottom: v-bind('gap + "px"');
  display: block;
  width: 100%;
}
</style>
