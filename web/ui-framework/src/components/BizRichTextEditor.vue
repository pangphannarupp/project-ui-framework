<template>
  <div class="biz-rte-container" :class="{ 'is-focused': isFocused }">
    <!-- Toolbar -->
    <div class="biz-rte-toolbar">
      <div class="toolbar-group">
        <button class="toolbar-btn" @click="format('bold')" title="Bold" type="button">
          <b>B</b>
        </button>
        <button class="toolbar-btn" @click="format('italic')" title="Italic" type="button">
          <i>I</i>
        </button>
        <button class="toolbar-btn" @click="format('underline')" title="Underline" type="button">
          <u>U</u>
        </button>
        <button class="toolbar-btn" @click="format('strikeThrough')" title="Strikethrough" type="button">
          <s>S</s>
        </button>
      </div>

      <div class="toolbar-divider"></div>

      <div class="toolbar-group">
        <button class="toolbar-btn" @click="formatBlock('H1')" title="Heading 1" type="button">
          <b>H1</b>
        </button>
        <button class="toolbar-btn" @click="formatBlock('H2')" title="Heading 2" type="button">
          <b>H2</b>
        </button>
        <button class="toolbar-btn" @click="formatBlock('H3')" title="Heading 3" type="button">
          <b>H3</b>
        </button>
        <button class="toolbar-btn" @click="formatBlock('P')" title="Paragraph" type="button">
          P
        </button>
        <button class="toolbar-btn" @click="formatBlock('BLOCKQUOTE')" title="Quote" type="button">
          ❞
        </button>
        <button class="toolbar-btn" @click="formatBlock('PRE')" title="Code Block" type="button">
          &lt;/&gt;
        </button>
      </div>

      <div class="toolbar-divider"></div>

      <div class="toolbar-group">
        <button class="toolbar-btn" @click="format('justifyLeft')" title="Align Left" type="button">
          ⫷
        </button>
        <button class="toolbar-btn" @click="format('justifyCenter')" title="Align Center" type="button">
          ≡
        </button>
        <button class="toolbar-btn" @click="format('justifyRight')" title="Align Right" type="button">
          ⫸
        </button>
        <button class="toolbar-btn" @click="format('justifyFull')" title="Justify" type="button">
          ▤
        </button>
      </div>

      <div class="toolbar-divider"></div>

      <div class="toolbar-group">
        <button class="toolbar-btn" @click="format('subscript')" title="Subscript" type="button">
          X₂
        </button>
        <button class="toolbar-btn" @click="format('superscript')" title="Superscript" type="button">
          X²
        </button>
      </div>

      <div class="toolbar-divider"></div>

      <div class="toolbar-group">
        <button class="toolbar-btn" @click="format('outdent')" title="Decrease Indent" type="button">
          ⇤
        </button>
        <button class="toolbar-btn" @click="format('indent')" title="Increase Indent" type="button">
          ⇥
        </button>
      </div>

      <div class="toolbar-divider"></div>

      <div class="toolbar-group">
        <button class="toolbar-btn" @click="format('insertUnorderedList')" title="Bullet List" type="button">
          •
        </button>
        <button class="toolbar-btn" @click="format('insertOrderedList')" title="Number List" type="button">
          1.
        </button>
        <button class="toolbar-btn" @click="format('insertHorizontalRule')" title="Horizontal Line" type="button">
          ―
        </button>
      </div>

      <div class="toolbar-divider"></div>

      <div class="toolbar-group">
        <button class="toolbar-btn" @click="insertLink" title="Insert Link" type="button">
          🔗
        </button>
        <button class="toolbar-btn" @click="insertImage" title="Insert Image" type="button">
          🖼️
        </button>
        <button class="toolbar-btn" @click="format('removeFormat')" title="Clear Formatting" type="button">
          ✕
        </button>
      </div>

      <div class="toolbar-divider"></div>

      <div class="toolbar-group" style="align-items: center; gap: 4px; margin-left: 4px;">
        <label style="font-size: 12px; color: #666; cursor: pointer;" title="Text Color">
          A
          <input type="color" @input="changeColor($event, 'foreColor')" style="width: 20px; height: 20px; padding: 0; border: none; cursor: pointer;">
        </label>
        <label style="font-size: 12px; color: #666; cursor: pointer; margin-left: 8px;" title="Background Color">
          B
          <input type="color" @input="changeColor($event, 'hiliteColor')" value="#ffffff" style="width: 20px; height: 20px; padding: 0; border: none; cursor: pointer;">
        </label>
      </div>

      <!-- Custom Buttons -->
      <template v-if="customButtons && customButtons.length > 0">
        <div class="toolbar-divider"></div>
        <div class="toolbar-group">
          <button 
            v-for="(btn, index) in customButtons" 
            :key="index"
            class="toolbar-btn" 
            @click="executeCustom(btn)" 
            :title="btn.title" 
            type="button"
          >
            <span v-html="btn.icon"></span>
          </button>
        </div>
      </template>

    </div>

    <!-- Editor Area -->
    <div 
      ref="editorRef"
      class="biz-rte-editor" 
      :style="{ minHeight }"
      contenteditable="true"
      @input="onInput"
      @focus="isFocused = true"
      @blur="onBlur"
      :data-placeholder="placeholder"
    ></div>
  </div>
</template>

<script setup lang="ts">
import { ref, watch, onMounted, PropType } from 'vue';

