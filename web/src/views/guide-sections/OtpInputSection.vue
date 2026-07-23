<template>
  <div class="guide-section">
    <h2>OTP Input</h2>
    <p>A specialized input component for One-Time Passwords.</p>

    <h3>OTP Input (6-digit)</h3>
    <div class="demo-box">
      <PPOtpInput v-model="otpVal" :length="6" />
      <div style="margin-top: 16px; font-family: monospace;">Value: {{ otpVal }}</div>
    </div>
    <pre class="code-block"><code>&lt;PPOtpInput v-model="otp" :length="6" /&gt;</code></pre>
  </div>
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
