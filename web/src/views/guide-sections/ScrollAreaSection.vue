<template>
  <div class="guide-section">
    <h2>Scroll Area</h2>
    <p>A container that handles horizontal, vertical, or dual-axis scrolling with customized or hidden scrollbars.</p>

    <h3>Horizontal Scrolling (Hide Scrollbar)</h3>
    <div class="demo-box">
      <PPScrollArea direction="horizontal" hideScrollbar style="height: 120px;">
        <div style="display: flex; gap: 16px; padding: 16px;">
          <div v-for="i in 10" :key="i" style="width: 80px; height: 80px; background: white; border-radius: 12px; display: flex; flex-direction: column; align-items: center; justify-content: center; box-shadow: 0 2px 8px rgba(0,0,0,0.05); flex-shrink: 0;">
            <div style="font-size: 14px; color: #666;">{{ i }} PM</div>
            <div style="font-size: 24px; margin: 4px 0;">🌤️</div>
            <div style="font-size: 16px; font-weight: 600;">28°C</div>
          </div>
        </div>
      </PPScrollArea>
    </div>
    <div class="usage-block" style="margin-top: 16px;">
      <pre v-pre style="background: #1f2937; color: #f8f8f2; padding: 16px; border-radius: 8px; overflow-x: auto; font-size: 14px;"><code>&lt;PPScrollArea direction="horizontal" hideScrollbar&gt;
  &lt;div style="display: flex; gap: 16px;"&gt;
    &lt;!-- Your horizontal content items --&gt;
  &lt;/div&gt;
&lt;/PPScrollArea&gt;</code></pre>
    </div>

    <h3>Vertical Scrolling (Mac & Thin variants)</h3>
    <div style="display: flex; gap: 24px; flex-wrap: wrap;">
      
      <!-- Default Mac Style -->
      <div class="demo-box" style="flex: 1; height: 200px; min-width: 250px;">
        <h4 style="margin-top: 0; font-size: 14px;">scrollbar="mac"</h4>
        <PPScrollArea direction="vertical" scrollbar="mac" style="background: white; border-radius: 8px; border: 1px solid #e5e7eb;">
          <div style="padding: 16px;">
            <div v-for="i in 15" :key="i" style="padding: 12px; border-bottom: 1px solid #f3f4f6;">
              List Item {{ i }}
            </div>
          </div>
        </PPScrollArea>
      </div>

      <!-- Thin Style -->
      <div class="demo-box" style="flex: 1; height: 200px; min-width: 250px;">
        <h4 style="margin-top: 0; font-size: 14px;">scrollbar="thin"</h4>
        <PPScrollArea direction="vertical" scrollbar="thin" style="background: white; border-radius: 8px; border: 1px solid #e5e7eb;">
          <div style="padding: 16px;">
            <div v-for="i in 15" :key="i" style="padding: 12px; border-bottom: 1px solid #f3f4f6;">
              List Item {{ i }}
            </div>
          </div>
        </PPScrollArea>
      </div>
      
    </div>
    <div class="usage-block" style="margin-top: 16px;">
      <pre v-pre style="background: #1f2937; color: #f8f8f2; padding: 16px; border-radius: 8px; overflow-x: auto; font-size: 14px;"><code>&lt;PPScrollArea direction="vertical"&gt;
  &lt;!-- Your long vertical content --&gt;
  &lt;div v-for="i in 15" :key="i"&gt;List Item {{ i }}&lt;/div&gt;
