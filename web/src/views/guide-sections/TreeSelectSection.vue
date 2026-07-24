<template>
  <div class="component-section">
    <h2>Tree Select</h2>
    <p>A form component that combines a dropdown with a hierarchical tree structure for selecting complex, nested data.</p>

    <!-- Basic Tree Select -->
    <div style="margin-top: 40px;">
      <h3>Basic Tree Select</h3>
      <p>A simple tree select allowing selection of a single node from a hierarchy.</p>
      
      <div class="demo-box" style="padding: 40px; background: #f8fafc; border-radius: 12px; display: flex; flex-direction: column; align-items: center; gap: 20px;">
        <div style="width: 320px;">
          <PPTreeSelect 
            v-model="selectedDepartmentId" 
            :data="departmentTree" 
            placeholder="Select a department..."
            label="Department"
            :clearable="true"
          />
        </div>
        <p v-if="selectedDepartmentId" style="font-size: 14px; color: #64748b;">Selected ID: <strong>{{ selectedDepartmentId }}</strong></p>
      </div>

      <div class="code-block" style="margin-top: 20px;">
        <pre><code>
&lt;template&gt;
  &lt;PPTreeSelect 
    v-model="selectedId" 
    :data="treeData" 
    placeholder="Select a department..."
    label="Department"
    :clearable="true"
  /&gt;
&lt;/template&gt;

&lt;script setup&gt;
import { ref } from 'vue';

const selectedId = ref(null);
const treeData = [
  {
    id: 'corp',
    label: 'Corporate',
    children: [
      { id: 'hr', label: 'Human Resources' },
      { id: 'fin', label: 'Finance' },
      { id: 'leg', label: 'Legal' }
    ]
  },
  {
    id: 'prod',
    label: 'Product',
    children: [
      { id: 'eng', label: 'Engineering' },
      { id: 'des', label: 'Design' },
      { id: 'pm', label: 'Product Management' }
    ]
  }
];
&lt;/script&gt;
        </code></pre>
      </div>
    </div>

    <!-- Variants -->
    <div style="margin-top: 40px;">
      <h3>Design Variants</h3>
      <p>Tree Select supports the same variants as other input fields: <code>outline</code> (default), <code>filled</code>, and <code>flushed</code>.</p>
      
      <div class="demo-box" style="padding: 40px; background: #f8fafc; border-radius: 12px; display: flex; flex-direction: column; gap: 20px;">
        <div style="width: 320px; margin: 0 auto;">
          <PPTreeSelect 
            v-model="selectedVariantId" 
            :data="departmentTree" 
            variant="outline"
            placeholder="Outline variant (Default)"
          />
        </div>
        <div style="width: 320px; margin: 0 auto;">
          <PPTreeSelect 
            v-model="selectedVariantId" 
            :data="departmentTree" 
            variant="filled"
            placeholder="Filled variant"
          />
        </div>
        <div style="width: 320px; margin: 0 auto;">
          <PPTreeSelect 
            v-model="selectedVariantId" 
            :data="departmentTree" 
            variant="flushed"
            placeholder="Flushed variant"
          />
        </div>
      </div>
    </div>

    <!-- Disabled & Error States -->
    <div style="margin-top: 40px;">
      <h3>States</h3>
      
      <div class="demo-box" style="padding: 40px; background: #f8fafc; border-radius: 12px; display: flex; flex-direction: column; gap: 20px;">
        <div style="width: 320px; margin: 0 auto;">
          <PPTreeSelect 
            v-model="selectedDepartmentId" 
            :data="departmentTree" 
            disabled
            label="Disabled State"
            placeholder="You cannot select this"
          />
        </div>
        <div style="width: 320px; margin: 0 auto;">
          <PPTreeSelect 
            v-model="selectedDepartmentId" 
            :data="departmentTree" 
            error="Please select a valid department"
            label="Error State"
          />
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { PPTreeSelect } from '@phanna/ui-framework';

const selectedDepartmentId = ref<string | null>(null);
const selectedVariantId = ref<string | null>(null);

const departmentTree = [
  {
    id: 'corp',
    label: 'Corporate',
    children: [
      { id: 'hr', label: 'Human Resources' },
      { id: 'fin', label: 'Finance' },
      { id: 'leg', label: 'Legal' }
    ]
  },
  {
    id: 'prod',
    label: 'Product',
    children: [
      { 
        id: 'eng', 
        label: 'Engineering',
        children: [
          { id: 'fe', label: 'Frontend' },
          { id: 'be', label: 'Backend' },
          { id: 'qa', label: 'Quality Assurance' }
        ]
      },
      { id: 'des', label: 'Design' },
      { id: 'pm', label: 'Product Management' }
    ]
  },
  {
    id: 'sales',
    label: 'Sales & Marketing',
    children: [
      { id: 'mkt', label: 'Marketing' },
      { id: 'bd', label: 'Business Development' },
      { id: 'sales-us', label: 'US Sales' },
      { id: 'sales-eu', label: 'EU Sales' }
    ]
  }
];
</script>
