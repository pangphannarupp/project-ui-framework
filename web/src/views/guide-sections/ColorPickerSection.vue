<template>
  <div class="guide-section">
    <h2>Color Picker</h2>
    <p>A color picker component that allows users to select colors using HEX, RGB, or HSL.</p>

    <h3>Basic Usage</h3>
    <div class="demo-box">
      <PPColorPicker v-model="color" />
      <div style="margin-top: 16px;">
        Selected Color: <span :style="{ color: color, fontWeight: 'bold' }">{{ color }}</span>
      </div>
    </div>
    <pre class="code-block" v-pre><code>&lt;PPColorPicker v-model="color" /&gt;</code></pre>
    
        <div class="variant-group">
          <h3>Input Wrapper</h3>
          <p class="custom-guide"><strong>Component:</strong> <code>&lt;PPColorPickerInput&gt;</code></p>
          <div class="component-demo" style="background: #ffffff; border: 1px solid #ddd; border-radius: 12px; padding: 20px;">
            <PPColorPickerInput v-model="colorModel" />
          </div>
          <pre class="code-block" v-pre><code>&lt;PPColorPickerInput v-model="color" /&gt;</code></pre>
        </div>

        <div class="variant-group">
      <h3>Color Picker Sheet</h3>
      <p class="custom-guide"><strong>Component:</strong> <code>&lt;PPColorPickerSheet&gt;</code></p>
      <div class="demo-box">
        <PPButton @click="showColorPickerSheet = true">Open Color Sheet</PPButton>
        <PPColorPickerSheet 
          v-model="showColorPickerSheet"
          v-model:colorValue="color"
          title="Select a Theme Color"
        />
      </div>
      <pre class="code-block" v-pre><code>&lt;PPColorPickerSheet v-model="isOpen" v-model:colorValue="color" title="Select a Theme Color" /&gt;</code></pre>
    </div>

    <div class="variant-group">
      <h3>Color Picker Island Popup</h3>
      <p class="custom-guide"><strong>Component:</strong> <code>&lt;PPColorPickerIsland&gt;</code></p>
      <div class="demo-box">
        <PPButton @click="showColorPickerIsland = true">Open Color Picker Island</PPButton>
        <PPColorPickerIsland 
          v-model="showColorPickerIsland"
          v-model:colorValue="color"
          title="Select a Theme Color"
        />
      </div>
      <pre class="code-block" v-pre><code>&lt;PPColorPickerIsland v-model="isOpen" v-model:colorValue="color" title="Select a Theme Color" /&gt;</code></pre>
    </div>

    <div class="variant-group">
      <h3>Color Picker Alert</h3>
      <p class="custom-guide"><strong>Component:</strong> <code>&lt;PPColorPickerAlert&gt;</code></p>
      <div class="demo-box">
        <PPButton @click="showColorPickerAlert = true">Open Color Alert</PPButton>
        <PPColorPickerAlert 
          v-model="showColorPickerAlert"
          v-model:colorValue="color"
          title="Select a Theme Color"
        />
      </div>
      <pre class="code-block" v-pre><code>&lt;PPColorPickerAlert v-model="isOpen" v-model:colorValue="color" title="Select a Theme Color" /&gt;</code></pre>
    </div>
  
        <div class="variant-group">
          <h3>Customizing CSS</h3>
          <p class="custom-guide">You can override the component's appearance globally via CSS variables or by targeting its specific classes.</p>
          <pre class="code-block" v-pre><code>/* Override globally */
