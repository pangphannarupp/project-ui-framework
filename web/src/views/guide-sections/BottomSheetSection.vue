<template>
  <div class="component-section">
    <h2>Bottom Sheet</h2>
    <p>A modal that slides up from the bottom of the screen, typically used for mobile layouts to present actions or information.</p>

    <div class="demo-box" style="margin-top: 32px; display: flex; gap: 16px; align-items: center; justify-content: center; height: 160px; background: #f8fafc; border-radius: 8px;">
      <PPButton @click="showDefault = true">Default Bottom Sheet</PPButton>
      <PPButton variant="secondary" @click="showBlur = true">Blur Backdrop</PPButton>
    </div>

    <!-- Default Bottom Sheet -->
    <PPBottomSheet v-model="showDefault" title="Settings">
      <div style="padding: 16px;">
        <p style="margin-bottom: 24px; color: #475569;">Configure your preferences below.</p>
        <div style="display: flex; flex-direction: column; gap: 12px;">
          <PPButton variant="outline" block @click="showDefault = false">Option 1</PPButton>
          <PPButton variant="outline" block @click="showDefault = false">Option 2</PPButton>
        </div>
      </div>
    </PPBottomSheet>

    <!-- Blur Backdrop Bottom Sheet -->
    <PPBottomSheet v-model="showBlur" backdropType="blur">
      <div style="padding: 24px; text-align: center;">
        <h3 style="margin-top: 0; color: #1e293b;">Blurred Background</h3>
        <p style="color: #64748b; margin-bottom: 32px;">This sheet uses a blurred backdrop for a frosted glass effect.</p>
        <PPButton block @click="showBlur = false">Close</PPButton>
      </div>
    </PPBottomSheet>

    <!-- Usage Section -->
    <div style="margin-top: 40px;">
      <h3>Usage Example</h3>
      <pre class="code-block" style="background: #1e293b; color: #e2e8f0; padding: 16px; border-radius: 8px; overflow-x: auto;" v-pre><code>&lt;template&gt;
  &lt;PPButton @click="isOpen = true"&gt;Open Sheet&lt;/PPButton&gt;

  &lt;PPBottomSheet v-model="isOpen" backdropType="blur"&gt;
    &lt;div style="padding: 24px;"&gt;
      &lt;h3&gt;Sheet Content&lt;/h3&gt;
      &lt;p&gt;This is a sliding bottom sheet.&lt;/p&gt;
    &lt;/div&gt;
  &lt;/PPBottomSheet&gt;
&lt;/template&gt;

&lt;script setup&gt;
import { ref } from 'vue';
import { PPBottomSheet, PPButton } from '@phanna/ui-framework';

const isOpen = ref(false);
&lt;/script&gt;</code></pre>
    </div>
  
        <div class="variant-group">
          <h3>Customizing CSS</h3>
          <p class="custom-guide">You can override the component's appearance globally via CSS variables or by targeting its specific classes.</p>
          <pre class="code-block" v-pre><code>/* Override globally */
