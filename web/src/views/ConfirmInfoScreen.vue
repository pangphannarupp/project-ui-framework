<template>
  <ion-page>
    <div class="biz-screen biz-confirm-screen">
      
      <!-- Top header -->
      <div class="confirm-header">
        <button class="back-btn" @click="router.back()">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
            <polyline points="15 18 9 12 15 6"></polyline>
          </svg>
        </button>

        <h1 class="confirm-title">Confirm<br>Your Information</h1>
        <p class="confirm-subtitle">
          Please review your personal information carefully. Make sure all information is correct and accurate.
        </p>
      </div>

      <!-- Main card area -->
      <div class="confirm-card">
        
        <!-- Data Container -->
        <div class="data-container">
          
          <h3 class="section-title">PERSONAL INFORMATION</h3>
          
          <div class="data-grid">
            <div class="data-item">
              <label>FIRST NAME</label>
              <span>Sophorn</span>
            </div>
            <div class="data-item">
              <label>LAST NAME</label>
              <span>Boramey</span>
            </div>
            <div class="data-item">
              <label>GENDER</label>
              <span>Female</span>
            </div>
            <div class="data-item">
              <label>DATE OF BIRTH</label>
              <span>20 Dec, 1990</span>
            </div>
          </div>

          <hr class="divider" />

          <h3 class="section-title">IDENTITY DOCUMENT</h3>
          
          <div class="data-grid">
            <div class="data-item full-width">
              <label>NATIONAL ID / PASSPORT ID</label>
              <span>1108745431</span>
            </div>
            <div class="data-item">
              <label>OLD ID EXPIRY DATE</label>
              <span>30 JUL, 2025</span>
            </div>
            <div class="data-item">
              <label>NEW ID EXPIRY DATE</label>
              <span>30 JUL, 2030</span>
            </div>
          </div>

        </div>

        <BizInfoCard type="warning" class="info-alert">
          Please verify the document again if your information is incorrect.
        </BizInfoCard>

        <div class="action-area">
          <BizButton variant="primary" block @click="handleConfirm">Confirm</BizButton>
          <!-- Using a custom button for the outline style just to be safe, or variant="outline" if supported -->
          <button class="verify-again-btn" @click="handleVerifyAgain">Verify Again</button>
        </div>

      </div>

    </div>
  </ion-page>
</template>

<script setup lang="ts">
import { useRouter } from 'vue-router';
import { IonPage } from '@ionic/vue';
import { BizButton, BizInfoCard } from '@bizmob-core/ui-framework';

const router = useRouter();

const handleConfirm = () => {
  router.push('/');
};

const handleVerifyAgain = () => {
  router.back();
};
</script>

<style scoped>
.biz-confirm-screen {
  display: flex;
  flex-direction: column;
  height: 100vh;
  background-color: var(--biz-primary-color, var(--biz-primary, #003399));
  position: relative;
  overflow: hidden;
}

.confirm-header {
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

.confirm-title {
  font-size: 28px;
  font-weight: 700;
  margin: 0 0 8px 0;
  line-height: 1.2;
}

.confirm-subtitle {
  font-size: 13px;
  opacity: 0.9;
  line-height: 1.5;
  margin: 0;
}

.confirm-card {
  flex: 1;
  background-color: white;
  border-top-left-radius: 24px;
  border-top-right-radius: 24px;
  padding: 32px 24px 24px 24px;
  display: flex;
  flex-direction: column;
  overflow-y: auto;
}

.data-container {
  border: 1px solid #f0f0f5;
  border-radius: 16px;
  padding: 24px 16px;
  margin-bottom: 24px;
}

.section-title {
  font-size: 12px;
  font-weight: 700;
  color: var(--biz-primary-variant, #1a2a5e);
  margin: 0 0 16px 0;
  letter-spacing: 0.5px;
}

.data-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  row-gap: 20px;
  column-gap: 16px;
}

.data-item {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.data-item.full-width {
  grid-column: 1 / -1;
}

.data-item label {
  font-size: 10px;
  font-weight: 600;
  color: #888;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.data-item span {
  font-size: 13px;
  font-weight: 700;
  color: #111;
}

.divider {
  border: none;
  border-top: 1px solid #f0f0f5;
  margin: 24px 0;
}

.info-alert {
  margin-bottom: auto; /* Push buttons to bottom */
  background-color: #ffffff !important;
  border: 1px solid #f0f0f5 !important;
  color: var(--biz-primary-variant, #1a2a5e) !important;
}

.action-area {
  display: flex;
  flex-direction: column;
  gap: 12px;
  margin-top: 32px;
}

.verify-again-btn {
  background-color: white;
  border: 1px solid #eaeaea;
  color: var(--biz-primary-variant, #1a2a5e);
  font-size: 15px;
  font-weight: 600;
  padding: 14px;
  border-radius: 12px;
  width: 100%;
  cursor: pointer;
}
</style>
