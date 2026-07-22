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
        <pre><code>{{ equation }}</code></pre>
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
  </div>
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
