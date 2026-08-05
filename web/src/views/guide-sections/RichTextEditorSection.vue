<template>
  <div class="component-section">
    <h2>Rich Text Editor</h2>
    <p>A native, lightweight WYSIWYG editor for standard text formatting and content creation without heavy dependencies.</p>

    <div class="demo-box">
      <h3>Basic Editor</h3>
      <p class="helper-text">Supports v-model binding directly to HTML output.</p>
      
      <div class="demo-content">
        <PPRichTextEditor 
          v-model="editorContent" 
          placeholder="Start writing your amazing story..."
          minHeight="250px"
        />
      </div>

      <div class="output-preview">
        <h4>Bound HTML Output:</h4>
        <pre v-pre><code>{{ editorContent }}</code></pre>
      </div>

      <pre class="code-block" v-pre><code>&lt;PPRichTextEditor 
  v-model="editorContent" 
  placeholder="Start writing your amazing story..."
  minHeight="250px"
/&gt;</code></pre>
    </div>

    <div class="demo-box">
      <h3>Custom Toolbar Buttons</h3>
      <p class="helper-text">You can add your own toolbar buttons using the <code>customButtons</code> prop to insert custom HTML or trigger custom actions.</p>
      
      <div class="demo-content">
        <PPRichTextEditor 
          v-model="customEditorContent" 
          placeholder="Try the custom buttons in the toolbar..."
          minHeight="150px"
          :customButtons="myCustomButtons"
        />
      </div>

      <pre class="code-block" v-pre><code>&lt;PPRichTextEditor 
  v-model="content"
  :customButtons="[
    { icon: '⭐', title: 'Insert Star', html: '&lt;span style=\'color: gold; font-size: 24px;\'&gt;★&lt;/span&gt;' },
    { icon: '📦', title: 'Insert Card', action: ({ insertHTML }) => {
        insertHTML('&lt;div style=\'border: 1px solid #ccc; padding: 16px; border-radius: 8px; background: #f9f9f9;\'&gt;Custom Component&lt;/div&gt;')
    }}
  ]"
/&gt;</code></pre>
    </div>
  
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
    &lt;h2&gt;Rich Text Editor&lt;/h2&gt;
    &lt;p&gt;A native, lightweight WYSIWYG editor for standard text formatting and content creation without heavy dependencies.&lt;/p&gt;

    &lt;div class="demo-box"&gt;
      &lt;h3&gt;Basic Editor&lt;/h3&gt;
      &lt;p class="helper-text"&gt;Supports v-model binding directly to HTML output.&lt;/p&gt;
      
      &lt;div class="demo-content"&gt;
        &lt;PPRichTextEditor 
          v-model="editorContent" 
          placeholder="Start writing your amazing story..."
          minHeight="250px"
        /&gt;
      &lt;/div&gt;

      &lt;div class="output-preview"&gt;
        &lt;h4&gt;Bound HTML Output:&lt;/h4&gt;
        &lt;pre&gt;&lt;code&gt;{{ editorContent }}&lt;/code&gt;&lt;/pre&gt;
      &lt;/div&gt;

      &lt;pre class="code-block" v-pre&gt;&lt;code&gt;&amp;lt;PPRichTextEditor 
  v-model="editorContent" 
  placeholder="Start writing your amazing story..."
  minHeight="250px"
/&amp;gt;&lt;/code&gt;&lt;/pre&gt;
    &lt;/div&gt;

    &lt;div class="demo-box"&gt;
      &lt;h3&gt;Custom Toolbar Buttons&lt;/h3&gt;
      &lt;p class="helper-text"&gt;You can add your own toolbar buttons using the &lt;code&gt;customButtons&lt;/code&gt; prop to insert custom HTML or trigger custom actions.&lt;/p&gt;
      
      &lt;div class="demo-content"&gt;
        &lt;PPRichTextEditor 
          v-model="customEditorContent" 
          placeholder="Try the custom buttons in the toolbar..."
          minHeight="150px"
          :customButtons="myCustomButtons"
        /&gt;
      &lt;/div&gt;

      &lt;pre class="code-block" v-pre&gt;&lt;code&gt;&amp;lt;PPRichTextEditor 
  v-model="content"
  :customButtons="[
    { icon: '⭐', title: 'Insert Star', html: '&amp;lt;span style=\'color: gold; font-size: 24px;\'&amp;gt;★&amp;lt;/span&amp;gt;' },
    { icon: '📦', title: 'Insert Card', action: ({ insertHTML }) =&gt; {
        insertHTML('&amp;lt;div style=\'border: 1px solid #ccc; padding: 16px; border-radius: 8px; background: #f9f9f9;\'&amp;gt;Custom Component&amp;lt;/div&amp;gt;')
    }}
  ]"
/&amp;gt;&lt;/code&gt;&lt;/pre&gt;
    &lt;/div&gt;
  
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
import { PPRichTextEditor } from '@phanna/ui-framework';

const editorContent = ref('&lt;h2&gt;Welcome to the Editor&lt;/h2&gt;&lt;p&gt;This is a &lt;b&gt;lightweight&lt;/b&gt; editor built specifically for standard use cases!&lt;/p&gt;&lt;ul&gt;&lt;li&gt;Bold and Italic&lt;/li&gt;&lt;li&gt;Headings&lt;/li&gt;&lt;li&gt;Lists (like this one)&lt;/li&gt;&lt;li&gt;And Links&lt;/li&gt;&lt;/ul&gt;');

const customEditorContent = ref('&lt;p&gt;Click the Star or Box icon in the toolbar!&lt;/p&gt;');

const myCustomButtons = ref([
  {
    icon: '⭐',
    title: 'Insert Gold Star',
    html: '&lt;span style="color: gold; font-size: 24px;"&gt;★&lt;/span&gt;'
  },
  {
    icon: '📦',
    title: 'Insert Alert Box',
    action: ({ insertHTML }: { insertHTML: (html: string) =&gt; void }) =&gt; {
      insertHTML('&lt;div style="border: 1px solid #ff9800; padding: 16px; border-radius: 8px; background: #fff3e0; color: #e65100; margin: 16px 0;"&gt;&lt;strong&gt;Alert:&lt;/strong&gt; This is a custom HTML block inserted via API!&lt;/div&gt;');
    }
  }
]);
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
&lt;/style&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { PPRichTextEditor } from '@phanna/ui-framework';

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
