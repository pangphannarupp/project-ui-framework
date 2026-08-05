<template>
  <div class="guide-section">
    <h2>Microsoft Math Editor</h2>
    <p>A complete Microsoft Word Equation Editor-style interface built using the Ribbon Menu and Math Editor components.</p>
    
    <div class="demo-box" style="padding: 0; overflow: hidden; border-radius: 8px; border: 1px solid #e5e7eb; background: #f9fafb;">
      <!-- App Header -->
      <div class="app-header">
        <div class="header-left">
          <div class="app-icon">∑</div>
          <div class="quick-actions">
            <PPIconButton :icon="saveOutline" variant="ghost" color="white" />
            <PPIconButton :icon="arrowUndoOutline" variant="ghost" color="white" />
            <PPIconButton :icon="arrowRedoOutline" variant="ghost" color="white" />
          </div>
        </div>
        <div class="header-center">
          <span class="document-title">Equation1 - Microsoft Math</span>
        </div>
        <div class="header-right">
          <PPIconButton :icon="removeOutline" variant="ghost" color="white" />
          <PPIconButton :icon="squareOutline" variant="ghost" color="white" />
          <PPIconButton :icon="closeOutline" variant="ghost" color="white" />
        </div>
      </div>

      <!-- Ribbon -->
      <PPRibbon v-model="activeTab">
        <PPRibbonTab id="home" title="HOME">
          <div class="ribbon-groups">
            <PPRibbonGroup title="Clipboard">
              <div class="horizontal-group">
                <PPRibbonButton label="Paste" size="large" />
                <PPRibbonButton label="Copy" size="large" />
              </div>
            </PPRibbonGroup>
            <PPRibbonGroup title="Tools">
              <div class="horizontal-group">
                <PPRibbonButton label="Professional" size="large" />
                <PPRibbonButton label="Linear" size="large" />
                <PPRibbonButton label="Normal Text" size="large" />
              </div>
            </PPRibbonGroup>
          </div>
        </PPRibbonTab>

        <PPRibbonTab id="symbol" title="SYMBOL">
           <div class="ribbon-groups">
            <PPRibbonGroup title="Basic Math">
              <div class="symbol-grid">
                <button class="symbol-btn" @click="insertMath('\\pm')">±</button>
                <button class="symbol-btn" @click="insertMath('\\infty')">∞</button>
                <button class="symbol-btn" @click="insertMath('\\approx')">≈</button>
                <button class="symbol-btn" @click="insertMath('\\neq')">≠</button>
                <button class="symbol-btn" @click="insertMath('\\times')">×</button>
                <button class="symbol-btn" @click="insertMath('\\div')">÷</button>
                <button class="symbol-btn" @click="insertMath('!')">!</button>
                <button class="symbol-btn" @click="insertMath('\\propto')">∝</button>
              </div>
            </PPRibbonGroup>
            <PPRibbonGroup title="Greek Letters">
              <div class="symbol-grid">
                <button class="symbol-btn" @click="insertMath('\\alpha')">α</button>
                <button class="symbol-btn" @click="insertMath('\\beta')">β</button>
                <button class="symbol-btn" @click="insertMath('\\gamma')">γ</button>
                <button class="symbol-btn" @click="insertMath('\\pi')">π</button>
                <button class="symbol-btn" @click="insertMath('\\Delta')">Δ</button>
                <button class="symbol-btn" @click="insertMath('\\theta')">θ</button>
                <button class="symbol-btn" @click="insertMath('\\Sigma')">Σ</button>
                <button class="symbol-btn" @click="insertMath('\\Omega')">Ω</button>
              </div>
            </PPRibbonGroup>
           </div>
        </PPRibbonTab>

        <PPRibbonTab id="structures" title="STRUCTURES">
           <div class="ribbon-groups">
            <PPRibbonGroup title="Fractions">
              <div class="horizontal-group">
                <PPRibbonButton label="Fraction" size="large" @click="insertMath('\\frac{x}{y}')">
                  <template #icon><span class="math-icon">½</span></template>
                </PPRibbonButton>
                <PPRibbonButton label="Stacked" size="large" @click="insertMath('\\frac{a}{b}')">
                  <template #icon><span class="math-icon" style="font-size: 20px;">a/b</span></template>
                </PPRibbonButton>
              </div>
            </PPRibbonGroup>
            
            <PPRibbonGroup title="Scripts">
              <div class="horizontal-group">
                <PPRibbonButton label="Superscript" size="large" @click="insertMath('x^2')">
                  <template #icon><span class="math-icon">x²</span></template>
                </PPRibbonButton>
                <PPRibbonButton label="Subscript" size="large" @click="insertMath('x_2')">
                  <template #icon><span class="math-icon">x₂</span></template>
                </PPRibbonButton>
              </div>
            </PPRibbonGroup>
            
            <PPRibbonGroup title="Radicals">
              <div class="horizontal-group">
                <PPRibbonButton label="Square Root" size="large" @click="insertMath('\\sqrt{x}')">
                  <template #icon><span class="math-icon">√x</span></template>
                </PPRibbonButton>
                <PPRibbonButton label="nth Root" size="large" @click="insertMath('\\sqrt[n]{x}')">
                  <template #icon><span class="math-icon">ⁿ√x</span></template>
                </PPRibbonButton>
              </div>
            </PPRibbonGroup>

            <PPRibbonGroup title="Integration">
              <div class="horizontal-group">
                <PPRibbonButton label="Integral" size="large" @click="insertMath('\\int')">
                  <template #icon><span class="math-icon">∫</span></template>
                </PPRibbonButton>
                <PPRibbonButton label="Double Integral" size="large" @click="insertMath('\\iint')">
                  <template #icon><span class="math-icon">∬</span></template>
                </PPRibbonButton>
                <PPRibbonButton label="Triple Integral" size="large" @click="insertMath('\\iiint')">
                  <template #icon><span class="math-icon">∭</span></template>
                </PPRibbonButton>
                <PPRibbonButton label="Contour Integral" size="large" @click="insertMath('\\oint')">
                  <template #icon><span class="math-icon">∮</span></template>
                </PPRibbonButton>
              </div>
            </PPRibbonGroup>
            <PPRibbonGroup title="Summation">
              <div class="horizontal-group">
                <PPRibbonButton label="Sum" size="large" @click="insertMath('\\sum')">
                  <template #icon><span class="math-icon">∑</span></template>
                </PPRibbonButton>
                <PPRibbonButton label="Product" size="large" @click="insertMath('\\prod')">
                  <template #icon><span class="math-icon">∏</span></template>
                </PPRibbonButton>
              </div>
            </PPRibbonGroup>
           </div>
        </PPRibbonTab>

        <PPRibbonTab id="matrix" title="MATRIX">
           <div class="ribbon-groups">
            <PPRibbonGroup title="Matrices">
              <div class="horizontal-group">
                <PPRibbonButton label="Parentheses Matrix" size="large" @click="insertMath('\\begin{pmatrix} a & b \\\\ c & d \\end{pmatrix}')">
                  <template #icon><span class="math-icon">( )</span></template>
                </PPRibbonButton>
                <PPRibbonButton label="Square Matrix" size="large" @click="insertMath('\\begin{bmatrix} a & b \\\\ c & d \\end{bmatrix}')">
                  <template #icon><span class="math-icon">[ ]</span></template>
                </PPRibbonButton>
                <PPRibbonButton label="Determinant" size="large" @click="insertMath('\\begin{vmatrix} a & b \\\\ c & d \\end{vmatrix}')">
                  <template #icon><span class="math-icon">| |</span></template>
                </PPRibbonButton>
              </div>
            </PPRibbonGroup>
           </div>
        </PPRibbonTab>
        
        <PPRibbonTab id="view" title="VIEW">
           <div class="ribbon-groups">
            <PPRibbonGroup title="Zoom">
              <PPRibbonButton label="Zoom In" size="large" />
              <PPRibbonButton label="Zoom Out" size="large" />
            </PPRibbonGroup>
           </div>
        </PPRibbonTab>
      </PPRibbon>

      <!-- Main Content Area -->
      <div class="document-area">
        <div class="page-container">
          <PPMathEditor 
            ref="mathEditorRef"
            v-model="equationContent" 
            placeholder="Type your equation here..."
            :showModeToggle="false"
            :hideToolbar="true"
          />
        </div>
      </div>
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
    &lt;h2&gt;Microsoft Math Editor&lt;/h2&gt;
    &lt;p&gt;A complete Microsoft Word Equation Editor-style interface built using the Ribbon Menu and Math Editor components.&lt;/p&gt;
    
    &lt;div class="demo-box" style="padding: 0; overflow: hidden; border-radius: 8px; border: 1px solid #e5e7eb; background: #f9fafb;"&gt;
      &lt;!-- App Header --&gt;
      &lt;div class="app-header"&gt;
        &lt;div class="header-left"&gt;
          &lt;div class="app-icon"&gt;∑&lt;/div&gt;
          &lt;div class="quick-actions"&gt;
            &lt;PPIconButton :icon="saveOutline" variant="ghost" color="white" /&gt;
            &lt;PPIconButton :icon="arrowUndoOutline" variant="ghost" color="white" /&gt;
            &lt;PPIconButton :icon="arrowRedoOutline" variant="ghost" color="white" /&gt;
          &lt;/div&gt;
        &lt;/div&gt;
        &lt;div class="header-center"&gt;
          &lt;span class="document-title"&gt;Equation1 - Microsoft Math&lt;/span&gt;
        &lt;/div&gt;
        &lt;div class="header-right"&gt;
          &lt;PPIconButton :icon="removeOutline" variant="ghost" color="white" /&gt;
          &lt;PPIconButton :icon="squareOutline" variant="ghost" color="white" /&gt;
          &lt;PPIconButton :icon="closeOutline" variant="ghost" color="white" /&gt;
        &lt;/div&gt;
      &lt;/div&gt;

      &lt;!-- Ribbon --&gt;
      &lt;PPRibbon v-model="activeTab"&gt;
        &lt;PPRibbonTab id="home" title="HOME"&gt;
          &lt;div class="ribbon-groups"&gt;
            &lt;PPRibbonGroup title="Clipboard"&gt;
              &lt;div class="horizontal-group"&gt;
                &lt;PPRibbonButton label="Paste" size="large" /&gt;
                &lt;PPRibbonButton label="Copy" size="large" /&gt;
              &lt;/div&gt;
            &lt;/PPRibbonGroup&gt;
            &lt;PPRibbonGroup title="Tools"&gt;
              &lt;div class="horizontal-group"&gt;
                &lt;PPRibbonButton label="Professional" size="large" /&gt;
                &lt;PPRibbonButton label="Linear" size="large" /&gt;
                &lt;PPRibbonButton label="Normal Text" size="large" /&gt;
              &lt;/div&gt;
            &lt;/PPRibbonGroup&gt;
          &lt;/div&gt;
        &lt;/PPRibbonTab&gt;

        &lt;PPRibbonTab id="symbol" title="SYMBOL"&gt;
           &lt;div class="ribbon-groups"&gt;
            &lt;PPRibbonGroup title="Basic Math"&gt;
              &lt;div class="symbol-grid"&gt;
                &lt;button class="symbol-btn" @click="insertMath('\\pm')"&gt;±&lt;/button&gt;
                &lt;button class="symbol-btn" @click="insertMath('\\infty')"&gt;∞&lt;/button&gt;
                &lt;button class="symbol-btn" @click="insertMath('\\approx')"&gt;≈&lt;/button&gt;
                &lt;button class="symbol-btn" @click="insertMath('\\neq')"&gt;≠&lt;/button&gt;
                &lt;button class="symbol-btn" @click="insertMath('\\times')"&gt;×&lt;/button&gt;
                &lt;button class="symbol-btn" @click="insertMath('\\div')"&gt;÷&lt;/button&gt;
                &lt;button class="symbol-btn" @click="insertMath('!')"&gt;!&lt;/button&gt;
                &lt;button class="symbol-btn" @click="insertMath('\\propto')"&gt;∝&lt;/button&gt;
              &lt;/div&gt;
            &lt;/PPRibbonGroup&gt;
            &lt;PPRibbonGroup title="Greek Letters"&gt;
              &lt;div class="symbol-grid"&gt;
                &lt;button class="symbol-btn" @click="insertMath('\\alpha')"&gt;α&lt;/button&gt;
                &lt;button class="symbol-btn" @click="insertMath('\\beta')"&gt;β&lt;/button&gt;
                &lt;button class="symbol-btn" @click="insertMath('\\gamma')"&gt;γ&lt;/button&gt;
                &lt;button class="symbol-btn" @click="insertMath('\\pi')"&gt;π&lt;/button&gt;
                &lt;button class="symbol-btn" @click="insertMath('\\Delta')"&gt;Δ&lt;/button&gt;
                &lt;button class="symbol-btn" @click="insertMath('\\theta')"&gt;θ&lt;/button&gt;
                &lt;button class="symbol-btn" @click="insertMath('\\Sigma')"&gt;Σ&lt;/button&gt;
                &lt;button class="symbol-btn" @click="insertMath('\\Omega')"&gt;Ω&lt;/button&gt;
              &lt;/div&gt;
            &lt;/PPRibbonGroup&gt;
           &lt;/div&gt;
        &lt;/PPRibbonTab&gt;

        &lt;PPRibbonTab id="structures" title="STRUCTURES"&gt;
           &lt;div class="ribbon-groups"&gt;
            &lt;PPRibbonGroup title="Fractions"&gt;
              &lt;div class="horizontal-group"&gt;
                &lt;PPRibbonButton label="Fraction" size="large" @click="insertMath('\\frac{x}{y}')"&gt;
                  &lt;template #icon&gt;&lt;span class="math-icon"&gt;½&lt;/span&gt;&lt;/template&gt;
                &lt;/PPRibbonButton&gt;
                &lt;PPRibbonButton label="Stacked" size="large" @click="insertMath('\\frac{a}{b}')"&gt;
                  &lt;template #icon&gt;&lt;span class="math-icon" style="font-size: 20px;"&gt;a/b&lt;/span&gt;&lt;/template&gt;
                &lt;/PPRibbonButton&gt;
              &lt;/div&gt;
            &lt;/PPRibbonGroup&gt;
            
            &lt;PPRibbonGroup title="Scripts"&gt;
              &lt;div class="horizontal-group"&gt;
                &lt;PPRibbonButton label="Superscript" size="large" @click="insertMath('x^2')"&gt;
                  &lt;template #icon&gt;&lt;span class="math-icon"&gt;x²&lt;/span&gt;&lt;/template&gt;
                &lt;/PPRibbonButton&gt;
                &lt;PPRibbonButton label="Subscript" size="large" @click="insertMath('x_2')"&gt;
                  &lt;template #icon&gt;&lt;span class="math-icon"&gt;x₂&lt;/span&gt;&lt;/template&gt;
                &lt;/PPRibbonButton&gt;
              &lt;/div&gt;
            &lt;/PPRibbonGroup&gt;
            
            &lt;PPRibbonGroup title="Radicals"&gt;
              &lt;div class="horizontal-group"&gt;
                &lt;PPRibbonButton label="Square Root" size="large" @click="insertMath('\\sqrt{x}')"&gt;
                  &lt;template #icon&gt;&lt;span class="math-icon"&gt;√x&lt;/span&gt;&lt;/template&gt;
                &lt;/PPRibbonButton&gt;
                &lt;PPRibbonButton label="nth Root" size="large" @click="insertMath('\\sqrt[n]{x}')"&gt;
                  &lt;template #icon&gt;&lt;span class="math-icon"&gt;ⁿ√x&lt;/span&gt;&lt;/template&gt;
                &lt;/PPRibbonButton&gt;
              &lt;/div&gt;
            &lt;/PPRibbonGroup&gt;

            &lt;PPRibbonGroup title="Integration"&gt;
              &lt;div class="horizontal-group"&gt;
                &lt;PPRibbonButton label="Integral" size="large" @click="insertMath('\\int')"&gt;
                  &lt;template #icon&gt;&lt;span class="math-icon"&gt;∫&lt;/span&gt;&lt;/template&gt;
                &lt;/PPRibbonButton&gt;
                &lt;PPRibbonButton label="Double Integral" size="large" @click="insertMath('\\iint')"&gt;
                  &lt;template #icon&gt;&lt;span class="math-icon"&gt;∬&lt;/span&gt;&lt;/template&gt;
                &lt;/PPRibbonButton&gt;
                &lt;PPRibbonButton label="Triple Integral" size="large" @click="insertMath('\\iiint')"&gt;
                  &lt;template #icon&gt;&lt;span class="math-icon"&gt;∭&lt;/span&gt;&lt;/template&gt;
                &lt;/PPRibbonButton&gt;
                &lt;PPRibbonButton label="Contour Integral" size="large" @click="insertMath('\\oint')"&gt;
                  &lt;template #icon&gt;&lt;span class="math-icon"&gt;∮&lt;/span&gt;&lt;/template&gt;
                &lt;/PPRibbonButton&gt;
              &lt;/div&gt;
            &lt;/PPRibbonGroup&gt;
            &lt;PPRibbonGroup title="Summation"&gt;
              &lt;div class="horizontal-group"&gt;
                &lt;PPRibbonButton label="Sum" size="large" @click="insertMath('\\sum')"&gt;
                  &lt;template #icon&gt;&lt;span class="math-icon"&gt;∑&lt;/span&gt;&lt;/template&gt;
                &lt;/PPRibbonButton&gt;
                &lt;PPRibbonButton label="Product" size="large" @click="insertMath('\\prod')"&gt;
                  &lt;template #icon&gt;&lt;span class="math-icon"&gt;∏&lt;/span&gt;&lt;/template&gt;
                &lt;/PPRibbonButton&gt;
              &lt;/div&gt;
            &lt;/PPRibbonGroup&gt;
           &lt;/div&gt;
        &lt;/PPRibbonTab&gt;

        &lt;PPRibbonTab id="matrix" title="MATRIX"&gt;
           &lt;div class="ribbon-groups"&gt;
            &lt;PPRibbonGroup title="Matrices"&gt;
              &lt;div class="horizontal-group"&gt;
                &lt;PPRibbonButton label="Parentheses Matrix" size="large" @click="insertMath('\\begin{pmatrix} a &amp; b \\\\ c &amp; d \\end{pmatrix}')"&gt;
                  &lt;template #icon&gt;&lt;span class="math-icon"&gt;( )&lt;/span&gt;&lt;/template&gt;
                &lt;/PPRibbonButton&gt;
                &lt;PPRibbonButton label="Square Matrix" size="large" @click="insertMath('\\begin{bmatrix} a &amp; b \\\\ c &amp; d \\end{bmatrix}')"&gt;
                  &lt;template #icon&gt;&lt;span class="math-icon"&gt;[ ]&lt;/span&gt;&lt;/template&gt;
                &lt;/PPRibbonButton&gt;
                &lt;PPRibbonButton label="Determinant" size="large" @click="insertMath('\\begin{vmatrix} a &amp; b \\\\ c &amp; d \\end{vmatrix}')"&gt;
                  &lt;template #icon&gt;&lt;span class="math-icon"&gt;| |&lt;/span&gt;&lt;/template&gt;
                &lt;/PPRibbonButton&gt;
              &lt;/div&gt;
            &lt;/PPRibbonGroup&gt;
           &lt;/div&gt;
        &lt;/PPRibbonTab&gt;
        
        &lt;PPRibbonTab id="view" title="VIEW"&gt;
           &lt;div class="ribbon-groups"&gt;
            &lt;PPRibbonGroup title="Zoom"&gt;
              &lt;PPRibbonButton label="Zoom In" size="large" /&gt;
              &lt;PPRibbonButton label="Zoom Out" size="large" /&gt;
            &lt;/PPRibbonGroup&gt;
           &lt;/div&gt;
        &lt;/PPRibbonTab&gt;
      &lt;/PPRibbon&gt;

      &lt;!-- Main Content Area --&gt;
      &lt;div class="document-area"&gt;
        &lt;div class="page-container"&gt;
          &lt;PPMathEditor 
            ref="mathEditorRef"
            v-model="equationContent" 
            placeholder="Type your equation here..."
            :showModeToggle="false"
            :hideToolbar="true"
          /&gt;
        &lt;/div&gt;
      &lt;/div&gt;
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
import { 
  saveOutline, arrowUndoOutline, arrowRedoOutline, 
  removeOutline, squareOutline, closeOutline
} from 'ionicons/icons';
import { 
  PPRibbon, PPRibbonTab, PPRibbonGroup, PPRibbonButton, PPIconButton, PPMathEditor
} from '@phanna/ui-framework';

