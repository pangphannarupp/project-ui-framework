<template>
  <div class="pp-rte-container" :class="{ 'is-focused': isFocused, 'is-preview': currentMode === 'preview' }">
    <!-- Toolbar -->
    <div class="pp-rte-toolbar" :class="{ 'is-disabled': currentMode !== 'edit' && currentMode !== 'split' }">
      <div class="toolbar-group">
        <button class="toolbar-btn" @click="format('undo')" title="Undo" type="button" :disabled="currentMode !== 'edit' && currentMode !== 'split'">
          <svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><path d="M3 7v6h6"></path><path d="M21 17a9 9 0 00-9-9 9 9 0 00-6 2.3L3 13"></path></svg>
        </button>
        <button class="toolbar-btn" @click="format('redo')" title="Redo" type="button" :disabled="currentMode !== 'edit' && currentMode !== 'split'">
          <svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><path d="M21 7v6h-6"></path><path d="M3 17a9 9 0 019-9 9 9 0 016 2.3l3 2.7"></path></svg>
        </button>
      </div>

      <div class="toolbar-divider"></div>

      <div class="toolbar-group">
        <button class="toolbar-btn" @click="format('bold')" title="Bold" type="button" :disabled="currentMode !== 'edit' && currentMode !== 'split'">
          <svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><path d="M6 4h8a4 4 0 0 1 4 4 4 4 0 0 1-4 4H6z"></path><path d="M6 12h9a4 4 0 0 1 4 4 4 4 0 0 1-4 4H6z"></path></svg>
        </button>
        <button class="toolbar-btn" @click="format('italic')" title="Italic" type="button" :disabled="currentMode !== 'edit' && currentMode !== 'split'">
          <svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><line x1="19" y1="4" x2="10" y2="4"></line><line x1="14" y1="20" x2="5" y2="20"></line><line x1="15" y1="4" x2="9" y2="20"></line></svg>
        </button>
        <button class="toolbar-btn" @click="format('underline')" title="Underline" type="button" :disabled="currentMode !== 'edit' && currentMode !== 'split'">
          <svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><path d="M6 3v7a6 6 0 0 0 6 6 6 6 0 0 0 6-6V3"></path><line x1="4" y1="21" x2="20" y2="21"></line></svg>
        </button>
        <button class="toolbar-btn" @click="format('strikeThrough')" title="Strikethrough" type="button" :disabled="currentMode !== 'edit' && currentMode !== 'split'">
          <svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><path d="M16 4H9a3 3 0 0 0-2.83 4"></path><path d="M14 12a4 4 0 0 1 0 8H6"></path><line x1="4" y1="12" x2="20" y2="12"></line></svg>
        </button>
        <button class="toolbar-btn" @click="format('subscript')" title="Subscript" type="button" :disabled="currentMode !== 'edit' && currentMode !== 'split'">
          <span style="font-weight: bold; font-size: 14px;">X<sub style="font-size: 10px;">2</sub></span>
        </button>
        <button class="toolbar-btn" @click="format('superscript')" title="Superscript" type="button" :disabled="currentMode !== 'edit' && currentMode !== 'split'">
          <span style="font-weight: bold; font-size: 14px;">X<sup style="font-size: 10px;">2</sup></span>
        </button>
      </div>

      <div class="toolbar-divider"></div>

      <!-- Format Dropdown -->
      <div class="toolbar-dropdown" :class="{ 'is-active': activeDropdown === 'format' }">
        <button class="toolbar-btn dropdown-toggle" @click="toggleDropdown('format')" title="Format" type="button" :disabled="currentMode !== 'edit' && currentMode !== 'split'">
          <svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><polyline points="4 7 4 4 20 4 20 7"></polyline><line x1="9" y1="20" x2="15" y2="20"></line><line x1="12" y1="4" x2="12" y2="20"></line></svg>
          <svg class="dropdown-arrow" viewBox="0 0 24 24" width="12" height="12" stroke="currentColor" stroke-width="2" fill="none"><polyline points="6 9 12 15 18 9"></polyline></svg>
        </button>
        <div class="dropdown-menu" v-show="activeDropdown === 'format'">
          <button class="dropdown-item" @click="formatBlock('H1'); toggleDropdown('format')" type="button">Heading 1</button>
          <button class="dropdown-item" @click="formatBlock('H2'); toggleDropdown('format')" type="button">Heading 2</button>
          <button class="dropdown-item" @click="formatBlock('H3'); toggleDropdown('format')" type="button">Heading 3</button>
          <button class="dropdown-item" @click="formatBlock('P'); toggleDropdown('format')" type="button">Paragraph</button>
          <button class="dropdown-item" @click="formatBlock('BLOCKQUOTE'); toggleDropdown('format')" type="button">Quote</button>
          <button class="dropdown-item" @click="formatBlock('PRE'); toggleDropdown('format')" type="button">Code Block</button>
        </div>
      </div>

      <!-- Align Dropdown -->
      <div class="toolbar-dropdown" :class="{ 'is-active': activeDropdown === 'align' }">
        <button class="toolbar-btn dropdown-toggle" @click="toggleDropdown('align')" title="Align" type="button" :disabled="currentMode !== 'edit' && currentMode !== 'split'">
          <svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><line x1="21" y1="6" x2="3" y2="6"></line><line x1="15" y1="12" x2="3" y2="12"></line><line x1="17" y1="18" x2="3" y2="18"></line></svg>
          <svg class="dropdown-arrow" viewBox="0 0 24 24" width="12" height="12" stroke="currentColor" stroke-width="2" fill="none"><polyline points="6 9 12 15 18 9"></polyline></svg>
        </button>
        <div class="dropdown-menu" v-show="activeDropdown === 'align'">
          <button class="dropdown-item" @click="format('justifyLeft'); toggleDropdown('align')" type="button">
            <svg viewBox="0 0 24 24" width="14" height="14" stroke="currentColor" stroke-width="2" fill="none"><line x1="21" y1="6" x2="3" y2="6"></line><line x1="15" y1="12" x2="3" y2="12"></line><line x1="17" y1="18" x2="3" y2="18"></line></svg>
            Align Left
          </button>
          <button class="dropdown-item" @click="format('justifyCenter'); toggleDropdown('align')" type="button">
            <svg viewBox="0 0 24 24" width="14" height="14" stroke="currentColor" stroke-width="2" fill="none"><line x1="21" y1="6" x2="3" y2="6"></line><line x1="17" y1="12" x2="7" y2="12"></line><line x1="19" y1="18" x2="5" y2="18"></line></svg>
            Align Center
          </button>
          <button class="dropdown-item" @click="format('justifyRight'); toggleDropdown('align')" type="button">
            <svg viewBox="0 0 24 24" width="14" height="14" stroke="currentColor" stroke-width="2" fill="none"><line x1="21" y1="6" x2="3" y2="6"></line><line x1="21" y1="12" x2="9" y2="12"></line><line x1="21" y1="18" x2="7" y2="18"></line></svg>
            Align Right
          </button>
          <button class="dropdown-item" @click="format('justifyFull'); toggleDropdown('align')" type="button">
            <svg viewBox="0 0 24 24" width="14" height="14" stroke="currentColor" stroke-width="2" fill="none"><line x1="21" y1="6" x2="3" y2="6"></line><line x1="21" y1="12" x2="3" y2="12"></line><line x1="21" y1="18" x2="3" y2="18"></line></svg>
            Justify Full
          </button>
        </div>
      </div>

      <!-- Lists & Indent Dropdown -->
      <div class="toolbar-dropdown" :class="{ 'is-active': activeDropdown === 'list' }">
        <button class="toolbar-btn dropdown-toggle" @click="toggleDropdown('list')" title="Lists & Indent" type="button" :disabled="currentMode !== 'edit' && currentMode !== 'split'">
          <svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><line x1="8" y1="6" x2="21" y2="6"></line><line x1="8" y1="12" x2="21" y2="12"></line><line x1="8" y1="18" x2="21" y2="18"></line><line x1="3" y1="6" x2="3.01" y2="6"></line><line x1="3" y1="12" x2="3.01" y2="12"></line><line x1="3" y1="18" x2="3.01" y2="18"></line></svg>
          <svg class="dropdown-arrow" viewBox="0 0 24 24" width="12" height="12" stroke="currentColor" stroke-width="2" fill="none"><polyline points="6 9 12 15 18 9"></polyline></svg>
        </button>
        <div class="dropdown-menu" v-show="activeDropdown === 'list'">
          <button class="dropdown-item" @click="format('insertUnorderedList'); toggleDropdown('list')" type="button">
            <svg viewBox="0 0 24 24" width="14" height="14" stroke="currentColor" stroke-width="2" fill="none"><line x1="8" y1="6" x2="21" y2="6"></line><line x1="8" y1="12" x2="21" y2="12"></line><line x1="8" y1="18" x2="21" y2="18"></line><line x1="3" y1="6" x2="3.01" y2="6"></line><line x1="3" y1="12" x2="3.01" y2="12"></line><line x1="3" y1="18" x2="3.01" y2="18"></line></svg>
            Bullet List
          </button>
          <button class="dropdown-item" @click="format('insertOrderedList'); toggleDropdown('list')" type="button">
            <svg viewBox="0 0 24 24" width="14" height="14" stroke="currentColor" stroke-width="2" fill="none"><line x1="10" y1="6" x2="21" y2="6"></line><line x1="10" y1="12" x2="21" y2="12"></line><line x1="10" y1="18" x2="21" y2="18"></line><path d="M4 6h1v4"></path><path d="M4 10h2"></path><path d="M6 18H4c0-1 2-2 2-3s-1-1.5-2-1"></path></svg>
            Number List
          </button>
          <button class="dropdown-item" @click="format('outdent'); toggleDropdown('list')" type="button">
            <svg viewBox="0 0 24 24" width="14" height="14" stroke="currentColor" stroke-width="2" fill="none"><polyline points="7 8 3 12 7 16"></polyline><line x1="21" y1="12" x2="11" y2="12"></line><line x1="21" y1="6" x2="11" y2="6"></line><line x1="21" y1="18" x2="11" y2="18"></line></svg>
            Decrease Indent
          </button>
          <button class="dropdown-item" @click="format('indent'); toggleDropdown('list')" type="button">
            <svg viewBox="0 0 24 24" width="14" height="14" stroke="currentColor" stroke-width="2" fill="none"><polyline points="17 8 21 12 17 16"></polyline><line x1="3" y1="12" x2="13" y2="12"></line><line x1="3" y1="6" x2="13" y2="6"></line><line x1="3" y1="18" x2="13" y2="18"></line></svg>
            Increase Indent
          </button>
        </div>
      </div>

      <div class="toolbar-divider"></div>

      <div class="toolbar-group">
        <button class="toolbar-btn" @click="insertLink" title="Insert Link" type="button" :disabled="currentMode !== 'edit' && currentMode !== 'split'">
          <svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><path d="M10 13a5 5 0 0 0 7.54.54l3-3a5 5 0 0 0-7.07-7.07l-1.72 1.71"></path><path d="M14 11a5 5 0 0 0-7.54-.54l-3 3a5 5 0 0 0 7.07 7.07l1.71-1.71"></path></svg>
        </button>
        <button class="toolbar-btn" @click="insertImage" title="Insert Image" type="button" :disabled="currentMode !== 'edit' && currentMode !== 'split'">
          <svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect><circle cx="8.5" cy="8.5" r="1.5"></circle><polyline points="21 15 16 10 5 21"></polyline></svg>
        </button>
        <button class="toolbar-btn" @click="insertTable" title="Insert Table" type="button" :disabled="currentMode !== 'edit' && currentMode !== 'split'">
          <svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect><line x1="3" y1="9" x2="21" y2="9"></line><line x1="3" y1="15" x2="21" y2="15"></line><line x1="9" y1="3" x2="9" y2="21"></line><line x1="15" y1="3" x2="15" y2="21"></line></svg>
        </button>
        <button class="toolbar-btn" @click="format('insertHorizontalRule')" title="Horizontal Rule" type="button" :disabled="currentMode !== 'edit' && currentMode !== 'split'">
          <svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><line x1="3" y1="12" x2="21" y2="12"></line><line x1="3" y1="6" x2="5" y2="6"></line><line x1="3" y1="18" x2="5" y2="18"></line><line x1="19" y1="6" x2="21" y2="6"></line><line x1="19" y1="18" x2="21" y2="18"></line></svg>
        </button>
        <button class="toolbar-btn" @click="format('removeFormat')" title="Clear Formatting" type="button" :disabled="currentMode !== 'edit' && currentMode !== 'split'">
          <svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><path d="M4 7V4h16v3"></path><path d="M9 20h6"></path><path d="M12 4v16"></path><line x1="4" y1="4" x2="20" y2="20"></line></svg>
        </button>
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
            :disabled="currentMode !== 'edit' && currentMode !== 'split'"
          >
            <span v-html="btn.icon"></span>
          </button>
        </div>
      </template>

      <!-- Mode Toggle -->
      <div v-if="showModeToggle && availableModes.length > 1" class="toolbar-group mode-toggle-group">
        <button 
          v-if="availableModes.includes('edit')"
          class="mode-btn" 
          :class="{ active: currentMode === 'edit' }"
          @click="setMode('edit')"
          title="Edit Mode"
          type="button"
        >
          <svg viewBox="0 0 24 24" width="14" height="14" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><path d="M12 20h9"></path><path d="M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19l-4 1 1-4L16.5 3.5z"></path></svg>
          Edit
        </button>
        <button 
          v-if="availableModes.includes('html')"
          class="mode-btn" 
          :class="{ active: currentMode === 'html' }"
          @click="setMode('html')"
          title="HTML Mode"
          type="button"
        >
          <svg viewBox="0 0 24 24" width="14" height="14" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><polyline points="16 18 22 12 16 6"></polyline><polyline points="8 6 2 12 8 18"></polyline></svg>
          HTML
        </button>
        <button 
          v-if="availableModes.includes('preview')"
          class="mode-btn" 
          :class="{ active: currentMode === 'preview' }"
          @click="setMode('preview')"
          title="Preview Mode"
          type="button"
        >
          <svg viewBox="0 0 24 24" width="14" height="14" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path><circle cx="12" cy="12" r="3"></circle></svg>
          Preview
        </button>
      </div>

    </div>

    <!-- Editor Area -->
    <div 
      v-show="currentMode === 'edit'"
      ref="editorRef"
      class="pp-rte-editor" 
      :style="{ minHeight }"
      contenteditable="true"
      @input="onInput"
      @focus="isFocused = true"
      @blur="onBlur"
      :data-placeholder="placeholder"
    ></div>

    <textarea 
      v-if="currentMode === 'html'"
      class="pp-rte-editor source-editor"
      v-model="htmlContent"
      :style="{ minHeight }"
      :placeholder="placeholder"
      @focus="isFocused = true"
      @blur="isFocused = false"
    ></textarea>
    
    <div 
      v-else-if="currentMode === 'preview'"
      class="pp-rte-editor is-readonly" 
      :style="{ minHeight }"
      v-html="htmlContent"
    ></div>

    <!-- Custom Prompt Overlay -->
    <div v-if="promptVisible" class="pp-rte-prompt-overlay" @mousedown.self="cancelPrompt">
      <div class="pp-rte-prompt-dialog">
        <h3 class="pp-rte-prompt-title">{{ promptTitle }}</h3>
        <div class="pp-rte-prompt-body">
          <div v-for="(input, index) in promptInputs" :key="input.key" class="pp-rte-prompt-field">
            <label :for="'prompt-' + input.key">{{ input.label }}</label>
            <input 
              :id="'prompt-' + input.key" 
              :type="input.type" 
              v-model="input.value" 
              class="pp-rte-prompt-input"
              :ref="el => { if (index === 0) firstInputRef = el }"
              @keydown.enter="submitPrompt"
              @keydown.esc="cancelPrompt"
            >
          </div>
        </div>
        <div class="pp-rte-prompt-footer">
          <button class="pp-rte-btn-cancel" @click="cancelPrompt">Cancel</button>
          <button class="pp-rte-btn-submit" @click="submitPrompt">Confirm</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, watch, onMounted, onUnmounted, PropType, nextTick } from 'vue';

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
  },
  showModeToggle: {
    type: Boolean,
    default: true
  },
  availableModes: {
    type: Array as PropType<Array<'edit' | 'html' | 'preview'>>,
    default: () => ['edit', 'html', 'preview']
  }
});

