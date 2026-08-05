<template>
<div class="guide-section">
        <h2>5. PPIconButton Variants</h2>
        
        <div class="variant-group" style="background: #f4f5f8; padding: 16px; border-radius: 8px;">
          <h3>Danger</h3>
          <div class="component-demo">
            <PPIconButton color="danger" :icon="trashOutline" />
          </div>
          <pre class="code-block" v-pre><code>&lt;PPIconButton color="danger" :icon="trashOutline" /&gt;</code></pre>
        </div>

        <div class="variant-group" style="background: var(--pp-primary, #003399); padding: 16px; border-radius: 8px; color: white;">
          <h3 style="color: white;">White (on dark backgrounds)</h3>
          <div class="component-demo">
            <PPIconButton color="white" badge :icon="notificationsOutline" />
          </div>
          <pre class="code-block" v-pre><code>&lt;PPIconButton color="white" badge :icon="notificationsOutline" /&gt;</code></pre>
        </div>

        <div class="variant-group" style="background: #f4f5f8; padding: 16px; border-radius: 8px;">
          <h3>Primary</h3>
          <div class="component-demo">
            <PPIconButton color="primary" :icon="squareOutline" />
          </div>
          <pre class="code-block" v-pre><code>&lt;PPIconButton color="primary" :icon="squareOutline" /&gt;</code></pre>
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
        &lt;h2&gt;5. PPIconButton Variants&lt;/h2&gt;
        
        &lt;div class="variant-group" style="background: #f4f5f8; padding: 16px; border-radius: 8px;"&gt;
          &lt;h3&gt;Danger&lt;/h3&gt;
          &lt;div class="component-demo"&gt;
            &lt;PPIconButton color="danger" :icon="trashOutline" /&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPIconButton color="danger" :icon="trashOutline" /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group" style="background: var(--pp-primary, #003399); padding: 16px; border-radius: 8px; color: white;"&gt;
          &lt;h3 style="color: white;"&gt;White (on dark backgrounds)&lt;/h3&gt;
          &lt;div class="component-demo"&gt;
            &lt;PPIconButton color="white" badge :icon="notificationsOutline" /&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPIconButton color="white" badge :icon="notificationsOutline" /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group" style="background: #f4f5f8; padding: 16px; border-radius: 8px;"&gt;
          &lt;h3&gt;Primary&lt;/h3&gt;
          &lt;div class="component-demo"&gt;
            &lt;PPIconButton color="primary" :icon="squareOutline" /&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPIconButton color="primary" :icon="squareOutline" /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
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
import { PPIconButton } from '@phanna/ui-framework';
import { trashOutline, notificationsOutline, squareOutline } from 'ionicons/icons';
&lt;/script&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';
import { PPIconButton } from '@phanna/ui-framework';
import { trashOutline, notificationsOutline, squareOutline } from 'ionicons/icons';
</script>
