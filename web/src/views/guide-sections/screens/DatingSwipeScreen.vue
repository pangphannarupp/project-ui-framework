<template>
  <div style="height: 600px; width: 100%; max-width: 400px; border: 1px solid var(--pp-border, #e2e8f0); border-radius: 12px; overflow: hidden; position: relative; margin: 0 auto; background: #f8fafc; display: flex; flex-direction: column;">
    
    <!-- App Bar -->
    <div style="padding: 16px; display: flex; justify-content: space-between; align-items: center; z-index: 10;">
      <ion-icon :icon="personOutline" style="font-size: 24px; color: #94a3b8; cursor: pointer;" />
      <div style="font-weight: 700; font-size: 20px; color: #ec4899; letter-spacing: -0.5px; display: flex; align-items: center; gap: 4px;">
        <ion-icon :icon="flame" style="font-size: 24px;" />
        match
      </div>
      <ion-icon :icon="chatbubblesOutline" style="font-size: 24px; color: #94a3b8; cursor: pointer;" />
    </div>
    
    <!-- Card Stack Area -->
    <div style="flex: 1; padding: 8px 16px; position: relative;">
      
      <!-- Background Card (Next) -->
      <div style="position: absolute; top: 16px; left: 24px; right: 24px; bottom: 32px; background: white; border-radius: 20px; box-shadow: 0 4px 12px rgba(0,0,0,0.05); transform: scale(0.95) translateY(12px); opacity: 0.8; z-index: 1;"></div>
      
      <!-- Main Card -->
      <div style="position: absolute; top: 8px; left: 16px; right: 16px; bottom: 24px; background: url('https://picsum.photos/400/600?random=person') center/cover; border-radius: 20px; box-shadow: 0 12px 24px rgba(0,0,0,0.15); z-index: 2; overflow: hidden; display: flex; flex-direction: column; justify-content: flex-end;">
        
        <!-- Gradient Overlay for text readability -->
        <div style="position: absolute; bottom: 0; left: 0; right: 0; height: 50%; background: linear-gradient(to top, rgba(0,0,0,0.8) 0%, rgba(0,0,0,0) 100%); pointer-events: none;"></div>
        
        <!-- Info Overlay -->
        <div style="padding: 24px; position: relative; z-index: 3; color: white;">
          <div style="display: flex; align-items: flex-end; gap: 12px; margin-bottom: 8px;">
            <h2 style="margin: 0; font-size: 32px; font-weight: 700; text-shadow: 0 2px 4px rgba(0,0,0,0.3);">Jessica, 26</h2>
            <ion-icon :icon="checkmarkCircle" style="font-size: 20px; color: #3b82f6; margin-bottom: 6px;" />
          </div>
          
          <div style="display: flex; align-items: center; gap: 8px; font-size: 15px; margin-bottom: 6px; text-shadow: 0 1px 2px rgba(0,0,0,0.5);">
            <ion-icon :icon="briefcaseOutline" />
            <span>Product Designer at TechCorp</span>
          </div>
          
          <div style="display: flex; align-items: center; gap: 8px; font-size: 15px; margin-bottom: 16px; text-shadow: 0 1px 2px rgba(0,0,0,0.5);">
            <ion-icon :icon="locationOutline" />
            <span>2 miles away</span>
          </div>
          
          <div style="display: flex; gap: 8px; flex-wrap: wrap;">
            <div style="background: rgba(255,255,255,0.2); backdrop-filter: blur(4px); padding: 4px 12px; border-radius: 12px; font-size: 13px; font-weight: 500;">Coffee ☕</div>
            <div style="background: rgba(255,255,255,0.2); backdrop-filter: blur(4px); padding: 4px 12px; border-radius: 12px; font-size: 13px; font-weight: 500;">Hiking 🏔️</div>
            <div style="background: rgba(255,255,255,0.2); backdrop-filter: blur(4px); padding: 4px 12px; border-radius: 12px; font-size: 13px; font-weight: 500;">Dogs 🐕</div>
          </div>
        </div>
      </div>
    </div>
    
    <!-- Action Buttons -->
    <div style="padding: 16px 32px 32px 32px; display: flex; justify-content: space-between; align-items: center; z-index: 10;">
      <div style="width: 56px; height: 56px; background: white; border-radius: 28px; display: flex; align-items: center; justify-content: center; box-shadow: 0 4px 12px rgba(0,0,0,0.1); cursor: pointer;">
        <ion-icon :icon="close" style="font-size: 32px; color: #ef4444;" />
      </div>
      
      <div style="width: 48px; height: 48px; background: white; border-radius: 24px; display: flex; align-items: center; justify-content: center; box-shadow: 0 4px 12px rgba(0,0,0,0.1); cursor: pointer;">
        <ion-icon :icon="star" style="font-size: 24px; color: #3b82f6;" />
      </div>
      
      <div style="width: 56px; height: 56px; background: white; border-radius: 28px; display: flex; align-items: center; justify-content: center; box-shadow: 0 4px 12px rgba(0,0,0,0.1); cursor: pointer;">
        <ion-icon :icon="heart" style="font-size: 32px; color: #10b981;" />
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { IonIcon } from '@ionic/vue';
import { personOutline, chatbubblesOutline, flame, briefcaseOutline, locationOutline, checkmarkCircle, close, star, heart } from 'ionicons/icons';
</script>
