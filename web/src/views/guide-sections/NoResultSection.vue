<template>
  <div class="guide-section">
    <h2>No Result</h2>
    <p>An empty state component to display when a search or filter yields no results.</p>

    <h3>Basic Usage</h3>
    <div class="demo-box">
      <div style="margin-bottom: 24px;">
        <PPNoResult 
          title="No matches found" 
          description="Try changing your search or filter."
        />
      </div>
      <pre class="code-block" style="margin: 0;" v-pre><code>&lt;PPNoResult 
  title="No matches found" 
  description="Try changing your search or filter."
/&gt;</code></pre>
    </div>

    <h3 style="margin-top: 32px;">Custom Icon</h3>
    <div class="demo-box">
      <div style="margin-bottom: 24px;">
        <PPNoResult 
          title="No connectivity" 
          subtitle="Please check your internet connection."
          :icon="wifiOutline"
        />
      </div>
      <pre class="code-block" style="margin: 0;" v-pre><code>&lt;PPNoResult 
  title="No connectivity" 
  subtitle="Please check your internet connection."
  :icon="wifiOutline"
/&gt;</code></pre>
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
    &lt;h2&gt;No Result&lt;/h2&gt;
    &lt;p&gt;An empty state component to display when a search or filter yields no results.&lt;/p&gt;

    &lt;h3&gt;Basic Usage&lt;/h3&gt;
    &lt;div class="demo-box"&gt;
      &lt;div style="margin-bottom: 24px;"&gt;
        &lt;PPNoResult 
          title="No matches found" 
          description="Try changing your search or filter."
        /&gt;
      &lt;/div&gt;
      &lt;pre class="code-block" style="margin: 0;"&gt;&lt;code&gt;&amp;lt;PPNoResult 
  title="No matches found" 
  description="Try changing your search or filter."
/&amp;gt;&lt;/code&gt;&lt;/pre&gt;
    &lt;/div&gt;

    &lt;h3 style="margin-top: 32px;"&gt;Custom Icon&lt;/h3&gt;
    &lt;div class="demo-box"&gt;
      &lt;div style="margin-bottom: 24px;"&gt;
        &lt;PPNoResult 
          title="No connectivity" 
          subtitle="Please check your internet connection."
          :icon="wifiOutline"
        /&gt;
      &lt;/div&gt;
      &lt;pre class="code-block" style="margin: 0;"&gt;&lt;code&gt;&amp;lt;PPNoResult 
  title="No connectivity" 
  subtitle="Please check your internet connection."
  :icon="wifiOutline"
/&amp;gt;&lt;/code&gt;&lt;/pre&gt;
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
import { PPNoResult } from '@phanna/ui-framework';
import { wifiOutline } from 'ionicons/icons';
&lt;/script&gt;

&lt;style scoped&gt;
.guide-section { display: flex; flex-direction: column; gap: 24px; }
.demo-box { border: 1px solid #e5e7eb; border-radius: 8px; padding: 24px; background: #f9fafb; }
&lt;/style&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
</template>

<script setup lang="ts">
import { PPNoResult } from '@phanna/ui-framework';
import { wifiOutline } from 'ionicons/icons';
</script>

<style scoped>
.guide-section { display: flex; flex-direction: column; gap: 24px; }
.demo-box { border: 1px solid #e5e7eb; border-radius: 8px; padding: 24px; background: #f9fafb; }
</style>
