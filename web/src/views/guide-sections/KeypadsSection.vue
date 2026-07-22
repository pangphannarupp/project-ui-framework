<template>
  <div class="guide-section">
    <h2>Keypads & Security</h2>
    <p>Secure input methods for PINs and amounts.</p>

    <h3>Standard Keypad</h3>
    <div class="demo-box">
      <div style="text-align: center; font-size: 24px; margin-bottom: 24px; font-family: monospace;">
        {{ keypadValue || 'Enter Amount' }}
      </div>
      <PPKeypad @input="onKeypadInput" @delete="onKeypadDelete" />
    </div>

    <h3>Secure Keyboard</h3>
    <p>A randomized keyboard layout to prevent keylogging/screen tracking.</p>
    <div class="demo-box">
      <PPSecureKeyboard @input="onSecureInput" @delete="onSecureDelete" />
    </div>

  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { PPKeypad, PPSecureKeyboard } from '@phanna/ui-framework';

const keypadValue = ref('');

const onKeypadInput = (val: string) => {
  if (keypadValue.value.length < 10) keypadValue.value += val;
};

const onKeypadDelete = () => {
  keypadValue.value = keypadValue.value.slice(0, -1);
};

const onSecureInput = (val: string) => console.log('Secure Input:', val);
const onSecureDelete = () => console.log('Secure Delete');
</script>

<style scoped>
.guide-section { display: flex; flex-direction: column; gap: 24px; }
.demo-box { border: 1px solid #e5e7eb; border-radius: 8px; padding: 24px; background: #f9fafb; }
</style>