:root {
  --pp-bottom-sheet-backdrop: /* value */;
  --pp-bottom-sheet-backdrop-black: /* value */;
  --pp-bottom-sheet-backdrop-blur-bg: /* value */;
  --pp-bottom-sheet-bg: /* value */;
  --pp-bottom-sheet-handle-color: /* value */;
  --pp-bottom-sheet-radius: /* value */;
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
  &lt;div class="component-section"&gt;
    &lt;h2&gt;Bottom Sheet&lt;/h2&gt;
    &lt;p&gt;A modal that slides up from the bottom of the screen, typically used for mobile layouts to present actions or information.&lt;/p&gt;

    &lt;div class="demo-box" style="margin-top: 32px; display: flex; gap: 16px; align-items: center; justify-content: center; height: 160px; background: #f8fafc; border-radius: 8px;"&gt;
      &lt;PPButton @click="showDefault = true"&gt;Default Bottom Sheet&lt;/PPButton&gt;
      &lt;PPButton variant="secondary" @click="showBlur = true"&gt;Blur Backdrop&lt;/PPButton&gt;
    &lt;/div&gt;

    &lt;!-- Default Bottom Sheet --&gt;
    &lt;PPBottomSheet v-model="showDefault" title="Settings"&gt;
      &lt;div style="padding: 16px;"&gt;
        &lt;p style="margin-bottom: 24px; color: #475569;"&gt;Configure your preferences below.&lt;/p&gt;
        &lt;div style="display: flex; flex-direction: column; gap: 12px;"&gt;
          &lt;PPButton variant="outline" block @click="showDefault = false"&gt;Option 1&lt;/PPButton&gt;
          &lt;PPButton variant="outline" block @click="showDefault = false"&gt;Option 2&lt;/PPButton&gt;
        &lt;/div&gt;
      &lt;/div&gt;
    &lt;/PPBottomSheet&gt;

    &lt;!-- Blur Backdrop Bottom Sheet --&gt;
    &lt;PPBottomSheet v-model="showBlur" backdropType="blur"&gt;
      &lt;div style="padding: 24px; text-align: center;"&gt;
        &lt;h3 style="margin-top: 0; color: #1e293b;"&gt;Blurred Background&lt;/h3&gt;
        &lt;p style="color: #64748b; margin-bottom: 32px;"&gt;This sheet uses a blurred backdrop for a frosted glass effect.&lt;/p&gt;
        &lt;PPButton block @click="showBlur = false"&gt;Close&lt;/PPButton&gt;
      &lt;/div&gt;
    &lt;/PPBottomSheet&gt;

    &lt;!-- Usage Section --&gt;
    &lt;div style="margin-top: 40px;"&gt;
      &lt;h3&gt;Usage Example&lt;/h3&gt;
      &lt;pre class="code-block" style="background: #1e293b; color: #e2e8f0; padding: 16px; border-radius: 8px; overflow-x: auto;"&gt;&lt;code&gt;&amp;lt;template&amp;gt;
  &amp;lt;PPButton @click="isOpen = true"&amp;gt;Open Sheet&amp;lt;/PPButton&amp;gt;

  &amp;lt;PPBottomSheet v-model="isOpen" backdropType="blur"&amp;gt;
    &amp;lt;div style="padding: 24px;"&amp;gt;
      &amp;lt;h3&amp;gt;Sheet Content&amp;lt;/h3&amp;gt;
      &amp;lt;p&amp;gt;This is a sliding bottom sheet.&amp;lt;/p&amp;gt;
    &amp;lt;/div&amp;gt;
  &amp;lt;/PPBottomSheet&amp;gt;
&amp;lt;/template&amp;gt;

&amp;lt;script setup&amp;gt;
import { ref } from 'vue';
import { PPBottomSheet, PPButton } from '@phanna/ui-framework';

const isOpen = ref(false);
&amp;lt;/script&amp;gt;&lt;/code&gt;&lt;/pre&gt;
    &lt;/div&gt;
  
        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Customizing CSS&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;You can override the component's appearance globally via CSS variables or by targeting its specific classes.&lt;/p&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;/* Override globally */
:root {
  --pp-bottom-sheet-backdrop: /* value */;
  --pp-bottom-sheet-backdrop-black: /* value */;
  --pp-bottom-sheet-backdrop-blur-bg: /* value */;
  --pp-bottom-sheet-bg: /* value */;
  --pp-bottom-sheet-handle-color: /* value */;
  --pp-bottom-sheet-radius: /* value */;
}

/* Or target specific instances using custom classes */
.my-custom-component {
  /* Add your custom styles */
}&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;
&lt;/div&gt;
&lt;/template&gt;

&lt;script setup lang="ts"&gt;
import { ref } from 'vue';
import { PPBottomSheet, PPButton } from '@phanna/ui-framework';

const showDefault = ref(false);
const showBlur = ref(false);
&lt;/script&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { PPBottomSheet, PPButton } from '@phanna/ui-framework';

const showDefault = ref(false);
const showBlur = ref(false);
</script>
