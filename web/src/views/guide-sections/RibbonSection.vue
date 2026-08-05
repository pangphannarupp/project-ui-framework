<template>
  <div class="guide-section">
    <h2>Ribbon Menu</h2>
    
    <div class="variant-group">
      <h3>Usage</h3>
      <div class="demo-box">
        <pre class="code-block" v-pre><code>&lt;script setup lang="ts"&gt;
import { 
  PPRibbon, 
  PPRibbonTab, 
  PPRibbonGroup, 
  PPRibbonButton 
} from '@phanna/ui-framework';
import { clipboardOutline, cutOutline } from 'ionicons/icons';
&lt;/script&gt;

&lt;template&gt;
  &lt;PPRibbon variant="classic" :collapsible="true" model-value="home"&gt;
    &lt;PPRibbonTab title="File" color="primary"&gt;
      &lt;PPRibbonGroup title="Document"&gt;
        &lt;PPRibbonButton label="Save" size="large" /&gt;
      &lt;/PPRibbonGroup&gt;
    &lt;/PPRibbonTab&gt;
    
    &lt;PPRibbonTab title="Home" id="home"&gt;
      &lt;PPRibbonGroup title="Clipboard"&gt;
        &lt;PPRibbonButton :icon="clipboardOutline" label="Paste" size="large" /&gt;
        &lt;div style="display: flex; flex-direction: column; gap: 2px;"&gt;
          &lt;PPRibbonButton :icon="cutOutline" label="Cut" size="small" /&gt;
        &lt;/div&gt;
      &lt;/PPRibbonGroup&gt;
    &lt;/PPRibbonTab&gt;
  &lt;/PPRibbon&gt;
&lt;/template&gt;</code></pre>
      </div>
    </div>
    
    <!-- Full Application Demo -->
    <div class="variant-group">
      <h3>Full Application Layout Demo</h3>
      <p class="custom-guide">A complete Microsoft Word-style interface built using the Ribbon Menu.</p>

      <div class="component-demo app-window-wrapper">
        <div class="word-layout">
          <!-- Window Header -->
          <header class="window-header">
            <div class="header-left">
              <div class="app-icon">W</div>
              <div class="quick-access">
                <PPIconButton color="transparent" size="sm">
                  <ion-icon :icon="saveOutline" />
                </PPIconButton>
                <PPIconButton color="transparent" size="sm">
                  <ion-icon :icon="arrowUndoOutline" />
                </PPIconButton>
                <PPIconButton color="transparent" size="sm">
                  <ion-icon :icon="arrowRedoOutline" />
                </PPIconButton>
              </div>
            </div>
            <div class="header-center">
              <span>Document1 - Word</span>
            </div>
            <div class="header-right">
              <PPIconButton color="transparent" size="sm">
                <ion-icon :icon="removeOutline" />
              </PPIconButton>
              <PPIconButton color="transparent" size="sm">
                <ion-icon :icon="stopOutline" />
              </PPIconButton>
              <PPIconButton color="transparent" size="sm" class="close-btn">
                <ion-icon :icon="closeOutline" />
              </PPIconButton>
            </div>
          </header>

          <!-- Ribbon -->
          <div class="ribbon-container">
            <PPRibbon variant="classic" :collapsible="true" model-value="home">
              <PPRibbonTab title="File" color="primary">
                <PPRibbonGroup title="Document">
                  <PPRibbonButton :icon="documentOutline" label="New" size="large" />
                  <PPRibbonButton :icon="saveOutline" label="Save" size="large" />
                </PPRibbonGroup>
                <PPRibbonGroup title="Print & Share">
                  <PPRibbonButton :icon="documentOutline" label="Print" size="large" />
                </PPRibbonGroup>
              </PPRibbonTab>
              <PPRibbonTab title="Home">
                <PPRibbonGroup title="Clipboard">
                  <PPRibbonButton :icon="clipboardOutline" label="Paste" size="large" />
                  <div class="vertical-group">
                    <PPRibbonButton :icon="cutOutline" label="Cut" size="small" />
                    <PPRibbonButton :icon="copyOutline" label="Copy" size="small" />
                    <PPRibbonButton :icon="brushOutline" label="Format Painter" size="small" />
                  </div>
                </PPRibbonGroup>
                <PPRibbonGroup title="Font">
                  <div class="font-controls">
                    <div class="font-row">
                      <select class="ribbon-select font-family">
                        <option>Calibri (Body)</option>
                        <option>Arial</option>
                        <option>Times New Roman</option>
                      </select>
                      <select class="ribbon-select font-size">
                        <option>11</option>
                        <option>12</option>
                        <option>14</option>
                      </select>
                    </div>
                    <div class="font-row action-row">
                      <button class="ribbon-icon-btn"><b>B</b></button>
                      <button class="ribbon-icon-btn"><i>I</i></button>
                      <button class="ribbon-icon-btn"><u>U</u></button>
                      <button class="ribbon-icon-btn"><del>ab</del></button>
                      <div class="divider"></div>
                      <button class="ribbon-icon-btn">
                        <ion-icon :icon="colorPaletteOutline" />
                      </button>
                      <button class="ribbon-icon-btn">
                        <ion-icon :icon="textOutline" />
                      </button>
                    </div>
                  </div>
                </PPRibbonGroup>
                <PPRibbonGroup title="Paragraph">
                  <div class="font-controls">
                    <div class="font-row action-row">
                      <button class="ribbon-icon-btn"><ion-icon :icon="listOutline" /></button>
                      <button class="ribbon-icon-btn"><ion-icon :icon="listCircleOutline" /></button>
                      <div class="divider"></div>
                      <button class="ribbon-icon-btn"><ion-icon :icon="reorderFourOutline" /></button>
                    </div>
                    <div class="font-row action-row">
                      <button class="ribbon-icon-btn"><ion-icon :icon="menuOutline" style="transform: scaleX(-1)"/></button>
                      <button class="ribbon-icon-btn"><ion-icon :icon="menuOutline" /></button>
                      <button class="ribbon-icon-btn"><ion-icon :icon="menuOutline" style="transform: scaleX(-1)"/></button>
                      <button class="ribbon-icon-btn"><ion-icon :icon="menuOutline" /></button>
                    </div>
                  </div>
                </PPRibbonGroup>
                <PPRibbonGroup title="Styles">
                  <div class="vertical-group">
                    <PPContextMenu :items="conditionalFormattingItems" placement="bottom-left">
                      <template #trigger>
                        <PPRibbonButton :icon="colorPaletteOutline" label="Conditional Formatting" size="small" />
                      </template>
                    </PPContextMenu>
                  </div>
                </PPRibbonGroup>
                <PPRibbonGroup title="Editing">
                  <div class="vertical-group">
                    <PPRibbonButton :icon="searchOutline" label="Find" size="small" />
                    <PPRibbonButton :icon="swapHorizontalOutline" label="Replace" size="small" />
                    <PPRibbonButton :icon="gitCommitOutline" label="Select" size="small" />
                  </div>
                </PPRibbonGroup>
              </PPRibbonTab>
              <PPRibbonTab title="Insert">
                <PPRibbonGroup title="Pages">
                  <PPRibbonButton :icon="documentOutline" label="Blank Page" size="large" />
                  <PPRibbonButton :icon="albumsOutline" label="Page Break" size="large" />
                </PPRibbonGroup>
                <PPRibbonGroup title="Tables">
                  <PPRibbonButton :icon="gridOutline" label="Table" size="large" />
                </PPRibbonGroup>
                <PPRibbonGroup title="Illustrations">
                  <PPRibbonButton :icon="imageOutline" label="Pictures" />
                  <PPRibbonButton :icon="shapesOutline" label="Shapes" />
                  <PPRibbonButton :icon="barChartOutline" label="Chart" />
                </PPRibbonGroup>
              </PPRibbonTab>
              <PPRibbonTab title="Layout">
                <PPRibbonGroup title="Page Setup">
                  <PPRibbonButton :icon="readerOutline" label="Margins" size="large" />
                  <PPRibbonButton :icon="phonePortraitOutline" label="Orientation" size="large" />
                  <PPRibbonButton :icon="resizeOutline" label="Size" size="large" />
                </PPRibbonGroup>
              </PPRibbonTab>
              <PPRibbonTab title="Review" />
              <PPRibbonTab title="View" />
            </PPRibbon>
          </div>

          <!-- Main Workspace -->
          <main class="workspace">
            <div class="document-page">
              <PPRichTextEditor v-model="documentContent" placeholder="Type here..." />
            </div>
          </main>

          <!-- Status Bar -->
          <footer class="status-bar">
            <div class="status-left">
              <span>Page 1 of 1</span>
              <span>0 words</span>
              <span>English (US)</span>
            </div>
            <div class="status-right">
              <div class="view-modes">
                <ion-icon :icon="bookOutline" />
                <ion-icon :icon="readerOutline" class="active" />
                <ion-icon :icon="globeOutline" />
              </div>
              <div class="zoom-control">
                <ion-icon :icon="removeOutline" />
                <input type="range" min="10" max="200" value="100" class="zoom-slider" />
                <ion-icon :icon="addOutline" />
                <span>100%</span>
              </div>
            </div>
          </footer>
        </div>
      </div>
    </div>

    <!-- Basic Variants -->
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
      
      <pre class="code-block" style="margin-top: 16px;" v-pre><code>&lt;PPRibbon variant="classic | modern | glass" :collapsible="true"&gt;
  &lt;PPRibbonTab title="Home"&gt;
    &lt;PPRibbonGroup title="Clipboard"&gt;
      &lt;PPRibbonButton :icon="clipboardOutline" label="Paste" /&gt;
    &lt;/PPRibbonGroup&gt;
  &lt;/PPRibbonTab&gt;
