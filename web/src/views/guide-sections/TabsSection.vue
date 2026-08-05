<template>
  <div class="guide-section">
    <h2>Tabs & TabBar</h2>
    <p>A flexible tab component for organizing content. Supports different visual variants including pills and segmented styles, as seen in iOS and modern web apps.</p>

    <h3>Standard Tabs</h3>
    <div class="demo-box">
      <PPTabs v-model="activeTab1">
        <PPTabList>
          <PPTab value="today">Today</PPTab>
          <PPTab value="tomorrow">Tomorrow</PPTab>
          <PPTab value="10days">10 Days</PPTab>
        </PPTabList>
        <div style="height: 16px;"></div>
        <PPTabPanels>
          <PPTabPanel value="today">
            <div style="padding: 16px; background: white; border-radius: 8px;">☀️ Today's Forecast: Sunny, 28°C</div>
          </PPTabPanel>
          <PPTabPanel value="tomorrow">
            <div style="padding: 16px; background: white; border-radius: 8px;">🌧️ Tomorrow's Forecast: Rainy, 22°C</div>
          </PPTabPanel>
          <PPTabPanel value="10days">
            <div style="padding: 16px; background: white; border-radius: 8px;">📅 10-Day Outlook: Mostly cloudy.</div>
          </PPTabPanel>
        </PPTabPanels>
      </PPTabs>
    </div>
    <div class="usage-block" style="margin-top: 16px;">
      <pre style="background: #1f2937; color: #f8f8f2; padding: 16px; border-radius: 8px; overflow-x: auto; font-size: 14px;" v-pre><code>&lt;PPTabs v-model="activeTab"&gt;
  &lt;PPTabList&gt;
    &lt;PPTab value="today"&gt;Today&lt;/PPTab&gt;
    &lt;PPTab value="tomorrow"&gt;Tomorrow&lt;/PPTab&gt;
  &lt;/PPTabList&gt;
  
  &lt;PPTabPanels&gt;
    &lt;PPTabPanel value="today"&gt;...&lt;/PPTabPanel&gt;
    &lt;PPTabPanel value="tomorrow"&gt;...&lt;/PPTabPanel&gt;
  &lt;/PPTabPanels&gt;
&lt;/PPTabs&gt;</code></pre>
    </div>
    
    <h3>Pills Variant (Scrollable)</h3>
    <p>Using <code>variant="pills"</code> and <code>scrollable</code> on the TabList.</p>
    <div class="demo-box">
      <PPTabs v-model="activeTab2" variant="pills">
        <PPTabList scrollable>
          <PPTab value="today">Today</PPTab>
          <PPTab value="aug01">01 Aug</PPTab>
          <PPTab value="aug02">02 Aug</PPTab>
          <PPTab value="aug03">03 Aug</PPTab>
          <PPTab value="aug04">04 Aug</PPTab>
          <PPTab value="aug05">05 Aug</PPTab>
        </PPTabList>
        <div style="height: 16px;"></div>
        <PPTabPanels>
          <PPTabPanel value="today">
            <div style="padding: 16px; background: white; border-radius: 8px;">Today content...</div>
          </PPTabPanel>
          <PPTabPanel value="aug01">
            <div style="padding: 16px; background: white; border-radius: 8px;">Aug 01 content...</div>
          </PPTabPanel>
          <PPTabPanel value="aug02">
            <div style="padding: 16px; background: white; border-radius: 8px;">Aug 02 content...</div>
          </PPTabPanel>
        </PPTabPanels>
      </PPTabs>
    </div>
    <div class="usage-block" style="margin-top: 16px;">
      <pre style="background: #1f2937; color: #f8f8f2; padding: 16px; border-radius: 8px; overflow-x: auto; font-size: 14px;" v-pre><code>&lt;PPTabs v-model="activeTab" variant="pills"&gt;
  &lt;PPTabList scrollable&gt;
    &lt;PPTab value="1"&gt;Tab 1&lt;/PPTab&gt;
    &lt;PPTab value="2"&gt;Tab 2&lt;/PPTab&gt;
  &lt;/PPTabList&gt;
  &lt;PPTabPanels&gt;...&lt;/PPTabPanels&gt;
