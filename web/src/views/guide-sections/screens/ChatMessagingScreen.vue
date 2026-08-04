<template>
  <div style="height: 600px; width: 100%; max-width: 400px; border: 1px solid var(--pp-border, #e2e8f0); border-radius: 12px; overflow: hidden; position: relative; margin: 0 auto; background: white; display: flex; flex-direction: column;">
    
    <!-- Sticky Header -->
    <div style="background: white; border-bottom: 1px solid #e2e8f0; display: flex; align-items: center; padding: 12px 16px; z-index: 10;">
      <ion-icon :icon="arrowBackOutline" style="font-size: 24px; color: #3b82f6; margin-right: 16px; cursor: pointer;" />
      <PPAvatar src="https://i.pravatar.cc/150?img=32" size="sm" style="margin-right: 12px;" />
      <div style="flex: 1;">
        <div style="font-weight: 600; font-size: 16px;">Design Team</div>
        <div style="font-size: 12px; color: #10b981;">Online</div>
      </div>
      <ion-icon :icon="ellipsisVerticalOutline" style="font-size: 20px; color: #64748b; cursor: pointer;" />
    </div>
    
    <!-- Chat History (Scrollable) -->
    <div style="flex: 1; overflow-y: auto; padding: 16px; display: flex; flex-direction: column; gap: 16px; background: #f8fafc;">
      <!-- Received Message -->
      <div style="display: flex; gap: 8px; max-width: 85%;">
        <PPAvatar src="https://i.pravatar.cc/150?img=32" size="xs" style="margin-top: auto;" />
        <div style="background: white; padding: 12px 16px; border-radius: 16px; border-bottom-left-radius: 4px; box-shadow: 0 1px 2px rgba(0,0,0,0.05); font-size: 14px; line-height: 1.5; color: #334155;">
          Hey everyone! Did we finalize the mockups for the new onboarding flow?
        </div>
      </div>
      
      <!-- Sent Message -->
      <div style="display: flex; gap: 8px; max-width: 85%; align-self: flex-end;">
        <div style="background: var(--pp-primary, #3b82f6); color: white; padding: 12px 16px; border-radius: 16px; border-bottom-right-radius: 4px; font-size: 14px; line-height: 1.5;">
          Almost! I just need to make a few tweaks to the hero illustration. I'll send them over in 10 mins.
        </div>
      </div>
      
      <!-- Received Message -->
      <div style="display: flex; gap: 8px; max-width: 85%;">
        <PPAvatar src="https://i.pravatar.cc/150?img=47" size="xs" style="margin-top: auto;" />
        <div style="background: white; padding: 12px 16px; border-radius: 16px; border-bottom-left-radius: 4px; box-shadow: 0 1px 2px rgba(0,0,0,0.05); font-size: 14px; line-height: 1.5; color: #334155;">
          Sounds perfect. Let's review them on the call at 2 PM.
        </div>
      </div>
    </div>
    
    <!-- Sticky Input Area -->
    <div style="background: white; border-top: 1px solid #e2e8f0; padding: 12px 16px; display: flex; align-items: center; gap: 12px;">
      <ion-icon :icon="addCircleOutline" style="font-size: 24px; color: #94a3b8; cursor: pointer;" />
      <div style="flex: 1; background: #f1f5f9; border-radius: 20px; padding: 10px 16px; font-size: 14px; color: #64748b;">
        Type a message...
      </div>
      <ion-icon :icon="micOutline" style="font-size: 24px; color: var(--pp-primary, #3b82f6); cursor: pointer;" />
    </div>
  </div>
</template>

<script setup lang="ts">
import { IonIcon } from '@ionic/vue';
import { arrowBackOutline, ellipsisVerticalOutline, addCircleOutline, micOutline } from 'ionicons/icons';
import { PPAvatar } from '@phanna/ui-framework';
</script>
