<template>
  <div class="component-section">
    <h2>Table</h2>
    <p>A data table component with sorting, pagination, selection, and expansion support.</p>

    <!-- Basic & Styling -->
    <div class="demo-box">
      <h3>Basic & Styling</h3>
      <div class="demo-content">
        <div style="display: flex; gap: 16px; margin-bottom: 16px; flex-wrap: wrap; align-items: center;">
          <label><input type="checkbox" v-model="isStriped"> Striped</label>
          <label><input type="checkbox" v-model="isBordered"> Bordered</label>
          <label><input type="checkbox" v-model="isCompact"> Compact</label>
        </div>

        <PPTable 
          :columns="columns" 
          :data="basicData"
          :striped="isStriped"
          :bordered="isBordered"
          :compact="isCompact"
        >
          <template #status="{ row }">
            <span class="status-badge" :class="`is-${row.status}`">{{ row.status }}</span>
          </template>
        </PPTable>
      </div>
      <pre class="code-block" v-pre><code>&lt;PPTable 
  :columns="columns" 
  :data="data"
  :striped="true"
  :bordered="true"
  :compact="false"
&gt;
  &lt;template #status="{ row }"&gt;
    &lt;span :class="`is-${row.status}`"&gt;{{ row.status }}&lt;/span&gt;
  &lt;/template&gt;
&lt;/PPTable&gt;</code></pre>
    </div>

    <!-- Pagination -->
    <div class="demo-box">
      <h3>Pagination</h3>
      <div class="demo-content">
        <div style="display: flex; gap: 16px; margin-bottom: 16px; flex-wrap: wrap; align-items: center;">
          <label><input type="checkbox" v-model="showFirstLast"> First/Last</label>
          <select v-model="paginationVariant" style="padding: 4px 8px; border-radius: 4px; border: 1px solid #ccc;">
            <option value="outline">Pagination: Outline</option>
            <option value="solid">Pagination: Solid</option>
            <option value="ghost">Pagination: Ghost</option>
          </select>
          <select v-model="paginationShape" style="padding: 4px 8px; border-radius: 4px; border: 1px solid #ccc;">
            <option value="rounded">Shape: Rounded</option>
            <option value="circle">Shape: Circle</option>
          </select>
          <select v-model="paginationAlign" style="padding: 4px 8px; border-radius: 4px; border: 1px solid #ccc;">
            <option value="left">Align: Left</option>
            <option value="center">Align: Center</option>
            <option value="right">Align: Right</option>
          </select>
          <select v-model="sizeChangerPosition" style="padding: 4px 8px; border-radius: 4px; border: 1px solid #ccc;">
            <option value="left">Size Changer: Left</option>
            <option value="right">Size Changer: Right</option>
          </select>
        </div>

        <PPTable 
          :columns="columns" 
          :data="tableData" 
          :pagination="true" 
          :pageSize="5"
          :paginationVariant="paginationVariant"
          :paginationShape="paginationShape"
          :paginationAlign="paginationAlign"
          :showSizeChanger="true"
          :sizeChangerPosition="sizeChangerPosition"
          :pageSizes="[5, 10, 15, 20]"
          :showFirstLast="showFirstLast"
        >
          <template #status="{ row }">
            <span class="status-badge" :class="`is-${row.status}`">{{ row.status }}</span>
          </template>
        </PPTable>
      </div>
      <pre class="code-block" v-pre><code>&lt;PPTable 
  :columns="columns" 
  :data="data" 
  :pagination="true" 
  :pageSize="5"
  paginationVariant="outline"
  paginationShape="rounded"
  paginationAlign="right"
  :showSizeChanger="true"
  :pageSizes="[5, 10, 15, 20]"
  :showFirstLast="true"
/&gt;</code></pre>
    </div>

    <!-- Selection -->
    <div class="demo-box">
      <h3>Selectable Rows</h3>
      <div class="demo-content">
        <div style="display: flex; gap: 16px; margin-bottom: 16px; flex-wrap: wrap; align-items: center;">
          <label><input type="checkbox" v-model="isMultiple"> Multiple</label>
        </div>

        <PPTable 
          :columns="columns" 
          :data="basicData" 
          :selectable="true"
          :multiple="isMultiple"
          v-model="selectedRows"
        >
          <template #status="{ row }">
            <span class="status-badge" :class="`is-${row.status}`">{{ row.status }}</span>
          </template>
        </PPTable>
        
        <div style="margin-top: 16px; padding: 12px; background: #f0f0f0; border-radius: 4px; font-size: 14px;">
          <strong>Selected IDs:</strong> {{ selectedRows.map(r => r.id).join(', ') || 'None' }}
        </div>
      </div>
      <pre class="code-block" v-pre><code>&lt;PPTable 
  :columns="columns" 
  :data="data" 
  :selectable="true"
  :multiple="true"
  v-model="selectedRows"
