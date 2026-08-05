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
        <pre v-pre><code>
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
  
        <div class="variant-group">
          <h3>Customizing CSS</h3>
          <p class="custom-guide">You can override the component's appearance globally via CSS variables or by targeting its specific classes.</p>
          <pre class="code-block" v-pre><code>/* Override globally */
:root {
  --pp-bg-color: /* value */;
  --pp-border-color: /* value */;
  --pp-primary-color: /* value */;
  --pp-primary-variant: /* value */;
  --pp-text-color: /* value */;
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
    &lt;h2&gt;Tree Select&lt;/h2&gt;
    &lt;p&gt;A form component that combines a dropdown with a hierarchical tree structure for selecting complex, nested data.&lt;/p&gt;

    &lt;!-- Basic Tree Select --&gt;
    &lt;div style="margin-top: 40px;"&gt;
      &lt;h3&gt;Basic Tree Select&lt;/h3&gt;
      &lt;p&gt;A simple tree select allowing selection of a single node from a hierarchy.&lt;/p&gt;
      
      &lt;div class="demo-box" style="padding: 40px; background: #f8fafc; border-radius: 12px; display: flex; flex-direction: column; align-items: center; gap: 20px;"&gt;
        &lt;div style="width: 320px;"&gt;
          &lt;PPTreeSelect 
            v-model="selectedDepartmentId" 
            :data="departmentTree" 
            placeholder="Select a department..."
            label="Department"
            :clearable="true"
          /&gt;
        &lt;/div&gt;
        &lt;p v-if="selectedDepartmentId" style="font-size: 14px; color: #64748b;"&gt;Selected ID: &lt;strong&gt;{{ selectedDepartmentId }}&lt;/strong&gt;&lt;/p&gt;
      &lt;/div&gt;

      &lt;div class="code-block" style="margin-top: 20px;"&gt;
        &lt;pre&gt;&lt;code&gt;
&amp;lt;template&amp;gt;
  &amp;lt;PPTreeSelect 
    v-model="selectedId" 
    :data="treeData" 
    placeholder="Select a department..."
    label="Department"
    :clearable="true"
  /&amp;gt;
&amp;lt;/template&amp;gt;

&amp;lt;script setup&amp;gt;
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
&amp;lt;/script&amp;gt;
        &lt;/code&gt;&lt;/pre&gt;
      &lt;/div&gt;
    &lt;/div&gt;

    &lt;!-- Variants --&gt;
    &lt;div style="margin-top: 40px;"&gt;
      &lt;h3&gt;Design Variants&lt;/h3&gt;
      &lt;p&gt;Tree Select supports the same variants as other input fields: &lt;code&gt;outline&lt;/code&gt; (default), &lt;code&gt;filled&lt;/code&gt;, and &lt;code&gt;flushed&lt;/code&gt;.&lt;/p&gt;
      
      &lt;div class="demo-box" style="padding: 40px; background: #f8fafc; border-radius: 12px; display: flex; flex-direction: column; gap: 20px;"&gt;
        &lt;div style="width: 320px; margin: 0 auto;"&gt;
          &lt;PPTreeSelect 
            v-model="selectedVariantId" 
            :data="departmentTree" 
            variant="outline"
            placeholder="Outline variant (Default)"
          /&gt;
        &lt;/div&gt;
        &lt;div style="width: 320px; margin: 0 auto;"&gt;
          &lt;PPTreeSelect 
            v-model="selectedVariantId" 
            :data="departmentTree" 
            variant="filled"
            placeholder="Filled variant"
          /&gt;
        &lt;/div&gt;
        &lt;div style="width: 320px; margin: 0 auto;"&gt;
          &lt;PPTreeSelect 
            v-model="selectedVariantId" 
            :data="departmentTree" 
            variant="flushed"
            placeholder="Flushed variant"
          /&gt;
        &lt;/div&gt;
      &lt;/div&gt;
    &lt;/div&gt;

    &lt;!-- Disabled &amp; Error States --&gt;
    &lt;div style="margin-top: 40px;"&gt;
      &lt;h3&gt;States&lt;/h3&gt;
      
      &lt;div class="demo-box" style="padding: 40px; background: #f8fafc; border-radius: 12px; display: flex; flex-direction: column; gap: 20px;"&gt;
        &lt;div style="width: 320px; margin: 0 auto;"&gt;
          &lt;PPTreeSelect 
            v-model="selectedDepartmentId" 
            :data="departmentTree" 
            disabled
            label="Disabled State"
            placeholder="You cannot select this"
          /&gt;
        &lt;/div&gt;
        &lt;div style="width: 320px; margin: 0 auto;"&gt;
          &lt;PPTreeSelect 
            v-model="selectedDepartmentId" 
            :data="departmentTree" 
            error="Please select a valid department"
            label="Error State"
          /&gt;
        &lt;/div&gt;
      &lt;/div&gt;
    &lt;/div&gt;
  
        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Customizing CSS&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;You can override the component's appearance globally via CSS variables or by targeting its specific classes.&lt;/p&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;/* Override globally */
:root {
  --pp-bg-color: /* value */;
  --pp-border-color: /* value */;
  --pp-primary-color: /* value */;
  --pp-primary-variant: /* value */;
  --pp-text-color: /* value */;
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
import { PPTreeSelect } from '@phanna/ui-framework';

const selectedDepartmentId = ref&lt;string | undefined&gt;(undefined);
const selectedVariantId = ref&lt;string | undefined&gt;(undefined);

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
    label: 'Sales &amp; Marketing',
    children: [
      { id: 'mkt', label: 'Marketing' },
      { id: 'bd', label: 'Business Development' },
      { id: 'sales-us', label: 'US Sales' },
      { id: 'sales-eu', label: 'EU Sales' }
    ]
  }
];
&lt;/script&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { PPTreeSelect } from '@phanna/ui-framework';

const selectedDepartmentId = ref<string | undefined>(undefined);
const selectedVariantId = ref<string | undefined>(undefined);

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
