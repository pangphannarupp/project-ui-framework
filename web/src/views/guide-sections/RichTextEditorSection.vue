<template>
  <div class="component-section">
    <h2>Rich Text Editor</h2>
    <p>A native, lightweight WYSIWYG editor for standard text formatting and content creation without heavy dependencies.</p>

    <div class="demo-box">
      <h3>Basic Editor</h3>
      <p class="helper-text">Supports v-model binding directly to HTML output.</p>
      
      <div class="demo-content">
        <BizRichTextEditor 
          v-model="editorContent" 
          placeholder="Start writing your amazing story..."
          minHeight="250px"
        />
      </div>

      <div class="output-preview">
        <h4>Bound HTML Output:</h4>
        <pre><code>{{ editorContent }}</code></pre>
      </div>

      <pre class="code-block" v-pre><code>&lt;BizRichTextEditor 
  v-model="editorContent" 
  placeholder="Start writing your amazing story..."
  minHeight="250px"
/&gt;</code></pre>
    </div>

    <div class="demo-box">
      <h3>Custom Toolbar Buttons</h3>
      <p class="helper-text">You can add your own toolbar buttons using the <code>customButtons</code> prop to insert custom HTML or trigger custom actions.</p>
      
      <div class="demo-content">
        <BizRichTextEditor 
          v-model="customEditorContent" 
          placeholder="Try the custom buttons in the toolbar..."
          minHeight="150px"
          :customButtons="myCustomButtons"
        />
      </div>

      <pre class="code-block" v-pre><code>&lt;BizRichTextEditor 
  v-model="content"
  :customButtons="[
    { icon: '⭐', title: 'Insert Star', html: '&lt;span style=\'color: gold; font-size: 24px;\'&gt;★&lt;/span&gt;' },
    { icon: '📦', title: 'Insert Card', action: ({ insertHTML }) => {
        insertHTML('&lt;div style=\'border: 1px solid #ccc; padding: 16px; border-radius: 8px; background: #f9f9f9;\'&gt;Custom Component&lt;/div&gt;')
    }}
  ]"
/&gt;</code></pre>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { BizRichTextEditor } from '@phanna/ui-framework';

const editorContent = ref('<h2>Welcome to the Editor</h2><p>This is a <b>lightweight</b> editor built specifically for standard use cases!</p><ul><li>Bold and Italic</li><li>Headings</li><li>Lists (like this one)</li><li>And Links</li></ul>');

const customEditorContent = ref('<p>Click the Star or Box icon in the toolbar!</p>');

const myCustomButtons = ref([
  {
    icon: '⭐',
    title: 'Insert Gold Star',
    html: '<span style="color: gold; font-size: 24px;">★</span>'
  },
  {
    icon: '📦',
    title: 'Insert Alert Box',
    action: ({ insertHTML }: { insertHTML: (html: string) => void }) => {
      insertHTML('<div style="border: 1px solid #ff9800; padding: 16px; border-radius: 8px; background: #fff3e0; color: #e65100; margin: 16px 0;"><strong>Alert:</strong> This is a custom HTML block inserted via API!</div>');
    }
  }
]);
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
}
.helper-text {
  font-size: 13px;
  color: #666;
  margin-bottom: 16px;
}
.code-block {
  background: #282c34;
  color: #abb2bf;
  padding: 16px;
  border-radius: 4px;
  overflow-x: auto;
  font-size: 14px;
  line-height: 1.5;
  margin-top: 24px;
}

.output-preview {
  margin-top: 24px;
  padding: 16px;
  background: #f5f7fa;
  border-left: 4px solid #003399;
  border-radius: 4px;
}

.output-preview h4 {
  margin-top: 0;
  margin-bottom: 12px;
  font-size: 14px;
  color: #333;
}

.output-preview pre {
  margin: 0;
  white-space: pre-wrap;
  word-wrap: break-word;
  font-family: monospace;
  font-size: 13px;
  color: #d63384;
}
</style>
