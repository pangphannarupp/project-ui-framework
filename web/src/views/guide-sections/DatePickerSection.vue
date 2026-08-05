<template>
  <div class="guide-section">
    <h2>26. Date Picker</h2>
    
    <div class="variant-group">
      <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px;">
        <h3>Basic Usage</h3>
      </div>
      <div class="demo-box" style="height: 350px; display: flex; align-items: flex-start; justify-content: center; padding-top: 50px;">
        <div style="width: 300px;">
          <PPDatePicker v-model="selectedDate" placeholder="Select a Date" />
        </div>
      </div>
      <pre class="code-block" style="margin-top: 16px;" v-pre><code>&lt;template&gt;
  &lt;PPDatePicker v-model="selectedDate" placeholder="Select a Date" /&gt;
&lt;/template&gt;

&lt;script setup&gt;
import { ref } from 'vue';
import { PPDatePicker } from '@phanna/ui-framework';

const selectedDate = ref(new Date());
&lt;/script&gt;</code></pre>
    </div>

    <div class="variant-group">
      <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px;">
        <h3>Custom Format</h3>
      </div>
      <div class="demo-box" style="height: 350px; display: flex; align-items: flex-start; justify-content: center; padding-top: 50px;">
        <div style="width: 300px;">
          <PPDatePicker 
            v-model="customDate" 
            placeholder="YYYY-MM-DD" 
            :format="customFormat"
          />
        </div>
      </div>
      <pre class="code-block" style="margin-top: 16px;" v-pre><code>&lt;template&gt;
  &lt;PPDatePicker 
    v-model="customDate" 
    placeholder="YYYY-MM-DD" 
    :format="customFormat"
  /&gt;
&lt;/template&gt;

&lt;script setup&gt;
import { ref } from 'vue';
import { PPDatePicker } from '@phanna/ui-framework';

const customDate = ref(null);
const customFormat = (date) => {
  return `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, '0')}-${String(date.getDate()).padStart(2, '0')}`;
};
&lt;/script&gt;</code></pre>
    </div>

  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { PPDatePicker } from '@phanna/ui-framework';

const selectedDate = ref(new Date());
const customDate = ref<Date | null>(null);

const customFormat = (date: Date) => {
  return `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, '0')}-${String(date.getDate()).padStart(2, '0')}`;
};
</script>

<style scoped>
.guide-section {
  display: flex;
  flex-direction: column;
  gap: 32px;
}
.variant-group {
  display: flex;
  flex-direction: column;
  gap: 16px;
}
.demo-box {
  border: 1px solid #e5e7eb;
  border-radius: 8px;
  padding: 24px;
  background-color: #f9fafb;
}
.code-block {
  background: #1e1e1e;
  color: #d4d4d4;
  padding: 16px;
  border-radius: 8px;
  overflow-x: auto;
  font-family: 'Consolas', 'Monaco', 'Courier New', monospace;
  font-size: 14px;
  line-height: 1.5;
}
</style>
