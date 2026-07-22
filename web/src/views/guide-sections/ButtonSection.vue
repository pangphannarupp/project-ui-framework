<template>
<div class="guide-section">
        <h2>1. PPButton Variants</h2>
        
        <div class="variant-group">
          <h3>Primary</h3>
          <div class="component-demo">
            <PPButton variant="primary" block>Primary Button</PPButton>
          </div>
          <pre class="code-block"><code>&lt;PPButton variant="primary" block&gt;Primary&lt;/PPButton&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Secondary</h3>
          <div class="component-demo">
            <PPButton variant="secondary" block>Secondary Button</PPButton>
          </div>
          <pre class="code-block"><code>&lt;PPButton variant="secondary" block&gt;Secondary&lt;/PPButton&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Danger</h3>
          <div class="component-demo">
            <PPButton block>Show Error Notification</PPButton>
          </div>
          <pre class="code-block"><code>&lt;PPButton variant="danger" block&gt;Danger&lt;/PPButton&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Outline</h3>
          <div class="component-demo">
            <PPButton variant="outline" block>Outline Button</PPButton>
          </div>
          <pre class="code-block"><code>&lt;PPButton variant="outline" block&gt;Outline&lt;/PPButton&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Disabled State</h3>
          <div class="component-demo">
            <PPButton variant="primary" block disabled>Disabled Button</PPButton>
          </div>
          <pre class="code-block"><code>&lt;PPButton variant="primary" block disabled&gt;Disabled&lt;/PPButton&gt;</code></pre>
        </div>
      </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

import { PPButton } from '@phanna/ui-framework';
</script>