/&gt;</code></pre>
    </div>

    <!-- Expandable -->
    <div class="demo-box">
      <h3>Expandable Rows</h3>
      <div class="demo-content">
        <PPTable 
          :columns="columns" 
          :data="basicData" 
          :expandable="true"
        >
          <template #status="{ row }">
            <span class="status-badge" :class="`is-${row.status}`">{{ row.status }}</span>
          </template>
          
          <template #expanded="{ row }">
            <div style="padding: 16px; background-color: #f9f9f9; border-radius: 8px; border: 1px dashed #ccc;">
              <strong>Expanded details for {{ row.name }}</strong>
              <p style="margin-top: 8px;">ID: {{ row.id }}</p>
              <p>Role: {{ row.role }}</p>
              <p>Status: {{ row.status }}</p>
            </div>
          </template>
        </PPTable>
      </div>
      <pre class="code-block" v-pre><code>&lt;PPTable 
  :columns="columns" 
  :data="data" 
  :expandable="true"
&gt;
  &lt;template #expanded="{ row }"&gt;
    &lt;div&gt;Expanded details for {{ row.name }}&lt;/div&gt;
  &lt;/template&gt;
&lt;/PPTable&gt;</code></pre>
    </div>

    <!-- Loading State -->
    <div class="demo-box">
      <h3>Loading State</h3>
      <div class="demo-content">
        <div style="display: flex; gap: 16px; margin-bottom: 16px; flex-wrap: wrap; align-items: center;">
          <label><input type="checkbox" v-model="isLoading"> Loading</label>
        </div>
        <PPTable 
          :columns="columns" 
          :data="basicData" 
          :loading="isLoading"
          :skeletonRows="4"
        >
          <template #status="{ row }">
            <span class="status-badge" :class="`is-${row.status}`">{{ row.status }}</span>
          </template>
        </PPTable>
      </div>
      <pre class="code-block" v-pre><code>&lt;PPTable 
  :columns="columns" 
  :data="data" 
  :loading="true"
  :skeletonRows="4"
/&gt;</code></pre>
    </div>

    <!-- Empty State -->
    <div class="demo-box">
      <h3>Empty State</h3>
      <div class="demo-content">
        <PPTable 
          :columns="columns" 
          :data="[]" 
          emptyText="Custom No Data Message"
        >
        </PPTable>
      </div>
      <pre class="code-block" v-pre><code>&lt;PPTable 
  :columns="columns" 
  :data="[]" 
  emptyText="Custom No Data Message"
  emptyIcon="&lt;svg...&gt;&lt;/svg&gt;"
/&gt;</code></pre>
    </div>


    <!-- Empty State -->
    <div class="demo-box">
      <h3>Empty State</h3>
      <div class="demo-content">
        <PPTable 
          :columns="columns" 
          :data="[]" 
          emptyText="Custom No Data Message"
        >
        </PPTable>
      </div>
      <pre class="code-block" v-pre><code>&amp;lt;PPTable 
  :columns="columns" 
  :data="[]" 
  emptyText="Custom No Data Message"
/&amp;gt;</code></pre>
    </div>

    <!-- Empty State -->
    <div class="demo-box">
      <h3>Empty State</h3>
      <div class="demo-content">
        <PPTable 
          :columns="columns" 
          :data="[]" 
          emptyText="Custom No Data Message"
        >
        </PPTable>
      </div>
      <pre class="code-block" v-pre><code>&amp;lt;PPTable 
  :columns="columns" 
  :data="[]" 
  emptyText="Custom No Data Message"
/&amp;gt;</code></pre>
    </div>

    <!-- Row/Column Spanning -->
    <div class="demo-box">
      <h3>Row/Column Spanning</h3>
      <div class="demo-content">
        <PPTable 
          :columns="spanColumns" 
          :data="spanData" 
          :bordered="true"
          :spanMethod="handleSpan"
        />
      </div>
      <pre class="code-block" v-pre><code>&lt;PPTable 
  :columns="columns" 
  :data="data" 
  :bordered="true"
  :spanMethod="handleSpan"
