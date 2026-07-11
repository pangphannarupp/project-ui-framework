<template>
  <ion-page>
    <div class="biz-screen biz-edit-nickname-screen">
      
      <!-- Top Blue Section -->
      <div class="top-section">
        <BizAppBar 
          title="Account Details" 
          backgroundColor="transparent" 
          textColor="white" 
          :leftAction="() => router.push('/home')"
          leftIcon="<svg viewBox='0 0 24 24' width='24' height='24' fill='none' stroke='currentColor' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'><polyline points='15 18 9 12 15 6'></polyline></svg>"
        />
        
        <div class="account-details-card">
          <div class="account-details-header">
            <div class="account-owner">
              <h3>SOM MONYROTTANA</h3>
              <p>1-120-12345678-9</p>
            </div>
            <div class="account-badge">Savings</div>
          </div>
          <div class="account-balance-area">
            <div class="balance-label">Available Balance</div>
            <div class="balance-amount">
              <span class="currency">$</span>
              <span class="amount">500,000.00</span>
              <button class="visibility-btn">
                <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                  <path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24"></path>
                  <line x1="1" y1="1" x2="23" y2="23"></line>
                </svg>
              </button>
            </div>
          </div>
          <button class="more-options-btn">
            <svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="5" r="1"></circle><circle cx="12" cy="12" r="1"></circle><circle cx="12" cy="19" r="1"></circle></svg>
          </button>
        </div>
      </div>
      
      <!-- Main Content Container (White rounded area) -->
      <div class="main-content-card">
        <h2 class="page-title">Edit Account Nickname</h2>
        
        <div class="form-group">
          <label>Account Nickname</label>
          <div class="input-wrapper">
            <div class="input-icon">
              <svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
            </div>
            <input type="text" v-model="nickname" placeholder="Enter Account Nickname" />
          </div>
        </div>
        
        <div class="action-footer">
          <BizButton 
            block 
            :variant="'primary'" 
            :disabled="!canUpdate"
            @click="handleUpdate"
          >
            Update
          </BizButton>
        </div>
      </div>
      
    </div>
  </ion-page>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';
import { useRouter } from 'vue-router';
import { IonPage } from '@ionic/vue';
import { BizAppBar, BizButton } from '@bizmob-core/ui-framework';

const router = useRouter();
const nickname = ref('');

const canUpdate = computed(() => {
  return nickname.value.trim().length > 0;
});

const handleUpdate = () => {
  if (canUpdate.value) {
    router.push('/edit-account-nickname-success');
  }
};
</script>

<style scoped>
.biz-screen {
  width: 100%;
  height: 100vh;
  position: relative;
  display: flex;
  flex-direction: column;
  background-color: var(--biz-primary, #003399); /* Deep blue background for top section */
}

/* Top Section */
.top-section {
  padding-bottom: 24px;
}

.account-details-card {
  padding: 0 20px;
  position: relative;
}

.account-details-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 24px;
}

.account-owner {
  color: white;
}

.account-owner h3 {
  margin: 0 0 4px 0;
  font-size: 15px;
  font-weight: 700;
  letter-spacing: 0.5px;
}

.account-owner p {
  margin: 0;
  font-size: 11px;
  opacity: 0.8;
  letter-spacing: 0.5px;
}

.account-badge {
  background: white;
  color: var(--biz-primary, #003399);
  padding: 2px 10px;
  border-radius: 12px;
  font-size: 11px;
  font-weight: 700;
}

.account-balance-area {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.balance-label {
  color: white;
  font-size: 11px;
  opacity: 0.8;
}

.balance-amount {
  display: flex;
  align-items: center;
  gap: 4px;
  color: white;
}

.currency {
  font-size: 14px;
  font-weight: 600;
}

.amount {
  font-size: 20px;
  font-weight: 700;
}

.visibility-btn {
  background: transparent;
  border: none;
  color: white;
  opacity: 0.8;
  padding: 4px;
  cursor: pointer;
  display: flex;
  align-items: center;
}

.more-options-btn {
  position: absolute;
  right: 16px;
  bottom: 0;
  background: transparent;
  border: none;
  color: white;
  padding: 8px;
  cursor: pointer;
}

/* Main Content Card */
.main-content-card {
  background: white;
  border-top-left-radius: 24px;
  border-top-right-radius: 24px;
  padding: 24px 20px;
  flex: 1;
  display: flex;
  flex-direction: column;
}

.page-title {
  font-size: 18px;
  font-weight: 800;
  color: var(--biz-primary-variant, #1a2a5e);
  margin: 0 0 24px 0;
}

.form-group {
  margin-bottom: 24px;
}

.form-group label {
  display: block;
  font-size: 12px;
  color: #777;
  margin-bottom: 8px;
  padding-left: 4px;
}

.input-wrapper {
  position: relative;
  display: flex;
  align-items: center;
  border: 1px solid #e0e0e0;
  border-radius: 12px;
  height: 48px;
  padding: 0 16px;
  background-color: white;
  transition: border-color 0.2s;
}

.input-wrapper:focus-within {
  border-color: var(--biz-primary, #003399);
}

.input-icon {
  display: flex;
  align-items: center;
  justify-content: center;
  color: #999;
  margin-right: 12px;
}

.input-wrapper input {
  flex: 1;
  border: none;
  outline: none;
  background: transparent;
  font-size: 15px;
  color: var(--biz-primary-variant, #1a2a5e);
  font-weight: 500;
}

.input-wrapper input::placeholder {
  color: #bbb;
  font-weight: 400;
}

.action-footer {
  margin-top: auto;
  padding-top: 20px;
  padding-bottom: 20px;
}
</style>
