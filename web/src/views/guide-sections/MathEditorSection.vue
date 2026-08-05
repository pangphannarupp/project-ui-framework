<template>
  <div class="component-section">
    <h2>Math Editor</h2>
    <p>A zero-bundle-size LaTeX math editor that dynamically loads KaTeX for lightning-fast rendering.</p>

    <!-- Basic Math Editor -->
    <div class="demo-box">
      <h3>Basic Editor with Live Preview</h3>
      <p class="helper-text">Type LaTeX or use the toolbar to insert symbols.</p>
      
      <div class="demo-content">
        <PPMathEditor 
          v-model="equation" 
          placeholder="Enter your LaTeX equation here..."
        />
      </div>

      <div class="output-preview">
        <h4>Raw LaTeX:</h4>
        <pre v-pre><code>{{ equation }}</code></pre>
      </div>

      <pre class="code-block" v-pre><code>&lt;PPMathEditor 
  v-model="equation" 
  placeholder="Enter your LaTeX equation here..."
/&gt;</code></pre>
    </div>

    <!-- Complex Example -->
    <div class="demo-box">
      <h3>Complex Equation Example</h3>
      <div class="demo-content">
        <PPMathEditor 
          v-model="complexEquation" 
        />
      </div>
    </div>

    <!-- Math Preview Only -->
    <div class="demo-box">
      <h3>Math Preview Only</h3>
      <p class="helper-text">If you just want to render equations without an editor, use <code>PPMathPreview</code>.</p>
      
      <div class="demo-content">
        Inline math preview: 
        <PPMathPreview equation="\sum_{i=1}^{\infty} \frac{1}{n^s}" :displayMode="false" />
        works perfectly!
      </div>

      <pre class="code-block" v-pre><code>&lt;PPMathPreview equation="\sum_{i=1}^{\infty} \frac{1}{n^s}" :displayMode="false" /&gt;</code></pre>
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
  &lt;div class="component-section"&gt;
    &lt;h2&gt;Math Editor&lt;/h2&gt;
    &lt;p&gt;A zero-bundle-size LaTeX math editor that dynamically loads KaTeX for lightning-fast rendering.&lt;/p&gt;

    &lt;!-- Basic Math Editor --&gt;
    &lt;div class="demo-box"&gt;
      &lt;h3&gt;Basic Editor with Live Preview&lt;/h3&gt;
      &lt;p class="helper-text"&gt;Type LaTeX or use the toolbar to insert symbols.&lt;/p&gt;
      
      &lt;div class="demo-content"&gt;
        &lt;PPMathEditor 
          v-model="equation" 
          placeholder="Enter your LaTeX equation here..."
        /&gt;
      &lt;/div&gt;

      &lt;div class="output-preview"&gt;
        &lt;h4&gt;Raw LaTeX:&lt;/h4&gt;
        &lt;pre&gt;&lt;code&gt;{{ equation }}&lt;/code&gt;&lt;/pre&gt;
      &lt;/div&gt;

      &lt;pre class="code-block" v-pre&gt;&lt;code&gt;&amp;lt;PPMathEditor 
  v-model="equation" 
  placeholder="Enter your LaTeX equation here..."
/&amp;gt;&lt;/code&gt;&lt;/pre&gt;
    &lt;/div&gt;

    &lt;!-- Complex Example --&gt;
    &lt;div class="demo-box"&gt;
      &lt;h3&gt;Complex Equation Example&lt;/h3&gt;
      &lt;div class="demo-content"&gt;
        &lt;PPMathEditor 
          v-model="complexEquation" 
        /&gt;
      &lt;/div&gt;
    &lt;/div&gt;

    &lt;!-- Math Preview Only --&gt;
    &lt;div class="demo-box"&gt;
      &lt;h3&gt;Math Preview Only&lt;/h3&gt;
      &lt;p class="helper-text"&gt;If you just want to render equations without an editor, use &lt;code&gt;PPMathPreview&lt;/code&gt;.&lt;/p&gt;
      
      &lt;div class="demo-content"&gt;
        Inline math preview: 
        &lt;PPMathPreview equation="\sum_{i=1}^{\infty} \frac{1}{n^s}" :displayMode="false" /&gt;
        works perfectly!
      &lt;/div&gt;

      &lt;pre class="code-block" v-pre&gt;&lt;code&gt;&amp;lt;PPMathPreview equation="\sum_{i=1}^{\infty} \frac{1}{n^s}" :displayMode="false" /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
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
import { ref } from 'vue';
import { PPMathEditor, PPMathPreview } from '@phanna/ui-framework';

const equation = ref('x = \\frac{-b \\pm \\sqrt{b^2-4ac}}{2a}');
const complexEquation = ref('\\int_{0}^{\\infty} e^{-x^2} dx = \\frac{\\sqrt{\\pi}}{2}');
&lt;/script&gt;

&lt;style scoped&gt;
.demo-box {
  border: 1px solid #e0e0e0;
  border-radius: 8px;
  padding: 24px;
  margin-top: 16px;
  background: white;
}
.demo-content {
  margin-bottom: 24px;
}
.helper-text {
  font-size: 13px;
  color: #666;
  margin-bottom: 16px;
}
.code-block {
  background: #282c34;
  color: #abb2bf;
  padding: 16px;
  border-radius: 4px;
  overflow-x: auto;
  font-size: 14px;
  line-height: 1.5;
  margin-top: 24px;
}

.output-preview {
  margin-top: 24px;
  padding: 16px;
  background: #f5f7fa;
  border-left: 4px solid #003399;
  border-radius: 4px;
}

.output-preview h4 {
  margin-top: 0;
  margin-bottom: 12px;
  font-size: 14px;
  color: #333;
}

.output-preview pre {
  margin: 0;
  white-space: pre-wrap;
  word-wrap: break-word;
  font-family: monospace;
  font-size: 13px;
  color: #d63384;
}
&lt;/style&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { PPMathEditor, PPMathPreview } from '@phanna/ui-framework';

const equation = ref('x = \\frac{-b \\pm \\sqrt{b^2-4ac}}{2a}');
const complexEquation = ref('\\int_{0}^{\\infty} e^{-x^2} dx = \\frac{\\sqrt{\\pi}}{2}');
</script>

<style scoped>
.demo-box {
  border: 1px solid #e0e0e0;
  border-radius: 8px;
  padding: 24px;
  margin-top: 16px;
  background: white;
}
.demo-content {
  margin-bottom: 24px;
}
.helper-text {
  font-size: 13px;
  color: #666;
  margin-bottom: 16px;
}
.code-block {
  background: #282c34;
  color: #abb2bf;
  padding: 16px;
  border-radius: 4px;
  overflow-x: auto;
  font-size: 14px;
  line-height: 1.5;
  margin-top: 24px;
}

.output-preview {
  margin-top: 24px;
  padding: 16px;
  background: #f5f7fa;
  border-left: 4px solid #003399;
  border-radius: 4px;
}

.output-preview h4 {
  margin-top: 0;
  margin-bottom: 12px;
  font-size: 14px;
  color: #333;
}

.output-preview pre {
  margin: 0;
  white-space: pre-wrap;
  word-wrap: break-word;
  font-family: monospace;
  font-size: 13px;
  color: #d63384;
}
</style>
