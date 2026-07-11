<template>
  <div class="code-block-wrapper">
    <div class="code-block-header">
      <span class="language">vue</span>
      <button class="copy-btn" @click="copyCode">
        {{ copied ? 'Copied!' : 'Copy' }}
      </button>
    </div>
    <pre class="code-block"><code class="code-content">{{ code.trim() }}</code></pre>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';

const props = defineProps<{
  code: string;
}>();

const copied = ref(false);

const copyCode = async () => {
  try {
    await navigator.clipboard.writeText(props.code.trim());
    copied.value = true;
    setTimeout(() => {
      copied.value = false;
    }, 2000);
  } catch (err) {
    console.error('Failed to copy text: ', err);
  }
};
</script>

<style scoped>
.code-block-wrapper {
  background-color: #282c34;
  border-radius: 8px;
  overflow: hidden;
  margin-top: 12px;
  width: 100%;
}

.code-block-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 8px 16px;
  background-color: #21252b;
  border-bottom: 1px solid #181a1f;
}

.language {
  color: #abb2bf;
  font-size: 12px;
  font-family: monospace;
  text-transform: uppercase;
}

.copy-btn {
  background: transparent;
  border: 1px solid #4b5363;
  color: #abb2bf;
  border-radius: 4px;
  padding: 4px 8px;
  font-size: 12px;
  cursor: pointer;
  transition: all 0.2s;
}

.copy-btn:hover {
  background: #4b5363;
  color: white;
}

.code-block {
  margin: 0;
  padding: 16px;
  overflow-x: auto;
}

.code-content {
  font-family: 'Fira Code', Consolas, Monaco, 'Andale Mono', 'Ubuntu Mono', monospace;
  font-size: 14px;
  color: #abb2bf;
  line-height: 1.5;
}
</style>