const activeTab = ref('home');
const equationContent = ref('x = \\frac{-b \\pm \\sqrt{b^2-4ac}}{2a}');
const mathEditorRef = ref&lt;any&gt;(null);

const insertMath = (latex: string) =&gt; {
  // If the editor is focused or has a public method, we can call it. 
  // Otherwise, we just append to the model value as a simple fallback for the demo.
  equationContent.value = equationContent.value + ' ' + latex;
};
&lt;/script&gt;

&lt;style scoped&gt;
.guide-section { display: flex; flex-direction: column; gap: 24px; }
.demo-box { min-height: 500px; display: flex; flex-direction: column; }

.app-header {
  height: 48px;
  background-color: #003399; /* Word Blue */
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 16px;
  color: white;
}

.header-left, .header-right {
  display: flex;
  align-items: center;
  gap: 8px;
}

.app-icon {
  width: 32px;
  height: 32px;
  background-color: rgba(255, 255, 255, 0.2);
  border-radius: 4px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: bold;
  font-family: serif;
  font-size: 18px;
  margin-right: 8px;
}

.quick-actions {
  display: flex;
  gap: 4px;
}

.document-title {
  font-size: 14px;
  font-weight: 500;
}

.ribbon-tab-content {
  padding: 12px 16px;
}

