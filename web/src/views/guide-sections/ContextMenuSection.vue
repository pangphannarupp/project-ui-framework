<template>
  <div class="guide-section">
    <h2>Context Menu</h2>
    <p>A multi-level context menu that supports icons, dividers, and nested submenus.</p>
    
    <div class="variant-group">
      <h3>Basic Usage</h3>
      <div class="demo-box" style="height: 300px; display: flex; align-items: flex-start;">
        <PPContextMenu :items="menuItems" placement="bottom-left">
          <template #trigger>
            <PPButton>Click to Open Menu</PPButton>
          </template>
        </PPContextMenu>
      </div>
      <pre class="code-block" style="max-height: 400px; overflow-y: auto;" v-pre><code>&lt;template&gt;
  &lt;PPContextMenu :items="menuItems" placement="bottom-left"&gt;
    &lt;template #trigger&gt;
      &lt;PPButton&gt;Click to Open Menu&lt;/PPButton&gt;
    &lt;/template&gt;
  &lt;/PPContextMenu&gt;
&lt;/template&gt;

&lt;script setup lang="ts"&gt;
import { PPContextMenu, PPButton } from '@phanna/ui-framework';
import { colorPaletteOutline, listOutline, listCircleOutline, addCircleOutline, trashOutline, settingsOutline } from 'ionicons/icons';

const menuItems = [
  {
    label: 'Highlight Cell Rules',
    icon: colorPaletteOutline,
    children: [
      { label: 'Greater Than...' },
      { label: 'Less Than...' },
      { label: 'Between...' },
      { label: 'Equal To...' }
    ]
  },
  {
    label: 'Top/Bottom Rules',
    icon: listOutline,
    children: [
      { label: 'Top 10 Items...' },
      { label: 'Top 10%...' },
      { label: 'Bottom 10 Items...' },
      { label: 'Bottom 10%...' }
    ]
  },
  { divider: true },
  {
    label: 'Data Bars',
    icon: listCircleOutline,
    children: [
      { label: 'Gradient Fill' },
      { label: 'Solid Fill' }
    ]
  },
  {
    label: 'Color Scales',
    icon: colorPaletteOutline,
    children: [
      { label: 'Green-Yellow-Red' },
      { label: 'Red-Yellow-Green' }
    ]
  },
  {
    label: 'Icon Sets',
    icon: settingsOutline,
    children: [
      { label: 'Directional' },
      { label: 'Shapes' },
      { label: 'Indicators' }
    ]
  },
  { divider: true },
  { label: 'New Rule', icon: addCircleOutline },
  { 
    label: 'Clear Rules', 
    icon: trashOutline,
    children: [
      { label: 'Clear Rules from Selected Cells' },
      { label: 'Clear Rules from Entire Sheet' }
    ]
  },
  { label: 'Manage Rules', icon: settingsOutline }
];
&lt;/script&gt;</code></pre>
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
    &lt;h2&gt;Context Menu&lt;/h2&gt;
    &lt;p&gt;A multi-level context menu that supports icons, dividers, and nested submenus.&lt;/p&gt;
    
    &lt;div class="variant-group"&gt;
      &lt;h3&gt;Basic Usage&lt;/h3&gt;
      &lt;div class="demo-box" style="height: 300px; display: flex; align-items: flex-start;"&gt;
        &lt;PPContextMenu :items="menuItems" placement="bottom-left"&gt;
          &lt;template #trigger&gt;
            &lt;PPButton&gt;Click to Open Menu&lt;/PPButton&gt;
          &lt;/template&gt;
        &lt;/PPContextMenu&gt;
      &lt;/div&gt;
      &lt;pre class="code-block" style="max-height: 400px; overflow-y: auto;"&gt;&lt;code&gt;&amp;lt;template&amp;gt;
  &amp;lt;PPContextMenu :items="menuItems" placement="bottom-left"&amp;gt;
    &amp;lt;template #trigger&amp;gt;
      &amp;lt;PPButton&amp;gt;Click to Open Menu&amp;lt;/PPButton&amp;gt;
    &amp;lt;/template&amp;gt;
  &amp;lt;/PPContextMenu&amp;gt;
&amp;lt;/template&amp;gt;

&amp;lt;script setup lang="ts"&amp;gt;
import { PPContextMenu, PPButton } from '@phanna/ui-framework';
import { colorPaletteOutline, listOutline, listCircleOutline, addCircleOutline, trashOutline, settingsOutline } from 'ionicons/icons';

