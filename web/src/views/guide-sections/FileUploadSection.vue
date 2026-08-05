<template>
  <div class="guide-section">
    <h2>File Upload (Dropzone)</h2>
    <p>A comprehensive drag-and-drop file upload area that shows upload progress, file previews, and handles multiple files elegantly.</p>

    <!-- Basic Upload -->
    <h3>Basic Usage</h3>
    <p>A simple file upload component allowing users to click or drag-and-drop a file.</p>
    <div class="demo-box">
      <PPFileUpload
        v-model="files1"
        @change="onFileChange"
      />
      <div class="state-preview">
        Files selected: {{ files1.length }}
      </div>
    </div>
    
    <div class="usage-section">
      <h4>Usage</h4>
      <pre class="code-block" v-pre><code>&lt;template&gt;
  &lt;PPFileUpload
    v-model="files"
    @change="onFileChange"
  /&gt;
&lt;/template&gt;

&lt;script setup lang="ts"&gt;
import { ref } from 'vue';
import { PPFileUpload } from '@phanna/ui-framework';

const files = ref&lt;File[]&gt;([]);

const onFileChange = (newFiles: File[]) =&gt; {
  console.log('Selected files:', newFiles);
};
&lt;/script&gt;</code></pre>
    </div>

    <h3>Upload with Progress Simulation</h3>
    <p>A complete implementation handling PPFileItem array to simulate an upload process.</p>
    <div class="demo-box">
      <PPFileUpload
        :files="uploadFiles"
        multiple
        accept="image/png, image/jpeg, application/pdf"
        :max-size="5 * 1024 * 1024"
        @select="onFileSelect"
        @remove="onFileRemove"
        @retry="onFileRetry"
      />
    </div>

    <div class="usage-section">
      <h4>Usage</h4>
      <pre class="code-block" v-pre><code>&lt;template&gt;
  &lt;PPFileUpload
    :files="uploadFiles"
    multiple
    accept="image/png, image/jpeg, application/pdf"
    :max-size="5 * 1024 * 1024"
    @select="onFileSelect"
    @remove="onFileRemove"
    @retry="onFileRetry"
  /&gt;
&lt;/template&gt;

&lt;script setup lang="ts"&gt;
import { ref } from 'vue';
import { PPFileUpload, PPFileItem } from '@phanna/ui-framework';

const uploadFiles = ref&lt;PPFileItem[]&gt;([]);

const onFileSelect = (files: File[]) =&gt; {
  const newItems = files.map(f =&gt; ({
    id: Date.now() + Math.random().toString(),
    name: f.name,
    size: f.size,
    progress: 0,
    status: 'uploading',
    file: f
  }));
  
  uploadFiles.value.push(...newItems);
  
  // Example: simulate upload progress
  newItems.forEach(item =&gt; {
    let progress = 0;
    const interval = setInterval(() =&gt; {
      progress += 10;
      const fileRef = uploadFiles.value.find(f =&gt; f.id === item.id);
      if (fileRef) {
        fileRef.progress = progress;
        if (progress &gt;= 100) {
          fileRef.status = 'success';
          clearInterval(interval);
        }
      }
    }, 200);
  });
};

const onFileRemove = (id: string | number) =&gt; {
  uploadFiles.value = uploadFiles.value.filter(f =&gt; f.id !== id);
};

const onFileRetry = (id: string | number) =&gt; {
  // Reset and restart upload logic
};
&lt;/script&gt;</code></pre>
    </div>

  
        <div class="variant-group">
          <h3>Customizing CSS</h3>
          <p class="custom-guide">You can override the component's appearance globally via CSS variables or by targeting its specific classes.</p>
          <pre class="code-block" v-pre><code>/* Override globally */
