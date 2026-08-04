<template>
  <div style="height: 600px; width: 100%; max-width: 400px; border: 1px solid var(--pp-border, #e2e8f0); border-radius: 12px; overflow: hidden; position: relative; margin: 0 auto; background: #f1f5f9; display: flex; flex-direction: column;">
    
    <!-- Header -->
    <div style="padding: 24px 20px 20px 20px; display: flex; justify-content: space-between; align-items: center;">
      <div>
        <h2 style="margin: 0 0 4px 0; font-size: 22px; color: #0f172a;">My Home</h2>
        <div style="font-size: 14px; color: #64748b; font-weight: 500;">4 devices active</div>
      </div>
      <PPAvatar src="https://i.pravatar.cc/150?u=home" size="sm" />
    </div>
    
    <!-- Quick Status Cards -->
    <div style="display: flex; gap: 12px; padding: 0 20px; margin-bottom: 24px;">
      <div style="flex: 1; background: white; padding: 16px; border-radius: 16px; display: flex; align-items: center; gap: 12px; box-shadow: 0 2px 4px rgba(0,0,0,0.02);">
        <div style="width: 40px; height: 40px; background: rgba(245,158,11,0.1); border-radius: 12px; display: flex; align-items: center; justify-content: center;">
          <ion-icon :icon="thermometerOutline" style="font-size: 20px; color: #f59e0b;" />
        </div>
        <div>
          <div style="font-size: 13px; color: #64748b; font-weight: 500;">Temp</div>
          <div style="font-size: 16px; font-weight: 700; color: #0f172a;">72°F</div>
        </div>
      </div>
      <div style="flex: 1; background: white; padding: 16px; border-radius: 16px; display: flex; align-items: center; gap: 12px; box-shadow: 0 2px 4px rgba(0,0,0,0.02);">
        <div style="width: 40px; height: 40px; background: rgba(16,185,129,0.1); border-radius: 12px; display: flex; align-items: center; justify-content: center;">
          <ion-icon :icon="shieldCheckmarkOutline" style="font-size: 20px; color: #10b981;" />
        </div>
        <div>
          <div style="font-size: 13px; color: #64748b; font-weight: 500;">Security</div>
          <div style="font-size: 16px; font-weight: 700; color: #0f172a;">Armed</div>
        </div>
      </div>
    </div>
    
    <!-- Rooms/Devices Grid -->
    <div style="flex: 1; background: white; border-radius: 24px 24px 0 0; padding: 24px 20px; overflow-y: auto;">
      <h3 style="margin: 0 0 16px 0; font-size: 18px; color: #0f172a;">Rooms & Devices</h3>
      
      <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 12px;">
        
        <!-- Active Device Card -->
        <div style="background: var(--pp-primary, #3b82f6); padding: 16px; border-radius: 20px; color: white;">
          <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 24px;">
            <ion-icon :icon="bulb" style="font-size: 28px;" />
            <div style="background: white; width: 40px; height: 24px; border-radius: 12px; position: relative;">
              <div style="position: absolute; right: 2px; top: 2px; width: 20px; height: 20px; background: var(--pp-primary, #3b82f6); border-radius: 10px;"></div>
            </div>
          </div>
          <div style="font-weight: 600; font-size: 16px; margin-bottom: 4px;">Living Room</div>
          <div style="font-size: 13px; opacity: 0.8;">Smart Lights</div>
        </div>
        
        <!-- Inactive Device Card -->
        <div style="background: #f8fafc; border: 1px solid #e2e8f0; padding: 16px; border-radius: 20px; color: #64748b;">
          <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 24px;">
            <ion-icon :icon="tvOutline" style="font-size: 28px; color: #94a3b8;" />
            <div style="background: #e2e8f0; width: 40px; height: 24px; border-radius: 12px; position: relative;">
              <div style="position: absolute; left: 2px; top: 2px; width: 20px; height: 20px; background: white; border-radius: 10px;"></div>
            </div>
          </div>
          <div style="font-weight: 600; font-size: 16px; margin-bottom: 4px; color: #0f172a;">Bedroom</div>
          <div style="font-size: 13px;">Smart TV</div>
        </div>
        
        <!-- Active Device Card -->
        <div style="background: var(--pp-primary, #3b82f6); padding: 16px; border-radius: 20px; color: white;">
          <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 24px;">
            <ion-icon :icon="snow" style="font-size: 28px;" />
            <div style="background: white; width: 40px; height: 24px; border-radius: 12px; position: relative;">
              <div style="position: absolute; right: 2px; top: 2px; width: 20px; height: 20px; background: var(--pp-primary, #3b82f6); border-radius: 10px;"></div>
            </div>
          </div>
          <div style="font-weight: 600; font-size: 16px; margin-bottom: 4px;">Kitchen</div>
          <div style="font-size: 13px; opacity: 0.8;">AC Unit • 70°F</div>
        </div>
        
        <!-- Inactive Device Card -->
        <div style="background: #f8fafc; border: 1px solid #e2e8f0; padding: 16px; border-radius: 20px; color: #64748b;">
          <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 24px;">
            <ion-icon :icon="lockClosedOutline" style="font-size: 28px; color: #94a3b8;" />
            <div style="background: #e2e8f0; width: 40px; height: 24px; border-radius: 12px; position: relative;">
              <div style="position: absolute; left: 2px; top: 2px; width: 20px; height: 20px; background: white; border-radius: 10px;"></div>
            </div>
          </div>
          <div style="font-weight: 600; font-size: 16px; margin-bottom: 4px; color: #0f172a;">Front Door</div>
          <div style="font-size: 13px;">Smart Lock</div>
        </div>
        
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { IonIcon } from '@ionic/vue';
import { thermometerOutline, shieldCheckmarkOutline, bulb, tvOutline, snow, lockClosedOutline } from 'ionicons/icons';
import { PPAvatar } from '@phanna/ui-framework';
</script>
