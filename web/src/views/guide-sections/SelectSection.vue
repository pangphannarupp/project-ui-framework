<template>
  <div class="guide-section">
    <h2>Select</h2>
    <p>A customizable dropdown select component for choosing from a list of options.</p>

    <div class="variant-group">
      <h3>Variants</h3>
      <div class="demo-box" style="display: flex; flex-direction: column; gap: 24px;">
        <PPSelect
          v-model="valOutlined"
          :options="options"
          label="Outlined (Default)"
          placeholder="Select an option"
        />
        <PPSelect
          v-model="valFilled"
          :options="options"
          variant="filled"
          label="Filled"
          placeholder="Select an option"
        />
        <PPSelect
          v-model="valFlushed"
          :options="options"
          variant="flushed"
          label="Flushed"
          placeholder="Select an option"
        />
        <PPSelect
          v-model="valSoft"
          :options="options"
          variant="soft"
          label="Soft (Tonal)"
          placeholder="Select an option"
        />
      </div>
      <pre class="code-block" v-pre><code>&lt;PPSelect variant="outlined" ... /&gt;
&lt;PPSelect variant="filled" ... /&gt;
&lt;PPSelect variant="flushed" ... /&gt;
&lt;PPSelect variant="soft" ... /&gt;</code></pre>
    </div>

    <div class="variant-group">
      <h3>States & Validation</h3>
      <div class="demo-box" style="display: flex; flex-direction: column; gap: 24px;">
        <PPSelect
          v-model="valError"
          :options="options"
          label="Error State"
          error="Please select a valid option."
          placeholder="Invalid selection"
        />
        <PPSelect
          v-model="valDisabled"
          :options="options"
          label="Disabled State"
          disabled
          placeholder="Cannot select"
        />
      </div>
    </div>
  
        <div class="variant-group">
          <h3>Customizing CSS</h3>
          <p class="custom-guide">You can override the component's appearance globally via CSS variables or by targeting its specific classes.</p>
          <pre class="code-block" v-pre><code>/* Override globally */
:root {
  --pp-bg-color: /* value */;
  --pp-border-color: /* value */;
  --pp-primary-color: /* value */;
  --pp-primary-variant: /* value */;
  --pp-text-color: /* value */;
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
    &lt;h2&gt;Select&lt;/h2&gt;
    &lt;p&gt;A customizable dropdown select component for choosing from a list of options.&lt;/p&gt;

    &lt;div class="variant-group"&gt;
      &lt;h3&gt;Variants&lt;/h3&gt;
      &lt;div class="demo-box" style="display: flex; flex-direction: column; gap: 24px;"&gt;
        &lt;PPSelect
          v-model="valOutlined"
          :options="options"
          label="Outlined (Default)"
          placeholder="Select an option"
        /&gt;
        &lt;PPSelect
          v-model="valFilled"
          :options="options"
          variant="filled"
          label="Filled"
          placeholder="Select an option"
        /&gt;
        &lt;PPSelect
          v-model="valFlushed"
          :options="options"
          variant="flushed"
          label="Flushed"
          placeholder="Select an option"
        /&gt;
        &lt;PPSelect
          v-model="valSoft"
          :options="options"
          variant="soft"
          label="Soft (Tonal)"
          placeholder="Select an option"
        /&gt;
      &lt;/div&gt;
      &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPSelect variant="outlined" ... /&amp;gt;
&amp;lt;PPSelect variant="filled" ... /&amp;gt;
&amp;lt;PPSelect variant="flushed" ... /&amp;gt;
&amp;lt;PPSelect variant="soft" ... /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
    &lt;/div&gt;

    &lt;div class="variant-group"&gt;
      &lt;h3&gt;States &amp; Validation&lt;/h3&gt;
      &lt;div class="demo-box" style="display: flex; flex-direction: column; gap: 24px;"&gt;
        &lt;PPSelect
          v-model="valError"
          :options="options"
          label="Error State"
          error="Please select a valid option."
          placeholder="Invalid selection"
        /&gt;
        &lt;PPSelect
          v-model="valDisabled"
          :options="options"
          label="Disabled State"
          disabled
          placeholder="Cannot select"
        /&gt;
      &lt;/div&gt;
    &lt;/div&gt;
  
        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Customizing CSS&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;You can override the component's appearance globally via CSS variables or by targeting its specific classes.&lt;/p&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;/* Override globally */
:root {
  --pp-bg-color: /* value */;
  --pp-border-color: /* value */;
  --pp-primary-color: /* value */;
  --pp-primary-variant: /* value */;
  --pp-text-color: /* value */;
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
import { PPSelect } from '@phanna/ui-framework';

const valOutlined = ref('');
const valFilled = ref('');
const valFlushed = ref('');
const valSoft = ref('');
const valError = ref('');
const valDisabled = ref('');

const options = [
  { label: 'Option 1', value: 'opt1' },
  { label: 'Option 2', value: 'opt2' },
  { label: 'Option 3', value: 'opt3' }
];
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
import { ref } from 'vue';
import { PPSelect } from '@phanna/ui-framework';

const valOutlined = ref('');
const valFilled = ref('');
const valFlushed = ref('');
const valSoft = ref('');
const valError = ref('');
const valDisabled = ref('');

const options = [
  { label: 'Option 1', value: 'opt1' },
  { label: 'Option 2', value: 'opt2' },
  { label: 'Option 3', value: 'opt3' }
];
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
