<template>
  <div class="guide-section">
    <h2>Phone Input</h2>
    <p>A specialized input component for telephone numbers with country code support.</p>

    <h3>Basic Usage</h3>
    <div class="demo-box">
      <PPPhoneInput v-model="phone" placeholder="Enter phone number" />
      <div style="margin-top: 16px; font-family: monospace;">Value: {{ phone }}</div>
    </div>
    <pre class="code-block" v-pre><code>&lt;PPPhoneInput v-model="phone" placeholder="Enter phone number" /&gt;</code></pre>

    <h3 style="margin-top: 24px;">Formatted Input</h3>
    <p class="guide-desc">Use the <code>format</code> prop to automatically format the number as the user types (e.g. <code>### ### ###</code> or <code>### ### ####</code>).</p>
    <div class="demo-box">
      <PPPhoneInput v-model="formattedPhone" format="### ### ###" placeholder="e.g. 012 345 678" />
      <div style="margin-top: 16px; font-family: monospace;">Value: {{ formattedPhone }}</div>
    </div>
    <pre class="code-block" v-pre><code>&lt;PPPhoneInput v-model="phone" format="### ### ###" /&gt;</code></pre>

    <h3 style="margin-top: 24px;">Variants</h3>
    <div class="demo-box" style="display: flex; flex-direction: column; gap: 16px;">
      <PPPhoneInput v-model="phone" variant="outline" placeholder="Outline (Default)" />
      <PPPhoneInput v-model="phone" variant="filled" placeholder="Filled" />
      <PPPhoneInput v-model="phone" variant="underlined" placeholder="Underlined" />
    </div>
    
    <h3 style="margin-top: 24px;">Sizes & Shapes</h3>
    <div class="demo-box" style="display: flex; flex-direction: column; gap: 16px;">
      <PPPhoneInput v-model="phone" size="sm" placeholder="Small (sm)" />
      <PPPhoneInput v-model="phone" size="md" placeholder="Medium (md) - Default" />
      <PPPhoneInput v-model="phone" size="lg" placeholder="Large (lg)" />
      <div style="margin-top: 8px;"></div>
      <PPPhoneInput v-model="phone" rounded placeholder="Rounded Pill Style" />
      <PPPhoneInput v-model="phone" variant="filled" rounded placeholder="Rounded Filled" />
    </div>
    <pre class="code-block" v-pre><code>&lt;PPPhoneInput variant="outline|filled|underlined" size="sm|md|lg" rounded /&gt;</code></pre>
  
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
    &lt;h2&gt;Phone Input&lt;/h2&gt;
    &lt;p&gt;A specialized input component for telephone numbers with country code support.&lt;/p&gt;

    &lt;h3&gt;Basic Usage&lt;/h3&gt;
    &lt;div class="demo-box"&gt;
      &lt;PPPhoneInput v-model="phone" placeholder="Enter phone number" /&gt;
      &lt;div style="margin-top: 16px; font-family: monospace;"&gt;Value: {{ phone }}&lt;/div&gt;
    &lt;/div&gt;
    &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPPhoneInput v-model="phone" placeholder="Enter phone number" /&amp;gt;&lt;/code&gt;&lt;/pre&gt;

    &lt;h3 style="margin-top: 24px;"&gt;Formatted Input&lt;/h3&gt;
    &lt;p class="guide-desc"&gt;Use the &lt;code&gt;format&lt;/code&gt; prop to automatically format the number as the user types (e.g. &lt;code&gt;### ### ###&lt;/code&gt; or &lt;code&gt;### ### ####&lt;/code&gt;).&lt;/p&gt;
    &lt;div class="demo-box"&gt;
      &lt;PPPhoneInput v-model="formattedPhone" format="### ### ###" placeholder="e.g. 012 345 678" /&gt;
      &lt;div style="margin-top: 16px; font-family: monospace;"&gt;Value: {{ formattedPhone }}&lt;/div&gt;
    &lt;/div&gt;
    &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPPhoneInput v-model="phone" format="### ### ###" /&amp;gt;&lt;/code&gt;&lt;/pre&gt;

    &lt;h3 style="margin-top: 24px;"&gt;Variants&lt;/h3&gt;
    &lt;div class="demo-box" style="display: flex; flex-direction: column; gap: 16px;"&gt;
      &lt;PPPhoneInput v-model="phone" variant="outline" placeholder="Outline (Default)" /&gt;
      &lt;PPPhoneInput v-model="phone" variant="filled" placeholder="Filled" /&gt;
      &lt;PPPhoneInput v-model="phone" variant="underlined" placeholder="Underlined" /&gt;
    &lt;/div&gt;
    
    &lt;h3 style="margin-top: 24px;"&gt;Sizes &amp; Shapes&lt;/h3&gt;
    &lt;div class="demo-box" style="display: flex; flex-direction: column; gap: 16px;"&gt;
      &lt;PPPhoneInput v-model="phone" size="sm" placeholder="Small (sm)" /&gt;
      &lt;PPPhoneInput v-model="phone" size="md" placeholder="Medium (md) - Default" /&gt;
      &lt;PPPhoneInput v-model="phone" size="lg" placeholder="Large (lg)" /&gt;
      &lt;div style="margin-top: 8px;"&gt;&lt;/div&gt;
      &lt;PPPhoneInput v-model="phone" rounded placeholder="Rounded Pill Style" /&gt;
      &lt;PPPhoneInput v-model="phone" variant="filled" rounded placeholder="Rounded Filled" /&gt;
    &lt;/div&gt;
    &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPPhoneInput variant="outline|filled|underlined" size="sm|md|lg" rounded /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
  
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
import { ref } from 'vue';
import { PPPhoneInput } from '@phanna/ui-framework';

const phone = ref('');
const formattedPhone = ref('');
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
import { ref } from 'vue';
import { PPPhoneInput } from '@phanna/ui-framework';

const phone = ref('');
const formattedPhone = ref('');
</script>

<style scoped>
.guide-section { display: flex; flex-direction: column; gap: 24px; }
.demo-box { border: 1px solid #e5e7eb; border-radius: 8px; padding: 24px; background: #f9fafb; }
</style>
