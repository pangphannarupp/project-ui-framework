<template>
  <div style="height: 600px; width: 100%; max-width: 400px; border: 1px solid var(--pp-border, #e2e8f0); border-radius: 12px; overflow: hidden; position: relative; margin: 0 auto; background: white; display: flex; flex-direction: column;">
    
    <!-- Header with Progress -->
    <div style="background: white; border-bottom: 1px solid #e2e8f0; padding: 16px; z-index: 10;">
      <div style="display: flex; align-items: center; margin-bottom: 16px;">
        <ion-icon :icon="closeOutline" style="font-size: 24px; color: #64748b; cursor: pointer;" />
        <h2 style="margin: 0; flex: 1; text-align: center; font-size: 16px;">Create Account</h2>
        <div style="width: 24px;"></div>
      </div>
      
      <!-- Step Indicator -->
      <div style="display: flex; align-items: center; justify-content: space-between; position: relative;">
        <div style="position: absolute; top: 50%; left: 10%; right: 10%; height: 2px; background: #e2e8f0; z-index: 1;"></div>
        <div style="position: absolute; top: 50%; left: 10%; width: 40%; height: 2px; background: var(--pp-primary, #3b82f6); z-index: 2;"></div>
        
        <div v-for="step in 3" :key="step" style="width: 24px; height: 24px; border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 12px; font-weight: 600; z-index: 3; background: white; border: 2px solid" :style="{ borderColor: step <= 2 ? 'var(--pp-primary, #3b82f6)' : '#e2e8f0', color: step <= 2 ? 'var(--pp-primary, #3b82f6)' : '#94a3b8' }">
          <span v-if="step < 2">✓</span>
          <span v-else>{{ step }}</span>
        </div>
      </div>
      <div style="display: flex; justify-content: space-between; margin-top: 8px; font-size: 11px; color: #64748b;">
        <span>Basic Info</span>
        <span style="color: var(--pp-primary, #3b82f6); font-weight: 600;">Details</span>
        <span>Confirm</span>
      </div>
    </div>
    
    <!-- Form Content -->
    <div style="flex: 1; overflow-y: auto; padding: 24px 16px;">
      <h3 style="margin: 0 0 8px 0; font-size: 20px;">Tell us more about you</h3>
      <p style="color: #64748b; font-size: 14px; margin: 0 0 24px 0;">This helps us personalize your experience.</p>
      
      <div style="display: flex; flex-direction: column; gap: 16px;">
        <div>
          <label style="display: block; font-size: 13px; font-weight: 600; color: #334155; margin-bottom: 8px;">Date of Birth</label>
          <div style="border: 1px solid #cbd5e1; border-radius: 8px; padding: 12px 16px; color: #94a3b8;">MM/DD/YYYY</div>
        </div>
        <div>
          <label style="display: block; font-size: 13px; font-weight: 600; color: #334155; margin-bottom: 8px;">Phone Number</label>
          <div style="border: 1px solid #cbd5e1; border-radius: 8px; padding: 12px 16px; color: #94a3b8;">+1 (555) 000-0000</div>
        </div>
        <div>
          <label style="display: block; font-size: 13px; font-weight: 600; color: #334155; margin-bottom: 8px;">Address</label>
          <div style="border: 1px solid #cbd5e1; border-radius: 8px; padding: 12px 16px; color: #94a3b8; height: 80px;">Enter your address</div>
        </div>
      </div>
    </div>
    
    <!-- Sticky Footer Actions -->
    <div style="background: white; border-top: 1px solid #e2e8f0; padding: 16px; display: flex; gap: 12px;">
      <PPButton variant="secondary" style="flex: 1;">Back</PPButton>
      <PPButton variant="primary" style="flex: 2;">Continue</PPButton>
    </div>
  </div>
</template>

<script setup lang="ts">
import { IonIcon } from '@ionic/vue';
import { closeOutline } from 'ionicons/icons';
import { PPButton } from '@phanna/ui-framework';
</script>
