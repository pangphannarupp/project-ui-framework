<template>
  <div class="guide-section">
    <h2>OTP Input</h2>
    <p>A specialized input component for One-Time Passwords.</p>

    <h3>OTP Input (6-digit)</h3>
    <div class="demo-box">
      <PPOtpInput v-model="otpVal" :length="6" />
      <div style="margin-top: 16px; font-family: monospace;">Value: {{ otpVal }}</div>
    </div>
    <pre class="code-block" v-pre><code>&lt;PPOtpInput v-model="otp" :length="6" /&gt;</code></pre>
  
        <div class="variant-group">
          <h3>Customizing CSS</h3>
          <p class="custom-guide">You can override the component's appearance globally via CSS variables or by targeting its specific classes.</p>
          <pre class="code-block" v-pre><code>/* Override globally */
:root {
  --pp-primary: /* value */;
  --pp-primary-color: /* value */;
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
    &lt;h2&gt;OTP Input&lt;/h2&gt;
    &lt;p&gt;A specialized input component for One-Time Passwords.&lt;/p&gt;

    &lt;h3&gt;OTP Input (6-digit)&lt;/h3&gt;
    &lt;div class="demo-box"&gt;
      &lt;PPOtpInput v-model="otpVal" :length="6" /&gt;
      &lt;div style="margin-top: 16px; font-family: monospace;"&gt;Value: {{ otpVal }}&lt;/div&gt;
    &lt;/div&gt;
    &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPOtpInput v-model="otp" :length="6" /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
  
        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Customizing CSS&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;You can override the component's appearance globally via CSS variables or by targeting its specific classes.&lt;/p&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;/* Override globally */
:root {
  --pp-primary: /* value */;
  --pp-primary-color: /* value */;
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
import { PPOtpInput } from '@phanna/ui-framework';

const otpVal = ref('');
&lt;/script&gt;

&lt;style scoped&gt;
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
&lt;/style&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { PPOtpInput } from '@phanna/ui-framework';

const otpVal = ref('');
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
