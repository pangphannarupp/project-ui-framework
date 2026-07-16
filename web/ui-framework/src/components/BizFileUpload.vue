<template>
  <div class="biz-file-upload">
    <div
      class="upload-dropzone"
      :class="{ 'is-dragover': isDragover, 'is-disabled': disabled }"
      @dragover.prevent="onDragOver"
      @dragleave.prevent="onDragLeave"
      @drop.prevent="onDrop"
      @click="triggerFileInput"
    >
      <input
        ref="fileInput"
        type="file"
        class="hidden-input"
        :multiple="multiple"
        :accept="accept"
        :disabled="disabled"
        @change="onFileSelected"
      />
      <div class="dropzone-content">
        <svg class="upload-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path>
          <polyline points="17 8 12 3 7 8"></polyline>
          <line x1="12" y1="3" x2="12" y2="15"></line>
        </svg>
        <div class="upload-text">
          <span class="highlight">Click to upload</span> or drag and drop
        </div>
        <div class="upload-hint" v-if="accept || maxSize">
          <span v-if="accept">{{ accept.replace(/,/g, ', ') }}</span>
          <span v-if="accept && maxSize"> (</span>
          <span v-if="maxSize">Max: {{ formatBytes(maxSize) }}</span>
          <span v-if="accept && maxSize">)</span>
        </div>
      </div>
    </div>

    <div v-if="files && files.length > 0" class="file-list">
      <div
        v-for="file in files"
        :key="file.id"
        class="file-item"
        :class="[`is-${file.status}`]"
      >
        <div class="file-icon">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M13 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V9z"></path>
            <polyline points="13 2 13 9 20 9"></polyline>
          </svg>
        </div>
        
        <div class="file-details">
          <div class="file-header">
            <span class="file-name" :title="file.name">{{ file.name }}</span>
            <span class="file-size" v-if="file.status !== 'uploading'">{{ formatBytes(file.size) }}</span>
            <span class="file-percentage" v-else>{{ Math.round(file.progress) }}%</span>
          </div>
          
          <div class="file-progress-container" v-if="file.status === 'uploading'">
            <div class="file-progress-bar" :style="{ width: file.progress + '%' }"></div>
          </div>
          
          <div class="file-error" v-if="file.status === 'error'">
            {{ file.errorMessage || 'Upload failed' }}
          </div>
        </div>

        <div class="file-actions">
          <button v-if="file.status === 'error'" class="action-btn retry-btn" @click.stop="$emit('retry', file.id)" title="Retry">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <polyline points="23 4 23 10 17 10"></polyline>
              <polyline points="1 20 1 14 7 14"></polyline>
              <path d="M3.51 9a9 9 0 0 1 14.85-3.36L23 10M1 14l4.64 4.36A9 9 0 0 0 20.49 15"></path>
            </svg>
          </button>
          
          <span v-if="file.status === 'success'" class="status-icon success">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path>
              <polyline points="22 4 12 14.01 9 11.01"></polyline>
            </svg>
          </span>

          <button class="action-btn remove-btn" @click.stop="$emit('remove', file.id)" title="Remove">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <line x1="18" y1="6" x2="6" y2="18"></line>
              <line x1="6" y1="6" x2="18" y2="18"></line>
            </svg>
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';

export interface BizFileItem {
  id: string | number;
  name: string;
  size: number;
  progress: number;
  status: 'pending' | 'uploading' | 'success' | 'error';
  errorMessage?: string;
  file?: File;
}

const props = withDefaults(defineProps<{
  multiple?: boolean;
  accept?: string;
  maxSize?: number;
  disabled?: boolean;
  files?: BizFileItem[];
}>(), {
  multiple: false,
  accept: '',
  maxSize: 0,
  disabled: false,
  files: () => []
});

const emit = defineEmits<{
  (e: 'select', files: File[]): void;
  (e: 'remove', id: string | number): void;
  (e: 'retry', id: string | number): void;
}>();

const fileInput = ref<HTMLInputElement | null>(null);
const isDragover = ref(false);

const triggerFileInput = () => {
  if (!props.disabled && fileInput.value) {
    fileInput.value.click();
  }
};

const onDragOver = (_e: DragEvent) => {
  if (!props.disabled) {
    isDragover.value = true;
  }
};

const onDragLeave = () => {
  isDragover.value = false;
};

const onDrop = (e: DragEvent) => {
  isDragover.value = false;
  if (props.disabled) return;
  
  const droppedFiles = e.dataTransfer?.files;
  if (droppedFiles && droppedFiles.length > 0) {
    handleFiles(droppedFiles);
  }
};

const onFileSelected = (e: Event) => {
  const target = e.target as HTMLInputElement;
  if (target.files && target.files.length > 0) {
    handleFiles(target.files);
  }
  if (fileInput.value) {
    fileInput.value.value = '';
  }
};

