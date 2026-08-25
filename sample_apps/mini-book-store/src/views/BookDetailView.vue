<template>
  <div class="book-detail-view" v-if="book">
    <!-- Navbar -->
    <header class="detail-nav">
      <button class="back-btn" @click="router.push('/')">
        ← {{ t.appName }}
      </button>
      <button class="cart-btn" @click="router.push('/checkout')">
        🛒 <span class="cart-badge" v-if="store.state.cart.length > 0">{{ store.state.cart.length }}</span>
      </button>
    </header>

    <div class="detail-container">
      <div class="editorial-row">
        <!-- Book Cover Column -->
        <div class="cover-col">
          <img :src="book.coverUrl" :alt="book.title" class="premium-cover" />
        </div>

        <!-- Book Details Column -->
        <div class="details-col">
          <span class="detail-genre">{{ book.category }}</span>
          <h1 class="detail-title">{{ book.title }}</h1>
          <p class="detail-author">Written by <span class="author-name">{{ book.author }}</span></p>

          <div class="meta-row">
            <div class="meta-item">
              <span class="meta-label">{{ t.rating }}</span>
              <span class="meta-value text-gold">★ {{ book.rating }} <span class="reviews-count">({{ book.reviewsCount }})</span></span>
            </div>
            <div class="meta-item">
              <span class="meta-label">{{ t.pages }}</span>
              <span class="meta-value">{{ book.pages }}</span>
            </div>
            <div class="meta-item">
              <span class="meta-label">{{ t.published }}</span>
              <span class="meta-value">{{ book.publishedYear }}</span>
            </div>
          </div>

          <p class="detail-description">{{ book.description }}</p>

          <div class="divider"></div>

          <!-- Format Picker -->
          <div class="format-section">
            <h3 class="format-heading">{{ t.formatTitle }}</h3>
            <div class="format-tabs">
              <button 
                v-for="fmt in book.formats" 
                :key="fmt"
                class="format-tab-btn" 
                :class="{ active: selectedFormat === fmt }"
                @click="selectedFormat = fmt"
              >
                <div class="format-tab-name">{{ fmt }}</div>
                <div class="format-tab-price">${{ store.getFormatPrice(book, fmt) }}</div>
              </button>
            </div>
          </div>

          <!-- Action Buttons -->
          <div class="action-buttons-row">
            <button class="preview-btn" @click="showReader = true">
              📖 {{ t.readPreview }}
            </button>
            <button class="add-to-cart-btn" @click="handleAddToCart">
              {{ t.buyNow }} • ${{ currentPrice }}
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- Alert / Custom message for added to cart -->
    <PPAlert
      v-model="showAlert"
      title="Added to Cart"
      :message="`${book.title} (${selectedFormat}) has been added to your cart!`"
      confirmText="Ok"
    />

    <!-- Stateless Interactive Book Flip Reader Overlay -->
    <BookFlipReader 
      v-if="showReader" 
      :book="book" 
      @close="showReader = false" 
    />
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { PPAlert } from '@phanna/ui-framework'
import { BOOK_DATABASE } from '../data/bookData'
import { useBookStore } from '../store/bookStore'
import { useI18n } from '../i18n'
import BookFlipReader from '../components/BookFlipReader.vue'
import type { Book } from '../types/book'

const router = useRouter()
const route = useRoute()
const store = useBookStore()
const { t } = useI18n()

const book = ref<Book | null>(null)
const selectedFormat = ref('Hardcover')
const showReader = ref(false)
const showAlert = ref(false)

onMounted(() => {
  const bId = route.params.id as string
  const foundBook = BOOK_DATABASE.find(b => b.id === bId)
  if (foundBook) {
    book.value = foundBook
    // Default to the first available format
    if (foundBook.formats.length > 0) {
      selectedFormat.value = foundBook.formats[0]
    }
  } else {
    router.push('/')
  }
})

const currentPrice = computed(() => {
  if (!book.value) return 0
  return store.getFormatPrice(book.value, selectedFormat.value)
})

const handleAddToCart = () => {
  if (book.value) {
    store.addToCart(book.value, selectedFormat.value)
    showAlert.value = true
  }
}
</script>

<style scoped>
.book-detail-view {
  min-height: 100vh;
  background-color: #FAF7F2;
  color: #26211C;
  padding-bottom: 60px;
}

.detail-nav {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px 20px;
  max-width: 900px;
  margin: 0 auto;
}

.back-btn {
  background: none;
  border: none;
  font-family: 'Playfair Display', serif;
  font-size: 1.1rem;
  color: #8A3535;
  cursor: pointer;
  font-weight: bold;
}

