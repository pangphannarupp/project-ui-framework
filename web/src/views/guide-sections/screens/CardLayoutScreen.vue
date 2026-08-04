<template>
  <div style="height: 600px; width: 100%; max-width: 400px; border: 1px solid var(--pp-border, #e2e8f0); border-radius: 12px; overflow: hidden; position: relative; margin: 0 auto; background: #f1f5f9; display: flex; flex-direction: column;">
    <PPAppBar title="News Feed" />
    
    <div style="flex: 1; overflow-y: auto; padding: 16px;">
      <div style="display: flex; flex-direction: column; gap: 20px;">
        <!-- Card 1 -->
        <div style="background: white; border-radius: 16px; overflow: hidden; box-shadow: 0 4px 12px rgba(0,0,0,0.05);">
          <div style="height: 200px; background: url('https://picsum.photos/400/200?random=1') center/cover;"></div>
          <div style="padding: 16px;">
            <div style="color: var(--pp-primary, #3b82f6); font-size: 12px; font-weight: 600; text-transform: uppercase; margin-bottom: 8px;">Technology</div>
            <h3 style="margin: 0 0 8px 0; font-size: 18px;">The Future of Mobile Design</h3>
            <p style="margin: 0; color: #64748b; font-size: 14px; line-height: 1.5;">Exploring the latest trends in UI and UX for the upcoming year.</p>
          </div>
        </div>

        <!-- Card 2 -->
        <div style="background: white; border-radius: 16px; overflow: hidden; box-shadow: 0 4px 12px rgba(0,0,0,0.05);">
          <div style="height: 200px; background: url('https://picsum.photos/400/200?random=2') center/cover;"></div>
          <div style="padding: 16px;">
            <div style="color: var(--pp-primary, #3b82f6); font-size: 12px; font-weight: 600; text-transform: uppercase; margin-bottom: 8px;">Design</div>
            <h3 style="margin: 0 0 8px 0; font-size: 18px;">Why Whitespace Matters</h3>
            <p style="margin: 0; color: #64748b; font-size: 14px; line-height: 1.5;">How to use empty space to guide users and improve readability.</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { PPAppBar } from '@phanna/ui-framework';
</script>