&lt;/PPRibbon&gt;</code></pre>
    </div>
    <!-- Image Editor Layout -->
    <div class="variant-group" style="margin-top: 32px;">
      <h3>Image Editor (Dark Mode)</h3>
      <p class="custom-guide">A sleek, dark-themed ribbon layout perfect for creative applications like photo editors or design tools.</p>

      <div class="component-demo app-window-wrapper dark-editor">
        <div class="dark-layout">
          <!-- Ribbon -->
          <div class="ribbon-container-dark">
            <PPRibbon variant="modern" :collapsible="true" model-value="tools">
              <PPRibbonTab title="File" />
              <PPRibbonTab title="Tools" id="tools">
                <PPRibbonGroup title="Select">
                  <PPRibbonButton :icon="cropOutline" label="Crop" size="large" />
                  <div class="vertical-group">
                    <PPRibbonButton :icon="searchOutline" label="Zoom" size="small" />
                    <PPRibbonButton :icon="gitCommitOutline" label="Magic" size="small" />
                  </div>
                </PPRibbonGroup>
                <PPRibbonGroup title="Adjust">
                  <PPRibbonButton :icon="contrastOutline" label="Brightness" size="large" />
                  <PPRibbonButton :icon="colorFilterOutline" label="Filter" size="large" />
                </PPRibbonGroup>
                <PPRibbonGroup title="Draw">
                  <PPRibbonButton :icon="pencilOutline" label="Pencil" size="large" />
                  <PPRibbonButton :icon="brushOutline" label="Brush" size="large" />
                  <PPRibbonButton :icon="colorPaletteOutline" label="Palette" size="large" />
                </PPRibbonGroup>
              </PPRibbonTab>
              <PPRibbonTab title="View" />
            </PPRibbon>
          </div>
          <!-- Canvas Area -->
          <div class="dark-workspace">
            <div class="editor-canvas">
              <div class="canvas-image">
                <ion-icon :icon="imageOutline" style="font-size: 64px; color: #4b5563;" />
                <span style="color: #6b7280; margin-top: 16px;">Drag and drop an image here</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- File Explorer Layout -->
    <div class="variant-group" style="margin-top: 32px;">
      <h3>File Explorer</h3>
      <p class="custom-guide">A compact ribbon layout simulating a modern OS file manager with breadcrumb navigation.</p>

      <div class="component-demo app-window-wrapper explorer-app">
        <div class="explorer-layout">
          <div class="ribbon-container-explorer">
            <PPRibbon variant="classic" :collapsible="true" model-value="home">
              <PPRibbonTab title="Home" id="home">
                <PPRibbonGroup title="Clipboard">
                  <PPRibbonButton :icon="copyOutline" label="Copy" size="large" />
                  <PPRibbonButton :icon="clipboardOutline" label="Paste" size="large" />
                </PPRibbonGroup>
                <PPRibbonGroup title="Organize">
                  <div class="vertical-group">
                    <PPRibbonButton :icon="folderOutline" label="Move to" size="small" />
                    <PPRibbonButton :icon="copyOutline" label="Copy to" size="small" />
                    <PPRibbonButton :icon="closeOutline" label="Delete" size="small" />
                  </div>
                </PPRibbonGroup>
                <PPRibbonGroup title="New">
                  <PPRibbonButton :icon="folderOpenOutline" label="New Folder" size="large" />
                  <PPRibbonButton :icon="documentTextOutline" label="New Item" size="large" />
                </PPRibbonGroup>
              </PPRibbonTab>
              <PPRibbonTab title="Share" />
              <PPRibbonTab title="View">
                <PPRibbonGroup title="Layout">
                  <PPRibbonButton :icon="gridOutline" label="Large Icons" size="large" />
                  <PPRibbonButton :icon="listOutline" label="Details" size="large" />
                </PPRibbonGroup>
              </PPRibbonTab>
            </PPRibbon>
          </div>
          
          <div class="explorer-toolbar">
            <div class="nav-buttons">
              <ion-icon :icon="arrowUndoOutline" />
              <ion-icon :icon="arrowRedoOutline" />
              <ion-icon :icon="arrowUndoOutline" style="transform: rotate(90deg);" />
            </div>
            <div class="address-bar">
              <ion-icon :icon="folderOutline" />
              <span>This PC > Documents > Projects</span>
            </div>
            <div class="search-box">
              <ion-icon :icon="searchOutline" />
              <span>Search Projects</span>
            </div>
          </div>

          <div class="explorer-body">
            <div class="sidebar">
              <ul>
                <li><ion-icon :icon="desktopOutline" /> Desktop</li>
                <li><ion-icon :icon="downloadOutline" /> Downloads</li>
                <li class="active"><ion-icon :icon="documentTextOutline" /> Documents</li>
                <li><ion-icon :icon="imageOutline" /> Pictures</li>
              </ul>
            </div>
            <div class="file-grid">
              <div class="file-item">
                <ion-icon :icon="folderOutline" class="folder-icon" />
                <span>ui-framework</span>
              </div>
              <div class="file-item">
                <ion-icon :icon="folderOutline" class="folder-icon" />
                <span>assets</span>
              </div>
              <div class="file-item">
                <ion-icon :icon="documentTextOutline" class="doc-icon" />
                <span>README.md</span>
              </div>
              <div class="file-item">
                <ion-icon :icon="imageOutline" class="img-icon" />
                <span>logo.png</span>
              </div>
            </div>
          </div>
        </div>
      </div>
      <pre class="code-block" style="margin-top: 16px;" v-pre><code>&lt;PPRibbon variant="classic" :collapsible="true" model-value="home"&gt;
  &lt;PPRibbonTab title="Home" id="home"&gt;
    &lt;PPRibbonGroup title="Clipboard"&gt;
      &lt;PPRibbonButton :icon="copyOutline" label="Copy" size="large" /&gt;
      &lt;PPRibbonButton :icon="clipboardOutline" label="Paste" size="large" /&gt;
    &lt;/PPRibbonGroup&gt;
    &lt;PPRibbonGroup title="Organize"&gt;
      &lt;div class="vertical-group"&gt;
        &lt;PPRibbonButton :icon="folderOutline" label="Move to" size="small" /&gt;
        &lt;PPRibbonButton :icon="copyOutline" label="Copy to" size="small" /&gt;
        &lt;PPRibbonButton :icon="closeOutline" label="Delete" size="small" /&gt;
      &lt;/div&gt;
    &lt;/PPRibbonGroup&gt;
  &lt;/PPRibbonTab&gt;
