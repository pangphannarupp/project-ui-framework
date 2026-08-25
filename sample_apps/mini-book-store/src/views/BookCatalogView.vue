<template>
  <div class="catalog-view">
    <!-- Top Vintage Bar -->
    <header class="store-header">
      <div class="header-container">
        <div class="logo-area">
          <span class="logo-icon">📖</span>
          <div>
            <h1 class="store-title">{{ t.appName }}</h1>
            <p class="store-subtitle">Est. 2026 • Literary Classics & Modern Works</p>
          </div>
        </div>
        
        <div class="header-actions">
          <!-- Language button -->
          <button class="lang-toggle-btn" @click="showLangSheet = true">
            {{ currentLangObj.flag }} {{ currentLangObj.name }}
          </button>

          <!-- Cart button -->
          <button class="cart-trigger-btn" @click="router.push('/checkout')">
            🛒 <span class="cart-count" v-if="store.state.cart.length > 0">{{ store.state.cart.length }}</span>
          </button>
          
          <button class="exit-btn" @click="showExitConfirm = true">✕</button>
        </div>
      </div>
    </header>

    <!-- Search Area -->
    <section class="search-section">
      <div class="search-box">
        <input 
          type="text" 
          v-model="searchQuery" 
          :placeholder="t.searchPlaceholder" 
          class="vintage-input"
        />
      </div>
    </section>

    <!-- Genre Segment Picker -->
    <section class="genre-selector">
      <div class="tabs-container">
        <button 
          v-for="cat in BOOK_CATEGORIES" 
          :key="cat"
          class="genre-tab" 
          :class="{ active: selectedCategory === cat }"
          @click="selectedCategory = cat"
        >
          {{ cat === 'All' ? t.allCategories : cat }}
        </button>
      </div>
    </section>

    <!-- Cozy Curated Book Display Stand -->
    <main class="book-stand">
      <div class="bookshelf-title">
        <h2>Curated Collection</h2>
        <div class="flourish">❦</div>
      </div>

      <div class="book-grid">
        <div 
          v-for="book in filteredBooks" 
          :key="book.id" 
          class="book-card"
          @click="router.push(`/book/${book.id}`)"
        >
          <div class="book-cover-container">
            <img :src="book.coverUrl" :alt="book.title" class="book-cover" />
            <div class="book-format-badges">
              <span v-for="fmt in book.formats" :key="fmt" class="format-badge">
                {{ fmt }}
              </span>
            </div>
          </div>
          <div class="book-info">
            <span class="book-genre">{{ book.category }}</span>
            <h3 class="book-title">{{ book.title }}</h3>
            <p class="book-author">by {{ book.author }}</p>
            <div class="book-footer">
              <span class="book-price">${{ book.price.toFixed(2) }}</span>
              <span class="book-rating">★ {{ book.rating }}</span>
            </div>
          </div>
        </div>
      </div>
    </main>

    <!-- Language Selector Bottom Sheet -->
    <PPBottomSheet v-model="showLangSheet" :title="t.selectLanguage">
      <div class="sheet-desc">{{ t.languageSubtitle }}</div>
      <div class="lang-list">
        <button 
          v-for="lang in supportedLanguages" 
          :key="lang.code"
          class="lang-item" 
          @click="changeLang(lang.code)"
        >
          <span class="lang-flag">{{ lang.flag }}</span>
          <div class="lang-names">
            <span class="lang-main">{{ lang.name }}</span>
            <span class="lang-sub">{{ lang.subname }}</span>
          </div>
          <span class="check-icon" v-if="currentLanguage === lang.code">✓</span>
        </button>
      </div>
    </PPBottomSheet>

    <!-- Exit App Confirmation -->
    <PPConfirm
      v-model="showExitConfirm"
      :title="t.exitTitle"
      :message="t.exitMessage"
      :confirmText="t.yesExit"
      :cancelText="t.stay"
      @confirm="confirmExit"
    />
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import { useRouter } from 'vue-router'
import { PPBottomSheet, PPConfirm } from '@phanna/ui-framework'
import { BOOK_CATEGORIES, BOOK_DATABASE } from '../data/bookData'
import { useBookStore } from '../store/bookStore'
import { useI18n } from '../i18n'
import '@/lib/mini.app.lib.js'

const router = useRouter()
const MiniApp = (window as any).MiniApp
const store = useBookStore()
const { t, currentLanguage, currentLangObj, supportedLanguages, setLanguage } = useI18n()