:root {
  --pp-primary-light: /* value */;
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
      <pre class="code-block" style="max-height: 500px; overflow-y: auto;" v-pre><code>&lt;template&gt;
  &lt;div class="guide-section"&gt;
    &lt;h2&gt;File Upload (Dropzone)&lt;/h2&gt;
    &lt;p&gt;A comprehensive drag-and-drop file upload area that shows upload progress, file previews, and handles multiple files elegantly.&lt;/p&gt;

    &lt;!-- Basic Upload --&gt;
    &lt;h3&gt;Basic Usage&lt;/h3&gt;
    &lt;p&gt;A simple file upload component allowing users to click or drag-and-drop a file.&lt;/p&gt;
    &lt;div class="demo-box"&gt;
      &lt;PPFileUpload
        v-model="files1"
        @change="onFileChange"
      /&gt;
      &lt;div class="state-preview"&gt;
        Files selected: {{ files1.length }}
      &lt;/div&gt;
    &lt;/div&gt;
    
    &lt;div class="usage-section"&gt;
      &lt;h4&gt;Usage&lt;/h4&gt;
      &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;template&amp;gt;
  &amp;lt;PPFileUpload
    v-model="files"
    @change="onFileChange"
  /&amp;gt;
&amp;lt;/template&amp;gt;

&amp;lt;script setup lang="ts"&amp;gt;
import { ref } from 'vue';
import { PPFileUpload } from '@phanna/ui-framework';

const files = ref&amp;lt;File[]&amp;gt;([]);

const onFileChange = (newFiles: File[]) =&amp;gt; {
  console.log('Selected files:', newFiles);
};
&amp;lt;/script&amp;gt;&lt;/code&gt;&lt;/pre&gt;
    &lt;/div&gt;

    &lt;h3&gt;Upload with Progress Simulation&lt;/h3&gt;
    &lt;p&gt;A complete implementation handling PPFileItem array to simulate an upload process.&lt;/p&gt;
    &lt;div class="demo-box"&gt;
      &lt;PPFileUpload
        :files="uploadFiles"
        multiple
        accept="image/png, image/jpeg, application/pdf"
        :max-size="5 * 1024 * 1024"
        @select="onFileSelect"
        @remove="onFileRemove"
        @retry="onFileRetry"
      /&gt;
    &lt;/div&gt;

    &lt;div class="usage-section"&gt;
      &lt;h4&gt;Usage&lt;/h4&gt;
      &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;template&amp;gt;
  &amp;lt;PPFileUpload
    :files="uploadFiles"
    multiple
    accept="image/png, image/jpeg, application/pdf"
    :max-size="5 * 1024 * 1024"
    @select="onFileSelect"
    @remove="onFileRemove"
    @retry="onFileRetry"
  /&amp;gt;
&amp;lt;/template&amp;gt;

&amp;lt;script setup lang="ts"&amp;gt;
import { ref } from 'vue';
import { PPFileUpload, PPFileItem } from '@phanna/ui-framework';

const uploadFiles = ref&amp;lt;PPFileItem[]&amp;gt;([]);

const onFileSelect = (files: File[]) =&amp;gt; {
  const newItems = files.map(f =&amp;gt; ({
    id: Date.now() + Math.random().toString(),
    name: f.name,
    size: f.size,
    progress: 0,
    status: 'uploading',
    file: f
  }));
  
  uploadFiles.value.push(...newItems);
  
  // Example: simulate upload progress
  newItems.forEach(item =&amp;gt; {
    let progress = 0;
    const interval = setInterval(() =&amp;gt; {
      progress += 10;
      const fileRef = uploadFiles.value.find(f =&amp;gt; f.id === item.id);
      if (fileRef) {
        fileRef.progress = progress;
        if (progress &amp;gt;= 100) {
          fileRef.status = 'success';
          clearInterval(interval);
        }
      }
    }, 200);
  });
};

const onFileRemove = (id: string | number) =&amp;gt; {
  uploadFiles.value = uploadFiles.value.filter(f =&amp;gt; f.id !== id);
};

const onFileRetry = (id: string | number) =&amp;gt; {
  // Reset and restart upload logic
};
&amp;lt;/script&amp;gt;&lt;/code&gt;&lt;/pre&gt;
    &lt;/div&gt;

  
        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Customizing CSS&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;You can override the component's appearance globally via CSS variables or by targeting its specific classes.&lt;/p&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;/* Override globally */
:root {
  --pp-primary-light: /* value */;
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
import { PPFileUpload } from '@phanna/ui-framework';

type PPFileItem = any;

const files1 = ref&lt;File[]&gt;([]);
const uploadFiles = ref&lt;PPFileItem[]&gt;([]);

const onFileChange = (files: File[]) =&gt; {
  files1.value = files;
};

const onFileSelect = (files: File[]) =&gt; {
  // Convert standard files to PPFileItems
  const newItems: PPFileItem[] = files.map((f: any) =&gt; ({
    id: Date.now() + Math.random().toString(36).substring(2, 9),
    name: f.name,
    size: f.size,
    progress: 0,
    status: 'uploading',
    file: f
  }));
  
  uploadFiles.value = [...uploadFiles.value, ...newItems];
  
  // Simulate upload for each new file
  newItems.forEach((item: any) =&gt; simulateUpload(item.id));
};

const onFileRemove = (id: string | number) =&gt; {
  uploadFiles.value = uploadFiles.value.filter((f: any) =&gt; f.id !== id);
};

const onFileRetry = (id: string | number) =&gt; {
  const item = uploadFiles.value.find((f: any) =&gt; f.id === id);
  if (item) {
    item.status = 'uploading';
    item.progress = 0;
    item.errorMessage = undefined;
    simulateUpload(item.id);
  }
};

const simulateUpload = (id: string | number) =&gt; {
  let progress = 0;
  const interval = setInterval(() =&gt; {
    // Look up the item from the reactive array to ensure reactivity
    const item = uploadFiles.value.find((f: any) =&gt; f.id === id);
    if (!item) {
      clearInterval(interval);
      return;
    }
    
    progress += Math.random() * 15 + 5; // Add 5-20% randomly
    
    if (progress &gt;= 100) {
      progress = 100;
      clearInterval(interval);
      
      // Randomly fail sometimes for demonstration
      if (Math.random() &gt; 0.8) {
        item.status = 'error';
        item.errorMessage = 'Network error. Please try again.';
      } else {
        item.status = 'success';
      }
    }
    
    item.progress = progress;
  }, 300);
};
&lt;/script&gt;

&lt;style scoped&gt;
.guide-section {
  display: flex;
  flex-direction: column;
  gap: 24px;
}

h2 {
  margin: 0;
  font-size: 24px;
  color: #111827;
}

h3 {
  margin: 0;
  font-size: 18px;
  color: #374151;
  border-bottom: 1px solid #e5e7eb;
  padding-bottom: 8px;
}

p {
  margin: 0;
  color: #6b7280;
  line-height: 1.5;
}

.demo-box {
  border: 1px solid #e5e7eb;
  border-radius: 8px;
  padding: 24px;
  background: #f9fafb;
}

.state-preview {
  margin-top: 16px;
  padding: 12px;
  background: #f3f4f6;
  border-radius: 6px;
  font-family: monospace;
  font-size: 14px;
  color: #374151;
}

.usage-section {
  margin-top: 24px;
}

.usage-section h4 {
  margin: 0 0 12px 0;
  font-size: 16px;
  color: #4b5563;
}

.code-block {
  background: #1f2937;
  color: #e5e7eb;
  padding: 16px;
  border-radius: 8px;
  overflow-x: auto;
  font-family: 'Fira Code', Consolas, Monaco, 'Andale Mono', 'Ubuntu Mono', monospace;
  font-size: 14px;
  line-height: 1.5;
  margin: 0;
}
&lt;/style&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { PPFileUpload } from '@phanna/ui-framework';

type PPFileItem = any;

const files1 = ref<File[]>([]);
const uploadFiles = ref<PPFileItem[]>([]);

const onFileChange = (files: File[]) => {
  files1.value = files;
};

const onFileSelect = (files: File[]) => {
  // Convert standard files to PPFileItems
  const newItems: PPFileItem[] = files.map((f: any) => ({
    id: Date.now() + Math.random().toString(36).substring(2, 9),
    name: f.name,
    size: f.size,
    progress: 0,
    status: 'uploading',
    file: f
  }));
  
  uploadFiles.value = [...uploadFiles.value, ...newItems];
  
  // Simulate upload for each new file
  newItems.forEach((item: any) => simulateUpload(item.id));
};

const onFileRemove = (id: string | number) => {
  uploadFiles.value = uploadFiles.value.filter((f: any) => f.id !== id);
};

const onFileRetry = (id: string | number) => {
  const item = uploadFiles.value.find((f: any) => f.id === id);
  if (item) {
    item.status = 'uploading';
    item.progress = 0;
    item.errorMessage = undefined;
    simulateUpload(item.id);
  }
};

const simulateUpload = (id: string | number) => {
  let progress = 0;
  const interval = setInterval(() => {
    // Look up the item from the reactive array to ensure reactivity
    const item = uploadFiles.value.find((f: any) => f.id === id);
    if (!item) {
      clearInterval(interval);
      return;
    }
    
    progress += Math.random() * 15 + 5; // Add 5-20% randomly
    
    if (progress >= 100) {
      progress = 100;
      clearInterval(interval);
      
      // Randomly fail sometimes for demonstration
      if (Math.random() > 0.8) {
        item.status = 'error';
        item.errorMessage = 'Network error. Please try again.';
      } else {
        item.status = 'success';
      }
    }
    
    item.progress = progress;
  }, 300);
};
</script>

<style scoped>
.guide-section {
  display: flex;
  flex-direction: column;
  gap: 24px;
}

h2 {
  margin: 0;
  font-size: 24px;
  color: #111827;
}

h3 {
  margin: 0;
  font-size: 18px;
  color: #374151;
  border-bottom: 1px solid #e5e7eb;
  padding-bottom: 8px;
}

p {
  margin: 0;
  color: #6b7280;
  line-height: 1.5;
}

.demo-box {
  border: 1px solid #e5e7eb;
  border-radius: 8px;
  padding: 24px;
  background: #f9fafb;
}

.state-preview {
  margin-top: 16px;
  padding: 12px;
  background: #f3f4f6;
  border-radius: 6px;
  font-family: monospace;
  font-size: 14px;
  color: #374151;
}

.usage-section {
  margin-top: 24px;
}

.usage-section h4 {
  margin: 0 0 12px 0;
  font-size: 16px;
  color: #4b5563;
}

.code-block {
  background: #1f2937;
  color: #e5e7eb;
  padding: 16px;
  border-radius: 8px;
  overflow-x: auto;
  font-family: 'Fira Code', Consolas, Monaco, 'Andale Mono', 'Ubuntu Mono', monospace;
  font-size: 14px;
  line-height: 1.5;
  margin: 0;
}
</style>
