<template>
  <div 
    class="pp-video-player" 
    :class="{ 'is-fullscreen': isFullscreen, 'hide-cursor': isPlaying && !isControlsVisible }"
    @mousemove="showControls"
    @mouseleave="hideControlsDelayed"
  >
    <!-- Standard HTML5 Video -->
    <video 
      ref="videoRef"
      :src="src"
      :poster="poster"
      class="video-element"
      @timeupdate="onTimeUpdate"
      @loadedmetadata="onLoadedMetadata"
      @ended="onEnded"
      @play="isPlaying = true"
      @pause="isPlaying = false"
      @click="togglePlay"
    ></video>
    
    <!-- Big center play button (visible when paused) -->
    <div 
      v-if="!isPlaying" 
      class="center-play" 
      @click="togglePlay"
    >
      <ion-icon :icon="play" />
    </div>
    
    <!-- Custom Control Bar -->
    <div class="control-bar" :class="{ 'visible': isControlsVisible || !isPlaying }">
      <!-- Progress Bar -->
      <div class="progress-container" @click="seek">
        <div class="progress-bg"></div>
        <div class="progress-fill" :style="{ width: progressPercent + '%' }"></div>
        <div class="progress-knob" :style="{ left: progressPercent + '%' }"></div>
      </div>
      
      <div class="controls-row">
        <!-- Left Controls -->
        <div class="left-controls">
          <button class="ctrl-btn" @click="togglePlay">
            <ion-icon :icon="isPlaying ? pause : play" />
          </button>
          
          <div class="volume-container">
            <button class="ctrl-btn" @click="toggleMute">
              <ion-icon :icon="isMuted || volume === 0 ? volumeMute : (volume < 0.5 ? volumeLow : volumeHigh)" />
            </button>
            <input 
              type="range" 
              min="0" 
              max="1" 
              step="0.05" 
              v-model="volume" 
              class="volume-slider"
              @input="onVolumeChange"
            />
          </div>
          
          <div class="time-display">
            {{ formatTime(currentTime) }} / {{ formatTime(duration) }}
          </div>
        </div>
        
        <!-- Right Controls -->
        <div class="right-controls">
          <div class="playback-speed" @click="toggleSpeed">
            {{ playbackRate }}x
          </div>
          <button class="ctrl-btn" @click="toggleFullscreen">
            <ion-icon :icon="isFullscreen ? contract : expand" />
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted, onBeforeUnmount } from 'vue';
import { IonIcon } from '@ionic/vue';
import { play, pause, volumeHigh, volumeLow, volumeMute, expand, contract } from 'ionicons/icons';

interface Props {
  src: string;
  poster?: string;
  autoplay?: boolean;
}

const props = withDefaults(defineProps<Props>(), {
  autoplay: false
});

const videoRef = ref<HTMLVideoElement | null>(null);
const isPlaying = ref(false);
const isFullscreen = ref(false);
const isControlsVisible = ref(true);
const currentTime = ref(0);
const duration = ref(0);
const volume = ref(1);
const isMuted = ref(false);
const playbackRate = ref(1);
let hideControlsTimeout: any = null;

const progressPercent = computed(() => {
  if (duration.value === 0) return 0;
  return (currentTime.value / duration.value) * 100;
});

const formatTime = (seconds: number) => {
  const m = Math.floor(seconds / 60);
  const s = Math.floor(seconds % 60);
  return `${m}:${s.toString().padStart(2, '0')}`;
};

const togglePlay = () => {
  if (!videoRef.value) return;
  if (videoRef.value.paused) {
    videoRef.value.play();
  } else {
    videoRef.value.pause();
  }
};

const onTimeUpdate = () => {
  if (videoRef.value) {
    currentTime.value = videoRef.value.currentTime;
  }
};

const onLoadedMetadata = () => {
  if (videoRef.value) {
    duration.value = videoRef.value.duration;
  }
};

const onEnded = () => {
  isPlaying.value = false;
  isControlsVisible.value = true;
};

const seek = (e: MouseEvent) => {
  if (!videoRef.value) return;
  const rect = (e.currentTarget as HTMLElement).getBoundingClientRect();
  const pos = (e.clientX - rect.left) / rect.width;
  videoRef.value.currentTime = pos * duration.value;
};

const toggleMute = () => {
  if (!videoRef.value) return;
  isMuted.value = !isMuted.value;
  videoRef.value.muted = isMuted.value;
  if (!isMuted.value && volume.value === 0) {
    volume.value = 1;
    videoRef.value.volume = 1;
  }
};

const onVolumeChange = () => {
  if (!videoRef.value) return;
  videoRef.value.volume = volume.value;
  isMuted.value = volume.value === 0;
  videoRef.value.muted = isMuted.value;
};

