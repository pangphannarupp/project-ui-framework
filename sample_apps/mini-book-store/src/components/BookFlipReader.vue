<template>
  <div class="book-reader-overlay">
    <div class="reader-header">
      <div class="header-left">
        <span class="vintage-serif text-gold">📖 Previewing:</span>
        <span class="book-title">{{ book.title }}</span>
      </div>
      <button class="close-btn" @click="$emit('close')">
        ✕ {{ t.closeReader }}
      </button>
    </div>

    <div class="reader-container">
      <!-- Vintage book body -->
      <div class="physical-book">
        <div class="spine"></div>
        <div class="book-page left-page">
          <div class="page-content parchment-bg">
            <div class="page-num">{{ currentPageNum }}</div>
            <div class="text-body" :class="{ 'has-dropcap': currentPageNum === 1 }">
              {{ currentText }}
            </div>
          </div>
        </div>
        <!-- Right page (on desktop/tablet shows next page, or shows custom vintage branding) -->
        <div class="book-page right-page hide-mobile">
          <div class="page-content parchment-bg">
            <div class="page-num">{{ currentPageNum + 1 <= book.samplePages.length ? currentPageNum + 1 : '' }}</div>
            <div class="text-body">
              <template v-if="currentPageNum + 1 <= book.samplePages.length">
                {{ book.samplePages[currentPageNum] }}
              </template>
              <div v-else class="end-of-preview">
                <div class="vintage-seal">❦</div>
                <p class="vintage-serif text-center">{{ t.lastPage }}</p>
                <p class="sub-message">Purchase this book to read the remaining {{ book.pages - book.samplePages.length * 5 }} pages!</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Reader controls -->
    <div class="reader-controls">
      <button 
        class="nav-page-btn" 
        :disabled="currentPageNum === 1" 
        @click="prevPage"
      >
        ← Previous
      </button>
      
      <span class="page-indicator">
        {{ t.pages }} {{ currentPageNum }} {{ t.pageOf }} {{ book.samplePages.length }}
      </span>

      <button 
        class="nav-page-btn" 
        :disabled="currentPageNum >= book.samplePages.length" 
        @click="nextPage"
      >
        Next →
      </button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import type { Book } from '../types/book'
import { useI18n } from '../i18n'

const props = defineProps<{
  book: Book
}>()

defineEmits<{
  (e: 'close'): void
}>()

const { t } = useI18n()
const currentPageNum = ref(1)

const currentText = computed(() => {
  return props.book.samplePages[currentPageNum.value - 1] || ''
})

const prevPage = () => {
  if (currentPageNum.value > 1) {
    currentPageNum.value--
  }
}

const nextPage = () => {
  if (currentPageNum.value < props.book.samplePages.length) {
    currentPageNum.value++
  }
}
</script>

<style scoped>
.book-reader-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: #161310;
  z-index: 1000;
  display: flex;
  flex-direction: column;
  color: #f4edd8;
  padding: 16px;
}

.reader-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  border-bottom: 1px solid #4a3e3d;
  padding-bottom: 12px;
}

.header-left {
  display: flex;
  flex-direction: column;
  gap: 2px;
}

.vintage-serif {
  font-family: 'Playfair Display', serif;
  font-style: italic;
}

.text-gold {
  color: #d4af37;
}

.book-title {
  font-size: 1.1rem;
  font-weight: 600;
  color: #fff;
}

.close-btn {
  background: none;
  border: 1px solid #d4af37;
  color: #d4af37;
  padding: 6px 12px;
  border-radius: 4px;
  font-size: 0.9rem;
  cursor: pointer;
  transition: all 0.2s ease;
}

.close-btn:hover {
  background-color: #d4af37;
  color: #1a1512;
}

.reader-container {
  flex: 1;
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 24px 0;
}

/* 3D Book Layout */
.physical-book {
  display: flex;
  width: 100%;
  max-width: 900px;
  height: 80vh;
  max-height: 580px;
  background-color: #2b231d;
  box-shadow: 0 30px 60px rgba(0, 0, 0, 0.6);
  border-radius: 8px;
  overflow: hidden;
  position: relative;
  border: 4px solid #3d3028;
}

.spine {
  width: 16px;
  background: linear-gradient(to right, #1a1512, #3d3028 40%, #1a1512);
  height: 100%;
  position: absolute;
  left: 50%;
  transform: translateX(-50%);
  z-index: 10;
  box-shadow: inset 0 0 10px rgba(0,0,0,0.5);
}

.book-page {
  flex: 1;
  height: 100%;
  position: relative;
  overflow: hidden;
}

.page-content {
  padding: 40px 36px;
  height: 100%;
  display: flex;
  flex-direction: column;
  justify-content: flex-start;
  position: relative;
  box-shadow: inset 0 0 40px rgba(0, 0, 0, 0.08);
}

.parchment-bg {
  background-color: #FAF4E8;
  background-image: radial-gradient(circle, rgba(255,255,255,0.4) 0%, rgba(240,230,210,0.3) 100%);
  color: #2c251e;
}

.page-num {
  position: absolute;
  bottom: 20px;
  font-size: 0.85rem;
  font-family: 'Playfair Display', serif;
  color: #7a6e60;
}

.left-page .page-num {
  left: 30px;
}

.right-page .page-num {
  right: 30px;
}

.text-body {
  font-family: 'Playfair Display', serif;
  font-size: 1.15rem;
  line-height: 1.7;
  white-space: pre-line;
  text-align: justify;
}

.has-dropcap::first-letter {
  float: left;
  font-size: 3.5rem;
  line-height: 0.85;
  padding-top: 4px;
  padding-right: 8px;
  font-weight: bold;
  color: #8A3535;
}

.end-of-preview {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 100%;
  padding: 20px;
  border: 1px dashed #d5c3aa;
  border-radius: 6px;
}

.vintage-seal {
  font-size: 2.5rem;
  color: #8A3535;
  margin-bottom: 12px;
}

.sub-message {
  font-size: 0.9rem;
  font-style: italic;
  color: #7c6853;
  margin-top: 8px;
  text-align: center;
}

.reader-controls {
  display: flex;
  justify-content: space-between;
  align-items: center;
  border-top: 1px solid #4a3e3d;
  padding-top: 16px;
}

.nav-page-btn {
  background-color: #2D4A3E;
  border: none;
  color: #fff;
  padding: 10px 20px;
  border-radius: 4px;
  font-family: 'Playfair Display', serif;
  cursor: pointer;
  transition: opacity 0.2s;
}

.nav-page-btn:disabled {
  opacity: 0.3;
  cursor: not-allowed;
}

.page-indicator {
  font-size: 1rem;
  font-family: 'Playfair Display', serif;
}

/* Mobile responsive */
@media (max-width: 767px) {
  .hide-mobile {
    display: none !important;
  }
  .spine {
    display: none;
  }
  .physical-book {
    border: none;
  }
}
</style>
