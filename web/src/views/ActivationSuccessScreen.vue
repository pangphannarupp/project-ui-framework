<template>
  <ion-page>
    <div class="biz-screen biz-success-screen">
      
      <!-- Content Area -->
      <div class="success-content">
        <!-- Illustration Placeholder -->
        <div class="illustration-container">
          <div class="confetti-emoji">🎉</div>
          <!-- A soft shadow under the illustration -->
          <div class="illustration-shadow"></div>
        </div>

        <h1 class="success-title">Activation Success!</h1>
        <p class="success-subtitle">
          The smartBiz activation completed successfully.<br>
          You can access smartBiz Web by scanning<br>
          the QR code displayed in log in screen.
        </p>

        <!-- Info Card -->
        <div class="web-access-card">
          <div class="card-header">
            <div class="laptop-icon-wrapper">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" class="laptop-icon">
                <rect x="2" y="3" width="20" height="14" rx="2" ry="2"></rect>
                <line x1="2" y1="20" x2="22" y2="20"></line>
                <!-- Globe inside screen -->
                <circle cx="12" cy="10" r="4"></circle>
                <line x1="8" y1="10" x2="16" y2="10"></line>
                <path d="M12 6a4 4 0 0 0-4 4 4 4 0 0 0 4 4 4 4 0 0 0 4-4 4 4 0 0 0-4-4z"></path>
              </svg>
            </div>
            <div class="card-text">
              <h4>Access smartBiz Web</h4>
              <p>Open smartBiz Web on your desktop browser to generate a QR code for quick sign in.</p>
            </div>
          </div>

          <div class="link-box">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="link-icon">
              <path d="M10 13a5 5 0 0 0 7.54.54l3-3a5 5 0 0 0-7.07-7.07l-1.72 1.71"></path>
              <path d="M14 11a5 5 0 0 0-7.54-.54l-3 3a5 5 0 0 0 7.07 7.07l1.71-1.71"></path>
            </svg>
            <span class="link-url">smartbiz.ppcbank.com.kh</span>
            <button class="share-btn">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="share-icon">
                <circle cx="18" cy="5" r="3"></circle>
                <circle cx="6" cy="12" r="3"></circle>
                <circle cx="18" cy="19" r="3"></circle>
                <line x1="8.59" y1="13.51" x2="15.42" y2="17.49"></line>
                <line x1="15.41" y1="6.51" x2="8.59" y2="10.49"></line>
              </svg>
            </button>
          </div>
        </div>
      </div>

      <!-- Bottom Actions -->
      <div class="success-actions">
        <BizButton variant="primary" block @click="router.push('/')">
          <div class="btn-content-with-icon">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="qr-icon">
              <rect x="3" y="3" width="7" height="7"></rect>
              <rect x="14" y="3" width="7" height="7"></rect>
              <rect x="14" y="14" width="7" height="7"></rect>
              <rect x="3" y="14" width="7" height="7"></rect>
            </svg>
            Scan QR to Sign In
          </div>
        </BizButton>
        <div style="height: 12px;"></div>
        <BizButton variant="outline" block @click="router.push('/')">
          Maybe Later
        </BizButton>
      </div>

    </div>
  </ion-page>
</template>

<script setup lang="ts">
import { useRouter } from 'vue-router';
import { IonPage } from '@ionic/vue';
import { BizButton } from '@phanna/ui-framework';

const router = useRouter();
</script>

<style scoped>
.biz-success-screen {
  display: flex;
  flex-direction: column;
  height: 100vh;
  background-color: #ffffff;
  padding: 0;
  position: relative;
}

.success-content {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 60px 24px 24px;
  overflow-y: auto;
}

/* Illustration */
.illustration-container {
  position: relative;
  margin-bottom: 32px;
  display: flex;
  flex-direction: column;
  align-items: center;
}
.confetti-emoji {
  font-size: 80px;
  line-height: 1;
  margin-bottom: 8px;
  z-index: 2;
  animation: float 3s ease-in-out infinite;
}
.illustration-shadow {
  width: 60px;
  height: 8px;
  background: radial-gradient(ellipse at center, rgba(0,0,0,0.15) 0%, rgba(0,0,0,0) 70%);
  border-radius: 50%;
}

@keyframes float {
  0% { transform: translateY(0px); }
  50% { transform: translateY(-10px); }
  100% { transform: translateY(0px); }
}

/* Typography */
.success-title {
  font-size: 24px;
  font-weight: 700;
  color: var(--biz-primary-variant, #1a2a5e);
  margin: 0 0 12px 0;
  text-align: center;
}
.success-subtitle {
  font-size: 13px;
  color: #555;
  text-align: center;
  line-height: 1.5;
  margin: 0 0 40px 0;
}

/* Info Card */
.web-access-card {
  width: 100%;
  background-color: #f8f9fc;
  border-radius: 16px;
  padding: 20px;
}
.card-header {
  display: flex;
  gap: 12px;
  margin-bottom: 16px;
}
.laptop-icon-wrapper {
  color: #0066cc;
  flex-shrink: 0;
}
.laptop-icon {
  width: 24px;
  height: 24px;
}
.card-text h4 {
  font-size: 14px;
  font-weight: 700;
  color: var(--biz-primary-variant, #1a2a5e);
  margin: 0 0 4px 0;
}
.card-text p {
  font-size: 12px;
  color: #555;
  margin: 0;
  line-height: 1.4;
}

/* Link Box */
.link-box {
  display: flex;
  align-items: center;
  background-color: transparent;
  border: 1px solid #cce0ff;
  border-radius: 8px;
  padding: 10px 12px;
}
.link-icon {
  width: 16px;
  height: 16px;
  color: #0066cc;
  margin-right: 8px;
  flex-shrink: 0;
}
.link-url {
  flex: 1;
  font-size: 13px;
  color: #0066cc;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}
.share-btn {
  background: transparent;
  border: none;
  padding: 0;
  color: #0066cc;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  flex-shrink: 0;
}
.share-icon {
  width: 16px;
  height: 16px;
}

/* Bottom Actions */
.success-actions {
  padding: 16px 24px 32px;
  background: white;
  border-top: 1px solid #f0f0f0;
}

.btn-content-with-icon {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
}
.qr-icon {
  width: 18px;
  height: 18px;
}
</style>
