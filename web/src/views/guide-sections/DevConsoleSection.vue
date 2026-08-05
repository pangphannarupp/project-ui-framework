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
      
      <pre class="code-block" style="background: #f8fafc; padding: 16px; border-radius: 8px; overflow-x: auto;" v-pre><code>&lt;template&gt;
  &lt;!-- Your app content --&gt;
  &lt;router-view /&gt;

  &lt;!-- Place this once in your App.vue (maybe wrap in a v-if="isDev" to hide in prod) --&gt;
  &lt;PPConsole /&gt;
&lt;/template&gt;

&lt;script setup&gt;
import { PPConsole } from '@phanna/ui-framework';
&lt;/script&gt;</code></pre>
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
    &lt;h2&gt;Developer Console (vConsole)&lt;/h2&gt;
    &lt;p&gt;A floating, in-app developer console that intercepts `console.log`, `console.error`, and other output methods. Extremely useful for debugging on mobile devices where standard DevTools are not accessible.&lt;/p&gt;

    &lt;div style="margin-top: 32px;"&gt;
      &lt;div class="demo-box" style="display: flex; flex-direction: column; gap: 16px; align-items: center; justify-content: center; height: 200px;"&gt;
        &lt;p style="color: #64748b; font-size: 14px; text-align: center;"&gt;Click these buttons to generate console logs.&lt;/p&gt;
        &lt;div style="display: flex; gap: 12px; flex-wrap: wrap; justify-content: center;"&gt;
          &lt;PPButton @click="logInfo"&gt;console.info()&lt;/PPButton&gt;
          &lt;PPButton variant="outline" color="primary" @click="logData"&gt;console.log(Object)&lt;/PPButton&gt;
          &lt;PPButton color="warning" @click="logWarning"&gt;console.warn()&lt;/PPButton&gt;
          &lt;PPButton color="danger" @click="logError"&gt;console.error()&lt;/PPButton&gt;
        &lt;/div&gt;
        &lt;p style="color: #64748b; font-size: 13px; margin-top: 8px;"&gt;Look at the bottom right of the screen for the &lt;b&gt;vConsole&lt;/b&gt; toggle button!&lt;/p&gt;
      &lt;/div&gt;
    &lt;/div&gt;

    &lt;!-- Usage Section --&gt;
    &lt;div style="margin-top: 40px;"&gt;
      &lt;h3&gt;Usage Example&lt;/h3&gt;
      &lt;p&gt;Simply drop the `PPConsole` component into your main layout (like `App.vue` or your global shell component). It will automatically intercept all console output and render a floating toggle button on the screen.&lt;/p&gt;
      
      &lt;pre class="code-block" style="background: #f8fafc; padding: 16px; border-radius: 8px; overflow-x: auto;"&gt;&lt;code&gt;&amp;lt;template&amp;gt;
  &amp;lt;!-- Your app content --&amp;gt;
  &amp;lt;router-view /&amp;gt;

  &amp;lt;!-- Place this once in your App.vue (maybe wrap in a v-if="isDev" to hide in prod) --&amp;gt;
  &amp;lt;PPConsole /&amp;gt;
&amp;lt;/template&amp;gt;

&amp;lt;script setup&amp;gt;
import { PPConsole } from '@phanna/ui-framework';
&amp;lt;/script&amp;gt;&lt;/code&gt;&lt;/pre&gt;
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
import { PPButton } from '@phanna/ui-framework';

const logInfo = () =&gt; {
  console.info('User clicked the info button.');
};

const logData = () =&gt; {
  console.log('Sending data to server:', {
    userId: 123,
    status: 'active',
    timestamp: new Date().toISOString()
  });
};

const logWarning = () =&gt; {
  console.warn('Network request is taking longer than expected.');
};

const logError = () =&gt; {
  console.error('Failed to parse JSON response.', new Error('Unexpected token u in JSON at position 0'));
};
&lt;/script&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
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
