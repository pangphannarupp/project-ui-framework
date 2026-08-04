<template>
  <div class="pp-audio-recorder" :class="{ recording: isRecording }">
    <div class="visualizer-container">
      <div v-if="!hasRecording" class="time-display" :class="{ active: isRecording }">
        {{ formattedTime }}
      </div>
      
      <!-- Audio Player when recording is done -->
      <div v-if="hasRecording && audioUrl" class="audio-player">
        <audio ref="audioPlayerRef" :src="audioUrl" controls style="width: 100%;"></audio>
      </div>
      
      <!-- Waveform representation (Mock) -->
      <div v-if="isRecording" class="waveform">
        <div v-for="i in 20" :key="i" class="bar" :style="getBarStyle()"></div>
      </div>
    </div>
    
    <div class="controls">
      <template v-if="!hasRecording">
        <button v-if="!isRecording" class="record-btn" @click="startRecording">
          <div class="inner-circle"></div>
        </button>
        <button v-else class="stop-btn" @click="stopRecording">
          <div class="inner-square"></div>
        </button>
      </template>
      
      <template v-else>
        <PPIconButton @click="discardRecording" color="danger" variant="outline">
          <ion-icon :icon="trashOutline" />
        </PPIconButton>
        <PPButton @click="confirmRecording" color="primary">Use Audio</PPButton>
      </template>
    </div>
    
    <div v-if="error" class="error-msg">{{ error }}</div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onBeforeUnmount } from 'vue';
import { IonIcon } from '@ionic/vue';
import { trashOutline } from 'ionicons/icons';
import PPIconButton from './PPIconButton.vue';
import PPButton from './PPButton.vue';

const emit = defineEmits<{
  (e: 'recording-complete', audioBlob: Blob): void;
}>();

const isRecording = ref(false);
const hasRecording = ref(false);
const recordingTime = ref(0);
const error = ref<string | null>(null);
const audioUrl = ref<string | null>(null);

let mediaRecorder: MediaRecorder | null = null;
let audioChunks: Blob[] = [];
let timerInterval: any = null;
let stream: MediaStream | null = null;

const formattedTime = computed(() => {
  const mins = Math.floor(recordingTime.value / 60);
  const secs = recordingTime.value % 60;
  return `${mins.toString().padStart(2, '0')}:${secs.toString().padStart(2, '0')}`;
});

const startRecording = async () => {
  error.value = null;
  audioChunks = [];
  
  try {
    stream = await navigator.mediaDevices.getUserMedia({ audio: true });
    mediaRecorder = new MediaRecorder(stream);
    
    mediaRecorder.ondataavailable = (event) => {
      if (event.data.size > 0) {
        audioChunks.push(event.data);
      }
    };
    
    mediaRecorder.onstop = () => {
      const audioBlob = new Blob(audioChunks, { type: 'audio/webm' });
      audioUrl.value = URL.createObjectURL(audioBlob);
      hasRecording.value = true;
    };
    
    mediaRecorder.start();
    isRecording.value = true;
    
    // Start Timer
    recordingTime.value = 0;
    timerInterval = setInterval(() => {
      recordingTime.value++;
    }, 1000);
    
  } catch (err: any) {
    error.value = 'Microphone access denied: ' + err.message;
  }
};

const stopRecording = () => {
  if (mediaRecorder && mediaRecorder.state === 'recording') {
    mediaRecorder.stop();
  }
  
  if (stream) {
    stream.getTracks().forEach(track => track.stop());
  }
  
  isRecording.value = false;
  clearInterval(timerInterval);
};

const discardRecording = () => {
  if (audioUrl.value) {
    URL.revokeObjectURL(audioUrl.value);
  }
  audioUrl.value = null;
  hasRecording.value = false;
  recordingTime.value = 0;
};

const confirmRecording = () => {
  const audioBlob = new Blob(audioChunks, { type: 'audio/webm' });
  emit('recording-complete', audioBlob);
};

const getBarStyle = () => {
  const height = Math.random() * 100 + 10;
  return {
    height: `${height}%`,
    animationDuration: `${Math.random() * 0.5 + 0.2}s`
  };
};

onBeforeUnmount(() => {
  if (isRecording.value) stopRecording();
  if (audioUrl.value) URL.revokeObjectURL(audioUrl.value);
});
</script>

<style scoped>
.pp-audio-recorder {
  background: var(--pp-background, white);
  border: 1px solid var(--pp-border, #e2e8f0);
  border-radius: 12px;
  padding: 24px;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 24px;
  transition: all 0.3s ease;
}
.pp-audio-recorder.recording {
  border-color: #ef4444;
  box-shadow: 0 0 0 4px rgba(239, 68, 68, 0.1);
}

.visualizer-container {
  height: 80px;
  width: 100%;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  position: relative;
}

.time-display {
  font-size: 32px;
  font-weight: 700;
  font-variant-numeric: tabular-nums;
  color: #64748b;
  transition: color 0.3s;
}
.time-display.active {
  color: #ef4444;
}

.waveform {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  height: 40px;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 4px;
  opacity: 0.5;
}
.bar {
  width: 4px;
  background: #ef4444;
  border-radius: 2px;
  animation: bounce infinite ease-in-out alternate;
}
@keyframes bounce {
  0% { transform: scaleY(0.3); }
  100% { transform: scaleY(1); }
}

.controls {
  display: flex;
  gap: 16px;
  align-items: center;
  justify-content: center;
}

.record-btn, .stop-btn {
  width: 64px;
  height: 64px;
  border-radius: 32px;
  border: 4px solid #ef4444;
  background: transparent;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.2s;
}

.record-btn .inner-circle {
  width: 44px;
  height: 44px;
  border-radius: 22px;
  background: #ef4444;
  transition: all 0.2s;
}

.stop-btn .inner-square {
  width: 24px;
  height: 24px;
  border-radius: 4px;
  background: #ef4444;
}

.error-msg {
  color: #ef4444;
  font-size: 14px;
  text-align: center;
}
</style>
