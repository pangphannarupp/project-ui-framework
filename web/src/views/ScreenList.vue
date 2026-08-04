<template>
  <ion-page>
    <ion-header>
      <ion-toolbar color="primary">
        <ion-title>App Screens</ion-title>
      </ion-toolbar>
    </ion-header>
    
    <ion-content class="ion-padding">
      <div class="screen-list">
        <div class="list-item" @click="router.push('/word')">
          <div class="item-content">
            <h3>Microsoft Word Screen</h3>
            <p>Word processor interface built with Ribbon Menu</p>
          </div>
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <polyline points="9 18 15 12 9 6"></polyline>
          </svg>
        </div>

        <div class="list-item" @click="router.push('/login')">
          <div class="item-content">
            <h3>Login Screen</h3>
            <p>Authentication and login layout</p>
          </div>
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <polyline points="9 18 15 12 9 6"></polyline>
          </svg>
        </div>

        <div class="list-item" @click="router.push('/activate')">
          <div class="item-content">
            <h3>Activate Account</h3>
            <p>Phone number verification layout</p>
          </div>
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <polyline points="9 18 15 12 9 6"></polyline>
          </svg>
        </div>

        <div class="list-item" @click="router.push('/verify-otp')">
          <div class="item-content">
            <h3>Verify OTP</h3>
            <p>6-digit OTP entry layout</p>
          </div>
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <polyline points="9 18 15 12 9 6"></polyline>
          </svg>
        </div>

        <div class="list-item" @click="router.push('/pin')">
          <div class="item-content">
            <h3>Create PIN</h3>
            <p>PIN entry and verification layout</p>
          </div>
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <polyline points="9 18 15 12 9 6"></polyline>
          </svg>
        </div>

        <div class="list-item" @click="router.push('/activation-success')">
          <div class="item-content">
            <h3>Activation Success</h3>
            <p>Success screen with QR instruction</p>
          </div>
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <polyline points="9 18 15 12 9 6"></polyline>
          </svg>
        </div>

        <div class="list-item" @click="router.push('/change-phone')">
          <div class="item-content">
            <h3>Change Phone</h3>
            <p>Phone input with country code sheet</p>
          </div>
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <polyline points="9 18 15 12 9 6"></polyline>
          </svg>
        </div>

        <div class="list-item" @click="router.push('/document-verification')">
          <div class="item-content">
            <h3>Document Verification</h3>
            <p>ID check preparation screen</p>
          </div>
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <polyline points="9 18 15 12 9 6"></polyline>
          </svg>
        </div>

        <div class="list-item" @click="router.push('/confirm-info')">
          <div class="item-content">
            <h3>Confirm Information</h3>
            <p>Review personal details screen</p>
          </div>
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <polyline points="9 18 15 12 9 6"></polyline>
          </svg>
        </div>

        <div class="list-item" @click="router.push('/setting')">
          <div class="item-content">
            <h3>Setting Screen</h3>
            <p>Theme, Language, and Version settings</p>
          </div>
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <polyline points="9 18 15 12 9 6"></polyline>
          </svg>
        </div>

        <div class="list-item" @click="router.push('/upgrade-info')">
          <div class="item-content">
            <h3>Why Upgrade Info</h3>
            <p>Upgrade to new screen</p>
          </div>
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <polyline points="9 18 15 12 9 6"></polyline>
          </svg>
        </div>

        <div class="list-item" @click="router.push('/branch-map')">
          <div class="item-content">
            <h3>Branch Map Demo</h3>
            <p>Filter & Sort bottom sheets</p>
          </div>
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <polyline points="9 18 15 12 9 6"></polyline>
          </svg>
        </div>

        <div class="list-item" @click="router.push('/user-management')">
          <div class="item-content">
            <h3>User Management</h3>
            <p>Admin user management screen</p>
          </div>
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <polyline points="9 18 15 12 9 6"></polyline>
          </svg>
        </div>

        <div class="list-item" @click="router.push('/edit-account-nickname')">
          <div class="item-content">
            <h3>Edit Account Nickname</h3>
            <p>Change nickname for an account</p>
          </div>
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <polyline points="9 18 15 12 9 6"></polyline>
          </svg>
        </div>

        <div class="list-item" @click="router.push('/edit-account-nickname-success')">
          <div class="item-content">
            <h3>Edit Nickname Success</h3>
            <p>Success screen after changing nickname</p>
          </div>
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <polyline points="9 18 15 12 9 6"></polyline>
          </svg>
        </div>

        <div class="list-item" @click="router.push('/home')">
          <div class="item-content">
            <h3>Home Dashboard</h3>
            <p>Main app layout and navigation</p>
          </div>
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <polyline points="9 18 15 12 9 6"></polyline>
          </svg>
        </div>

        <div class="list-item" @click="router.push('/notification')">
          <div class="item-content">
            <h3>Notification Screen</h3>
            <p>Notifications list with collapsible header</p>
          </div>
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <polyline points="9 18 15 12 9 6"></polyline>
          </svg>
        </div>
        
        <div class="list-item usage-item" @click="router.push('/usage-guide')">
          <div class="item-content">
            <h3>Component Usage Guide</h3>
            <p>View all UI Framework components</p>
          </div>
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect>
            <line x1="9" y1="9" x2="15" y2="15"></line>
            <line x1="15" y1="9" x2="9" y2="15"></line>
          </svg>
        </div>
      </div>
    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import { useRouter } from 'vue-router';
import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent } from '@ionic/vue';

const router = useRouter();
</script>

<style scoped>
.screen-list {
  display: flex;
  flex-direction: column;
  gap: 16px;
  padding-top: 16px;
}

.list-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px;
  background: white;
  border-radius: 16px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.05);
  cursor: pointer;
  transition: transform 0.2s, box-shadow 0.2s;
}

.list-item:active {
  transform: scale(0.98);
}

.item-content h3 {
  margin: 0 0 8px 0;
  font-size: 18px;
  color: var(--pp-primary-variant, #1a2a5e);
  font-weight: 700;
}

.item-content p {
  margin: 0;
  font-size: 14px;
  color: #666;
}

.list-item svg {
  width: 24px;
  height: 24px;
  color: #ccc;
}

.usage-item {
  margin-top: 16px;
  background: var(--pp-background, #f4f6fa);
  border: 1px dashed #0066cc;
}
.usage-item h3 {
  color: #0066cc;
}
</style>
