<template>
  <ion-page>
    <div class="biz-screen biz-upgrade-screen">
      
      <!-- Top header area -->
      <div class="upgrade-header">
        <div class="top-nav">
          <button class="back-btn" @click="router.back()">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
              <polyline points="15 18 9 12 15 6"></polyline>
            </svg>
          </button>
          
          <button class="lang-btn">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="globe-icon"><circle cx="12" cy="12" r="10"></circle><line x1="2" y1="12" x2="22" y2="12"></line><path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"></path></svg>
            <span class="lang-text">English</span>
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="chevron-icon"><polyline points="6 9 12 15 18 9"></polyline></svg>
          </button>
        </div>

        <div class="header-content">
          <div class="text-content">
            <div class="shield-badge">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="badge-icon">
                <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z" fill="currentColor" stroke="none"></path>
                <path d="M9 12l2 2 4-4" stroke="#fff" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"></path>
              </svg>
            </div>
            <h1 class="upgrade-title">Why upgrade<br>to new smartBiz?</h1>
            <p class="upgrade-subtitle">Enjoy stronger corporate banking<br>with more seamless login security</p>
          </div>
          <div class="graphic-content">
            <!-- Emoji placeholder for the 3D shield graphic -->
            <div class="shield-graphic">
              <span class="emoji-shield">🛡️</span>
              <span class="emoji-lock">🔒</span>
            </div>
          </div>
        </div>
      </div>

      <!-- Main card area -->
      <div class="upgrade-card">
        
        <div class="info-list">
          
          <!-- To upgrade section -->
          <BizUpgradeCard title="To upgrade" description="Visit your nearest PPCBank branch.">
            <template #icon>
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path><circle cx="12" cy="10" r="3"></circle>
              </svg>
            </template>
          </BizUpgradeCard>

          <hr class="list-divider" />

          <!-- For re-verification section -->
          <BizUpgradeCard title="For re-verification purpose">
            <template #icon>
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M16 4h2a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h2"></path><rect x="8" y="2" width="8" height="4" rx="1" ry="1"></rect>
                <path d="M9 14l2 2 4-4" stroke-linecap="round" stroke-linejoin="round"></path>
              </svg>
            </template>
          </BizUpgradeCard>

          <!-- Sub items -->
          <div class="sub-items">
            <BizVerificationCard 
              title="Provide your company's authorized information." 
              description="Proof of your authorization to act for the company.">
              <template #icon>
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path d="M3 21h18"></path><path d="M5 21V5a2 2 0 0 1 2-2h10a2 2 0 0 1 2 2v16"></path><path d="M9 21v-4a2 2 0 0 1 2-2h2a2 2 0 0 1 2 2v4"></path>
                </svg>
              </template>
            </BizVerificationCard>

            <BizVerificationCard 
              title="Bring your identification document." 
              description="Such as original NID or Passport.">
              <template #icon>
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <rect x="3" y="5" width="18" height="14" rx="2" ry="2"></rect><line x1="8" y1="10" x2="16" y2="10"></line><line x1="8" y1="14" x2="16" y2="14"></line><line x1="10" y1="18" x2="14" y2="18"></line>
                </svg>
              </template>
            </BizVerificationCard>
          </div>

        </div>

        <div class="action-area">
          <BizButton variant="primary" block @click="handleFindBranch" class="branch-btn">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="btn-icon"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path><polyline points="9 22 9 12 15 12 15 22"></polyline></svg>
            Find Nearest Branch
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="btn-arrow"><polyline points="9 18 15 12 9 6"></polyline></svg>
          </BizButton>
          
          <BizSkipButton @click="handleSkip" />
        </div>

      </div>

    </div>
  </ion-page>
</template>

<script setup lang="ts">
import { useRouter } from 'vue-router';
import { IonPage } from '@ionic/vue';
import { BizButton, BizUpgradeCard, BizVerificationCard, BizSkipButton } from '@bizmob-core/ui-framework';

const router = useRouter();

const handleFindBranch = () => {
  // Demo branch click
};

const handleSkip = () => {
  router.push('/login');
};
</script>

<style scoped>
.biz-upgrade-screen {
  display: flex;
  flex-direction: column;
  height: 100vh;
  background-color: var(--biz-primary-color, var(--biz-primary, #003399));
  position: relative;
  overflow: hidden;
}

/* Header & Nav */
.upgrade-header {
  padding: 56px 24px 32px 24px;
  color: white;
}

.top-nav {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 24px;
}

.back-btn {
  background: transparent;
  border: none;
  color: white;
  padding: 0;
  cursor: pointer;
}

.back-btn svg {
  width: 24px;
  height: 24px;
}

.lang-btn {
  display: flex;
  align-items: center;
  gap: 6px;
  background: white;
  color: var(--biz-primary-variant, #1a2a5e);
  border: none;
  padding: 8px 12px;
  border-radius: 20px;
  font-size: 13px;
  font-weight: 600;
  cursor: pointer;
}

.globe-icon, .chevron-icon {
  width: 16px;
  height: 16px;
}

/* Header Content */
.header-content {
  display: flex;
  align-items: center;
  position: relative;
}

.text-content {
  flex: 1;
  z-index: 2;
}

.shield-badge {
  width: 32px;
  height: 32px;
  background-color: rgba(255, 255, 255, 0.2);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 16px;
}

.badge-icon {
  width: 18px;
  height: 18px;
  color: #fff;
}

.upgrade-title {
  font-size: 26px;
  font-weight: 700;
  margin: 0 0 12px 0;
  line-height: 1.2;
}

.upgrade-subtitle {
  font-size: 13px;
  opacity: 0.9;
  line-height: 1.5;
  margin: 0;
}

.graphic-content {
  position: absolute;
  right: -20px;
  top: -20px;
  width: 140px;
  height: 140px;
  z-index: 1;
  display: flex;
  align-items: center;
  justify-content: center;
}

.shield-graphic {
  position: relative;
  font-size: 80px;
}
.emoji-lock {
  position: absolute;
  font-size: 30px;
  left: 50%;
  top: 50%;
  transform: translate(-50%, -50%);
}

/* Main Card */
.upgrade-card {
  flex: 1;
  background-color: white;
  border-top-left-radius: 24px;
  border-top-right-radius: 24px;
  padding: 32px 24px 24px 24px;
  display: flex;
  flex-direction: column;
  overflow-y: auto;
}

.info-list {
  background-color: white;
  border-radius: 16px;
  border: 1px solid #eef1f6;
  box-shadow: 0 4px 12px rgba(0,0,0,0.02);
  padding: 16px;
  margin-bottom: 24px;
}

.list-divider {
  border: none;
  border-top: 1px solid #f0f0f5;
  margin: 16px 0 16px 56px;
}

.sub-items {
  margin-left: 20px;
  padding-left: 35px;
  border-left: 2px dashed #eaeaea;
  display: flex;
  flex-direction: column;
  gap: 24px;
  margin-top: 16px;
}

/* Actions */
.action-area {
  margin-top: auto;
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.branch-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  position: relative;
}

.btn-icon {
  width: 18px;
  height: 18px;
  position: absolute;
  left: 16px;
}

.btn-arrow {
  width: 16px;
  height: 16px;
  position: absolute;
  right: 16px;
}
</style>
