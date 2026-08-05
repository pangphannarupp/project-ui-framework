<template>
  <div class="guide-section">
    <h2>Signature Pad</h2>
    <p>A native canvas-based signature pad that works on both touch and mouse devices.</p>

    <h3>Standard Signature</h3>
    <div class="demo-box">
      <div class="options-toolbar">
        <div class="toolbar-item">
          <ion-icon :icon="colorPaletteOutline" class="toolbar-icon" />
          <input type="color" v-model="penColor" class="color-picker" title="Pen Color" />
        </div>
        
        <div class="toolbar-item">
          <ion-icon :icon="pencilOutline" class="toolbar-icon" />
          <div class="slider-container">
            <input type="range" v-model.number="penSize" min="1" max="10" class="size-slider" title="Pen Size" />
            <span class="size-label">{{ penSize }}px</span>
          </div>
        </div>

        <div class="toolbar-item">
          <ion-icon :icon="brushOutline" class="toolbar-icon" />
          <input type="color" v-model="bgColor" class="color-picker" title="Background Color" />
        </div>
      </div>

      <PPSignaturePad 
        ref="sigPadRef"
        placeholder="Please sign here"
        :strokeColor="penColor"
        :lineWidth="penSize"
        :backgroundColor="bgColor"
        @begin="onBegin"
        @end="onEnd"
      />
      
      <div class="action-buttons">
        <PPButton variant="outline" @click="clearPad">Clear</PPButton>
        <PPButton @click="saveSignature">Save</PPButton>
      </div>

      <div v-if="savedSignature" class="signature-preview">
        <h4>Saved Result:</h4>
        <img :src="savedSignature" alt="Saved signature" />
      </div>
    </div>
    
    <h3>Modal Examples</h3>
    <div class="demo-box" style="flex-direction: row; gap: 16px;">
      <PPButton variant="outline" @click="showAlert = true">Open Alert</PPButton>
      <PPButton @click="showSheet = true">Open Bottom Sheet</PPButton>
    </div>

    <PPSignaturePadAlert
      v-model="showAlert"
      title="Sign Contract"
      @save="onSaveModal"
    />

    <PPSignaturePadSheet
      v-model="showSheet"
      title="Sign Delivery"
      @save="onSaveModal"
    />
    
    <pre class="code-block" v-pre><code>&lt;PPSignaturePad 
  ref="sigPad" 
  placeholder="Sign here" 
  :lineWidth="3" 
  strokeColor="#003399" 
/&gt;

&lt;script setup&gt;
import { ref } from 'vue';

const sigPad = ref(null);

const save = () => {
  if (sigPad.value.isEmpty()) return;
  const base64Image = sigPad.value.getData();
  console.log(base64Image);
};

const clear = () => {
  sigPad.value.clear();
};
&lt;/script&gt;</code></pre>
  
        <div class="variant-group">
          <h3>Customizing CSS</h3>
          <p class="custom-guide">You can override the component's appearance globally via CSS variables or by targeting its specific classes.</p>
          <pre class="code-block" v-pre><code>/* Override globally */
