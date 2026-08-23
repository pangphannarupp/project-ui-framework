<template>
  <div class="pp-skeleton-wrapper">
    <template v-if="loading">
      <div class="pp-skeleton-template-container" :class="{ 'is-animated': animated }">
        <slot name="template">
          <!-- Fallbacks if no template provided -->
          <div class="pp-skeleton-fallback">
            <PPSkeletonItem v-for="i in rows" :key="i" variant="text" style="margin-bottom: 8px;" />
          </div>
        </slot>
      </div>
    </template>
    <template v-else>
      <slot></slot>
    </template>
  </div>
</template>

<script setup lang="ts">
import PPSkeletonItem from './PPSkeletonItem.vue';

withDefaults(defineProps<{
  loading?: boolean;
  animated?: boolean;
  rows?: number;
}>(), {
  loading: true,
  animated: true,
  rows: 3
});
</script>

<style scoped>
.pp-skeleton-wrapper {
  width: 100%;
}

.pp-skeleton-template-container.is-animated :deep(.pp-skeleton-item) {
  background: var(--pp-skeleton-bg, #f0f0f0);
  background: linear-gradient(
    90deg,
    var(--pp-skeleton-bg, #f0f0f0) 25%,
    var(--pp-skeleton-highlight, #e0e0e0) 50%,
    var(--pp-skeleton-bg, #f0f0f0) 75%
  );
  background-size: 200% 100%;
  animation: pp-shimmer 1.5s infinite;
}

@keyframes pp-shimmer {
  0% { background-position: 200% 0; }
  100% { background-position: -200% 0; }
}
</style>
