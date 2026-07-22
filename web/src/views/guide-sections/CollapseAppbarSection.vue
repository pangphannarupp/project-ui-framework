<template>
<div class="guide-section">
        <h2>Collapsing Appbar</h2>
        <div class="variant-group">
          <h3>Scroll to Collapse</h3>
          <p class="custom-guide">A Material Design style collapsing toolbar. Scroll the content below to see it shrink!</p>
          <div class="component-demo" style="height: 400px; padding: 0; border-radius: 12px; overflow: hidden; position: relative;">
            <PPCollapsingToolbar title="Profile" :expandedHeight="200" :collapsedHeight="56">
              <template #background>
                <img src="https://images.unsplash.com/photo-1579546929518-9e396f3cc809?q=80&w=1000&auto=format&fit=crop" alt="bg" />
              </template>
              <template #start>
                <PPIconButton color="white"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="24" height="24"><path d="M19 12H5M12 19l-7-7 7-7"/></svg></PPIconButton>
              </template>
              
              <template #profile>
                <img src="https://i.pravatar.cc/150?img=68" alt="Profile" style="width: 32px; height: 32px; border-radius: 50%; border: 2px solid white; object-fit: cover; box-shadow: 0 2px 4px rgba(0,0,0,0.2);" />
              </template>
              
              <div style="padding: 24px;">
                <p v-for="i in 10" :key="i" style="margin-bottom: 20px; font-size: 16px; color: #555;">
                  Scrollable content block {{ i }}. Keep scrolling to see the header collapse.
                </p>
              </div>
            </PPCollapsingToolbar>
          </div>
        </div>
        
        <div class="variant-group">
          <h3>Standard Header (No Profile)</h3>
          <p class="custom-guide">Without a profile picture, the title scales and aligns correctly by itself. Here it moves to the center when collapsed.</p>
          <div class="component-demo" style="height: 400px; padding: 0; border-radius: 12px; overflow: hidden; position: relative;">
            <PPCollapsingToolbar title="Dashboard" :expandedHeight="200" :collapsedHeight="56" centerTitleOnCollapse>
              <template #background>
                <img src="https://images.unsplash.com/photo-1550684848-fac1c5b4e853?q=80&w=1000&auto=format&fit=crop" alt="bg" />
              </template>
              <template #start>
                <PPIconButton color="white"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="24" height="24"><path d="M19 12H5M12 19l-7-7 7-7"/></svg></PPIconButton>
              </template>
              
              <div style="padding: 24px;">
                <p v-for="i in 10" :key="i" style="margin-bottom: 20px; font-size: 16px; color: #555;">
                  Scrollable content block {{ i }}. Keep scrolling to see the header collapse.
                </p>
              </div>
            </PPCollapsingToolbar>
          </div>
        </div>
      </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

import { PPCollapsingToolbar } from '@phanna/ui-framework';
</script>
