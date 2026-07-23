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
          <h3>Standard Text Input</h3>
          <div class="component-demo">
            <PPInput v-model="textVal" label="Username" placeholder="Enter name" clearable />
          </div>
          <pre class="code-block"><code>&lt;PPInput v-model="text" label="Username" clearable /&gt;</code></pre>
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
