<template>
  <div class="component-section">
    <h2>Web Toast</h2>
    <p>A desktop-friendly toast component that can be positioned at various corners of the screen.</p>

    <div class="demo-box">
      <h3>Basic Toast</h3>
      <div class="demo-content">
        <div style="display: flex; gap: 12px; flex-wrap: wrap;">
          <PPButton @click="showToast('info', 'top-right')" style="color: white;">Info (Top Right)</PPButton>
          <PPButton @click="showToast('success', 'bottom-right')" style="--pp-primary-variant: #4caf50; color: white;">Success (Bottom Right)</PPButton>
          <PPButton @click="showToast('error', 'top-center')" style="--pp-primary-variant: #f44336; color: white;">Error (Top Center)</PPButton>
          <PPButton @click="showToast('warning', 'bottom-left')" style="--pp-primary-variant: #ff9800; color: white;">Warning (Bottom Left)</PPButton>
        </div>

        <PPWebToast 
          v-model="toastVisible"
          :type="toastType"
          :position="toastPosition"
          title="Notification"
          :message="toastMessage"
        />
      </div>
      <pre class="code-block"><code>&lt;PPWebToast 
  v-model="isVisible"
  type="success|error|warning|info"
  position="top-right|top-left|bottom-right|bottom-left|top-center|bottom-center"
  title="Notification"
  message="This is a toast message."
/&gt;</code></pre>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { PPButton, PPWebToast } from '@phanna/ui-framework';

const toastVisible = ref(false);
const toastType = ref('info');
const toastPosition = ref('top-right');
const toastMessage = ref('');

const showToast = (type: string, position: string) => {
  toastVisible.value = false;
  
  setTimeout(() => {
    toastType.value = type;
    toastPosition.value = position;
    toastMessage.value = `This is a ${type} toast displayed at ${position}.`;
    toastVisible.value = true;
  }, 100);
};
</script>

<style scoped>
.demo-box {
  border: 1px solid #e0e0e0;
  border-radius: 8px;
  padding: 24px;
  margin-top: 16px;
  background: white;
}
.demo-content {
  margin-bottom: 24px;
  padding: 16px;
  background: #f9f9f9;
  border-radius: 4px;
}
</style>
