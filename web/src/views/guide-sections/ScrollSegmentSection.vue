<template>
  <div class="guide-section">
    <h2>Scroll Segment</h2>
    <p>A horizontally scrollable segment control for navigating between many categories.</p>

    <h3>Basic Usage</h3>
    <div class="demo-box">
      <PPScrollSegment v-model="activeTab">
        <PPScrollSegmentButton value="tab1">Overview</PPScrollSegmentButton>
        <PPScrollSegmentButton value="tab2">Analytics</PPScrollSegmentButton>
        <PPScrollSegmentButton value="tab3">Reports</PPScrollSegmentButton>
        <PPScrollSegmentButton value="tab4">Notifications</PPScrollSegmentButton>
        <PPScrollSegmentButton value="tab5">Settings</PPScrollSegmentButton>
        <PPScrollSegmentButton value="tab6">Billing</PPScrollSegmentButton>
        <PPScrollSegmentButton value="tab7">Team</PPScrollSegmentButton>
      </PPScrollSegment>
      
      <div style="margin-top: 16px; padding: 16px; background: white; border-radius: 8px;">
        Currently viewing: <strong>{{ activeTab }}</strong>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { PPScrollSegment, PPScrollSegmentButton } from '@phanna/ui-framework';

const activeTab = ref('tab1');
</script>

<style scoped>
.guide-section { display: flex; flex-direction: column; gap: 24px; }
.demo-box { border: 1px solid #e5e7eb; border-radius: 8px; padding: 24px; background: #f9fafb; }
</style>
