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
      <pre class="code-block" style="background: #1e293b; color: #e2e8f0; padding: 16px; border-radius: 8px; overflow-x: auto;" v-pre><code>&lt;template&gt;
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
  
        <div class="variant-group">
          <h3>Customizing CSS</h3>
          <p class="custom-guide">You can override the component's appearance globally via CSS variables or by targeting its specific classes.</p>
          <pre class="code-block" v-pre><code>/* Override globally */
:root {
  --pp-primary: /* value */;
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
  &lt;div class="component-section"&gt;
    &lt;h2&gt;Dialogs&lt;/h2&gt;
    &lt;p&gt;Modal dialogs designed to interrupt the user to prompt for confirmation, display alerts, or request input.&lt;/p&gt;

    &lt;!-- Demo Box --&gt;
    &lt;div class="demo-box" style="margin-top: 32px; display: flex; gap: 16px; align-items: center; justify-content: center; height: 160px; background: #f8fafc; border-radius: 8px; flex-wrap: wrap;"&gt;
      &lt;PPButton @click="showConfirm = true"&gt;Confirm Dialog&lt;/PPButton&gt;
      &lt;PPButton variant="secondary" @click="showAlert = true"&gt;Alert Dialog&lt;/PPButton&gt;
      &lt;PPButton variant="outline" @click="showInput = true"&gt;Input Dialog&lt;/PPButton&gt;
    &lt;/div&gt;

    &lt;!-- Confirm Dialog --&gt;
    &lt;PPConfirm 
      v-model="showConfirm" 
      title="Delete Account?" 
      message="Are you sure you want to delete your account? This action cannot be undone."
      confirmText="Delete"
      cancelText="Cancel"
      confirmVariant="outline-danger"
      @confirm="handleConfirm"
    /&gt;

    &lt;!-- Alert Dialog --&gt;
    &lt;PPAlert 
      v-model="showAlert" 
      title="Update Successful" 
      message="Your profile has been updated successfully."
      buttonText="Great"
    /&gt;

    &lt;!-- Input Dialog --&gt;
    &lt;PPInputDialog 
      v-model="showInput" 
      title="Create Folder" 
      message="Enter a name for the new folder:"
      placeholder="Folder name"
      confirmText="Create"
      cancelText="Cancel"
      @confirm="handleInputConfirm"
    /&gt;

    &lt;!-- Usage Section --&gt;
    &lt;div style="margin-top: 40px;"&gt;
      &lt;h3&gt;Usage Example&lt;/h3&gt;
      &lt;pre class="code-block" style="background: #1e293b; color: #e2e8f0; padding: 16px; border-radius: 8px; overflow-x: auto;"&gt;&lt;code&gt;&amp;lt;template&amp;gt;
  &amp;lt;PPButton @click="isOpen = true"&amp;gt;Show Confirm&amp;lt;/PPButton&amp;gt;

  &amp;lt;PPConfirm 
    v-model="isOpen" 
    title="Are you sure?" 
    message="This action is irreversible."
    confirmText="Yes, Proceed"
    cancelText="No, Go Back"
    @confirm="onConfirm"
  /&amp;gt;
&amp;lt;/template&amp;gt;

&amp;lt;script setup&amp;gt;
import { ref } from 'vue';
import { PPConfirm, PPButton } from '@phanna/ui-framework';

const isOpen = ref(false);

const onConfirm = () =&amp;gt; {
  console.log('User confirmed action');
};
&amp;lt;/script&amp;gt;&lt;/code&gt;&lt;/pre&gt;
    &lt;/div&gt;
  
        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Customizing CSS&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;You can override the component's appearance globally via CSS variables or by targeting its specific classes.&lt;/p&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;/* Override globally */
:root {
  --pp-primary: /* value */;
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
import { PPConfirm, PPAlert, PPInputDialog, PPButton } from '@phanna/ui-framework';

const showConfirm = ref(false);
const showAlert = ref(false);
const showInput = ref(false);

const handleConfirm = () =&gt; {
  console.log('Confirmed!');
};

const handleInputConfirm = (value: string) =&gt; {
  console.log('Input value:', value);
};
&lt;/script&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
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
