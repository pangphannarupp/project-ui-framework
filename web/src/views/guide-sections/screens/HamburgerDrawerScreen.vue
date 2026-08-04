<template>
  <div style="height: 600px; width: 100%; max-width: 400px; border: 1px solid var(--pp-border, #e2e8f0); border-radius: 12px; overflow: hidden; position: relative; margin: 0 auto;">
    <PPMaterialApp :theme="'light'" :responsive="false" :drawer-open="drawerOpen" @close-drawer="drawerOpen = false">
      <template #header>
        <PPAppBar title="App">
          <template #left>
            <PPIconButton @click="drawerOpen = !drawerOpen" color="transparent">
              <ion-icon :icon="menuOutline" />
            </PPIconButton>
          </template>
        </PPAppBar>
      </template>

      <template #drawer>
        <PPSidebarNavigation
          v-model="activeMenu"
          :items="sidebarItems"
          :collapsed="!drawerOpen"
        />
      </template>

      <div style="padding: 24px;">
        <h2>Main Content</h2>
        <p>This layout uses a drawer for navigation. Tap the hamburger icon in the top left to open it.</p>
        <div style="height: 300px; background: repeating-linear-gradient(45deg, transparent, transparent 10px, rgba(0,0,0,0.05) 10px, rgba(0,0,0,0.05) 20px); border-radius: 8px; margin-top: 24px; padding: 24px;">
          Scrollable area.
        </div>
      </div>
    </PPMaterialApp>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { IonIcon } from '@ionic/vue';
import { menuOutline, homeOutline, settingsOutline, personOutline } from 'ionicons/icons';
import { PPMaterialApp, PPAppBar, PPSidebarNavigation, PPIconButton } from '@phanna/ui-framework';

const drawerOpen = ref(false);
const activeMenu = ref('home');

const sidebarItems = [
  {
    groupLabel: 'Menu',
    items: [
      { id: 'home', label: 'Home', icon: homeOutline },
      { id: 'profile', label: 'Profile', icon: personOutline },
      { id: 'settings', label: 'Settings', icon: settingsOutline }
    ]
  }
];
</script>
