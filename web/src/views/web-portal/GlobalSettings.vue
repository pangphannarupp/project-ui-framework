<template>
  <ion-page>
    <ion-content>
      <div class="settings-container">
        <div class="header-section">
          <h1 class="page-title">Global Settings</h1>
          <p class="page-subtitle">Manage your store's core information and configuration.</p>
        </div>

        <div class="settings-card">
          <h2 class="section-title">Store Information</h2>
          <div class="form-grid">
            <PPTextField 
              v-model="formData.storeName" 
              label="Store Name *" 
              placeholder="e.g. My Awesome Store" 
            />
            <PPTextField 
              v-model="formData.supportEmail" 
              label="Support Email *" 
              placeholder="support@example.com" 
            />
            <PPTextField 
              v-model="formData.supportPhone" 
              label="Support Phone" 
              placeholder="+1 234 567 8900" 
            />
          </div>

          <div class="divider"></div>

          <h2 class="section-title">Localization</h2>
          <div class="form-grid">
            <PPSelect 
              v-model="formData.currency" 
              label="Default Currency *" 
              :options="currencyOptions" 
            />
            <PPSelect 
              v-model="formData.timezone" 
              label="Timezone *" 
              :options="timezoneOptions" 
            />
          </div>

          <div class="form-actions">
            <PPButton variant="primary" @click="saveSettings">
              <template #iconLeft>
                <ion-icon :icon="saveOutline" />
              </template>
              Save Settings
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
import { PPTextField, PPSelect, PPButton } from '@phanna/ui-framework';
import { saveOutline } from 'ionicons/icons';

const formData = ref({
  storeName: 'Aura Portal',
  supportEmail: 'support@auraportal.com',
  supportPhone: '',
  currency: 'USD',
  timezone: 'UTC'
});

const currencyOptions = [
  { label: 'US Dollar (USD)', value: 'USD' },
  { label: 'Euro (EUR)', value: 'EUR' },
  { label: 'British Pound (GBP)', value: 'GBP' },
  { label: 'Cambodian Riel (KHR)', value: 'KHR' }
];

const timezoneOptions = [
  { label: 'UTC', value: 'UTC' },
  { label: 'Pacific Time (PT)', value: 'PT' },
  { label: 'Eastern Time (ET)', value: 'ET' },
  { label: 'Indochina Time (ICT)', value: 'ICT' }
];

const saveSettings = () => {
  console.log('Saving global settings...', formData.value);
  // Mock save API call
  setTimeout(() => {
    alert('Global settings saved successfully!');
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
  .form-grid {
    grid-template-columns: 1fr;
  }
  .settings-container {
    padding: 20px;
  }
}
</style>
