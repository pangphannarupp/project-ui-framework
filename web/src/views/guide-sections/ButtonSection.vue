<template>
<div class="guide-section">
        <h2>1. BizButton Variants</h2>
        
        <div class="variant-group">
          <h3>Primary</h3>
          <div class="component-demo">
            <BizButton variant="primary" block>Primary Button</BizButton>
          </div>
          <pre class="code-block"><code>&lt;BizButton variant="primary" block&gt;Primary&lt;/BizButton&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Secondary</h3>
          <div class="component-demo">
            <BizButton variant="secondary" block>Secondary Button</BizButton>
          </div>
          <pre class="code-block"><code>&lt;BizButton variant="secondary" block&gt;Secondary&lt;/BizButton&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Danger</h3>
          <div class="component-demo">
            <BizButton block>Show Error Notification</BizButton>
          </div>
          <pre class="code-block"><code>&lt;BizButton variant="danger" block&gt;Danger&lt;/BizButton&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Outline</h3>
          <div class="component-demo">
            <BizButton variant="outline" block>Outline Button</BizButton>
          </div>
          <pre class="code-block"><code>&lt;BizButton variant="outline" block&gt;Outline&lt;/BizButton&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Disabled State</h3>
          <div class="component-demo">
            <BizButton variant="primary" block disabled>Disabled Button</BizButton>
          </div>
          <pre class="code-block"><code>&lt;BizButton variant="primary" block disabled&gt;Disabled&lt;/BizButton&gt;</code></pre>
        </div>
      </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

import { BizButton } from '@phanna/ui-framework';
</script>