const emit = defineEmits(['update:modelValue']);

const editorRef = ref<HTMLElement | null>(null);
const isFocused = ref(false);
const isTyping = ref(false);
const currentMode = ref<'edit' | 'html' | 'preview' | 'split'>('edit');
const htmlContent = ref(props.modelValue);

const activeDropdown = ref<string | null>(null);

let savedSelection: Range | null = null;
const promptVisible = ref(false);
const promptTitle = ref('');
const promptInputs = ref<{key: string, label: string, value: string, type: string}[]>([]);
let promptResolve: ((values: Record<string, string> | null) => void) | null = null;
const firstInputRef = ref<any>(null);

const saveSelection = () => {
  const selection = window.getSelection();
  if (selection && selection.rangeCount > 0) {
    let node = selection.anchorNode;
    while (node && node !== document.body) {
      if (node === editorRef.value) {
        savedSelection = selection.getRangeAt(0);
        return;
      }
      node = node.parentNode;
    }
  }
  savedSelection = null;
};

const restoreSelection = () => {
  editorRef.value?.focus();
  if (savedSelection) {
    const selection = window.getSelection();
    if (selection) {
      selection.removeAllRanges();
      selection.addRange(savedSelection);
    }
  }
};

const openPrompt = (title: string, inputs: {key: string, label: string, defaultValue?: string, type?: string}[]) => {
  saveSelection();
  return new Promise<Record<string, string> | null>((resolve) => {
    promptTitle.value = title;
    promptInputs.value = inputs.map(i => ({
      key: i.key,
      label: i.label,
      value: i.defaultValue || '',
      type: i.type || 'text'
    }));
    promptResolve = resolve;
    promptVisible.value = true;
    
    nextTick(() => {
      if (firstInputRef.value) {
        firstInputRef.value.focus();
        if (firstInputRef.value.select) firstInputRef.value.select();
      }
    });
  });
};

