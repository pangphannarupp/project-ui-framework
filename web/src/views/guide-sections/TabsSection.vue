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
      <pre style="background: #1f2937; color: #f8f8f2; padding: 16px; border-radius: 8px; overflow-x: auto; font-size: 14px;"><code>&lt;PPTabs v-model="activeTab"&gt;
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
      <pre style="background: #1f2937; color: #f8f8f2; padding: 16px; border-radius: 8px; overflow-x: auto; font-size: 14px;"><code>&lt;PPTabs v-model="activeTab" variant="pills"&gt;
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
      <pre style="background: #1f2937; color: #f8f8f2; padding: 16px; border-radius: 8px; overflow-x: auto; font-size: 14px;"><code>&lt;PPTabs v-model="activeTab" variant="segmented"&gt;
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
  </div>
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