.ribbon-groups {
  display: flex;
  gap: 16px;
  height: 100%;
}

.horizontal-group {
  display: flex;
  gap: 8px;
  height: 100%;
}

.symbol-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 4px;
  padding: 0 8px;
}

.symbol-btn {
  background: transparent;
  border: 1px solid transparent;
  border-radius: 4px;
  width: 28px;
  height: 28px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  font-family: serif;
  font-size: 14px;
  color: #374151;
}

.symbol-btn:hover {
  background: #f3f4f6;
  border-color: #e5e7eb;
}

.document-area {
  flex: 1;
  background-color: #f3f4f6;
  padding: 32px;
  display: flex;
  justify-content: center;
  overflow-y: auto;
}

.page-container {
  width: 100%;
  max-width: 800px;
  background: white;
  min-height: 400px;
  box-shadow: 0 1px 3px rgba(0,0,0,0.1);
  padding: 48px;
}

.math-icon {
  font-family: 'Cambria Math', 'Times New Roman', serif;
  font-size: 24px;
  font-style: italic;
  display: flex;
  align-items: center;
  justify-content: center;
}
&lt;/style&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { 
  saveOutline, arrowUndoOutline, arrowRedoOutline, 
  removeOutline, squareOutline, closeOutline
} from 'ionicons/icons';
import { 
  PPRibbon, PPRibbonTab, PPRibbonGroup, PPRibbonButton, PPIconButton, PPMathEditor
} from '@phanna/ui-framework';

