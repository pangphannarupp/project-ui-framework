<template>
<div class="guide-section">
        <h2>16. Skeleton Loading</h2>
        <p class="guide-desc">Beautiful loading placeholders for list and detail views.</p>

        <div class="variant-group">
          <h3>List Skeleton</h3>
          <div class="component-demo">
            <PPSkeletonList :count="3" :avatar="true" />
          </div>
          <pre class="code-block" v-pre><code>&lt;PPSkeletonList :count="3" :avatar="true" /&gt;</code></pre>
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
          <pre class="code-block" v-pre><code>&lt;PPSkeleton :loading="true"&gt;
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
          <pre class="code-block" v-pre><code>&lt;PPSkeletonDetail :paragraphs="2" /&gt;</code></pre>
        </div>
      
        <div class="variant-group">
          <h3>Customizing CSS</h3>
          <p class="custom-guide">You can override the component's appearance globally via CSS variables or by targeting its specific classes.</p>
          <pre class="code-block" v-pre><code>/* Override globally */
:root {
  /* This component does not use CSS variables directly. */
  /* Use custom classes to override styles. */
}

/* Or target specific instances using custom classes */
.my-custom-component {
  /* Add your custom styles */
}</code></pre>
        </div>
</div>
<!-- FULL_SOURCE_CODE_START -->
    <div class="variant-group" style="margin-top: 40px;">
      <h3>Full Page Source Code</h3>
      <p class="custom-guide">Complete source code for this section.</p>
      <pre class="code-block" style="max-height: 500px; overflow-y: auto;" v-pre><code>&lt;template&gt;
&lt;div class="guide-section"&gt;
        &lt;h2&gt;16. Skeleton Loading&lt;/h2&gt;
        &lt;p class="guide-desc"&gt;Beautiful loading placeholders for list and detail views.&lt;/p&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;List Skeleton&lt;/h3&gt;
          &lt;div class="component-demo"&gt;
            &lt;PPSkeletonList :count="3" :avatar="true" /&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPSkeletonList :count="3" :avatar="true" /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group" style="margin-top: 32px;"&gt;
          &lt;h3&gt;Custom Template Skeleton&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;Use &lt;code&gt;&amp;lt;PPSkeleton&amp;gt;&lt;/code&gt; to create your own loading layouts&lt;/p&gt;
          &lt;div class="component-demo"&gt;
            &lt;PPSkeleton :loading="true"&gt;
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
            &lt;/PPSkeleton&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPSkeleton :loading="true"&amp;gt;
  &amp;lt;template #template&amp;gt;
    &amp;lt;div style="display: flex; gap: 16px; align-items: center;"&amp;gt;
      &amp;lt;PPSkeletonItem variant="circle" /&amp;gt;
      &amp;lt;div style="flex: 1; display: flex; flex-direction: column; gap: 8px;"&amp;gt;
        &amp;lt;PPSkeletonItem variant="text" width="60%" /&amp;gt;
        &amp;lt;PPSkeletonItem variant="text" width="80%" /&amp;gt;
        &amp;lt;PPSkeletonItem variant="text" width="40%" /&amp;gt;
      &amp;lt;/div&amp;gt;
    &amp;lt;/div&amp;gt;
  &amp;lt;/template&amp;gt;
&amp;lt;/PPSkeleton&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group" style="margin-top: 32px;"&gt;
          &lt;h3&gt;Detail Skeleton&lt;/h3&gt;
          &lt;div class="component-demo"&gt;
            &lt;PPSkeletonDetail :paragraphs="2" /&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPSkeletonDetail :paragraphs="2" /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;
      
        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Customizing CSS&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;You can override the component's appearance globally via CSS variables or by targeting its specific classes.&lt;/p&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;/* Override globally */
:root {
  /* This component does not use CSS variables directly. */
  /* Use custom classes to override styles. */
}

/* Or target specific instances using custom classes */
.my-custom-component {
  /* Add your custom styles */
}&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;
&lt;/div&gt;
&lt;/template&gt;

&lt;script setup lang="ts"&gt;
import { ref, computed } from 'vue';

import { PPSkeleton, PPSkeletonItem, PPSkeletonList, PPSkeletonDetail } from '@phanna/ui-framework';
&lt;/script&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

import { PPSkeleton, PPSkeletonItem, PPSkeletonList, PPSkeletonDetail } from '@phanna/ui-framework';
</script>