&lt;/PPRibbon&gt;</code></pre>
    </div>
  
        <div class="variant-group">
          <h3>Customizing CSS</h3>
          <p class="custom-guide">You can override the component's appearance globally via CSS variables or by targeting its specific classes.</p>
          <pre class="code-block" v-pre><code>/* Override globally */
:root {
  --pp-primary-variant: /* value */;
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
    &lt;h2&gt;Ribbon Menu&lt;/h2&gt;
    
    &lt;div class="variant-group"&gt;
      &lt;h3&gt;Usage&lt;/h3&gt;
      &lt;div class="demo-box"&gt;
        &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;script setup lang="ts"&amp;gt;
import { 
  PPRibbon, 
  PPRibbonTab, 
  PPRibbonGroup, 
  PPRibbonButton 
} from '@phanna/ui-framework';
import { clipboardOutline, cutOutline } from 'ionicons/icons';
&amp;lt;/script&amp;gt;

&amp;lt;template&amp;gt;
  &amp;lt;PPRibbon variant="classic" :collapsible="true" model-value="home"&amp;gt;
    &amp;lt;PPRibbonTab title="File" color="primary"&amp;gt;
      &amp;lt;PPRibbonGroup title="Document"&amp;gt;
        &amp;lt;PPRibbonButton label="Save" size="large" /&amp;gt;
      &amp;lt;/PPRibbonGroup&amp;gt;
    &amp;lt;/PPRibbonTab&amp;gt;
    
    &amp;lt;PPRibbonTab title="Home" id="home"&amp;gt;
      &amp;lt;PPRibbonGroup title="Clipboard"&amp;gt;
        &amp;lt;PPRibbonButton :icon="clipboardOutline" label="Paste" size="large" /&amp;gt;
        &amp;lt;div style="display: flex; flex-direction: column; gap: 2px;"&amp;gt;
          &amp;lt;PPRibbonButton :icon="cutOutline" label="Cut" size="small" /&amp;gt;
        &amp;lt;/div&amp;gt;
      &amp;lt;/PPRibbonGroup&amp;gt;
    &amp;lt;/PPRibbonTab&amp;gt;
  &amp;lt;/PPRibbon&amp;gt;
&amp;lt;/template&amp;gt;&lt;/code&gt;&lt;/pre&gt;
      &lt;/div&gt;
    &lt;/div&gt;
    
    &lt;!-- Full Application Demo --&gt;
    &lt;div class="variant-group"&gt;
      &lt;h3&gt;Full Application Layout Demo&lt;/h3&gt;
      &lt;p class="custom-guide"&gt;A complete Microsoft Word-style interface built using the Ribbon Menu.&lt;/p&gt;

      &lt;div class="component-demo app-window-wrapper"&gt;
        &lt;div class="word-layout"&gt;
          &lt;!-- Window Header --&gt;
          &lt;header class="window-header"&gt;
            &lt;div class="header-left"&gt;
              &lt;div class="app-icon"&gt;W&lt;/div&gt;
              &lt;div class="quick-access"&gt;
                &lt;PPIconButton color="transparent" size="sm"&gt;
                  &lt;ion-icon :icon="saveOutline" /&gt;
                &lt;/PPIconButton&gt;
                &lt;PPIconButton color="transparent" size="sm"&gt;
                  &lt;ion-icon :icon="arrowUndoOutline" /&gt;
                &lt;/PPIconButton&gt;
                &lt;PPIconButton color="transparent" size="sm"&gt;
                  &lt;ion-icon :icon="arrowRedoOutline" /&gt;
                &lt;/PPIconButton&gt;
              &lt;/div&gt;
            &lt;/div&gt;
            &lt;div class="header-center"&gt;
              &lt;span&gt;Document1 - Word&lt;/span&gt;
            &lt;/div&gt;
            &lt;div class="header-right"&gt;
              &lt;PPIconButton color="transparent" size="sm"&gt;
                &lt;ion-icon :icon="removeOutline" /&gt;
              &lt;/PPIconButton&gt;
              &lt;PPIconButton color="transparent" size="sm"&gt;
                &lt;ion-icon :icon="stopOutline" /&gt;
              &lt;/PPIconButton&gt;
              &lt;PPIconButton color="transparent" size="sm" class="close-btn"&gt;
                &lt;ion-icon :icon="closeOutline" /&gt;
              &lt;/PPIconButton&gt;
            &lt;/div&gt;
          &lt;/header&gt;

          &lt;!-- Ribbon --&gt;
          &lt;div class="ribbon-container"&gt;
            &lt;PPRibbon variant="classic" :collapsible="true" model-value="home"&gt;
              &lt;PPRibbonTab title="File" color="primary"&gt;
                &lt;PPRibbonGroup title="Document"&gt;
                  &lt;PPRibbonButton :icon="documentOutline" label="New" size="large" /&gt;
                  &lt;PPRibbonButton :icon="saveOutline" label="Save" size="large" /&gt;
                &lt;/PPRibbonGroup&gt;
                &lt;PPRibbonGroup title="Print &amp; Share"&gt;
                  &lt;PPRibbonButton :icon="documentOutline" label="Print" size="large" /&gt;
                &lt;/PPRibbonGroup&gt;
              &lt;/PPRibbonTab&gt;
              &lt;PPRibbonTab title="Home"&gt;
                &lt;PPRibbonGroup title="Clipboard"&gt;
                  &lt;PPRibbonButton :icon="clipboardOutline" label="Paste" size="large" /&gt;
                  &lt;div class="vertical-group"&gt;
                    &lt;PPRibbonButton :icon="cutOutline" label="Cut" size="small" /&gt;
                    &lt;PPRibbonButton :icon="copyOutline" label="Copy" size="small" /&gt;
                    &lt;PPRibbonButton :icon="brushOutline" label="Format Painter" size="small" /&gt;
                  &lt;/div&gt;
                &lt;/PPRibbonGroup&gt;
                &lt;PPRibbonGroup title="Font"&gt;
                  &lt;div class="font-controls"&gt;
                    &lt;div class="font-row"&gt;
                      &lt;select class="ribbon-select font-family"&gt;
                        &lt;option&gt;Calibri (Body)&lt;/option&gt;
                        &lt;option&gt;Arial&lt;/option&gt;
                        &lt;option&gt;Times New Roman&lt;/option&gt;
                      &lt;/select&gt;
                      &lt;select class="ribbon-select font-size"&gt;
                        &lt;option&gt;11&lt;/option&gt;
                        &lt;option&gt;12&lt;/option&gt;
                        &lt;option&gt;14&lt;/option&gt;
                      &lt;/select&gt;
                    &lt;/div&gt;
                    &lt;div class="font-row action-row"&gt;
                      &lt;button class="ribbon-icon-btn"&gt;&lt;b&gt;B&lt;/b&gt;&lt;/button&gt;
                      &lt;button class="ribbon-icon-btn"&gt;&lt;i&gt;I&lt;/i&gt;&lt;/button&gt;
                      &lt;button class="ribbon-icon-btn"&gt;&lt;u&gt;U&lt;/u&gt;&lt;/button&gt;
                      &lt;button class="ribbon-icon-btn"&gt;&lt;del&gt;ab&lt;/del&gt;&lt;/button&gt;
                      &lt;div class="divider"&gt;&lt;/div&gt;
                      &lt;button class="ribbon-icon-btn"&gt;
                        &lt;ion-icon :icon="colorPaletteOutline" /&gt;
                      &lt;/button&gt;
                      &lt;button class="ribbon-icon-btn"&gt;
                        &lt;ion-icon :icon="textOutline" /&gt;
                      &lt;/button&gt;
                    &lt;/div&gt;
                  &lt;/div&gt;
                &lt;/PPRibbonGroup&gt;
                &lt;PPRibbonGroup title="Paragraph"&gt;
                  &lt;div class="font-controls"&gt;
                    &lt;div class="font-row action-row"&gt;
                      &lt;button class="ribbon-icon-btn"&gt;&lt;ion-icon :icon="listOutline" /&gt;&lt;/button&gt;
                      &lt;button class="ribbon-icon-btn"&gt;&lt;ion-icon :icon="listCircleOutline" /&gt;&lt;/button&gt;
                      &lt;div class="divider"&gt;&lt;/div&gt;
                      &lt;button class="ribbon-icon-btn"&gt;&lt;ion-icon :icon="reorderFourOutline" /&gt;&lt;/button&gt;
                    &lt;/div&gt;
                    &lt;div class="font-row action-row"&gt;
                      &lt;button class="ribbon-icon-btn"&gt;&lt;ion-icon :icon="menuOutline" style="transform: scaleX(-1)"/&gt;&lt;/button&gt;
                      &lt;button class="ribbon-icon-btn"&gt;&lt;ion-icon :icon="menuOutline" /&gt;&lt;/button&gt;
                      &lt;button class="ribbon-icon-btn"&gt;&lt;ion-icon :icon="menuOutline" style="transform: scaleX(-1)"/&gt;&lt;/button&gt;
                      &lt;button class="ribbon-icon-btn"&gt;&lt;ion-icon :icon="menuOutline" /&gt;&lt;/button&gt;
                    &lt;/div&gt;
                  &lt;/div&gt;
                &lt;/PPRibbonGroup&gt;
                &lt;PPRibbonGroup title="Styles"&gt;
                  &lt;div class="vertical-group"&gt;
                    &lt;PPContextMenu :items="conditionalFormattingItems" placement="bottom-left"&gt;
                      &lt;template #trigger&gt;
                        &lt;PPRibbonButton :icon="colorPaletteOutline" label="Conditional Formatting" size="small" /&gt;
                      &lt;/template&gt;
                    &lt;/PPContextMenu&gt;
                  &lt;/div&gt;
                &lt;/PPRibbonGroup&gt;
                &lt;PPRibbonGroup title="Editing"&gt;
                  &lt;div class="vertical-group"&gt;
                    &lt;PPRibbonButton :icon="searchOutline" label="Find" size="small" /&gt;
                    &lt;PPRibbonButton :icon="swapHorizontalOutline" label="Replace" size="small" /&gt;
                    &lt;PPRibbonButton :icon="gitCommitOutline" label="Select" size="small" /&gt;
                  &lt;/div&gt;
                &lt;/PPRibbonGroup&gt;
              &lt;/PPRibbonTab&gt;
              &lt;PPRibbonTab title="Insert"&gt;
                &lt;PPRibbonGroup title="Pages"&gt;
                  &lt;PPRibbonButton :icon="documentOutline" label="Blank Page" size="large" /&gt;
                  &lt;PPRibbonButton :icon="albumsOutline" label="Page Break" size="large" /&gt;
                &lt;/PPRibbonGroup&gt;
                &lt;PPRibbonGroup title="Tables"&gt;
                  &lt;PPRibbonButton :icon="gridOutline" label="Table" size="large" /&gt;
                &lt;/PPRibbonGroup&gt;
                &lt;PPRibbonGroup title="Illustrations"&gt;
                  &lt;PPRibbonButton :icon="imageOutline" label="Pictures" /&gt;
                  &lt;PPRibbonButton :icon="shapesOutline" label="Shapes" /&gt;
                  &lt;PPRibbonButton :icon="barChartOutline" label="Chart" /&gt;
                &lt;/PPRibbonGroup&gt;
              &lt;/PPRibbonTab&gt;
              &lt;PPRibbonTab title="Layout"&gt;
                &lt;PPRibbonGroup title="Page Setup"&gt;
                  &lt;PPRibbonButton :icon="readerOutline" label="Margins" size="large" /&gt;
                  &lt;PPRibbonButton :icon="phonePortraitOutline" label="Orientation" size="large" /&gt;
                  &lt;PPRibbonButton :icon="resizeOutline" label="Size" size="large" /&gt;
                &lt;/PPRibbonGroup&gt;
              &lt;/PPRibbonTab&gt;
              &lt;PPRibbonTab title="Review" /&gt;
              &lt;PPRibbonTab title="View" /&gt;
            &lt;/PPRibbon&gt;
          &lt;/div&gt;

          &lt;!-- Main Workspace --&gt;
          &lt;main class="workspace"&gt;
            &lt;div class="document-page"&gt;
              &lt;PPRichTextEditor v-model="documentContent" placeholder="Type here..." /&gt;
            &lt;/div&gt;
          &lt;/main&gt;

          &lt;!-- Status Bar --&gt;
          &lt;footer class="status-bar"&gt;
            &lt;div class="status-left"&gt;
              &lt;span&gt;Page 1 of 1&lt;/span&gt;
              &lt;span&gt;0 words&lt;/span&gt;
              &lt;span&gt;English (US)&lt;/span&gt;
            &lt;/div&gt;
            &lt;div class="status-right"&gt;
              &lt;div class="view-modes"&gt;
                &lt;ion-icon :icon="bookOutline" /&gt;
                &lt;ion-icon :icon="readerOutline" class="active" /&gt;
                &lt;ion-icon :icon="globeOutline" /&gt;
              &lt;/div&gt;
              &lt;div class="zoom-control"&gt;
                &lt;ion-icon :icon="removeOutline" /&gt;
                &lt;input type="range" min="10" max="200" value="100" class="zoom-slider" /&gt;
                &lt;ion-icon :icon="addOutline" /&gt;
                &lt;span&gt;100%&lt;/span&gt;
              &lt;/div&gt;
            &lt;/div&gt;
          &lt;/footer&gt;
        &lt;/div&gt;
      &lt;/div&gt;
    &lt;/div&gt;

    &lt;!-- Basic Variants --&gt;
    &lt;div class="variant-group" style="margin-top: 32px;"&gt;
      &lt;h3&gt;Modern Ribbon&lt;/h3&gt;
      &lt;p class="custom-guide"&gt;A cleaner, flatter ribbon style with underlined active tabs, similar to modern web office apps.&lt;/p&gt;

      &lt;div class="component-demo" style="padding: 0; overflow: hidden; border-radius: 8px; border: 1px solid #e5e7eb; background: #f9fafb;"&gt;
        &lt;PPRibbon variant="modern"&gt;
          &lt;PPRibbonTab title="Home"&gt;
            &lt;PPRibbonGroup title="Clipboard"&gt;
              &lt;PPRibbonButton :icon="clipboardOutline" label="Paste" /&gt;
              &lt;PPRibbonButton :icon="cutOutline" label="Cut" /&gt;
            &lt;/PPRibbonGroup&gt;
          &lt;/PPRibbonTab&gt;
          &lt;PPRibbonTab title="Insert"&gt;
            &lt;PPRibbonGroup title="Media"&gt;
              &lt;PPRibbonButton :icon="imageOutline" label="Pictures" /&gt;
            &lt;/PPRibbonGroup&gt;
          &lt;/PPRibbonTab&gt;
        &lt;/PPRibbon&gt;
        &lt;div style="height: 100px; background: white; padding: 16px; border-top: 1px solid #e5e7eb;"&gt;
          &lt;p style="color: #4b5563; margin: 0; font-size: 14px;"&gt;Modern ribbon content area.&lt;/p&gt;
        &lt;/div&gt;
      &lt;/div&gt;
    &lt;/div&gt;

    &lt;div class="variant-group" style="margin-top: 32px;"&gt;
      &lt;h3&gt;Glass Ribbon&lt;/h3&gt;
      &lt;p class="custom-guide"&gt;A translucent glassmorphism ribbon, great for placing over gradients or imagery.&lt;/p&gt;

      &lt;div class="component-demo" style="padding: 24px; overflow: hidden; border-radius: 8px; background: linear-gradient(135deg, #a8edea 0%, #fed6e3 100%);"&gt;
        &lt;PPRibbon variant="glass"&gt;
          &lt;PPRibbonTab title="Home"&gt;
            &lt;PPRibbonGroup title="Clipboard"&gt;
              &lt;PPRibbonButton :icon="clipboardOutline" label="Paste" /&gt;
              &lt;PPRibbonButton :icon="copyOutline" label="Copy" /&gt;
            &lt;/PPRibbonGroup&gt;
          &lt;/PPRibbonTab&gt;
          &lt;PPRibbonTab title="Insert"&gt;
            &lt;PPRibbonGroup title="Media"&gt;
              &lt;PPRibbonButton :icon="imageOutline" label="Pictures" /&gt;
            &lt;/PPRibbonGroup&gt;
          &lt;/PPRibbonTab&gt;
        &lt;/PPRibbon&gt;
      &lt;/div&gt;
      
      &lt;pre class="code-block" style="margin-top: 16px;"&gt;&lt;code&gt;&amp;lt;PPRibbon variant="classic | modern | glass" :collapsible="true"&amp;gt;
  &amp;lt;PPRibbonTab title="Home"&amp;gt;
    &amp;lt;PPRibbonGroup title="Clipboard"&amp;gt;
      &amp;lt;PPRibbonButton :icon="clipboardOutline" label="Paste" /&amp;gt;
    &amp;lt;/PPRibbonGroup&amp;gt;
  &amp;lt;/PPRibbonTab&amp;gt;
&amp;lt;/PPRibbon&amp;gt;&lt;/code&gt;&lt;/pre&gt;
    &lt;/div&gt;
    &lt;!-- Image Editor Layout --&gt;
    &lt;div class="variant-group" style="margin-top: 32px;"&gt;
      &lt;h3&gt;Image Editor (Dark Mode)&lt;/h3&gt;
      &lt;p class="custom-guide"&gt;A sleek, dark-themed ribbon layout perfect for creative applications like photo editors or design tools.&lt;/p&gt;

      &lt;div class="component-demo app-window-wrapper dark-editor"&gt;
        &lt;div class="dark-layout"&gt;
          &lt;!-- Ribbon --&gt;
          &lt;div class="ribbon-container-dark"&gt;
            &lt;PPRibbon variant="modern" :collapsible="true" model-value="tools"&gt;
              &lt;PPRibbonTab title="File" /&gt;
              &lt;PPRibbonTab title="Tools" id="tools"&gt;
                &lt;PPRibbonGroup title="Select"&gt;
                  &lt;PPRibbonButton :icon="cropOutline" label="Crop" size="large" /&gt;
                  &lt;div class="vertical-group"&gt;
                    &lt;PPRibbonButton :icon="searchOutline" label="Zoom" size="small" /&gt;
                    &lt;PPRibbonButton :icon="gitCommitOutline" label="Magic" size="small" /&gt;
                  &lt;/div&gt;
                &lt;/PPRibbonGroup&gt;
                &lt;PPRibbonGroup title="Adjust"&gt;
                  &lt;PPRibbonButton :icon="contrastOutline" label="Brightness" size="large" /&gt;
                  &lt;PPRibbonButton :icon="colorFilterOutline" label="Filter" size="large" /&gt;
                &lt;/PPRibbonGroup&gt;
                &lt;PPRibbonGroup title="Draw"&gt;
                  &lt;PPRibbonButton :icon="pencilOutline" label="Pencil" size="large" /&gt;
                  &lt;PPRibbonButton :icon="brushOutline" label="Brush" size="large" /&gt;
                  &lt;PPRibbonButton :icon="colorPaletteOutline" label="Palette" size="large" /&gt;
                &lt;/PPRibbonGroup&gt;
              &lt;/PPRibbonTab&gt;
              &lt;PPRibbonTab title="View" /&gt;
            &lt;/PPRibbon&gt;
          &lt;/div&gt;
          &lt;!-- Canvas Area --&gt;
          &lt;div class="dark-workspace"&gt;
            &lt;div class="editor-canvas"&gt;
              &lt;div class="canvas-image"&gt;
                &lt;ion-icon :icon="imageOutline" style="font-size: 64px; color: #4b5563;" /&gt;
                &lt;span style="color: #6b7280; margin-top: 16px;"&gt;Drag and drop an image here&lt;/span&gt;
              &lt;/div&gt;
            &lt;/div&gt;
          &lt;/div&gt;
        &lt;/div&gt;
      &lt;/div&gt;
    &lt;/div&gt;

    &lt;!-- File Explorer Layout --&gt;
    &lt;div class="variant-group" style="margin-top: 32px;"&gt;
      &lt;h3&gt;File Explorer&lt;/h3&gt;
      &lt;p class="custom-guide"&gt;A compact ribbon layout simulating a modern OS file manager with breadcrumb navigation.&lt;/p&gt;

      &lt;div class="component-demo app-window-wrapper explorer-app"&gt;
        &lt;div class="explorer-layout"&gt;
          &lt;div class="ribbon-container-explorer"&gt;
            &lt;PPRibbon variant="classic" :collapsible="true" model-value="home"&gt;
              &lt;PPRibbonTab title="Home" id="home"&gt;
                &lt;PPRibbonGroup title="Clipboard"&gt;
                  &lt;PPRibbonButton :icon="copyOutline" label="Copy" size="large" /&gt;
                  &lt;PPRibbonButton :icon="clipboardOutline" label="Paste" size="large" /&gt;
                &lt;/PPRibbonGroup&gt;
                &lt;PPRibbonGroup title="Organize"&gt;
                  &lt;div class="vertical-group"&gt;
                    &lt;PPRibbonButton :icon="folderOutline" label="Move to" size="small" /&gt;
                    &lt;PPRibbonButton :icon="copyOutline" label="Copy to" size="small" /&gt;
                    &lt;PPRibbonButton :icon="closeOutline" label="Delete" size="small" /&gt;
                  &lt;/div&gt;
                &lt;/PPRibbonGroup&gt;
                &lt;PPRibbonGroup title="New"&gt;
                  &lt;PPRibbonButton :icon="folderOpenOutline" label="New Folder" size="large" /&gt;
                  &lt;PPRibbonButton :icon="documentTextOutline" label="New Item" size="large" /&gt;
                &lt;/PPRibbonGroup&gt;
              &lt;/PPRibbonTab&gt;
              &lt;PPRibbonTab title="Share" /&gt;
              &lt;PPRibbonTab title="View"&gt;
                &lt;PPRibbonGroup title="Layout"&gt;
                  &lt;PPRibbonButton :icon="gridOutline" label="Large Icons" size="large" /&gt;
                  &lt;PPRibbonButton :icon="listOutline" label="Details" size="large" /&gt;
                &lt;/PPRibbonGroup&gt;
              &lt;/PPRibbonTab&gt;
            &lt;/PPRibbon&gt;
          &lt;/div&gt;
          
          &lt;div class="explorer-toolbar"&gt;
            &lt;div class="nav-buttons"&gt;
              &lt;ion-icon :icon="arrowUndoOutline" /&gt;
              &lt;ion-icon :icon="arrowRedoOutline" /&gt;
              &lt;ion-icon :icon="arrowUndoOutline" style="transform: rotate(90deg);" /&gt;
            &lt;/div&gt;
            &lt;div class="address-bar"&gt;
              &lt;ion-icon :icon="folderOutline" /&gt;
              &lt;span&gt;This PC &gt; Documents &gt; Projects&lt;/span&gt;
            &lt;/div&gt;
            &lt;div class="search-box"&gt;
              &lt;ion-icon :icon="searchOutline" /&gt;
              &lt;span&gt;Search Projects&lt;/span&gt;
            &lt;/div&gt;
          &lt;/div&gt;

          &lt;div class="explorer-body"&gt;
            &lt;div class="sidebar"&gt;
              &lt;ul&gt;
                &lt;li&gt;&lt;ion-icon :icon="desktopOutline" /&gt; Desktop&lt;/li&gt;
                &lt;li&gt;&lt;ion-icon :icon="downloadOutline" /&gt; Downloads&lt;/li&gt;
                &lt;li class="active"&gt;&lt;ion-icon :icon="documentTextOutline" /&gt; Documents&lt;/li&gt;
                &lt;li&gt;&lt;ion-icon :icon="imageOutline" /&gt; Pictures&lt;/li&gt;
              &lt;/ul&gt;
            &lt;/div&gt;
            &lt;div class="file-grid"&gt;
              &lt;div class="file-item"&gt;
                &lt;ion-icon :icon="folderOutline" class="folder-icon" /&gt;
                &lt;span&gt;ui-framework&lt;/span&gt;
              &lt;/div&gt;
              &lt;div class="file-item"&gt;
                &lt;ion-icon :icon="folderOutline" class="folder-icon" /&gt;
                &lt;span&gt;assets&lt;/span&gt;
              &lt;/div&gt;
              &lt;div class="file-item"&gt;
                &lt;ion-icon :icon="documentTextOutline" class="doc-icon" /&gt;
                &lt;span&gt;README.md&lt;/span&gt;
              &lt;/div&gt;
              &lt;div class="file-item"&gt;
                &lt;ion-icon :icon="imageOutline" class="img-icon" /&gt;
                &lt;span&gt;logo.png&lt;/span&gt;
              &lt;/div&gt;
            &lt;/div&gt;
          &lt;/div&gt;
        &lt;/div&gt;
      &lt;/div&gt;
      &lt;pre class="code-block" style="margin-top: 16px;"&gt;&lt;code&gt;&amp;lt;PPRibbon variant="classic" :collapsible="true" model-value="home"&amp;gt;
  &amp;lt;PPRibbonTab title="Home" id="home"&amp;gt;
    &amp;lt;PPRibbonGroup title="Clipboard"&amp;gt;
      &amp;lt;PPRibbonButton :icon="copyOutline" label="Copy" size="large" /&amp;gt;
      &amp;lt;PPRibbonButton :icon="clipboardOutline" label="Paste" size="large" /&amp;gt;
    &amp;lt;/PPRibbonGroup&amp;gt;
    &amp;lt;PPRibbonGroup title="Organize"&amp;gt;
      &amp;lt;div class="vertical-group"&amp;gt;
        &amp;lt;PPRibbonButton :icon="folderOutline" label="Move to" size="small" /&amp;gt;
        &amp;lt;PPRibbonButton :icon="copyOutline" label="Copy to" size="small" /&amp;gt;
        &amp;lt;PPRibbonButton :icon="closeOutline" label="Delete" size="small" /&amp;gt;
      &amp;lt;/div&amp;gt;
    &amp;lt;/PPRibbonGroup&amp;gt;
  &amp;lt;/PPRibbonTab&amp;gt;
&amp;lt;/PPRibbon&amp;gt;&lt;/code&gt;&lt;/pre&gt;
    &lt;/div&gt;
  
        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Customizing CSS&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;You can override the component's appearance globally via CSS variables or by targeting its specific classes.&lt;/p&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;/* Override globally */
:root {
  --pp-primary-variant: /* value */;
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
import { IonIcon } from '@ionic/vue';
import { 
  saveOutline, arrowUndoOutline, arrowRedoOutline, removeOutline, stopOutline, closeOutline,
  clipboardOutline, cutOutline, copyOutline, brushOutline, colorPaletteOutline, textOutline,
  listOutline, listCircleOutline, reorderFourOutline, menuOutline, searchOutline, swapHorizontalOutline,
  gitCommitOutline, documentOutline, albumsOutline, gridOutline, imageOutline, shapesOutline,
  barChartOutline, readerOutline, phonePortraitOutline, resizeOutline, bookOutline, globeOutline,
  addOutline,
  folderOutline, folderOpenOutline, documentTextOutline, settingsOutline,
  cropOutline, contrastOutline, colorFilterOutline, pencilOutline,
  desktopOutline, downloadOutline
} from 'ionicons/icons';
import { 
  PPRibbon, PPRibbonTab, PPRibbonGroup, PPRibbonButton, PPIconButton, PPRichTextEditor, PPContextMenu
} from '@phanna/ui-framework';

const documentContent = ref('');

const conditionalFormattingItems = [
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
  { label: 'New Rule', icon: addOutline },
  { 
    label: 'Clear Rules', 
    icon: removeOutline,
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

/* Wrapper for the embedded app window */
.app-window-wrapper {
  padding: 0;
  overflow: hidden;
  border-radius: 8px;
  border: 1px solid #e5e7eb;
  background: #f9fafb;
  height: 600px;
  position: relative;
  box-shadow: 0 10px 25px rgba(0,0,0,0.1);
}

.word-layout {
  display: flex;
  flex-direction: column;
  height: 100%;
  width: 100%;
  background-color: #f3f2f1;
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  overflow: hidden;
}

/* Header */
.window-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  height: 48px;
  background-color: #2b579a;
  color: white;
  padding: 0 8px;
  user-select: none;
}
.header-left, .header-right {
  display: flex;
  align-items: center;
  gap: 4px;
}
.app-icon {
  width: 32px;
  height: 32px;
  background: rgba(255,255,255,0.1);
  border-radius: 4px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: bold;
  font-size: 18px;
  margin-right: 8px;
}
.quick-access {
  display: flex;
  gap: 2px;
}
.quick-access ion-icon {
  color: white;
}
.header-center {
  font-size: 14px;
  flex: 1;
  text-align: center;
}
.header-right ion-icon {
  color: white;
}
.close-btn:hover {
  background-color: #e81123 !important;
}

/* Ribbon Overrides */
.ribbon-container {
  background-color: #f3f2f1;
  border-bottom: 1px solid #c8c6c4;
  --pp-primary-variant: #2b579a;
}
:deep(.pp-ribbon-tabs) {
  padding: 0 8px;
}
:deep(.pp-ribbon--classic .pp-ribbon-header) {
  padding-top: 0;
}
:deep(.pp-ribbon--classic .pp-ribbon-tab-header) {
  border-top-left-radius: 0;
  border-top-right-radius: 0;
}

/* Custom Controls inside Ribbon */
.vertical-group {
  display: flex;
  flex-direction: column;
  gap: 2px;
}
.font-controls {
  display: flex;
  flex-direction: column;
  gap: 4px;
  padding: 0 8px;
}
.font-row {
  display: flex;
  align-items: center;
  gap: 4px;
}
.ribbon-select {
  border: 1px solid #c8c6c4;
  border-radius: 2px;
  padding: 2px 4px;
  font-size: 12px;
  background: white;
  height: 24px;
}
.font-family { width: 120px; }
.font-size { width: 48px; }
.ribbon-icon-btn {
  width: 24px;
  height: 24px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: transparent;
  border: 1px solid transparent;
  border-radius: 2px;
  cursor: pointer;
  color: #323130;
  font-size: 14px;
}
.ribbon-icon-btn:hover {
  background-color: #e1dfdd;
  border-color: #c8c6c4;
}
.divider {
  width: 1px;
  height: 16px;
  background-color: #c8c6c4;
  margin: 0 4px;
}

/* Workspace */
.workspace {
  flex: 1;
  background-color: #e1dfdd;
  overflow-y: auto;
  padding: 32px 0;
  display: flex;
  justify-content: center;
}
.document-page {
  width: 80%;
  max-width: 816px;
  min-height: 1056px;
  background-color: white;
  box-shadow: 0 2px 6px rgba(0,0,0,0.2);
  padding: 48px 10%;
}
:deep(.pp-rte-container) {
  border: none !important;
  box-shadow: none !important;
  border-radius: 0 !important;
  background: transparent !important;
  min-height: 100%;
}
:deep(.pp-rte-container.is-focused) {
  border: none !important;
  box-shadow: none !important;
}
:deep(.pp-rte-container .pp-rte-toolbar) {
  display: none !important;
}

/* Status Bar */
.status-bar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  height: 24px;
  background-color: #f3f2f1;
  border-top: 1px solid #c8c6c4;
  padding: 0 16px;
  font-size: 12px;
  color: #605e5c;
  user-select: none;
}
.status-left, .status-right {
  display: flex;
  align-items: center;
  gap: 16px;
}
.status-left span:hover {
  background-color: #e1dfdd;
  cursor: pointer;
}
.view-modes {
  display: flex;
  gap: 8px;
}
.view-modes ion-icon {
  font-size: 16px;
  cursor: pointer;
  padding: 2px;
}
.view-modes ion-icon:hover {
  background-color: #e1dfdd;
}
.view-modes ion-icon.active {
  background-color: #c8c6c4;
}
.zoom-control {
  display: flex;
  align-items: center;
  gap: 8px;
}
.zoom-slider {
  width: 100px;
}
.zoom-control ion-icon {
  cursor: pointer;
}

/* Dark Image Editor Layout Styles */
.dark-editor {
  height: 500px;
}
.dark-layout {
  display: flex;
  flex-direction: column;
  height: 100%;
  background-color: #1f2937;
  color: #e5e7eb;
}
.ribbon-container-dark {
  --pp-primary-variant: #60a5fa;
}
.ribbon-container-dark :deep(.pp-ribbon--modern) {
  background-color: #111827;
  border-bottom: 1px solid #374151;
  color: #e5e7eb;
}
.ribbon-container-dark :deep(.pp-ribbon-tab-header) {
  color: #9ca3af;
}
.ribbon-container-dark :deep(.pp-ribbon-tab-header:hover) {
  color: #f3f4f6;
}
.ribbon-container-dark :deep(.pp-ribbon-tab-header--active) {
  color: #60a5fa;
  border-bottom-color: #60a5fa;
}
.ribbon-container-dark :deep(.pp-ribbon-body) {
  background-color: #1f2937;
}
.ribbon-container-dark :deep(.pp-ribbon-button) {
  color: #e5e7eb;
}
.ribbon-container-dark :deep(.pp-ribbon-button:hover) {
  background-color: #374151;
  border-color: #4b5563;
}
.ribbon-container-dark :deep(.pp-ribbon-group-title) {
  color: #9ca3af;
  border-top-color: #4b5563;
}
.ribbon-container-dark :deep(.pp-ribbon-group:not(:last-child)::after) {
  background: linear-gradient(to bottom, transparent, #4b5563, transparent);
}
.dark-workspace {
  flex: 1;
  background-color: #111827;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 32px;
  overflow: auto;
}
.editor-canvas {
  width: 100%;
  height: 100%;
  background-color: #1f2937;
  border: 2px dashed #374151;
  border-radius: 8px;
  display: flex;
  align-items: center;
  justify-content: center;
}
.canvas-image {
  display: flex;
  flex-direction: column;
  align-items: center;
}

/* File Explorer Layout Styles */
.explorer-app {
  height: 500px;
}
.explorer-layout {
  display: flex;
  flex-direction: column;
  height: 100%;
  background-color: #ffffff;
}
.ribbon-container-explorer {
  --pp-primary-variant: #0078d7;
}
.explorer-toolbar {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 8px 16px;
  background-color: #f3f4f6;
  border-bottom: 1px solid #e5e7eb;
}
.nav-buttons {
  display: flex;
  gap: 8px;
  color: #6b7280;
  font-size: 20px;
}
.nav-buttons ion-icon {
  cursor: pointer;
}
.nav-buttons ion-icon:hover {
  color: #111827;
}
.address-bar {
  flex: 1;
  display: flex;
  align-items: center;
  gap: 8px;
  background: white;
  border: 1px solid #d1d5db;
  padding: 4px 12px;
  border-radius: 4px;
  font-size: 13px;
  color: #374151;
}
.address-bar ion-icon {
  color: #60a5fa;
}
.search-box {
  width: 200px;
  display: flex;
  align-items: center;
  gap: 8px;
  background: white;
  border: 1px solid #d1d5db;
  padding: 4px 12px;
  border-radius: 4px;
  font-size: 13px;
  color: #9ca3af;
}
.explorer-body {
  flex: 1;
  display: flex;
  overflow: hidden;
}
.sidebar {
  width: 200px;
  background: #f9fafb;
  border-right: 1px solid #e5e7eb;
  padding: 16px 0;
}
.sidebar ul {
  list-style: none;
  padding: 0;
  margin: 0;
}
.sidebar li {
  padding: 8px 24px;
  display: flex;
  align-items: center;
  gap: 12px;
  font-size: 13px;
  color: #4b5563;
  cursor: pointer;
}
.sidebar li:hover {
  background-color: #e5e7eb;
}
.sidebar li.active {
  background-color: #dbeafe;
  color: #1d4ed8;
  font-weight: 500;
}
.sidebar li.active ion-icon {
  color: #3b82f6;
}
.file-grid {
  flex: 1;
  padding: 24px;
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(100px, 1fr));
  grid-auto-rows: min-content;
  gap: 16px;
  background: white;
  overflow-y: auto;
}
.file-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8px;
  padding: 12px;
  border-radius: 4px;
  cursor: pointer;
  text-align: center;
}
.file-item:hover {
  background-color: #f3f4f6;
}
.file-item span {
  font-size: 12px;
  color: #111827;
  word-break: break-word;
}
.folder-icon { font-size: 48px; color: #fbbf24; }
.doc-icon { font-size: 48px; color: #3b82f6; }
.img-icon { font-size: 48px; color: #10b981; }
&lt;/style&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { IonIcon } from '@ionic/vue';
import { 
  saveOutline, arrowUndoOutline, arrowRedoOutline, removeOutline, stopOutline, closeOutline,
  clipboardOutline, cutOutline, copyOutline, brushOutline, colorPaletteOutline, textOutline,
  listOutline, listCircleOutline, reorderFourOutline, menuOutline, searchOutline, swapHorizontalOutline,
  gitCommitOutline, documentOutline, albumsOutline, gridOutline, imageOutline, shapesOutline,
  barChartOutline, readerOutline, phonePortraitOutline, resizeOutline, bookOutline, globeOutline,
  addOutline,
  folderOutline, folderOpenOutline, documentTextOutline, settingsOutline,
  cropOutline, contrastOutline, colorFilterOutline, pencilOutline,
  desktopOutline, downloadOutline
} from 'ionicons/icons';
import { 
  PPRibbon, PPRibbonTab, PPRibbonGroup, PPRibbonButton, PPIconButton, PPRichTextEditor, PPContextMenu
} from '@phanna/ui-framework';

const documentContent = ref('');

const conditionalFormattingItems = [
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
  { label: 'New Rule', icon: addOutline },
  { 
    label: 'Clear Rules', 
    icon: removeOutline,
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

/* Wrapper for the embedded app window */
.app-window-wrapper {
  padding: 0;
  overflow: hidden;
  border-radius: 8px;
  border: 1px solid #e5e7eb;
  background: #f9fafb;
  height: 600px;
  position: relative;
  box-shadow: 0 10px 25px rgba(0,0,0,0.1);
}

.word-layout {
  display: flex;
  flex-direction: column;
  height: 100%;
  width: 100%;
  background-color: #f3f2f1;
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  overflow: hidden;
}

/* Header */
.window-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  height: 48px;
  background-color: #2b579a;
  color: white;
  padding: 0 8px;
  user-select: none;
}
.header-left, .header-right {
  display: flex;
  align-items: center;
  gap: 4px;
}
.app-icon {
  width: 32px;
  height: 32px;
  background: rgba(255,255,255,0.1);
  border-radius: 4px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: bold;
  font-size: 18px;
  margin-right: 8px;
}
.quick-access {
  display: flex;
  gap: 2px;
}
.quick-access ion-icon {
  color: white;
}
.header-center {
  font-size: 14px;
  flex: 1;
  text-align: center;
}
.header-right ion-icon {
  color: white;
}
.close-btn:hover {
  background-color: #e81123 !important;
}

/* Ribbon Overrides */
.ribbon-container {
  background-color: #f3f2f1;
  border-bottom: 1px solid #c8c6c4;
  --pp-primary-variant: #2b579a;
}
:deep(.pp-ribbon-tabs) {
  padding: 0 8px;
}
:deep(.pp-ribbon--classic .pp-ribbon-header) {
  padding-top: 0;
}
:deep(.pp-ribbon--classic .pp-ribbon-tab-header) {
  border-top-left-radius: 0;
  border-top-right-radius: 0;
}

/* Custom Controls inside Ribbon */
.vertical-group {
  display: flex;
  flex-direction: column;
  gap: 2px;
}
.font-controls {
  display: flex;
  flex-direction: column;
  gap: 4px;
  padding: 0 8px;
}
.font-row {
  display: flex;
  align-items: center;
  gap: 4px;
}
.ribbon-select {
  border: 1px solid #c8c6c4;
  border-radius: 2px;
  padding: 2px 4px;
  font-size: 12px;
  background: white;
  height: 24px;
}
.font-family { width: 120px; }
.font-size { width: 48px; }
.ribbon-icon-btn {
  width: 24px;
  height: 24px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: transparent;
  border: 1px solid transparent;
  border-radius: 2px;
  cursor: pointer;
  color: #323130;
  font-size: 14px;
}
.ribbon-icon-btn:hover {
  background-color: #e1dfdd;
  border-color: #c8c6c4;
}
.divider {
  width: 1px;
  height: 16px;
  background-color: #c8c6c4;
  margin: 0 4px;
}

/* Workspace */
.workspace {
  flex: 1;
  background-color: #e1dfdd;
  overflow-y: auto;
  padding: 32px 0;
  display: flex;
  justify-content: center;
}
.document-page {
  width: 80%;
  max-width: 816px;
  min-height: 1056px;
  background-color: white;
  box-shadow: 0 2px 6px rgba(0,0,0,0.2);
  padding: 48px 10%;
}
:deep(.pp-rte-container) {
  border: none !important;
  box-shadow: none !important;
  border-radius: 0 !important;
  background: transparent !important;
  min-height: 100%;
}
:deep(.pp-rte-container.is-focused) {
  border: none !important;
  box-shadow: none !important;
}
:deep(.pp-rte-container .pp-rte-toolbar) {
  display: none !important;
}

/* Status Bar */
.status-bar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  height: 24px;
  background-color: #f3f2f1;
  border-top: 1px solid #c8c6c4;
  padding: 0 16px;
  font-size: 12px;
  color: #605e5c;
  user-select: none;
}
.status-left, .status-right {
  display: flex;
  align-items: center;
  gap: 16px;
}
.status-left span:hover {
  background-color: #e1dfdd;
  cursor: pointer;
}
.view-modes {
  display: flex;
  gap: 8px;
}
.view-modes ion-icon {
  font-size: 16px;
  cursor: pointer;
  padding: 2px;
}
.view-modes ion-icon:hover {
  background-color: #e1dfdd;
}
.view-modes ion-icon.active {
  background-color: #c8c6c4;
}
.zoom-control {
  display: flex;
  align-items: center;
  gap: 8px;
}
.zoom-slider {
  width: 100px;
}
.zoom-control ion-icon {
  cursor: pointer;
}

/* Dark Image Editor Layout Styles */
.dark-editor {
  height: 500px;
}
.dark-layout {
  display: flex;
  flex-direction: column;
  height: 100%;
  background-color: #1f2937;
  color: #e5e7eb;
}
.ribbon-container-dark {
  --pp-primary-variant: #60a5fa;
}
.ribbon-container-dark :deep(.pp-ribbon--modern) {
  background-color: #111827;
  border-bottom: 1px solid #374151;
  color: #e5e7eb;
}
.ribbon-container-dark :deep(.pp-ribbon-tab-header) {
  color: #9ca3af;
}
.ribbon-container-dark :deep(.pp-ribbon-tab-header:hover) {
  color: #f3f4f6;
}
.ribbon-container-dark :deep(.pp-ribbon-tab-header--active) {
  color: #60a5fa;
  border-bottom-color: #60a5fa;
}
.ribbon-container-dark :deep(.pp-ribbon-body) {
  background-color: #1f2937;
}
.ribbon-container-dark :deep(.pp-ribbon-button) {
  color: #e5e7eb;
}
.ribbon-container-dark :deep(.pp-ribbon-button:hover) {
  background-color: #374151;
  border-color: #4b5563;
}
.ribbon-container-dark :deep(.pp-ribbon-group-title) {
  color: #9ca3af;
  border-top-color: #4b5563;
}
.ribbon-container-dark :deep(.pp-ribbon-group:not(:last-child)::after) {
  background: linear-gradient(to bottom, transparent, #4b5563, transparent);
}
.dark-workspace {
  flex: 1;
  background-color: #111827;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 32px;
  overflow: auto;
}
.editor-canvas {
  width: 100%;
  height: 100%;
  background-color: #1f2937;
  border: 2px dashed #374151;
  border-radius: 8px;
  display: flex;
  align-items: center;
  justify-content: center;
}
.canvas-image {
  display: flex;
  flex-direction: column;
  align-items: center;
}

/* File Explorer Layout Styles */
.explorer-app {
  height: 500px;
}
.explorer-layout {
  display: flex;
  flex-direction: column;
  height: 100%;
  background-color: #ffffff;
}
.ribbon-container-explorer {
  --pp-primary-variant: #0078d7;
}
.explorer-toolbar {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 8px 16px;
  background-color: #f3f4f6;
  border-bottom: 1px solid #e5e7eb;
}
.nav-buttons {
  display: flex;
  gap: 8px;
  color: #6b7280;
  font-size: 20px;
}
.nav-buttons ion-icon {
  cursor: pointer;
}
.nav-buttons ion-icon:hover {
  color: #111827;
}
.address-bar {
  flex: 1;
  display: flex;
  align-items: center;
  gap: 8px;
  background: white;
  border: 1px solid #d1d5db;
  padding: 4px 12px;
  border-radius: 4px;
  font-size: 13px;
  color: #374151;
}
.address-bar ion-icon {
  color: #60a5fa;
}
.search-box {
  width: 200px;
  display: flex;
  align-items: center;
  gap: 8px;
  background: white;
  border: 1px solid #d1d5db;
  padding: 4px 12px;
  border-radius: 4px;
  font-size: 13px;
  color: #9ca3af;
}
.explorer-body {
  flex: 1;
  display: flex;
  overflow: hidden;
}
.sidebar {
  width: 200px;
  background: #f9fafb;
  border-right: 1px solid #e5e7eb;
  padding: 16px 0;
}
.sidebar ul {
  list-style: none;
  padding: 0;
  margin: 0;
}
.sidebar li {
  padding: 8px 24px;
  display: flex;
  align-items: center;
  gap: 12px;
  font-size: 13px;
  color: #4b5563;
  cursor: pointer;
}
.sidebar li:hover {
  background-color: #e5e7eb;
}
.sidebar li.active {
  background-color: #dbeafe;
  color: #1d4ed8;
  font-weight: 500;
}
.sidebar li.active ion-icon {
  color: #3b82f6;
}
.file-grid {
  flex: 1;
  padding: 24px;
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(100px, 1fr));
  grid-auto-rows: min-content;
  gap: 16px;
  background: white;
  overflow-y: auto;
}
.file-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8px;
  padding: 12px;
  border-radius: 4px;
  cursor: pointer;
  text-align: center;
}
.file-item:hover {
  background-color: #f3f4f6;
}
.file-item span {
  font-size: 12px;
  color: #111827;
  word-break: break-word;
}
.folder-icon { font-size: 48px; color: #fbbf24; }
.doc-icon { font-size: 48px; color: #3b82f6; }
.img-icon { font-size: 48px; color: #10b981; }
</style>