/&gt;

// In script:
const handleSpan = ({ rowIndex, columnIndex }) =&gt; {
  // Merge first column for rows 0 and 1
  if (columnIndex === 0) {
    if (rowIndex % 2 === 0) {
      return { rowspan: 2, colspan: 1 };
    } else {
      return { rowspan: 0, colspan: 0 };
    }
  }
};</code></pre>
    </div>

  
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
      <pre class="code-block" v-pre style="max-height: 500px; overflow-y: auto;"><code>&lt;template&gt;
  &lt;div class="component-section"&gt;
    &lt;h2&gt;Table&lt;/h2&gt;
    &lt;p&gt;A data table component with sorting, pagination, selection, and expansion support.&lt;/p&gt;

    &lt;!-- Basic &amp; Styling --&gt;
    &lt;div class="demo-box"&gt;
      &lt;h3&gt;Basic &amp; Styling&lt;/h3&gt;
      &lt;div class="demo-content"&gt;
        &lt;div style="display: flex; gap: 16px; margin-bottom: 16px; flex-wrap: wrap; align-items: center;"&gt;
          &lt;label&gt;&lt;input type="checkbox" v-model="isStriped"&gt; Striped&lt;/label&gt;
          &lt;label&gt;&lt;input type="checkbox" v-model="isBordered"&gt; Bordered&lt;/label&gt;
          &lt;label&gt;&lt;input type="checkbox" v-model="isCompact"&gt; Compact&lt;/label&gt;
        &lt;/div&gt;

        &lt;PPTable 
          :columns="columns" 
          :data="basicData"
          :striped="isStriped"
          :bordered="isBordered"
          :compact="isCompact"
        &gt;
          &lt;template #status="{ row }"&gt;
            &lt;span class="status-badge" :class="`is-${row.status}`"&gt;{{ row.status }}&lt;/span&gt;
          &lt;/template&gt;
        &lt;/PPTable&gt;
      &lt;/div&gt;
      &lt;pre class="code-block" v-pre&gt;&lt;code&gt;&amp;lt;PPTable 
  :columns="columns" 
  :data="data"
  :striped="true"
  :bordered="true"
  :compact="false"
&amp;gt;
  &amp;lt;template #status="{ row }"&amp;gt;
    &amp;lt;span :class="`is-${row.status}`"&amp;gt;{{ row.status }}&amp;lt;/span&amp;gt;
  &amp;lt;/template&amp;gt;
&amp;lt;/PPTable&amp;gt;&lt;/code&gt;&lt;/pre&gt;
    &lt;/div&gt;

    &lt;!-- Pagination --&gt;
    &lt;div class="demo-box"&gt;
      &lt;h3&gt;Pagination&lt;/h3&gt;
      &lt;div class="demo-content"&gt;
        &lt;div style="display: flex; gap: 16px; margin-bottom: 16px; flex-wrap: wrap; align-items: center;"&gt;
          &lt;label&gt;&lt;input type="checkbox" v-model="showFirstLast"&gt; First/Last&lt;/label&gt;
          &lt;select v-model="paginationVariant" style="padding: 4px 8px; border-radius: 4px; border: 1px solid #ccc;"&gt;
            &lt;option value="outline"&gt;Pagination: Outline&lt;/option&gt;
            &lt;option value="solid"&gt;Pagination: Solid&lt;/option&gt;
            &lt;option value="ghost"&gt;Pagination: Ghost&lt;/option&gt;
          &lt;/select&gt;
          &lt;select v-model="paginationShape" style="padding: 4px 8px; border-radius: 4px; border: 1px solid #ccc;"&gt;
            &lt;option value="rounded"&gt;Shape: Rounded&lt;/option&gt;
            &lt;option value="circle"&gt;Shape: Circle&lt;/option&gt;
          &lt;/select&gt;
          &lt;select v-model="paginationAlign" style="padding: 4px 8px; border-radius: 4px; border: 1px solid #ccc;"&gt;
            &lt;option value="left"&gt;Align: Left&lt;/option&gt;
            &lt;option value="center"&gt;Align: Center&lt;/option&gt;
            &lt;option value="right"&gt;Align: Right&lt;/option&gt;
          &lt;/select&gt;
          &lt;select v-model="sizeChangerPosition" style="padding: 4px 8px; border-radius: 4px; border: 1px solid #ccc;"&gt;
            &lt;option value="left"&gt;Size Changer: Left&lt;/option&gt;
            &lt;option value="right"&gt;Size Changer: Right&lt;/option&gt;
          &lt;/select&gt;
        &lt;/div&gt;

        &lt;PPTable 
          :columns="columns" 
          :data="tableData" 
          :pagination="true" 
          :pageSize="5"
          :paginationVariant="paginationVariant"
          :paginationShape="paginationShape"
          :paginationAlign="paginationAlign"
          :showSizeChanger="true"
          :sizeChangerPosition="sizeChangerPosition"
          :pageSizes="[5, 10, 15, 20]"
          :showFirstLast="showFirstLast"
        &gt;
          &lt;template #status="{ row }"&gt;
            &lt;span class="status-badge" :class="`is-${row.status}`"&gt;{{ row.status }}&lt;/span&gt;
          &lt;/template&gt;
        &lt;/PPTable&gt;
      &lt;/div&gt;
      &lt;pre class="code-block" v-pre&gt;&lt;code&gt;&amp;lt;PPTable 
  :columns="columns" 
  :data="data" 
  :pagination="true" 
  :pageSize="5"
  paginationVariant="outline"
  paginationShape="rounded"
  paginationAlign="right"
  :showSizeChanger="true"
  :pageSizes="[5, 10, 15, 20]"
  :showFirstLast="true"
