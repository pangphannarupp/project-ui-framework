<template>
  <div class="component-section">
    <h2>Draggable Grid</h2>
    <p>A CSS grid layout that supports drag-and-drop reordering, as well as accepting items from external drag sources.</p>

    <div class="demo-box draggable-demo-layout">
      <!-- External Draggable Items -->
      <div class="external-source">
        <h3>Components (Drag me!)</h3>
        <p class="helper-text">Drag these items into the grid on the right.</p>
        <div class="external-items-list">
          <div 
            v-for="item in availableItems" 
            :key="item.id"
            class="external-item"
            draggable="true"
            @dragstart="onExternalDragStart($event, item)"
          >
            <div class="item-icon">{{ item.icon }}</div>
            <div class="item-name">{{ item.name }}</div>
          </div>
        </div>
      </div>

      <!-- The Grid -->
      <div class="grid-destination">
        <h3>Dashboard Layout</h3>
        <p class="helper-text">Drag items here to add or rearrange.</p>
        
        <div class="grid-controls">
          <label>Columns: <input type="number" v-model="gridColumns" min="1" max="6"></label>
        </div>

        <PPDraggableGrid 
          v-model="gridItems" 
          :columns="gridColumns"
          gap="16px"
          @drop-external="onDropExternal"
        >
          <!-- Custom template for each item in the grid -->
          <template #item="{ item, index }">
            <div class="grid-card">
              <div class="card-header">
                <span class="card-icon">{{ item.icon }}</span>
                <span class="card-title">{{ item.name }}</span>
                <button class="remove-btn" @click.stop="removeItem(index)">✕</button>
              </div>
              <div class="card-body">
                Placeholder content for {{ item.name }}.
              </div>
            </div>
          </template>
          
          <!-- Custom template for empty state -->
          <template #empty>
            <div class="empty-state">
              <div style="font-size: 24px; margin-bottom: 8px;">📥</div>
              Drop components here to build your dashboard
            </div>
          </template>
        </PPDraggableGrid>
        
        <div style="margin-top: 24px; padding: 12px; background: #f0f0f0; border-radius: 4px; font-size: 14px;">
          <strong>Current Order:</strong> {{ gridItems.map(i => i.name).join(' → ') || 'Empty' }}
        </div>
      </div>
    </div>
    
    <pre class="code-block" v-pre><code>&lt;!-- The Grid --&gt;
&lt;PPDraggableGrid 
  v-model="gridItems" 
  :columns="3"
  gap="16px"
  @drop-external="onDropExternal"
&gt;
  &lt;template #item="{ item, index }"&gt;
    &lt;div class="my-card"&gt;{{ item.name }}&lt;/div&gt;
  &lt;/template&gt;
&lt;/PPDraggableGrid&gt;

&lt;!-- External draggable source (make sure to set dataTransfer!) --&gt;
&lt;div 
  draggable="true" 
  @dragstart="(e) =&gt; {
    e.dataTransfer.setData('application/json', JSON.stringify(myObject));
  }"
&gt;Drag me!&lt;/div&gt;</code></pre>
  
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
  &lt;div class="component-section"&gt;
    &lt;h2&gt;Draggable Grid&lt;/h2&gt;
    &lt;p&gt;A CSS grid layout that supports drag-and-drop reordering, as well as accepting items from external drag sources.&lt;/p&gt;

    &lt;div class="demo-box draggable-demo-layout"&gt;
      &lt;!-- External Draggable Items --&gt;
      &lt;div class="external-source"&gt;
        &lt;h3&gt;Components (Drag me!)&lt;/h3&gt;
        &lt;p class="helper-text"&gt;Drag these items into the grid on the right.&lt;/p&gt;
        &lt;div class="external-items-list"&gt;
          &lt;div 
            v-for="item in availableItems" 
            :key="item.id"
            class="external-item"
            draggable="true"
            @dragstart="onExternalDragStart($event, item)"
          &gt;
            &lt;div class="item-icon"&gt;{{ item.icon }}&lt;/div&gt;
            &lt;div class="item-name"&gt;{{ item.name }}&lt;/div&gt;
          &lt;/div&gt;
        &lt;/div&gt;
      &lt;/div&gt;

      &lt;!-- The Grid --&gt;
      &lt;div class="grid-destination"&gt;
        &lt;h3&gt;Dashboard Layout&lt;/h3&gt;
        &lt;p class="helper-text"&gt;Drag items here to add or rearrange.&lt;/p&gt;
        
        &lt;div class="grid-controls"&gt;
          &lt;label&gt;Columns: &lt;input type="number" v-model="gridColumns" min="1" max="6"&gt;&lt;/label&gt;
        &lt;/div&gt;

        &lt;PPDraggableGrid 
          v-model="gridItems" 
          :columns="gridColumns"
          gap="16px"
          @drop-external="onDropExternal"
        &gt;
          &lt;!-- Custom template for each item in the grid --&gt;
          &lt;template #item="{ item, index }"&gt;
            &lt;div class="grid-card"&gt;
              &lt;div class="card-header"&gt;
                &lt;span class="card-icon"&gt;{{ item.icon }}&lt;/span&gt;
                &lt;span class="card-title"&gt;{{ item.name }}&lt;/span&gt;
                &lt;button class="remove-btn" @click.stop="removeItem(index)"&gt;✕&lt;/button&gt;
              &lt;/div&gt;
              &lt;div class="card-body"&gt;
                Placeholder content for {{ item.name }}.
              &lt;/div&gt;
            &lt;/div&gt;
          &lt;/template&gt;
          
          &lt;!-- Custom template for empty state --&gt;
          &lt;template #empty&gt;
            &lt;div class="empty-state"&gt;
              &lt;div style="font-size: 24px; margin-bottom: 8px;"&gt;📥&lt;/div&gt;
              Drop components here to build your dashboard
            &lt;/div&gt;
          &lt;/template&gt;
        &lt;/PPDraggableGrid&gt;
        
        &lt;div style="margin-top: 24px; padding: 12px; background: #f0f0f0; border-radius: 4px; font-size: 14px;"&gt;
          &lt;strong&gt;Current Order:&lt;/strong&gt; {{ gridItems.map(i =&gt; i.name).join(' → ') || 'Empty' }}
        &lt;/div&gt;
      &lt;/div&gt;
    &lt;/div&gt;
    
    &lt;pre class="code-block" v-pre&gt;&lt;code&gt;&amp;lt;!-- The Grid --&amp;gt;
