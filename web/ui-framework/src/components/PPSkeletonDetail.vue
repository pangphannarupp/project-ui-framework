<template>
  <div class="pp-skeleton-detail">
    <!-- Hero Image Placeholder -->
    <div class="pp-skeleton pp-skeleton-hero"></div>
    
    <!-- Content Area -->
    <div class="pp-skeleton-content">
      <!-- Title & Meta -->
      <div class="pp-skeleton pp-skeleton-h1"></div>
      <div class="pp-skeleton-meta">
        <div class="pp-skeleton" style="width: 30%; height: 12px; border-radius: 4px;"></div>
        <div class="pp-skeleton" style="width: 20%; height: 12px; border-radius: 4px;"></div>
      </div>
      
      <!-- Paragraphs -->
      <div class="pp-skeleton-paragraph" v-for="p in paragraphs" :key="p">
        <div class="pp-skeleton" style="width: 100%; height: 12px; border-radius: 4px;"></div>
        <div class="pp-skeleton" style="width: 95%; height: 12px; border-radius: 4px;"></div>
        <div class="pp-skeleton" style="width: 98%; height: 12px; border-radius: 4px;"></div>
        <div class="pp-skeleton" :style="{ width: getRandomWidth(40, 80) + '%', height: '12px', borderRadius: '4px' }"></div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">

withDefaults(defineProps<{
  paragraphs?: number;
}>(), {
  paragraphs: 3
});

const getRandomWidth = (min: number, max: number) => {
  return Math.floor(Math.random() * (max - min + 1)) + min;
};
</script>

<style scoped>
.pp-skeleton-detail {
  width: 100%;
  display: flex;
  flex-direction: column;
}

.pp-skeleton-hero {
  width: 100%;
  height: 240px;
  margin: 0;
  border-radius: 0;
}

.pp-skeleton-content {
  padding: 24px 16px;
  display: flex;
  flex-direction: column;
  gap: 24px;
}

.pp-skeleton-h1 {
  width: 75%;
  height: 28px;
  border-radius: 6px;
  margin: 0;
}

.pp-skeleton-meta {
  display: flex;
  gap: 16px;
  margin-top: -8px;
}

.pp-skeleton-paragraph {
  display: flex;
  flex-direction: column;
  gap: 8px;
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
