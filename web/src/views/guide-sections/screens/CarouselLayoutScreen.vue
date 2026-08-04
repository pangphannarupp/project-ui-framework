<template>
  <div style="height: 600px; width: 100%; max-width: 400px; border: 1px solid var(--pp-border, #e2e8f0); border-radius: 12px; overflow: hidden; position: relative; margin: 0 auto; background: white; display: flex; flex-direction: column;">
    <PPAppBar title="Discover" />
    
    <div style="flex: 1; overflow-y: auto; padding: 16px 0;">
      
      <div style="padding: 0 16px; margin-bottom: 16px; display: flex; justify-content: space-between; align-items: baseline;">
        <h2 style="margin: 0; font-size: 20px;">Featured</h2>
        <a href="#" style="color: var(--pp-primary, #3b82f6); text-decoration: none; font-weight: 500; font-size: 14px;">See All</a>
      </div>

      <!-- Horizontal Scroll Area (Carousel) -->
      <div style="display: flex; overflow-x: auto; padding: 0 16px; gap: 16px; scroll-snap-type: x mandatory; margin-bottom: 32px;">
        <div v-for="i in 5" :key="`feat-${i}`" style="min-width: 280px; scroll-snap-align: start; background: white; border-radius: 12px; overflow: hidden; box-shadow: 0 2px 8px rgba(0,0,0,0.1);">
          <div :style="`height: 160px; background: url('https://picsum.photos/280/160?random=${i + 30}') center/cover;`"></div>
          <div style="padding: 12px;">
            <h3 style="margin: 0 0 4px 0; font-size: 16px;">Featured Item {{ i }}</h3>
            <p style="margin: 0; color: #64748b; font-size: 14px;">Short description goes here.</p>
          </div>
        </div>
      </div>

      <div style="padding: 0 16px; margin-bottom: 16px;">
        <h2 style="margin: 0; font-size: 20px;">Recommended for You</h2>
      </div>

      <!-- Vertical List underneath -->
      <div style="padding: 0 16px; display: flex; flex-direction: column; gap: 16px;">
        <div v-for="i in 5" :key="`rec-${i}`" style="display: flex; gap: 12px; align-items: center;">
          <div :style="`width: 80px; height: 80px; border-radius: 8px; background: url('https://picsum.photos/80/80?random=${i + 40}') center/cover;`"></div>
          <div>
            <h4 style="margin: 0 0 4px 0; font-size: 16px;">Recommendation {{ i }}</h4>
            <p style="margin: 0; color: #64748b; font-size: 14px;">More detail about this item.</p>
          </div>
        </div>
      </div>

    </div>
  </div>
</template>

<script setup lang="ts">
import { PPAppBar } from '@phanna/ui-framework';
</script>
