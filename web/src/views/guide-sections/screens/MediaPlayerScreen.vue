<template>
  <div style="height: 600px; width: 100%; max-width: 400px; border: 1px solid var(--pp-border, #e2e8f0); border-radius: 12px; overflow: hidden; position: relative; margin: 0 auto; background: linear-gradient(180deg, #1e293b 0%, #0f172a 100%); display: flex; flex-direction: column; color: white;">
    
    <!-- App Bar -->
    <div style="padding: 16px; display: flex; justify-content: space-between; align-items: center;">
      <PPIconButton color="transparent" style="color: white;"><ion-icon :icon="chevronDownOutline" /></PPIconButton>
      <div style="font-size: 14px; font-weight: 600; text-transform: uppercase; letter-spacing: 1px;">Now Playing</div>
      <PPIconButton color="transparent" style="color: white;"><ion-icon :icon="ellipsisHorizontal" /></PPIconButton>
    </div>
    
    <div style="flex: 1; display: flex; flex-direction: column; align-items: center; justify-content: space-between; padding: 24px;">
      <!-- Album Art -->
      <div style="width: 250px; height: 250px; border-radius: 16px; background: url('https://picsum.photos/300/300?random=music') center/cover; box-shadow: 0 16px 32px rgba(0,0,0,0.5);"></div>
      
      <!-- Track Info -->
      <div style="text-align: center; width: 100%;">
        <h2 style="margin: 0 0 8px 0; font-size: 24px; font-weight: 700;">Midnight Drive</h2>
        <div style="color: #94a3b8; font-size: 16px;">The Synthetics</div>
      </div>
      
      <!-- Progress -->
      <div style="width: 100%;">
        <div style="height: 4px; background: rgba(255,255,255,0.2); border-radius: 2px; position: relative; margin-bottom: 8px;">
          <div style="position: absolute; left: 0; top: 0; bottom: 0; width: 40%; background: white; border-radius: 2px;"></div>
          <div style="position: absolute; left: 40%; top: 50%; transform: translate(-50%, -50%); width: 12px; height: 12px; background: white; border-radius: 50%; box-shadow: 0 2px 4px rgba(0,0,0,0.2);"></div>
        </div>
        <div style="display: flex; justify-content: space-between; color: #94a3b8; font-size: 12px;">
          <span>1:24</span>
          <span>3:42</span>
        </div>
      </div>
      
      <!-- Controls -->
      <div style="display: flex; justify-content: space-between; align-items: center; width: 100%; padding: 0 16px;">
        <ion-icon :icon="shuffle" style="font-size: 24px; color: #94a3b8; cursor: pointer;" />
        <ion-icon :icon="playSkipBack" style="font-size: 32px; color: white; cursor: pointer;" />
        <div style="width: 72px; height: 72px; background: white; border-radius: 36px; display: flex; align-items: center; justify-content: center; cursor: pointer; box-shadow: 0 4px 12px rgba(255,255,255,0.2);">
          <ion-icon :icon="play" style="font-size: 36px; color: #0f172a; margin-left: 4px;" />
        </div>
        <ion-icon :icon="playSkipForward" style="font-size: 32px; color: white; cursor: pointer;" />
        <ion-icon :icon="repeat" style="font-size: 24px; color: #94a3b8; cursor: pointer;" />
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { IonIcon } from '@ionic/vue';
import { chevronDownOutline, ellipsisHorizontal, shuffle, playSkipBack, play, playSkipForward, repeat } from 'ionicons/icons';
import { PPIconButton } from '@phanna/ui-framework';
</script>