/&amp;gt;&lt;/code&gt;&lt;/pre&gt;
    &lt;/div&gt;

    &lt;!-- Selection --&gt;
    &lt;div class="demo-box"&gt;
      &lt;h3&gt;Selectable Rows&lt;/h3&gt;
      &lt;div class="demo-content"&gt;
        &lt;div style="display: flex; gap: 16px; margin-bottom: 16px; flex-wrap: wrap; align-items: center;"&gt;
          &lt;label&gt;&lt;input type="checkbox" v-model="isMultiple"&gt; Multiple&lt;/label&gt;
        &lt;/div&gt;

        &lt;PPTable 
          :columns="columns" 
          :data="basicData" 
          :selectable="true"
          :multiple="isMultiple"
          v-model="selectedRows"
        &gt;
          &lt;template #status="{ row }"&gt;
            &lt;span class="status-badge" :class="`is-${row.status}`"&gt;{{ row.status }}&lt;/span&gt;
          &lt;/template&gt;
        &lt;/PPTable&gt;
        
        &lt;div style="margin-top: 16px; padding: 12px; background: #f0f0f0; border-radius: 4px; font-size: 14px;"&gt;
          &lt;strong&gt;Selected IDs:&lt;/strong&gt; {{ selectedRows.map(r =&gt; r.id).join(', ') || 'None' }}
        &lt;/div&gt;
      &lt;/div&gt;
      &lt;pre class="code-block" v-pre&gt;&lt;code&gt;&amp;lt;PPTable 
  :columns="columns" 
  :data="data" 
  :selectable="true"
  :multiple="true"
  v-model="selectedRows"
/&amp;gt;&lt;/code&gt;&lt;/pre&gt;
    &lt;/div&gt;

    &lt;!-- Expandable --&gt;
    &lt;div class="demo-box"&gt;
      &lt;h3&gt;Expandable Rows&lt;/h3&gt;
      &lt;div class="demo-content"&gt;
        &lt;PPTable 
          :columns="columns" 
          :data="basicData" 
          :expandable="true"
        &gt;
          &lt;template #status="{ row }"&gt;
            &lt;span class="status-badge" :class="`is-${row.status}`"&gt;{{ row.status }}&lt;/span&gt;
          &lt;/template&gt;
          
          &lt;template #expanded="{ row }"&gt;
            &lt;div style="padding: 16px; background-color: #f9f9f9; border-radius: 8px; border: 1px dashed #ccc;"&gt;
              &lt;strong&gt;Expanded details for {{ row.name }}&lt;/strong&gt;
              &lt;p style="margin-top: 8px;"&gt;ID: {{ row.id }}&lt;/p&gt;
              &lt;p&gt;Role: {{ row.role }}&lt;/p&gt;
              &lt;p&gt;Status: {{ row.status }}&lt;/p&gt;
            &lt;/div&gt;
          &lt;/template&gt;
        &lt;/PPTable&gt;
      &lt;/div&gt;
      &lt;pre class="code-block" v-pre&gt;&lt;code&gt;&amp;lt;PPTable 
  :columns="columns" 
  :data="data" 
  :expandable="true"
