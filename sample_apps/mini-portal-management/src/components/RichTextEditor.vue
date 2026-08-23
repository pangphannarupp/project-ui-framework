<script setup lang="ts">
import { ref, onMounted, watch } from 'vue'

const props = withDefaults(
  defineProps<{
    modelValue: string
    placeholder?: string
    minHeight?: string
  }>(),
  {
    modelValue: '',
    placeholder: 'Write formatted description...',
    minHeight: '120px'
  }
)

const emit = defineEmits<{
  (e: 'update:modelValue', value: string): void
}>()

const editorRef = ref<HTMLDivElement | null>(null)
const isSourceMode = ref(false)
const rawHtml = ref('')

onMounted(() => {
  if (editorRef.value) {
    editorRef.value.innerHTML = props.modelValue || ''
  }
  rawHtml.value = props.modelValue || ''
})

watch(
  () => props.modelValue,
  (newVal) => {
    if (editorRef.value && editorRef.value.innerHTML !== newVal) {
      editorRef.value.innerHTML = newVal || ''
    }
    rawHtml.value = newVal || ''
  }
)

const handleInput = () => {
  if (editorRef.value) {
    const html = editorRef.value.innerHTML
    rawHtml.value = html
    emit('update:modelValue', html)
  }
}

const handleSourceInput = () => {
  emit('update:modelValue', rawHtml.value)
  if (editorRef.value) {
    editorRef.value.innerHTML = rawHtml.value
  }
}

const exec = (command: string, value: string | undefined = undefined) => {
  document.execCommand(command, false, value)
  handleInput()
  if (editorRef.value) {
    editorRef.value.focus()
  }
}

const insertLink = () => {
  const url = prompt('Enter hyperlink URL:', 'https://')
  if (url) {
    exec('createLink', url)
  }
}

const toggleSource = () => {
  isSourceMode.value = !isSourceMode.value
  if (!isSourceMode.value && editorRef.value) {
    editorRef.value.innerHTML = rawHtml.value
  }
}
</script>

<template>
  <div class="rich-text-editor">
    <!-- Toolbar -->
    <div class="editor-toolbar">
      <div class="toolbar-group">
        <button
          type="button"
          class="tool-btn"
          @click="exec('bold')"
          title="Bold (Ctrl+B)"
        >
          <strong>B</strong>
        </button>
        <button
          type="button"
          class="tool-btn italic"
          @click="exec('italic')"
          title="Italic (Ctrl+I)"
        >
          <em>I</em>
        </button>
        <button
          type="button"
          class="tool-btn underline"
          @click="exec('underline')"
          title="Underline (Ctrl+U)"
        >
          <u>U</u>
        </button>
        <button
          type="button"
          class="tool-btn strike"
          @click="exec('strikeThrough')"
          title="Strikethrough"
        >
          <s>S</s>
        </button>
      </div>

      <div class="toolbar-divider"></div>

      <div class="toolbar-group">
        <button
          type="button"
          class="tool-btn"
          @click="exec('formatBlock', '<h3>')"
          title="Heading 3"
        >
          H3
        </button>
        <button
          type="button"
          class="tool-btn"
          @click="exec('formatBlock', '<p>')"
          title="Paragraph"
        >
          P
        </button>
        <button
          type="button"
          class="tool-btn"
          @click="exec('insertUnorderedList')"
          title="Bullet List"
        >
          • List
        </button>
        <button
          type="button"
          class="tool-btn"
          @click="exec('insertOrderedList')"
          title="Numbered List"
        >
          1. List
        </button>
      </div>

      <div class="toolbar-divider"></div>

      <div class="toolbar-group">
        <button
          type="button"
          class="tool-btn"
          @click="insertLink"
          title="Insert Link"
        >
          🔗 Link
        </button>
        <button
          type="button"
          class="tool-btn"
          @click="exec('formatBlock', '<blockquote>')"
          title="Quote Block"
        >
          ❝
        </button>
        <button
          type="button"
          class="tool-btn"
          @click="exec('removeFormat')"
          title="Clear Formatting"
        >
          🧹 Clean
        </button>
      </div>

      <div class="toolbar-spacer"></div>

      <div class="toolbar-group">
        <button
          type="button"
          class="tool-btn mode-btn"
          :class="{ active: isSourceMode }"
          @click="toggleSource"
          title="Toggle HTML Code Mode"
        >
          &lt;/&gt; HTML
        </button>
      </div>
    </div>

    <!-- Visual Content Editable Area -->
    <div
      v-show="!isSourceMode"
      ref="editorRef"
      class="editor-content"
      :style="{ minHeight: minHeight }"
      contenteditable="true"
      :data-placeholder="placeholder"
      @input="handleInput"
    ></div>

    <!-- Raw HTML Code View Area -->
    <textarea
      v-show="isSourceMode"
      v-model="rawHtml"
      class="editor-source-textarea"
      :style="{ minHeight: minHeight }"
      @input="handleSourceInput"
      placeholder="Enter raw HTML content..."
    ></textarea>
  </div>
