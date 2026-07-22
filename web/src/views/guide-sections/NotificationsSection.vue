<template>
<div class="guide-section">
        <h2>Notifications & Scrolling</h2>

        <div class="variant-group">
          <h3>PPScrollSegment</h3>
          <div class="component-demo" style="background: #f4f5f8; padding: 20px; border-radius: 12px; max-width: 400px;">
            <PPScrollSegment>
              <PPScrollSegmentButton :isActive="true">All (20)</PPScrollSegmentButton>
              <PPScrollSegmentButton>Unread (5)</PPScrollSegmentButton>
              <PPScrollSegmentButton>Payments (2)</PPScrollSegmentButton>
              <PPScrollSegmentButton>Announcements (13)</PPScrollSegmentButton>
              <PPScrollSegmentButton>Security (0)</PPScrollSegmentButton>
            </PPScrollSegment>
          </div>
          <pre class="code-block"><code>&lt;PPScrollSegment&gt;
  &lt;PPScrollSegmentButton :isActive="true"&gt;All (20)&lt;/PPScrollSegmentButton&gt;
  &lt;PPScrollSegmentButton&gt;Unread (5)&lt;/PPScrollSegmentButton&gt;
&lt;/PPScrollSegment&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>PPNotificationItem</h3>
          <div class="component-demo" style="background: #f4f5f8; padding: 20px; border-radius: 12px;">
            <div style="background: white; border-radius: 12px; overflow: hidden; box-shadow: 0 4px 12px rgba(0,0,0,0.05); max-width: 400px;">
              <PPNotificationItem 
                title="PPCBank" 
                description="Set up smartPay now, easy transfer, and payment anytime, anywhere. Scan KHQR..." 
                timestamp="29 SEP, 2026 7:41:42 PM" 
                :unread="true"
              >
                <template #icon>
                  <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M11 5L6 9H2v6h4l5 4V5z"/><path d="M19.07 4.93a10 10 0 0 1 0 14.14M15.54 8.46a5 5 0 0 1 0 7.07"/></svg>
                </template>
              </PPNotificationItem>

              <PPNotificationItem 
                title="Account" 
                description="242.50 USD is deposited into 00100 001 0005517." 
                timestamp="02 SEP, 2026 8:12:12 AM"
              >
                <template #icon>
                  <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="2" y="5" width="20" height="14" rx="2"/><path d="M12 12h.01"/><path d="M16 12h.01"/><path d="M8 12h.01"/></svg>
                </template>
              </PPNotificationItem>
            </div>
          </div>
        </div>
      </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

import { PPScrollSegment, PPScrollSegmentButton, PPNotificationItem } from '@phanna/ui-framework';
</script>
