<template>
<div class="guide-section">
        <h2>16. Skeleton Loading</h2>
        <p class="guide-desc">Beautiful loading placeholders for list and detail views.</p>

        <div class="variant-group">
          <h3>List Skeleton</h3>
          <div class="component-demo">
            <PPSkeletonList :count="3" :avatar="true" />
          </div>
          <pre class="code-block"><code>&lt;PPSkeletonList :count="3" :avatar="true" /&gt;</code></pre>
        </div>

        <div class="variant-group" style="margin-top: 32px;">
          <h3>Custom Template Skeleton</h3>
          <p class="custom-guide">Use <code>&lt;PPSkeleton&gt;</code> to create your own loading layouts</p>
          <div class="component-demo">
            <PPSkeleton :loading="true">
              <template #template>
                <div style="display: flex; gap: 16px; align-items: center;">
                  <PPSkeletonItem variant="circle" />
                  <div style="flex: 1; display: flex; flex-direction: column; gap: 8px;">
                    <PPSkeletonItem variant="text" width="60%" />
                    <PPSkeletonItem variant="text" width="80%" />
                    <PPSkeletonItem variant="text" width="40%" />
                  </div>
                </div>
              </template>
            </PPSkeleton>
          </div>
          <pre class="code-block"><code>&lt;PPSkeleton :loading="true"&gt;
  &lt;template #template&gt;
    &lt;div style="display: flex; gap: 16px; align-items: center;"&gt;
      &lt;PPSkeletonItem variant="circle" /&gt;
      &lt;div style="flex: 1; display: flex; flex-direction: column; gap: 8px;"&gt;
        &lt;PPSkeletonItem variant="text" width="60%" /&gt;
        &lt;PPSkeletonItem variant="text" width="80%" /&gt;
        &lt;PPSkeletonItem variant="text" width="40%" /&gt;
      &lt;/div&gt;
    &lt;/div&gt;
  &lt;/template&gt;
&lt;/PPSkeleton&gt;</code></pre>
        </div>

        <div class="variant-group" style="margin-top: 32px;">
          <h3>Detail Skeleton</h3>
          <div class="component-demo">
            <PPSkeletonDetail :paragraphs="2" />
          </div>
          <pre class="code-block"><code>&lt;PPSkeletonDetail :paragraphs="2" /&gt;</code></pre>
        </div>
      </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

import { PPSkeleton, PPSkeletonItem, PPSkeletonList, PPSkeletonDetail } from '@phanna/ui-framework';
</script>
