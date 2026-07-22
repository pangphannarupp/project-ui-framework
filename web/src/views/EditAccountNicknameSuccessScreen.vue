<template>
  <ion-page>
    <div class="pp-screen pp-success-screen">
      <!-- Minimal App Bar for back or completely hidden? In the screenshot the app bar is not there, it's just the status bar -->
      
      <div class="success-content">
        <!-- Confetti/Success Graphic -->
        <div class="success-icon-wrapper">
          <svg viewBox="0 0 100 100" width="120" height="120" fill="none">
            <!-- Simplified party popper / confetti graphic -->
            <path d="M40 70 L30 80 C28 82 25 81 26 78 L32 62" fill="#c4d5e8"/>
            <path d="M30 80 L70 40 L60 30 L20 70 Z" fill="#7baaf7"/>
            <path d="M20 70 L25 75 L65 35 L60 30 Z" fill="#4a8cf6"/>
            <!-- Confetti pieces -->
            <circle cx="80" cy="20" r="3" fill="#ff4081" />
            <circle cx="70" cy="10" r="2" fill="#ffeb3b" />
            <circle cx="90" cy="35" r="2.5" fill="#00bcd4" />
            <circle cx="60" cy="25" r="1.5" fill="#ff9800" />
            <rect x="75" y="30" width="4" height="8" transform="rotate(45 75 30)" fill="#8bc34a" />
            <rect x="85" y="15" width="3" height="6" transform="rotate(-30 85 15)" fill="#9c27b0" />
          </svg>
        </div>
        
        <h2 class="success-title">Edit Nickname Success!</h2>
        <p class="success-desc">
          Your Account Nickname Has been<br/>
          Changed Successfully.
        </p>
      </div>

      <div class="action-footer">
        <PPButton block variant="primary" @click="goHome">
          Okay
        </PPButton>
      </div>
    </div>
  </ion-page>
</template>

<script setup lang="ts">
import { useRouter } from 'vue-router';
import { IonPage } from '@ionic/vue';
import { PPButton } from '@phanna/ui-framework';

const router = useRouter();

const goHome = () => {
  router.push('/home');
};
</script>

<style scoped>
.pp-screen {
  width: 100%;
  height: 100vh;
  position: relative;
  display: flex;
  flex-direction: column;
  background-color: white;
  padding: 0 20px;
}

.success-content {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  text-align: center;
  margin-top: -10vh; /* slightly elevated visually */
}

.success-icon-wrapper {
  margin-bottom: 24px;
}

.success-title {
  font-size: 22px;
  font-weight: 800;
  color: var(--pp-primary-variant, #1a2a5e);
  margin: 0 0 12px 0;
}

.success-desc {
  font-size: 14px;
  color: #666;
  line-height: 1.5;
  margin: 0;
}

.action-footer {
  margin-top: auto;
  padding-bottom: 32px;
}
</style>