:root {
  --pp-calendar-btn-cancel-text: /* value */;
  --pp-calendar-btn-confirm-bg: /* value */;
  --pp-calendar-btn-confirm-text: /* value */;
  --pp-color-primary: /* value */;
  --pp-island-expanded-height: /* value */;
  --pp-island-expanded-radius: /* value */;
  --pp-island-expanded-width: /* value */;
  --pp-primary: /* value */;
  --pp-primary-color: /* value */;
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
    &lt;h2&gt;Color Picker&lt;/h2&gt;
    &lt;p&gt;A color picker component that allows users to select colors using HEX, RGB, or HSL.&lt;/p&gt;

    &lt;h3&gt;Basic Usage&lt;/h3&gt;
    &lt;div class="demo-box"&gt;
      &lt;PPColorPicker v-model="color" /&gt;
      &lt;div style="margin-top: 16px;"&gt;
        Selected Color: &lt;span :style="{ color: color, fontWeight: 'bold' }"&gt;{{ color }}&lt;/span&gt;
      &lt;/div&gt;
    &lt;/div&gt;
    &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPColorPicker v-model="color" /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
    &lt;div class="variant-group"&gt;
      &lt;h3&gt;Color Picker Sheet&lt;/h3&gt;
      &lt;p class="custom-guide"&gt;&lt;strong&gt;Component:&lt;/strong&gt; &lt;code&gt;&amp;lt;PPColorPickerSheet&amp;gt;&lt;/code&gt;&lt;/p&gt;
      &lt;div class="demo-box"&gt;
        &lt;PPButton @click="showColorPickerSheet = true"&gt;Open Color Sheet&lt;/PPButton&gt;
        &lt;PPColorPickerSheet 
          v-model="showColorPickerSheet"
          v-model:colorValue="color"
          title="Select a Theme Color"
        /&gt;
      &lt;/div&gt;
      &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPColorPickerSheet v-model="isOpen" v-model:colorValue="color" title="Select a Theme Color" /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
    &lt;/div&gt;

    &lt;div class="variant-group"&gt;
      &lt;h3&gt;Color Picker Island Popup&lt;/h3&gt;
      &lt;p class="custom-guide"&gt;&lt;strong&gt;Component:&lt;/strong&gt; &lt;code&gt;&amp;lt;PPColorPickerIsland&amp;gt;&lt;/code&gt;&lt;/p&gt;
      &lt;div class="demo-box"&gt;
        &lt;PPButton @click="showColorPickerIsland = true"&gt;Open Color Picker Island&lt;/PPButton&gt;
        &lt;PPColorPickerIsland 
          v-model="showColorPickerIsland"
          v-model:colorValue="color"
          title="Select a Theme Color"
        /&gt;
      &lt;/div&gt;
      &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPColorPickerIsland v-model="isOpen" v-model:colorValue="color" title="Select a Theme Color" /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
    &lt;/div&gt;

    &lt;div class="variant-group"&gt;
      &lt;h3&gt;Color Picker Alert&lt;/h3&gt;
      &lt;p class="custom-guide"&gt;&lt;strong&gt;Component:&lt;/strong&gt; &lt;code&gt;&amp;lt;PPColorPickerAlert&amp;gt;&lt;/code&gt;&lt;/p&gt;
      &lt;div class="demo-box"&gt;
        &lt;PPButton @click="showColorPickerAlert = true"&gt;Open Color Alert&lt;/PPButton&gt;
        &lt;PPColorPickerAlert 
          v-model="showColorPickerAlert"
          v-model:colorValue="color"
          title="Select a Theme Color"
        /&gt;
      &lt;/div&gt;
      &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPColorPickerAlert v-model="isOpen" v-model:colorValue="color" title="Select a Theme Color" /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
    &lt;/div&gt;
  
        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Customizing CSS&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;You can override the component's appearance globally via CSS variables or by targeting its specific classes.&lt;/p&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;/* Override globally */
:root {
  --pp-calendar-btn-cancel-text: /* value */;
  --pp-calendar-btn-confirm-bg: /* value */;
  --pp-calendar-btn-confirm-text: /* value */;
  --pp-color-primary: /* value */;
  --pp-island-expanded-height: /* value */;
  --pp-island-expanded-radius: /* value */;
  --pp-island-expanded-width: /* value */;
  --pp-primary: /* value */;
  --pp-primary-color: /* value */;
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
const colorModel = ref(null);
import { PPColorPicker, PPButton, PPColorPickerSheet, PPColorPickerIsland, PPColorPickerAlert , PPColorPickerInput } from '@phanna/ui-framework';

const color = ref('#3880ff');
const showColorPickerSheet = ref(false);
const showColorPickerIsland = ref(false);
const showColorPickerAlert = ref(false);
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
const colorModel = ref(null);
import { PPColorPicker, PPButton, PPColorPickerSheet, PPColorPickerIsland, PPColorPickerAlert , PPColorPickerInput } from '@phanna/ui-framework';

const color = ref('#3880ff');
const showColorPickerSheet = ref(false);
const showColorPickerIsland = ref(false);
const showColorPickerAlert = ref(false);
</script>

<style scoped>
.guide-section { display: flex; flex-direction: column; gap: 24px; }
.demo-box { border: 1px solid #e5e7eb; border-radius: 8px; padding: 24px; background: #f9fafb; }
</style>
