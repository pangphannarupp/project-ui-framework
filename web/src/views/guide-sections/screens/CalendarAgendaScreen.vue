<template>
  <div style="height: 600px; width: 100%; max-width: 400px; border: 1px solid var(--pp-border, #e2e8f0); border-radius: 12px; overflow: hidden; position: relative; margin: 0 auto; background: #f8fafc; display: flex; flex-direction: column;">
    <PPAppBar title="Schedule" />
    
    <!-- Week Header -->
    <div style="background: white; border-bottom: 1px solid #e2e8f0; padding: 16px;">
      <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px;">
        <div style="font-weight: 600; font-size: 16px; color: #0f172a;">August 2026</div>
        <div style="display: flex; gap: 12px;">
          <ion-icon :icon="searchOutline" style="font-size: 20px; color: #64748b; cursor: pointer;" />
          <ion-icon :icon="calendarOutline" style="font-size: 20px; color: #64748b; cursor: pointer;" />
        </div>
      </div>
      
      <!-- Date Scroller -->
      <div style="display: flex; justify-content: space-between;">
        <div v-for="(day, index) in ['M','T','W','T','F','S','S']" :key="index" style="display: flex; flex-direction: column; align-items: center; gap: 8px;">
          <div style="font-size: 12px; color: #94a3b8; font-weight: 500;">{{ day }}</div>
          <div :style="index === 2 ? 'background: var(--pp-primary, #3b82f6); color: white;' : 'color: #334155;'" style="width: 32px; height: 32px; border-radius: 16px; display: flex; align-items: center; justify-content: center; font-size: 14px; font-weight: 600; cursor: pointer;">
            {{ 3 + index }}
          </div>
        </div>
      </div>
    </div>
    
    <!-- Agenda -->
    <div style="flex: 1; overflow-y: auto; padding: 16px;">
      <div style="display: flex; flex-direction: column; gap: 24px;">
        
        <!-- Time Block -->
        <div style="display: flex; gap: 16px;">
          <div style="width: 50px; font-size: 13px; color: #94a3b8; font-weight: 500; text-align: right; padding-top: 4px;">10:00 AM</div>
          <div style="flex: 1; background: #e0e7ff; border-left: 4px solid var(--pp-primary, #3b82f6); padding: 12px; border-radius: 0 8px 8px 0;">
            <div style="font-weight: 600; font-size: 15px; color: #1e3a8a; margin-bottom: 4px;">Team Standup</div>
            <div style="font-size: 13px; color: #3b82f6;">Zoom Room A</div>
          </div>
        </div>
        
        <!-- Time Block -->
        <div style="display: flex; gap: 16px;">
          <div style="width: 50px; font-size: 13px; color: #94a3b8; font-weight: 500; text-align: right; padding-top: 4px;">11:30 AM</div>
          <div style="flex: 1; background: #dcfce7; border-left: 4px solid #10b981; padding: 12px; border-radius: 0 8px 8px 0;">
            <div style="font-weight: 600; font-size: 15px; color: #065f46; margin-bottom: 4px;">Design Review</div>
            <div style="font-size: 13px; color: #10b981;">11:30 AM - 1:00 PM</div>
          </div>
        </div>
        
        <!-- Time Block -->
        <div style="display: flex; gap: 16px;">
          <div style="width: 50px; font-size: 13px; color: #94a3b8; font-weight: 500; text-align: right; padding-top: 4px;">2:00 PM</div>
          <div style="flex: 1; background: #fef9c3; border-left: 4px solid #eab308; padding: 12px; border-radius: 0 8px 8px 0;">
            <div style="font-weight: 600; font-size: 15px; color: #854d0e; margin-bottom: 4px;">Client Call</div>
            <div style="font-size: 13px; color: #ca8a04;">Phone</div>
          </div>
        </div>

      </div>
    </div>
    
    <!-- FAB -->
    <div style="position: absolute; bottom: 16px; right: 16px;">
      <PPFab color="primary" shape="circle">
        <template #icon><ion-icon :icon="addOutline" /></template>
      </PPFab>
    </div>
  </div>
</template>

<script setup lang="ts">
import { IonIcon } from '@ionic/vue';
import { searchOutline, calendarOutline, addOutline } from 'ionicons/icons';
import { PPAppBar, PPFab } from '@phanna/ui-framework';
</script>
