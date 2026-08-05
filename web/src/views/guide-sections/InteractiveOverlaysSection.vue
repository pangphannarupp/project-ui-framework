<template>
  <div class="component-section">
    <h2>Interactive Overlays</h2>
    <p>Contextual components that appear above the main content to provide extra information or actions.</p>

    <!-- Tooltip -->
    <div style="margin-top: 32px;">
      <h3>Tooltip</h3>
      <p>A brief informative message that appears on hover.</p>
      
      <div class="demo-box" style="display: flex; gap: 32px; align-items: center; justify-content: center; height: 160px;">
        <PPTooltip content="Top placement (Dark)">
          <PPButton variant="outline">Hover Top</PPButton>
        </PPTooltip>

        <PPTooltip content="Bottom placement (Light)" placement="bottom" theme="light">
          <PPButton variant="outline">Hover Bottom</PPButton>
        </PPTooltip>

        <PPTooltip content="Right placement" placement="right">
          <div style="width: 40px; height: 40px; border-radius: 50%; background: #e2e8f0; display: flex; align-items: center; justify-content: center;">
            <ion-icon :icon="informationCircleOutline" style="font-size: 24px; color: #64748b;" />
          </div>
        </PPTooltip>
      </div>
    </div>

    <!-- Dropdown -->
    <div style="margin-top: 32px;">
      <h3>Dropdown</h3>
      <p>A contextual menu for displaying a list of actions.</p>
      
      <div class="demo-box" style="display: flex; gap: 48px; align-items: center; justify-content: center; height: 300px;">
        <PPDropdown :items="dropdownItems1" @select="handleSelect">
          <template #trigger>
            <PPButton>Actions <ion-icon :icon="chevronDownOutline" style="margin-left: 8px;" /></PPButton>
          </template>
        </PPDropdown>
        
        <PPDropdown :items="dropdownItems2" placement="bottom-left" @select="handleSelect">
          <template #trigger>
            <div style="cursor: pointer; padding: 8px; border-radius: 8px; background: #f1f5f9;">
              <ion-icon :icon="ellipsisVerticalOutline" style="font-size: 20px;" />
            </div>
          </template>
        </PPDropdown>
      </div>
    </div>

    <!-- Usage Section -->
    <div style="margin-top: 40px;">
      <h3>Usage Example</h3>
      <pre class="code-block" style="background: #f8fafc; padding: 16px; border-radius: 8px; overflow-x: auto;" v-pre><code>&lt;template&gt;
  &lt;PPTooltip content="Hover me!" placement="top"&gt;
    &lt;PPButton&gt;Action&lt;/PPButton&gt;
  &lt;/PPTooltip&gt;
  
  &lt;PPDropdown :items="menuItems" @select="handleSelect"&gt;
    &lt;template #trigger&gt;
      &lt;PPButton&gt;Menu&lt;/PPButton&gt;
    &lt;/template&gt;
  &lt;/PPDropdown&gt;
&lt;/template&gt;

&lt;script setup&gt;
import { PPTooltip, PPDropdown, PPButton } from '@phanna/ui-framework';
import { settingsOutline, logOutOutline } from 'ionicons/icons';

const menuItems = [
  { label: 'Settings', icon: settingsOutline },
  { label: 'Logout', icon: logOutOutline, danger: true }
];

