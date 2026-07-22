<template>
  <div class="guide-section">
    <h2>Ribbon</h2>
    <p>A Microsoft Office style ribbon menu for complex application interfaces.</p>

    <h3>Basic Usage</h3>
    <div class="demo-box" style="padding: 0; overflow: hidden;">
      <PPRibbon>
        <PPRibbonTab title="Home">
          <PPRibbonGroup title="Clipboard">
            <PPRibbonButton icon="clipboard-outline" label="Paste" />
            <PPRibbonButton icon="cut-outline" label="Cut" />
            <PPRibbonButton icon="copy-outline" label="Copy" />
          </PPRibbonGroup>
          <PPRibbonGroup title="Font">
            <PPRibbonButton icon="text-outline" label="Bold" />
            <PPRibbonButton icon="color-palette-outline" label="Color" />
          </PPRibbonGroup>
        </PPRibbonTab>
        <PPRibbonTab title="Insert">
          <PPRibbonGroup title="Media">
            <PPRibbonButton icon="image-outline" label="Pictures" />
            <PPRibbonButton icon="videocam-outline" label="Video" />
          </PPRibbonGroup>
        </PPRibbonTab>
      </PPRibbon>
    </div>
  </div>
</template>

<script setup lang="ts">
import { PPRibbon, PPRibbonTab, PPRibbonGroup, PPRibbonButton } from '@phanna/ui-framework';
</script>

<style scoped>
.guide-section { display: flex; flex-direction: column; gap: 24px; }
.demo-box { border: 1px solid #e5e7eb; border-radius: 8px; padding: 24px; background: #f9fafb; }
</style>
