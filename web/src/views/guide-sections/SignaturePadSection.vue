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
    
    <pre class="code-block"><code>&lt;PPSignaturePad 
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
  </div>
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