const handleSelect = (item) =&gt; {
  console.log('Selected:', item.label);
};
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
  &lt;div class="component-section"&gt;
    &lt;h2&gt;Interactive Overlays&lt;/h2&gt;
    &lt;p&gt;Contextual components that appear above the main content to provide extra information or actions.&lt;/p&gt;

    &lt;!-- Tooltip --&gt;
    &lt;div style="margin-top: 32px;"&gt;
      &lt;h3&gt;Tooltip&lt;/h3&gt;
      &lt;p&gt;A brief informative message that appears on hover.&lt;/p&gt;
      
      &lt;div class="demo-box" style="display: flex; gap: 32px; align-items: center; justify-content: center; height: 160px;"&gt;
        &lt;PPTooltip content="Top placement (Dark)"&gt;
          &lt;PPButton variant="outline"&gt;Hover Top&lt;/PPButton&gt;
        &lt;/PPTooltip&gt;

        &lt;PPTooltip content="Bottom placement (Light)" placement="bottom" theme="light"&gt;
          &lt;PPButton variant="outline"&gt;Hover Bottom&lt;/PPButton&gt;
        &lt;/PPTooltip&gt;

        &lt;PPTooltip content="Right placement" placement="right"&gt;
          &lt;div style="width: 40px; height: 40px; border-radius: 50%; background: #e2e8f0; display: flex; align-items: center; justify-content: center;"&gt;
            &lt;ion-icon :icon="informationCircleOutline" style="font-size: 24px; color: #64748b;" /&gt;
          &lt;/div&gt;
        &lt;/PPTooltip&gt;
      &lt;/div&gt;
    &lt;/div&gt;

    &lt;!-- Dropdown --&gt;
    &lt;div style="margin-top: 32px;"&gt;
      &lt;h3&gt;Dropdown&lt;/h3&gt;
      &lt;p&gt;A contextual menu for displaying a list of actions.&lt;/p&gt;
      
      &lt;div class="demo-box" style="display: flex; gap: 48px; align-items: center; justify-content: center; height: 300px;"&gt;
        &lt;PPDropdown :items="dropdownItems1" @select="handleSelect"&gt;
          &lt;template #trigger&gt;
            &lt;PPButton&gt;Actions &lt;ion-icon :icon="chevronDownOutline" style="margin-left: 8px;" /&gt;&lt;/PPButton&gt;
          &lt;/template&gt;
        &lt;/PPDropdown&gt;
        
        &lt;PPDropdown :items="dropdownItems2" placement="bottom-left" @select="handleSelect"&gt;
          &lt;template #trigger&gt;
            &lt;div style="cursor: pointer; padding: 8px; border-radius: 8px; background: #f1f5f9;"&gt;
              &lt;ion-icon :icon="ellipsisVerticalOutline" style="font-size: 20px;" /&gt;
            &lt;/div&gt;
          &lt;/template&gt;
        &lt;/PPDropdown&gt;
      &lt;/div&gt;
    &lt;/div&gt;

    &lt;!-- Usage Section --&gt;
    &lt;div style="margin-top: 40px;"&gt;
      &lt;h3&gt;Usage Example&lt;/h3&gt;
      &lt;pre class="code-block" style="background: #f8fafc; padding: 16px; border-radius: 8px; overflow-x: auto;"&gt;&lt;code&gt;&amp;lt;template&amp;gt;
  &amp;lt;PPTooltip content="Hover me!" placement="top"&amp;gt;
    &amp;lt;PPButton&amp;gt;Action&amp;lt;/PPButton&amp;gt;
  &amp;lt;/PPTooltip&amp;gt;
  
  &amp;lt;PPDropdown :items="menuItems" @select="handleSelect"&amp;gt;
    &amp;lt;template #trigger&amp;gt;
      &amp;lt;PPButton&amp;gt;Menu&amp;lt;/PPButton&amp;gt;
    &amp;lt;/template&amp;gt;
  &amp;lt;/PPDropdown&amp;gt;
&amp;lt;/template&amp;gt;

&amp;lt;script setup&amp;gt;
import { PPTooltip, PPDropdown, PPButton } from '@phanna/ui-framework';
import { settingsOutline, logOutOutline } from 'ionicons/icons';

const menuItems = [
  { label: 'Settings', icon: settingsOutline },
  { label: 'Logout', icon: logOutOutline, danger: true }
];

const handleSelect = (item) =&amp;gt; {
  console.log('Selected:', item.label);
};
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
import { informationCircleOutline, chevronDownOutline, ellipsisVerticalOutline, eyeOutline, createOutline, shareSocialOutline, trashOutline } from 'ionicons/icons';
import { PPTooltip, PPDropdown, PPButton } from '@phanna/ui-framework';
import { IonIcon } from '@ionic/vue';

const dropdownItems1 = [
  { label: 'View Details', icon: eyeOutline, value: 'view' },
  { label: 'Edit Document', icon: createOutline, value: 'edit' },
  { label: 'Share', icon: shareSocialOutline, value: 'share', disabled: true },
  { label: 'Delete', icon: trashOutline, value: 'delete', danger: true }
];

const dropdownItems2 = [
  { label: 'Option 1', value: 1 },
  { label: 'Option 2', value: 2 },
  { label: 'Option 3', value: 3 }
];

const handleSelect = (item: any) =&gt; {
  console.log('Selected:', item);
};
&lt;/script&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
</template>

<script setup lang="ts">
import { informationCircleOutline, chevronDownOutline, ellipsisVerticalOutline, eyeOutline, createOutline, shareSocialOutline, trashOutline } from 'ionicons/icons';
import { PPTooltip, PPDropdown, PPButton } from '@phanna/ui-framework';
import { IonIcon } from '@ionic/vue';

const dropdownItems1 = [
  { label: 'View Details', icon: eyeOutline, value: 'view' },
  { label: 'Edit Document', icon: createOutline, value: 'edit' },
  { label: 'Share', icon: shareSocialOutline, value: 'share', disabled: true },
  { label: 'Delete', icon: trashOutline, value: 'delete', danger: true }
];

const dropdownItems2 = [
  { label: 'Option 1', value: 1 },
  { label: 'Option 2', value: 2 },
  { label: 'Option 3', value: 3 }
];

const handleSelect = (item: any) => {
  console.log('Selected:', item);
};
</script>