const submitPrompt = () => {
  const result: Record<string, string> = {};
  promptInputs.value.forEach(i => {
    result[i.key] = i.value;
  });
  if (promptResolve) promptResolve(result);
  promptVisible.value = false;
};

const cancelPrompt = () => {
  if (promptResolve) promptResolve(null);
  promptVisible.value = false;
};

const toggleDropdown = (name: string) => {
  if (currentMode.value !== 'edit' && currentMode.value !== 'split') return;
  activeDropdown.value = activeDropdown.value === name ? null : name;
};

const closeDropdowns = (e: MouseEvent) => {
  const target = e.target as HTMLElement;
  if (!target.closest('.toolbar-dropdown')) {
    activeDropdown.value = null;
  }
};

const prettyFormatHTML = (html: string) => {
  if (!html) return '';
  let formatted = '';
  const reg = /(>)(<)(\/*)/g;
  let str = html.replace(reg, '$1\r\n$2$3');
  let pad = 0;
  
  str.split('\r\n').forEach(function(node) {
    let indent = 0;
    if (node.match( /.+<\/\w[^>]*>$/ )) {
      indent = 0;
    } else if (node.match( /^<\/\w/ )) {
      if (pad !== 0) pad -= 1;
    } else if (node.match( /^<\w[^>]*[^\/]>.*$/ )) {
      indent = 1;
    } else {
      indent = 0;
    }
    
    let padding = '';
    for (let i = 0; i < pad; i++) {
      padding += '  ';
    }
    
    formatted += padding + node + '\r\n';
    pad += indent;
  });
  
  return formatted.trim();
};

const setMode = (mode: 'edit' | 'html' | 'preview') => {
  if (mode === 'html' && currentMode.value !== 'html') {
    htmlContent.value = prettyFormatHTML(htmlContent.value);
  }
  
  if (mode === 'edit' && currentMode.value !== 'edit' && currentMode.value !== 'split') {
    nextTick(() => {
      if (editorRef.value) {
        editorRef.value.innerHTML = htmlContent.value;
      }
    });
  }

  currentMode.value = mode;
};

const format = (command: string, value?: string) => {
  if (currentMode.value !== 'edit' && currentMode.value !== 'split') return;
  document.execCommand(command, false, value);
  updateModel();
  editorRef.value?.focus();
};

const formatBlock = (tag: string) => {
  if (currentMode.value !== 'edit' && currentMode.value !== 'split') return;
  document.execCommand('formatBlock', false, tag);
  updateModel();
  editorRef.value?.focus();
};

const insertLink = async () => {
  if (currentMode.value !== 'edit' && currentMode.value !== 'split') return;
  const result = await openPrompt('Insert Link', [{ key: 'url', label: 'URL', type: 'url', defaultValue: 'https://' }]);
  if (result && result.url) {
    restoreSelection();
    format('createLink', result.url);
  }
};

const insertImage = async () => {
  if (currentMode.value !== 'edit' && currentMode.value !== 'split') return;
  const result = await openPrompt('Insert Image', [{ key: 'url', label: 'Image URL', type: 'url', defaultValue: 'https://' }]);
  if (result && result.url) {
    restoreSelection();
    format('insertImage', result.url);
  }
};

const insertTable = async () => {
  if (currentMode.value !== 'edit' && currentMode.value !== 'split') return;
  const result = await openPrompt('Insert Table', [
    { key: 'rows', label: 'Number of rows', type: 'number', defaultValue: '3' },
    { key: 'cols', label: 'Number of columns', type: 'number', defaultValue: '3' }
  ]);
  
  if (result) {
    restoreSelection();
    const rows = parseInt(result.rows, 10);
    const cols = parseInt(result.cols, 10);
    
    if (rows > 0 && cols > 0) {
      let tableHTML = '<table><tbody>';
      for (let r = 0; r < rows; r++) {
        tableHTML += '<tr>';
        for (let c = 0; c < cols; c++) {
          tableHTML += '<td>Cell</td>';
        }
        tableHTML += '</tr>';
      }
      tableHTML += '</tbody></table><p><br></p>';
      format('insertHTML', tableHTML);
    }
  }
};

const executeCustom = (btn: CustomEditorButton) => {
  if (currentMode.value !== 'edit' && currentMode.value !== 'split') return;
  if (btn.html) {
    format('insertHTML', btn.html);
  } else if (btn.action) {
    btn.action({
      insertHTML: (html: string) => format('insertHTML', html)
    });
  }
};

const updateModel = () => {
  if (editorRef.value && currentMode.value === 'edit') {
    let html = editorRef.value.innerHTML;
    if (html === '<br>') html = ''; // Clean up empty content
    isTyping.value = true;
    htmlContent.value = html;
  }
};

const onInput = () => {
  updateModel();
};

const onBlur = () => {
  isFocused.value = false;
  isTyping.value = false;
};

watch(htmlContent, (newVal) => {
  emit('update:modelValue', newVal);
});

// Sync external changes to the editor (but don't overwrite if the user is actively typing)
watch(() => props.modelValue, (newVal) => {
  if (newVal !== htmlContent.value) {
    htmlContent.value = newVal;
    if (currentMode.value === 'edit' && editorRef.value && !isTyping.value) {
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
  document.addEventListener('click', closeDropdowns);
});

onUnmounted(() => {
  document.removeEventListener('click', closeDropdowns);
});
</script>

<style scoped>
.pp-rte-container {
  border: 1px solid #d1d5db;
  border-radius: 8px;
  background: white;
  overflow: hidden;
  display: flex;
  flex-direction: column;
  transition: border-color 0.2s, box-shadow 0.2s;
  position: relative;
}

.pp-rte-container.is-focused {
  border-color: #003399;
  box-shadow: 0 0 0 3px rgba(0, 51, 153, 0.1);
}

.pp-rte-container.is-preview {
  border-color: #e5e7eb;
}

.pp-rte-toolbar {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  padding: 8px 12px;
  background: #f9fafb;
  border-bottom: 1px solid #e5e7eb;
  gap: 8px;
  transition: opacity 0.2s;
}

.pp-rte-toolbar.is-disabled .toolbar-btn:not(:disabled) {
  opacity: 0.5;
  pointer-events: none;
}

.toolbar-group {
  display: flex;
  gap: 4px;
}

.toolbar-dropdown {
  position: relative;
  display: inline-block;
}

.toolbar-btn.dropdown-toggle {
  display: flex;
  align-items: center;
  gap: 4px;
  padding: 0 8px;
  width: auto;
}

.dropdown-arrow {
  opacity: 0.6;
  margin-left: 2px;
}

.toolbar-dropdown.is-active .dropdown-toggle {
  background: #e5e7eb;
  color: #111827;
}

.dropdown-menu {
  position: absolute;
  top: 100%;
  left: 0;
  margin-top: 4px;
  background: white;
  border: 1px solid #e5e7eb;
  border-radius: 6px;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
  min-width: 140px;
  z-index: 10;
  padding: 4px;
  display: flex;
  flex-direction: column;
}

.dropdown-item {
  display: flex;
  align-items: center;
  gap: 8px;
  width: 100%;
  text-align: left;
  background: transparent;
  border: none;
  padding: 6px 10px;
  font-size: 13px;
  color: #374151;
  border-radius: 4px;
  cursor: pointer;
  transition: background 0.2s;
}

.dropdown-item:hover {
  background: #f3f4f6;
  color: #111827;
}

.dropdown-item svg {
  color: #6b7280;
}


.mode-toggle-group {
  margin-left: auto;
  background: #e5e7eb;
  padding: 2px;
  border-radius: 6px;
  pointer-events: auto !important; /* Allow toggle even when toolbar disabled */
  opacity: 1 !important;
}

.mode-btn {
  background: transparent;
  border: none;
  border-radius: 4px;
  padding: 4px 10px;
  font-size: 12px;
  font-weight: 500;
  color: #4b5563;
  cursor: pointer;
  display: flex;
  align-items: center;
  gap: 6px;
  transition: all 0.2s;
}

.mode-btn:hover {
  color: #111827;
}

.mode-btn.active {
  background: white;
  color: #003399;
  box-shadow: 0 1px 3px rgba(0,0,0,0.1);
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
  color: #4b5563;
  width: 32px;
  height: 32px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.2s;
}

.toolbar-btn:hover:not(:disabled) {
  background: #e5e7eb;
  color: #111827;
}

.toolbar-btn:active:not(:disabled) {
  background: #d1d5db;
}

.toolbar-btn:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.pp-rte-editor {
  padding: 16px 20px;
  outline: none;
  font-family: inherit;
  font-size: 15px;
  line-height: 1.6;
  color: #1f2937;
  overflow-y: auto;
}

.pp-rte-editor.source-editor {
  width: 100%;
  resize: vertical;
  border: none;
  background: #fdfdfd;
  font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", "Courier New", monospace;
  font-size: 14px;
  padding: 16px 20px;
  outline: none;
  color: #374151;
}

.pp-rte-editor.is-readonly {
  background: #fafafa;
}

/* Placeholder support */
.pp-rte-editor:empty:before {
  content: attr(data-placeholder);
  color: #9ca3af;
  pointer-events: none;
  display: block; 
}

/* Editor default styles to ensure headings and lists look correct */
.pp-rte-editor :deep(h1) {
  font-size: 2em;
  margin: 0.67em 0;
  font-weight: 700;
  color: #111827;
}

.pp-rte-editor :deep(h2) {
  font-size: 1.5em;
  margin: 0.83em 0;
  font-weight: 600;
  color: #111827;
}

.pp-rte-editor :deep(h3) {
  font-size: 1.17em;
  margin: 1em 0;
  font-weight: 600;
  color: #111827;
}

.pp-rte-editor :deep(p) {
  margin: 0 0 1em 0;
}

.pp-rte-editor :deep(ul) {
  list-style-type: disc;
  padding-left: 2em;
  margin: 1em 0;
}

.pp-rte-editor :deep(ol) {
  list-style-type: decimal;
  padding-left: 2em;
  margin: 1em 0;
}

.pp-rte-editor :deep(a) {
  color: #003399;
  text-decoration: underline;
}

.pp-rte-editor :deep(blockquote) {
  border-left: 4px solid #003399;
  padding-left: 16px;
  margin: 1.5em 0;
  color: #4b5563;
  font-style: italic;
  background: #f9fafb;
  padding-top: 8px;
  padding-bottom: 8px;
  border-radius: 0 4px 4px 0;
}

.pp-rte-editor :deep(pre) {
  background: #f3f4f6;
  padding: 12px 16px;
  border-radius: 6px;
  overflow-x: auto;
  font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", "Courier New", monospace;
  font-size: 0.9em;
  border: 1px solid #e5e7eb;
}

.pp-rte-editor :deep(img) {
  max-width: 100%;
  height: auto;
  border-radius: 6px;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
}

.pp-rte-editor :deep(table) {
  width: 100%;
  border-collapse: collapse;
  margin: 1em 0;
}

.pp-rte-editor :deep(th),
.pp-rte-editor :deep(td) {
  border: 1px solid #d1d5db;
  padding: 8px 12px;
}

.pp-rte-editor :deep(th) {
  background: #f9fafb;
  font-weight: 600;
  text-align: left;
}

.pp-rte-editor :deep(hr) {
  border: 0;
  border-top: 1px solid #e5e7eb;
  margin: 24px 0;
}

/* Prompt Overlay Styles */
.pp-rte-prompt-overlay {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(17, 24, 39, 0.4);
  backdrop-filter: blur(2px);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 50;
  border-radius: inherit;
}

.pp-rte-prompt-dialog {
  background: white;
  border-radius: 8px;
  box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
  width: 90%;
  max-width: 320px;
  overflow: hidden;
  animation: promptFadeIn 0.2s ease-out;
}

@keyframes promptFadeIn {
  from { opacity: 0; transform: scale(0.95); }
  to { opacity: 1; transform: scale(1); }
}

.pp-rte-prompt-title {
  margin: 0;
  padding: 16px 20px;
  font-size: 16px;
  font-weight: 600;
  color: #111827;
  border-bottom: 1px solid #e5e7eb;
}

.pp-rte-prompt-body {
  padding: 16px 20px;
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.pp-rte-prompt-field {
  display: flex;
  flex-direction: column;
  gap: 6px;
}

.pp-rte-prompt-field label {
  font-size: 13px;
  font-weight: 500;
  color: #374151;
}

.pp-rte-prompt-input {
  border: 1px solid #d1d5db;
  border-radius: 6px;
  padding: 8px 12px;
  font-size: 14px;
  outline: none;
  transition: border-color 0.2s, box-shadow 0.2s;
  font-family: inherit;
  background-color: #ffffff;
  color: #111827;
  color-scheme: light;
}

/* Remove default number arrows to look cleaner */
.pp-rte-prompt-input[type="number"]::-webkit-inner-spin-button,
.pp-rte-prompt-input[type="number"]::-webkit-outer-spin-button {
  -webkit-appearance: none;
  margin: 0;
}
.pp-rte-prompt-input[type="number"] {
  -moz-appearance: textfield;
}

.pp-rte-prompt-input:focus {
  border-color: #003399;
  box-shadow: 0 0 0 3px rgba(0, 51, 153, 0.1);
}

.pp-rte-prompt-footer {
  padding: 12px 20px;
  background: #f9fafb;
  border-top: 1px solid #e5e7eb;
  display: flex;
  justify-content: flex-end;
  gap: 8px;
}

.pp-rte-btn-cancel,
.pp-rte-btn-submit {
  padding: 6px 14px;
  font-size: 14px;
  font-weight: 500;
  border-radius: 6px;
  cursor: pointer;
  transition: all 0.2s;
  font-family: inherit;
}

.pp-rte-btn-cancel {
  background: white;
  border: 1px solid #d1d5db;
  color: #4b5563;
}

.pp-rte-btn-cancel:hover {
  background: #f3f4f6;
}

.pp-rte-btn-submit {
  background: #003399;
  border: 1px solid #003399;
  color: white;
}

.pp-rte-btn-submit:hover {
  background: #002266;
}
</style>
