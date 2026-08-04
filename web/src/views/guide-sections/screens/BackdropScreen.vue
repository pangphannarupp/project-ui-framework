<template>
  <div style="height: 600px; width: 100%; max-width: 400px; border: 1px solid var(--pp-border, #e2e8f0); border-radius: 12px; overflow: hidden; position: relative; margin: 0 auto; background: var(--pp-primary, #3b82f6); display: flex; flex-direction: column;">
    
    <!-- Back layer -->
    <div style="padding: 24px; color: white;">
      <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 24px;">
        <h1 style="margin: 0; font-size: 24px;">Filters</h1>
        <PPIconButton color="transparent" style="color: white;">
          <ion-icon :icon="closeOutline" />
        </PPIconButton>
      </div>
      
      <div style="display: flex; flex-direction: column; gap: 16px;">
        <div>
          <label style="display: block; font-size: 14px; font-weight: 500; margin-bottom: 8px;">Price Range</label>
          <div style="height: 40px; background: rgba(255,255,255,0.2); border-radius: 8px;"></div>
        </div>
        <div>
          <label style="display: block; font-size: 14px; font-weight: 500; margin-bottom: 8px;">Category</label>
          <div style="height: 40px; background: rgba(255,255,255,0.2); border-radius: 8px;"></div>
        </div>
      </div>
    </div>

    <!-- Front layer -->
    <div style="flex: 1; background: white; border-top-left-radius: 24px; border-top-right-radius: 24px; box-shadow: 0 -4px 16px rgba(0,0,0,0.1); display: flex; flex-direction: column; overflow: hidden; z-index: 10;">
      <!-- Sticky Front Header -->
      <div style="padding: 24px 24px 16px 24px; border-bottom: 1px solid #f1f5f9;">
        <h2 style="margin: 0; font-size: 20px;">Results (124)</h2>
      </div>
      
      <!-- Scrollable Content -->
      <div style="flex: 1; overflow-y: auto; padding: 16px 24px 24px 24px;">
        <div style="display: flex; flex-direction: column; gap: 16px;">
          <div v-for="i in 10" :key="i" style="display: flex; gap: 16px;">
            <div style="width: 100px; height: 100px; border-radius: 12px; background: #f1f5f9;"></div>
            <div style="flex: 1; padding: 4px 0;">
              <div style="font-weight: 600; font-size: 16px; margin-bottom: 4px;">Product {{ i }}</div>
              <div style="color: #64748b; font-size: 14px; margin-bottom: 8px;">Brand Name</div>
              <div style="font-weight: 700; color: var(--pp-primary, #3b82f6);">$99.99</div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { IonIcon } from '@ionic/vue';
import { closeOutline } from 'ionicons/icons';
import { PPIconButton } from '@phanna/ui-framework';
</script>
