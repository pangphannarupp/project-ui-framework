<template>
<div class="guide-section">
        <h2>1.5 Button Group</h2>

        <div class="variant-group">
          <h3>Connected Group (Default)</h3>
          <div class="component-demo">
            <PPButtonGroup>
              <PPButton variant="outline">Left</PPButton>
              <PPButton variant="outline">Middle</PPButton>
              <PPButton variant="outline">Right</PPButton>
            </PPButtonGroup>
          </div>
          <pre class="code-block" v-pre><code>&lt;PPButtonGroup&gt;
  &lt;PPButton variant="outline"&gt;Left&lt;/PPButton&gt;
  &lt;PPButton variant="outline"&gt;Middle&lt;/PPButton&gt;
  &lt;PPButton variant="outline"&gt;Right&lt;/PPButton&gt;
&lt;/PPButtonGroup&gt;</code></pre>
        </div>
        
        <div class="variant-group">
          <h3>Segmented Group</h3>
          <div class="component-demo">
            <PPButtonGroup variant="segmented">
              <PPButton variant="primary">Active</PPButton>
              <PPButton variant="ghost">Inactive</PPButton>
              <PPButton variant="ghost">Disabled</PPButton>
            </PPButtonGroup>
          </div>
          <pre class="code-block" v-pre><code>&lt;PPButtonGroup variant="segmented"&gt;
  &lt;PPButton variant="primary"&gt;Active&lt;/PPButton&gt;
  &lt;PPButton variant="ghost"&gt;Inactive&lt;/PPButton&gt;
  &lt;PPButton variant="ghost"&gt;Disabled&lt;/PPButton&gt;
&lt;/PPButtonGroup&gt;</code></pre>
        </div>
        
        <div class="variant-group">
          <h3>Separated Group</h3>
          <div class="component-demo">
            <PPButtonGroup variant="separated">
              <PPButton variant="outline">Action 1</PPButton>
              <PPButton variant="outline">Action 2</PPButton>
              <PPButton variant="outline">Action 3</PPButton>
            </PPButtonGroup>
          </div>
          <pre class="code-block" v-pre><code>&lt;PPButtonGroup variant="separated"&gt;
  &lt;PPButton variant="outline"&gt;Action 1&lt;/PPButton&gt;
  &lt;PPButton variant="outline"&gt;Action 2&lt;/PPButton&gt;
  &lt;PPButton variant="outline"&gt;Action 3&lt;/PPButton&gt;
&lt;/PPButtonGroup&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Vertical Group</h3>
          <div class="component-demo">
            <PPButtonGroup vertical>
              <PPButton variant="outline" block>Top</PPButton>
              <PPButton variant="outline" block>Middle</PPButton>
              <PPButton variant="outline" block>Bottom</PPButton>
            </PPButtonGroup>
          </div>
          <pre class="code-block" v-pre><code>&lt;PPButtonGroup vertical&gt;
  ...
&lt;/PPButtonGroup&gt;</code></pre>
        </div>
      
        <div class="variant-group">
          <h3>Customizing CSS</h3>
          <p class="custom-guide">You can override the component's appearance globally via CSS variables or by targeting its specific classes.</p>
          <pre class="code-block" v-pre><code>/* Override globally */
:root {
  --pp-primary-variant: /* value */;
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
        &lt;h2&gt;1.5 Button Group&lt;/h2&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Connected Group (Default)&lt;/h3&gt;
          &lt;div class="component-demo"&gt;
            &lt;PPButtonGroup&gt;
              &lt;PPButton variant="outline"&gt;Left&lt;/PPButton&gt;
              &lt;PPButton variant="outline"&gt;Middle&lt;/PPButton&gt;
              &lt;PPButton variant="outline"&gt;Right&lt;/PPButton&gt;
            &lt;/PPButtonGroup&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPButtonGroup&amp;gt;
  &amp;lt;PPButton variant="outline"&amp;gt;Left&amp;lt;/PPButton&amp;gt;
  &amp;lt;PPButton variant="outline"&amp;gt;Middle&amp;lt;/PPButton&amp;gt;
  &amp;lt;PPButton variant="outline"&amp;gt;Right&amp;lt;/PPButton&amp;gt;
&amp;lt;/PPButtonGroup&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;
        
        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Segmented Group&lt;/h3&gt;
          &lt;div class="component-demo"&gt;
            &lt;PPButtonGroup variant="segmented"&gt;
              &lt;PPButton variant="primary"&gt;Active&lt;/PPButton&gt;
              &lt;PPButton variant="ghost"&gt;Inactive&lt;/PPButton&gt;
              &lt;PPButton variant="ghost"&gt;Disabled&lt;/PPButton&gt;
            &lt;/PPButtonGroup&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPButtonGroup variant="segmented"&amp;gt;
  &amp;lt;PPButton variant="primary"&amp;gt;Active&amp;lt;/PPButton&amp;gt;
  &amp;lt;PPButton variant="ghost"&amp;gt;Inactive&amp;lt;/PPButton&amp;gt;
  &amp;lt;PPButton variant="ghost"&amp;gt;Disabled&amp;lt;/PPButton&amp;gt;
&amp;lt;/PPButtonGroup&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;
        
        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Separated Group&lt;/h3&gt;
          &lt;div class="component-demo"&gt;
            &lt;PPButtonGroup variant="separated"&gt;
              &lt;PPButton variant="outline"&gt;Action 1&lt;/PPButton&gt;
              &lt;PPButton variant="outline"&gt;Action 2&lt;/PPButton&gt;
              &lt;PPButton variant="outline"&gt;Action 3&lt;/PPButton&gt;
            &lt;/PPButtonGroup&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPButtonGroup variant="separated"&amp;gt;
  &amp;lt;PPButton variant="outline"&amp;gt;Action 1&amp;lt;/PPButton&amp;gt;
  &amp;lt;PPButton variant="outline"&amp;gt;Action 2&amp;lt;/PPButton&amp;gt;
  &amp;lt;PPButton variant="outline"&amp;gt;Action 3&amp;lt;/PPButton&amp;gt;
&amp;lt;/PPButtonGroup&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Vertical Group&lt;/h3&gt;
          &lt;div class="component-demo"&gt;
            &lt;PPButtonGroup vertical&gt;
              &lt;PPButton variant="outline" block&gt;Top&lt;/PPButton&gt;
              &lt;PPButton variant="outline" block&gt;Middle&lt;/PPButton&gt;
              &lt;PPButton variant="outline" block&gt;Bottom&lt;/PPButton&gt;
            &lt;/PPButtonGroup&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPButtonGroup vertical&amp;gt;
  ...
&amp;lt;/PPButtonGroup&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;
      
        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Customizing CSS&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;You can override the component's appearance globally via CSS variables or by targeting its specific classes.&lt;/p&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;/* Override globally */
:root {
  --pp-primary-variant: /* value */;
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

import { PPButton, PPButtonGroup } from '@phanna/ui-framework';
&lt;/script&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

import { PPButton, PPButtonGroup } from '@phanna/ui-framework';
</script>
