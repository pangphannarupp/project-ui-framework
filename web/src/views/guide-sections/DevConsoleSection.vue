<template>
  <div class="component-section">
    <h2>Developer Console (vConsole)</h2>
    <p>A floating, in-app developer console that intercepts `console.log`, `console.error`, and other output methods. Extremely useful for debugging on mobile devices where standard DevTools are not accessible.</p>

    <div style="margin-top: 32px;">
      <div class="demo-box" style="display: flex; flex-direction: column; gap: 16px; align-items: center; justify-content: center; height: 200px;">
        <p style="color: #64748b; font-size: 14px; text-align: center;">Click these buttons to generate console logs.</p>
        <div style="display: flex; gap: 12px; flex-wrap: wrap; justify-content: center;">
          <PPButton @click="logInfo">console.info()</PPButton>
          <PPButton variant="outline" color="primary" @click="logData">console.log(Object)</PPButton>
          <PPButton color="warning" @click="logWarning">console.warn()</PPButton>
          <PPButton color="danger" @click="logError">console.error()</PPButton>
        </div>
        <p style="color: #64748b; font-size: 13px; margin-top: 8px;">Look at the bottom right of the screen for the <b>vConsole</b> toggle button!</p>
      </div>
    </div>

    <!-- Usage Section -->
    <div style="margin-top: 40px;">
      <h3>Usage Example</h3>
      <p>Simply drop the `PPConsole` component into your main layout (like `App.vue` or your global shell component). It will automatically intercept all console output and render a floating toggle button on the screen.</p>
      
      <pre class="code-block" style="background: #f8fafc; padding: 16px; border-radius: 8px; overflow-x: auto;"><code>&lt;template&gt;
  &lt;!-- Your app content --&gt;
  &lt;router-view /&gt;

  &lt;!-- Place this once in your App.vue (maybe wrap in a v-if="isDev" to hide in prod) --&gt;
  &lt;PPConsole /&gt;
&lt;/template&gt;

&lt;script setup&gt;
import { PPConsole } from '@phanna/ui-framework';
&lt;/script&gt;</code></pre>
    </div>

  </div>
</template>

<script setup lang="ts">
import { PPButton } from '@phanna/ui-framework';

const logInfo = () => {
  console.info('User clicked the info button.');
};

const logData = () => {
  console.log('Sending data to server:', {
    userId: 123,
    status: 'active',
    timestamp: new Date().toISOString()
  });
};

const logWarning = () => {
  console.warn('Network request is taking longer than expected.');
};

const logError = () => {
  console.error('Failed to parse JSON response.', new Error('Unexpected token u in JSON at position 0'));
};
</script>
