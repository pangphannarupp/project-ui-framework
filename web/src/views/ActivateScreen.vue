<template>
  <ion-page>
    <div class="biz-screen biz-activate-screen">
    
    <div class="auth-header">
      <BizIconButton color="white" style="background: transparent; margin-bottom: 24px;" @click="router.push('/')">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round">
          <polyline points="15 18 9 12 15 6"></polyline>
        </svg>
      </BizIconButton>
      <h1 class="auth-title">Activate Your SmartBiz Account</h1>
      <p class="auth-subtitle">Re-verify the phone number registered with PPCBank to begin account activation.</p>
    </div>
    
    <div class="auth-card">
      <BizPhoneInput 
        v-model="phoneNumber" 
        label="Phone Number" 
        placeholder="12 *** *66"
      />
      
      <p class="auth-help-text">
        If you no longer use this phone number. Please update it before activating.
      </p>
      <a href="#" class="auth-link">Change Phone Number?</a>
      
      <div class="auth-footer">
        <BizButton variant="primary" block @click="router.push('/verify-otp')">Next</BizButton>
      </div>
    </div>

    </div>
  </ion-page>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import { IonPage } from '@ionic/vue';
import { BizIconButton, BizPhoneInput, BizButton } from '@phanna/ui-framework';

const router = useRouter();
const phoneNumber = ref('');
</script>

<style scoped>
.biz-screen {
  width: 100%;
  height: 100vh;
  position: relative;
  overflow-y: auto;
  overflow-x: hidden;
  background-color: var(--biz-primary, #003399);
  display: flex;
  flex-direction: column;
}

.auth-header {
  padding: 40px 24px 24px;
  color: white;
}

.auth-title {
  font-size: 28px;
  font-weight: 800;
  margin: 0 0 12px 0;
  line-height: 1.2;
}

.auth-subtitle {
  font-size: 14px;
  opacity: 0.9;
  line-height: 1.5;
  margin: 0;
}

.auth-card {
  flex: 1;
  background: white;
  border-top-left-radius: 24px;
  border-top-right-radius: 24px;
  padding: 32px 24px;
  display: flex;
  flex-direction: column;
}

.auth-help-text {
  font-size: 13px;
  color: #666;
  line-height: 1.5;
  margin: 16px 0 8px 0;
}

.auth-link {
  font-size: 14px;
  color: #1a75ff;
  text-decoration: underline;
  font-weight: 500;
}

.auth-footer {
  margin-top: auto;
  padding-top: 40px;
  padding-bottom: env(safe-area-inset-bottom, 20px);
}
</style>
