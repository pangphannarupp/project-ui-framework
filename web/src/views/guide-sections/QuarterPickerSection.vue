<template>
  <div class="component-section">
    <h2>Quarter Picker</h2>
    <p>A specialized calendar component for selecting financial or calendar quarters (Q1-Q4) within a given year.</p>

    <!-- Basic Quarter Picker -->
    <div style="margin-top: 40px;">
      <h3>Basic Quarter Picker (PPQuarterPicker)</h3>
      <p>A simple inline quarter picker, similar to the month and year pickers.</p>
      
      <div class="demo-box" style="padding: 40px; background: #f8fafc; border-radius: 12px; display: flex; flex-direction: column; align-items: center; gap: 20px;">
        <div style="width: 300px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); border-radius: 12px; overflow: hidden;">
          <PPQuarterPicker 
            @quarter-selected="onQuarterSelected" 
          />
        </div>
        <p v-if="selectedQuarter" style="font-size: 14px; color: #64748b;">Selected: <strong>{{ selectedQuarter.year }} - Q{{ selectedQuarter.quarter }}</strong></p>
      </div>

      <div style="margin-top: 16px;">
        <pre class="code-block"><code>&lt;template&gt;
  &lt;PPQuarterPicker @quarter-selected="onSelect" /&gt;
&lt;/template&gt;

&lt;script setup&gt;
const onSelect = (selection) =&gt; {
  console.log(selection.year, selection.quarter);
};
&lt;/script&gt;</code></pre>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { PPQuarterPicker } from '@phanna/ui-framework';

const selectedQuarter = ref<{ year: number, quarter: number } | null>(null);

const onQuarterSelected = (selection: { year: number, quarter: number }) => {
  selectedQuarter.value = selection;
};
</script>

<style scoped>
.component-section {
  max-width: 800px;
}
.demo-box {
  border: 1px solid #e2e8f0;
}
h2 {
  font-size: 28px;
  font-weight: 700;
  margin-bottom: 8px;
}
h3 {
  font-size: 20px;
  font-weight: 600;
  margin-bottom: 8px;
}
p {
  color: #64748b;
  margin-bottom: 16px;
  line-height: 1.5;
}
.code-block {
  background: #1e293b;
  color: #f8fafc;
  padding: 16px;
  border-radius: 8px;
  overflow-x: auto;
  font-size: 14px;
}
</style>