const activeTab = ref('home');
const equationContent = ref('x = \\frac{-b \\pm \\sqrt{b^2-4ac}}{2a}');
const mathEditorRef = ref<any>(null);

const insertMath = (latex: string) => {
  // If the editor is focused or has a public method, we can call it. 
  // Otherwise, we just append to the model value as a simple fallback for the demo.
  equationContent.value = equationContent.value + ' ' + latex;
};
</script>

<style scoped>
.guide-section { display: flex; flex-direction: column; gap: 24px; }
.demo-box { min-height: 500px; display: flex; flex-direction: column; }

.app-header {
  height: 48px;
  background-color: #003399; /* Word Blue */
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 16px;
  color: white;
}

.header-left, .header-right {
  display: flex;
  align-items: center;
  gap: 8px;
}

.app-icon {
  width: 32px;
  height: 32px;
  background-color: rgba(255, 255, 255, 0.2);
  border-radius: 4px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: bold;
  font-family: serif;
  font-size: 18px;
  margin-right: 8px;
}

.quick-actions {
  display: flex;
  gap: 4px;
}

.document-title {
  font-size: 14px;
  font-weight: 500;
}

.ribbon-tab-content {
  padding: 12px 16px;
}

.ribbon-groups {
  display: flex;
  gap: 16px;
  height: 100%;
}

.horizontal-group {
  display: flex;
  gap: 8px;
  height: 100%;
}

.symbol-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 4px;
  padding: 0 8px;
}

.symbol-btn {
  background: transparent;
  border: 1px solid transparent;
  border-radius: 4px;
  width: 28px;
  height: 28px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  font-family: serif;
  font-size: 14px;
  color: #374151;
}

.symbol-btn:hover {
  background: #f3f4f6;
  border-color: #e5e7eb;
}

.document-area {
  flex: 1;
  background-color: #f3f4f6;
  padding: 32px;
  display: flex;
  justify-content: center;
  overflow-y: auto;
}

.page-container {
  width: 100%;
  max-width: 800px;
  background: white;
  min-height: 400px;
  box-shadow: 0 1px 3px rgba(0,0,0,0.1);
  padding: 48px;
}

.math-icon {
  font-family: 'Cambria Math', 'Times New Roman', serif;
  font-size: 24px;
  font-style: italic;
  display: flex;
  align-items: center;
  justify-content: center;
}
</style>
