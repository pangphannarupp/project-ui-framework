<template>
<div class="guide-section">
        <h2>5. PPIconButton Variants</h2>
        
        <div class="variant-group" style="background: #f4f5f8; padding: 16px; border-radius: 8px;">
          <h3>Danger</h3>
          <div class="component-demo">
            <PPIconButton color="danger" :icon="trashOutline" />
          </div>
          <pre class="code-block"><code>&lt;PPIconButton color="danger" :icon="trashOutline" /&gt;</code></pre>
        </div>

        <div class="variant-group" style="background: var(--pp-primary, #003399); padding: 16px; border-radius: 8px; color: white;">
          <h3 style="color: white;">White (on dark backgrounds)</h3>
          <div class="component-demo">
            <PPIconButton color="white" badge :icon="notificationsOutline" />
          </div>
          <pre class="code-block"><code>&lt;PPIconButton color="white" badge :icon="notificationsOutline" /&gt;</code></pre>
        </div>

        <div class="variant-group" style="background: #f4f5f8; padding: 16px; border-radius: 8px;">
          <h3>Primary</h3>
          <div class="component-demo">
            <PPIconButton color="primary" :icon="squareOutline" />
          </div>
          <pre class="code-block"><code>&lt;PPIconButton color="primary" :icon="squareOutline" /&gt;</code></pre>
        </div>
      </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';
import { PPIconButton } from '@phanna/ui-framework';
import { trashOutline, notificationsOutline, squareOutline } from 'ionicons/icons';
</script>
