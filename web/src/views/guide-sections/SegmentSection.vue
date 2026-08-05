<template>
  <div class="component-section">
    <h2>Segment Controls</h2>
    <p>Segment controls allow users to toggle between different views or options.</p>

    <!-- Basic Segment -->
    <div style="margin-top: 40px;">
      <h3>Basic Segment (PPSegment)</h3>
      <p>A simple segmented control for toggling between a few options.</p>
      
      <div class="demo-box" style="padding: 40px; background: #f8fafc; border-radius: 12px; display: flex; flex-direction: column; align-items: center; gap: 40px;">
        <!-- Pill Variant (Default) -->
        <div>
          <p style="text-align: center; margin-bottom: 12px; font-size: 14px; color: #64748b;">Pill Variant (Default)</p>
          <PPSegment v-model="activeTab" variant="pill">
            <PPSegmentButton value="map">Map View</PPSegmentButton>
            <PPSegmentButton value="list">List View</PPSegmentButton>
            <PPSegmentButton value="grid">Grid View</PPSegmentButton>
          </PPSegment>
        </div>

        <!-- Underline Variant -->
        <div>
          <p style="text-align: center; margin-bottom: 12px; font-size: 14px; color: #64748b;">Underline Variant</p>
          <PPSegment v-model="activeTab" variant="underline" style="width: 300px;">
            <PPSegmentButton value="map">Map</PPSegmentButton>
            <PPSegmentButton value="list">List</PPSegmentButton>
            <PPSegmentButton value="grid">Grid</PPSegmentButton>
          </PPSegment>
        </div>

        <!-- Block Variant -->
        <div>
          <p style="text-align: center; margin-bottom: 12px; font-size: 14px; color: #64748b;">Block Variant</p>
          <PPSegment v-model="activeTab" variant="block" style="width: 300px; background: #e2e8f0;">
            <PPSegmentButton value="map">Map</PPSegmentButton>
            <PPSegmentButton value="list">List</PPSegmentButton>
            <PPSegmentButton value="grid">Grid</PPSegmentButton>
          </PPSegment>
        </div>

        <!-- Material UI 3 Variant -->
        <div>
          <p style="text-align: center; margin-bottom: 12px; font-size: 14px; color: #64748b;">Material UI 3 Variant</p>
          <PPSegment v-model="activeTab" variant="material3" style="width: 300px;">
            <PPSegmentButton value="map">Map</PPSegmentButton>
            <PPSegmentButton value="list">List</PPSegmentButton>
            <PPSegmentButton value="grid">Grid</PPSegmentButton>
          </PPSegment>
        </div>

        <!-- iOS Liquid Glass Variant -->
        <div style="background: url('https://images.unsplash.com/photo-1557683316-973673baf926?q=80&w=600&auto=format&fit=crop') center/cover; padding: 40px; border-radius: 12px;">
          <p style="text-align: center; margin-bottom: 12px; font-size: 14px; color: #ffffff; text-shadow: 0 1px 2px rgba(0,0,0,0.5);">iOS Liquid Glass Variant</p>
          <PPSegment v-model="activeTab" variant="ios-glass" style="width: 300px;">
            <PPSegmentButton value="map">Map</PPSegmentButton>
            <PPSegmentButton value="list">List</PPSegmentButton>
            <PPSegmentButton value="grid">Grid</PPSegmentButton>
          </PPSegment>
        </div>

        <p style="font-size: 14px; color: #64748b; margin-top: 20px;">Selected: <strong>{{ activeTab }}</strong></p>

        <!-- Tab Content Example -->
        <div style="margin-top: 24px; padding: 24px; background: #ffffff; border-radius: 12px; border: 1px solid #e2e8f0; width: 100%; max-width: 400px; min-height: 150px;">
          <div v-if="activeTab === 'map'" style="text-align: center;">
            <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="#3b82f6" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="margin-bottom: 12px;"><polygon points="3 6 9 3 15 6 21 3 21 18 15 21 9 18 3 21"></polygon><line x1="9" y1="3" x2="9" y2="18"></line><line x1="15" y1="6" x2="15" y2="21"></line></svg>
            <h4 style="margin: 0 0 8px 0; color: #0f172a;">Map View</h4>
            <p style="margin: 0; color: #64748b; font-size: 14px;">This is the map view content.</p>
          </div>
          <div v-else-if="activeTab === 'list'" style="text-align: center;">
            <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="#10b981" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="margin-bottom: 12px;"><line x1="8" y1="6" x2="21" y2="6"></line><line x1="8" y1="12" x2="21" y2="12"></line><line x1="8" y1="18" x2="21" y2="18"></line><line x1="3" y1="6" x2="3.01" y2="6"></line><line x1="3" y1="12" x2="3.01" y2="12"></line><line x1="3" y1="18" x2="3.01" y2="18"></line></svg>
            <h4 style="margin: 0 0 8px 0; color: #0f172a;">List View</h4>
            <p style="margin: 0; color: #64748b; font-size: 14px;">This is the list view content.</p>
          </div>
          <div v-else-if="activeTab === 'grid'" style="text-align: center;">
            <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="#f59e0b" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="margin-bottom: 12px;"><rect x="3" y="3" width="7" height="7"></rect><rect x="14" y="3" width="7" height="7"></rect><rect x="14" y="14" width="7" height="7"></rect><rect x="3" y="14" width="7" height="7"></rect></svg>
            <h4 style="margin: 0 0 8px 0; color: #0f172a;">Grid View</h4>
            <p style="margin: 0; color: #64748b; font-size: 14px;">This is the grid view content.</p>
          </div>
        </div>
      </div>

      <div style="margin-top: 16px;">
        <h4>Usage Example</h4>
        <pre v-pre class="code-block" style="background: #f8fafc; padding: 16px; border-radius: 8px; overflow-x: auto;"><code>&lt;template&gt;
  &lt;PPSegment v-model="activeTab"&gt;
    &lt;PPSegmentButton value="map"&gt;Map View&lt;/PPSegmentButton&gt;
    &lt;PPSegmentButton value="list"&gt;List View&lt;/PPSegmentButton&gt;
    &lt;PPSegmentButton value="grid"&gt;Grid View&lt;/PPSegmentButton&gt;
  &lt;/PPSegment&gt;

  &lt;!-- Underline Variant --&gt;
  &lt;PPSegment v-model="activeTab" variant="underline"&gt;
    &lt;PPSegmentButton value="map"&gt;Map&lt;/PPSegmentButton&gt;
    &lt;PPSegmentButton value="list"&gt;List&lt;/PPSegmentButton&gt;
  &lt;/PPSegment&gt;

  &lt;!-- Block Variant --&gt;
  &lt;PPSegment v-model="activeTab" variant="block"&gt;
    &lt;PPSegmentButton value="map"&gt;Map&lt;/PPSegmentButton&gt;
    &lt;PPSegmentButton value="list"&gt;List&lt;/PPSegmentButton&gt;
  &lt;/PPSegment&gt;

  &lt;!-- Material UI 3 Variant --&gt;
  &lt;PPSegment v-model="activeTab" variant="material3"&gt;
    &lt;PPSegmentButton value="map"&gt;Map&lt;/PPSegmentButton&gt;
    &lt;PPSegmentButton value="list"&gt;List&lt;/PPSegmentButton&gt;
  &lt;/PPSegment&gt;

  &lt;!-- iOS Liquid Glass Variant --&gt;
  &lt;PPSegment v-model="activeTab" variant="ios-glass"&gt;
    &lt;PPSegmentButton value="map"&gt;Map&lt;/PPSegmentButton&gt;
    &lt;PPSegmentButton value="list"&gt;List&lt;/PPSegmentButton&gt;
  &lt;/PPSegment&gt;

  &lt;!-- Tab Content Example --&gt;
  &lt;div class="tab-content"&gt;
    &lt;div v-if="activeTab === 'map'"&gt;Map View Content&lt;/div&gt;
    &lt;div v-else-if="activeTab === 'list'"&gt;List View Content&lt;/div&gt;
    &lt;div v-else-if="activeTab === 'grid'"&gt;Grid View Content&lt;/div&gt;
  &lt;/div&gt;