&amp;gt;
  &amp;lt;template #expanded="{ row }"&amp;gt;
    &amp;lt;div&amp;gt;Expanded details for {{ row.name }}&amp;lt;/div&amp;gt;
  &amp;lt;/template&amp;gt;
&amp;lt;/PPTable&amp;gt;&lt;/code&gt;&lt;/pre&gt;
    &lt;/div&gt;

    &lt;!-- Loading State --&gt;
    &lt;div class="demo-box"&gt;
      &lt;h3&gt;Loading State&lt;/h3&gt;
      &lt;div class="demo-content"&gt;
        &lt;div style="display: flex; gap: 16px; margin-bottom: 16px; flex-wrap: wrap; align-items: center;"&gt;
          &lt;label&gt;&lt;input type="checkbox" v-model="isLoading"&gt; Loading&lt;/label&gt;
        &lt;/div&gt;
        &lt;PPTable 
          :columns="columns" 
          :data="basicData" 
          :loading="isLoading"
          :skeletonRows="4"
        &gt;
          &lt;template #status="{ row }"&gt;
            &lt;span class="status-badge" :class="`is-${row.status}`"&gt;{{ row.status }}&lt;/span&gt;
          &lt;/template&gt;
        &lt;/PPTable&gt;
      &lt;/div&gt;
      &lt;pre class="code-block" v-pre&gt;&lt;code&gt;&amp;lt;PPTable 
  :columns="columns" 
  :data="data" 
  :loading="true"
  :skeletonRows="4"
/&amp;gt;&lt;/code&gt;&lt;/pre&gt;
    &lt;/div&gt;

    &lt;!-- Row/Column Spanning --&gt;
    &lt;div class="demo-box"&gt;
      &lt;h3&gt;Row/Column Spanning&lt;/h3&gt;
      &lt;div class="demo-content"&gt;
        &lt;PPTable 
          :columns="spanColumns" 
          :data="spanData" 
          :bordered="true"
          :spanMethod="handleSpan"
        /&gt;
      &lt;/div&gt;
      &lt;pre class="code-block" v-pre&gt;&lt;code&gt;&amp;lt;PPTable 
  :columns="columns" 
  :data="data" 
  :bordered="true"
  :spanMethod="handleSpan"
/&amp;gt;

// In script:
const handleSpan = ({ rowIndex, columnIndex }) =&amp;gt; {
  // Merge first column for rows 0 and 1
  if (columnIndex === 0) {
    if (rowIndex % 2 === 0) {
      return { rowspan: 2, colspan: 1 };
    } else {
      return { rowspan: 0, colspan: 0 };
    }
  }
};&lt;/code&gt;&lt;/pre&gt;
    &lt;/div&gt;

  
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
import { PPTable } from '@phanna/ui-framework';

const columns = ref([
  { key: 'id', title: 'ID', width: '60px', sortable: true },
  { key: 'name', title: 'Name', sortable: true },
  { key: 'role', title: 'Role', sortable: true },
  { key: 'status', title: 'Status' }
]);

const isStriped = ref(false);
const isBordered = ref(false);
const isCompact = ref(false);

const showFirstLast = ref(true);
const paginationVariant = ref('outline');
const paginationShape = ref('rounded');
const paginationAlign = ref('right');
const sizeChangerPosition = ref('left');

const isMultiple = ref(true);
const selectedRows = ref&lt;any[]&gt;([]);

const isLoading = ref(true);

const spanColumns = ref([
  { key: 'category', title: 'Category' },
  { key: 'name', title: 'Item Name' },
  { key: 'price', title: 'Price' }
]);

const spanData = ref([
  { id: 1, category: 'Fruits', name: 'Apple', price: '$1.00' },
  { id: 2, category: 'Fruits', name: 'Banana', price: '$0.50' },
  { id: 3, category: 'Vegetables', name: 'Carrot', price: '$0.80' },
  { id: 4, category: 'Vegetables', name: 'Broccoli', price: '$1.20' }
]);

const handleSpan = ({ rowIndex, columnIndex }: { row: any, column: any, rowIndex: number, columnIndex: number }) =&gt; {
  // Merge the 'Category' column (columnIndex === 0) for every 2 rows
  if (columnIndex === 0) {
    if (rowIndex % 2 === 0) {
      return { rowspan: 2, colspan: 1 }; // span this row to cover the next one
    } else {
      return { rowspan: 0, colspan: 0 }; // hide this row's cell
    }
  }
};

