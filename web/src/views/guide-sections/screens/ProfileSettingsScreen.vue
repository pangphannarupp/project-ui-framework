<template>
  <div style="height: 600px; width: 100%; max-width: 400px; border: 1px solid var(--pp-border, #e2e8f0); border-radius: 12px; overflow: hidden; position: relative; margin: 0 auto; background: #f8fafc; display: flex; flex-direction: column;">
    <PPAppBar title="Profile" />
    
    <div style="flex: 1; overflow-y: auto; padding-bottom: 24px;">
      <!-- Profile Header -->
      <div style="background: white; padding: 32px 16px; text-align: center; border-bottom: 1px solid #e2e8f0;">
        <PPAvatar src="https://i.pravatar.cc/150?img=68" size="xl" style="margin: 0 auto 16px auto;" />
        <h2 style="margin: 0 0 4px 0; font-size: 24px;">Alex Johnson</h2>
        <p style="margin: 0 0 16px 0; color: #64748b; font-size: 14px;">alex.johnson@example.com</p>
        <PPButton variant="outline" size="small" style="border-radius: 20px;">Edit Profile</PPButton>
      </div>
      
      <!-- Settings Sections -->
      <div style="padding: 24px 16px 8px 16px; font-size: 12px; font-weight: 700; color: #64748b; text-transform: uppercase; letter-spacing: 0.5px;">
        Account Settings
      </div>
      <div style="background: white; border-top: 1px solid #e2e8f0; border-bottom: 1px solid #e2e8f0;">
        <div v-for="item in ['Personal Information', 'Payment Methods', 'Notifications']" :key="item" style="padding: 16px; display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #f1f5f9; cursor: pointer;">
          <span style="font-size: 15px; color: #334155;">{{ item }}</span>
          <ion-icon :icon="chevronForwardOutline" style="color: #cbd5e1;" />
        </div>
      </div>

      <div style="padding: 24px 16px 8px 16px; font-size: 12px; font-weight: 700; color: #64748b; text-transform: uppercase; letter-spacing: 0.5px;">
        Support
      </div>
      <div style="background: white; border-top: 1px solid #e2e8f0; border-bottom: 1px solid #e2e8f0;">
        <div v-for="item in ['Help Center', 'Terms of Service', 'Privacy Policy']" :key="item" style="padding: 16px; display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #f1f5f9; cursor: pointer;">
          <span style="font-size: 15px; color: #334155;">{{ item }}</span>
          <ion-icon :icon="chevronForwardOutline" style="color: #cbd5e1;" />
        </div>
      </div>
      
      <div style="padding: 24px 16px;">
        <PPButton variant="soft" color="danger" block>Log Out</PPButton>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { IonIcon } from '@ionic/vue';
import { chevronForwardOutline } from 'ionicons/icons';
import { PPAppBar, PPAvatar, PPButton } from '@phanna/ui-framework';
</script>