export interface CustomEditorButton {
  icon: string;
  title: string;
  html?: string;
  action?: (context: { insertHTML: (html: string) => void }) => void;
}

const props = defineProps({
  modelValue: {
    type: String,
    default: ''
  },
  placeholder: {
    type: String,
    default: 'Type your content here...'
  },
  minHeight: {
    type: String,
    default: '200px'
  },
  customButtons: {
    type: Array as PropType<CustomEditorButton[]>,
    default: () => []
  }
});

const emit = defineEmits(['update:modelValue']);

const editorRef = ref<HTMLElement | null>(null);
const isFocused = ref(false);
const isTyping = ref(false);

const format = (command: string, value?: string) => {
  document.execCommand(command, false, value);
  updateModel();
  editorRef.value?.focus();
};

const formatBlock = (tag: string) => {
  document.execCommand('formatBlock', false, tag);
  updateModel();
  editorRef.value?.focus();
};

const insertLink = () => {
  const url = prompt('Enter the link URL:');
  if (url) {
    format('createLink', url);
  }
};

const insertImage = () => {
  const url = prompt('Enter image URL:');
  if (url) {
    format('insertImage', url);
  }
};

const changeColor = (event: Event, command: string) => {
  const input = event.target as HTMLInputElement;
  // Use hiliteColor for non-IE, backColor for IE (hiliteColor is standard for execCommand)
  format(command, input.value);
};

const executeCustom = (btn: CustomEditorButton) => {
  if (btn.html) {
    format('insertHTML', btn.html);
  } else if (btn.action) {
    btn.action({
      insertHTML: (html: string) => format('insertHTML', html)
    });
  }
};

const updateModel = () => {
  if (editorRef.value) {
    let html = editorRef.value.innerHTML;
    if (html === '<br>') html = ''; // Clean up empty content
    isTyping.value = true;
    emit('update:modelValue', html);
  }
};

const onInput = () => {
  updateModel();
};

const onBlur = () => {
  isFocused.value = false;
  isTyping.value = false;
};

// Sync external changes to the editor (but don't overwrite if the user is actively typing)
watch(() => props.modelValue, (newVal) => {
  if (editorRef.value && !isTyping.value) {
    if (editorRef.value.innerHTML !== newVal) {
      editorRef.value.innerHTML = newVal || '';
    }
  }
});

onMounted(() => {
  if (editorRef.value && props.modelValue) {
    editorRef.value.innerHTML = props.modelValue;
  }
  // Optional: Ensure paragraphs are used instead of divs for line breaks
  document.execCommand('defaultParagraphSeparator', false, 'p');
});
</script>

<style scoped>
.biz-rte-container {
  border: 1px solid #d1d5db;
  border-radius: 6px;
  background: white;
  overflow: hidden;
  display: flex;
  flex-direction: column;
  transition: border-color 0.2s, box-shadow 0.2s;
}

.biz-rte-container.is-focused {
  border-color: #003399;
  box-shadow: 0 0 0 3px rgba(0, 51, 153, 0.1);
}

.biz-rte-toolbar {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  padding: 8px;
  background: #f9fafb;
  border-bottom: 1px solid #e5e7eb;
  gap: 8px;
}

.toolbar-group {
  display: flex;
  gap: 4px;
}

.toolbar-divider {
  width: 1px;
  height: 20px;
  background: #d1d5db;
  margin: 0 4px;
}

.toolbar-btn {
  background: transparent;
  border: 1px solid transparent;
  border-radius: 4px;
  color: #374151;
  width: 32px;
  height: 32px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  font-size: 14px;
  transition: all 0.2s;
}

.toolbar-btn:hover {
  background: #e5e7eb;
}

.toolbar-btn:active {
  background: #d1d5db;
}

.biz-rte-editor {
  padding: 16px;
  outline: none;
  font-family: inherit;
  font-size: 14px;
  line-height: 1.6;
  color: #1f2937;
  overflow-y: auto;
}

/* Placeholder support */
.biz-rte-editor:empty:before {
  content: attr(data-placeholder);
  color: #9ca3af;
  pointer-events: none;
  display: block; 
}

/* Editor default styles to ensure headings and lists look correct */
.biz-rte-editor :deep(h1) {
  font-size: 2em;
  margin: 0.67em 0;
  font-weight: bold;
}

.biz-rte-editor :deep(h2) {
  font-size: 1.5em;
  margin: 0.83em 0;
  font-weight: bold;
}

.biz-rte-editor :deep(p) {
  margin: 0 0 1em 0;
}

.biz-rte-editor :deep(ul) {
  list-style-type: disc;
  padding-left: 2em;
  margin: 1em 0;
}

.biz-rte-editor :deep(ol) {
  list-style-type: decimal;
  padding-left: 2em;
  margin: 1em 0;
}

.biz-rte-editor :deep(a) {
  color: #003399;
  text-decoration: underline;
}

.biz-rte-editor :deep(blockquote) {
  border-left: 4px solid #d1d5db;
  padding-left: 16px;
  margin-left: 0;
  color: #4b5563;
  font-style: italic;
}

.biz-rte-editor :deep(pre) {
  background: #f3f4f6;
  padding: 12px;
  border-radius: 4px;
  overflow-x: auto;
  font-family: monospace;
}

.biz-rte-editor :deep(img) {
  max-width: 100%;
  height: auto;
  border-radius: 4px;
}

.biz-rte-editor :deep(hr) {
  border: 0;
  border-top: 1px solid #d1d5db;
  margin: 16px 0;
}
</style>
