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
    <pre class="code-block"><code>&lt;PPTransferList variant="outlined" ... /&gt;
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
    <pre class="code-block"><code>&lt;PPTransferList
  v-model="targetKeys"
  :data="dataSource"
  :titles="['Source', 'Target']"
  direction="vertical"
/&gt;</code></pre>
  </div>
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