&amp;lt;PPDraggableGrid 
  v-model="gridItems" 
  :columns="3"
  gap="16px"
  @drop-external="onDropExternal"
&amp;gt;
  &amp;lt;template #item="{ item, index }"&amp;gt;
    &amp;lt;div class="my-card"&amp;gt;{{ item.name }}&amp;lt;/div&amp;gt;
  &amp;lt;/template&amp;gt;
&amp;lt;/PPDraggableGrid&amp;gt;

&amp;lt;!-- External draggable source (make sure to set dataTransfer!) --&amp;gt;
&amp;lt;div 
  draggable="true" 
  @dragstart="(e) =&amp;gt; {
    e.dataTransfer.setData('application/json', JSON.stringify(myObject));
  }"
&amp;gt;Drag me!&amp;lt;/div&amp;gt;&lt;/code&gt;&lt;/pre&gt;
  
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
import { PPDraggableGrid } from '@phanna/ui-framework';

const gridColumns = ref(3);

const availableItems = ref([
  { id: 'stat-1', name: 'Revenue', icon: '💰' },
  { id: 'stat-2', name: 'Users', icon: '👥' },
  { id: 'chart-1', name: 'Analytics', icon: '📈' },
  { id: 'list-1', name: 'Recent Tasks', icon: '📋' },
  { id: 'alert-1', name: 'System Status', icon: '⚠️' }
]);

const gridItems = ref([
  { id: 'initial-1', name: 'Welcome Panel', icon: '👋' }
]);

const onExternalDragStart = (e: DragEvent, item: any) =&gt; {
  if (e.dataTransfer) {
    e.dataTransfer.effectAllowed = 'copy';
    // Stringify the item and set it as JSON payload
    // We add a random suffix to ID so we can drop the same item multiple times
    const dropItem = { ...item, id: `${item.id}-${Math.random().toString(36).substr(2, 9)}` };
    e.dataTransfer.setData('application/json', JSON.stringify(dropItem));
  }
};

const onDropExternal = ({ item, index }: { item: any, index: number }) =&gt; {
  console.log(`External item ${item.name} dropped at index ${index}`);
};

const removeItem = (index: number) =&gt; {
  gridItems.value.splice(index, 1);
};
&lt;/script&gt;

&lt;style scoped&gt;
.draggable-demo-layout {
  display: flex;
  gap: 24px;
  align-items: flex-start;
}

@media (max-width: 768px) {
  .draggable-demo-layout {
    flex-direction: column;
  }
}

.external-source {
  flex: 0 0 250px;
  background: #f8f9fa;
  border-radius: 8px;
  padding: 16px;
  border: 1px solid #e0e0e0;
}

.grid-destination {
  flex: 1;
  background: white;
  border-radius: 8px;
  padding: 16px;
  border: 1px solid #e0e0e0;
}

.helper-text {
  font-size: 13px;
  color: #666;
  margin-bottom: 16px;
}

