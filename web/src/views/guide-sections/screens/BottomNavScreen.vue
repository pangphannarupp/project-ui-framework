<template>
  <div style="height: 600px; width: 100%; max-width: 400px; border: 1px solid var(--pp-border, #e2e8f0); border-radius: 12px; overflow: hidden; position: relative; margin: 0 auto;">
    <PPMaterialApp :theme="'light'" :responsive="false">
      <template #header>
        <PPAppBar title="Home" />
      </template>

      <div style="padding: 16px;">
        <h2>Feed</h2>
        <div style="display: flex; flex-direction: column; gap: 16px;">
          <div v-for="i in 5" :key="i" style="background: var(--pp-surface, white); padding: 16px; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1);">
            <div style="display: flex; align-items: center; gap: 12px; margin-bottom: 12px;">
              <PPAvatar :src="`https://i.pravatar.cc/150?u=${i}`" size="sm" />
              <div style="font-weight: 500;">User {{ i }}</div>
            </div>
            <div style="height: 150px; background: #f1f5f9; border-radius: 8px;"></div>
            <div style="margin-top: 12px; color: #64748b; font-size: 14px;">This is a post description showcasing the bottom nav layout.</div>
          </div>
        </div>
      </div>

      <template #bottom-nav>
        <PPBottomNav
          :items="bottomNavItems"
          v-model="activeBottom"
        />
      </template>
    </PPMaterialApp>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { homeOutline, home, searchOutline, search, personOutline, person, addCircleOutline, addCircle } from 'ionicons/icons';
import { PPMaterialApp, PPAppBar, PPBottomNav, PPAvatar } from '@phanna/ui-framework';

const activeBottom = ref('home');
const bottomNavItems = [
  { value: 'home', label: 'Home', icon: homeOutline, activeIcon: home },
  { value: 'search', label: 'Search', icon: searchOutline, activeIcon: search },
  { value: 'create', label: 'Create', icon: addCircleOutline, activeIcon: addCircle },
  { value: 'profile', label: 'Profile', icon: personOutline, activeIcon: person }
];
</script>
