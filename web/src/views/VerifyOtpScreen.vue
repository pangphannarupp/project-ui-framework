<template>
  <ion-page>
    <div class="biz-screen biz-otp-screen">
      
      <!-- Top header -->
      <div class="otp-header">
        <button class="back-btn" @click="router.back()">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
            <polyline points="15 18 9 12 15 6"></polyline>
          </svg>
        </button>

        <h1 class="otp-title">Verify OTP</h1>
        <p class="otp-subtitle">We have sent the OTP to +855 12*** *66.</p>
      </div>

      <!-- Main card area -->
      <div class="otp-card">
        
        <div class="otp-section">
          <label class="otp-label">Enter OTP</label>
          <BizOtpInput v-model="otpCode" :length="6" @complete="handleComplete" />
          <div class="timer-text">Code will expire in <span>01:59</span></div>
        </div>

        <BizInfoCard type="warning" class="otp-info">
          If your device can't receive OTP automatically, just tap any blocks to get your OTP.
        </BizInfoCard>

        <!-- Tap Below Suggestion -->
        <div class="sms-suggestion" v-if="otpCode.length < 6">
          <div class="tap-below">Tap Below</div>
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="double-down">
            <polyline points="7 13 12 18 17 13"></polyline>
            <polyline points="7 6 12 11 17 6"></polyline>
          </svg>
          <button class="sms-pill" @click="otpCode = '101736'; handleComplete('101736')">
            From SMS<br>
            <strong>101736</strong>
          </button>
        </div>

      </div>

    </div>
  </ion-page>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import { IonPage } from '@ionic/vue';
import { BizOtpInput, BizInfoCard } from '@bizmob-core/ui-framework';

const router = useRouter();
const otpCode = ref('');

const handleComplete = (val: string) => {
  if (val === '101736') {
    setTimeout(() => {
      router.push('/document-verification');
    }, 300);
  }
};
</script>

<style scoped>
.biz-otp-screen {
  display: flex;
  flex-direction: column;
  height: 100vh;
  background-color: var(--biz-primary-color, var(--biz-primary, #003399));
  position: relative;
  overflow: hidden;
}

.otp-header {
  padding: 56px 24px 24px 24px;
  color: white;
}

.back-btn {
  background: transparent;
  border: none;
  color: white;
  padding: 0;
  margin-bottom: 24px;
  cursor: pointer;
}

.back-btn svg {
  width: 24px;
  height: 24px;
}

.otp-title {
  font-size: 28px;
  font-weight: 700;
  margin: 0 0 8px 0;
  line-height: 1.2;
}

.otp-subtitle {
  font-size: 13px;
  opacity: 0.9;
  line-height: 1.5;
  margin: 0;
}

.otp-card {
  flex: 1;
  background-color: white;
  border-top-left-radius: 24px;
  border-top-right-radius: 24px;
  padding: 32px 24px 24px 24px;
  display: flex;
  flex-direction: column;
}

.otp-section {
  margin-bottom: 24px;
}

.otp-label {
  display: block;
  font-size: 12px;
  color: #555;
  margin-bottom: 8px;
}

.timer-text {
  font-size: 13px;
  color: #555;
  margin-top: 12px;
}
.timer-text span {
  color: #0066cc;
  font-weight: 600;
}

.otp-info {
  margin-bottom: auto;
}

/* SMS Suggestion */
.sms-suggestion {
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-top: auto;
  padding-top: 40px;
}

.tap-below {
  font-size: 13px;
  color: var(--biz-primary-variant, #1a2a5e);
  font-weight: 600;
}

.double-down {
  width: 20px;
  height: 20px;
  color: var(--biz-primary-variant, #1a2a5e);
  margin: 4px 0 12px 0;
}

.sms-pill {
  background-color: #e5e5ea;
  border: none;
  border-radius: 24px;
  padding: 12px 32px;
  font-size: 12px;
  color: #111;
  text-align: center;
  cursor: pointer;
  line-height: 1.4;
}
.sms-pill strong {
  font-size: 14px;
  display: block;
}
</style>