const showLangSheet = ref(false)
const showExitConfirm = ref(false)
const searchQuery = ref('')
const selectedCategory = ref('All')

const filteredBooks = computed(() => {
  return BOOK_DATABASE.filter(book => {
    const matchesSearch = 
      book.title.toLowerCase().includes(searchQuery.value.toLowerCase()) ||
      book.author.toLowerCase().includes(searchQuery.value.toLowerCase()) ||
      book.category.toLowerCase().includes(searchQuery.value.toLowerCase())
    
    const matchesCategory = selectedCategory.value === 'All' || book.category === selectedCategory.value
    
    return matchesSearch && matchesCategory
  })
})

const changeLang = (langCode: any) => {
  setLanguage(langCode)
  showLangSheet.value = false
}

const confirmExit = () => {
  if (MiniApp?.exit) MiniApp.exit(false)
  else window.history.back()
}
</script>

<style scoped>
.catalog-view {
  min-height: 100vh;
  background-color: #FAF7F2;
  color: #26211C;
  padding-bottom: 40px;
}

.store-header {
  background-color: #26211C;
  color: #FAF7F2;
  padding: 16px 20px;
  border-bottom: 4px solid #8A3535;
}

.header-container {
  max-width: 800px;
  margin: 0 auto;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.logo-area {
  display: flex;
  align-items: center;
  gap: 12px;
}

.logo-icon {
  font-size: 2.2rem;
}

.store-title {
  font-size: 1.4rem;
  font-weight: 700;
  letter-spacing: 0.5px;
}

.store-subtitle {
  font-size: 0.75rem;
  color: #c9bdae;
  font-style: italic;
  font-family: 'Playfair Display', serif;
}

.header-actions {
  display: flex;
  align-items: center;
  gap: 12px;
}

.lang-toggle-btn {
  background-color: #3b332c;
  color: #FAF7F2;
  border: 1px solid #4d433b;
  padding: 6px 12px;
  border-radius: 20px;
  font-size: 0.85rem;
  cursor: pointer;
}

.cart-trigger-btn {
  background-color: #8A3535;
  color: #fff;
  border: none;
  width: 36px;
  height: 36px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  position: relative;
  font-size: 1.1rem;
}

.cart-count {
  position: absolute;
  top: -4px;
  right: -4px;
  background-color: #2D4A3E;
  color: #fff;
  font-size: 0.7rem;
  width: 18px;
  height: 18px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: bold;
}

.exit-btn {
  background: none;
  border: none;
  color: #FAF7F2;
  font-size: 1.4rem;
  cursor: pointer;
}

.search-section {
  padding: 20px;
  max-width: 800px;
  margin: 0 auto;
}

.vintage-input {
  width: 100%;
  padding: 12px 16px;
  border: 2px solid #e2dacd;
  background-color: #fff;
  color: #26211C;
  border-radius: 6px;
  font-family: inherit;
  font-size: 1rem;
  outline: none;
  box-shadow: inset 0 2px 4px rgba(0,0,0,0.02);
  transition: border-color 0.2s;
}

.vintage-input:focus {
  border-color: #8A3535;
}

.genre-selector {
  max-width: 800px;
  margin: 0 auto;
  padding: 0 20px;
  overflow-x: auto;
  scrollbar-width: none; /* Firefox */
}

.genre-selector::-webkit-scrollbar {
  display: none; /* Chrome, Safari, Opera */
}

.tabs-container {
  display: flex;
  gap: 8px;
  border-bottom: 2px solid #e2dacd;
  padding-bottom: 8px;
  min-width: max-content;
}

.genre-tab {
  background: none;
  border: none;
  padding: 8px 16px;
  font-family: 'Playfair Display', serif;
  font-size: 1rem;
  color: #706254;
  cursor: pointer;
  border-radius: 4px;
}

.genre-tab.active {
  color: #8A3535;
  font-weight: bold;
  background-color: #e2dacd;
}

.book-stand {
  max-width: 800px;
  margin: 32px auto 0 auto;
  padding: 0 20px;
}

.bookshelf-title {
  text-align: center;
  margin-bottom: 24px;
}

.bookshelf-title h2 {
  font-size: 1.8rem;
  color: #26211C;
}

.flourish {
  color: #8A3535;
  font-size: 1.4rem;
  margin-top: 4px;
}

.book-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(160px, 1fr));
  gap: 24px;
}

