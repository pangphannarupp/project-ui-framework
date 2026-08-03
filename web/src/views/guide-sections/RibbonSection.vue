<template>
  <div class="guide-section">
    <h2>Ribbon Menu</h2>
    <div class="variant-group">
      <h3>Classic Ribbon (Default)</h3>
      <p class="custom-guide">A Microsoft Office style ribbon menu for complex application interfaces.</p>
      <p class="guide-desc">The Ribbon is <code>collapsible</code> by default. You can toggle it via the chevron icon on the right, or by clicking the active tab.</p>

      <div class="component-demo" style="padding: 0; overflow: hidden; border-radius: 8px; border: 1px solid #e5e7eb; background: #f9fafb;">
        <PPRibbon variant="classic" :collapsible="true">
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
        <div style="height: 100px; background: white; padding: 16px; border-top: 1px solid #e5e7eb;">
          <p style="color: #4b5563; margin: 0; font-size: 14px;">Classic ribbon content area.</p>
        </div>
      </div>
    </div>

    <div class="variant-group" style="margin-top: 32px;">
      <h3>Modern Ribbon</h3>
      <p class="custom-guide">A cleaner, flatter ribbon style with underlined active tabs, similar to modern web office apps.</p>

      <div class="component-demo" style="padding: 0; overflow: hidden; border-radius: 8px; border: 1px solid #e5e7eb; background: #f9fafb;">
        <PPRibbon variant="modern">
          <PPRibbonTab title="Home">
            <PPRibbonGroup title="Clipboard">
              <PPRibbonButton :icon="clipboardOutline" label="Paste" />
              <PPRibbonButton :icon="cutOutline" label="Cut" />
            </PPRibbonGroup>
          </PPRibbonTab>
          <PPRibbonTab title="Insert">
            <PPRibbonGroup title="Media">
              <PPRibbonButton :icon="imageOutline" label="Pictures" />
            </PPRibbonGroup>
          </PPRibbonTab>
        </PPRibbon>
        <div style="height: 100px; background: white; padding: 16px; border-top: 1px solid #e5e7eb;">
          <p style="color: #4b5563; margin: 0; font-size: 14px;">Modern ribbon content area.</p>
        </div>
      </div>
    </div>

    <div class="variant-group" style="margin-top: 32px;">
      <h3>Glass Ribbon</h3>
      <p class="custom-guide">A translucent glassmorphism ribbon, great for placing over gradients or imagery.</p>

      <div class="component-demo" style="padding: 24px; overflow: hidden; border-radius: 8px; background: linear-gradient(135deg, #a8edea 0%, #fed6e3 100%);">
        <PPRibbon variant="glass">
          <PPRibbonTab title="Home">
            <PPRibbonGroup title="Clipboard">
              <PPRibbonButton :icon="clipboardOutline" label="Paste" />
              <PPRibbonButton :icon="copyOutline" label="Copy" />
            </PPRibbonGroup>
          </PPRibbonTab>
          <PPRibbonTab title="Insert">
            <PPRibbonGroup title="Media">
              <PPRibbonButton :icon="imageOutline" label="Pictures" />
            </PPRibbonGroup>
          </PPRibbonTab>
        </PPRibbon>
      </div>
      
      <pre class="code-block" style="margin-top: 16px;"><code>&lt;PPRibbon variant="classic | modern | glass" :collapsible="true"&gt;
  &lt;PPRibbonTab title="Home"&gt;
    &lt;PPRibbonGroup title="Clipboard"&gt;
      &lt;PPRibbonButton :icon="clipboardOutline" label="Paste" /&gt;
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
