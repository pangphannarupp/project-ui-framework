<template>
  <div class="clinic-status-root" v-if="latest">
    <div class="status-top">
      <div class="pulse-ring">🩺</div>
      <h2>{{ t.paymentSuccess }}</h2>
      <span class="ref-no">{{ t.orderNumber }}: {{ latest.orderNumber }}</span>
    </div>

    <div class="video-room-pass">
      <div class="vr-badge">SECURE TELEHEALTH ROOM</div>
      <div class="vr-doctor">
        <img :src="latest.doctor.avatarUrl" class="vr-avatar" />
        <div class="vr-info">
          <h3>{{ latest.doctor.name[currentLanguage] || latest.doctor.name.en }}</h3>
          <span>{{ latest.doctor.specialty[currentLanguage] || latest.doctor.specialty.en }}</span>
        </div>
      </div>

      <div class="rx-qr-zone">
        <PPQRCode :value="latest.roomLink" :size="140" />
        <span class="qr-sub">Scan to connect secondary medical device</span>
      </div>

      <PPButton variant="primary" block size="large" @click="openVideoCall">
        {{ t.enterRoom }}
      </PPButton>
    </div>

    <div class="status-actions">
      <PPButton variant="outline" block size="medium" @click="$router.push('/')">
        ← Back to Clinic
      </PPButton>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { useRouter } from 'vue-router'
import { PPQRCode, PPButton } from '@phanna/ui-framework'
import { useClinicStore } from '../store/clinicStore'
import { useI18n } from '../i18n'

const router = useRouter()
const store = useClinicStore()
const { t, currentLanguage } = useI18n()

const latest = computed(() => store.state.latestAppointment || store.state.appointments[0])

const openVideoCall = () => {
  alert('Connecting to encrypted video consultation with ' + latest.value?.doctor.name.en)
}
</script>

<style scoped>
.clinic-status-root {
  min-height: 100vh;
  background: radial-gradient(circle at 50% 10%, #f0fdfa 0%, #e0f2fe 100%);
  padding: 24px 16px;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 16px;
}
.status-top { display: flex; flex-direction: column; align-items: center; text-align: center; }
.pulse-ring {
  width: 60px; height: 60px; border-radius: 50%; background: #0284c7; color: white;
  display: flex; align-items: center; justify-content: center; font-size: 26px; margin-bottom: 8px;
}
.status-top h2 { font-size: 16px; font-weight: 900; color: #0c4a6e; margin: 0; }
.ref-no { font-size: 11px; font-family: monospace; color: #64748b; margin-top: 4px; }

.video-room-pass {
  background: white; border-radius: 20px; padding: 18px; width: 100%; border: 1.5px solid #bae6fd;
  display: flex; flex-direction: column; gap: 14px; box-shadow: 0 10px 25px rgba(2,132,199,0.1);
}
.vr-badge { font-size: 8px; font-weight: 900; letter-spacing: 1.5px; color: #0284c7; text-align: center; }
.vr-doctor { display: flex; gap: 10px; align-items: center; border-bottom: 1px solid #e0f2fe; padding-bottom: 10px; }
.vr-avatar { width: 44px; height: 44px; border-radius: 10px; object-fit: cover; }
.vr-info h3 { font-size: 13px; font-weight: 900; margin: 0; }
.vr-info span { font-size: 10px; color: #0284c7; font-weight: 700; }

.rx-qr-zone { display: flex; flex-direction: column; align-items: center; gap: 6px; padding: 8px 0; }
.qr-sub { font-size: 9px; color: #64748b; }

.status-actions { width: 100%; }
</style>