.book-card {
  background-color: #fff;
  border: 1px solid #e2dacd;
  border-radius: 6px;
  overflow: hidden;
  box-shadow: 0 4px 12px rgba(0,0,0,0.03);
  cursor: pointer;
  transition: transform 0.2s, box-shadow 0.2s;
}

.book-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 8px 20px rgba(138, 53, 53, 0.08);
}

.book-cover-container {
  position: relative;
  aspect-ratio: 2/3;
  background-color: #f5f2eb;
  box-shadow: inset -3px 0 10px rgba(0,0,0,0.1);
}

.book-cover-container::after {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: linear-gradient(to right, rgba(0,0,0,0.2) 0%, rgba(0,0,0,0) 6%, rgba(255,255,255,0.08) 9%, rgba(0,0,0,0) 14%);
  pointer-events: none;
}

.book-cover {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.book-format-badges {
  position: absolute;
  bottom: 8px;
  left: 8px;
  display: flex;
  flex-wrap: wrap;
  gap: 4px;
}

.format-badge {
  background-color: rgba(38, 33, 28, 0.85);
  color: #fff;
  font-size: 0.6rem;
  padding: 2px 6px;
  border-radius: 3px;
  font-weight: 500;
}

.book-info {
  padding: 12px;
}

.book-genre {
  font-size: 0.7rem;
  text-transform: uppercase;
  color: #8A3535;
  font-weight: 700;
  letter-spacing: 0.5px;
}

.book-title {
  font-family: 'Playfair Display', serif;
  font-size: 1rem;
  color: #26211C;
  margin: 4px 0;
  line-height: 1.3;
}

.book-author {
  font-size: 0.8rem;
  color: #706254;
  margin-bottom: 8px;
}

.book-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  border-top: 1px dashed #e2dacd;
  padding-top: 8px;
}

.book-price {
  font-weight: 700;
  color: #2D4A3E;
}

.book-rating {
  font-size: 0.8rem;
  color: #e5a93b;
}

.sheet-desc {
  font-size: 0.9rem;
  color: #706254;
  margin-bottom: 16px;
  text-align: center;
}

.lang-list {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.lang-item {
  display: flex;
  align-items: center;
  padding: 12px;
  border: 1px solid #e2dacd;
  background-color: #fff;
  border-radius: 8px;
  cursor: pointer;
  text-align: left;
}

.lang-flag {
  font-size: 1.5rem;
  margin-right: 12px;
}

.lang-names {
  flex: 1;
  display: flex;
  flex-direction: column;
}

.lang-main {
  font-weight: 600;
}

.lang-sub {
  font-size: 0.8rem;
  color: #706254;
}

.check-icon {
  color: #2D4A3E;
  font-weight: bold;
}

@media (max-width: 600px) {
  .store-header {
    padding: 10px 12px;
  }
  .logo-icon {
    font-size: 1.6rem;
  }
  .store-title {
    font-size: 1.1rem;
    line-height: 1.2;
  }
  .store-subtitle {
    display: none;
  }
  .header-actions {
    gap: 6px;
  }
  .lang-toggle-btn {
    padding: 4px 8px;
    font-size: 0.75rem;
  }
  .cart-trigger-btn {
    width: 30px;
    height: 30px;
    font-size: 0.9rem;
  }
  .cart-count {
    width: 15px;
    height: 15px;
    font-size: 0.6rem;
    top: -3px;
    right: -3px;
  }
  .exit-btn {
    font-size: 1.1rem;
    padding: 0 4px;
  }
  .search-section {
    padding: 12px;
  }
  .vintage-input {
    padding: 10px 12px;
    font-size: 0.9rem;
  }
  .genre-selector {
    padding: 0 12px;
  }
  .genre-tab {
    padding: 6px 12px;
    font-size: 0.9rem;
  }
  .book-grid {
    grid-template-columns: repeat(2, 1fr);
    gap: 16px;
  }
  .book-card {
    border-radius: 4px;
  }
  .book-info {
    padding: 10px;
  }
  .book-title {
    font-size: 0.9rem;
    height: 2.6rem;
    overflow: hidden;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
  }
  .book-author {
    font-size: 0.75rem;
    margin-bottom: 6px;
  }
  .book-footer {
    padding-top: 6px;
  }
  .book-price {
    font-size: 0.85rem;
  }
  .book-rating {
    font-size: 0.75rem;
  }
  .book-format-badges {
    display: none;
  }
}
</style>
