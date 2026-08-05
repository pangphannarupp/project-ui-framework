<template>
<div class="guide-section">
        <h2>Text Input & Textarea</h2>
        
        <div class="variant-group">
          <h3>PPTextField Styles</h3>
          <div class="component-demo" style="display: flex; flex-direction: column; gap: 16px;">
            <PPTextField v-model="textVal" label="Outlined (Default)" placeholder="Enter text" clearable />
            <PPTextField v-model="textVal" variant="filled" label="Filled" placeholder="Enter text" clearable />
          </div>
          <pre class="code-block" v-pre><code>&lt;PPTextField variant="outlined|filled" label="..." clearable /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Standard Text Input (PPInput)</h3>
          
          <h4 style="margin-top: 16px;">Variants</h4>
          <div class="component-demo" style="display: flex; flex-direction: column; gap: 8px;">
            <PPInput v-model="textVal" label="Outline (Default)" variant="outline" placeholder="Outline variant" />
            <PPInput v-model="textVal" label="Filled" variant="filled" placeholder="Filled variant" />
            <PPInput v-model="textVal" label="Underlined" variant="underlined" placeholder="Underlined variant" />
          </div>
          
          <h4 style="margin-top: 24px;">Sizes & Shapes</h4>
          <div class="component-demo" style="display: flex; flex-direction: column; gap: 8px;">
            <PPInput v-model="textVal" size="sm" placeholder="Small (sm)" />
            <PPInput v-model="textVal" size="md" placeholder="Medium (md) - Default" />
            <PPInput v-model="textVal" size="lg" placeholder="Large (lg)" />
            <div style="margin-top: 16px;"></div>
            <PPInput v-model="textVal" rounded placeholder="Rounded Pill Style" />
          </div>

          <h4 style="margin-top: 24px;">Constraints & Formatting</h4>
          <p class="guide-desc">Restrict input using <code>maxLength</code>, <code>numberOnly</code>, <code>min</code>, <code>max</code>, and <code>format</code>.</p>
          <div class="component-demo" style="display: flex; flex-direction: column; gap: 8px;">
            <PPInput v-model="textVal" :maxLength="10" placeholder="Max length 10" />
            <PPInput v-model="textVal" numberOnly placeholder="Numbers only" />
            <PPInput v-model="textVal" :min="10" :max="100" placeholder="Min 10, Max 100" type="number" />
            <PPInput v-model="textVal" format="####-####-####-####" placeholder="Card format (####-####-####-####)" />
          </div>
          
          <pre class="code-block" v-pre><code>&lt;PPInput variant="outline|filled|underlined" size="sm|md|lg" rounded /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Password Input (with icon)</h3>
          <div class="component-demo">
            <PPInput v-model="textVal" label="Password" type="password" placeholder="Enter pass" clearable>
              <template #iconLeft>
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect><path d="M7 11V7a5 5 0 0 1 10 0v4"></path></svg>
              </template>
            </PPInput>
          </div>
          <pre class="code-block" v-pre><code>&lt;PPInput type="password"&gt;
  &lt;template #iconLeft&gt;...&lt;/template&gt;
&lt;/PPInput&gt;</code></pre>
        </div>
      
        <div class="variant-group">
          <h3>Customizing CSS</h3>
          <p class="custom-guide">You can override the component's appearance globally via CSS variables or by targeting its specific classes.</p>
          <pre class="code-block" v-pre><code>/* Override globally */
