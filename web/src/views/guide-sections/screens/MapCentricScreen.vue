<template>
  <div style="height: 600px; width: 100%; max-width: 400px; border: 1px solid var(--pp-border, #e2e8f0); border-radius: 12px; overflow: hidden; position: relative; margin: 0 auto; background: url('https://picsum.photos/600/800?random=map') center/cover;">
    
    <!-- Floating Search Bar -->
    <div style="position: absolute; top: 16px; left: 16px; right: 16px; background: white; border-radius: 24px; padding: 12px 16px; display: flex; align-items: center; gap: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); z-index: 10;">
      <ion-icon :icon="menuOutline" style="font-size: 24px; color: #64748b; cursor: pointer;" />
      <div style="flex: 1; font-size: 15px; color: #94a3b8;">Search here...</div>
      <ion-icon :icon="micOutline" style="font-size: 20px; color: #64748b; cursor: pointer;" />
    </div>

    <!-- Map Pins (Mock) -->
    <div style="position: absolute; top: 30%; left: 40%; transform: translate(-50%, -50%);">
      <ion-icon :icon="location" style="font-size: 32px; color: #ef4444; filter: drop-shadow(0 2px 4px rgba(0,0,0,0.3));" />
    </div>
    <div style="position: absolute; top: 50%; left: 70%; transform: translate(-50%, -50%);">
      <ion-icon :icon="location" style="font-size: 32px; color: #ef4444; filter: drop-shadow(0 2px 4px rgba(0,0,0,0.3));" />
    </div>

    <!-- FAB for location -->
    <div style="position: absolute; bottom: 200px; right: 16px; z-index: 10;">
      <div style="background: white; width: 48px; height: 48px; border-radius: 24px; display: flex; align-items: center; justify-content: center; box-shadow: 0 4px 12px rgba(0,0,0,0.1); cursor: pointer;">
        <ion-icon :icon="locateOutline" style="font-size: 24px; color: var(--pp-primary, #3b82f6);" />
      </div>
    </div>

    <!-- Bottom Sheet / Card -->
    <div style="position: absolute; bottom: 16px; left: 16px; right: 16px; background: white; border-radius: 16px; padding: 20px; box-shadow: 0 8px 24px rgba(0,0,0,0.15); z-index: 10;">
      <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 12px;">
        <div>
          <h3 style="margin: 0 0 4px 0; font-size: 18px; color: #0f172a;">Central Park Cafe</h3>
          <div style="color: #64748b; font-size: 14px;">Coffee Shop • $$ • 1.2 mi</div>
        </div>
        <div style="background: #10b981; color: white; padding: 4px 8px; border-radius: 8px; font-weight: 700; font-size: 14px;">4.8</div>
      </div>
      
      <div style="display: flex; gap: 8px;">
        <PPButton variant="primary" block size="small">Directions</PPButton>
        <PPButton variant="outline" block size="small">Details</PPButton>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { IonIcon } from '@ionic/vue';
import { menuOutline, micOutline, location, locateOutline } from 'ionicons/icons';
import { PPButton } from '@phanna/ui-framework';
</script>
