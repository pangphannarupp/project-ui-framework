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

    <pre class="code-block" v-pre><code>&lt;PPScrollSegment v-model="activeTab"&gt;
  &lt;PPScrollSegmentButton value="tab1"&gt;Overview&lt;/PPScrollSegmentButton&gt;
  &lt;PPScrollSegmentButton value="tab2"&gt;Analytics&lt;/PPScrollSegmentButton&gt;
  &lt;PPScrollSegmentButton value="tab3"&gt;Reports&lt;/PPScrollSegmentButton&gt;
  &lt;!-- Add as many tabs as you need --&gt;
&lt;/PPScrollSegment&gt;</code></pre>
  
        <div class="variant-group">
          <h3>Customizing CSS</h3>
          <p class="custom-guide">You can override the component's appearance globally via CSS variables or by targeting its specific classes.</p>
          <pre class="code-block" v-pre><code>/* Override globally */
:root {
  --pp-background-alt: /* value */;
  --pp-border-color: /* value */;
  --pp-primary-variant: /* value */;
  --pp-scroll-segment-bg: /* value */;
  --pp-scroll-segment-border-radius: /* value */;
  --pp-scroll-segment-btn-active-bg: /* value */;
  --pp-scroll-segment-btn-active-border-color: /* value */;
  --pp-scroll-segment-btn-active-color: /* value */;
  --pp-scroll-segment-btn-bg: /* value */;
  --pp-scroll-segment-btn-border-color: /* value */;
  --pp-scroll-segment-btn-color: /* value */;
  --pp-scroll-segment-btn-font-size: /* value */;
  --pp-scroll-segment-btn-padding: /* value */;
  --pp-scroll-segment-btn-radius: /* value */;
  --pp-scroll-segment-btn-shadow: /* value */;
  --pp-scroll-segment-gap: /* value */;
  --pp-scroll-segment-margin-bottom: /* value */;
  --pp-scroll-segment-padding: /* value */;
  --pp-segment-bg: /* value */;
  --pp-segment-border-color: /* value */;
  --pp-segment-btn-active-bg: /* value */;
  --pp-segment-btn-active-shadow: /* value */;
  --pp-segment-padding: /* value */;
  --pp-segment-radius: /* value */;
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
    &lt;h2&gt;Scroll Segment&lt;/h2&gt;
    &lt;p&gt;A horizontally scrollable segment control for navigating between many categories.&lt;/p&gt;

    &lt;h3&gt;Basic Usage&lt;/h3&gt;
    &lt;div class="demo-box"&gt;
      &lt;PPScrollSegment v-model="activeTab"&gt;
        &lt;PPScrollSegmentButton value="tab1"&gt;Overview&lt;/PPScrollSegmentButton&gt;
        &lt;PPScrollSegmentButton value="tab2"&gt;Analytics&lt;/PPScrollSegmentButton&gt;
        &lt;PPScrollSegmentButton value="tab3"&gt;Reports&lt;/PPScrollSegmentButton&gt;
        &lt;PPScrollSegmentButton value="tab4"&gt;Notifications&lt;/PPScrollSegmentButton&gt;
        &lt;PPScrollSegmentButton value="tab5"&gt;Settings&lt;/PPScrollSegmentButton&gt;
        &lt;PPScrollSegmentButton value="tab6"&gt;Billing&lt;/PPScrollSegmentButton&gt;
        &lt;PPScrollSegmentButton value="tab7"&gt;Team&lt;/PPScrollSegmentButton&gt;
      &lt;/PPScrollSegment&gt;
      
      &lt;div style="margin-top: 16px; padding: 16px; background: white; border-radius: 8px;"&gt;
        Currently viewing: &lt;strong&gt;{{ activeTab }}&lt;/strong&gt;
      &lt;/div&gt;
    &lt;/div&gt;

    &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPScrollSegment v-model="activeTab"&amp;gt;
  &amp;lt;PPScrollSegmentButton value="tab1"&amp;gt;Overview&amp;lt;/PPScrollSegmentButton&amp;gt;
  &amp;lt;PPScrollSegmentButton value="tab2"&amp;gt;Analytics&amp;lt;/PPScrollSegmentButton&amp;gt;
  &amp;lt;PPScrollSegmentButton value="tab3"&amp;gt;Reports&amp;lt;/PPScrollSegmentButton&amp;gt;
  &amp;lt;!-- Add as many tabs as you need --&amp;gt;
&amp;lt;/PPScrollSegment&amp;gt;&lt;/code&gt;&lt;/pre&gt;
  
        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Customizing CSS&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;You can override the component's appearance globally via CSS variables or by targeting its specific classes.&lt;/p&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;/* Override globally */
:root {
  --pp-background-alt: /* value */;
  --pp-border-color: /* value */;
  --pp-primary-variant: /* value */;
  --pp-scroll-segment-bg: /* value */;
  --pp-scroll-segment-border-radius: /* value */;
  --pp-scroll-segment-btn-active-bg: /* value */;
  --pp-scroll-segment-btn-active-border-color: /* value */;
  --pp-scroll-segment-btn-active-color: /* value */;
  --pp-scroll-segment-btn-bg: /* value */;
  --pp-scroll-segment-btn-border-color: /* value */;
  --pp-scroll-segment-btn-color: /* value */;
  --pp-scroll-segment-btn-font-size: /* value */;
  --pp-scroll-segment-btn-padding: /* value */;
  --pp-scroll-segment-btn-radius: /* value */;
  --pp-scroll-segment-btn-shadow: /* value */;
  --pp-scroll-segment-gap: /* value */;
  --pp-scroll-segment-margin-bottom: /* value */;
  --pp-scroll-segment-padding: /* value */;
  --pp-segment-bg: /* value */;
  --pp-segment-border-color: /* value */;
  --pp-segment-btn-active-bg: /* value */;
  --pp-segment-btn-active-shadow: /* value */;
  --pp-segment-padding: /* value */;
  --pp-segment-radius: /* value */;
}

/* Or target specific instances using custom classes */
.my-custom-component {
  /* Add your custom styles */
}&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;
&lt;/div&gt;
&lt;/template&gt;

&lt;script setup lang="ts"&gt;
import { ref } from 'vue';
import { PPScrollSegment, PPScrollSegmentButton } from '@phanna/ui-framework';

const activeTab = ref('tab1');
&lt;/script&gt;

&lt;style scoped&gt;
.guide-section { display: flex; flex-direction: column; gap: 24px; }
.demo-box { border: 1px solid #e5e7eb; border-radius: 8px; padding: 24px; background: #f9fafb; }
&lt;/style&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
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
