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
      <pre class="code-block" v-pre><code>&lt;PPWebToast 
  v-model="isVisible"
  type="success|error|warning|info"
  position="top-right|top-left|bottom-right|bottom-left|top-center|bottom-center"
  title="Notification"
  message="This is a toast message."
/&gt;</code></pre>
    </div>
  
        <div class="variant-group">
          <h3>Customizing CSS</h3>
          <p class="custom-guide">You can override the component's appearance globally via CSS variables or by targeting its specific classes.</p>
          <pre class="code-block" v-pre><code>/* Override globally */
:root {
  /* This component does not use CSS variables directly. */
  /* Use custom classes to override styles. */
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
  &lt;div class="component-section"&gt;
    &lt;h2&gt;Web Toast&lt;/h2&gt;
    &lt;p&gt;A desktop-friendly toast component that can be positioned at various corners of the screen.&lt;/p&gt;

    &lt;div class="demo-box"&gt;
      &lt;h3&gt;Basic Toast&lt;/h3&gt;
      &lt;div class="demo-content"&gt;
        &lt;div style="display: flex; gap: 12px; flex-wrap: wrap;"&gt;
          &lt;PPButton @click="showToast('info', 'top-right')" style="color: white;"&gt;Info (Top Right)&lt;/PPButton&gt;
          &lt;PPButton @click="showToast('success', 'bottom-right')" style="--pp-primary-variant: #4caf50; color: white;"&gt;Success (Bottom Right)&lt;/PPButton&gt;
          &lt;PPButton @click="showToast('error', 'top-center')" style="--pp-primary-variant: #f44336; color: white;"&gt;Error (Top Center)&lt;/PPButton&gt;
          &lt;PPButton @click="showToast('warning', 'bottom-left')" style="--pp-primary-variant: #ff9800; color: white;"&gt;Warning (Bottom Left)&lt;/PPButton&gt;
        &lt;/div&gt;

        &lt;PPWebToast 
          v-model="toastVisible"
          :type="toastType"
          :position="toastPosition"
          title="Notification"
          :message="toastMessage"
        /&gt;
      &lt;/div&gt;
      &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPWebToast 
  v-model="isVisible"
  type="success|error|warning|info"
  position="top-right|top-left|bottom-right|bottom-left|top-center|bottom-center"
  title="Notification"
  message="This is a toast message."
/&amp;gt;&lt;/code&gt;&lt;/pre&gt;
    &lt;/div&gt;
  
        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Customizing CSS&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;You can override the component's appearance globally via CSS variables or by targeting its specific classes.&lt;/p&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;/* Override globally */
:root {
  /* This component does not use CSS variables directly. */
  /* Use custom classes to override styles. */
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
import { PPButton, PPWebToast } from '@phanna/ui-framework';

const toastVisible = ref(false);
const toastType = ref('info');
const toastPosition = ref('top-right');
const toastMessage = ref('');

const showToast = (type: string, position: string) =&gt; {
  toastVisible.value = false;
  
  setTimeout(() =&gt; {
    toastType.value = type;
    toastPosition.value = position;
    toastMessage.value = `This is a ${type} toast displayed at ${position}.`;
    toastVisible.value = true;
  }, 100);
};
&lt;/script&gt;

&lt;style scoped&gt;
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
&lt;/style&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
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
