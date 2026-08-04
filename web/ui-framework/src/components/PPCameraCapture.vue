<template>
  <div class="pp-camera-capture" :style="cssVars">
    <div v-if="error" class="camera-error">
      <ion-icon :icon="warningOutline" />
      <p>{{ error }}</p>
      <PPButton size="small" @click="startCamera">Retry</PPButton>
    </div>
    
    <div v-else-if="imageCaptured" class="camera-preview">
      <img :src="imageCaptured" alt="Captured" />
      <div class="camera-controls">
        <PPIconButton @click="retake" color="danger">
          <ion-icon :icon="closeOutline" />
        </PPIconButton>
        <PPIconButton @click="confirm" color="success">
          <ion-icon :icon="checkmarkOutline" />
        </PPIconButton>
      </div>
    </div>
    
    <div v-else class="camera-stream">
      <video ref="videoRef" autoplay playsinline muted></video>
      <canvas ref="canvasRef" style="display: none;"></canvas>
      
      <!-- Overlays -->
      <div class="overlay" :class="overlayMode">
        <div v-if="overlayMode === 'document'" class="overlay-document"></div>
        <div v-if="overlayMode === 'selfie'" class="overlay-selfie"></div>
        <div v-if="overlayMode === 'barcode'" class="overlay-barcode">
          <div class="scanner-line"></div>
        </div>
      </div>

      <div class="camera-controls">
        <PPIconButton @click="toggleCamera" color="secondary" v-if="hasMultipleCameras">
          <ion-icon :icon="cameraReverseOutline" />
        </PPIconButton>
        <button class="capture-button" @click="capture" :disabled="!isStreamActive"></button>
        <PPIconButton @click="$emit('cancel')" color="transparent" style="color: white;">
          <ion-icon :icon="closeOutline" />
        </PPIconButton>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, onBeforeUnmount, computed } from 'vue';
import { IonIcon } from '@ionic/vue';
import { warningOutline, cameraReverseOutline, closeOutline, checkmarkOutline } from 'ionicons/icons';
import PPIconButton from './PPIconButton.vue';
import PPButton from './PPButton.vue';

interface Props {
  overlayMode?: 'none' | 'document' | 'selfie' | 'barcode';
  facingMode?: 'user' | 'environment';
  width?: number | string;
  height?: number | string;
}

const props = withDefaults(defineProps<Props>(), {
  overlayMode: 'none',
  facingMode: 'environment',
  width: '100%',
  height: '100%'
});

const emit = defineEmits<{
  (e: 'capture', imageDataUrl: string): void;
  (e: 'cancel'): void;
}>();

const videoRef = ref<HTMLVideoElement | null>(null);
const canvasRef = ref<HTMLCanvasElement | null>(null);
const stream = ref<MediaStream | null>(null);
const error = ref<string | null>(null);
const imageCaptured = ref<string | null>(null);
const currentFacingMode = ref(props.facingMode);
const hasMultipleCameras = ref(false);
const isStreamActive = ref(false);

const cssVars = computed(() => ({
  '--camera-width': typeof props.width === 'number' ? `${props.width}px` : props.width,
  '--camera-height': typeof props.height === 'number' ? `${props.height}px` : props.height
}));

const checkDevices = async () => {
  try {
    const devices = await navigator.mediaDevices.enumerateDevices();
    const videoDevices = devices.filter(device => device.kind === 'videoinput');
    hasMultipleCameras.value = videoDevices.length > 1;
  } catch (err) {
    console.error('Error checking devices:', err);
  }
};

const startCamera = async () => {
  error.value = null;
  stopCamera();
  
  try {
    const constraints = {
      video: {
        facingMode: currentFacingMode.value,
        width: { ideal: 1920 },
        height: { ideal: 1080 }
      },
      audio: false
    };
    
    stream.value = await navigator.mediaDevices.getUserMedia(constraints);
    
    if (videoRef.value) {
      videoRef.value.srcObject = stream.value;
      videoRef.value.onloadedmetadata = () => {
        isStreamActive.value = true;
      };
    }
  } catch (err: any) {
    error.value = 'Camera access denied or not available. ' + err.message;
    isStreamActive.value = false;
  }
};

