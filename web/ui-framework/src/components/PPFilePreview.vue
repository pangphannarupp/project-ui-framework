<template>
  <div v-if="modelValue" class="pp-file-preview-overlay" @click.self="close">
    <div class="pp-file-preview-content">
      <div class="preview-header">
        <h3 class="preview-title">{{ file?.name || 'File Preview' }}</h3>
        <button class="close-btn" @click="close">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>
        </button>
      </div>
      
      <div class="preview-body" v-if="fileUrl">
        <!-- Image Preview -->
        <template v-if="isImage">
          <PPImagePreview :src="fileUrl" />
        </template>
        
        <!-- PDF Preview -->
        <template v-else-if="isPdf">
          <PPPdfViewer :src="fileUrl" :sidebarPosition="sidebarPosition" />
        </template>
        
        <!-- Unsupported File -->
        <template v-else>
          <div class="unsupported-message">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="unsupported-icon"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/><line x1="12" y1="18" x2="12" y2="12"/><line x1="9" y1="15" x2="15" y2="15"/></svg>
            <p>Preview not available for this file type.</p>
          </div>
        </template>
      </div>
      <div class="preview-body loading-state" v-else>
        <p>Loading preview...</p>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, watch, onUnmounted } from 'vue';
import PPImagePreview from './PPImagePreview.vue';
import PPPdfViewer from './PPPdfViewer.vue';

const props = defineProps({
  modelValue: { type: Boolean, default: false },
  file: { type: Object, default: null }, // Can be a File object or an object { name, url, type }
  sidebarPosition: { type: String, default: 'left' }
});

const emit = defineEmits(['update:modelValue', 'crop']);

const fileUrl = ref('');

const isImage = computed(() => {
  if (!props.file) return false;
  if (props.file instanceof File) return props.file.type?.startsWith('image/');
  if (props.file.file instanceof File) return props.file.file.type?.startsWith('image/');
  if (props.file.type) return props.file.type.startsWith('image/');
  return false;
});

const isPdf = computed(() => {
  if (!props.file) return false;
  if (props.file instanceof File) return props.file.type === 'application/pdf';
  if (props.file.file instanceof File) return props.file.file.type === 'application/pdf';
  if (props.file.type) return props.file.type === 'application/pdf';
  return false;
});

const generateUrl = () => {
  if (fileUrl.value && fileUrl.value.startsWith('blob:')) {
    URL.revokeObjectURL(fileUrl.value);
  }
  fileUrl.value = '';
  
  if (props.file) {
    if (props.file instanceof File) {
      fileUrl.value = URL.createObjectURL(props.file);
    } else if (props.file.url) {
      fileUrl.value = props.file.url;
    } else if (props.file.file instanceof File) {
      // In case we receive the PPFileUpload custom object
      fileUrl.value = URL.createObjectURL(props.file.file);
    }
  }
};

watch(() => props.modelValue, (isOpen) => {
  if (isOpen) {
    generateUrl();
    document.body.style.overflow = 'hidden';
  } else {
    document.body.style.overflow = '';
  }
});

watch(() => props.file, () => {
  if (props.modelValue) {
    generateUrl();
  }
});

onUnmounted(() => {
  if (fileUrl.value && fileUrl.value.startsWith('blob:')) {
    URL.revokeObjectURL(fileUrl.value);
  }
  document.body.style.overflow = '';
});

const close = () => {
  emit('update:modelValue', false);
};
</script>

<style scoped>
.pp-file-preview-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.7);
  backdrop-filter: blur(4px);
  z-index: 9999;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 24px;
}

.pp-file-preview-content {
  background: #fff;
  border-radius: 12px;
  width: 100%;
  max-width: 800px;
  max-height: 90vh;
  display: flex;
  flex-direction: column;
  overflow: hidden;
  box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
}

.preview-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 16px 20px;
  border-bottom: 1px solid #eee;
  background: #fafafa;
}

.preview-title {
  margin: 0;
  font-size: 16px;
  font-weight: 600;
  color: #333;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  max-width: 80%;
}

.close-btn {
  background: none;
  border: none;
  cursor: pointer;
  color: #666;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 4px;
  border-radius: 50%;
  transition: 0.2s;
}

.close-btn:hover {
  background: #eee;
  color: #000;
}

.close-btn svg {
  width: 24px;
  height: 24px;
}

.preview-body {
  flex: 1;
  overflow: auto;
  padding: 20px;
  background: #f5f5f5;
  display: flex;
  align-items: center;
  justify-content: center;
  min-height: 400px;
}

.pdf-viewer {
  width: 100%;
  height: 600px;
  border-radius: 8px;
  background: #fff;
}

.unsupported-message, .loading-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 12px;
  color: #888;
}

.unsupported-icon {
  width: 48px;
  height: 48px;
  stroke: #ccc;
}
</style>
