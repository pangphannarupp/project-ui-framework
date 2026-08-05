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
      
        <div class="variant-group">
          <h3>Customizing CSS</h3>
          <p class="custom-guide">You can override the component's appearance globally via CSS variables or by targeting its specific classes.</p>
          <pre class="code-block" v-pre><code>/* Override globally */
:root {
  /* This component does not use CSS variables directly. */
  /* Use custom classes to override styles. */
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
        &lt;h2&gt;Image Transition (List to Detail)&lt;/h2&gt;
        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Seamless Fullscreen Expansion&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;Tap the thumbnail to see it expand perfectly into a full-screen detail view!&lt;/p&gt;
          &lt;div class="component-demo" style="display: flex; gap: 16px; align-items: center;"&gt;
            &lt;div style="width: 60px; height: 60px; border-radius: 50%; overflow: hidden;"&gt;
              &lt;PPImageTransition&gt;
                &lt;template #image&gt;
                  &lt;img 
                    src="https://images.unsplash.com/photo-1579546929518-9e396f3cc809?q=80&amp;w=1000&amp;auto=format&amp;fit=crop" 
                    alt="Thumbnail"
                  /&gt;
                &lt;/template&gt;
                &lt;template #detail&gt;
                  &lt;div style="padding: 24px; color: #333;"&gt;
                    &lt;h2 style="margin-top: 0; font-size: 28px;"&gt;Jane Doe&lt;/h2&gt;
                    &lt;p style="font-size: 16px; line-height: 1.5; color: #666;"&gt;
                      This image expanded beautifully without needing a route transition! 
                      Click the back button in the top left corner to collapse it right back into the list.
                    &lt;/p&gt;
                  &lt;/div&gt;
                &lt;/template&gt;
              &lt;/PPImageTransition&gt;
            &lt;/div&gt;
            &lt;div&gt;
              &lt;strong style="display: block; font-size: 16px;"&gt;Jane Doe&lt;/strong&gt;
              &lt;span style="color: #666; font-size: 14px;"&gt;Tap image to view profile&lt;/span&gt;
            &lt;/div&gt;
          &lt;/div&gt;
        &lt;/div&gt;
      
        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Customizing CSS&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;You can override the component's appearance globally via CSS variables or by targeting its specific classes.&lt;/p&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;/* Override globally */
:root {
  /* This component does not use CSS variables directly. */
  /* Use custom classes to override styles. */
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

import { PPImageTransition } from '@phanna/ui-framework';
&lt;/script&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

import { PPImageTransition } from '@phanna/ui-framework';
</script>