&lt;/template&gt;

&lt;script setup&gt;
import { ref } from 'vue';
import { PPSegment, PPSegmentButton } from '@phanna/ui-framework';

const activeTab = ref('map');
&lt;/script&gt;</code></pre>
      </div>
    </div>

    <!-- Scrollable Segment -->
    <div style="margin-top: 40px;">
      <h3>Scrollable Segment (PPScrollSegment)</h3>
      <p>A scrollable segmented control for a large number of options.</p>
      
      <div class="demo-box" style="padding: 40px; background: #f8fafc; border-radius: 12px; display: flex; flex-direction: column; align-items: center; gap: 20px;">
        <PPScrollSegment v-model="activeScrollTab" style="width: 100%; max-width: 400px;">
          <PPScrollSegmentButton v-for="cat in categories" :key="cat" :value="cat">
            {{ cat }}
          </PPScrollSegmentButton>
        </PPScrollSegment>
        <p style="font-size: 14px; color: #64748b;">Selected: <strong>{{ activeScrollTab }}</strong></p>
      </div>

      <div style="margin-top: 16px;">
        <h4>Usage Example</h4>
        <pre v-pre class="code-block" style="background: #f8fafc; padding: 16px; border-radius: 8px; overflow-x: auto;"><code>&lt;template&gt;
  &lt;PPScrollSegment v-model="activeCategory"&gt;
    &lt;PPScrollSegmentButton value="all"&gt;All&lt;/PPScrollSegmentButton&gt;
    &lt;PPScrollSegmentButton value="electronics"&gt;Electronics&lt;/PPScrollSegmentButton&gt;
    &lt;PPScrollSegmentButton value="clothing"&gt;Clothing&lt;/PPScrollSegmentButton&gt;
    &lt;PPScrollSegmentButton value="books"&gt;Books&lt;/PPScrollSegmentButton&gt;
    &lt;PPScrollSegmentButton value="home"&gt;Home & Garden&lt;/PPScrollSegmentButton&gt;
  &lt;/PPScrollSegment&gt;
