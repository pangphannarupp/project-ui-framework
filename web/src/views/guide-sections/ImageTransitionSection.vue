<template>
<div class="guide-section">
        <h2>Image Transition (List to Detail)</h2>
        <div class="variant-group">
          <h3>Seamless Fullscreen Expansion</h3>
          <p class="custom-guide">Tap the thumbnail to see it expand perfectly into a full-screen detail view!</p>
          <div class="component-demo" style="display: flex; gap: 16px; align-items: center;">
            <div style="width: 60px; height: 60px; border-radius: 50%; overflow: hidden;">
              <PPImageTransition>
                <template #image>
                  <img 
                    src="https://images.unsplash.com/photo-1579546929518-9e396f3cc809?q=80&w=1000&auto=format&fit=crop" 
                    alt="Thumbnail"
                  />
                </template>
                <template #detail>
                  <div style="padding: 24px; color: #333;">
                    <h2 style="margin-top: 0; font-size: 28px;">Jane Doe</h2>
                    <p style="font-size: 16px; line-height: 1.5; color: #666;">
                      This image expanded beautifully without needing a route transition! 
                      Click the back button in the top left corner to collapse it right back into the list.
                    </p>
                  </div>
                </template>
              </PPImageTransition>
            </div>
            <div>
              <strong style="display: block; font-size: 16px;">Jane Doe</strong>
              <span style="color: #666; font-size: 14px;">Tap image to view profile</span>
            </div>
          </div>
        </div>
      </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

import { PPImageTransition } from '@phanna/ui-framework';
</script>
