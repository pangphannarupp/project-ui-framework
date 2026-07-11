<template>
  <ion-page>
    <div class="biz-screen biz-login-screen">
    
    <!-- Floating Back Button for Dev Navigation -->
    <button class="dev-back-btn" @click="router.push('/')">
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <line x1="19" y1="12" x2="5" y2="12"></line>
        <polyline points="12 19 5 12 12 5"></polyline>
      </svg>
      Back to List
    </button>

    <div class="login-header-area">
      <!-- Top Navigation -->
      <div class="login-nav">
        <button class="lang-btn" @click="showLangSheet = true">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="globe-icon"><circle cx="12" cy="12" r="10"></circle><line x1="2" y1="12" x2="22" y2="12"></line><path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"></path></svg>
          <span class="lang-text">{{ currentLangName }}</span>
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="chevron-icon"><polyline points="6 9 12 15 18 9"></polyline></svg>
        </button>
      </div>

      <div class="brand-area">
        <div class="logo">smart<span>Biz</span></div>
        <!-- Forgot / Help -->
        <div class="login-help">
          <button class="help-btn" @click="showActionRequired = true">Forgot ID/Password?</button>
        </div>
        <h1 class="login-title">Login</h1>
        <p class="login-subtitle">Sign in to manage your business securely and efficiently</p>
      </div>
    </div>

    <div class="login-card">
      <div class="segment-wrapper">
        <BizSegment v-model="loginType" class="login-segment">
          <BizSegmentButton value="userid">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
              <circle cx="12" cy="7" r="4"></circle>
            </svg>
            User ID
          </BizSegmentButton>
          <BizSegmentButton value="phone">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"></path>
            </svg>
            Phone Number
          </BizSegmentButton>
        </BizSegment>
      </div>

      <div class="form-area" v-if="loginType === 'userid'">
        <BizInput 
          v-model="userId" 
          label="User ID" 
          placeholder="Enter User ID" 
          clearable
        >
          <template #iconLeft>
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
              <circle cx="12" cy="7" r="4"></circle>
            </svg>
          </template>
        </BizInput>

        <BizInput 
          v-model="password" 
          label="Password" 
          type="password"
          placeholder="Enter Password" 
        >
          <template #iconLeft>
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
              <path d="M7 11V7a5 5 0 0 1 10 0v4"></path>
            </svg>
          </template>
        </BizInput>

        <div class="login-options">
          <BizCheckbox v-model="rememberMe">Remember User ID</BizCheckbox>
        </div>
      </div>
      
      <div class="form-area" v-else>
        <BizPhoneInput 
          v-model="phoneNumber" 
          label="Phone Number" 
          placeholder="Enter Phone Number" 
        />
        <BizInput 
          v-model="password" 
          label="Password" 
          type="password"
          placeholder="Enter Password" 
        >
          <template #iconLeft>
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
              <path d="M7 11V7a5 5 0 0 1 10 0v4"></path>
            </svg>
          </template>
        </BizInput>
        <div class="login-options">
          <BizCheckbox v-model="rememberMe">Remember Phone Number</BizCheckbox>
        </div>
      </div>

      <div class="bottom-actions">
        <!-- Disabled until fields are filled -->
        <BizButton variant="primary" block :disabled="!canLogin" @click="handleLogin">Login</BizButton>
      </div>

      <!-- Language Sheet -->
      <BizLanguageSheet 
        v-model="showLangSheet" 
        v-model:modelValueLang="currentLang" 
      />

      <!-- Action Required Sheet (Forgot Password) -->
      <BizFeedbackSheet 
        v-model="showActionRequired" 
        icon="error" 
        title="Action Required" 
        description="For security reasons, we are unable to reset User ID or Password in the app."
        buttonText="Back to Login"
      >
        <div class="user-reset-info">
          <div class="reset-box">
            <div class="box-header">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="box-icon"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
              Master User
            </div>
            <p>Please visit your nearest <strong>PPCBank branch</strong> for assistance to reset your User ID or Password.</p>
            <button class="branch-btn">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="branch-icon"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path><polyline points="9 22 9 12 15 12 15 22"></polyline></svg>
              Find Nearest Branch
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="branch-arrow"><polyline points="9 18 15 12 9 6"></polyline></svg>
            </button>
          </div>
          <div class="reset-box">
            <div class="box-header">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="box-icon"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
              Sub-user
            </div>
            <p>Please contact your <strong>Master</strong> to reset your User ID or Password, or Phone Number.</p>
          </div>
        </div>
      </BizFeedbackSheet>

      <!-- Incorrect User ID Sheet -->
      <BizFeedbackSheet 
        v-model="showIncorrectId" 
        icon="error" 
        title="Incorrect User ID" 
        description="The User ID you entered is incorrect.<br>Please check and try again"
        buttonText="Okay"
      />

      <!-- Incorrect Password Sheet -->
      <BizFeedbackSheet 
        v-model="showIncorrectPass" 
        icon="error" 
        title="Incorrect Password" 
        description="You have <strong style='color:#d93025'>4 attempts</strong> remaining. Otherwise, your account will be locked. Please try again carefully."
        buttonText="Okay"
      />

      <!-- Account Locked Sheet -->
      <BizFeedbackSheet 
        v-model="showAccountLocked" 
        icon="locked" 
        title="Account Locked" 
        description="Your account is now locked.<br>Please visit PPCBank branch to unlock your account."
        buttonText="Okay"
      />

      <!-- Not Yet Activated Sheet -->
      <BizFeedbackSheet 
        v-model="showNotActivated" 
        icon="error" 
        title="Not Yet Activated" 
        description="Please go to smartBiz Web and activate there."
        buttonText="Okay"
      />

      </div>
    </div>
  </ion-page>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';
