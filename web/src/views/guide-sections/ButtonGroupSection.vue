<template>
<div class="guide-section">
        <h2>1.5 Button Group</h2>

        <div class="variant-group">
          <h3>Horizontal Group</h3>
          <div class="component-demo">
            <BizButtonGroup>
              <BizButton variant="outline">Left</BizButton>
              <BizButton variant="outline">Middle</BizButton>
              <BizButton variant="outline">Right</BizButton>
            </BizButtonGroup>
          </div>
          <pre class="code-block"><code>&lt;BizButtonGroup&gt;
  &lt;BizButton variant="outline"&gt;Left&lt;/BizButton&gt;
  &lt;BizButton variant="outline"&gt;Middle&lt;/BizButton&gt;
  &lt;BizButton variant="outline"&gt;Right&lt;/BizButton&gt;
&lt;/BizButtonGroup&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Vertical Group</h3>
          <div class="component-demo">
            <BizButtonGroup vertical>
              <BizButton variant="outline" block>Top</BizButton>
              <BizButton variant="outline" block>Middle</BizButton>
              <BizButton variant="outline" block>Bottom</BizButton>
            </BizButtonGroup>
          </div>
          <pre class="code-block"><code>&lt;BizButtonGroup vertical&gt;
  ...
&lt;/BizButtonGroup&gt;</code></pre>
        </div>
      </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

import { BizButton, BizButtonGroup } from '@phanna/ui-framework';
</script>
