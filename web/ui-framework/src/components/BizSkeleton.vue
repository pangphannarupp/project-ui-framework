<template>
  <div class="biz-skeleton-wrapper">
    <template v-if="loading">
      <div class="biz-skeleton-template-container" :class="{ 'is-animated': animated }">
        <slot name="template">
          <!-- Fallbacks if no template provided -->
          <div class="biz-skeleton-fallback">
            <BizSkeletonItem v-for="i in rows" :key="i" variant="text" style="margin-bottom: 8px;" />
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
import BizSkeletonItem from './BizSkeletonItem.vue';

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
.biz-skeleton-wrapper {
  width: 100%;
}

.biz-skeleton-template-container.is-animated :deep(.biz-skeleton-item) {
  background: #f0f0f0;
  background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
  background-size: 200% 100%;
  animation: biz-shimmer 1.5s infinite;
}

@keyframes biz-shimmer {
  0% { background-position: 200% 0; }
  100% { background-position: -200% 0; }
}
</style>
