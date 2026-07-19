<template>
  <div class="guide-section">
    <h2>Transfer List</h2>
    <p>A component for moving items between two lists.</p>

    <h3>Basic Usage</h3>
    <div class="demo-box">
      <BizTransferList
        v-model="targetKeys"
        :data="dataSource"
        :titles="['Source', 'Target']"
      />
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { BizTransferList } from '@phanna/ui-framework';

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
