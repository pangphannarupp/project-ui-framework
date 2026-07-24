<template>
  <div class="pp-qr-code">
    <div class="qr-wrapper" :style="{ width: `${size}px`, height: `${size}px` }">
      <div v-if="loading" class="qr-skeleton"></div>
      <img 
        v-show="!loading"
        :src="qrUrl" 
        :width="size" 
        :height="size" 
        alt="QR Code"
        @load="loading = false"
        @error="loading = false"
      />
      <!-- Optional center logo -->
      <div v-if="logo" class="qr-logo">
        <img :src="logo" alt="Logo" />
      </div>
    </div>
    <div v-if="downloadable" class="qr-actions">
      <button class="download-btn" @click="downloadQR">Download QR</button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, watch } from 'vue';

const props = withDefaults(defineProps<{
  value: string;
  size?: number;
  logo?: string;
  downloadable?: boolean;
}>(), {
  size: 200,
  downloadable: false
});

const loading = ref(true);

const qrUrl = computed(() => {
  // Using a reliable free QR generation API to avoid heavy npm dependencies
  return `https://api.qrserver.com/v1/create-qr-code/?size=${props.size}x${props.size}&data=${encodeURIComponent(props.value)}&margin=10`;
});

watch(qrUrl, () => {
  loading.value = true;
});

const downloadQR = async () => {
  try {
    const response = await fetch(qrUrl.value);
    const blob = await response.blob();
    const url = window.URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = `qrcode.png`;
    document.body.appendChild(a);
    a.click();
    a.remove();
    window.URL.revokeObjectURL(url);
  } catch (err) {
    console.error('Failed to download QR code', err);
  }
};
</script>

<style scoped>
.pp-qr-code {
  display: inline-flex;
  flex-direction: column;
  align-items: center;
  gap: 16px;
  background: white;
  padding: 16px;
  border-radius: 16px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.05);
}

.qr-wrapper {
  position: relative;
  border-radius: 8px;
  overflow: hidden;
  background: #f8fafc;
}

.qr-skeleton {
  position: absolute;
  top: 0; left: 0; right: 0; bottom: 0;
  background: linear-gradient(90deg, #f1f5f9 25%, #e2e8f0 50%, #f1f5f9 75%);
  background-size: 200% 100%;
  animation: shimmer 1.5s infinite linear;
}

@keyframes shimmer {
  0% { background-position: 200% 0; }
  100% { background-position: -200% 0; }
}

.qr-logo {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 20%;
  height: 20%;
  background: white;
  border-radius: 8px;
  padding: 4px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.qr-logo img {
  width: 100%;
  height: 100%;
  object-fit: contain;
  border-radius: 4px;
}

.download-btn {
  background: #3b82f6;
  color: white;
  border: none;
  padding: 8px 16px;
  border-radius: 6px;
  font-size: 14px;
  font-weight: 600;
  cursor: pointer;
  transition: background 0.2s;
}

.download-btn:hover {
  background: #2563eb;
}
</style>
