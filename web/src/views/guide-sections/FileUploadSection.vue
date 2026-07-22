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
      <pre class="code-block"><code>&lt;template&gt;
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
      <pre class="code-block"><code>&lt;template&gt;
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

  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { PPFileUpload, PPFileItem } from '@phanna/ui-framework';

const files1 = ref<File[]>([]);
const uploadFiles = ref<PPFileItem[]>([]);

const onFileChange = (files: File[]) => {
  files1.value = files;
};

const onFileSelect = (files: File[]) => {
  // Convert standard files to PPFileItems
  const newItems: PPFileItem[] = files.map(f => ({
    id: Date.now() + Math.random().toString(36).substr(2, 9),
    name: f.name,
    size: f.size,
    progress: 0,
    status: 'uploading',
    file: f
  }));
  
  uploadFiles.value = [...uploadFiles.value, ...newItems];
  
  // Simulate upload for each new file
  newItems.forEach(item => simulateUpload(item.id));
};

const onFileRemove = (id: string | number) => {
  uploadFiles.value = uploadFiles.value.filter(f => f.id !== id);
};

const onFileRetry = (id: string | number) => {
  const item = uploadFiles.value.find(f => f.id === id);
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
    const item = uploadFiles.value.find(f => f.id === id);
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
