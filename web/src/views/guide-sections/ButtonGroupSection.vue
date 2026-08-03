<template>
<div class="guide-section">
        <h2>1.5 Button Group</h2>

        <div class="variant-group">
          <h3>Connected Group (Default)</h3>
          <div class="component-demo">
            <PPButtonGroup>
              <PPButton variant="outline">Left</PPButton>
              <PPButton variant="outline">Middle</PPButton>
              <PPButton variant="outline">Right</PPButton>
            </PPButtonGroup>
          </div>
          <pre class="code-block"><code>&lt;PPButtonGroup&gt;
  &lt;PPButton variant="outline"&gt;Left&lt;/PPButton&gt;
  &lt;PPButton variant="outline"&gt;Middle&lt;/PPButton&gt;
  &lt;PPButton variant="outline"&gt;Right&lt;/PPButton&gt;
&lt;/PPButtonGroup&gt;</code></pre>
        </div>
        
        <div class="variant-group">
          <h3>Segmented Group</h3>
          <div class="component-demo">
            <PPButtonGroup variant="segmented">
              <PPButton variant="primary">Active</PPButton>
              <PPButton variant="ghost">Inactive</PPButton>
              <PPButton variant="ghost">Disabled</PPButton>
            </PPButtonGroup>
          </div>
          <pre class="code-block"><code>&lt;PPButtonGroup variant="segmented"&gt;
  &lt;PPButton variant="primary"&gt;Active&lt;/PPButton&gt;
  &lt;PPButton variant="ghost"&gt;Inactive&lt;/PPButton&gt;
  &lt;PPButton variant="ghost"&gt;Disabled&lt;/PPButton&gt;
&lt;/PPButtonGroup&gt;</code></pre>
        </div>
        
        <div class="variant-group">
          <h3>Separated Group</h3>
          <div class="component-demo">
            <PPButtonGroup variant="separated">
              <PPButton variant="outline">Action 1</PPButton>
              <PPButton variant="outline">Action 2</PPButton>
              <PPButton variant="outline">Action 3</PPButton>
            </PPButtonGroup>
          </div>
          <pre class="code-block"><code>&lt;PPButtonGroup variant="separated"&gt;
  &lt;PPButton variant="outline"&gt;Action 1&lt;/PPButton&gt;
  &lt;PPButton variant="outline"&gt;Action 2&lt;/PPButton&gt;
  &lt;PPButton variant="outline"&gt;Action 3&lt;/PPButton&gt;
&lt;/PPButtonGroup&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Vertical Group</h3>
          <div class="component-demo">
            <PPButtonGroup vertical>
              <PPButton variant="outline" block>Top</PPButton>
              <PPButton variant="outline" block>Middle</PPButton>
              <PPButton variant="outline" block>Bottom</PPButton>
            </PPButtonGroup>
          </div>
          <pre class="code-block"><code>&lt;PPButtonGroup vertical&gt;
  ...
&lt;/PPButtonGroup&gt;</code></pre>
        </div>
      </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

import { PPButton, PPButtonGroup } from '@phanna/ui-framework';
</script>
