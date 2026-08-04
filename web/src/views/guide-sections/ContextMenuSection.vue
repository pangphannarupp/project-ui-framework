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
    </div>
  </div>
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