&lt;/template&gt;

&lt;script setup&gt;
import { ref } from 'vue';
import { PPScrollSegment, PPScrollSegmentButton } from '@phanna/ui-framework';

const activeCategory = ref('all');
&lt;/script&gt;</code></pre>
      </div>
    </div>

  
        <div class="variant-group">
          <h3>Customizing CSS</h3>
          <p class="custom-guide">You can override the component's appearance globally via CSS variables or by targeting its specific classes.</p>
          <pre class="code-block" v-pre><code>/* Override globally */
:root {
  --pp-background-alt: /* value */;
  --pp-border-color: /* value */;
  --pp-primary: /* value */;
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
  --pp-segment-btn-active-color: /* value */;
  --pp-segment-btn-active-shadow: /* value */;
  --pp-segment-btn-color: /* value */;
  --pp-segment-btn-font-size: /* value */;
  --pp-segment-btn-font-weight: /* value */;
  --pp-segment-btn-padding: /* value */;
  --pp-segment-btn-radius: /* value */;
  --pp-segment-icon-size: /* value */;
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
  &lt;div class="component-section"&gt;
    &lt;h2&gt;Segment Controls&lt;/h2&gt;
    &lt;p&gt;Segment controls allow users to toggle between different views or options.&lt;/p&gt;

    &lt;!-- Basic Segment --&gt;
    &lt;div style="margin-top: 40px;"&gt;
      &lt;h3&gt;Basic Segment (PPSegment)&lt;/h3&gt;
      &lt;p&gt;A simple segmented control for toggling between a few options.&lt;/p&gt;
      
      &lt;div class="demo-box" style="padding: 40px; background: #f8fafc; border-radius: 12px; display: flex; flex-direction: column; align-items: center; gap: 40px;"&gt;
        &lt;!-- Pill Variant (Default) --&gt;
        &lt;div&gt;
          &lt;p style="text-align: center; margin-bottom: 12px; font-size: 14px; color: #64748b;"&gt;Pill Variant (Default)&lt;/p&gt;
          &lt;PPSegment v-model="activeTab" variant="pill"&gt;
            &lt;PPSegmentButton value="map"&gt;Map View&lt;/PPSegmentButton&gt;
            &lt;PPSegmentButton value="list"&gt;List View&lt;/PPSegmentButton&gt;
            &lt;PPSegmentButton value="grid"&gt;Grid View&lt;/PPSegmentButton&gt;
          &lt;/PPSegment&gt;
        &lt;/div&gt;

        &lt;!-- Underline Variant --&gt;
        &lt;div&gt;
          &lt;p style="text-align: center; margin-bottom: 12px; font-size: 14px; color: #64748b;"&gt;Underline Variant&lt;/p&gt;
          &lt;PPSegment v-model="activeTab" variant="underline" style="width: 300px;"&gt;
            &lt;PPSegmentButton value="map"&gt;Map&lt;/PPSegmentButton&gt;
            &lt;PPSegmentButton value="list"&gt;List&lt;/PPSegmentButton&gt;
            &lt;PPSegmentButton value="grid"&gt;Grid&lt;/PPSegmentButton&gt;
          &lt;/PPSegment&gt;
        &lt;/div&gt;

        &lt;!-- Block Variant --&gt;
        &lt;div&gt;
          &lt;p style="text-align: center; margin-bottom: 12px; font-size: 14px; color: #64748b;"&gt;Block Variant&lt;/p&gt;
          &lt;PPSegment v-model="activeTab" variant="block" style="width: 300px; background: #e2e8f0;"&gt;
            &lt;PPSegmentButton value="map"&gt;Map&lt;/PPSegmentButton&gt;
            &lt;PPSegmentButton value="list"&gt;List&lt;/PPSegmentButton&gt;
            &lt;PPSegmentButton value="grid"&gt;Grid&lt;/PPSegmentButton&gt;
          &lt;/PPSegment&gt;
        &lt;/div&gt;

        &lt;!-- Material UI 3 Variant --&gt;
        &lt;div&gt;
          &lt;p style="text-align: center; margin-bottom: 12px; font-size: 14px; color: #64748b;"&gt;Material UI 3 Variant&lt;/p&gt;
          &lt;PPSegment v-model="activeTab" variant="material3" style="width: 300px;"&gt;
            &lt;PPSegmentButton value="map"&gt;Map&lt;/PPSegmentButton&gt;
            &lt;PPSegmentButton value="list"&gt;List&lt;/PPSegmentButton&gt;
            &lt;PPSegmentButton value="grid"&gt;Grid&lt;/PPSegmentButton&gt;
          &lt;/PPSegment&gt;
        &lt;/div&gt;

        &lt;!-- iOS Liquid Glass Variant --&gt;
        &lt;div style="background: url('https://images.unsplash.com/photo-1557683316-973673baf926?q=80&amp;w=600&amp;auto=format&amp;fit=crop') center/cover; padding: 40px; border-radius: 12px;"&gt;
          &lt;p style="text-align: center; margin-bottom: 12px; font-size: 14px; color: #ffffff; text-shadow: 0 1px 2px rgba(0,0,0,0.5);"&gt;iOS Liquid Glass Variant&lt;/p&gt;
          &lt;PPSegment v-model="activeTab" variant="ios-glass" style="width: 300px;"&gt;
            &lt;PPSegmentButton value="map"&gt;Map&lt;/PPSegmentButton&gt;
            &lt;PPSegmentButton value="list"&gt;List&lt;/PPSegmentButton&gt;
            &lt;PPSegmentButton value="grid"&gt;Grid&lt;/PPSegmentButton&gt;
          &lt;/PPSegment&gt;
        &lt;/div&gt;

        &lt;p style="font-size: 14px; color: #64748b; margin-top: 20px;"&gt;Selected: &lt;strong&gt;{{ activeTab }}&lt;/strong&gt;&lt;/p&gt;

        &lt;!-- Tab Content Example --&gt;
        &lt;div style="margin-top: 24px; padding: 24px; background: #ffffff; border-radius: 12px; border: 1px solid #e2e8f0; width: 100%; max-width: 400px; min-height: 150px;"&gt;
          &lt;div v-if="activeTab === 'map'" style="text-align: center;"&gt;
            &lt;svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="#3b82f6" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="margin-bottom: 12px;"&gt;&lt;polygon points="3 6 9 3 15 6 21 3 21 18 15 21 9 18 3 21"&gt;&lt;/polygon&gt;&lt;line x1="9" y1="3" x2="9" y2="18"&gt;&lt;/line&gt;&lt;line x1="15" y1="6" x2="15" y2="21"&gt;&lt;/line&gt;&lt;/svg&gt;
            &lt;h4 style="margin: 0 0 8px 0; color: #0f172a;"&gt;Map View&lt;/h4&gt;
            &lt;p style="margin: 0; color: #64748b; font-size: 14px;"&gt;This is the map view content.&lt;/p&gt;
          &lt;/div&gt;
          &lt;div v-else-if="activeTab === 'list'" style="text-align: center;"&gt;
            &lt;svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="#10b981" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="margin-bottom: 12px;"&gt;&lt;line x1="8" y1="6" x2="21" y2="6"&gt;&lt;/line&gt;&lt;line x1="8" y1="12" x2="21" y2="12"&gt;&lt;/line&gt;&lt;line x1="8" y1="18" x2="21" y2="18"&gt;&lt;/line&gt;&lt;line x1="3" y1="6" x2="3.01" y2="6"&gt;&lt;/line&gt;&lt;line x1="3" y1="12" x2="3.01" y2="12"&gt;&lt;/line&gt;&lt;line x1="3" y1="18" x2="3.01" y2="18"&gt;&lt;/line&gt;&lt;/svg&gt;
            &lt;h4 style="margin: 0 0 8px 0; color: #0f172a;"&gt;List View&lt;/h4&gt;
            &lt;p style="margin: 0; color: #64748b; font-size: 14px;"&gt;This is the list view content.&lt;/p&gt;
          &lt;/div&gt;
          &lt;div v-else-if="activeTab === 'grid'" style="text-align: center;"&gt;
            &lt;svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="#f59e0b" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="margin-bottom: 12px;"&gt;&lt;rect x="3" y="3" width="7" height="7"&gt;&lt;/rect&gt;&lt;rect x="14" y="3" width="7" height="7"&gt;&lt;/rect&gt;&lt;rect x="14" y="14" width="7" height="7"&gt;&lt;/rect&gt;&lt;rect x="3" y="14" width="7" height="7"&gt;&lt;/rect&gt;&lt;/svg&gt;
            &lt;h4 style="margin: 0 0 8px 0; color: #0f172a;"&gt;Grid View&lt;/h4&gt;
            &lt;p style="margin: 0; color: #64748b; font-size: 14px;"&gt;This is the grid view content.&lt;/p&gt;
          &lt;/div&gt;
        &lt;/div&gt;
      &lt;/div&gt;

      &lt;div style="margin-top: 16px;"&gt;
        &lt;h4&gt;Usage Example&lt;/h4&gt;
        &lt;pre v-pre class="code-block" style="background: #f8fafc; padding: 16px; border-radius: 8px; overflow-x: auto;"&gt;&lt;code&gt;&amp;lt;template&amp;gt;
  &amp;lt;PPSegment v-model="activeTab"&amp;gt;
    &amp;lt;PPSegmentButton value="map"&amp;gt;Map View&amp;lt;/PPSegmentButton&amp;gt;
    &amp;lt;PPSegmentButton value="list"&amp;gt;List View&amp;lt;/PPSegmentButton&amp;gt;
    &amp;lt;PPSegmentButton value="grid"&amp;gt;Grid View&amp;lt;/PPSegmentButton&amp;gt;
  &amp;lt;/PPSegment&amp;gt;

  &amp;lt;!-- Underline Variant --&amp;gt;
  &amp;lt;PPSegment v-model="activeTab" variant="underline"&amp;gt;
    &amp;lt;PPSegmentButton value="map"&amp;gt;Map&amp;lt;/PPSegmentButton&amp;gt;
    &amp;lt;PPSegmentButton value="list"&amp;gt;List&amp;lt;/PPSegmentButton&amp;gt;
  &amp;lt;/PPSegment&amp;gt;

  &amp;lt;!-- Block Variant --&amp;gt;
  &amp;lt;PPSegment v-model="activeTab" variant="block"&amp;gt;
    &amp;lt;PPSegmentButton value="map"&amp;gt;Map&amp;lt;/PPSegmentButton&amp;gt;
    &amp;lt;PPSegmentButton value="list"&amp;gt;List&amp;lt;/PPSegmentButton&amp;gt;
  &amp;lt;/PPSegment&amp;gt;

  &amp;lt;!-- Material UI 3 Variant --&amp;gt;
  &amp;lt;PPSegment v-model="activeTab" variant="material3"&amp;gt;
    &amp;lt;PPSegmentButton value="map"&amp;gt;Map&amp;lt;/PPSegmentButton&amp;gt;
    &amp;lt;PPSegmentButton value="list"&amp;gt;List&amp;lt;/PPSegmentButton&amp;gt;
  &amp;lt;/PPSegment&amp;gt;

  &amp;lt;!-- iOS Liquid Glass Variant --&amp;gt;
  &amp;lt;PPSegment v-model="activeTab" variant="ios-glass"&amp;gt;
    &amp;lt;PPSegmentButton value="map"&amp;gt;Map&amp;lt;/PPSegmentButton&amp;gt;
    &amp;lt;PPSegmentButton value="list"&amp;gt;List&amp;lt;/PPSegmentButton&amp;gt;
  &amp;lt;/PPSegment&amp;gt;

  &amp;lt;!-- Tab Content Example --&amp;gt;
  &amp;lt;div class="tab-content"&amp;gt;
    &amp;lt;div v-if="activeTab === 'map'"&amp;gt;Map View Content&amp;lt;/div&amp;gt;
    &amp;lt;div v-else-if="activeTab === 'list'"&amp;gt;List View Content&amp;lt;/div&amp;gt;
    &amp;lt;div v-else-if="activeTab === 'grid'"&amp;gt;Grid View Content&amp;lt;/div&amp;gt;
  &amp;lt;/div&amp;gt;
&amp;lt;/template&amp;gt;

&amp;lt;script setup&amp;gt;
import { ref } from 'vue';
import { PPSegment, PPSegmentButton } from '@phanna/ui-framework';

const activeTab = ref('map');
&amp;lt;/script&amp;gt;&lt;/code&gt;&lt;/pre&gt;
      &lt;/div&gt;
    &lt;/div&gt;

    &lt;!-- Scrollable Segment --&gt;
    &lt;div style="margin-top: 40px;"&gt;
      &lt;h3&gt;Scrollable Segment (PPScrollSegment)&lt;/h3&gt;
      &lt;p&gt;A scrollable segmented control for a large number of options.&lt;/p&gt;
      
      &lt;div class="demo-box" style="padding: 40px; background: #f8fafc; border-radius: 12px; display: flex; flex-direction: column; align-items: center; gap: 20px;"&gt;
        &lt;PPScrollSegment v-model="activeScrollTab" style="width: 100%; max-width: 400px;"&gt;
          &lt;PPScrollSegmentButton v-for="cat in categories" :key="cat" :value="cat"&gt;
            {{ cat }}
          &lt;/PPScrollSegmentButton&gt;
        &lt;/PPScrollSegment&gt;
        &lt;p style="font-size: 14px; color: #64748b;"&gt;Selected: &lt;strong&gt;{{ activeScrollTab }}&lt;/strong&gt;&lt;/p&gt;
      &lt;/div&gt;

      &lt;div style="margin-top: 16px;"&gt;
        &lt;h4&gt;Usage Example&lt;/h4&gt;
        &lt;pre v-pre class="code-block" style="background: #f8fafc; padding: 16px; border-radius: 8px; overflow-x: auto;"&gt;&lt;code&gt;&amp;lt;template&amp;gt;
  &amp;lt;PPScrollSegment v-model="activeCategory"&amp;gt;
    &amp;lt;PPScrollSegmentButton value="all"&amp;gt;All&amp;lt;/PPScrollSegmentButton&amp;gt;
    &amp;lt;PPScrollSegmentButton value="electronics"&amp;gt;Electronics&amp;lt;/PPScrollSegmentButton&amp;gt;
    &amp;lt;PPScrollSegmentButton value="clothing"&amp;gt;Clothing&amp;lt;/PPScrollSegmentButton&amp;gt;
    &amp;lt;PPScrollSegmentButton value="books"&amp;gt;Books&amp;lt;/PPScrollSegmentButton&amp;gt;
    &amp;lt;PPScrollSegmentButton value="home"&amp;gt;Home &amp; Garden&amp;lt;/PPScrollSegmentButton&amp;gt;
  &amp;lt;/PPScrollSegment&amp;gt;
&amp;lt;/template&amp;gt;

&amp;lt;script setup&amp;gt;
import { ref } from 'vue';
import { PPScrollSegment, PPScrollSegmentButton } from '@phanna/ui-framework';

const activeCategory = ref('all');
&amp;lt;/script&amp;gt;&lt;/code&gt;&lt;/pre&gt;
      &lt;/div&gt;
    &lt;/div&gt;

  
        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Customizing CSS&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;You can override the component's appearance globally via CSS variables or by targeting its specific classes.&lt;/p&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;/* Override globally */
:root {
  --pp-background-alt: /* value */;
  --pp-border-color: /* value */;
  --pp-primary: /* value */;
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
  --pp-segment-btn-active-color: /* value */;
  --pp-segment-btn-active-shadow: /* value */;
  --pp-segment-btn-color: /* value */;
  --pp-segment-btn-font-size: /* value */;
  --pp-segment-btn-font-weight: /* value */;
  --pp-segment-btn-padding: /* value */;
  --pp-segment-btn-radius: /* value */;
  --pp-segment-icon-size: /* value */;
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
import { 
  PPSegment, 
  PPSegmentButton,
  PPScrollSegment,
  PPScrollSegmentButton
} from '@phanna/ui-framework';

const activeTab = ref('map');
const activeScrollTab = ref('All');

const categories = ['All', 'Electronics', 'Clothing', 'Books', 'Home &amp; Garden', 'Sports', 'Toys', 'Health'];
&lt;/script&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { 
  PPSegment, 
  PPSegmentButton,
  PPScrollSegment,
  PPScrollSegmentButton
} from '@phanna/ui-framework';

const activeTab = ref('map');
const activeScrollTab = ref('All');

const categories = ['All', 'Electronics', 'Clothing', 'Books', 'Home & Garden', 'Sports', 'Toys', 'Health'];
</script>
