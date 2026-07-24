<template>
  <div class="pp-audio-wave" :class="{ 'is-playing': isPlaying }" @click="togglePlay">
    <button class="play-btn">
      <span class="icon">{{ isPlaying ? '⏸' : '▶' }}</span>
    </button>
    <div class="wave-container">
      <div 
        v-for="n in bars" 
        :key="n" 
        class="wave-bar"
        :style="{ 
          height: isPlaying ? `${Math.random() * 80 + 20}%` : '20%',
          animationDelay: `${n * 0.1}s`
        }"
      ></div>
    </div>
    <div class="time">{{ isPlaying ? '0:14' : '0:00' }}</div>
  </div>
</template>

<script setup lang="ts">
import { ref, onUnmounted } from 'vue';

withDefaults(defineProps<{
  bars?: number;
}>(), {
  bars: 30
});

const isPlaying = ref(false);
let interval: any = null;

const togglePlay = () => {
  isPlaying.value = !isPlaying.value;
  if (isPlaying.value) {
    interval = setInterval(() => {
      // Force reactivity update to recalculate Math.random() in template
      isPlaying.value = false;
      isPlaying.value = true;
    }, 150);
  } else {
    clearInterval(interval);
  }
};

onUnmounted(() => {
  clearInterval(interval);
});
</script>

<style scoped>
.pp-audio-wave {
  display: flex;
  align-items: center;
  gap: 12px;
  background: #f1f5f9;
  padding: 8px 16px;
  border-radius: 30px;
  width: max-content;
  cursor: pointer;
  transition: background 0.2s;
}

.pp-audio-wave:hover {
  background: #e2e8f0;
}

.play-btn {
  background: #3b82f6;
  color: white;
  border: none;
  width: 36px;
  height: 36px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  box-shadow: 0 2px 8px rgba(59, 130, 246, 0.3);
}

.play-btn .icon {
  font-size: 14px;
  margin-left: 2px;
}
.is-playing .play-btn .icon {
  margin-left: 0;
}

.wave-container {
  display: flex;
  align-items: center;
  gap: 3px;
  height: 24px;
  width: 120px;
}

.wave-bar {
  flex: 1;
  background: #94a3b8;
  border-radius: 2px;
  transition: height 0.15s ease;
}

.is-playing .wave-bar {
  background: #3b82f6;
}

.time {
  font-size: 12px;
  font-weight: 600;
  color: #64748b;
  min-width: 32px;
}
</style>
