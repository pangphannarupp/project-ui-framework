<template>
  <div class="component-section">
    <h2>Timeline</h2>
    <p>A component for displaying a list of events in chronological order.</p>

    <div class="demo-box">
      <h3>Vertical Timeline</h3>
      <div class="demo-content">
        <PPTimeline direction="vertical">
          <PPTimelineItem 
            timestamp="2023-04-12" 
            timestampPlacement="top"
            type="primary"
          >
            <h4>Created</h4>
            <p>Order has been created successfully.</p>
          </PPTimelineItem>
          
          <PPTimelineItem 
            timestamp="2023-04-13" 
            type="success"
            size="large"
          >
            <h4>Processed</h4>
            <p>Order is being processed.</p>
          </PPTimelineItem>

          <PPTimelineItem 
            timestamp="2023-04-14" 
            type="warning"
          >
            <h4>Shipped</h4>
            <p>Order has been shipped.</p>
          </PPTimelineItem>
        </PPTimeline>
      </div>
      <pre class="code-block"><code>&lt;PPTimeline direction="vertical"&gt;
  &lt;PPTimelineItem timestamp="2023-04-12" timestampPlacement="top" type="primary"&gt;
    &lt;h4&gt;Created&lt;/h4&gt;
    &lt;p&gt;Order has been created successfully.&lt;/p&gt;
  &lt;/PPTimelineItem&gt;
&lt;/PPTimeline&gt;</code></pre>

      <h3>Horizontal Timeline</h3>
      <div class="demo-content">
        <PPTimeline direction="horizontal">
          <PPTimelineItem 
            timestamp="Step 1" 
            type="success"
          >
            <p>Approval</p>
          </PPTimelineItem>
          
          <PPTimelineItem 
            timestamp="Step 2" 
            type="primary"
          >
            <p>Processing</p>
          </PPTimelineItem>

          <PPTimelineItem 
            timestamp="Step 3" 
            type="info"
          >
            <p>Done</p>
          </PPTimelineItem>
        </PPTimeline>
      </div>
      <pre class="code-block"><code>&lt;PPTimeline direction="horizontal"&gt;
  &lt;PPTimelineItem timestamp="Step 1" type="success"&gt;
    &lt;p&gt;Approval&lt;/p&gt;
  &lt;/PPTimelineItem&gt;
&lt;/PPTimeline&gt;</code></pre>
    </div>
  </div>
</template>

<script setup lang="ts">
import { PPTimeline, PPTimelineItem } from '@phanna/ui-framework';
</script>

<style scoped>
.demo-box {
  border: 1px solid #e0e0e0;
  border-radius: 8px;
  padding: 24px;
  margin-top: 16px;
  background: white;
}
.demo-content {
  margin-bottom: 24px;
  padding: 16px;
  background: #f9f9f9;
  border-radius: 4px;
}
h4 {
  margin: 0 0 4px 0;
  font-size: 14px;
  font-weight: 600;
  color: #1a2a5e;
}
p {
  margin: 0;
  color: #666;
  font-size: 13px;
}
</style>