&lt;/PPTabs&gt;</code></pre>
    </div>

    <h3>Segmented Variant</h3>
    <div class="demo-box">
      <div style="background: #f1f5f9; padding: 4px; border-radius: 12px; width: fit-content;">
        <PPTabs v-model="activeTab3" variant="segmented">
          <PPTabList>
            <PPTab value="hourly">Hourly</PPTab>
            <PPTab value="daily">Daily</PPTab>
            <PPTab value="details">Details</PPTab>
          </PPTabList>
        </PPTabs>
      </div>
    </div>
    <div class="usage-block" style="margin-top: 16px;">
      <pre style="background: #1f2937; color: #f8f8f2; padding: 16px; border-radius: 8px; overflow-x: auto; font-size: 14px;" v-pre><code>&lt;PPTabs v-model="activeTab" variant="segmented"&gt;
  &lt;PPTabList&gt;
    &lt;PPTab value="hourly"&gt;Hourly&lt;/PPTab&gt;
    &lt;PPTab value="daily"&gt;Daily&lt;/PPTab&gt;
  &lt;/PPTabList&gt;
&lt;/PPTabs&gt;</code></pre>
    </div>

    <h3>Outlined Variant</h3>
    <div class="demo-box">
      <PPTabs v-model="activeTab4" variant="outlined">
        <PPTabList scrollable>
          <PPTab value="all">All</PPTab>
          <PPTab value="unread">Unread</PPTab>
          <PPTab value="drafts">Drafts</PPTab>
          <PPTab value="sent">Sent</PPTab>
        </PPTabList>
      </PPTabs>
    </div>

    <h3>Minimal Variant</h3>
    <div class="demo-box">
      <PPTabs v-model="activeTab5" variant="minimal">
        <PPTabList>
          <PPTab value="code">Code</PPTab>
          <PPTab value="issues">Issues</PPTab>
          <PPTab value="pulls">Pull Requests</PPTab>
        </PPTabList>
      </PPTabs>
    </div>
  
        <div class="variant-group">
          <h3>Customizing CSS</h3>
          <p class="custom-guide">You can override the component's appearance globally via CSS variables or by targeting its specific classes.</p>
          <pre class="code-block" v-pre><code>/* Override globally */
