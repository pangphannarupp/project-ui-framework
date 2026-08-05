<template>
  <div class="guide-section">
    <h2>Transfer List</h2>
    <p>A component for moving items between two lists.</p>

    <h3>Variants</h3>
    <div class="demo-box" style="display: flex; flex-direction: column; gap: 48px;">
      
      <!-- Outlined -->
      <div>
        <h4 style="margin-bottom: 16px;">Outlined (Default)</h4>
        <PPTransferList
          v-model="targetKeysOutlined"
          :data="dataSource"
          :titles="['Source', 'Target']"
          variant="outlined"
        />
      </div>

      <!-- Filled -->
      <div>
        <h4 style="margin-bottom: 16px;">Filled</h4>
        <PPTransferList
          v-model="targetKeysFilled"
          :data="dataSource"
          :titles="['Source', 'Target']"
          variant="filled"
        />
      </div>

      <!-- Soft -->
      <div>
        <h4 style="margin-bottom: 16px;">Soft (Tonal)</h4>
        <PPTransferList
          v-model="targetKeysSoft"
          :data="dataSource"
          :titles="['Source', 'Target']"
          variant="soft"
        />
      </div>

      <!-- Elevated -->
      <div>
        <h4 style="margin-bottom: 16px;">Elevated (3D)</h4>
        <PPTransferList
          v-model="targetKeysElevated"
          :data="dataSource"
          :titles="['Source', 'Target']"
          variant="elevated"
        />
      </div>

    </div>
    <pre class="code-block" v-pre><code>&lt;PPTransferList variant="outlined" ... /&gt;
&lt;PPTransferList variant="filled" ... /&gt;
&lt;PPTransferList variant="soft" ... /&gt;
&lt;PPTransferList variant="elevated" ... /&gt;</code></pre>
    
    <h3>Vertical Layout</h3>
    <div class="demo-box">
      <PPTransferList
        v-model="targetKeys"
        :data="dataSource"
        :titles="['Source', 'Target']"
        direction="vertical"
      />
    </div>
    <pre class="code-block" v-pre><code>&lt;PPTransferList
  v-model="targetKeys"
  :data="dataSource"
  :titles="['Source', 'Target']"
  direction="vertical"
/&gt;</code></pre>
  
        <div class="variant-group">
          <h3>Customizing CSS</h3>
          <p class="custom-guide">You can override the component's appearance globally via CSS variables or by targeting its specific classes.</p>
          <pre class="code-block" v-pre><code>/* Override globally */
:root {
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
    &lt;h2&gt;Transfer List&lt;/h2&gt;
    &lt;p&gt;A component for moving items between two lists.&lt;/p&gt;

    &lt;h3&gt;Variants&lt;/h3&gt;
    &lt;div class="demo-box" style="display: flex; flex-direction: column; gap: 48px;"&gt;
      
      &lt;!-- Outlined --&gt;
      &lt;div&gt;
        &lt;h4 style="margin-bottom: 16px;"&gt;Outlined (Default)&lt;/h4&gt;
        &lt;PPTransferList
          v-model="targetKeysOutlined"
          :data="dataSource"
          :titles="['Source', 'Target']"
          variant="outlined"
        /&gt;
      &lt;/div&gt;

      &lt;!-- Filled --&gt;
      &lt;div&gt;
        &lt;h4 style="margin-bottom: 16px;"&gt;Filled&lt;/h4&gt;
        &lt;PPTransferList
          v-model="targetKeysFilled"
          :data="dataSource"
          :titles="['Source', 'Target']"
          variant="filled"
        /&gt;
      &lt;/div&gt;

      &lt;!-- Soft --&gt;
      &lt;div&gt;
        &lt;h4 style="margin-bottom: 16px;"&gt;Soft (Tonal)&lt;/h4&gt;
        &lt;PPTransferList
          v-model="targetKeysSoft"
          :data="dataSource"
          :titles="['Source', 'Target']"
          variant="soft"
        /&gt;
      &lt;/div&gt;

      &lt;!-- Elevated --&gt;
      &lt;div&gt;
        &lt;h4 style="margin-bottom: 16px;"&gt;Elevated (3D)&lt;/h4&gt;
        &lt;PPTransferList
          v-model="targetKeysElevated"
          :data="dataSource"
          :titles="['Source', 'Target']"
          variant="elevated"
        /&gt;
      &lt;/div&gt;

    &lt;/div&gt;
    &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPTransferList variant="outlined" ... /&amp;gt;
&amp;lt;PPTransferList variant="filled" ... /&amp;gt;
&amp;lt;PPTransferList variant="soft" ... /&amp;gt;
&amp;lt;PPTransferList variant="elevated" ... /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
    
    &lt;h3&gt;Vertical Layout&lt;/h3&gt;
    &lt;div class="demo-box"&gt;
      &lt;PPTransferList
        v-model="targetKeys"
        :data="dataSource"
        :titles="['Source', 'Target']"
        direction="vertical"
      /&gt;
    &lt;/div&gt;
    &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPTransferList
  v-model="targetKeys"
  :data="dataSource"
  :titles="['Source', 'Target']"
  direction="vertical"
/&amp;gt;&lt;/code&gt;&lt;/pre&gt;
  
        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Customizing CSS&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;You can override the component's appearance globally via CSS variables or by targeting its specific classes.&lt;/p&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;/* Override globally */
:root {
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
import { PPTransferList } from '@phanna/ui-framework';

const generateData = () =&gt; {
  const data = [];
  for (let i = 1; i &lt;= 10; i++) {
    data.push({
      key: i.toString(),
      label: `Item ${i}`,
      disabled: i % 4 === 0
    });
  }
  return data;
};

const dataSource = ref(generateData());
const targetKeys = ref&lt;string[]&gt;(['1', '3']);
const targetKeysOutlined = ref&lt;string[]&gt;(['1', '3']);
const targetKeysFilled = ref&lt;string[]&gt;(['1', '3']);
const targetKeysSoft = ref&lt;string[]&gt;(['1', '3']);
const targetKeysElevated = ref&lt;string[]&gt;(['1', '3']);
&lt;/script&gt;

&lt;style scoped&gt;
.guide-section {
  display: flex;
  flex-direction: column;
  gap: 24px;
}
.demo-box {
  border: 1px solid #e5e7eb;
  border-radius: 8px;
  padding: 24px;
  background: #f9fafb;
}
&lt;/style&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { PPTransferList } from '@phanna/ui-framework';

const generateData = () => {
  const data = [];
  for (let i = 1; i <= 10; i++) {
    data.push({
      key: i.toString(),
      label: `Item ${i}`,
      disabled: i % 4 === 0
    });
  }
  return data;
};

const dataSource = ref(generateData());
const targetKeys = ref<string[]>(['1', '3']);
const targetKeysOutlined = ref<string[]>(['1', '3']);
const targetKeysFilled = ref<string[]>(['1', '3']);
const targetKeysSoft = ref<string[]>(['1', '3']);
const targetKeysElevated = ref<string[]>(['1', '3']);
</script>

<style scoped>
.guide-section {
  display: flex;
  flex-direction: column;
  gap: 24px;
}
.demo-box {
  border: 1px solid #e5e7eb;
  border-radius: 8px;
  padding: 24px;
  background: #f9fafb;
}
</style>