:root {
  --pp-border-color: /* value */;
  --pp-primary-color: /* value */;
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
    &lt;h2&gt;Signature Pad&lt;/h2&gt;
    &lt;p&gt;A native canvas-based signature pad that works on both touch and mouse devices.&lt;/p&gt;

    &lt;h3&gt;Standard Signature&lt;/h3&gt;
    &lt;div class="demo-box"&gt;
      &lt;div class="options-toolbar"&gt;
        &lt;div class="toolbar-item"&gt;
          &lt;ion-icon :icon="colorPaletteOutline" class="toolbar-icon" /&gt;
          &lt;input type="color" v-model="penColor" class="color-picker" title="Pen Color" /&gt;
        &lt;/div&gt;
        
        &lt;div class="toolbar-item"&gt;
          &lt;ion-icon :icon="pencilOutline" class="toolbar-icon" /&gt;
          &lt;div class="slider-container"&gt;
            &lt;input type="range" v-model.number="penSize" min="1" max="10" class="size-slider" title="Pen Size" /&gt;
            &lt;span class="size-label"&gt;{{ penSize }}px&lt;/span&gt;
          &lt;/div&gt;
        &lt;/div&gt;

        &lt;div class="toolbar-item"&gt;
          &lt;ion-icon :icon="brushOutline" class="toolbar-icon" /&gt;
          &lt;input type="color" v-model="bgColor" class="color-picker" title="Background Color" /&gt;
        &lt;/div&gt;
      &lt;/div&gt;

      &lt;PPSignaturePad 
        ref="sigPadRef"
        placeholder="Please sign here"
        :strokeColor="penColor"
        :lineWidth="penSize"
        :backgroundColor="bgColor"
        @begin="onBegin"
        @end="onEnd"
      /&gt;
      
      &lt;div class="action-buttons"&gt;
        &lt;PPButton variant="outline" @click="clearPad"&gt;Clear&lt;/PPButton&gt;
        &lt;PPButton @click="saveSignature"&gt;Save&lt;/PPButton&gt;
      &lt;/div&gt;

      &lt;div v-if="savedSignature" class="signature-preview"&gt;
        &lt;h4&gt;Saved Result:&lt;/h4&gt;
        &lt;img :src="savedSignature" alt="Saved signature" /&gt;
      &lt;/div&gt;
    &lt;/div&gt;
    
    &lt;h3&gt;Modal Examples&lt;/h3&gt;
    &lt;div class="demo-box" style="flex-direction: row; gap: 16px;"&gt;
      &lt;PPButton variant="outline" @click="showAlert = true"&gt;Open Alert&lt;/PPButton&gt;
      &lt;PPButton @click="showSheet = true"&gt;Open Bottom Sheet&lt;/PPButton&gt;
    &lt;/div&gt;

    &lt;PPSignaturePadAlert
      v-model="showAlert"
      title="Sign Contract"
      @save="onSaveModal"
    /&gt;

    &lt;PPSignaturePadSheet
      v-model="showSheet"
      title="Sign Delivery"
      @save="onSaveModal"
    /&gt;
    
    &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPSignaturePad 
  ref="sigPad" 
  placeholder="Sign here" 
  :lineWidth="3" 
  strokeColor="#003399" 
/&amp;gt;

&amp;lt;script setup&amp;gt;
import { ref } from 'vue';

const sigPad = ref(null);

const save = () =&gt; {
  if (sigPad.value.isEmpty()) return;
  const base64Image = sigPad.value.getData();
  console.log(base64Image);
};

const clear = () =&gt; {
  sigPad.value.clear();
};
&amp;lt;/script&amp;gt;&lt;/code&gt;&lt;/pre&gt;
  
        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Customizing CSS&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;You can override the component's appearance globally via CSS variables or by targeting its specific classes.&lt;/p&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;/* Override globally */
:root {
  --pp-border-color: /* value */;
  --pp-primary-color: /* value */;
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
import { pencilOutline, colorPaletteOutline, brushOutline } from 'ionicons/icons';
import { PPSignaturePad, PPSignaturePadAlert, PPSignaturePadSheet, PPButton } from '@phanna/ui-framework';

const sigPadRef = ref&lt;any&gt;(null);
const savedSignature = ref&lt;string | null&gt;(null);

const showAlert = ref(false);
const showSheet = ref(false);

const penColor = ref('#000000');
const penSize = ref(2);
const bgColor = ref('#ffffff');

const onBegin = () =&gt; {
  console.log('Started drawing');
};

const onEnd = () =&gt; {
  console.log('Finished drawing');
};

const clearPad = () =&gt; {
  if (sigPadRef.value) {
    sigPadRef.value.clear();
    savedSignature.value = null;
  }
};

const saveSignature = () =&gt; {
  if (sigPadRef.value &amp;&amp; !sigPadRef.value.isEmpty()) {
    savedSignature.value = sigPadRef.value.getData();
  }
};

const onSaveModal = (data: string) =&gt; {
  savedSignature.value = data;
};
&lt;/script&gt;

&lt;style scoped&gt;
.guide-section { display: flex; flex-direction: column; gap: 24px; }
.demo-box { border: 1px solid #e5e7eb; border-radius: 8px; padding: 24px; background: #f9fafb; display: flex; flex-direction: column; gap: 16px; }
.options-toolbar { display: flex; gap: 24px; align-items: center; padding: 12px 20px; background: #ffffff; border: 1px solid #e5e7eb; border-radius: 8px; flex-wrap: wrap; box-shadow: 0 2px 4px rgba(0,0,0,0.02); margin-bottom: 8px; }
.toolbar-item { display: flex; align-items: center; gap: 8px; }
.toolbar-icon { font-size: 20px; color: #4b5563; }
.color-picker { width: 28px; height: 28px; padding: 0; border: none; border-radius: 50%; cursor: pointer; overflow: hidden; }
.color-picker::-webkit-color-swatch-wrapper { padding: 0; }
.color-picker::-webkit-color-swatch { border: 2px solid #e5e7eb; border-radius: 50%; }
.slider-container { display: flex; align-items: center; gap: 8px; }
.size-slider { width: 80px; accent-color: #003399; }
.size-label { font-size: 12px; color: #6b7280; width: 28px; }
.action-buttons { display: flex; gap: 12px; justify-content: flex-end; }
.signature-preview { margin-top: 16px; border-top: 1px solid #e0e0e0; padding-top: 16px; }
.signature-preview img { border: 1px dashed #ccc; background: white; max-width: 100%; height: auto; }
&lt;/style&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { IonIcon } from '@ionic/vue';
import { pencilOutline, colorPaletteOutline, brushOutline } from 'ionicons/icons';
import { PPSignaturePad, PPSignaturePadAlert, PPSignaturePadSheet, PPButton } from '@phanna/ui-framework';

const sigPadRef = ref<any>(null);
const savedSignature = ref<string | null>(null);

const showAlert = ref(false);
const showSheet = ref(false);

const penColor = ref('#000000');
const penSize = ref(2);
const bgColor = ref('#ffffff');

const onBegin = () => {
  console.log('Started drawing');
};

const onEnd = () => {
  console.log('Finished drawing');
};

const clearPad = () => {
  if (sigPadRef.value) {
    sigPadRef.value.clear();
    savedSignature.value = null;
  }
};

const saveSignature = () => {
  if (sigPadRef.value && !sigPadRef.value.isEmpty()) {
    savedSignature.value = sigPadRef.value.getData();
  }
};

const onSaveModal = (data: string) => {
  savedSignature.value = data;
};
</script>

<style scoped>
.guide-section { display: flex; flex-direction: column; gap: 24px; }
.demo-box { border: 1px solid #e5e7eb; border-radius: 8px; padding: 24px; background: #f9fafb; display: flex; flex-direction: column; gap: 16px; }
.options-toolbar { display: flex; gap: 24px; align-items: center; padding: 12px 20px; background: #ffffff; border: 1px solid #e5e7eb; border-radius: 8px; flex-wrap: wrap; box-shadow: 0 2px 4px rgba(0,0,0,0.02); margin-bottom: 8px; }
.toolbar-item { display: flex; align-items: center; gap: 8px; }
.toolbar-icon { font-size: 20px; color: #4b5563; }
.color-picker { width: 28px; height: 28px; padding: 0; border: none; border-radius: 50%; cursor: pointer; overflow: hidden; }
.color-picker::-webkit-color-swatch-wrapper { padding: 0; }
.color-picker::-webkit-color-swatch { border: 2px solid #e5e7eb; border-radius: 50%; }
.slider-container { display: flex; align-items: center; gap: 8px; }
.size-slider { width: 80px; accent-color: #003399; }
.size-label { font-size: 12px; color: #6b7280; width: 28px; }
.action-buttons { display: flex; gap: 12px; justify-content: flex-end; }
.signature-preview { margin-top: 16px; border-top: 1px solid #e0e0e0; padding-top: 16px; }
.signature-preview img { border: 1px dashed #ccc; background: white; max-width: 100%; height: auto; }
</style>
