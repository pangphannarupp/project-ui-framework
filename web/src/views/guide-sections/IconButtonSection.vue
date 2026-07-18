<template>
<div class="guide-section">
        <h2>5. BizIconButton Variants</h2>
        
        <div class="variant-group" style="background: #f4f5f8; padding: 16px; border-radius: 8px;">
          <h3>Danger</h3>
          <div class="component-demo">
            <BizIconButton color="danger">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle></svg>
            </BizIconButton>
          </div>
          <pre class="code-block"><code>&lt;BizIconButton color="danger"&gt;...&lt;/BizIconButton&gt;</code></pre>
        </div>

        <div class="variant-group" style="background: var(--biz-primary, #003399); padding: 16px; border-radius: 8px; color: white;">
          <h3 style="color: white;">White (on dark backgrounds)</h3>
          <div class="component-demo">
            <BizIconButton color="white" badge>
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"></path></svg>
            </BizIconButton>
          </div>
          <pre class="code-block"><code>&lt;BizIconButton color="white" badge&gt;...&lt;/BizIconButton&gt;</code></pre>
        </div>

        <div class="variant-group" style="background: #f4f5f8; padding: 16px; border-radius: 8px;">
          <h3>Primary</h3>
          <div class="component-demo">
            <BizIconButton color="primary">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect></svg>
            </BizIconButton>
          </div>
          <pre class="code-block"><code>&lt;BizIconButton color="primary"&gt;...&lt;/BizIconButton&gt;</code></pre>
        </div>
      </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';
</script>
