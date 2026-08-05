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
      <pre class="code-block" v-pre><code>&lt;PPTimeline direction="vertical"&gt;
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
      <pre class="code-block" v-pre><code>&lt;PPTimeline direction="horizontal"&gt;
  &lt;PPTimelineItem timestamp="Step 1" type="success"&gt;
    &lt;p&gt;Approval&lt;/p&gt;
  &lt;/PPTimelineItem&gt;
&lt;/PPTimeline&gt;</code></pre>
    </div>

    <div class="demo-box">
      <h3>Alternate Layout & Hollow Nodes</h3>
      <p class="helper-text">Alternating sides with hollow variant and dashed lines for pending events. (Reload to see the animation)</p>
      <div class="demo-content">
        <PPTimeline direction="vertical" align="alternate" animated>
          <PPTimelineItem timestamp="2023-04-12" type="primary" variant="hollow">
            <h4>Created</h4>
            <p>Order created successfully.</p>
          </PPTimelineItem>
          
          <PPTimelineItem timestamp="2023-04-13" type="success" variant="hollow">
            <h4>Processed</h4>
            <p>Order is being processed.</p>
          </PPTimelineItem>

          <PPTimelineItem timestamp="2023-04-14" type="warning" variant="hollow" active>
            <h4>Shipped</h4>
            <p>Order has been shipped.</p>
          </PPTimelineItem>
          
          <PPTimelineItem timestamp="Pending" type="info" variant="hollow" dashed>
            <h4>Delivered</h4>
            <p>Awaiting delivery.</p>
          </PPTimelineItem>
        </PPTimeline>
      </div>
      <pre class="code-block" v-pre><code>&lt;PPTimeline direction="vertical" align="alternate" animated&gt;
  &lt;PPTimelineItem variant="hollow"&gt;...&lt;/PPTimelineItem&gt;
  &lt;PPTimelineItem variant="hollow" active&gt;...&lt;/PPTimelineItem&gt;
  &lt;PPTimelineItem variant="hollow" dashed&gt;...&lt;/PPTimelineItem&gt;
&lt;/PPTimeline&gt;</code></pre>

      <h3>Custom Icon Timeline</h3>
      <p class="helper-text">Use the <code>#icon</code> slot to replace the standard dot.</p>
      <div class="demo-content">
        <PPTimeline direction="vertical">
          <PPTimelineItem type="success" size="large">
            <template #icon>
              <div style="background: #4caf50; border-radius: 50%; width: 24px; height: 24px; display: flex; align-items: center; justify-content: center; color: white;">✓</div>
            </template>
            <h4>Step 1 Complete</h4>
          </PPTimelineItem>
          <PPTimelineItem type="primary" dashed>
            <template #icon>
              <div style="background: white; border: 2px solid #1a2a5e; border-radius: 50%; width: 20px; height: 20px; display: flex; align-items: center; justify-content: center; color: #1a2a5e; font-size: 12px; font-weight: bold;">2</div>
            </template>
            <h4>Step 2 In Progress</h4>
          </PPTimelineItem>
        </PPTimeline>
      </div>
      <pre class="code-block" v-pre><code>&lt;PPTimeline direction="vertical"&gt;
  &lt;PPTimelineItem type="success" size="large"&gt;
    &lt;template #icon&gt;
      &lt;div&gt;✓&lt;/div&gt;
    &lt;/template&gt;
    &lt;h4&gt;Step 1 Complete&lt;/h4&gt;
  &lt;/PPTimelineItem&gt;
&lt;/PPTimeline&gt;</code></pre>
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
  &lt;div class="component-section"&gt;
    &lt;h2&gt;Timeline&lt;/h2&gt;
    &lt;p&gt;A component for displaying a list of events in chronological order.&lt;/p&gt;

    &lt;div class="demo-box"&gt;
      &lt;h3&gt;Vertical Timeline&lt;/h3&gt;
      &lt;div class="demo-content"&gt;
        &lt;PPTimeline direction="vertical"&gt;
          &lt;PPTimelineItem 
            timestamp="2023-04-12" 
            timestampPlacement="top"
            type="primary"
          &gt;
            &lt;h4&gt;Created&lt;/h4&gt;
            &lt;p&gt;Order has been created successfully.&lt;/p&gt;
          &lt;/PPTimelineItem&gt;
          
          &lt;PPTimelineItem 
            timestamp="2023-04-13" 
            type="success"
            size="large"
          &gt;
            &lt;h4&gt;Processed&lt;/h4&gt;
            &lt;p&gt;Order is being processed.&lt;/p&gt;
          &lt;/PPTimelineItem&gt;

          &lt;PPTimelineItem 
            timestamp="2023-04-14" 
            type="warning"
          &gt;
            &lt;h4&gt;Shipped&lt;/h4&gt;
            &lt;p&gt;Order has been shipped.&lt;/p&gt;
          &lt;/PPTimelineItem&gt;
        &lt;/PPTimeline&gt;
      &lt;/div&gt;
      &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPTimeline direction="vertical"&amp;gt;
  &amp;lt;PPTimelineItem timestamp="2023-04-12" timestampPlacement="top" type="primary"&amp;gt;
    &amp;lt;h4&amp;gt;Created&amp;lt;/h4&amp;gt;
    &amp;lt;p&amp;gt;Order has been created successfully.&amp;lt;/p&amp;gt;
  &amp;lt;/PPTimelineItem&amp;gt;
