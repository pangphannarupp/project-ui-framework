<template>
  <div style="height: 600px; width: 100%; max-width: 400px; border: 1px solid var(--pp-border, #e2e8f0); border-radius: 12px; overflow: hidden; position: relative; margin: 0 auto; background: white; display: flex; flex-direction: column;">
    
    <!-- Transparent Header overlapping image -->
    <div style="position: absolute; top: 0; left: 0; right: 0; padding: 16px; display: flex; justify-content: space-between; z-index: 10;">
      <div style="background: rgba(255,255,255,0.8); backdrop-filter: blur(8px); border-radius: 50%; width: 40px; height: 40px; display: flex; align-items: center; justify-content: center; cursor: pointer;">
        <ion-icon :icon="arrowBackOutline" style="font-size: 20px; color: #0f172a;" />
      </div>
      <div style="background: rgba(255,255,255,0.8); backdrop-filter: blur(8px); border-radius: 50%; width: 40px; height: 40px; display: flex; align-items: center; justify-content: center; cursor: pointer;">
        <ion-icon :icon="heartOutline" style="font-size: 20px; color: #0f172a;" />
      </div>
    </div>
    
    <div style="flex: 1; overflow-y: auto;">
      <!-- Product Image -->
      <div style="height: 350px; background: url('https://picsum.photos/400/400?random=ecommerce') center/cover;"></div>
      
      <!-- Product Details -->
      <div style="padding: 24px 16px;">
        <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 8px;">
          <h2 style="margin: 0; font-size: 24px; color: #0f172a;">Minimalist Chair</h2>
          <div style="font-weight: 700; font-size: 22px; color: var(--pp-primary, #3b82f6);">$129</div>
        </div>
        <div style="color: #64748b; font-size: 14px; margin-bottom: 24px; display: flex; align-items: center; gap: 4px;">
          <ion-icon :icon="star" style="color: #fbbf24;" />
          <span style="font-weight: 600; color: #334155;">4.8</span> (124 reviews)
        </div>
        
        <h3 style="margin: 0 0 12px 0; font-size: 16px; color: #0f172a;">Description</h3>
        <p style="color: #64748b; font-size: 14px; line-height: 1.6; margin-bottom: 24px; margin-top: 0;">
          Experience modern design combined with ultimate comfort. This chair features a solid wood frame and premium upholstery, perfect for any contemporary living space.
        </p>
      </div>
    </div>
    
    <!-- Sticky Bottom Bar -->
    <div style="padding: 16px; border-top: 1px solid #e2e8f0; background: white;">
      <PPButton variant="primary" block size="large" style="border-radius: 28px;">Add to Cart</PPButton>
    </div>
  </div>
</template>

<script setup lang="ts">
import { IonIcon } from '@ionic/vue';
import { arrowBackOutline, heartOutline, star } from 'ionicons/icons';
import { PPButton } from '@phanna/ui-framework';
</script>
