<template>
  <ion-page>
    <div class="biz-screen biz-pin-screen">
      
      <!-- Top header -->
      <div class="pin-header">
        <button class="back-btn" @click="router.push('/')">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
            <polyline points="15 18 9 12 15 6"></polyline>
          </svg>
        </button>

        <h1 class="pin-title">Create PIN</h1>
        <p class="pin-subtitle">
          Pin will be used for transactions authorization and many more. Never share your PIN.
        </p>
      </div>

      <!-- Main card area -->
      <div class="pin-card">
        
        <div class="dots-wrapper">
          <BizPinDots 
            :length="6" 
            :value="pin" 
            :error="isError"
            :success="isSuccess"
            :errorText="'PIN does not match. Please try again.'"
          />
        </div>

        <!-- Spacer to push keypad to bottom if needed, but it's absolute -->
      </div>

      <!-- Keypad -->
      <div class="keypad-wrapper">
        <BizKeypad @press="handleKeyPress" />
      </div>

      <!-- Biometric Setup Sheet -->
      <BizBiometricSheet 
        v-model="showBiometricSheet" 
        type="both" 
        @setup="handleBioSetup" 
        @later="handleBioLater"
      />

    </div>
  </ion-page>
</template>

<script setup lang="ts">
import { ref, watch } from 'vue';
import { useRouter } from 'vue-router';
import { IonPage } from '@ionic/vue';
import { BizPinDots, BizKeypad, BizBiometricSheet } from '@phanna/ui-framework';

const router = useRouter();

const pin = ref('');
const isError = ref(false);
const isSuccess = ref(false);
const showBiometricSheet = ref(false);

const handleKeyPress = (val: string) => {
  if (isError.value || isSuccess.value) {
    // Reset state on any new key press after error, or if blocked by success
    if (isSuccess.value) return; 
    isError.value = false;
    pin.value = '';
  }

  if (val === 'backspace') {
    if (pin.value.length > 0) {
      pin.value = pin.value.slice(0, -1);
    }
  } else {
    if (pin.value.length < 6) {
      pin.value += val;
    }
  }
};

// Simulate verification when 6 digits entered
watch(pin, (newVal) => {
  if (newVal.length === 6) {
    // Fake validation: if the pin is exactly 123456 it succeeds, else fails
    setTimeout(() => {
      if (newVal === '123456') {
        isSuccess.value = true;
        setTimeout(() => {
          showBiometricSheet.value = true;
        }, 1000); // wait for success animation to finish
      } else {
        isError.value = true;
      }
    }, 150);
  }
});

const handleBioSetup = () => {
  alert('Biometrics Setup Initialized!');
  router.push('/');
};

const handleBioLater = () => {
  router.push('/');
};
</script>

<style scoped>
.biz-pin-screen {
  display: flex;
  flex-direction: column;
  height: 100vh;
  background-color: var(--biz-primary-color, var(--biz-primary, #003399));
  position: relative;
  overflow: hidden;
}

.pin-header {
  padding: 56px 24px 32px 24px;
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

.pin-title {
  font-size: 28px;
  font-weight: 700;
  margin: 0 0 8px 0;
}

.pin-subtitle {
  font-size: 14px;
  opacity: 0.9;
  line-height: 1.5;
  margin: 0;
}

.pin-card {
  flex: 1;
  background-color: white;
  border-top-left-radius: 24px;
  border-top-right-radius: 24px;
  padding: 48px 24px;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.dots-wrapper {
  margin-top: 32px;
  width: 100%;
}

.keypad-wrapper {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
}
</style>
