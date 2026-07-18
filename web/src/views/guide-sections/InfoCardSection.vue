<template>
<div class="guide-section">
        <h2>2. BizInfoCard Variants</h2>
        
        <div class="variant-group">
          <h3>Warning Type</h3>
          <div class="component-demo">
            <BizInfoCard type="warning">This is a warning alert!</BizInfoCard>
          </div>
          <pre class="code-block"><code>&lt;BizInfoCard type="warning"&gt;This is a warning alert!&lt;/BizInfoCard&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Info Type (Default)</h3>
          <div class="component-demo">
            <BizInfoCard type="info">This is a general information card.</BizInfoCard>
          </div>
          <pre class="code-block"><code>&lt;BizInfoCard type="info"&gt;This is a general info card.&lt;/BizInfoCard&gt;</code></pre>
        </div>
      </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

import { BizInfoCard } from '@phanna/ui-framework';
</script>
