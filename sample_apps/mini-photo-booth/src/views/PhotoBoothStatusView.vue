<template>
  <div class="photo-pass-root" v-if="latest">
    <div class="status-top">
      <div class="film-heart-disc">💖</div>
      <h2>{{ t.paymentSuccess }}</h2>
      <span class="ref-no">{{ t.printCode }}: {{ latest.printPassCode }}</span>
    </div>

    <!-- Live Kiosk Instant Print Pass Card -->
    <div class="kiosk-print-card">
      <div class="kc-head">
        <span class="kc-tag">KIOSK INSTANT PRINT DISPATCH</span>
        <h3>{{ latest.theme.name }}</h3>
      </div>

      <div class="film-mini-strip-preview" :style="{ background: latest.theme.bgPattern }">
        <div class="mini-cut">✨</div>
        <div class="mini-cut">📸</div>
        <div class="mini-cut">🥰</div>
        <div class="mini-cut">💖</div>
      </div>

      <div class="kc-qr-area">
        <PPQRCode :value="latest.printPassCode" :size="130" />
        <span class="qr-sub">Scan under kiosk scanner to print physical strips</span>
      </div>
    </div>

    <div class="pass-actions">
      <PPButton variant="outline" block size="medium" @click="$router.push('/')">
        ← Back to Studio
      </PPButton>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { useRouter } from 'vue-router'
import { PPQRCode, PPButton } from '@phanna/ui-framework'
import { usePhotoBoothStore } from '../store/photoboothStore'
import { useI18n } from '../i18n'

const router = useRouter()
const store = usePhotoBoothStore()
const { t } = useI18n()

const latest = computed(() => store.state.latestSession || store.state.sessions[0])
</script>

<style scoped>
.photo-pass-root {
  min-height: 100vh;
  background: radial-gradient(circle at 50% 10%, #fdf4ff 0%, #fae8ff 100%);
  padding: 24px 16px;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 16px;
  color: #581c87;
}
.status-top { display: flex; flex-direction: column; align-items: center; text-align: center; }
.film-heart-disc {
  width: 60px; height: 60px; border-radius: 50%; background: #c026d3; color: white;
  display: flex; align-items: center; justify-content: center; font-size: 26px; margin-bottom: 8px;
}
.status-top h2 { font-size: 16px; font-weight: 900; margin: 0; color: #581c87; }
.ref-no { font-size: 10px; font-family: monospace; color: #86198f; margin-top: 4px; }

.kiosk-print-card {
  background: white; border-radius: 20px; padding: 18px; width: 100%; border: 1.5px solid #f0abfc;
  display: flex; flex-direction: column; gap: 14px; box-shadow: 0 10px 30px rgba(192,38,211,0.15);
}
.kc-head { display: flex; flex-direction: column; gap: 2px; border-bottom: 1px solid #fdf4ff; padding-bottom: 10px; }
.kc-tag { font-size: 8px; font-weight: 900; letter-spacing: 1.5px; color: #c026d3; }
.kc-head h3 { font-size: 14px; font-weight: 900; margin: 0; color: #581c87; }

.film-mini-strip-preview {
  display: flex; justify-content: space-around; padding: 8px; border-radius: 10px; border: 1px solid #f0abfc;
}
.mini-cut { width: 34px; height: 34px; background: white; border-radius: 4px; display: flex; align-items: center; justify-content: center; font-size: 14px; }

.kc-qr-area { display: flex; flex-direction: column; align-items: center; gap: 6px; }
.qr-sub { font-size: 9px; font-weight: 800; color: #581c87; }

.pass-actions { width: 100%; }
</style>