&amp;lt;/PPTimeline&amp;gt;&lt;/code&gt;&lt;/pre&gt;

      &lt;h3&gt;Horizontal Timeline&lt;/h3&gt;
      &lt;div class="demo-content"&gt;
        &lt;PPTimeline direction="horizontal"&gt;
          &lt;PPTimelineItem 
            timestamp="Step 1" 
            type="success"
          &gt;
            &lt;p&gt;Approval&lt;/p&gt;
          &lt;/PPTimelineItem&gt;
          
          &lt;PPTimelineItem 
            timestamp="Step 2" 
            type="primary"
          &gt;
            &lt;p&gt;Processing&lt;/p&gt;
          &lt;/PPTimelineItem&gt;

          &lt;PPTimelineItem 
            timestamp="Step 3" 
            type="info"
          &gt;
            &lt;p&gt;Done&lt;/p&gt;
          &lt;/PPTimelineItem&gt;
        &lt;/PPTimeline&gt;
      &lt;/div&gt;
      &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPTimeline direction="horizontal"&amp;gt;
  &amp;lt;PPTimelineItem timestamp="Step 1" type="success"&amp;gt;
    &amp;lt;p&amp;gt;Approval&amp;lt;/p&amp;gt;
  &amp;lt;/PPTimelineItem&amp;gt;
&amp;lt;/PPTimeline&amp;gt;&lt;/code&gt;&lt;/pre&gt;
    &lt;/div&gt;

    &lt;div class="demo-box"&gt;
      &lt;h3&gt;Alternate Layout &amp; Hollow Nodes&lt;/h3&gt;
      &lt;p class="helper-text"&gt;Alternating sides with hollow variant and dashed lines for pending events. (Reload to see the animation)&lt;/p&gt;
      &lt;div class="demo-content"&gt;
        &lt;PPTimeline direction="vertical" align="alternate" animated&gt;
          &lt;PPTimelineItem timestamp="2023-04-12" type="primary" variant="hollow"&gt;
            &lt;h4&gt;Created&lt;/h4&gt;
            &lt;p&gt;Order created successfully.&lt;/p&gt;
          &lt;/PPTimelineItem&gt;
          
          &lt;PPTimelineItem timestamp="2023-04-13" type="success" variant="hollow"&gt;
            &lt;h4&gt;Processed&lt;/h4&gt;
            &lt;p&gt;Order is being processed.&lt;/p&gt;
          &lt;/PPTimelineItem&gt;

          &lt;PPTimelineItem timestamp="2023-04-14" type="warning" variant="hollow" active&gt;
            &lt;h4&gt;Shipped&lt;/h4&gt;
            &lt;p&gt;Order has been shipped.&lt;/p&gt;
          &lt;/PPTimelineItem&gt;
          
          &lt;PPTimelineItem timestamp="Pending" type="info" variant="hollow" dashed&gt;
            &lt;h4&gt;Delivered&lt;/h4&gt;
            &lt;p&gt;Awaiting delivery.&lt;/p&gt;
          &lt;/PPTimelineItem&gt;
        &lt;/PPTimeline&gt;
      &lt;/div&gt;
      &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPTimeline direction="vertical" align="alternate" animated&amp;gt;
  &amp;lt;PPTimelineItem variant="hollow"&amp;gt;...&amp;lt;/PPTimelineItem&amp;gt;
  &amp;lt;PPTimelineItem variant="hollow" active&amp;gt;...&amp;lt;/PPTimelineItem&amp;gt;
  &amp;lt;PPTimelineItem variant="hollow" dashed&amp;gt;...&amp;lt;/PPTimelineItem&amp;gt;
&amp;lt;/PPTimeline&amp;gt;&lt;/code&gt;&lt;/pre&gt;

      &lt;h3&gt;Custom Icon Timeline&lt;/h3&gt;
      &lt;p class="helper-text"&gt;Use the &lt;code&gt;#icon&lt;/code&gt; slot to replace the standard dot.&lt;/p&gt;
      &lt;div class="demo-content"&gt;
        &lt;PPTimeline direction="vertical"&gt;
          &lt;PPTimelineItem type="success" size="large"&gt;
            &lt;template #icon&gt;
              &lt;div style="background: #4caf50; border-radius: 50%; width: 24px; height: 24px; display: flex; align-items: center; justify-content: center; color: white;"&gt;✓&lt;/div&gt;
            &lt;/template&gt;
            &lt;h4&gt;Step 1 Complete&lt;/h4&gt;
          &lt;/PPTimelineItem&gt;
          &lt;PPTimelineItem type="primary" dashed&gt;
            &lt;template #icon&gt;
              &lt;div style="background: white; border: 2px solid #1a2a5e; border-radius: 50%; width: 20px; height: 20px; display: flex; align-items: center; justify-content: center; color: #1a2a5e; font-size: 12px; font-weight: bold;"&gt;2&lt;/div&gt;
            &lt;/template&gt;
            &lt;h4&gt;Step 2 In Progress&lt;/h4&gt;
          &lt;/PPTimelineItem&gt;
        &lt;/PPTimeline&gt;
      &lt;/div&gt;
      &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPTimeline direction="vertical"&amp;gt;
  &amp;lt;PPTimelineItem type="success" size="large"&amp;gt;
    &amp;lt;template #icon&amp;gt;
      &amp;lt;div&amp;gt;✓&amp;lt;/div&amp;gt;
    &amp;lt;/template&amp;gt;
    &amp;lt;h4&amp;gt;Step 1 Complete&amp;lt;/h4&amp;gt;
  &amp;lt;/PPTimelineItem&amp;gt;
&amp;lt;/PPTimeline&amp;gt;&lt;/code&gt;&lt;/pre&gt;
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
import { PPTimeline, PPTimelineItem } from '@phanna/ui-framework';
&lt;/script&gt;

&lt;style scoped&gt;
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
&lt;/style&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
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