const handleFiles = (fileList: FileList | File[]) => {
  let validFiles: File[] = [];
  const filesArray = Array.from(fileList);
  
  if (!props.multiple) {
    const f = filesArray[0];
    if (validateFile(f)) {
      validFiles.push(f);
    }
  } else {
    validFiles = filesArray.filter(validateFile);
  }
  
  if (validFiles.length > 0) {
    emit('select', validFiles);
  }
};

const validateFile = (file: File): boolean => {
  if (props.maxSize && file.size > props.maxSize) {
    return false;
  }
  
  if (props.accept) {
    const acceptedTypes = props.accept.split(',').map(t => t.trim().toLowerCase());
    const fileType = file.type.toLowerCase();
    const fileName = file.name.toLowerCase();
    
    const isAccepted = acceptedTypes.some(type => {
      if (type.startsWith('.')) {
        return fileName.endsWith(type);
      } else if (type.endsWith('/*')) {
        const baseType = type.replace('/*', '');
        return fileType.startsWith(baseType);
      } else {
        return fileType === type;
      }
    });
    
    if (!isAccepted) return false;
  }
  
  return true;
};

const formatBytes = (bytes: number, decimals = 2) => {
  if (!+bytes) return '0 Bytes';
  const k = 1024;
  const dm = decimals < 0 ? 0 : decimals;
  const sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB'];
  const i = Math.floor(Math.log(bytes) / Math.log(k));
  return `${parseFloat((bytes / Math.pow(k, i)).toFixed(dm))} ${sizes[i]}`;
};
</script>

<style scoped>
.biz-file-upload {
  display: flex;
  flex-direction: column;
  gap: 16px;
  width: 100%;
}

.upload-dropzone {
  border: 2px dashed #cccccc;
  border-radius: 12px;
  padding: 32px 16px;
  text-align: center;
  background-color: #fafafa;
  cursor: pointer;
  transition: all 0.2s ease;
  position: relative;
}

.upload-dropzone:hover:not(.is-disabled) {
  border-color: var(--biz-primary-variant, #1a2a5e);
  background-color: #f0f4ff;
}

.upload-dropzone.is-dragover {
  border-color: var(--biz-primary-light, #3880ff);
  background-color: #f0f4ff;
}

.upload-dropzone.is-disabled {
  cursor: not-allowed;
  opacity: 0.6;
}

.hidden-input {
  display: none;
}

.dropzone-content {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 12px;
}

.upload-icon {
  width: 32px;
  height: 32px;
  color: #999999;
}

.upload-dropzone:hover:not(.is-disabled) .upload-icon,
.upload-dropzone.is-dragover .upload-icon {
  color: var(--biz-primary-variant, #1a2a5e);
}

.upload-text {
  font-size: 15px;
  color: #666666;
}

.upload-text .highlight {
  color: var(--biz-primary-variant, #1a2a5e);
  font-weight: 600;
}

.upload-hint {
  font-size: 13px;
  color: #999999;
}

.file-list {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.file-item {
  display: flex;
  align-items: center;
  padding: 12px 16px;
  border-radius: 8px;
  border: 1px solid #eeeeee;
  background-color: #ffffff;
  gap: 16px;
  transition: border-color 0.2s ease;
}

.file-item.is-error {
  border-color: #ffebee;
  background-color: #fff9f9;
}

.file-item.is-success {
  border-color: #e8f5e9;
}

.file-icon {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 40px;
  height: 40px;
  border-radius: 8px;
  background-color: #f4f5f8;
  color: #666666;
  flex-shrink: 0;
}

.file-icon svg {
  width: 20px;
  height: 20px;
}

.file-details {
  flex: 1;
  min-width: 0;
  display: flex;
  flex-direction: column;
  justify-content: center;
  gap: 4px;
}

.file-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: 12px;
}

.file-name {
  font-size: 14px;
  font-weight: 500;
  color: #333333;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.file-size, .file-percentage {
  font-size: 12px;
  color: #999999;
  flex-shrink: 0;
}

.file-progress-container {
  height: 4px;
  background-color: #eeeeee;
  border-radius: 2px;
  overflow: hidden;
  width: 100%;
}

.file-progress-bar {
  height: 100%;
  background-color: var(--biz-primary-light, #3880ff);
  border-radius: 2px;
  transition: width 0.3s ease;
}

.file-error {
  font-size: 12px;
  color: #d32f2f;
}

.file-actions {
  display: flex;
  align-items: center;
  gap: 8px;
  flex-shrink: 0;
}

.action-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 32px;
  height: 32px;
  border-radius: 50%;
  border: none;
  background-color: transparent;
  color: #999999;
  cursor: pointer;
  transition: all 0.2s ease;
}

.action-btn svg {
  width: 18px;
  height: 18px;
}

.action-btn:hover {
  background-color: #f4f5f8;
  color: #333333;
}

.remove-btn:hover {
  color: #d32f2f;
  background-color: #ffebee;
}

.status-icon {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 32px;
  height: 32px;
}

.status-icon svg {
  width: 20px;
  height: 20px;
}

.status-icon.success {
  color: #388e3c;
}
</style>
