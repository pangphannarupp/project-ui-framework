<template>
<div class="guide-section">
        <h2>14. Account Reorder List</h2>
        <div class="variant-group">
          <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px;">
            <h3>Fully Custom Template</h3>
            <PPButton size="small" @click="isReorderMode = !isReorderMode">
              {{ isReorderMode ? 'Done' : 'Sort by' }}
            </PPButton>
          </div>
          <p class="custom-guide">You can completely replace the internal cards with your own custom HTML while retaining the drag-to-reorder logic.</p>
          <div class="component-demo" style="background: #f4f6f9; padding: 20px; border-radius: 12px;">
            <PPAccountReorderList 
              :accounts="demoAccounts"
              :isReorderMode="isReorderMode"
              @update:accounts="newAccs => demoAccounts = newAccs"
            >
              <template #item="{ item, dragListeners, isReorderMode: reorderMode }">
                <div style="background: white; border-radius: 8px; padding: 16px; margin-bottom: 8px; display: flex; align-items: center; justify-content: space-between; box-shadow: 0 2px 4px rgba(0,0,0,0.05);">
                  <div>
                    <strong style="display: block; font-size: 16px; color: #333;">Custom: {{ item.accountName || item.name }}</strong>
                    <span style="color: #666; font-size: 14px;">Description</span>
                  </div>
                  <div 
                    v-if="reorderMode" 
                    style="background: #eef2f6; padding: 8px; border-radius: 4px; cursor: grab; color: #555;"
                    v-on="dragListeners"
                  >
                    Hold to Drag
                  </div>
                  <PPButton v-else size="small" variant="outline" @click="alertVal('Action on custom card')">Action</PPButton>
                </div>
              </template>
            </PPAccountReorderList>
          </div>
          <pre class="code-block" v-pre><code>&lt;PPAccountReorderList 
  :accounts="accounts" 
  :isReorderMode="isReorderMode"
&gt;
  &lt;template #item="{ item, dragListeners, isReorderMode }"&gt;
    &lt;div class="my-custom-card"&gt;
      &lt;h4&gt;{{ item.name }}&lt;/h4&gt;
      &lt;p&gt;{{ item.balance }}&lt;/p&gt;
      &lt;div v-if="isReorderMode" v-on="dragListeners"&gt;
        Hold to Drag
      &lt;/div&gt;
    &lt;/div&gt;
  &lt;/template&gt;
&lt;/PPAccountReorderList&gt;</code></pre>
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
&lt;div class="guide-section"&gt;
        &lt;h2&gt;14. Account Reorder List&lt;/h2&gt;
        &lt;div class="variant-group"&gt;
          &lt;div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px;"&gt;
            &lt;h3&gt;Fully Custom Template&lt;/h3&gt;
            &lt;PPButton size="small" @click="isReorderMode = !isReorderMode"&gt;
              {{ isReorderMode ? 'Done' : 'Sort by' }}
            &lt;/PPButton&gt;
          &lt;/div&gt;
          &lt;p class="custom-guide"&gt;You can completely replace the internal cards with your own custom HTML while retaining the drag-to-reorder logic.&lt;/p&gt;
          &lt;div class="component-demo" style="background: #f4f6f9; padding: 20px; border-radius: 12px;"&gt;
            &lt;PPAccountReorderList 
              :accounts="demoAccounts"
              :isReorderMode="isReorderMode"
              @update:accounts="newAccs =&gt; demoAccounts = newAccs"
            &gt;
              &lt;template #item="{ item, dragListeners, isReorderMode: reorderMode }"&gt;
                &lt;div style="background: white; border-radius: 8px; padding: 16px; margin-bottom: 8px; display: flex; align-items: center; justify-content: space-between; box-shadow: 0 2px 4px rgba(0,0,0,0.05);"&gt;
                  &lt;div&gt;
                    &lt;strong style="display: block; font-size: 16px; color: #333;"&gt;Custom: {{ item.accountName || item.name }}&lt;/strong&gt;
                    &lt;span style="color: #666; font-size: 14px;"&gt;Description&lt;/span&gt;
                  &lt;/div&gt;
                  &lt;div 
                    v-if="reorderMode" 
                    style="background: #eef2f6; padding: 8px; border-radius: 4px; cursor: grab; color: #555;"
                    v-on="dragListeners"
                  &gt;
                    Hold to Drag
                  &lt;/div&gt;
                  &lt;PPButton v-else size="small" variant="outline" @click="alertVal('Action on custom card')"&gt;Action&lt;/PPButton&gt;
                &lt;/div&gt;
              &lt;/template&gt;
            &lt;/PPAccountReorderList&gt;
          &lt;/div&gt;
          &lt;pre class="code-block" v-pre&gt;&lt;code&gt;&amp;lt;PPAccountReorderList 
  :accounts="accounts" 
  :isReorderMode="isReorderMode"
&amp;gt;
  &amp;lt;template #item="{ item, dragListeners, isReorderMode }"&amp;gt;
    &amp;lt;div class="my-custom-card"&amp;gt;
      &amp;lt;h4&amp;gt;{{ item.name }}&amp;lt;/h4&amp;gt;
      &amp;lt;p&amp;gt;{{ item.balance }}&amp;lt;/p&amp;gt;
      &amp;lt;div v-if="isReorderMode" v-on="dragListeners"&amp;gt;
        Hold to Drag
      &amp;lt;/div&amp;gt;
    &amp;lt;/div&amp;gt;
  &amp;lt;/template&amp;gt;
&amp;lt;/PPAccountReorderList&amp;gt;&lt;/code&gt;&lt;/pre&gt;
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

const demoAccounts = ref([
  { id: 'acc1', name: "AAAAAAAA", number: "1-120-14335454-8", balance: 12000000.00, currency: "USD" as const, type: "Savings", isHidden: false },
  { id: 'acc2', name: "BBBBBBBB", number: "1-120-14335455-9", balance: 50000.50, currency: "USD" as const, type: "Savings", isHidden: false },
  { id: 'acc3', name: "CCCCCCCC", number: "1-120-14335456-0", balance: 40000000, currency: "KHR" as const, type: "Savings", isHidden: true },
]);

const isReorderMode = ref(false);

const alertVal = (type: string) =&gt; console.log('Setup: ' + type);
// Search functionality

import { PPButton, PPAccountReorderList } from '@phanna/ui-framework';

&lt;/script&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
</template>

<script setup lang="ts">
import { ref } from 'vue';

const demoAccounts = ref([
  { id: 'acc1', name: "AAAAAAAA", number: "1-120-14335454-8", balance: 12000000.00, currency: "USD" as const, type: "Savings", isHidden: false },
  { id: 'acc2', name: "BBBBBBBB", number: "1-120-14335455-9", balance: 50000.50, currency: "USD" as const, type: "Savings", isHidden: false },
  { id: 'acc3', name: "CCCCCCCC", number: "1-120-14335456-0", balance: 40000000, currency: "KHR" as const, type: "Savings", isHidden: true },
]);

const isReorderMode = ref(false);

const alertVal = (type: string) => console.log('Setup: ' + type);
// Search functionality

import { PPButton, PPAccountReorderList } from '@phanna/ui-framework';

</script>
