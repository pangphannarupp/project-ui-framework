<template>
  <div class="history-tab">
    <div class="history-top-nav">
      <PPSegment v-model="historyType" variant="pill" style="--pp-segment-bg: white; --pp-segment-btn-active-bg: var(--smart-green); --pp-segment-btn-active-color: white;">
        <PPSegmentButton value="Mobile">Mobile</PPSegmentButton>
        <PPSegmentButton value="Wi-Fi">Wi-Fi</PPSegmentButton>
      </PPSegment>
    </div>

    <div class="history-sub-nav" v-if="historyType === 'Mobile'">
       <PPSegment v-model="mobileSubType" variant="block" style="--pp-background-alt: transparent; --pp-segment-bg: transparent; --pp-segment-btn-active-bg: var(--smart-green); --pp-segment-btn-active-color: white;">
          <PPSegmentButton value="Plan">Plan</PPSegmentButton>
          <PPSegmentButton value="Add-on">Add-on</PPSegmentButton>
          <PPSegmentButton value="e-SIM">e-SIM</PPSegmentButton>
       </PPSegment>
    </div>

    <div class="history-sub-nav" v-if="historyType === 'Wi-Fi'">
       <PPSegment v-model="wifiSubType" variant="block" style="--pp-background-alt: transparent; --pp-segment-bg: transparent; --pp-segment-btn-active-bg: var(--smart-green); --pp-segment-btn-active-color: white;">
          <PPSegmentButton value="Smart Fiber+">Smart Fiber+</PPSegmentButton>
          <PPSegmentButton value="Smart@Home">Smart@Home</PPSegmentButton>
       </PPSegment>
    </div>

    <HistoryEmptyState />
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { PPSegment, PPSegmentButton } from '@phanna/ui-framework';
import HistoryEmptyState from './components/HistoryEmptyState.vue';

const historyType = ref('Mobile');
const mobileSubType = ref('Plan');
const wifiSubType = ref('Smart Fiber+');
</script>

<style scoped>
.history-tab {
  display: flex;
  flex-direction: column;
  padding: 1rem;
}

.history-top-nav {
  margin-bottom: 1rem;
}

.history-sub-nav {
  margin-bottom: 2rem;
}
</style>
