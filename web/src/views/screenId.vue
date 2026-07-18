<template>
  <ion-page class="notification-page">
    <div class="safe-area-wrapper">
      <BizCollapsingToolbar 
        title="Notifications" 
        :expandedHeight="220" 
        :collapsedHeight="56" 
        centerTitleOnCollapse
      >
        <template #start>
          <ion-back-button default-href="/"></ion-back-button>
        </template>
        
        <template #background>
        <div class="custom-large-header">
          <div class="text-content">
            <p>Receive the latest updates here</p>
          </div>
          <div class="bell-wrapper">
            <ion-icon :icon="notifications" class="bell-icon"></ion-icon>
            <div class="badge-dot"></div>
          </div>
        </div>
      </template>

      <div class="content-wrapper">
        <div class="tabs-container">
          <BizScrollSegment>
            <BizScrollSegmentButton :isActive="true">All(20)</BizScrollSegmentButton>
            <BizScrollSegmentButton>Transaction(5)</BizScrollSegmentButton>
            <BizScrollSegmentButton>Approval(2)</BizScrollSegmentButton>
            <BizScrollSegmentButton>Announcement</BizScrollSegmentButton>
          </BizScrollSegment>
        </div>

        <div class="notification-list">
          <BizNotificationItem 
            title="PPCBank" 
            description="Set up smartPay now for easier business payment"
            timestamp="29 SEP, 2026 7:41:42 PM"
            :unread="true"
          >
            <template #icon>
              <ion-icon :icon="megaphoneOutline"></ion-icon>
            </template>
          </BizNotificationItem>

          <BizNotificationItem 
            title="Account" 
            description="242.50 USD is deposited in Acct: #6536. New Balance: 12,340.50 USD. Tap to see!"
            timestamp="29 SEP, 2026 7:41:42 PM"
            :unread="true"
          >
            <template #icon>
              <ion-icon :icon="logInOutline"></ion-icon>
            </template>
          </BizNotificationItem>

          <BizNotificationItem 
            title="Account" 
            description="242.50 USD is deposited in Acct: #6538. New Balance: 12,340.50 USD. Tap to see!"
            timestamp="29 SEP, 2026 7:41:42 PM"
          >
            <template #icon>
              <ion-icon :icon="logInOutline"></ion-icon>
            </template>
          </BizNotificationItem>

          <BizNotificationItem 
            title="Approval" 
            description="[Need my Approval] A request for approval has been receive. Tap to see in detail."
            timestamp="29 SEP, 2026 7:41:42 PM"
          >
            <template #icon>
              <ion-icon :icon="documentTextOutline"></ion-icon>
            </template>
          </BizNotificationItem>
          
          <BizNotificationItem 
            title="Account" 
            description="3,400,000 KHR is deposited in Acct: #6536. New Balance: 14,250,000 KHR. Tap to see!"
            timestamp="29 SEP, 2026 7:41:42 PM"
          >
            <template #icon>
              <ion-icon :icon="logInOutline"></ion-icon>
            </template>
          </BizNotificationItem>
        </div>
      </div>
    </BizCollapsingToolbar>
    </div>
  </ion-page>
</template>

<script setup lang="ts">
import { IonPage, IonBackButton, IonIcon } from '@ionic/vue';
import { 
  notifications, 
  megaphoneOutline, 
  logInOutline, 
  documentTextOutline 
} from 'ionicons/icons';
import { 
  BizCollapsingToolbar,
  BizScrollSegment,
  BizScrollSegmentButton,
  BizNotificationItem
} from '@phanna/ui-framework';
</script>

<style scoped>
.notification-page {
  background-color: var(--biz-primary-variant, #1a2a5e);
  --ion-safe-area-top: 0px;
}

.safe-area-wrapper {
  display: flex;
  flex-direction: column;
  height: 100%;
  width: 100%;
  padding-top: env(safe-area-inset-top);
  box-sizing: border-box;
}

.custom-large-header {
  position: relative;
  background-color: var(--biz-primary-variant, #1a2a5e);
  color: white;
  height: 100%;
  box-sizing: border-box;
}

.text-content {
  position: absolute;
  bottom: 64px;
  left: 16px;
}

.text-content p {
  margin: 0;
  font-size: 14px;
  opacity: 0.9;
}

.bell-wrapper {
  position: absolute;
  bottom: 50px;
  right: 16px;
  background: white;
  width: 48px;
  height: 48px;
  border-radius: 24px;
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 0 4px 10px rgba(0,0,0,0.1);
}

.bell-icon {
  font-size: 24px;
  color: var(--biz-primary-variant, #1a2a5e);
}

.badge-dot {
  position: absolute;
  top: 10px;
  right: 12px;
  width: 10px;
  height: 10px;
  background-color: #3b82f6;
  border-radius: 50%;
  border: 2px solid white;
}

.content-wrapper {
  background: white;
  min-height: 100%;
}

.tabs-container {
  padding: 16px;
  position: sticky;
  top: 0;
  background: white;
  z-index: 10;
  border-bottom: 1px solid #f0f0f0;
}

:deep(.biz-scroll-segment) {
  margin-bottom: 0 !important;
}

:deep(.scroll-btn) {
  margin-top: 0 !important;
}

.notification-list {
  padding-bottom: 24px;
}
</style>
