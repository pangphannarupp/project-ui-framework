<template>
<div class="guide-section">
        <h2>2. PPInfoCard Styles</h2>

        <div class="variant-group">
          <h3>Types (Soft Variant Default)</h3>
          <div class="component-demo" style="display: flex; flex-direction: column; gap: 16px;">
            <PPInfoCard type="info">This is an informational message to guide the user.</PPInfoCard>
            <PPInfoCard type="success">Your changes have been saved successfully!</PPInfoCard>
            <PPInfoCard type="warning">Please review your inputs before proceeding.</PPInfoCard>
            <PPInfoCard type="error">There was a problem processing your request.</PPInfoCard>
            <PPInfoCard type="neutral">This is a neutral message for general context.</PPInfoCard>
          </div>
        </div>

        <div class="variant-group">
          <h3>Variants</h3>
          <div class="component-demo" style="display: flex; flex-direction: column; gap: 16px;">
            <PPInfoCard type="info" variant="soft">Soft Variant (Default) - Subtle background</PPInfoCard>
            <PPInfoCard type="info" variant="solid">Solid Variant - High emphasis</PPInfoCard>
            <PPInfoCard type="info" variant="outline">Outline Variant - Border only</PPInfoCard>
            <PPInfoCard type="info" variant="glass">Glass Variant - Frosted glass effect</PPInfoCard>
          </div>
        </div>

        <div class="variant-group">
          <h3>Custom Styles</h3>
          <div class="component-demo">
            <PPInfoCard 
              type="info" 
              backgroundColor="#e8f5e9" 
              textColor="#2e7d32" 
              iconColor="#1b5e20" 
              borderRadius="24px"
            >
              This is a fully customized success info card using explicit style props!
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
