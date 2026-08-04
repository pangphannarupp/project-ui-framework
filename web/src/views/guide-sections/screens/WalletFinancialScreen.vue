<template>
  <div style="height: 600px; width: 100%; max-width: 400px; border: 1px solid var(--pp-border, #e2e8f0); border-radius: 12px; overflow: hidden; position: relative; margin: 0 auto; background: #f8fafc; display: flex; flex-direction: column;">
    
    <!-- Top Card / Balance -->
    <div style="background: var(--pp-primary, #3b82f6); color: white; padding: 24px 24px 32px 24px; border-radius: 0 0 24px 24px; box-shadow: 0 4px 12px rgba(59,130,246,0.3);">
      <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 24px;">
        <div style="display: flex; align-items: center; gap: 12px;">
          <PPAvatar src="https://i.pravatar.cc/150?u=444" size="sm" style="border: 2px solid white;" />
          <span style="font-weight: 500;">Hi, Alex</span>
        </div>
        <ion-icon :icon="notificationsOutline" style="font-size: 24px; cursor: pointer;" />
      </div>
      
      <div style="margin-bottom: 8px; opacity: 0.8; font-size: 14px;">Total Balance</div>
      <div style="font-size: 36px; font-weight: 700; display: flex; align-items: center; gap: 8px;">
        $12,450.00
        <ion-icon :icon="eyeOutline" style="font-size: 20px; opacity: 0.8; cursor: pointer;" />
      </div>
    </div>
    
    <!-- Quick Actions (Floating) -->
    <div style="display: flex; justify-content: space-between; padding: 0 32px; margin-top: -24px; position: relative; z-index: 10;">
      <div style="display: flex; flex-direction: column; align-items: center; gap: 8px;">
        <div style="width: 48px; height: 48px; background: white; border-radius: 16px; display: flex; align-items: center; justify-content: center; box-shadow: 0 4px 12px rgba(0,0,0,0.05); cursor: pointer; color: var(--pp-primary, #3b82f6);">
          <ion-icon :icon="arrowUpOutline" style="font-size: 24px;" />
        </div>
        <span style="font-size: 12px; font-weight: 600; color: #334155;">Send</span>
      </div>
      <div style="display: flex; flex-direction: column; align-items: center; gap: 8px;">
        <div style="width: 48px; height: 48px; background: white; border-radius: 16px; display: flex; align-items: center; justify-content: center; box-shadow: 0 4px 12px rgba(0,0,0,0.05); cursor: pointer; color: var(--pp-primary, #3b82f6);">
          <ion-icon :icon="arrowDownOutline" style="font-size: 24px;" />
        </div>
        <span style="font-size: 12px; font-weight: 600; color: #334155;">Receive</span>
      </div>
      <div style="display: flex; flex-direction: column; align-items: center; gap: 8px;">
        <div style="width: 48px; height: 48px; background: white; border-radius: 16px; display: flex; align-items: center; justify-content: center; box-shadow: 0 4px 12px rgba(0,0,0,0.05); cursor: pointer; color: var(--pp-primary, #3b82f6);">
          <ion-icon :icon="cardOutline" style="font-size: 24px;" />
        </div>
        <span style="font-size: 12px; font-weight: 600; color: #334155;">Top Up</span>
      </div>
      <div style="display: flex; flex-direction: column; align-items: center; gap: 8px;">
        <div style="width: 48px; height: 48px; background: white; border-radius: 16px; display: flex; align-items: center; justify-content: center; box-shadow: 0 4px 12px rgba(0,0,0,0.05); cursor: pointer; color: var(--pp-primary, #3b82f6);">
          <ion-icon :icon="gridOutline" style="font-size: 24px;" />
        </div>
        <span style="font-size: 12px; font-weight: 600; color: #334155;">More</span>
      </div>
    </div>
    
    <!-- Recent Transactions -->
    <div style="flex: 1; overflow-y: auto; padding: 24px 16px;">
      <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px;">
        <h3 style="margin: 0; font-size: 18px; color: #0f172a;">Recent Transactions</h3>
        <span style="font-size: 14px; color: var(--pp-primary, #3b82f6); font-weight: 600; cursor: pointer;">See All</span>
      </div>
      
      <div style="display: flex; flex-direction: column; gap: 16px;">
        <div style="display: flex; justify-content: space-between; align-items: center; background: white; padding: 16px; border-radius: 12px; box-shadow: 0 2px 4px rgba(0,0,0,0.02);">
          <div style="display: flex; align-items: center; gap: 12px;">
            <div style="width: 40px; height: 40px; background: #fee2e2; border-radius: 20px; display: flex; align-items: center; justify-content: center; color: #ef4444;">
              <ion-icon :icon="cartOutline" style="font-size: 20px;" />
            </div>
            <div>
              <div style="font-weight: 600; font-size: 15px; color: #0f172a;">Grocery Store</div>
              <div style="font-size: 13px; color: #64748b;">Today, 10:45 AM</div>
            </div>
          </div>
          <div style="font-weight: 700; font-size: 15px; color: #0f172a;">-$64.20</div>
        </div>
        
        <div style="display: flex; justify-content: space-between; align-items: center; background: white; padding: 16px; border-radius: 12px; box-shadow: 0 2px 4px rgba(0,0,0,0.02);">
          <div style="display: flex; align-items: center; gap: 12px;">
            <div style="width: 40px; height: 40px; background: #dcfce7; border-radius: 20px; display: flex; align-items: center; justify-content: center; color: #10b981;">
              <ion-icon :icon="cashOutline" style="font-size: 20px;" />
            </div>
            <div>
              <div style="font-weight: 600; font-size: 15px; color: #0f172a;">Salary Deposit</div>
              <div style="font-size: 13px; color: #64748b;">Yesterday, 9:00 AM</div>
            </div>
          </div>
          <div style="font-weight: 700; font-size: 15px; color: #10b981;">+$3,200.00</div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { IonIcon } from '@ionic/vue';
import { notificationsOutline, eyeOutline, arrowUpOutline, arrowDownOutline, cardOutline, gridOutline, cartOutline, cashOutline } from 'ionicons/icons';
import { PPAvatar } from '@phanna/ui-framework';
</script>
