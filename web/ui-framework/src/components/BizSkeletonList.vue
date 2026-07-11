<template>
  <div class="biz-skeleton-list">
    <div 
      v-for="i in count" 
      :key="i" 
      class="biz-skeleton-item"
    >
      <div v-if="avatar" class="biz-skeleton biz-skeleton-avatar"></div>
      <div class="biz-skeleton-text-container">
        <div class="biz-skeleton biz-skeleton-title" :style="{ width: getRandomWidth(40, 70) + '%' }"></div>
        <div class="biz-skeleton biz-skeleton-subtitle" :style="{ width: getRandomWidth(60, 90) + '%' }"></div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">

withDefaults(defineProps<{
  count?: number;
  avatar?: boolean;
}>(), {
  count: 5,
  avatar: true
});

const getRandomWidth = (min: number, max: number) => {
  return Math.floor(Math.random() * (max - min + 1)) + min;
};
</script>

<style scoped>
.biz-skeleton-list {
  display: flex;
  flex-direction: column;
  width: 100%;
}

.biz-skeleton-item {
  display: flex;
  align-items: center;
  padding: 16px;
  border-bottom: 1px solid #f0f0f0;
}

.biz-skeleton-avatar {
  width: 48px;
  height: 48px;
  border-radius: 50%;
  margin-right: 16px;
  flex-shrink: 0;
}

.biz-skeleton-text-container {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.biz-skeleton-title {
  height: 16px;
  border-radius: 4px;
  margin: 0;
}

.biz-skeleton-subtitle {
  height: 12px;
  border-radius: 4px;
  margin: 0;
}

.biz-skeleton {
  background: #f0f0f0;
  background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
  background-size: 200% 100%;
  animation: biz-shimmer 1.5s infinite;
}

@keyframes biz-shimmer {
  0% {
    background-position: 200% 0;
  }
  100% {
    background-position: -200% 0;
  }
}
</style>
