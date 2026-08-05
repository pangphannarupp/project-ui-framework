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
          <pre class="code-block" v-pre><code>&lt;PPScrollSegment&gt;
  &lt;PPScrollSegmentButton :isActive="true"&gt;All (20)&lt;/PPScrollSegmentButton&gt;
  &lt;PPScrollSegmentButton&gt;Unread (5)&lt;/PPScrollSegmentButton&gt;
&lt;/PPScrollSegment&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>PPNotificationItem</h3>
          <div class="component-demo" style="background: #f4f5f8; padding: 20px; border-radius: 12px;">
            <div style="background: white; border-radius: 12px; overflow: hidden; box-shadow: 0 4px 12px rgba(0,0,0,0.05); max-width: 400px;">
              <PPNotificationItem 
                title="The Bank" 
                description="Set up fast payments now, easy transfer, and payment anytime, anywhere. Scan KHQR..." 
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
        &lt;h2&gt;Notifications &amp; Scrolling&lt;/h2&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;PPScrollSegment&lt;/h3&gt;
          &lt;div class="component-demo" style="background: #f4f5f8; padding: 20px; border-radius: 12px; max-width: 400px;"&gt;
            &lt;PPScrollSegment&gt;
              &lt;PPScrollSegmentButton :isActive="true"&gt;All (20)&lt;/PPScrollSegmentButton&gt;
              &lt;PPScrollSegmentButton&gt;Unread (5)&lt;/PPScrollSegmentButton&gt;
              &lt;PPScrollSegmentButton&gt;Payments (2)&lt;/PPScrollSegmentButton&gt;
              &lt;PPScrollSegmentButton&gt;Announcements (13)&lt;/PPScrollSegmentButton&gt;
              &lt;PPScrollSegmentButton&gt;Security (0)&lt;/PPScrollSegmentButton&gt;
            &lt;/PPScrollSegment&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPScrollSegment&amp;gt;
  &amp;lt;PPScrollSegmentButton :isActive="true"&amp;gt;All (20)&amp;lt;/PPScrollSegmentButton&amp;gt;
  &amp;lt;PPScrollSegmentButton&amp;gt;Unread (5)&amp;lt;/PPScrollSegmentButton&amp;gt;
&amp;lt;/PPScrollSegment&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;PPNotificationItem&lt;/h3&gt;
          &lt;div class="component-demo" style="background: #f4f5f8; padding: 20px; border-radius: 12px;"&gt;
            &lt;div style="background: white; border-radius: 12px; overflow: hidden; box-shadow: 0 4px 12px rgba(0,0,0,0.05); max-width: 400px;"&gt;
              &lt;PPNotificationItem 
                title="The Bank" 
                description="Set up fast payments now, easy transfer, and payment anytime, anywhere. Scan KHQR..." 
                timestamp="29 SEP, 2026 7:41:42 PM" 
                :unread="true"
              &gt;
                &lt;template #icon&gt;
                  &lt;svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"&gt;&lt;path d="M11 5L6 9H2v6h4l5 4V5z"/&gt;&lt;path d="M19.07 4.93a10 10 0 0 1 0 14.14M15.54 8.46a5 5 0 0 1 0 7.07"/&gt;&lt;/svg&gt;
                &lt;/template&gt;
              &lt;/PPNotificationItem&gt;

              &lt;PPNotificationItem 
                title="Account" 
                description="242.50 USD is deposited into 00100 001 0005517." 
                timestamp="02 SEP, 2026 8:12:12 AM"
              &gt;
                &lt;template #icon&gt;
                  &lt;svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"&gt;&lt;rect x="2" y="5" width="20" height="14" rx="2"/&gt;&lt;path d="M12 12h.01"/&gt;&lt;path d="M16 12h.01"/&gt;&lt;path d="M8 12h.01"/&gt;&lt;/svg&gt;
                &lt;/template&gt;
              &lt;/PPNotificationItem&gt;
            &lt;/div&gt;
          &lt;/div&gt;
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

import { PPScrollSegment, PPScrollSegmentButton, PPNotificationItem } from '@phanna/ui-framework';
&lt;/script&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

import { PPScrollSegment, PPScrollSegmentButton, PPNotificationItem } from '@phanna/ui-framework';
</script>