const menuItems = [
  {
    label: 'Highlight Cell Rules',
    icon: colorPaletteOutline,
    children: [
      { label: 'Greater Than...' },
      { label: 'Less Than...' },
      { label: 'Between...' },
      { label: 'Equal To...' }
    ]
  },
  {
    label: 'Top/Bottom Rules',
    icon: listOutline,
    children: [
      { label: 'Top 10 Items...' },
      { label: 'Top 10%...' },
      { label: 'Bottom 10 Items...' },
      { label: 'Bottom 10%...' }
    ]
  },
  { divider: true },
  {
    label: 'Data Bars',
    icon: listCircleOutline,
    children: [
      { label: 'Gradient Fill' },
      { label: 'Solid Fill' }
    ]
  },
  {
    label: 'Color Scales',
    icon: colorPaletteOutline,
    children: [
      { label: 'Green-Yellow-Red' },
      { label: 'Red-Yellow-Green' }
    ]
  },
  {
    label: 'Icon Sets',
    icon: settingsOutline,
    children: [
      { label: 'Directional' },
      { label: 'Shapes' },
      { label: 'Indicators' }
    ]
  },
  { divider: true },
  { label: 'New Rule', icon: addCircleOutline },
  { 
    label: 'Clear Rules', 
    icon: trashOutline,
    children: [
      { label: 'Clear Rules from Selected Cells' },
      { label: 'Clear Rules from Entire Sheet' }
    ]
  },
  { label: 'Manage Rules', icon: settingsOutline }
];
&amp;lt;/script&amp;gt;&lt;/code&gt;&lt;/pre&gt;
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
import { PPContextMenu, PPButton } from '@phanna/ui-framework';
import { colorPaletteOutline, listOutline, listCircleOutline, addCircleOutline, trashOutline, settingsOutline } from 'ionicons/icons';

const menuItems = [
  {
    label: 'Highlight Cell Rules',
    icon: colorPaletteOutline,
    children: [
      { label: 'Greater Than...' },
      { label: 'Less Than...' },
      { label: 'Between...' },
      { label: 'Equal To...' }
    ]
  },
  {
    label: 'Top/Bottom Rules',
    icon: listOutline,
    children: [
      { label: 'Top 10 Items...' },
      { label: 'Top 10%...' },
      { label: 'Bottom 10 Items...' },
      { label: 'Bottom 10%...' }
    ]
  },
  { divider: true },
  {
    label: 'Data Bars',
    icon: listCircleOutline,
    children: [
      { label: 'Gradient Fill' },
      { label: 'Solid Fill' }
    ]
  },
  {
    label: 'Color Scales',
    icon: colorPaletteOutline,
    children: [
      { label: 'Green-Yellow-Red' },
      { label: 'Red-Yellow-Green' }
    ]
  },
  {
    label: 'Icon Sets',
    icon: settingsOutline,
    children: [
      { label: 'Directional' },
      { label: 'Shapes' },
      { label: 'Indicators' }
    ]
  },
  { divider: true },
  { label: 'New Rule', icon: addCircleOutline },
  { 
    label: 'Clear Rules', 
    icon: trashOutline,
    children: [
      { label: 'Clear Rules from Selected Cells' },
      { label: 'Clear Rules from Entire Sheet' }
    ]
  },
  { label: 'Manage Rules', icon: settingsOutline }
];
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
import { PPContextMenu, PPButton } from '@phanna/ui-framework';
import { colorPaletteOutline, listOutline, listCircleOutline, addCircleOutline, trashOutline, settingsOutline } from 'ionicons/icons';

const menuItems = [
  {
    label: 'Highlight Cell Rules',
    icon: colorPaletteOutline,
    children: [
      { label: 'Greater Than...' },
      { label: 'Less Than...' },
      { label: 'Between...' },
      { label: 'Equal To...' }
    ]
  },
  {
    label: 'Top/Bottom Rules',
    icon: listOutline,
    children: [
      { label: 'Top 10 Items...' },
      { label: 'Top 10%...' },
      { label: 'Bottom 10 Items...' },
      { label: 'Bottom 10%...' }
    ]
  },
  { divider: true },
  {
    label: 'Data Bars',
    icon: listCircleOutline,
    children: [
      { label: 'Gradient Fill' },
      { label: 'Solid Fill' }
    ]
  },
  {
    label: 'Color Scales',
    icon: colorPaletteOutline,
    children: [
      { label: 'Green-Yellow-Red' },
      { label: 'Red-Yellow-Green' }
    ]
  },
  {
    label: 'Icon Sets',
    icon: settingsOutline,
    children: [
      { label: 'Directional' },
      { label: 'Shapes' },
      { label: 'Indicators' }
    ]
  },
  { divider: true },
  { label: 'New Rule', icon: addCircleOutline },
  { 
    label: 'Clear Rules', 
    icon: trashOutline,
    children: [
      { label: 'Clear Rules from Selected Cells' },
      { label: 'Clear Rules from Entire Sheet' }
    ]
  },
  { label: 'Manage Rules', icon: settingsOutline }
];
</script>

<style scoped>
.guide-section { display: flex; flex-direction: column; gap: 24px; }
.demo-box { border: 1px solid #e5e7eb; border-radius: 8px; padding: 24px; background: #f9fafb; }
</style>
