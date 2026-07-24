<template>
  <div class="component-section">
    <h2>Tree</h2>
    <p>A component for displaying hierarchical data in a tree structure.</p>

    <div class="demo-box">
      <h3>Standard Tree</h3>
      <div class="demo-content">
        <PPTree :data="treeData" @node-click="handleNodeClick" variant="standard" />
      </div>
      <pre class="code-block"><code>&lt;PPTree :data="treeData" variant="standard" /&gt;</code></pre>
    </div>

    <div class="demo-box">
      <h3>Boxed Tree</h3>
      <div class="demo-content">
        <PPTree :data="treeData" @node-click="handleNodeClick" variant="boxed" />
      </div>
      <pre class="code-block"><code>&lt;PPTree :data="treeData" variant="boxed" /&gt;</code></pre>
    </div>

    <div class="demo-box">
      <h3>Lined Tree</h3>
      <div class="demo-content" style="background: white;">
        <PPTree :data="treeData" @node-click="handleNodeClick" variant="lined" />
      </div>
      <pre class="code-block"><code>&lt;PPTree :data="treeData" variant="lined" /&gt;</code></pre>
    </div>

    <div class="demo-box">
      <h3>Zebra Tree</h3>
      <div class="demo-content" style="padding: 0; overflow: hidden; background: white; border: 1px solid #e0e0e0;">
        <PPTree :data="treeData" @node-click="handleNodeClick" variant="zebra" />
      </div>
      <pre class="code-block"><code>&lt;PPTree :data="treeData" variant="zebra" /&gt;</code></pre>

      <div v-if="clickedNode" style="margin-top: 16px; font-size: 14px; color: #666;">
        Selected: {{ clickedNode }}
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { PPTree } from '@phanna/ui-framework';
import { folderOutline, documentOutline } from 'ionicons/icons';

const clickedNode = ref('');

const treeData = ref([
  {
    id: 1,
    label: 'Level 1 - 1',
    icon: folderOutline,
    children: [
      {
        id: 4,
        label: 'Level 2 - 1-1',
        icon: documentOutline
      },
      {
        id: 5,
        label: 'Level 2 - 1-2',
        icon: folderOutline,
        children: [
          {
            id: 9,
            label: 'Level 3 - 1-2-1',
            icon: documentOutline
          },
          {
            id: 10,
            label: 'Level 3 - 1-2-2',
            icon: documentOutline
          }
        ]
      }
    ]
  },
  {
    id: 2,
    label: 'Level 1 - 2',
    icon: folderOutline,
    children: [
      {
        id: 6,
        label: 'Level 2 - 2-1',
        icon: documentOutline
      },
      {
        id: 7,
        label: 'Level 2 - 2-2',
        icon: documentOutline
      }
    ]
  },
  {
    id: 3,
    label: 'Level 1 - 3',
    icon: documentOutline
  }
]);

const handleNodeClick = (node: any) => {
  clickedNode.value = node.label;
};
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
</style>