:root {
  --pp-primary-variant: /* value */;
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
    &lt;h2&gt;Tabs &amp; TabBar&lt;/h2&gt;
    &lt;p&gt;A flexible tab component for organizing content. Supports different visual variants including pills and segmented styles, as seen in iOS and modern web apps.&lt;/p&gt;

    &lt;h3&gt;Standard Tabs&lt;/h3&gt;
    &lt;div class="demo-box"&gt;
      &lt;PPTabs v-model="activeTab1"&gt;
        &lt;PPTabList&gt;
          &lt;PPTab value="today"&gt;Today&lt;/PPTab&gt;
          &lt;PPTab value="tomorrow"&gt;Tomorrow&lt;/PPTab&gt;
          &lt;PPTab value="10days"&gt;10 Days&lt;/PPTab&gt;
        &lt;/PPTabList&gt;
        &lt;div style="height: 16px;"&gt;&lt;/div&gt;
        &lt;PPTabPanels&gt;
          &lt;PPTabPanel value="today"&gt;
            &lt;div style="padding: 16px; background: white; border-radius: 8px;"&gt;☀️ Today's Forecast: Sunny, 28°C&lt;/div&gt;
          &lt;/PPTabPanel&gt;
          &lt;PPTabPanel value="tomorrow"&gt;
            &lt;div style="padding: 16px; background: white; border-radius: 8px;"&gt;🌧️ Tomorrow's Forecast: Rainy, 22°C&lt;/div&gt;
          &lt;/PPTabPanel&gt;
          &lt;PPTabPanel value="10days"&gt;
            &lt;div style="padding: 16px; background: white; border-radius: 8px;"&gt;📅 10-Day Outlook: Mostly cloudy.&lt;/div&gt;
          &lt;/PPTabPanel&gt;
        &lt;/PPTabPanels&gt;
      &lt;/PPTabs&gt;
    &lt;/div&gt;
    &lt;div class="usage-block" style="margin-top: 16px;"&gt;
      &lt;pre style="background: #1f2937; color: #f8f8f2; padding: 16px; border-radius: 8px; overflow-x: auto; font-size: 14px;"&gt;&lt;code&gt;&amp;lt;PPTabs v-model="activeTab"&amp;gt;
  &amp;lt;PPTabList&amp;gt;
    &amp;lt;PPTab value="today"&amp;gt;Today&amp;lt;/PPTab&amp;gt;
    &amp;lt;PPTab value="tomorrow"&amp;gt;Tomorrow&amp;lt;/PPTab&amp;gt;
  &amp;lt;/PPTabList&amp;gt;
  
  &amp;lt;PPTabPanels&amp;gt;
    &amp;lt;PPTabPanel value="today"&amp;gt;...&amp;lt;/PPTabPanel&amp;gt;
    &amp;lt;PPTabPanel value="tomorrow"&amp;gt;...&amp;lt;/PPTabPanel&amp;gt;
  &amp;lt;/PPTabPanels&amp;gt;
&amp;lt;/PPTabs&amp;gt;&lt;/code&gt;&lt;/pre&gt;
    &lt;/div&gt;
    
    &lt;h3&gt;Pills Variant (Scrollable)&lt;/h3&gt;
    &lt;p&gt;Using &lt;code&gt;variant="pills"&lt;/code&gt; and &lt;code&gt;scrollable&lt;/code&gt; on the TabList.&lt;/p&gt;
    &lt;div class="demo-box"&gt;
      &lt;PPTabs v-model="activeTab2" variant="pills"&gt;
        &lt;PPTabList scrollable&gt;
          &lt;PPTab value="today"&gt;Today&lt;/PPTab&gt;
          &lt;PPTab value="aug01"&gt;01 Aug&lt;/PPTab&gt;
          &lt;PPTab value="aug02"&gt;02 Aug&lt;/PPTab&gt;
          &lt;PPTab value="aug03"&gt;03 Aug&lt;/PPTab&gt;
          &lt;PPTab value="aug04"&gt;04 Aug&lt;/PPTab&gt;
          &lt;PPTab value="aug05"&gt;05 Aug&lt;/PPTab&gt;
        &lt;/PPTabList&gt;
        &lt;div style="height: 16px;"&gt;&lt;/div&gt;
        &lt;PPTabPanels&gt;
          &lt;PPTabPanel value="today"&gt;
            &lt;div style="padding: 16px; background: white; border-radius: 8px;"&gt;Today content...&lt;/div&gt;
          &lt;/PPTabPanel&gt;
          &lt;PPTabPanel value="aug01"&gt;
            &lt;div style="padding: 16px; background: white; border-radius: 8px;"&gt;Aug 01 content...&lt;/div&gt;
          &lt;/PPTabPanel&gt;
          &lt;PPTabPanel value="aug02"&gt;
            &lt;div style="padding: 16px; background: white; border-radius: 8px;"&gt;Aug 02 content...&lt;/div&gt;
          &lt;/PPTabPanel&gt;
        &lt;/PPTabPanels&gt;
      &lt;/PPTabs&gt;
    &lt;/div&gt;
    &lt;div class="usage-block" style="margin-top: 16px;"&gt;
      &lt;pre style="background: #1f2937; color: #f8f8f2; padding: 16px; border-radius: 8px; overflow-x: auto; font-size: 14px;"&gt;&lt;code&gt;&amp;lt;PPTabs v-model="activeTab" variant="pills"&amp;gt;
  &amp;lt;PPTabList scrollable&amp;gt;
    &amp;lt;PPTab value="1"&amp;gt;Tab 1&amp;lt;/PPTab&amp;gt;
    &amp;lt;PPTab value="2"&amp;gt;Tab 2&amp;lt;/PPTab&amp;gt;
  &amp;lt;/PPTabList&amp;gt;
  &amp;lt;PPTabPanels&amp;gt;...&amp;lt;/PPTabPanels&amp;gt;
&amp;lt;/PPTabs&amp;gt;&lt;/code&gt;&lt;/pre&gt;
    &lt;/div&gt;

    &lt;h3&gt;Segmented Variant&lt;/h3&gt;
    &lt;div class="demo-box"&gt;
      &lt;div style="background: #f1f5f9; padding: 4px; border-radius: 12px; width: fit-content;"&gt;
        &lt;PPTabs v-model="activeTab3" variant="segmented"&gt;
          &lt;PPTabList&gt;
            &lt;PPTab value="hourly"&gt;Hourly&lt;/PPTab&gt;
            &lt;PPTab value="daily"&gt;Daily&lt;/PPTab&gt;
            &lt;PPTab value="details"&gt;Details&lt;/PPTab&gt;
          &lt;/PPTabList&gt;
        &lt;/PPTabs&gt;
      &lt;/div&gt;
    &lt;/div&gt;
    &lt;div class="usage-block" style="margin-top: 16px;"&gt;
      &lt;pre style="background: #1f2937; color: #f8f8f2; padding: 16px; border-radius: 8px; overflow-x: auto; font-size: 14px;"&gt;&lt;code&gt;&amp;lt;PPTabs v-model="activeTab" variant="segmented"&amp;gt;
  &amp;lt;PPTabList&amp;gt;
    &amp;lt;PPTab value="hourly"&amp;gt;Hourly&amp;lt;/PPTab&amp;gt;
    &amp;lt;PPTab value="daily"&amp;gt;Daily&amp;lt;/PPTab&amp;gt;
  &amp;lt;/PPTabList&amp;gt;
&amp;lt;/PPTabs&amp;gt;&lt;/code&gt;&lt;/pre&gt;
    &lt;/div&gt;

    &lt;h3&gt;Outlined Variant&lt;/h3&gt;
    &lt;div class="demo-box"&gt;
      &lt;PPTabs v-model="activeTab4" variant="outlined"&gt;
        &lt;PPTabList scrollable&gt;
          &lt;PPTab value="all"&gt;All&lt;/PPTab&gt;
          &lt;PPTab value="unread"&gt;Unread&lt;/PPTab&gt;
          &lt;PPTab value="drafts"&gt;Drafts&lt;/PPTab&gt;
          &lt;PPTab value="sent"&gt;Sent&lt;/PPTab&gt;
        &lt;/PPTabList&gt;
      &lt;/PPTabs&gt;
    &lt;/div&gt;

    &lt;h3&gt;Minimal Variant&lt;/h3&gt;
    &lt;div class="demo-box"&gt;
      &lt;PPTabs v-model="activeTab5" variant="minimal"&gt;
        &lt;PPTabList&gt;
          &lt;PPTab value="code"&gt;Code&lt;/PPTab&gt;
          &lt;PPTab value="issues"&gt;Issues&lt;/PPTab&gt;
          &lt;PPTab value="pulls"&gt;Pull Requests&lt;/PPTab&gt;
        &lt;/PPTabList&gt;
      &lt;/PPTabs&gt;
    &lt;/div&gt;
  
        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Customizing CSS&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;You can override the component's appearance globally via CSS variables or by targeting its specific classes.&lt;/p&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;/* Override globally */
:root {
  --pp-primary-variant: /* value */;
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
import { PPTabs, PPTabList, PPTab, PPTabPanels, PPTabPanel } from '@phanna/ui-framework';

const activeTab1 = ref('today');
const activeTab2 = ref('today');
const activeTab3 = ref('hourly');
const activeTab4 = ref('all');
const activeTab5 = ref('code');
&lt;/script&gt;

&lt;style scoped&gt;
.guide-section {
  display: flex;
  flex-direction: column;
  gap: 24px;
}
.demo-box {
  border: 1px solid #e5e7eb;
  border-radius: 8px;
  padding: 24px;
  background: #f9fafb;
}
&lt;/style&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { PPTabs, PPTabList, PPTab, PPTabPanels, PPTabPanel } from '@phanna/ui-framework';

const activeTab1 = ref('today');
const activeTab2 = ref('today');
const activeTab3 = ref('hourly');
const activeTab4 = ref('all');
const activeTab5 = ref('code');
</script>

<style scoped>
.guide-section {
  display: flex;
  flex-direction: column;
  gap: 24px;
}
.demo-box {
  border: 1px solid #e5e7eb;
  border-radius: 8px;
  padding: 24px;
  background: #f9fafb;
}
</style>
