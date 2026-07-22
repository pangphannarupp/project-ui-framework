<template>
  <ion-page>
    <div class="pp-screen pp-doc-screen">
      
      <!-- Top header -->
      <div class="doc-header">
        <button class="back-btn" @click="router.back()">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
            <polyline points="15 18 9 12 15 6"></polyline>
          </svg>
        </button>

        <h1 class="doc-title">Document Verification</h1>
        <p class="doc-subtitle">Please prepare your valid National ID (new version) or Passport.</p>
      </div>

      <!-- Main card area -->
      <div class="doc-card">
        
        <div class="illustration-area">
          <div class="placeholder-graphic">
            <div class="graphic-circle"></div>
            <!-- Emoji placeholder for the complex 3D graphic -->
            <span class="emoji-stack">
              📱<span class="emoji-overlay-1">🛡️</span><span class="emoji-overlay-2">🪪</span>
            </span>
          </div>
        </div>

        <div class="requirements-box">
          <div class="req-item">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="check-icon">
              <circle cx="12" cy="12" r="10"></circle>
              <polyline points="8 12 11 15 16 9"></polyline>
            </svg>
            <span>Prepare your valid National ID or Passport.</span>
          </div>
          <div class="req-item">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="check-icon">
              <circle cx="12" cy="12" r="10"></circle>
              <polyline points="8 12 11 15 16 9"></polyline>
            </svg>
            <span>The National ID or Passport must not be expired.</span>
          </div>
        </div>

        <div class="action-area">
          <PPButton variant="primary" block @click="router.push('/confirm-info')">Get Started</PPButton>
        </div>

      </div>

    </div>
  </ion-page>
</template>

<script setup lang="ts">
import { useRouter } from 'vue-router';
import { IonPage } from '@ionic/vue';
import { PPButton } from '@phanna/ui-framework';

const router = useRouter();
</script>

<style scoped>
.pp-doc-screen {
  display: flex;
  flex-direction: column;
  height: 100vh;
  background-color: var(--pp-primary-color, var(--pp-primary, #003399));
  position: relative;
  overflow: hidden;
}

.doc-header {
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

.doc-title {
  font-size: 26px;
  font-weight: 700;
  margin: 0 0 8px 0;
  line-height: 1.2;
}

.doc-subtitle {
  font-size: 13px;
  opacity: 0.9;
  line-height: 1.5;
  margin: 0;
}

.doc-card {
  flex: 1;
  background-color: white;
  border-top-left-radius: 24px;
  border-top-right-radius: 24px;
  padding: 40px 24px 32px 24px;
  display: flex;
  flex-direction: column;
}

.illustration-area {
  display: flex;
  justify-content: center;
  margin-bottom: 40px;
}

.placeholder-graphic {
  position: relative;
  width: 200px;
  height: 200px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.graphic-circle {
  position: absolute;
  width: 140px;
  height: 140px;
  background-color: #f0f5ff;
  border-radius: 50%;
  z-index: 1;
}

.emoji-stack {
  position: relative;
  font-size: 100px;
  z-index: 2;
  line-height: 1;
}

.emoji-overlay-1 {
  position: absolute;
  font-size: 40px;
  left: -20px;
  top: 20px;
  filter: drop-shadow(0 4px 8px rgba(0,0,0,0.1));
}

.emoji-overlay-2 {
  position: absolute;
  font-size: 60px;
  right: -30px;
  bottom: 0px;
  transform: rotate(15deg);
  filter: drop-shadow(0 8px 16px rgba(0,0,0,0.15));
}

.requirements-box {
  background-color: #f5f8ff;
  border-radius: 16px;
  padding: 16px;
  display: flex;
  flex-direction: column;
  gap: 12px;
  margin-bottom: auto; /* push action area to bottom */
}

.req-item {
  display: flex;
  align-items: flex-start;
  gap: 12px;
}

.check-icon {
  width: 16px;
  height: 16px;
  color: #0066cc;
  flex-shrink: 0;
  margin-top: 2px;
}

.req-item span {
  font-size: 12px;
  color: #333;
  line-height: 1.5;
  font-weight: 500;
}

.action-area {
  margin-top: 40px;
}
</style>
