<template>
  <div style="height: 600px; width: 100%; max-width: 800px; border: 1px solid var(--pp-border, #e2e8f0); border-radius: 12px; overflow: hidden; position: relative; margin: 0 auto; display: flex; background: #f8fafc;">
    
    <!-- Master List (Left Pane) -->
    <div style="width: 320px; border-right: 1px solid var(--pp-border, #e2e8f0); background: white; display: flex; flex-direction: column;">
      <PPAppBar title="Mail" />
      
      <div style="flex: 1; overflow-y: auto;">
        <div 
          v-for="i in 10" 
          :key="i"
          @click="activeItem = i"
          :style="`padding: 16px; border-bottom: 1px solid #f1f5f9; cursor: pointer; background: ${activeItem === i ? '#f1f5f9' : 'white'}; border-left: 3px solid ${activeItem === i ? 'var(--pp-primary, #3b82f6)' : 'transparent'};`"
        >
          <div style="display: flex; justify-content: space-between; align-items: baseline; margin-bottom: 4px;">
            <div style="font-weight: 600; font-size: 14px;">Sender {{ i }}</div>
            <div style="color: #64748b; font-size: 12px;">10:00 AM</div>
          </div>
          <div style="font-weight: 500; font-size: 13px; margin-bottom: 4px;">Subject line {{ i }}</div>
          <div style="color: #64748b; font-size: 13px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">Brief preview of the message content...</div>
        </div>
      </div>
    </div>

    <!-- Detail View (Right Pane) -->
    <div style="flex: 1; display: flex; flex-direction: column; background: white;">
      <template v-if="activeItem">
        <PPAppBar :title="`Message ${activeItem}`">
          <template #right>
            <PPIconButton color="transparent">
              <ion-icon :icon="trashOutline" />
            </PPIconButton>
          </template>
        </PPAppBar>

        <div style="flex: 1; padding: 24px; overflow-y: auto;">
          <div style="display: flex; align-items: center; gap: 16px; margin-bottom: 24px;">
            <PPAvatar :src="`https://i.pravatar.cc/150?u=${activeItem}`" size="lg" />
            <div>
              <div style="font-size: 18px; font-weight: 600;">Sender {{ activeItem }}</div>
              <div style="color: #64748b; font-size: 14px;">sender{{ activeItem }}@example.com</div>
            </div>
          </div>

          <h2 style="margin: 0 0 16px 0; font-size: 20px;">Subject line {{ activeItem }}</h2>
          
          <div style="color: #334155; line-height: 1.6;">
            <p>Hello,</p>
            <p>This is the detailed view for message {{ activeItem }}. The master-detail layout is excellent for tablet devices or landscape orientations on larger phones, allowing users to browse a list without losing context of the currently selected item.</p>
            <p>Best regards,<br/>Sender {{ activeItem }}</p>
          </div>
        </div>
      </template>
      <div v-else style="flex: 1; display: flex; align-items: center; justify-content: center; color: #94a3b8; font-size: 16px;">
        Select a message to read
      </div>
    </div>

  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { IonIcon } from '@ionic/vue';
import { trashOutline } from 'ionicons/icons';
import { PPAppBar, PPIconButton, PPAvatar } from '@phanna/ui-framework';

const activeItem = ref<number | null>(1);
</script>
