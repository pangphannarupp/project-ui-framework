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
      <pre class="code-block" style="background: #f8fafc; padding: 16px; border-radius: 8px; overflow-x: auto;"><code>&lt;template&gt;
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

  </div>
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
