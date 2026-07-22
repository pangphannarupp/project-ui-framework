<template>
  <div class="pp-math-preview">
    <div v-if="!katexLoaded" class="pp-math-loading">Loading math renderer...</div>
    <div v-else ref="previewRef" class="pp-math-rendered"></div>
  </div>
</template>

<script setup lang="ts">
import { ref, watch, onMounted, nextTick } from 'vue';

const props = defineProps({
  equation: {
    type: String,
    required: true
  },
  displayMode: {
    type: Boolean,
    default: true
  }
});

const previewRef = ref<HTMLElement | null>(null);
const katexLoaded = ref(false);

const renderMath = () => {
  if (!katexLoaded.value || !previewRef.value) return;
  
  try {
    // @ts-ignore
    window.katex.render(props.equation || ' ', previewRef.value, {
      throwOnError: false,
      displayMode: props.displayMode
    });
  } catch (err) {
    console.error('KaTeX rendering error:', err);
  }
};

watch(() => props.equation, () => {
  renderMath();
});

watch(() => props.displayMode, () => {
  renderMath();
});

onMounted(() => {
  // @ts-ignore
  if (window.katex) {
    katexLoaded.value = true;
    renderMath();
    return;
  }

  // Load CSS
  if (!document.getElementById('katex-css')) {
    const link = document.createElement('link');
    link.id = 'katex-css';
    link.rel = 'stylesheet';
    link.href = 'https://cdn.jsdelivr.net/npm/katex@0.16.8/dist/katex.min.css';
    document.head.appendChild(link);
  }

  // Load JS
  if (!document.getElementById('katex-js')) {
    const script = document.createElement('script');
    script.id = 'katex-js';
    script.src = 'https://cdn.jsdelivr.net/npm/katex@0.16.8/dist/katex.min.js';
    script.onload = async () => {
      katexLoaded.value = true;
      await nextTick();
      renderMath();
    };
    document.head.appendChild(script);
  } else {
    // Poll for it
    const check = setInterval(async () => {
      // @ts-ignore
      if (window.katex) {
        clearInterval(check);
        katexLoaded.value = true;
        await nextTick();
        renderMath();
      }
    }, 100);
  }
});
</script>

<style scoped>
.pp-math-preview {
  display: inline-flex;
  align-items: center;
  justify-content: center;
}

.pp-math-loading {
  color: #9ca3af;
  font-size: 14px;
}

.pp-math-rendered {
  display: inline-block;
}
</style>
