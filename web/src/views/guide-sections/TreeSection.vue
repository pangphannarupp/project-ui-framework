<template>
  <div class="component-section">
    <h2>Tree</h2>
    <p>A component for displaying hierarchical data in a tree structure.</p>

    <div class="demo-box">
      <h3>Standard Tree</h3>
      <div class="demo-content">
        <PPTree :data="treeData" @node-click="handleNodeClick" variant="standard" />
      </div>
      <pre class="code-block" v-pre><code>&lt;PPTree :data="treeData" variant="standard" /&gt;</code></pre>
    </div>

    <div class="demo-box">
      <h3>Boxed Tree</h3>
      <div class="demo-content">
        <PPTree :data="treeData" @node-click="handleNodeClick" variant="boxed" />
      </div>
      <pre class="code-block" v-pre><code>&lt;PPTree :data="treeData" variant="boxed" /&gt;</code></pre>
    </div>

    <div class="demo-box">
      <h3>Lined Tree</h3>
      <div class="demo-content" style="background: white;">
        <PPTree :data="treeData" @node-click="handleNodeClick" variant="lined" />
      </div>
      <pre class="code-block" v-pre><code>&lt;PPTree :data="treeData" variant="lined" /&gt;</code></pre>
    </div>

    <div class="demo-box">
      <h3>Zebra Tree</h3>
      <div class="demo-content" style="padding: 0; overflow: hidden; background: white; border: 1px solid #e0e0e0;">
        <PPTree :data="treeData" @node-click="handleNodeClick" variant="zebra" />
      </div>
      <pre class="code-block" v-pre><code>&lt;PPTree :data="treeData" variant="zebra" /&gt;</code></pre>

      <div v-if="clickedNode" style="margin-top: 16px; font-size: 14px; color: #666;">
        Selected: {{ clickedNode }}
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
    &lt;h2&gt;Tree&lt;/h2&gt;
    &lt;p&gt;A component for displaying hierarchical data in a tree structure.&lt;/p&gt;

    &lt;div class="demo-box"&gt;
      &lt;h3&gt;Standard Tree&lt;/h3&gt;
      &lt;div class="demo-content"&gt;
        &lt;PPTree :data="treeData" @node-click="handleNodeClick" variant="standard" /&gt;
      &lt;/div&gt;
      &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPTree :data="treeData" variant="standard" /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
    &lt;/div&gt;

    &lt;div class="demo-box"&gt;
      &lt;h3&gt;Boxed Tree&lt;/h3&gt;
      &lt;div class="demo-content"&gt;
        &lt;PPTree :data="treeData" @node-click="handleNodeClick" variant="boxed" /&gt;
      &lt;/div&gt;
      &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPTree :data="treeData" variant="boxed" /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
    &lt;/div&gt;

    &lt;div class="demo-box"&gt;
      &lt;h3&gt;Lined Tree&lt;/h3&gt;
      &lt;div class="demo-content" style="background: white;"&gt;
        &lt;PPTree :data="treeData" @node-click="handleNodeClick" variant="lined" /&gt;
      &lt;/div&gt;
      &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPTree :data="treeData" variant="lined" /&amp;gt;&lt;/code&gt;&lt;/pre&gt;
    &lt;/div&gt;

    &lt;div class="demo-box"&gt;
      &lt;h3&gt;Zebra Tree&lt;/h3&gt;
      &lt;div class="demo-content" style="padding: 0; overflow: hidden; background: white; border: 1px solid #e0e0e0;"&gt;
        &lt;PPTree :data="treeData" @node-click="handleNodeClick" variant="zebra" /&gt;
      &lt;/div&gt;
      &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPTree :data="treeData" variant="zebra" /&amp;gt;&lt;/code&gt;&lt;/pre&gt;

      &lt;div v-if="clickedNode" style="margin-top: 16px; font-size: 14px; color: #666;"&gt;
        Selected: {{ clickedNode }}
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

const handleNodeClick = (node: any) =&gt; {
  clickedNode.value = node.label;
};
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
&lt;/style&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
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
