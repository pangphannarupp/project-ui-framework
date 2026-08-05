<template>
  <ion-page>
    <ion-content>
      <div class="settings-container">
        <div class="header-section">
          <h1 class="page-title">Notification Settings</h1>
          <p class="page-subtitle">Configure email and SMS alerts for your store events.</p>
        </div>

        <div class="settings-card">
          <h2 class="section-title">Event Triggers</h2>
          <div class="notification-list">
            
            <div class="notification-item">
              <div class="notification-info">
                <h3>New Order</h3>
                <p>Send an alert when a new customer order is placed.</p>
              </div>
              <div class="notification-toggles">
                <PPCheckbox v-model="settings.newOrder.email" label="Email" />
                <PPCheckbox v-model="settings.newOrder.sms" label="SMS" />
              </div>
            </div>

            <div class="notification-item">
              <div class="notification-info">
                <h3>Low Stock Warning</h3>
                <p>Send an alert when a product's stock falls below 5 items.</p>
              </div>
              <div class="notification-toggles">
                <PPCheckbox v-model="settings.lowStock.email" label="Email" />
                <PPCheckbox v-model="settings.lowStock.sms" label="SMS" />
              </div>
            </div>

            <div class="notification-item">
              <div class="notification-info">
                <h3>New User Registration</h3>
                <p>Send an alert when a new admin or customer account is created.</p>
              </div>
              <div class="notification-toggles">
                <PPCheckbox v-model="settings.newRegistration.email" label="Email" />
                <PPCheckbox v-model="settings.newRegistration.sms" label="SMS" />
              </div>
            </div>

          </div>

          <div class="divider"></div>

          <h2 class="section-title">Email Configuration</h2>
          <div class="form-grid">
            <PPTextField 
              v-model="emailConfig.senderName" 
              label="Sender Name *" 
              placeholder="Aura Portal Alerts" 
            />
            <PPTextField 
              v-model="emailConfig.replyTo" 
              label="Reply-To Email *" 
              placeholder="no-reply@auraportal.com" 
            />
          </div>

          <div class="form-actions">
            <PPButton variant="primary" @click="saveSettings">
              <template #iconLeft>
                <ion-icon :icon="saveOutline" />
              </template>
              Save Preferences
            </PPButton>
          </div>
        </div>
      </div>
    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { IonPage, IonContent, IonIcon } from '@ionic/vue';
import { PPTextField, PPCheckbox, PPButton } from '@phanna/ui-framework';
import { saveOutline } from 'ionicons/icons';

const settings = ref({
  newOrder: { email: true, sms: false },
  lowStock: { email: true, sms: true },
  newRegistration: { email: false, sms: false }
});

const emailConfig = ref({
  senderName: 'Aura Portal',
  replyTo: 'no-reply@auraportal.com'
});

const saveSettings = () => {
  console.log('Saving notification settings...', settings.value, emailConfig.value);
  // Mock save API call
  setTimeout(() => {
    alert('Notification settings saved successfully!');
  }, 500);
};
</script>

<style scoped>
ion-content {
  --background: transparent;
}

.settings-container {
  padding: 40px;
  width: 100%;
}

.header-section {
  margin-bottom: 32px;
}

.page-title {
  font-size: 28px;
  font-weight: 700;
  color: #1e293b;
  margin: 0 0 8px 0;
}

.page-subtitle {
  font-size: 15px;
  color: #64748b;
  margin: 0;
}

.settings-card {
  background: white;
  border-radius: 16px;
  border: 1px solid #e2e8f0;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05), 0 2px 4px -2px rgba(0, 0, 0, 0.025);
  padding: 32px;
}

.section-title {
  font-size: 18px;
  font-weight: 600;
  color: #334155;
  margin: 0 0 24px 0;
}

.notification-list {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.notification-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px;
  border: 1px solid #e2e8f0;
  border-radius: 8px;
  background: #f8fafc;
}

.notification-info h3 {
  margin: 0 0 4px 0;
  font-size: 16px;
  font-weight: 600;
  color: #1e293b;
}

.notification-info p {
  margin: 0;
  font-size: 14px;
  color: #64748b;
}

.notification-toggles {
  display: flex;
  gap: 24px;
}

.form-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 24px;
  margin-bottom: 32px;
}

.divider {
  height: 1px;
  background: #e2e8f0;
  margin: 32px 0;
}

.form-actions {
  display: flex;
  justify-content: flex-end;
  margin-top: 32px;
}

@media (max-width: 640px) {
  .notification-item {
    flex-direction: column;
    align-items: flex-start;
    gap: 16px;
  }
  .form-grid {
    grid-template-columns: 1fr;
  }
  .settings-container {
    padding: 20px;
  }
}
</style>
