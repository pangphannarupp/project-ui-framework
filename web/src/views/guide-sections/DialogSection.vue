<template>
  <div class="component-section">
    <h2>Dialogs</h2>
    <p>Modal dialogs designed to interrupt the user to prompt for confirmation, display alerts, or request input.</p>

    <!-- Demo Box -->
    <div class="demo-box" style="margin-top: 32px; display: flex; gap: 16px; align-items: center; justify-content: center; height: 160px; background: #f8fafc; border-radius: 8px; flex-wrap: wrap;">
      <PPButton @click="showConfirm = true">Confirm Dialog</PPButton>
      <PPButton variant="secondary" @click="showAlert = true">Alert Dialog</PPButton>
      <PPButton variant="outline" @click="showInput = true">Input Dialog</PPButton>
    </div>

    <!-- Confirm Dialog -->
    <PPConfirm 
      v-model="showConfirm" 
      title="Delete Account?" 
      message="Are you sure you want to delete your account? This action cannot be undone."
      confirmText="Delete"
      cancelText="Cancel"
      confirmVariant="outline-danger"
      @confirm="handleConfirm"
    />

    <!-- Alert Dialog -->
    <PPAlert 
      v-model="showAlert" 
      title="Update Successful" 
      message="Your profile has been updated successfully."
      buttonText="Great"
    />

    <!-- Input Dialog -->
    <PPInputDialog 
      v-model="showInput" 
      title="Create Folder" 
      message="Enter a name for the new folder:"
      placeholder="Folder name"
      confirmText="Create"
      cancelText="Cancel"
      @confirm="handleInputConfirm"
    />

    <!-- Usage Section -->
    <div style="margin-top: 40px;">
      <h3>Usage Example</h3>
      <pre class="code-block" style="background: #1e293b; color: #e2e8f0; padding: 16px; border-radius: 8px; overflow-x: auto;"><code>&lt;template&gt;
  &lt;PPButton @click="isOpen = true"&gt;Show Confirm&lt;/PPButton&gt;

  &lt;PPConfirm 
    v-model="isOpen" 
    title="Are you sure?" 
    message="This action is irreversible."
    confirmText="Yes, Proceed"
    cancelText="No, Go Back"
    @confirm="onConfirm"
  /&gt;
&lt;/template&gt;

&lt;script setup&gt;
import { ref } from 'vue';
import { PPConfirm, PPButton } from '@phanna/ui-framework';

const isOpen = ref(false);

const onConfirm = () =&gt; {
  console.log('User confirmed action');
};
&lt;/script&gt;</code></pre>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { PPConfirm, PPAlert, PPInputDialog, PPButton } from '@phanna/ui-framework';

const showConfirm = ref(false);
const showAlert = ref(false);
const showInput = ref(false);

const handleConfirm = () => {
  console.log('Confirmed!');
};

const handleInputConfirm = (value: string) => {
  console.log('Input value:', value);
};
</script>
