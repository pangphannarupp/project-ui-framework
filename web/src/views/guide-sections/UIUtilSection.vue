<template>
  <div class="component-section">
    <h2>Imperative Components (UIUtil)</h2>
    <p>A utility to dynamically show components like BottomSheets or Dialogs from TypeScript/JavaScript without declaring them in your template.</p>

    <div class="demo-box" style="margin-top: 32px; display: flex; gap: 16px; align-items: center; justify-content: center; height: 160px; background: #f8fafc; border-radius: 8px;">
      <PPButton @click="showConfirmSheet">Show Confirm Sheet</PPButton>
    </div>

    <!-- Usage Section -->
    <div style="margin-top: 40px;">
      <h3>Usage Example</h3>
      <pre class="code-block" style="background: #1e293b; color: #e2e8f0; padding: 16px; border-radius: 8px; overflow-x: auto;"><code>&lt;template&gt;
  &lt;PPButton @click="handleAction"&gt;Perform Action&lt;/PPButton&gt;
&lt;/template&gt;

&lt;script setup lang="ts"&gt;
import { UIUtil, PPConfirmSheet } from '@phanna/ui-framework';

const handleAction = () =&gt; {
  const sheet = UIUtil.showComponent(PPConfirmSheet, {
    title: 'Are you sure?',
    subtitle: 'This action cannot be undone.',
    confirmText: 'Yes, Delete',
    cancelText: 'Cancel',
    onConfirm: () =&gt; {
      console.log('User confirmed!');
      sheet.close();
    }
  });
};
&lt;/script&gt;</code></pre>
    </div>
  </div>
</template>

<script setup lang="ts">
import { UIUtil, PPConfirmSheet, PPButton } from '@phanna/ui-framework';

const showConfirmSheet = () => {
  const sheet = UIUtil.showComponent(PPConfirmSheet, {
    title: 'Are you sure?',
    subtitle: 'This is triggered imperatively without template code.',
    confirmText: 'Confirm',
    cancelText: 'Cancel',
    onConfirm: () => {
      console.log('Confirmed via UIUtil');
      sheet.close();
    }
  });
};
</script>