import { useRouter } from 'vue-router';
import { IonPage } from '@ionic/vue';
import { 
  BizSegment, BizSegmentButton, BizInput, BizCheckbox, BizButton, BizPhoneInput, BizLanguageSheet, BizFeedbackSheet 
} from '@bizmob-core/ui-framework';

const router = useRouter();

const loginType = ref('userid');
const userId = ref('');
const password = ref('');
const phoneNumber = ref('');
const rememberMe = ref(false);

const canLogin = computed(() => {
  if (loginType.value === 'userid') {
    return userId.value.length > 0 && password.value.length > 0;
  }
  return phoneNumber.value.length > 0 && password.value.length > 0;
});

// State for bottom sheets
const showLangSheet = ref(false);
const showActionRequired = ref(false);
const showIncorrectId = ref(false);
const showIncorrectPass = ref(false);
const showAccountLocked = ref(false);
const showNotActivated = ref(false);

const currentLang = ref('en');
const currentLangName = computed(() => {
  switch(currentLang.value) {
    case 'km': return 'ភាសាខ្មែរ';
    case 'ko': return '한국어';
    case 'ja': return '日本語';
    case 'zh': return '漢語';
    default: return 'English';
  }
});

const handleLogin = () => {
  if (userId.value === 'locked') {
    showAccountLocked.value = true;
    return;
  }
  if (userId.value === 'notactivated') {
    showNotActivated.value = true;
    return;
  }
  if (userId.value === 'wrong') {
    showIncorrectId.value = true;
    return;
  }
  if (password.value === 'wrong') {
    showIncorrectPass.value = true;
    return;
  }
  router.push('/home');
};
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

.login-header-area {
  padding: 40px 24px 30px;
  color: white;
}

.top-actions {
  display: flex;
  justify-content: flex-end;
  margin-bottom: 24px;
}

.login-nav {
  display: flex;
  justify-content: flex-end;
  margin-bottom: 24px;
}

.lang-btn {
  display: flex;
  align-items: center;
  gap: 6px;
  background: white;
  color: var(--biz-primary, #003399);
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
.chevron-icon {
  width: 12px;
  height: 12px;
}

.brand-area {
  margin-bottom: 10px;
}

.logo {
  font-size: 24px;
  font-weight: 800;
  margin-bottom: 16px;
  letter-spacing: -0.5px;
}
.logo span {
  color: #4da6ff;
}

.login-title {
  font-size: 32px;
  font-weight: 800;
  margin: 0 0 8px 0;
}

.login-subtitle {
  font-size: 14px;
  margin: 0;
  line-height: 1.4;
  opacity: 0.9;
}

.login-card {
  flex: 1;
  background: white;
  border-top-left-radius: 24px;
  border-top-right-radius: 24px;
  padding: 24px;
  display: flex;
  flex-direction: column;
}

.segment-wrapper {
  margin-bottom: 24px;
}

.login-segment {
  --biz-segment-bg: white;
  --biz-segment-border-color: #e9ecef;
  --biz-segment-btn-active-bg: var(--biz-primary-variant, #1a2a5e);
  border-radius: 12px;
  border: 1px solid #e9ecef;
}

/* Add icons to segment buttons */
.login-segment :deep(.biz-segment-button) {
  display: flex;
  align-items: center;
  gap: 8px;
}
.login-segment :deep(.biz-segment-button svg) {
  width: 16px;
  height: 16px;
}

.form-area {
  display: flex;
  flex-direction: column;
  gap: 20px;
  flex: 1;
}

.login-options {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: 4px;
}

.forgot-link {
  font-size: 13px;
  color: #1a75ff;
  text-decoration: none;
  font-weight: 500;
}

.bottom-actions {
  margin-top: auto;
  padding-top: 40px;
  padding-bottom: env(safe-area-inset-bottom, 20px);
}

.dev-back-btn {
  position: absolute;
  top: 16px;
  left: 16px;
  z-index: 100;
  background: rgba(255,255,255,0.2);
  border: none;
  color: white;
  padding: 8px 12px;
  border-radius: 20px;
  display: flex;
  align-items: center;
  gap: 6px;
  font-size: 13px;
  font-weight: 500;
  cursor: pointer;
  backdrop-filter: blur(4px);
}
.dev-back-btn svg {
  width: 16px;
  height: 16px;
}

/* User Reset Info Specific Styling for Feedback Sheet */
.user-reset-info {
  display: flex;
  flex-direction: column;
  gap: 12px;
  width: 100%;
}

.reset-box {
  background-color: #ffffff;
  border: 1px solid #eaeaea;
  border-radius: 12px;
  padding: 16px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.02);
}

.box-header {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 14px;
  font-weight: 700;
  color: var(--biz-primary-variant, #1a2a5e);
  margin-bottom: 8px;
}

.box-icon {
  width: 16px;
  height: 16px;
  color: #0066cc;
}

.reset-box p {
  font-size: 12px;
  color: #555;
  margin: 0 0 12px 0;
  line-height: 1.5;
}

.branch-btn {
  width: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  background-color: #ffffff;
  border: 1px solid var(--biz-primary-variant, #1a2a5e);
  color: var(--biz-primary-variant, #1a2a5e);
  font-size: 13px;
  font-weight: 600;
  padding: 10px;
  border-radius: 8px;
  cursor: pointer;
}

.branch-icon {
  width: 16px;
  height: 16px;
}

.branch-arrow {
  width: 14px;
  height: 14px;
  margin-left: auto;
}
</style>