const basicData = ref([
  { id: 1, name: 'User 1', role: 'Admin', status: 'active' },
  { id: 2, name: 'User 2', role: 'Editor', status: 'inactive' },
  { id: 3, name: 'User 3', role: 'Viewer', status: 'active' },
  { id: 4, name: 'User 4', role: 'Admin', status: 'inactive' }
]);

const tableData = ref(Array.from({ length: 24 }).map((_, i) =&gt; ({
  id: i + 1,
  name: `User ${i + 1}`,
  role: i % 3 === 0 ? 'Admin' : i % 2 === 0 ? 'Editor' : 'Viewer',
  status: i % 4 === 0 ? 'inactive' : 'active'
})));
&lt;/script&gt;

&lt;style scoped&gt;
.demo-box {
  border: 1px solid #e0e0e0;
  border-radius: 8px;
  padding: 24px;
  margin-top: 16px;
  background: white;
}
.demo-content {
  margin-bottom: 24px;
  padding: 16px;
  background: #f9f9f9;
  border-radius: 4px;
}
.status-badge {
  display: inline-block;
  padding: 4px 8px;
  border-radius: 12px;
  font-size: 12px;
  font-weight: 500;
  text-transform: capitalize;
}
.status-badge.is-active {
  background-color: #e8f5e9;
  color: #2e7d32;
}
.status-badge.is-inactive {
  background-color: #ffebee;
  color: #c62828;
}
&lt;/style&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { PPTable } from '@phanna/ui-framework';

const columns = ref([
  { key: 'id', title: 'ID', width: '60px', sortable: true },
  { key: 'name', title: 'Name', sortable: true },
  { key: 'role', title: 'Role', sortable: true },
  { key: 'status', title: 'Status' }
]);

const isStriped = ref(false);
const isBordered = ref(false);
const isCompact = ref(false);

const showFirstLast = ref(true);
const paginationVariant = ref('outline');
const paginationShape = ref('rounded');
const paginationAlign = ref('right');
const sizeChangerPosition = ref('left');

const isMultiple = ref(true);
const selectedRows = ref<any[]>([]);

const isLoading = ref(true);

const spanColumns = ref([
  { key: 'category', title: 'Category' },
  { key: 'name', title: 'Item Name' },
  { key: 'price', title: 'Price' }
]);

const spanData = ref([
  { id: 1, category: 'Fruits', name: 'Apple', price: '$1.00' },
  { id: 2, category: 'Fruits', name: 'Banana', price: '$0.50' },
  { id: 3, category: 'Vegetables', name: 'Carrot', price: '$0.80' },
  { id: 4, category: 'Vegetables', name: 'Broccoli', price: '$1.20' }
]);

const handleSpan = ({ rowIndex, columnIndex }: { row: any, column: any, rowIndex: number, columnIndex: number }) => {
  // Merge the 'Category' column (columnIndex === 0) for every 2 rows
  if (columnIndex === 0) {
    if (rowIndex % 2 === 0) {
      return { rowspan: 2, colspan: 1 }; // span this row to cover the next one
    } else {
      return { rowspan: 0, colspan: 0 }; // hide this row's cell
    }
  }
};

const basicData = ref([
  { id: 1, name: 'User 1', role: 'Admin', status: 'active' },
  { id: 2, name: 'User 2', role: 'Editor', status: 'inactive' },
  { id: 3, name: 'User 3', role: 'Viewer', status: 'active' },
  { id: 4, name: 'User 4', role: 'Admin', status: 'inactive' }
]);

const tableData = ref(Array.from({ length: 24 }).map((_, i) => ({
  id: i + 1,
  name: `User ${i + 1}`,
  role: i % 3 === 0 ? 'Admin' : i % 2 === 0 ? 'Editor' : 'Viewer',
  status: i % 4 === 0 ? 'inactive' : 'active'
})));
</script>

<style scoped>
.demo-box {
  border: 1px solid #e0e0e0;
  border-radius: 8px;
  padding: 24px;
  margin-top: 16px;
  background: white;
}
.demo-content {
  margin-bottom: 24px;
  padding: 16px;
  background: #f9f9f9;
  border-radius: 4px;
}
.status-badge {
  display: inline-block;
  padding: 4px 8px;
  border-radius: 12px;
  font-size: 12px;
  font-weight: 500;
  text-transform: capitalize;
}
.status-badge.is-active {
  background-color: #e8f5e9;
  color: #2e7d32;
}
.status-badge.is-inactive {
  background-color: #ffebee;
  color: #c62828;
}
</style>