</template>

<style scoped>
.rich-text-editor {
  display: flex;
  flex-direction: column;
  border: 1px solid #374151;
  border-radius: 10px;
  background: #0f172a;
  overflow: hidden;
  transition: border-color 0.2s ease;
}

.rich-text-editor:focus-within {
  border-color: #3b82f6;
  box-shadow: 0 0 0 1px rgba(59, 130, 246, 0.3);
}

.editor-toolbar {
  display: flex;
  align-items: center;
  gap: 4px;
  padding: 6px 8px;
  background: #111827;
  border-bottom: 1px solid #1f2937;
  flex-wrap: wrap;
}

.toolbar-group {
  display: flex;
  align-items: center;
  gap: 2px;
}

.toolbar-divider {
  width: 1px;
  height: 18px;
  background: #374151;
  margin: 0 4px;
}

.toolbar-spacer {
  flex: 1;
}

.tool-btn {
  background: transparent;
  border: 1px solid transparent;
  color: #94a3b8;
  padding: 4px 8px;
  border-radius: 6px;
  font-size: 12px;
  font-weight: 600;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  min-width: 28px;
  height: 28px;
  transition: all 0.15s ease;
}

.tool-btn:hover {
  background: #1f2937;
  color: #f8fafc;
  border-color: #374151;
}

.tool-btn.active {
  background: #2563eb;
  color: #fff;
  border-color: #3b82f6;
}

.mode-btn {
  font-family: 'JetBrains Mono', monospace;
  font-size: 11px;
  padding: 3px 8px;
}

.editor-content {
  padding: 12px 14px;
  color: #f1f5f9;
  font-size: 13px;
  line-height: 1.6;
  outline: none;
  overflow-y: auto;
  position: relative;
}

.editor-content:empty:before {
  content: attr(data-placeholder);
  color: #64748b;
  pointer-events: none;
  display: block;
}

.editor-content :deep(h3) {
  font-size: 15px;
  font-weight: 700;
  color: #fff;
  margin: 8px 0 4px 0;
}

.editor-content :deep(p) {
  margin-bottom: 6px;
}

.editor-content :deep(ul),
.editor-content :deep(ol) {
  padding-left: 20px;
  margin-bottom: 6px;
}

.editor-content :deep(li) {
  margin-bottom: 2px;
}

.editor-content :deep(a) {
  color: #60a5fa;
  text-decoration: underline;
}

.editor-content :deep(blockquote) {
  border-left: 3px solid #3b82f6;
  padding-left: 10px;
  margin: 6px 0;
  color: #94a3b8;
  font-style: italic;
}

.editor-source-textarea {
  width: 100%;
  padding: 12px 14px;
  background: #090d16;
  color: #38bdf8;
  font-family: 'JetBrains Mono', monospace;
  font-size: 12px;
  line-height: 1.5;
  border: none;
  outline: none;
  resize: vertical;
  box-sizing: border-box;
}
</style>
