<template>
  <div class="component-section">
    <h2>Imperative Components (UIUtil)</h2>
    <p>A utility to dynamically show components like BottomSheets or Dialogs from TypeScript/JavaScript without declaring them in your template.</p>

    <div class="demo-box" style="margin-top: 32px; display: flex; gap: 16px; align-items: center; justify-content: center; height: 160px; background: #f8fafc; border-radius: 8px; flex-wrap: wrap;">
      <PPButton @click="showConfirmSheet">Show Confirm Sheet</PPButton>
      <PPButton variant="secondary" @click="showDialog">Show Dialog</PPButton>
      <PPButton variant="outline" @click="showIsland">Show Dynamic Island</PPButton>
    </div>

    <!-- Usage Section -->
    <div style="margin-top: 40px;">
      <h3>Usage Example</h3>
      <pre class="code-block" style="background: #1e293b; color: #e2e8f0; padding: 16px; border-radius: 8px; overflow-x: auto;" v-pre><code>&lt;template&gt;
  &lt;PPButton @click="handleAction"&gt;Perform Action&lt;/PPButton&gt;
&lt;/template&gt;

&lt;script setup lang="ts"&gt;
import { UIUtil, PPConfirmSheet, PPConfirm, PPDynamicIsland } from '@phanna/ui-framework';

const handleAction = () =&gt; {
  const sheet = UIUtil.showBottomSheet(PPConfirmSheet, {
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
    &lt;h2&gt;Imperative Components (UIUtil)&lt;/h2&gt;
    &lt;p&gt;A utility to dynamically show components like BottomSheets or Dialogs from TypeScript/JavaScript without declaring them in your template.&lt;/p&gt;

    &lt;div class="demo-box" style="margin-top: 32px; display: flex; gap: 16px; align-items: center; justify-content: center; height: 160px; background: #f8fafc; border-radius: 8px; flex-wrap: wrap;"&gt;
      &lt;PPButton @click="showConfirmSheet"&gt;Show Confirm Sheet&lt;/PPButton&gt;
      &lt;PPButton variant="secondary" @click="showDialog"&gt;Show Dialog&lt;/PPButton&gt;
      &lt;PPButton variant="outline" @click="showIsland"&gt;Show Dynamic Island&lt;/PPButton&gt;
    &lt;/div&gt;

    &lt;!-- Usage Section --&gt;
    &lt;div style="margin-top: 40px;"&gt;
      &lt;h3&gt;Usage Example&lt;/h3&gt;
      &lt;pre class="code-block" style="background: #1e293b; color: #e2e8f0; padding: 16px; border-radius: 8px; overflow-x: auto;"&gt;&lt;code&gt;&amp;lt;template&amp;gt;
  &amp;lt;PPButton @click="handleAction"&amp;gt;Perform Action&amp;lt;/PPButton&amp;gt;
&amp;lt;/template&amp;gt;

&amp;lt;script setup lang="ts"&amp;gt;
import { UIUtil, PPConfirmSheet, PPConfirm, PPDynamicIsland } from '@phanna/ui-framework';

const handleAction = () =&amp;gt; {
  const sheet = UIUtil.showBottomSheet(PPConfirmSheet, {
    title: 'Are you sure?',
    subtitle: 'This action cannot be undone.',
    confirmText: 'Yes, Delete',
    cancelText: 'Cancel',
    onConfirm: () =&amp;gt; {
      console.log('User confirmed!');
      sheet.close();
    }
  });
};
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
import { UIUtil, PPConfirmSheet, PPConfirm, PPDynamicIsland, PPButton } from '@phanna/ui-framework';

const showConfirmSheet = () =&gt; {
  const sheet = UIUtil.showBottomSheet(PPConfirmSheet, {
    title: 'Are you sure?',
    subtitle: 'This is triggered imperatively without template code.',
    confirmText: 'Confirm',
    cancelText: 'Cancel',
    onConfirm: () =&gt; {
      console.log('Confirmed via UIUtil');
      sheet.close();
    }
  });
};

const showDialog = () =&gt; {
  const dialog = UIUtil.showDialog(PPConfirm, {
    title: 'Delete Item',
    message: 'Are you sure you want to delete this? This action cannot be undone.',
    confirmText: 'Delete',
    cancelText: 'Cancel',
    onConfirm: () =&gt; {
      console.log('Deleted!');
      dialog.close();
    }
  });
};

const showIsland = () =&gt; {
  const island = UIUtil.showDynamicIsland(PPDynamicIsland, {
    state: 'compact',
    position: 'top',
    fullWidth: false,
    'onClick': () =&gt; {
      island.close();
    }
  });
};
&lt;/script&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
</template>

<script setup lang="ts">
import { UIUtil, PPConfirmSheet, PPConfirm, PPDynamicIsland, PPButton } from '@phanna/ui-framework';

const showConfirmSheet = () => {
  const sheet = UIUtil.showBottomSheet(PPConfirmSheet, {
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

const showDialog = () => {
  const dialog = UIUtil.showDialog(PPConfirm, {
    title: 'Delete Item',
    message: 'Are you sure you want to delete this? This action cannot be undone.',
    confirmText: 'Delete',
    cancelText: 'Cancel',
    onConfirm: () => {
      console.log('Deleted!');
      dialog.close();
    }
  });
};

const showIsland = () => {
  const island = UIUtil.showDynamicIsland(PPDynamicIsland, {
    state: 'compact',
    position: 'top',
    fullWidth: false,
    'onClick': () => {
      island.close();
    }
  });
};
</script>
