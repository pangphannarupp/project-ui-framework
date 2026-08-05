<template>
<div class="guide-section">
        <h2>2. PPInfoCard Styles</h2>

        <div class="variant-group">
          <h3>Types (Soft Variant Default)</h3>
          <div class="component-demo" style="display: flex; flex-direction: column; gap: 16px;">
            <PPInfoCard type="info">This is an informational message to guide the user.</PPInfoCard>
            <PPInfoCard type="success">Your changes have been saved successfully!</PPInfoCard>
            <PPInfoCard type="warning">Please review your inputs before proceeding.</PPInfoCard>
            <PPInfoCard type="error">There was a problem processing your request.</PPInfoCard>
            <PPInfoCard type="neutral">This is a neutral message for general context.</PPInfoCard>
          </div>
        </div>

        <div class="variant-group">
          <h3>Variants</h3>
          <div class="component-demo" style="display: flex; flex-direction: column; gap: 16px;">
            <PPInfoCard type="info" variant="soft">Soft Variant (Default) - Subtle background</PPInfoCard>
            <PPInfoCard type="info" variant="solid">Solid Variant - High emphasis</PPInfoCard>
            <PPInfoCard type="info" variant="outline">Outline Variant - Border only</PPInfoCard>
            <PPInfoCard type="info" variant="glass">Glass Variant - Frosted glass effect</PPInfoCard>
          </div>
        </div>

        <div class="variant-group">
          <h3>Custom Styles</h3>
          <div class="component-demo">
            <PPInfoCard 
              type="info" 
              backgroundColor="#e8f5e9" 
              textColor="#2e7d32" 
              iconColor="#1b5e20" 
              borderRadius="24px"
            >
              This is a fully customized success info card using explicit style props!
            </PPInfoCard>
          </div>
          <pre class="code-block" v-pre><code>&lt;PPInfoCard 
  type="info" 
  backgroundColor="#e8f5e9" 
  textColor="#2e7d32" 
  iconColor="#1b5e20" 
  borderRadius="24px"
&gt;
  This is a fully customized success info card!
&lt;/PPInfoCard&gt;</code></pre>
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
        &lt;h2&gt;2. PPInfoCard Styles&lt;/h2&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Types (Soft Variant Default)&lt;/h3&gt;
          &lt;div class="component-demo" style="display: flex; flex-direction: column; gap: 16px;"&gt;
            &lt;PPInfoCard type="info"&gt;This is an informational message to guide the user.&lt;/PPInfoCard&gt;
            &lt;PPInfoCard type="success"&gt;Your changes have been saved successfully!&lt;/PPInfoCard&gt;
            &lt;PPInfoCard type="warning"&gt;Please review your inputs before proceeding.&lt;/PPInfoCard&gt;
            &lt;PPInfoCard type="error"&gt;There was a problem processing your request.&lt;/PPInfoCard&gt;
            &lt;PPInfoCard type="neutral"&gt;This is a neutral message for general context.&lt;/PPInfoCard&gt;
          &lt;/div&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Variants&lt;/h3&gt;
          &lt;div class="component-demo" style="display: flex; flex-direction: column; gap: 16px;"&gt;
            &lt;PPInfoCard type="info" variant="soft"&gt;Soft Variant (Default) - Subtle background&lt;/PPInfoCard&gt;
            &lt;PPInfoCard type="info" variant="solid"&gt;Solid Variant - High emphasis&lt;/PPInfoCard&gt;
            &lt;PPInfoCard type="info" variant="outline"&gt;Outline Variant - Border only&lt;/PPInfoCard&gt;
            &lt;PPInfoCard type="info" variant="glass"&gt;Glass Variant - Frosted glass effect&lt;/PPInfoCard&gt;
          &lt;/div&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Custom Styles&lt;/h3&gt;
          &lt;div class="component-demo"&gt;
            &lt;PPInfoCard 
              type="info" 
              backgroundColor="#e8f5e9" 
              textColor="#2e7d32" 
              iconColor="#1b5e20" 
              borderRadius="24px"
            &gt;
              This is a fully customized success info card using explicit style props!
            &lt;/PPInfoCard&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPInfoCard 
  type="info" 
  backgroundColor="#e8f5e9" 
  textColor="#2e7d32" 
  iconColor="#1b5e20" 
  borderRadius="24px"
&amp;gt;
  This is a fully customized success info card!
&amp;lt;/PPInfoCard&amp;gt;&lt;/code&gt;&lt;/pre&gt;
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

import { PPInfoCard } from '@phanna/ui-framework';
&lt;/script&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

import { PPInfoCard } from '@phanna/ui-framework';
</script>