const stopCamera = () => {
  if (stream.value) {
    stream.value.getTracks().forEach(track => track.stop());
    stream.value = null;
    isStreamActive.value = false;
  }
};

const toggleCamera = () => {
  currentFacingMode.value = currentFacingMode.value === 'user' ? 'environment' : 'user';
  startCamera();
};

const capture = () => {
  if (!videoRef.value || !canvasRef.value) return;
  
  const video = videoRef.value;
  const canvas = canvasRef.value;
  
  canvas.width = video.videoWidth;
  canvas.height = video.videoHeight;
  
  const ctx = canvas.getContext('2d');
  if (ctx) {
    // Handle mirroring for front camera
    if (currentFacingMode.value === 'user') {
      ctx.translate(canvas.width, 0);
      ctx.scale(-1, 1);
    }
    ctx.drawImage(video, 0, 0, canvas.width, canvas.height);
    imageCaptured.value = canvas.toDataURL('image/jpeg', 0.9);
    stopCamera();
  }
};

const retake = () => {
  imageCaptured.value = null;
  startCamera();
};

const confirm = () => {
  if (imageCaptured.value) {
    emit('capture', imageCaptured.value);
  }
};

onMounted(() => {
  checkDevices();
  startCamera();
});

onBeforeUnmount(() => {
  stopCamera();
});
</script>

<style scoped>
.pp-camera-capture {
  position: relative;
  width: var(--camera-width);
  height: var(--camera-height);
  background: #000;
  border-radius: 12px;
  overflow: hidden;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  min-height: 300px;
}

.camera-error {
  color: white;
  text-align: center;
  padding: 24px;
}
.camera-error ion-icon {
  font-size: 48px;
  color: #ef4444;
  margin-bottom: 16px;
}

.camera-stream, .camera-preview {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  display: flex;
  flex-direction: column;
}

video, img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

/* Overlays */
.overlay {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  pointer-events: none;
}
.overlay-document {
  position: absolute;
  top: 15%;
  bottom: 25%;
  left: 10%;
  right: 10%;
  border: 2px dashed rgba(255,255,255,0.7);
  border-radius: 8px;
  background: rgba(0,0,0,0.2);
  box-shadow: 0 0 0 9999px rgba(0,0,0,0.5);
}
.overlay-selfie {
  position: absolute;
  top: 15%;
  left: 50%;
  transform: translateX(-50%);
  width: 250px;
  height: 350px;
  border: 2px dashed rgba(255,255,255,0.7);
  border-radius: 50%;
  box-shadow: 0 0 0 9999px rgba(0,0,0,0.5);
}
.overlay-barcode {
  position: absolute;
  top: 35%;
  left: 15%;
  right: 15%;
  height: 120px;
  border: 2px solid rgba(255,255,255,0.8);
  border-radius: 8px;
  box-shadow: 0 0 0 9999px rgba(0,0,0,0.6);
}
.scanner-line {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 2px;
  background: #3b82f6;
  box-shadow: 0 0 4px #3b82f6;
  animation: scan 2s linear infinite;
}
@keyframes scan {
  0% { top: 0; }
  50% { top: 100%; }
  100% { top: 0; }
}

/* Controls */
.camera-controls {
  position: absolute;
  bottom: 24px;
  left: 0;
  right: 0;
  display: flex;
  justify-content: space-evenly;
  align-items: center;
  z-index: 10;
}

.capture-button {
  width: 64px;
  height: 64px;
  border-radius: 32px;
  background: white;
  border: 4px solid rgba(255,255,255,0.5);
  box-shadow: 0 0 0 2px white;
  cursor: pointer;
  transition: transform 0.1s ease;
}
.capture-button:active {
  transform: scale(0.9);
}
.capture-button:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}
</style>
