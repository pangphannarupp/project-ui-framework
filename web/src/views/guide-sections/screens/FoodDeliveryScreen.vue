<template>
  <div style="height: 600px; width: 100%; max-width: 400px; border: 1px solid var(--pp-border, #e2e8f0); border-radius: 12px; overflow: hidden; position: relative; margin: 0 auto; background: #f8fafc; display: flex; flex-direction: column;">
    
    <!-- Transparent Top Nav -->
    <div style="position: absolute; top: 0; left: 0; right: 0; padding: 16px; display: flex; justify-content: space-between; z-index: 10;">
      <div style="background: rgba(255,255,255,0.9); border-radius: 50%; width: 40px; height: 40px; display: flex; align-items: center; justify-content: center; cursor: pointer; box-shadow: 0 2px 8px rgba(0,0,0,0.1);">
        <ion-icon :icon="arrowBackOutline" style="font-size: 20px; color: #0f172a;" />
      </div>
      <div style="display: flex; gap: 8px;">
        <div style="background: rgba(255,255,255,0.9); border-radius: 50%; width: 40px; height: 40px; display: flex; align-items: center; justify-content: center; cursor: pointer; box-shadow: 0 2px 8px rgba(0,0,0,0.1);">
          <ion-icon :icon="searchOutline" style="font-size: 20px; color: #0f172a;" />
        </div>
        <div style="background: rgba(255,255,255,0.9); border-radius: 50%; width: 40px; height: 40px; display: flex; align-items: center; justify-content: center; cursor: pointer; box-shadow: 0 2px 8px rgba(0,0,0,0.1);">
          <ion-icon :icon="shareOutline" style="font-size: 20px; color: #0f172a;" />
        </div>
      </div>
    </div>
    
    <!-- Main Content -->
    <div style="flex: 1; overflow-y: auto;">
      <!-- Hero Image -->
      <div style="height: 220px; background: url('https://picsum.photos/400/300?random=food') center/cover;"></div>
      
      <!-- Restaurant Info -->
      <div style="padding: 20px 16px; background: white;">
        <h2 style="margin: 0 0 8px 0; font-size: 24px; color: #0f172a;">Burger Joint & Co.</h2>
        <div style="display: flex; align-items: center; gap: 12px; color: #64748b; font-size: 14px; margin-bottom: 16px;">
          <div style="display: flex; align-items: center; gap: 4px;">
            <ion-icon :icon="star" style="color: #fbbf24;" />
            <span style="font-weight: 600; color: #334155;">4.9</span> (500+)
          </div>
          <div>•</div>
          <div>American, Burgers</div>
          <div>•</div>
          <div>$$</div>
        </div>
        <div style="display: flex; align-items: center; gap: 8px; background: #f1f5f9; padding: 12px; border-radius: 8px; font-size: 14px;">
          <ion-icon :icon="timeOutline" style="color: #64748b; font-size: 18px;" />
          <span style="font-weight: 500;">Delivery: 20-30 min</span>
        </div>
      </div>
      
      <!-- Sticky Categories -->
      <div style="position: sticky; top: 0; background: white; border-bottom: 1px solid #e2e8f0; padding: 12px 16px; display: flex; gap: 16px; overflow-x: auto; white-space: nowrap; z-index: 5;">
        <div style="font-weight: 600; color: var(--pp-primary, #3b82f6); border-bottom: 2px solid var(--pp-primary, #3b82f6); padding-bottom: 4px;">Popular</div>
        <div style="font-weight: 500; color: #64748b; padding-bottom: 4px;">Burgers</div>
        <div style="font-weight: 500; color: #64748b; padding-bottom: 4px;">Sides</div>
        <div style="font-weight: 500; color: #64748b; padding-bottom: 4px;">Drinks</div>
      </div>
      
      <!-- Menu Items -->
      <div style="padding: 16px; display: flex; flex-direction: column; gap: 24px; padding-bottom: 100px;">
        <div style="display: flex; gap: 16px; align-items: center;">
          <div style="flex: 1;">
            <h4 style="margin: 0 0 4px 0; font-size: 16px; color: #0f172a;">Classic Cheeseburger</h4>
            <p style="margin: 0 0 8px 0; font-size: 13px; color: #64748b; line-height: 1.4; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;">Beef patty, cheddar cheese, lettuce, tomato, onions, and our secret sauce.</p>
            <div style="font-weight: 600; font-size: 15px;">$12.99</div>
          </div>
          <div style="width: 100px; height: 100px; border-radius: 8px; background: url('https://picsum.photos/100/100?random=burger1') center/cover; position: relative;">
            <div style="position: absolute; bottom: -10px; right: 50%; transform: translateX(50%); background: white; border-radius: 16px; padding: 4px 12px; box-shadow: 0 2px 8px rgba(0,0,0,0.15); font-weight: 600; font-size: 13px; color: var(--pp-primary, #3b82f6); cursor: pointer;">Add</div>
          </div>
        </div>
        
        <div style="height: 1px; background: #e2e8f0;"></div>
        
        <div style="display: flex; gap: 16px; align-items: center;">
          <div style="flex: 1;">
            <h4 style="margin: 0 0 4px 0; font-size: 16px; color: #0f172a;">Truffle Fries</h4>
            <p style="margin: 0 0 8px 0; font-size: 13px; color: #64748b; line-height: 1.4; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;">Crispy fries tossed in truffle oil, parmesan, and parsley.</p>
            <div style="font-weight: 600; font-size: 15px;">$6.50</div>
          </div>
          <div style="width: 100px; height: 100px; border-radius: 8px; background: url('https://picsum.photos/100/100?random=fries') center/cover; position: relative;">
            <div style="position: absolute; bottom: -10px; right: 50%; transform: translateX(50%); background: white; border-radius: 16px; padding: 4px 12px; box-shadow: 0 2px 8px rgba(0,0,0,0.15); font-weight: 600; font-size: 13px; color: var(--pp-primary, #3b82f6); cursor: pointer;">Add</div>
          </div>
        </div>
      </div>
    </div>
    
    <!-- Floating View Cart Button -->
    <div style="position: absolute; bottom: 16px; left: 16px; right: 16px; z-index: 20;">
      <div style="background: var(--pp-primary, #3b82f6); color: white; padding: 16px; border-radius: 12px; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 8px 24px rgba(59,130,246,0.4); cursor: pointer;">
        <div style="background: rgba(255,255,255,0.2); width: 32px; height: 32px; border-radius: 16px; display: flex; align-items: center; justify-content: center; font-weight: 600; font-size: 14px;">2</div>
        <div style="font-weight: 600; font-size: 16px;">View Cart</div>
        <div style="font-weight: 600; font-size: 16px;">$19.49</div>
      </div>
    </div>
    
  </div>
</template>

<script setup lang="ts">
import { IonIcon } from '@ionic/vue';
import { arrowBackOutline, searchOutline, shareOutline, star, timeOutline } from 'ionicons/icons';
</script>
