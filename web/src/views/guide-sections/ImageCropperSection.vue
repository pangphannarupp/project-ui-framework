<template>
  <div class="guide-section">
    <h2>Image Cropper</h2>
    <p>A component that allows users to crop an image to a specific aspect ratio.</p>

    <h3>Basic Usage</h3>
    <div class="demo-box">
      <PPImageCropper 
        src="https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8&w=1000&q=80"
        :aspectRatio="1"
        @crop="handleCrop"
        @cancel="handleCropCancel"
      />
      <div v-if="croppedImage" style="margin-top: 20px;">
        <h4>Cropped Result:</h4>
        <img :src="croppedImage" style="max-width: 200px; border-radius: 8px;" />
      </div>
    </div>
    <pre class="code-block"><code>&lt;PPImageCropper src="..." :aspectRatio="1" @crop="..." @cancel="..." /&gt;</code></pre>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { PPImageCropper } from '@phanna/ui-framework';

const croppedImage = ref('');

const handleCrop = (dataUrl: string) => {
  croppedImage.value = dataUrl;
};

const handleCropCancel = () => {
  alert('Crop cancelled');
};
</script>

<style scoped>
.guide-section { display: flex; flex-direction: column; gap: 24px; }
.demo-box { border: 1px solid #e5e7eb; border-radius: 8px; padding: 24px; background: #f9fafb; }
.code-block {
  background: #1f2937;
  color: #e5e7eb;
  padding: 16px;
  border-radius: 8px;
  overflow-x: auto;
  font-family: 'Fira Code', Consolas, Monaco, 'Andale Mono', 'Ubuntu Mono', monospace;
  font-size: 14px;
  line-height: 1.5;
  margin: 0;
}
</style>
