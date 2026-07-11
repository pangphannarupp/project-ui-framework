<template>
  <div class="liquid-glass-container">
    <div class="liquid-glass-tab-bar">
      <router-link to="/tabs/tab1" class="tab-btn" active-class="active">
        <ion-icon :icon="triangle" />
        <span>Tab 1</span>
      </router-link>
      
      <router-link to="/tabs/tab2" class="tab-btn" active-class="active">
        <ion-icon :icon="ellipse" />
        <span>Tab 2</span>
      </router-link>
      
      <router-link to="/tabs/tab3" class="tab-btn" active-class="active">
        <ion-icon :icon="square" />
        <span>Tab 3</span>
      </router-link>
    </div>
  </div>
</template>

<script setup lang="ts">
import { IonIcon } from '@ionic/vue';
import { ellipse, square, triangle } from 'ionicons/icons';
</script>

<style scoped>
.liquid-glass-container {
  position: absolute;
  bottom: 24px;
  left: 0;
  right: 0;
  display: flex;
  justify-content: center;
  pointer-events: none;
  z-index: 1000;
}

.liquid-glass-tab-bar {
  display: flex;
  align-items: center;
  justify-content: space-around;
  width: 85%;
  max-width: 400px;
  height: 64px;
  border-radius: 32px;
  pointer-events: auto;
  
  /* Liquid Glass Effect */
  background: rgba(255, 255, 255, 0.4);
  backdrop-filter: blur(24px) saturate(150%);
  -webkit-backdrop-filter: blur(24px) saturate(150%);
  border: 1px solid rgba(255, 255, 255, 0.6);
  box-shadow: 
    0 8px 32px rgba(0, 0, 0, 0.15),
    inset 0 1px 1px rgba(255, 255, 255, 0.8),
    inset 0 -1px 1px rgba(255, 255, 255, 0.1);
  overflow: hidden;
}

.tab-btn {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  width: 100%;
  height: 100%;
  color: #555;
  text-decoration: none;
  transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
  border-radius: 20px;
  gap: 4px;
}

.tab-btn ion-icon {
  font-size: 22px;
  transition: transform 0.3s ease;
}

.tab-btn span {
  font-size: 11px;
  font-weight: 500;
  opacity: 0.8;
  transition: opacity 0.3s ease;
}

/* Active State */
.tab-btn.active {
  color: #007aff;
}

.tab-btn.active ion-icon {
  transform: translateY(-2px) scale(1.1);
}

.tab-btn.active span {
  opacity: 1;
  font-weight: 600;
}

/* Hover Effect (For non-touch devices) */
@media (hover: hover) {
  .tab-btn:hover {
    background: rgba(255, 255, 255, 0.2);
  }
}

/* Dark Mode Support */
@media (prefers-color-scheme: dark) {
  .liquid-glass-tab-bar {
    background: rgba(30, 30, 30, 0.45);
    border: 1px solid rgba(255, 255, 255, 0.15);
    box-shadow: 
      0 8px 32px rgba(0, 0, 0, 0.4),
      inset 0 1px 1px rgba(255, 255, 255, 0.15),
      inset 0 -1px 1px rgba(0, 0, 0, 0.3);
  }
  
  .tab-btn {
    color: #bbb;
  }
  
  .tab-btn.active {
    color: #4da6ff;
  }
  
  @media (hover: hover) {
    .tab-btn:hover {
      background: rgba(255, 255, 255, 0.05);
    }
  }
}
</style>