&lt;/PPScrollArea&gt;</code></pre>
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
    &lt;h2&gt;Scroll Area&lt;/h2&gt;
    &lt;p&gt;A container that handles horizontal, vertical, or dual-axis scrolling with customized or hidden scrollbars.&lt;/p&gt;

    &lt;h3&gt;Horizontal Scrolling (Hide Scrollbar)&lt;/h3&gt;
    &lt;div class="demo-box"&gt;
      &lt;PPScrollArea direction="horizontal" hideScrollbar style="height: 120px;"&gt;
        &lt;div style="display: flex; gap: 16px; padding: 16px;"&gt;
          &lt;div v-for="i in 10" :key="i" style="width: 80px; height: 80px; background: white; border-radius: 12px; display: flex; flex-direction: column; align-items: center; justify-content: center; box-shadow: 0 2px 8px rgba(0,0,0,0.05); flex-shrink: 0;"&gt;
            &lt;div style="font-size: 14px; color: #666;"&gt;{{ i }} PM&lt;/div&gt;
            &lt;div style="font-size: 24px; margin: 4px 0;"&gt;🌤️&lt;/div&gt;
            &lt;div style="font-size: 16px; font-weight: 600;"&gt;28°C&lt;/div&gt;
          &lt;/div&gt;
        &lt;/div&gt;
      &lt;/PPScrollArea&gt;
    &lt;/div&gt;
    &lt;div class="usage-block" style="margin-top: 16px;"&gt;
      &lt;pre v-pre style="background: #1f2937; color: #f8f8f2; padding: 16px; border-radius: 8px; overflow-x: auto; font-size: 14px;"&gt;&lt;code&gt;&amp;lt;PPScrollArea direction="horizontal" hideScrollbar&amp;gt;
  &amp;lt;div style="display: flex; gap: 16px;"&amp;gt;
    &amp;lt;!-- Your horizontal content items --&amp;gt;
  &amp;lt;/div&amp;gt;
&amp;lt;/PPScrollArea&amp;gt;&lt;/code&gt;&lt;/pre&gt;
    &lt;/div&gt;

    &lt;h3&gt;Vertical Scrolling (Mac &amp; Thin variants)&lt;/h3&gt;
    &lt;div style="display: flex; gap: 24px; flex-wrap: wrap;"&gt;
      
      &lt;!-- Default Mac Style --&gt;
      &lt;div class="demo-box" style="flex: 1; height: 200px; min-width: 250px;"&gt;
        &lt;h4 style="margin-top: 0; font-size: 14px;"&gt;scrollbar="mac"&lt;/h4&gt;
        &lt;PPScrollArea direction="vertical" scrollbar="mac" style="background: white; border-radius: 8px; border: 1px solid #e5e7eb;"&gt;
          &lt;div style="padding: 16px;"&gt;
            &lt;div v-for="i in 15" :key="i" style="padding: 12px; border-bottom: 1px solid #f3f4f6;"&gt;
              List Item {{ i }}
            &lt;/div&gt;
          &lt;/div&gt;
        &lt;/PPScrollArea&gt;
      &lt;/div&gt;

      &lt;!-- Thin Style --&gt;
      &lt;div class="demo-box" style="flex: 1; height: 200px; min-width: 250px;"&gt;
        &lt;h4 style="margin-top: 0; font-size: 14px;"&gt;scrollbar="thin"&lt;/h4&gt;
        &lt;PPScrollArea direction="vertical" scrollbar="thin" style="background: white; border-radius: 8px; border: 1px solid #e5e7eb;"&gt;
          &lt;div style="padding: 16px;"&gt;
            &lt;div v-for="i in 15" :key="i" style="padding: 12px; border-bottom: 1px solid #f3f4f6;"&gt;
              List Item {{ i }}
            &lt;/div&gt;
          &lt;/div&gt;
        &lt;/PPScrollArea&gt;
      &lt;/div&gt;
      
    &lt;/div&gt;
    &lt;div class="usage-block" style="margin-top: 16px;"&gt;
      &lt;pre v-pre style="background: #1f2937; color: #f8f8f2; padding: 16px; border-radius: 8px; overflow-x: auto; font-size: 14px;"&gt;&lt;code&gt;&amp;lt;PPScrollArea direction="vertical"&amp;gt;
  &amp;lt;!-- Your long vertical content --&amp;gt;
  &amp;lt;div v-for="i in 15" :key="i"&amp;gt;List Item {{ i }}&amp;lt;/div&amp;gt;
&amp;lt;/PPScrollArea&amp;gt;&lt;/code&gt;&lt;/pre&gt;
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
import { PPScrollArea } from '@phanna/ui-framework';
&lt;/script&gt;

&lt;style scoped&gt;
.guide-section {
  display: flex;
  flex-direction: column;
  gap: 24px;
}
.demo-box {
  border: 1px solid #e5e7eb;
  border-radius: 8px;
  padding: 24px;
  background: #f9fafb;
}
&lt;/style&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
</template>

<script setup lang="ts">
import { PPScrollArea } from '@phanna/ui-framework';
</script>

<style scoped>
.guide-section {
  display: flex;
  flex-direction: column;
  gap: 24px;
}
.demo-box {
  border: 1px solid #e5e7eb;
  border-radius: 8px;
  padding: 24px;
  background: #f9fafb;
}
</style>
