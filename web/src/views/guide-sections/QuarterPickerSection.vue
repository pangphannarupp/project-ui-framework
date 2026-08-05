<template>
  <div class="component-section">
    <h2>Quarter Picker</h2>
    <p>A specialized calendar component for selecting financial or calendar quarters (Q1-Q4) within a given year.</p>

    <!-- Basic Quarter Picker -->
    <div style="margin-top: 40px;">
      <h3>Basic Quarter Picker (PPQuarterPicker)</h3>
      <p>A simple inline quarter picker, similar to the month and year pickers.</p>
      
      <div class="demo-box" style="padding: 40px; background: #f8fafc; border-radius: 12px; display: flex; flex-direction: column; align-items: center; gap: 20px;">
        <div style="width: 300px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); border-radius: 12px; overflow: hidden;">
          <PPQuarterPicker 
            @quarter-selected="onQuarterSelected" 
          />
        </div>
        <p v-if="selectedQuarter" style="font-size: 14px; color: #64748b;">Selected: <strong>{{ selectedQuarter?.year }} - Q{{ selectedQuarter?.quarter }}</strong></p>
      </div>

      <div style="margin-top: 16px;">
        <pre class="code-block" v-pre><code>&lt;template&gt;
  &lt;PPQuarterPicker @quarter-selected="onSelect" /&gt;
&lt;/template&gt;

&lt;script setup&gt;
const onSelect = (selection) =&gt; {
  console.log(selection.year, selection.quarter);
};
&lt;/script&gt;</code></pre>
      </div>
    </div>
  
        
        <div class="variant-group">
          <h3>Input Wrapper</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;PPQuarterPickerInput&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;">
            <PPQuarterPickerInput v-model="quarterModel" />
          </div>
          <pre class="code-block" v-pre><code>&lt;PPQuarterPickerInput v-model="quarter" /&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Customizing CSS</h3>
          <p class="custom-guide">You can override the component's appearance globally via CSS variables or by targeting its specific classes.</p>
          <pre class="code-block" v-pre><code>/* Override globally */
:root {
  --pp-calendar-bg: /* value */;
  --pp-calendar-btn-cancel-text: /* value */;
  --pp-calendar-btn-confirm-bg: /* value */;
  --pp-calendar-btn-confirm-text: /* value */;
  --pp-calendar-cell-height: /* value */;
  --pp-calendar-day-disabled-opacity: /* value */;
  --pp-calendar-range-bg: /* value */;
  --pp-calendar-selected-bg: /* value */;
  --pp-calendar-selected-text: /* value */;
  --pp-calendar-text: /* value */;
  --pp-calendar-today-border: /* value */;
  --pp-calendar-wheel-active: /* value */;
  --pp-calendar-wheel-text: /* value */;
  --pp-danger-color: /* value */;
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
  &lt;div class="component-section"&gt;
    &lt;h2&gt;Quarter Picker&lt;/h2&gt;
    &lt;p&gt;A specialized calendar component for selecting financial or calendar quarters (Q1-Q4) within a given year.&lt;/p&gt;

    &lt;!-- Basic Quarter Picker --&gt;
    &lt;div style="margin-top: 40px;"&gt;
      &lt;h3&gt;Basic Quarter Picker (PPQuarterPicker)&lt;/h3&gt;
      &lt;p&gt;A simple inline quarter picker, similar to the month and year pickers.&lt;/p&gt;
      
      &lt;div class="demo-box" style="padding: 40px; background: #f8fafc; border-radius: 12px; display: flex; flex-direction: column; align-items: center; gap: 20px;"&gt;
        &lt;div style="width: 300px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); border-radius: 12px; overflow: hidden;"&gt;
          &lt;PPQuarterPicker 
            @quarter-selected="onQuarterSelected" 
          /&gt;
        &lt;/div&gt;
        &lt;p v-if="selectedQuarter" style="font-size: 14px; color: #64748b;"&gt;Selected: &lt;strong&gt;{{ selectedQuarter?.year }} - Q{{ selectedQuarter?.quarter }}&lt;/strong&gt;&lt;/p&gt;
      &lt;/div&gt;

      &lt;div style="margin-top: 16px;"&gt;
        &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;template&amp;gt;
  &amp;lt;PPQuarterPicker @quarter-selected="onSelect" /&amp;gt;
&amp;lt;/template&amp;gt;

&amp;lt;script setup&amp;gt;
const onSelect = (selection) =&amp;gt; {
  console.log(selection.year, selection.quarter);
};
&amp;lt;/script&amp;gt;&lt;/code&gt;&lt;/pre&gt;
      &lt;/div&gt;
    &lt;/div&gt;
  
        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Customizing CSS&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;You can override the component's appearance globally via CSS variables or by targeting its specific classes.&lt;/p&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;/* Override globally */
:root {
  --pp-calendar-bg: /* value */;
  --pp-calendar-btn-cancel-text: /* value */;
  --pp-calendar-btn-confirm-bg: /* value */;
  --pp-calendar-btn-confirm-text: /* value */;
  --pp-calendar-cell-height: /* value */;
  --pp-calendar-day-disabled-opacity: /* value */;
  --pp-calendar-range-bg: /* value */;
  --pp-calendar-selected-bg: /* value */;
  --pp-calendar-selected-text: /* value */;
  --pp-calendar-text: /* value */;
  --pp-calendar-today-border: /* value */;
  --pp-calendar-wheel-active: /* value */;
  --pp-calendar-wheel-text: /* value */;
  --pp-danger-color: /* value */;
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
const quarterModel = ref(null);
import { PPQuarterPicker , PPQuarterPickerInput } from '@phanna/ui-framework';

const selectedQuarter = ref&lt;{ year: number, quarter: number } | null&gt;(null);

const onQuarterSelected = (selection: { year: number, quarter: number }) =&gt; {
  selectedQuarter.value = selection;
};
&lt;/script&gt;

&lt;style scoped&gt;
.component-section {
  max-width: 800px;
}
.demo-box {
  border: 1px solid #e2e8f0;
}
h2 {
  font-size: 28px;
  font-weight: 700;
  margin-bottom: 8px;
}
h3 {
  font-size: 20px;
  font-weight: 600;
  margin-bottom: 8px;
}
p {
  color: #64748b;
  margin-bottom: 16px;
  line-height: 1.5;
}
.code-block {
  background: #1e293b;
  color: #f8fafc;
  padding: 16px;
  border-radius: 8px;
  overflow-x: auto;
  font-size: 14px;
}
&lt;/style&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
</template>

<script setup lang="ts">
import { ref } from 'vue';
const quarterModel = ref(null);
import { PPQuarterPicker , PPQuarterPickerInput } from '@phanna/ui-framework';

const selectedQuarter = ref<{ year: number, quarter: number } | null>(null);

const onQuarterSelected = (selection: { year: number, quarter: number }) => {
  selectedQuarter.value = selection;
};
</script>

<style scoped>
.component-section {
  max-width: 800px;
}
.demo-box {
  border: 1px solid #e2e8f0;
}
h2 {
  font-size: 28px;
  font-weight: 700;
  margin-bottom: 8px;
}
h3 {
  font-size: 20px;
  font-weight: 600;
  margin-bottom: 8px;
}
p {
  color: #64748b;
  margin-bottom: 16px;
  line-height: 1.5;
}
.code-block {
  background: #1e293b;
  color: #f8fafc;
  padding: 16px;
  border-radius: 8px;
  overflow-x: auto;
  font-size: 14px;
}
</style>
