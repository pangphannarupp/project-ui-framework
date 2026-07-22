<template>
  <ion-page>
    <div class="pp-screen pp-change-phone">
      
      <!-- Top header -->
      <div class="phone-header">
        <button class="back-btn" @click="router.back()">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
            <polyline points="15 18 9 12 15 6"></polyline>
          </svg>
        </button>

        <h1 class="phone-title">Enter New<br>Phone Number</h1>
        <p class="phone-subtitle">
          Enter the new phone number to register with PPCBank smartBiz for account activation.
        </p>
      </div>

      <!-- Main card area -->
      <div class="phone-card">
        
        <div class="input-section">
          <!-- The PPPhoneInput uses our custom Country Selector -->
          <PPPhoneInput 
            v-model="phoneNumber" 
            :countryCode="countryCode" 
            label="Phone Number" 
            @select-country="showCountrySheet = true"
            @focus="showKeypad = true"
          />
        </div>

        <!-- Next Button -->
        <div class="action-section" :class="{ 'is-keypad-open': showKeypad }">
          <PPButton variant="primary" block @click="handleNext">Next</PPButton>
        </div>

      </div>

      <!-- Keypad -->
      <div class="keypad-wrapper" v-show="showKeypad">
        <!-- Close Keypad button overlay if needed, or rely on tapping outside -->
        <PPKeypad @press="handleKeyPress" />
      </div>

      <!-- Country Code Sheet -->
      <PPCountryCodeSheet 
        v-model="showCountrySheet"
        v-model:modelValueCode="countryCode"
      />

    </div>
  </ion-page>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import { IonPage } from '@ionic/vue';
import { PPPhoneInput, PPButton, PPKeypad, PPCountryCodeSheet } from '@phanna/ui-framework';

const router = useRouter();

const phoneNumber = ref('');
const countryCode = ref('+855');
const showCountrySheet = ref(false);
const showKeypad = ref(false); // Initially false, shown on focus

const handleKeyPress = (val: string) => {
  if (val === 'backspace') {
    if (phoneNumber.value.length > 0) {
      phoneNumber.value = phoneNumber.value.slice(0, -1);
    }
  } else {
    phoneNumber.value += val;
  }
};

const handleNext = () => {
  if (showKeypad.value) {
    // If keypad is open, tapping Next closes it first (like a done button)
    showKeypad.value = false;
  } else {
    // Actual action
    alert(`Phone Number: ${countryCode.value} ${phoneNumber.value}`);
    router.push('/');
  }
};
</script>

<style scoped>
.pp-change-phone {
  display: flex;
  flex-direction: column;
  height: 100vh;
  background-color: var(--pp-primary-color, var(--pp-primary, #003399));
  position: relative;
  overflow: hidden;
}

.phone-header {
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

.phone-title {
  font-size: 28px;
  font-weight: 700;
  margin: 0 0 8px 0;
  line-height: 1.2;
}

.phone-subtitle {
  font-size: 13px;
  opacity: 0.9;
  line-height: 1.5;
  margin: 0;
}

.phone-card {
  flex: 1;
  background-color: white;
  border-top-left-radius: 24px;
  border-top-right-radius: 24px;
  padding: 32px 24px 24px 24px;
  display: flex;
  flex-direction: column;
  position: relative;
}

.input-section {
  margin-bottom: 24px;
}

.action-section {
  margin-top: auto; /* pushes button to the bottom of the card when flexed */
  transition: margin 0.3s;
}

.action-section.is-keypad-open {
  margin-top: 0; /* pulls it up right below input when keypad is open */
}

.keypad-wrapper {
  background-color: #f2f2f7;
  padding-bottom: env(safe-area-inset-bottom, 20px);
}
</style>
