<template>
  <div style="height: 600px; width: 100%; max-width: 400px; border: 1px solid var(--pp-border, #e2e8f0); border-radius: 12px; overflow: hidden; position: relative; margin: 0 auto; background: #fff7ed; display: flex; flex-direction: column;">
    
    <!-- App Bar -->
    <div style="padding: 16px; display: flex; justify-content: space-between; align-items: center;">
      <ion-icon :icon="chevronDownOutline" style="font-size: 24px; color: #0f172a; cursor: pointer;" />
      <div style="font-weight: 600; font-size: 14px; color: #9a3412; text-transform: uppercase; letter-spacing: 1px;">Podcast</div>
      <ion-icon :icon="ellipsisHorizontal" style="font-size: 24px; color: #0f172a; cursor: pointer;" />
    </div>
    
    <div style="flex: 1; display: flex; flex-direction: column; padding: 16px 24px;">
      <!-- Podcast Cover -->
      <div style="width: 100%; aspect-ratio: 1; border-radius: 16px; background: url('https://picsum.photos/300/300?random=podcast') center/cover; box-shadow: 0 16px 32px rgba(154,52,18,0.2); margin-bottom: 32px;"></div>
      
      <!-- Info -->
      <div style="text-align: center; margin-bottom: 24px;">
        <h2 style="margin: 0 0 8px 0; font-size: 22px; color: #0f172a; font-weight: 700; line-height: 1.3;">Ep 142: The Future of Design Systems</h2>
        <div style="color: #ea580c; font-size: 16px; font-weight: 500;">Design Details Podcast</div>
      </div>
      
      <!-- Scrubber -->
      <div style="width: 100%; margin-bottom: 24px;">
        <div style="height: 6px; background: #fed7aa; border-radius: 3px; position: relative; margin-bottom: 8px;">
          <div style="position: absolute; left: 0; top: 0; bottom: 0; width: 35%; background: #ea580c; border-radius: 3px;"></div>
          <div style="position: absolute; left: 35%; top: 50%; transform: translate(-50%, -50%); width: 16px; height: 16px; background: #ea580c; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.2);"></div>
        </div>
        <div style="display: flex; justify-content: space-between; color: #9a3412; font-size: 13px; font-weight: 500;">
          <span>15:24</span>
          <span>-42:18</span>
        </div>
      </div>
      
      <!-- Controls -->
      <div style="display: flex; justify-content: space-between; align-items: center; width: 100%; padding: 0 16px;">
        <div style="font-weight: 700; font-size: 15px; color: #ea580c; cursor: pointer;">1x</div>
        <ion-icon :icon="playBack" style="font-size: 32px; color: #0f172a; cursor: pointer;" />
        <div style="width: 72px; height: 72px; background: #ea580c; border-radius: 36px; display: flex; align-items: center; justify-content: center; box-shadow: 0 8px 16px rgba(234,88,12,0.3); cursor: pointer;">
          <ion-icon :icon="pause" style="font-size: 36px; color: white;" />
        </div>
        <ion-icon :icon="playForward" style="font-size: 32px; color: #0f172a; cursor: pointer;" />
        <ion-icon :icon="moonOutline" style="font-size: 24px; color: #ea580c; cursor: pointer;" />
      </div>
    </div>
    
    <!-- Bottom Sheet Pull (Chapters) -->
    <div style="background: white; border-radius: 24px 24px 0 0; padding: 12px 24px 24px 24px; box-shadow: 0 -4px 16px rgba(0,0,0,0.05); display: flex; flex-direction: column; align-items: center;">
      <div style="width: 40px; height: 4px; background: #e2e8f0; border-radius: 2px; margin-bottom: 16px;"></div>
      <div style="display: flex; justify-content: space-between; width: 100%; align-items: center;">
        <div style="font-weight: 600; font-size: 16px; color: #0f172a;">Chapters</div>
        <ion-icon :icon="list" style="font-size: 20px; color: #64748b;" />
      </div>
    </div>
    
  </div>
</template>

<script setup lang="ts">
import { IonIcon } from '@ionic/vue';
import { chevronDownOutline, ellipsisHorizontal, playBack, pause, playForward, moonOutline, list } from 'ionicons/icons';
</script>
