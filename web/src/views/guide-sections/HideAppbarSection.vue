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
          <pre class="code-block" v-pre><code>&lt;PPHideAppBar :headerHeight="56"&gt;
  &lt;template #header&gt;
    &lt;div&gt;My Header&lt;/div&gt;
  &lt;/template&gt;

  &lt;!-- Scrollable content --&gt;
  &lt;div&gt;...&lt;/div&gt;
&lt;/PPHideAppBar&gt;</code></pre>
        </div>
      
        <div class="variant-group">
          <h3>Customizing CSS</h3>
          <p class="custom-guide">You can override the component's appearance globally via CSS variables or by targeting its specific classes.</p>
          <pre class="code-block" v-pre><code>/* Override globally */
:root {
  --pp-app-bar-bg: /* value */;
  --pp-app-bar-color: /* value */;
  --pp-app-bar-height: /* value */;
  --pp-app-bar-pb: /* value */;
  --pp-app-bar-pt: /* value */;
  --pp-app-bar-radius: /* value */;
  --pp-app-bar-title-size: /* value */;
}

/* Or target specific instances using custom classes */
.my-custom-component {
  /* Add your custom styles */
}</code></pre>
        </div>
</div>
<!-- FULL_SOURCE_CODE_START -->
    <div class="variant-group" style="margin-top: 40px;">
      <h3>Full Page Source Code</h3>
      <p class="custom-guide">Complete source code for this section.</p>
      <pre class="code-block" style="max-height: 500px; overflow-y: auto;" v-pre><code>&lt;template&gt;
&lt;div class="guide-section"&gt;
        &lt;h2&gt;Hide on Scroll App Bar&lt;/h2&gt;
        &lt;p class="guide-desc"&gt;A header that seamlessly hides when scrolling down, and reveals when scrolling up.&lt;/p&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Interactive Demo&lt;/h3&gt;
          &lt;div class="component-demo" style="height: 400px; padding: 0;"&gt;
            &lt;PPHideAppBar :headerHeight="56"&gt;
              &lt;template #header&gt;
                &lt;div style="height: 100%; display: flex; align-items: center; padding: 0 16px; background: var(--pp-primary-light, #3880ff); color: white;"&gt;
                  &lt;h2 style="margin: 0; font-size: 18px;"&gt;My Hidden Header&lt;/h2&gt;
                &lt;/div&gt;
              &lt;/template&gt;
              
              &lt;div style="padding: 16px; display: flex; flex-direction: column; gap: 16px;"&gt;
                &lt;div v-for="i in 20" :key="i" style="padding: 16px; background: #fff; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.05);"&gt;
                  Scroll me up and down! Item {{ i }}
                &lt;/div&gt;
              &lt;/div&gt;
            &lt;/PPHideAppBar&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPHideAppBar :headerHeight="56"&amp;gt;
  &amp;lt;template #header&amp;gt;
    &amp;lt;div&amp;gt;My Header&amp;lt;/div&amp;gt;
  &amp;lt;/template&amp;gt;

  &amp;lt;!-- Scrollable content --&amp;gt;
  &amp;lt;div&amp;gt;...&amp;lt;/div&amp;gt;
&amp;lt;/PPHideAppBar&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;
      
        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Customizing CSS&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;You can override the component's appearance globally via CSS variables or by targeting its specific classes.&lt;/p&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;/* Override globally */
:root {
  --pp-app-bar-bg: /* value */;
  --pp-app-bar-color: /* value */;
  --pp-app-bar-height: /* value */;
  --pp-app-bar-pb: /* value */;
  --pp-app-bar-pt: /* value */;
  --pp-app-bar-radius: /* value */;
  --pp-app-bar-title-size: /* value */;
}

/* Or target specific instances using custom classes */
.my-custom-component {
  /* Add your custom styles */
}&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;
&lt;/div&gt;
&lt;/template&gt;

&lt;script setup lang="ts"&gt;
import { ref, computed } from 'vue';

import { PPHideAppBar } from '@phanna/ui-framework';
&lt;/script&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

import { PPHideAppBar } from '@phanna/ui-framework';
</script>