.cart-btn {
  background: none;
  border: none;
  font-size: 1.3rem;
  cursor: pointer;
  position: relative;
}

.cart-badge {
  position: absolute;
  top: -4px;
  right: -4px;
  background-color: #2D4A3E;
  color: #fff;
  font-size: 0.65rem;
  width: 16px;
  height: 16px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: bold;
}

.detail-container {
  max-width: 900px;
  margin: 20px auto 0 auto;
  padding: 0 20px;
}

.editorial-row {
  display: grid;
  grid-template-columns: 1fr;
  gap: 32px;
}

@media (min-width: 768px) {
  .editorial-row {
    grid-template-columns: 1fr 1.5fr;
  }
}

.cover-col {
  display: flex;
  justify-content: center;
  align-items: flex-start;
}

.premium-cover {
  width: 100%;
  max-width: 320px;
  border-radius: 8px;
  box-shadow: 0 16px 36px rgba(38, 33, 28, 0.15);
  border: 1px solid #FAF7F2;
}

.details-col {
  display: flex;
  flex-direction: column;
}

.detail-genre {
  font-size: 0.75rem;
  text-transform: uppercase;
  color: #8A3535;
  font-weight: 700;
  letter-spacing: 0.8px;
}

.detail-title {
  font-size: 2.2rem;
  line-height: 1.2;
  margin: 8px 0;
  color: #26211C;
}

.detail-author {
  font-size: 1rem;
  color: #706254;
  margin-bottom: 20px;
}

.author-name {
  color: #2D4A3E;
  font-weight: 600;
  font-family: 'Playfair Display', serif;
}

.meta-row {
  display: flex;
  gap: 24px;
  margin-bottom: 24px;
}

.meta-item {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.meta-label {
  font-size: 0.75rem;
  color: #706254;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.meta-value {
  font-size: 1rem;
  font-weight: 600;
}

.text-gold {
  color: #d4af37;
}

.reviews-count {
  font-size: 0.8rem;
  color: #706254;
  font-weight: normal;
}

.detail-description {
  font-size: 1.05rem;
  line-height: 1.6;
  color: #4a3e36;
  text-align: justify;
}

.divider {
  height: 1px;
  background-color: #e2dacd;
  margin: 24px 0;
}

.format-section {
  margin-bottom: 24px;
}

.format-heading {
  font-size: 1.1rem;
  margin-bottom: 12px;
  color: #26211C;
}

.format-tabs {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(100px, 1fr));
  gap: 12px;
}

.format-tab-btn {
  background-color: #fff;
  border: 1px solid #e2dacd;
  border-radius: 6px;
  padding: 12px;
  cursor: pointer;
  transition: all 0.2s;
  text-align: center;
}

.format-tab-btn.active {
  border-color: #8A3535;
  background-color: #f7ede2;
  box-shadow: 0 4px 10px rgba(138, 53, 53, 0.08);
}

.format-tab-name {
  font-size: 0.85rem;
  font-weight: 600;
  color: #706254;
}

.format-tab-btn.active .format-tab-name {
  color: #8A3535;
}

.format-tab-price {
  font-size: 1.05rem;
  font-weight: bold;
  margin-top: 4px;
  color: #26211C;
}

.action-buttons-row {
  display: grid;
  grid-template-columns: 1fr;
  gap: 12px;
  margin-top: 12px;
}

@media (min-width: 480px) {
  .action-buttons-row {
    grid-template-columns: 1fr 1.5fr;
  }
}

.preview-btn {
  background-color: #fff;
  border: 1.5px solid #2D4A3E;
  color: #2D4A3E;
  font-family: 'Playfair Display', serif;
  font-weight: bold;
  padding: 14px;
  border-radius: 6px;
  cursor: pointer;
  transition: background-color 0.2s;
}

.preview-btn:hover {
  background-color: #eff5f2;
}

.add-to-cart-btn {
  background-color: #8A3535;
  border: none;
  color: #fff;
  font-weight: bold;
  padding: 14px;
  border-radius: 6px;
  cursor: pointer;
  transition: background-color 0.2s;
  font-size: 1rem;
}

.add-to-cart-btn:hover {
  background-color: #752d2d;
}

@media (max-width: 600px) {
  .detail-nav {
    padding: 12px 14px;
  }
  .detail-title {
    font-size: 1.6rem;
  }
  .meta-row {
    gap: 16px;
    margin-bottom: 16px;
  }
  .meta-value {
    font-size: 0.9rem;
  }
  .format-tabs {
    grid-template-columns: repeat(2, 1fr);
  }
  .preview-btn, .add-to-cart-btn {
    padding: 12px;
    font-size: 0.9rem;
  }
}
</style>