const speedOptions = [0.5, 1, 1.25, 1.5, 2];
const toggleSpeed = () => {
  if (!videoRef.value) return;
  const currentIndex = speedOptions.indexOf(playbackRate.value);
  const nextIndex = (currentIndex + 1) % speedOptions.length;
  playbackRate.value = speedOptions[nextIndex];
  videoRef.value.playbackRate = playbackRate.value;
};

const toggleFullscreen = () => {
  const container = videoRef.value?.parentElement;
  if (!container) return;
  
  if (!document.fullscreenElement) {
    container.requestFullscreen().catch(err => {
      console.warn('Error attempting to enable fullscreen:', err.message);
    });
  } else {
    document.exitFullscreen();
  }
};

const handleFullscreenChange = () => {
  isFullscreen.value = !!document.fullscreenElement;
};

const showControls = () => {
  isControlsVisible.value = true;
  hideControlsDelayed();
};

const hideControlsDelayed = () => {
  clearTimeout(hideControlsTimeout);
  hideControlsTimeout = setTimeout(() => {
    if (isPlaying.value) {
      isControlsVisible.value = false;
    }
  }, 2500);
};

onMounted(() => {
  document.addEventListener('fullscreenchange', handleFullscreenChange);
  if (props.autoplay && videoRef.value) {
    videoRef.value.play().catch(e => console.log('Autoplay prevented by browser:', e));
  }
});

onBeforeUnmount(() => {
  document.removeEventListener('fullscreenchange', handleFullscreenChange);
  clearTimeout(hideControlsTimeout);
});
</script>

<style scoped>
.pp-video-player {
  position: relative;
  width: 100%;
  background: #000;
  border-radius: 12px;
  overflow: hidden;
  display: flex;
  font-family: system-ui, -apple-system, sans-serif;
}
.pp-video-player.is-fullscreen {
  border-radius: 0;
}
.pp-video-player.hide-cursor {
  cursor: none;
}

.video-element {
  width: 100%;
  height: 100%;
  max-height: 80vh;
  object-fit: contain;
}

.center-play {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 64px;
  height: 64px;
  background: rgba(0, 0, 0, 0.6);
  border-radius: 32px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  z-index: 10;
  transition: transform 0.2s;
}
.center-play:hover {
  transform: translate(-50%, -50%) scale(1.1);
  background: rgba(59, 130, 246, 0.8);
}
.center-play ion-icon {
  font-size: 32px;
  color: white;
  margin-left: 4px;
}

.control-bar {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  background: linear-gradient(to top, rgba(0,0,0,0.8) 0%, rgba(0,0,0,0) 100%);
  padding: 24px 16px 12px 16px;
  opacity: 0;
  transition: opacity 0.3s;
  pointer-events: none;
}
.control-bar.visible {
  opacity: 1;
  pointer-events: auto;
}

.progress-container {
  position: relative;
  height: 20px;
  cursor: pointer;
  display: flex;
  align-items: center;
  margin-bottom: 8px;
}
.progress-bg {
  position: absolute;
  left: 0;
  right: 0;
  height: 4px;
  background: rgba(255,255,255,0.3);
  border-radius: 2px;
}
.progress-fill {
  position: absolute;
  left: 0;
  height: 4px;
  background: var(--pp-primary, #3b82f6);
  border-radius: 2px;
  pointer-events: none;
}
.progress-knob {
  position: absolute;
  width: 12px;
  height: 12px;
  background: white;
  border-radius: 6px;
  transform: translateX(-50%);
  opacity: 0;
  transition: opacity 0.2s;
  pointer-events: none;
}
.progress-container:hover .progress-knob {
  opacity: 1;
}

.controls-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.left-controls, .right-controls {
  display: flex;
  align-items: center;
  gap: 16px;
}

.ctrl-btn {
  background: none;
  border: none;
  color: white;
  font-size: 24px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  padding: 0;
  opacity: 0.9;
}
.ctrl-btn:hover {
  opacity: 1;
}

.time-display {
  color: white;
  font-size: 13px;
  font-variant-numeric: tabular-nums;
}

.volume-container {
  display: flex;
  align-items: center;
  gap: 8px;
  width: 32px;
  overflow: hidden;
  transition: width 0.3s ease;
}
.volume-container:hover {
  width: 120px;
}
.volume-slider {
  width: 80px;
  accent-color: var(--pp-primary, #3b82f6);
  cursor: pointer;
}

.playback-speed {
  color: white;
  font-size: 14px;
  font-weight: 600;
  cursor: pointer;
  user-select: none;
}
</style>