.external-items-list {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.external-item {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 12px;
  background: white;
  border: 1px solid #ddd;
  border-radius: 6px;
  cursor: grab;
  box-shadow: 0 1px 3px rgba(0,0,0,0.05);
}
.external-item:active {
  cursor: grabbing;
}

.item-icon {
  font-size: 20px;
}
.item-name {
  font-weight: 500;
  font-size: 14px;
}

.grid-controls {
  margin-bottom: 16px;
}

.grid-card {
  background: white;
  border: 1px solid #e0e0e0;
  border-radius: 8px;
  height: 100%;
  display: flex;
  flex-direction: column;
  box-shadow: 0 2px 8px rgba(0,0,0,0.04);
}

.card-header {
  display: flex;
  align-items: center;
  padding: 12px;
  border-bottom: 1px solid #f0f0f0;
  background: #fafafa;
  border-radius: 8px 8px 0 0;
}

.card-icon {
  margin-right: 8px;
}

.card-title {
  font-weight: 600;
  flex: 1;
}

.remove-btn {
  background: none;
  border: none;
  color: #999;
  cursor: pointer;
  font-size: 14px;
  padding: 4px;
  border-radius: 4px;
}
.remove-btn:hover {
  background: #f0f0f0;
  color: #d32f2f;
}

.card-body {
  padding: 16px;
  font-size: 13px;
  color: #555;
  flex: 1;
}

.empty-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  text-align: center;
  color: #666;
}
&lt;/style&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { PPDraggableGrid } from '@phanna/ui-framework';

const gridColumns = ref(3);

const availableItems = ref([
  { id: 'stat-1', name: 'Revenue', icon: '💰' },
  { id: 'stat-2', name: 'Users', icon: '👥' },
  { id: 'chart-1', name: 'Analytics', icon: '📈' },
  { id: 'list-1', name: 'Recent Tasks', icon: '📋' },
  { id: 'alert-1', name: 'System Status', icon: '⚠️' }
]);

const gridItems = ref([
  { id: 'initial-1', name: 'Welcome Panel', icon: '👋' }
]);

const onExternalDragStart = (e: DragEvent, item: any) => {
  if (e.dataTransfer) {
    e.dataTransfer.effectAllowed = 'copy';
    // Stringify the item and set it as JSON payload
    // We add a random suffix to ID so we can drop the same item multiple times
    const dropItem = { ...item, id: `${item.id}-${Math.random().toString(36).substr(2, 9)}` };
    e.dataTransfer.setData('application/json', JSON.stringify(dropItem));
  }
};

const onDropExternal = ({ item, index }: { item: any, index: number }) => {
  console.log(`External item ${item.name} dropped at index ${index}`);
};

const removeItem = (index: number) => {
  gridItems.value.splice(index, 1);
};
</script>

<style scoped>
.draggable-demo-layout {
  display: flex;
  gap: 24px;
  align-items: flex-start;
}

@media (max-width: 768px) {
  .draggable-demo-layout {
    flex-direction: column;
  }
}

.external-source {
  flex: 0 0 250px;
  background: #f8f9fa;
  border-radius: 8px;
  padding: 16px;
  border: 1px solid #e0e0e0;
}

.grid-destination {
  flex: 1;
  background: white;
  border-radius: 8px;
  padding: 16px;
  border: 1px solid #e0e0e0;
}

.helper-text {
  font-size: 13px;
  color: #666;
  margin-bottom: 16px;
}

.external-items-list {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.external-item {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 12px;
  background: white;
  border: 1px solid #ddd;
  border-radius: 6px;
  cursor: grab;
  box-shadow: 0 1px 3px rgba(0,0,0,0.05);
}
.external-item:active {
  cursor: grabbing;
}

.item-icon {
  font-size: 20px;
}
.item-name {
  font-weight: 500;
  font-size: 14px;
}

.grid-controls {
  margin-bottom: 16px;
}

.grid-card {
  background: white;
  border: 1px solid #e0e0e0;
  border-radius: 8px;
  height: 100%;
  display: flex;
  flex-direction: column;
  box-shadow: 0 2px 8px rgba(0,0,0,0.04);
}

.card-header {
  display: flex;
  align-items: center;
  padding: 12px;
  border-bottom: 1px solid #f0f0f0;
  background: #fafafa;
  border-radius: 8px 8px 0 0;
}

.card-icon {
  margin-right: 8px;
}

.card-title {
  font-weight: 600;
  flex: 1;
}

.remove-btn {
  background: none;
  border: none;
  color: #999;
  cursor: pointer;
  font-size: 14px;
  padding: 4px;
  border-radius: 4px;
}
.remove-btn:hover {
  background: #f0f0f0;
  color: #d32f2f;
}

.card-body {
  padding: 16px;
  font-size: 13px;
  color: #555;
  flex: 1;
}

.empty-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  text-align: center;
  color: #666;
}
</style>
