<template>
<div class="guide-section">
        <h2>16. Skeleton Loading</h2>
        <p class="guide-desc">Beautiful loading placeholders for list and detail views.</p>

        <div class="variant-group">
          <h3>List Skeleton</h3>
          <BizSkeletonList :count="3" :avatar="true" />
        </div>

        <div class="variant-group" style="margin-top: 32px;">
          <h3>Custom Template Skeleton</h3>
          <p class="custom-guide">Use <code>&lt;BizSkeleton&gt;</code> to create your own loading layouts</p>
          <BizSkeleton :loading="true">
            <template #template>
              <div style="display: flex; gap: 16px; align-items: center;">
                <BizSkeletonItem variant="circle" />
                <div style="flex: 1; display: flex; flex-direction: column; gap: 8px;">
                  <BizSkeletonItem variant="text" width="60%" />
                  <BizSkeletonItem variant="text" width="80%" />
                  <BizSkeletonItem variant="text" width="40%" />
                </div>
              </div>
            </template>
          </BizSkeleton>
        </div>

        <div class="variant-group" style="margin-top: 32px;">
          <h3>Detail Skeleton</h3>
          <BizSkeletonDetail :paragraphs="2" />
        </div>
      </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

import { BizSkeleton, BizSkeletonItem, BizSkeletonList, BizSkeletonDetail } from '@phanna/ui-framework';
</script>
