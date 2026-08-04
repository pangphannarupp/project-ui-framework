<template>
  <div style="height: 600px; width: 100%; max-width: 400px; border: 1px solid var(--pp-border, #e2e8f0); border-radius: 12px; overflow: hidden; position: relative; margin: 0 auto; background: white; display: flex; flex-direction: column;">
    <PPAppBar title="Inbox" />
    
    <div style="flex: 1; overflow-y: auto;">
      <div v-for="i in 15" :key="i" style="display: flex; align-items: flex-start; gap: 16px; padding: 16px; border-bottom: 1px solid #f1f5f9;">
        <PPAvatar :src="`https://i.pravatar.cc/150?u=${i + 20}`" size="md" />
        <div style="flex: 1;">
          <div style="display: flex; justify-content: space-between; align-items: baseline; margin-bottom: 4px;">
            <div style="font-weight: 600; font-size: 16px;">Sender {{ i }}</div>
            <div style="color: #64748b; font-size: 12px;">12:0{{ i }} PM</div>
          </div>
          <div style="font-weight: 500; font-size: 14px; margin-bottom: 4px; color: #334155;">Weekly Update Meeting</div>
          <div style="color: #64748b; font-size: 14px; line-height: 1.4; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 250px;">
            Hi, just wanted to check in before our meeting tomorrow to see if...
          </div>
        </div>
      </div>
    </div>

    <!-- FAB -->
    <div style="position: absolute; bottom: 24px; right: 24px;">
      <PPFab color="primary" shape="circle">
        <template #icon><ion-icon :icon="addOutline" /></template>
      </PPFab>
    </div>
  </div>
</template>

<script setup lang="ts">
import { IonIcon } from '@ionic/vue';
import { addOutline } from 'ionicons/icons';
import { PPAppBar, PPAvatar, PPFab } from '@phanna/ui-framework';
</script>
