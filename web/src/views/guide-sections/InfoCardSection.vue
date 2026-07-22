<template>
<div class="guide-section">
        <h2>2. PPInfoCard Variants</h2>
        
        <div class="variant-group">
          <h3>Warning Type</h3>
          <div class="component-demo">
            <PPInfoCard type="warning">This is a warning alert!</PPInfoCard>
          </div>
          <pre class="code-block"><code>&lt;PPInfoCard type="warning"&gt;This is a warning alert!&lt;/PPInfoCard&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Info Type (Default)</h3>
          <div class="component-demo">
            <PPInfoCard type="info">This is a general information card.</PPInfoCard>
          </div>
          <pre class="code-block"><code>&lt;PPInfoCard type="info"&gt;This is a general info card.&lt;/PPInfoCard&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Custom Style</h3>
          <div class="component-demo">
            <PPInfoCard 
              type="info" 
              backgroundColor="#e8f5e9" 
              textColor="#2e7d32" 
              iconColor="#1b5e20" 
              borderRadius="24px"
            >
              This is a fully customized success info card!
            </PPInfoCard>
          </div>
          <pre class="code-block"><code>&lt;PPInfoCard 
  type="info" 
  backgroundColor="#e8f5e9" 
  textColor="#2e7d32" 
  iconColor="#1b5e20" 
  borderRadius="24px"
&gt;
  This is a fully customized success info card!
&lt;/PPInfoCard&gt;</code></pre>
        </div>
      </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

import { PPInfoCard } from '@phanna/ui-framework';
</script>
