<template>
  <div style="height: 600px; width: 100%; max-width: 400px; border: 1px solid var(--pp-border, #e2e8f0); border-radius: 12px; overflow: hidden; position: relative; margin: 0 auto; background: black; display: flex; flex-direction: column; color: white;">
    
    <!-- Top Nav Overlay -->
    <div style="position: absolute; top: 16px; left: 0; right: 0; display: flex; justify-content: center; gap: 16px; z-index: 10;">
      <div style="font-weight: 600; font-size: 16px; opacity: 0.7; cursor: pointer;">Following</div>
      <div style="font-weight: 700; font-size: 16px; cursor: pointer;">For You</div>
      <div style="position: absolute; right: 16px; top: 0;"><ion-icon :icon="searchOutline" style="font-size: 24px;" /></div>
    </div>
    
    <!-- Fullscreen Content Area -->
    <div style="flex: 1; background: url('https://picsum.photos/400/800?random=social') center/cover; position: relative;">
      
      <!-- Right Side Actions -->
      <div style="position: absolute; right: 16px; bottom: 80px; display: flex; flex-direction: column; gap: 24px; align-items: center; z-index: 10;">
        <div style="position: relative;">
          <div style="width: 48px; height: 48px; border-radius: 24px; border: 2px solid white; background: url('https://i.pravatar.cc/150?u=123') center/cover;"></div>
          <div style="position: absolute; bottom: -8px; left: 50%; transform: translateX(-50%); background: #ef4444; width: 20px; height: 20px; border-radius: 10px; display: flex; align-items: center; justify-content: center; font-size: 14px; font-weight: bold;">+</div>
        </div>
        
        <div style="display: flex; flex-direction: column; align-items: center; gap: 4px;">
          <ion-icon :icon="heart" style="font-size: 32px; color: #ef4444;" />
          <span style="font-size: 12px; font-weight: 600;">124K</span>
        </div>
        
        <div style="display: flex; flex-direction: column; align-items: center; gap: 4px;">
          <ion-icon :icon="chatbubbleEllipses" style="font-size: 32px;" />
          <span style="font-size: 12px; font-weight: 600;">4,281</span>
        </div>
        
        <div style="display: flex; flex-direction: column; align-items: center; gap: 4px;">
          <ion-icon :icon="bookmark" style="font-size: 32px;" />
          <span style="font-size: 12px; font-weight: 600;">Save</span>
        </div>
        
        <div style="display: flex; flex-direction: column; align-items: center; gap: 4px;">
          <ion-icon :icon="shareSocial" style="font-size: 32px;" />
          <span style="font-size: 12px; font-weight: 600;">Share</span>
        </div>
      </div>
      
      <!-- Bottom Info Overlay -->
      <div style="position: absolute; bottom: 16px; left: 16px; right: 80px; z-index: 10;">
        <h3 style="margin: 0 0 8px 0; font-size: 16px;">@travel_adventures</h3>
        <p style="margin: 0 0 8px 0; font-size: 14px; line-height: 1.4; opacity: 0.9;">Exploring the hidden gems of the Pacific Northwest! 🌲🏔️ #travel #nature #pnw</p>
        <div style="display: flex; align-items: center; gap: 8px; font-size: 13px; font-weight: 500;">
          <ion-icon :icon="musicalNotes" />
          <span>Original Audio - Nature Sounds</span>
        </div>
      </div>
    </div>
    
  </div>
</template>

<script setup lang="ts">
import { IonIcon } from '@ionic/vue';
import { searchOutline, heart, chatbubbleEllipses, bookmark, shareSocial, musicalNotes } from 'ionicons/icons';
</script>
