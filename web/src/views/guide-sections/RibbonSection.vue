<template>
  <div class="guide-section">
    <h2>Ribbon</h2>
    <p>A Microsoft Office style ribbon menu for complex application interfaces.</p>

    <h3>Basic Usage</h3>
    <div class="demo-box" style="padding: 0; overflow: hidden;">
      <BizRibbon>
        <BizRibbonTab title="Home">
          <BizRibbonGroup title="Clipboard">
            <BizRibbonButton icon="clipboard-outline" label="Paste" />
            <BizRibbonButton icon="cut-outline" label="Cut" />
            <BizRibbonButton icon="copy-outline" label="Copy" />
          </BizRibbonGroup>
          <BizRibbonGroup title="Font">
            <BizRibbonButton icon="text-outline" label="Bold" />
            <BizRibbonButton icon="color-palette-outline" label="Color" />
          </BizRibbonGroup>
        </BizRibbonTab>
        <BizRibbonTab title="Insert">
          <BizRibbonGroup title="Media">
            <BizRibbonButton icon="image-outline" label="Pictures" />
            <BizRibbonButton icon="videocam-outline" label="Video" />
          </BizRibbonGroup>
        </BizRibbonTab>
      </BizRibbon>
    </div>
  </div>
</template>

<script setup lang="ts">
import { BizRibbon, BizRibbonTab, BizRibbonGroup, BizRibbonButton } from '@phanna/ui-framework';
</script>

<style scoped>
.guide-section { display: flex; flex-direction: column; gap: 24px; }
.demo-box { border: 1px solid #e5e7eb; border-radius: 8px; padding: 24px; background: #f9fafb; }
</style>
