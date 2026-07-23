<template>
  <div class="guide-section">
    <h2>Ribbon Menu</h2>
    <div class="variant-group">
      <h3>Ribbon</h3>
      <p class="custom-guide">A Microsoft Office style ribbon menu for complex application interfaces.</p>

      <div class="component-demo" style="padding: 0; overflow: hidden; border-radius: 8px; border: 1px solid #e5e7eb; background: #f9fafb;">
        <PPRibbon>
          <PPRibbonTab title="Home">
            <PPRibbonGroup title="Clipboard">
              <PPRibbonButton :icon="clipboardOutline" label="Paste" />
              <PPRibbonButton :icon="cutOutline" label="Cut" />
              <PPRibbonButton :icon="copyOutline" label="Copy" />
            </PPRibbonGroup>
            <PPRibbonGroup title="Font">
              <PPRibbonButton :icon="textOutline" label="Bold" />
              <PPRibbonButton :icon="colorPaletteOutline" label="Color" />
            </PPRibbonGroup>
          </PPRibbonTab>
          <PPRibbonTab title="Insert">
            <PPRibbonGroup title="Media">
              <PPRibbonButton :icon="imageOutline" label="Pictures" />
              <PPRibbonButton :icon="videocamOutline" label="Video" />
            </PPRibbonGroup>
          </PPRibbonTab>
        </PPRibbon>
        <div style="height: 300px; background: white; padding: 32px; border-top: 1px solid #e5e7eb; overflow-y: auto;">
          <h1 style="margin-top: 0; color: #111827;">Document Title</h1>
          <p style="color: #4b5563; line-height: 1.6;">This is the content area below the ribbon menu. The ribbon is designed to sit at the top of a complex application window and control the content displayed here. Try clicking on the different ribbon tabs to see how the available controls change while this content remains in place.</p>
          <p style="color: #4b5563; line-height: 1.6;">Use the <b>large</b> and <b>small</b> sizes on ribbon buttons to build hierarchical command groups.</p>
        </div>
      </div>
      
      <pre class="code-block"><code>&lt;PPRibbon&gt;
  &lt;PPRibbonTab title="Home"&gt;
    &lt;PPRibbonGroup title="Clipboard"&gt;
      &lt;PPRibbonButton :icon="clipboardOutline" label="Paste" /&gt;
      &lt;PPRibbonButton :icon="cutOutline" label="Cut" /&gt;
    &lt;/PPRibbonGroup&gt;
  &lt;/PPRibbonTab&gt;
&lt;/PPRibbon&gt;</code></pre>
    </div>
  </div>
</template>

<script setup lang="ts">
import { PPRibbon, PPRibbonTab, PPRibbonGroup, PPRibbonButton } from '@phanna/ui-framework';
import { clipboardOutline, cutOutline, copyOutline, textOutline, colorPaletteOutline, imageOutline, videocamOutline } from 'ionicons/icons';
</script>

<style scoped>
.guide-section { display: flex; flex-direction: column; gap: 24px; }
.demo-box { border: 1px solid #e5e7eb; border-radius: 8px; padding: 24px; background: #f9fafb; }
</style>
