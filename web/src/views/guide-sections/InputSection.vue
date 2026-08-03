<template>
<div class="guide-section">
        <h2>Text Input & Textarea</h2>
        
        <div class="variant-group">
          <h3>PPTextField Styles</h3>
          <div class="component-demo" style="display: flex; flex-direction: column; gap: 16px;">
            <PPTextField v-model="textVal" label="Outlined (Default)" placeholder="Enter text" clearable />
            <PPTextField v-model="textVal" variant="filled" label="Filled" placeholder="Enter text" clearable />
          </div>
          <pre class="code-block"><code>&lt;PPTextField variant="outlined|filled" label="..." clearable /&gt;</code></pre>
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
            <PPInput v-model="textVal" maxLength="10" placeholder="Max length 10" />
            <PPInput v-model="textVal" numberOnly placeholder="Numbers only" />
            <PPInput v-model="textVal" min="10" max="100" placeholder="Min 10, Max 100" type="number" />
            <PPInput v-model="textVal" format="####-####-####-####" placeholder="Card format (####-####-####-####)" />
          </div>
          
          <pre class="code-block"><code>&lt;PPInput variant="outline|filled|underlined" size="sm|md|lg" rounded /&gt;</code></pre>
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
          <pre class="code-block"><code>&lt;PPInput type="password"&gt;
  &lt;template #iconLeft&gt;...&lt;/template&gt;
&lt;/PPInput&gt;</code></pre>
        </div>
      </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { PPTextField, PPInput } from '@phanna/ui-framework';

const textVal = ref('');
</script>
