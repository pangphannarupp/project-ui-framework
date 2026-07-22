<template>
<div class="guide-section">
        <h2>1.5 Button Group</h2>

        <div class="variant-group">
          <h3>Horizontal Group</h3>
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
