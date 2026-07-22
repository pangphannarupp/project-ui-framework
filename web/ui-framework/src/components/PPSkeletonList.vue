<template>
  <div class="pp-skeleton-list">
    <div 
      v-for="i in count" 
      :key="i" 
      class="pp-skeleton-item"
    >
      <div v-if="avatar" class="pp-skeleton pp-skeleton-avatar"></div>
      <div class="pp-skeleton-text-container">
        <div class="pp-skeleton pp-skeleton-title" :style="{ width: getRandomWidth(40, 70) + '%' }"></div>
        <div class="pp-skeleton pp-skeleton-subtitle" :style="{ width: getRandomWidth(60, 90) + '%' }"></div>
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
.pp-skeleton-list {
  display: flex;
  flex-direction: column;
  width: 100%;
}

.pp-skeleton-item {
  display: flex;
  align-items: center;
  padding: 16px;
  border-bottom: 1px solid #f0f0f0;
}

.pp-skeleton-avatar {
  width: 48px;
  height: 48px;
  border-radius: 50%;
  margin-right: 16px;
  flex-shrink: 0;
}

.pp-skeleton-text-container {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.pp-skeleton-title {
  height: 16px;
  border-radius: 4px;
  margin: 0;
}

.pp-skeleton-subtitle {
  height: 12px;
  border-radius: 4px;
  margin: 0;
}

.pp-skeleton {
  background: #f0f0f0;
  background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
  background-size: 200% 100%;
  animation: pp-shimmer 1.5s infinite;
}

@keyframes pp-shimmer {
  0% {
    background-position: 200% 0;
  }
  100% {
    background-position: -200% 0;
  }
}
</style>
