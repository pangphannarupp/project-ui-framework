<template>
  <div style="height: 600px; width: 100%; max-width: 400px; border: 1px solid var(--pp-border, #e2e8f0); border-radius: 12px; overflow: hidden; position: relative; margin: 0 auto; background: #0f172a; display: flex; flex-direction: column; color: white;">
    
    <!-- Header -->
    <div style="padding: 16px 24px; display: flex; justify-content: space-between; align-items: center;">
      <h2 style="margin: 0; font-size: 20px; font-weight: 600;">Today</h2>
      <PPAvatar src="https://i.pravatar.cc/150?u=fit" size="sm" style="border: 2px solid #334155;" />
    </div>
    
    <div style="flex: 1; overflow-y: auto; padding: 0 24px 24px 24px;">
      
      <!-- Circular Progress Ring (Mock) -->
      <div style="display: flex; justify-content: center; margin: 24px 0 40px 0;">
        <div style="position: relative; width: 200px; height: 200px; border-radius: 50%; background: conic-gradient(var(--pp-primary, #3b82f6) 75%, #334155 75%); display: flex; align-items: center; justify-content: center; box-shadow: inset 0 0 0 16px #0f172a;">
          <div style="text-align: center;">
            <ion-icon :icon="flame" style="font-size: 32px; color: #ef4444; margin-bottom: 8px;" />
            <div style="font-size: 36px; font-weight: 700; line-height: 1;">1,240</div>
            <div style="font-size: 14px; color: #94a3b8; font-weight: 500; margin-top: 4px;">KCAL BURNED</div>
          </div>
        </div>
      </div>
      
      <!-- Metrics Row -->
      <div style="display: flex; gap: 16px; margin-bottom: 32px;">
        <div style="flex: 1; background: #1e293b; padding: 16px; border-radius: 16px;">
          <ion-icon :icon="walk" style="font-size: 24px; color: #10b981; margin-bottom: 8px;" />
          <div style="font-size: 20px; font-weight: 600; margin-bottom: 2px;">8,432</div>
          <div style="font-size: 12px; color: #94a3b8;">Steps</div>
        </div>
        <div style="flex: 1; background: #1e293b; padding: 16px; border-radius: 16px;">
          <ion-icon :icon="time" style="font-size: 24px; color: #8b5cf6; margin-bottom: 8px;" />
          <div style="font-size: 20px; font-weight: 600; margin-bottom: 2px;">45m</div>
          <div style="font-size: 12px; color: #94a3b8;">Active</div>
        </div>
        <div style="flex: 1; background: #1e293b; padding: 16px; border-radius: 16px;">
          <ion-icon :icon="heart" style="font-size: 24px; color: #ef4444; margin-bottom: 8px;" />
          <div style="font-size: 20px; font-weight: 600; margin-bottom: 2px;">112</div>
          <div style="font-size: 12px; color: #94a3b8;">Avg BPM</div>
        </div>
      </div>
      
      <!-- Activities List -->
      <h3 style="margin: 0 0 16px 0; font-size: 18px;">Recent Activities</h3>
      <div style="display: flex; flex-direction: column; gap: 16px;">
        
        <div style="display: flex; align-items: center; gap: 16px; background: #1e293b; padding: 16px; border-radius: 16px;">
          <div style="width: 48px; height: 48px; background: rgba(59,130,246,0.1); border-radius: 12px; display: flex; align-items: center; justify-content: center;">
            <ion-icon :icon="bicycle" style="font-size: 24px; color: var(--pp-primary, #3b82f6);" />
          </div>
          <div style="flex: 1;">
            <div style="font-weight: 600; font-size: 16px; margin-bottom: 4px;">Morning Cycling</div>
            <div style="font-size: 13px; color: #94a3b8;">12.4 km • 8:30 AM</div>
          </div>
          <div style="font-weight: 600; font-size: 15px; color: #10b981;">420 kcal</div>
        </div>
        
        <div style="display: flex; align-items: center; gap: 16px; background: #1e293b; padding: 16px; border-radius: 16px;">
          <div style="width: 48px; height: 48px; background: rgba(139,92,246,0.1); border-radius: 12px; display: flex; align-items: center; justify-content: center;">
            <ion-icon :icon="barbell" style="font-size: 24px; color: #8b5cf6;" />
          </div>
          <div style="flex: 1;">
            <div style="font-weight: 600; font-size: 16px; margin-bottom: 4px;">Strength Training</div>
            <div style="font-size: 13px; color: #94a3b8;">45 min • Yesterday</div>
          </div>
          <div style="font-weight: 600; font-size: 15px; color: #10b981;">310 kcal</div>
        </div>
        
      </div>
      
    </div>
    
    <!-- Floating Add Button -->
    <div style="position: absolute; bottom: 24px; right: 24px;">
      <PPFab color="primary" shape="circle">
        <template #icon><ion-icon :icon="addOutline" /></template>
      </PPFab>
    </div>
  </div>
</template>

<script setup lang="ts">
import { IonIcon } from '@ionic/vue';
import { flame, walk, time, heart, bicycle, barbell, addOutline } from 'ionicons/icons';
import { PPAvatar, PPFab } from '@phanna/ui-framework';
</script>
