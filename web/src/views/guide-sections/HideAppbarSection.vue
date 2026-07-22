<template>
<div class="guide-section">
        <h2>Hide on Scroll App Bar</h2>
        <p class="guide-desc">A header that seamlessly hides when scrolling down, and reveals when scrolling up.</p>

        <div class="variant-group">
          <h3>Interactive Demo</h3>
          <div class="component-demo" style="height: 400px; padding: 0;">
            <PPHideAppBar :headerHeight="56">
              <template #header>
                <div style="height: 100%; display: flex; align-items: center; padding: 0 16px; background: var(--pp-primary-light, #3880ff); color: white;">
                  <h2 style="margin: 0; font-size: 18px;">My Hidden Header</h2>
                </div>
              </template>
              
              <div style="padding: 16px; display: flex; flex-direction: column; gap: 16px;">
                <div v-for="i in 20" :key="i" style="padding: 16px; background: #fff; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.05);">
                  Scroll me up and down! Item {{ i }}
                </div>
              </div>
            </PPHideAppBar>
          </div>
          <pre class="code-block"><code>&lt;PPHideAppBar :headerHeight="56"&gt;
  &lt;template #header&gt;
    &lt;div&gt;My Header&lt;/div&gt;
  &lt;/template&gt;

  &lt;!-- Scrollable content --&gt;
  &lt;div&gt;...&lt;/div&gt;
&lt;/PPHideAppBar&gt;</code></pre>
        </div>
      </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

import { PPHideAppBar } from '@phanna/ui-framework';
</script>
