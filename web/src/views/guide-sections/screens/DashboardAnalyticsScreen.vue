<template>
  <div style="height: 600px; width: 100%; max-width: 400px; border: 1px solid var(--pp-border, #e2e8f0); border-radius: 12px; overflow: hidden; position: relative; margin: 0 auto; background: #f8fafc; display: flex; flex-direction: column;">
    <PPAppBar title="Dashboard" />
    
    <div style="flex: 1; overflow-y: auto; padding: 16px;">
      <!-- Key Metrics -->
      <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px; margin-bottom: 24px;">
        <div style="background: white; padding: 16px; border-radius: 12px; box-shadow: 0 1px 3px rgba(0,0,0,0.05);">
          <div style="color: #64748b; font-size: 13px; font-weight: 500; margin-bottom: 8px;">Total Users</div>
          <div style="font-size: 24px; font-weight: 700; color: #0f172a;">24.5k</div>
          <div style="color: #10b981; font-size: 12px; font-weight: 600; margin-top: 4px;">↑ +12% this week</div>
        </div>
        <div style="background: white; padding: 16px; border-radius: 12px; box-shadow: 0 1px 3px rgba(0,0,0,0.05);">
          <div style="color: #64748b; font-size: 13px; font-weight: 500; margin-bottom: 8px;">Revenue</div>
          <div style="font-size: 24px; font-weight: 700; color: #0f172a;">$12.4k</div>
          <div style="color: #ef4444; font-size: 12px; font-weight: 600; margin-top: 4px;">↓ -2% this week</div>
        </div>
      </div>
      
      <!-- Chart Area -->
      <div style="background: white; padding: 16px; border-radius: 12px; box-shadow: 0 1px 3px rgba(0,0,0,0.05); margin-bottom: 24px;">
        <h3 style="margin: 0 0 16px 0; font-size: 16px; color: #334155;">Weekly Traffic</h3>
        <div style="height: 120px; display: flex; align-items: flex-end; justify-content: space-between; gap: 8px;">
          <!-- Fake Bar Chart -->
          <div v-for="h in [40, 70, 45, 90, 60, 80, 50]" :key="h" style="flex: 1; background: var(--pp-primary, #3b82f6); border-radius: 4px 4px 0 0; opacity: 0.8;" :style="{ height: h + '%' }"></div>
        </div>
        <div style="display: flex; justify-content: space-between; margin-top: 8px; color: #94a3b8; font-size: 11px;">
          <span>Mon</span><span>Tue</span><span>Wed</span><span>Thu</span><span>Fri</span><span>Sat</span><span>Sun</span>
        </div>
      </div>
      
      <!-- Recent Activity -->
      <h3 style="margin: 0 0 12px 0; font-size: 16px; color: #334155;">Recent Activity</h3>
      <div style="display: flex; flex-direction: column; gap: 12px;">
        <div v-for="i in 4" :key="i" style="background: white; padding: 12px; border-radius: 12px; display: flex; gap: 12px; align-items: center; box-shadow: 0 1px 2px rgba(0,0,0,0.02);">
          <div style="width: 40px; height: 40px; border-radius: 20px; background: #e0e7ff; display: flex; align-items: center; justify-content: center; color: var(--pp-primary, #3b82f6);">
            <ion-icon :icon="personOutline" />
          </div>
          <div style="flex: 1;">
            <div style="font-size: 14px; font-weight: 500; color: #0f172a;">New user signed up</div>
            <div style="font-size: 12px; color: #64748b;">{{ i * 10 }} mins ago</div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { IonIcon } from '@ionic/vue';
import { personOutline } from 'ionicons/icons';
import { PPAppBar } from '@phanna/ui-framework';
</script>