:root {
  --pp-primary: /* value */;
  --pp-primary-color: /* value */;
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
        &lt;h2&gt;Text Input &amp; Textarea&lt;/h2&gt;
        
        &lt;div class="variant-group"&gt;
          &lt;h3&gt;PPTextField Styles&lt;/h3&gt;
          &lt;div class="component-demo" style="display: flex; flex-direction: column; gap: 16px;"&gt;
            &lt;PPTextField v-model="textVal" label="Outlined (Default)" placeholder="Enter text" clearable /&gt;
            &lt;PPTextField v-model="textVal" variant="filled" label="Filled" placeholder="Enter text" clearable /&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPTextField variant="outlined|filled" label="..." clearable /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Standard Text Input (PPInput)&lt;/h3&gt;
          
          &lt;h4 style="margin-top: 16px;"&gt;Variants&lt;/h4&gt;
          &lt;div class="component-demo" style="display: flex; flex-direction: column; gap: 8px;"&gt;
            &lt;PPInput v-model="textVal" label="Outline (Default)" variant="outline" placeholder="Outline variant" /&gt;
            &lt;PPInput v-model="textVal" label="Filled" variant="filled" placeholder="Filled variant" /&gt;
            &lt;PPInput v-model="textVal" label="Underlined" variant="underlined" placeholder="Underlined variant" /&gt;
          &lt;/div&gt;
          
          &lt;h4 style="margin-top: 24px;"&gt;Sizes &amp; Shapes&lt;/h4&gt;
          &lt;div class="component-demo" style="display: flex; flex-direction: column; gap: 8px;"&gt;
            &lt;PPInput v-model="textVal" size="sm" placeholder="Small (sm)" /&gt;
            &lt;PPInput v-model="textVal" size="md" placeholder="Medium (md) - Default" /&gt;
            &lt;PPInput v-model="textVal" size="lg" placeholder="Large (lg)" /&gt;
            &lt;div style="margin-top: 16px;"&gt;&lt;/div&gt;
            &lt;PPInput v-model="textVal" rounded placeholder="Rounded Pill Style" /&gt;
          &lt;/div&gt;

          &lt;h4 style="margin-top: 24px;"&gt;Constraints &amp; Formatting&lt;/h4&gt;
          &lt;p class="guide-desc"&gt;Restrict input using &lt;code&gt;maxLength&lt;/code&gt;, &lt;code&gt;numberOnly&lt;/code&gt;, &lt;code&gt;min&lt;/code&gt;, &lt;code&gt;max&lt;/code&gt;, and &lt;code&gt;format&lt;/code&gt;.&lt;/p&gt;
          &lt;div class="component-demo" style="display: flex; flex-direction: column; gap: 8px;"&gt;
            &lt;PPInput v-model="textVal" :maxLength="10" placeholder="Max length 10" /&gt;
            &lt;PPInput v-model="textVal" numberOnly placeholder="Numbers only" /&gt;
            &lt;PPInput v-model="textVal" :min="10" :max="100" placeholder="Min 10, Max 100" type="number" /&gt;
            &lt;PPInput v-model="textVal" format="####-####-####-####" placeholder="Card format (####-####-####-####)" /&gt;
          &lt;/div&gt;
          
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPInput variant="outline|filled|underlined" size="sm|md|lg" rounded /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Password Input (with icon)&lt;/h3&gt;
          &lt;div class="component-demo"&gt;
            &lt;PPInput v-model="textVal" label="Password" type="password" placeholder="Enter pass" clearable&gt;
              &lt;template #iconLeft&gt;
                &lt;svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"&gt;&lt;rect x="3" y="11" width="18" height="11" rx="2" ry="2"&gt;&lt;/rect&gt;&lt;path d="M7 11V7a5 5 0 0 1 10 0v4"&gt;&lt;/path&gt;&lt;/svg&gt;
              &lt;/template&gt;
            &lt;/PPInput&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPInput type="password"&amp;gt;
  &amp;lt;template #iconLeft&amp;gt;...&amp;lt;/template&amp;gt;
&amp;lt;/PPInput&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;
      
        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Customizing CSS&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;You can override the component's appearance globally via CSS variables or by targeting its specific classes.&lt;/p&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;/* Override globally */
:root {
  --pp-primary: /* value */;
  --pp-primary-color: /* value */;
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
import { PPTextField, PPInput } from '@phanna/ui-framework';

const textVal = ref('');
&lt;/script&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { PPTextField, PPInput } from '@phanna/ui-framework';

const textVal = ref('');
</script>
