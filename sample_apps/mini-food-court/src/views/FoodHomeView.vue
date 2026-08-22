<template>
  <div class="food-home-view">
    <!-- Top Greeting Area -->
    <div class="greeting-area">
      <div class="top-row-header">
        <div class="user-greeting">
          <div class="food-avatar">🍜</div>
          <div class="chat-bubbles">
            <div class="bubble small">{{ t.appName }}</div>
            <div class="bubble large">{{ userName }}</div>
          </div>
        </div>

        <div class="header-right-actions">
          <button class="wallet-btn" @click="$router.push('/my-tickets')" aria-label="Orders">
            <span>📋</span>
            <span class="count-badge" v-if="store.state.orders.length > 0">{{ store.state.orders.length }}</span>
          </button>

          <button class="lang-switch-btn" @click="showLangSheet = true">
            <span>{{ currentLangObj.flag }}</span>
            <span>{{ currentLangObj.name }}</span>
          </button>

          <button class="exit-icon-btn" @click="showExitConfirm = true">
            <svg viewBox="0 0 24 24" width="18" height="18" stroke="currentColor" stroke-width="2.5" fill="none">
              <line x1="18" y1="6" x2="6" y2="18"></line>
              <line x1="6" y1="6" x2="18" y2="18"></line>
            </svg>
          </button>
        </div>
      </div>

      <!-- Dine In / Takeaway Segment -->
      <div class="order-mode-strip">
        <div class="mode-toggle">
          <button 
            class="mode-btn" 
            :class="{ active: store.state.orderType === 'DINE_IN' }"
            @click="store.state.orderType = 'DINE_IN'"
          >
            🍽️ {{ t.dineIn }}
          </button>
          <button 
            class="mode-btn" 
            :class="{ active: store.state.orderType === 'TAKEAWAY' }"
            @click="store.state.orderType = 'TAKEAWAY'"
          >
            🛍️ {{ t.takeaway }}
          </button>
        </div>

        <div class="table-input-wrap" v-if="store.state.orderType === 'DINE_IN'">
          <span class="table-lbl">Table:</span>
          <input type="text" v-model="store.state.tableNumber" class="table-field" />
        </div>
      </div>

      <!-- Search Input using PPSearch -->
      <div class="search-box">
        <PPSearch v-model="searchQuery" :placeholder="t.searchPlaceholder" />
      </div>
    </div>

    <!-- Category Tabs -->
    <div class="category-scroll">
      <button 
        v-for="cat in FOOD_CATEGORIES" 
        :key="cat"
        class="category-chip"
        :class="{ active: selectedCategory === cat }"
        @click="selectedCategory = cat"
      >
        {{ cat }}
      </button>
    </div>

    <!-- Food Items Grid -->
    <div class="products-container">
      <div class="products-grid" v-if="filteredItems.length > 0">
        <div 
          v-for="food in filteredItems" 
          :key="food.id"
          class="food-card"
          @click="store.addToCart(food)"
        >
          <div class="img-wrapper">
            <img :src="food.imageUrl" :alt="getFoodName(food)" loading="lazy" />
            <span class="time-tag">⏱️ {{ food.prepTime }}</span>
            <span v-if="store.getItemQuantity(food.id) > 0" class="qty-badge">
              {{ store.getItemQuantity(food.id) }}
            </span>
          </div>

          <div class="food-info">
            <h4 class="food-title">{{ getFoodName(food) }}</h4>
            <p class="food-desc">{{ food.description }}</p>
            <div class="food-bottom">
              <span class="food-price">${{ food.price.toFixed(2) }}</span>
              <button class="add-btn" @click.stop="store.addToCart(food)">+</button>
            </div>
          </div>
        </div>
      </div>

      <div v-else class="no-result">
        <p>No dishes found for "{{ searchQuery }}"</p>
      </div>
    </div>

    <!-- Sticky Bottom Cart Bar -->
    <div class="bottom-checkout-bar" v-if="store.totalCount.value > 0">
      <div class="cart-info">
        <div class="items-count-badge">
          <span>{{ store.totalCount.value }} {{ t.items }}</span>
        </div>
        <div class="total-price-text">
          <span class="label">{{ t.total }}:</span>
          <span class="val">${{ store.grandTotal.value.toFixed(2) }}</span>
        </div>
      </div>
      <button class="checkout-btn" @click="$router.push('/checkout')">
        <span>{{ t.reviewAndPay }}</span>
        <svg viewBox="0 0 24 24" width="18" height="18" stroke="currentColor" stroke-width="2" fill="none">
          <line x1="5" y1="12" x2="19" y2="12"></line>
          <polyline points="12 5 19 12 12 19"></polyline>
        </svg>
      </button>
    </div>

    <!-- Language Sheet -->
    <PPBottomSheet v-model="showLangSheet">
      <div class="pos-lang-sheet">
        <h3>{{ t.selectLanguage }}</h3>
        <div class="lang-items-list">
          <div 
            v-for="l in supportedLanguages" 
            :key="l.code" 
            class="lang-item-row"
            :class="{ active: currentLanguage === l.code }"
            @click="setLanguage(l.code); showLangSheet = false"
          >
            <span>{{ l.flag }} {{ l.name }}</span>
            <div class="dot" v-if="currentLanguage === l.code"></div>
          </div>
        </div>
      </div>
    </PPBottomSheet>

    <!-- Exit confirm -->
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
import { ref, computed, onMounted } from 'vue'
import { PPBottomSheet, PPConfirm, PPSearch } from '@phanna/ui-framework'
import { useFoodStore } from '../store/foodStore'
import { FOOD_ITEMS, FOOD_CATEGORIES } from '../data/foodData'
import { useI18n } from '../i18n'
import type { FoodItem } from '../types/food'
import '@/lib/mini.app.lib.js'

const MiniApp = (window as any).MiniApp
const store = useFoodStore()
const { t, currentLanguage, currentLangObj, supportedLanguages, setLanguage } = useI18n()

const userName = ref('FOOD LOVER GUEST')
const searchQuery = ref('')
const selectedCategory = ref('All')
const showLangSheet = ref(false)
const showExitConfirm = ref(false)

onMounted(async () => {
  try {
    if (MiniApp && typeof MiniApp.getUserProfile === 'function') {
      const p = await MiniApp.getUserProfile()
      if (p?.name) userName.value = p.name
    }
  } catch (e) {}
})

const getFoodName = (food: FoodItem) => {
  const lang = currentLanguage.value
  return food.name[lang] || food.name.en
}

const filteredItems = computed(() => {
  return FOOD_ITEMS.filter(item => {
    const matchCat = selectedCategory.value === 'All' || item.category === selectedCategory.value
    const q = searchQuery.value.toLowerCase().trim()
    const name = getFoodName(item).toLowerCase()
    const matchSearch = !q || name.includes(q) || item.description.toLowerCase().includes(q)
    return matchCat && matchSearch
  })
})

const confirmExit = () => {
  if (MiniApp?.exit) MiniApp.exit(false)
  else window.history.back()
}
</script>

<style scoped>
.food-home-view {
  min-height: 100vh;
  background-color: #f8fafc;
  padding-bottom: 84px;
}

.greeting-area {
  background-color: #ffffff;
  padding: 14px 16px;
  border-bottom: 1px solid #edf2f7;
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.top-row-header { display: flex; justify-content: space-between; align-items: center; }
.user-greeting { display: flex; align-items: center; gap: 10px; }

.food-avatar {
  font-size: 24px;
  background: #f97316;
  width: 42px;
  height: 42px;
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
}

.bubble.small { font-size: 11px; color: #64748b; }
.bubble.large { font-size: 15px; font-weight: 800; }

.header-right-actions { display: flex; align-items: center; gap: 8px; }
.wallet-btn {
  position: relative;
  background: #f1f5f9;
  border: 1px solid #e2e8f0;
  border-radius: 10px;
  width: 36px;
  height: 36px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
}

.count-badge {
  position: absolute;
  top: -4px;
  right: -4px;
  background: #f97316;
  color: white;
  font-size: 10px;
  font-weight: 800;
  width: 16px;
  height: 16px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
}

.lang-switch-btn {
  display: flex;
  align-items: center;
  gap: 4px;
  background: #f1f5f9;
  border: 1px solid #e2e8f0;
  padding: 6px 10px;
  border-radius: 18px;
  font-size: 12px;
  cursor: pointer;
}

.exit-icon-btn {
  background: #fee2e2;
  border: none;
  color: #ef4444;
  width: 34px;
  height: 34px;
  border-radius: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
}

.order-mode-strip {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 8px;
}

.mode-toggle {
  display: flex;
  background: #f1f5f9;
  padding: 3px;
  border-radius: 10px;
  flex: 1;
}

.mode-btn {
  flex: 1;
  background: transparent;
  border: none;
  font-size: 11px;
  font-weight: 700;
  padding: 6px;
  border-radius: 8px;
  color: #64748b;
  cursor: pointer;
}

.mode-btn.active {
  background: #ffffff;
  color: #0f172a;
  box-shadow: 0 1px 4px rgba(0,0,0,0.08);
}

.table-input-wrap {
  display: flex;
  align-items: center;
  gap: 4px;
  background: #f8fafc;
  border: 1px solid #e2e8f0;
  padding: 4px 8px;
  border-radius: 8px;
}

.table-lbl { font-size: 11px; font-weight: 700; color: #64748b; }
.table-field { width: 44px; font-size: 12px; font-weight: 800; border: none; background: transparent; outline: none; }

.search-box {
  position: relative;
  display: flex;
  align-items: center;
}

.search-box input {
  width: 100%;
  padding: 8px 12px 8px 34px;
  border-radius: 10px;
  border: 1px solid #cbd5e1;
  font-size: 13px;
  outline: none;
}

.search-icon { position: absolute; left: 10px; color: #94a3b8; }

.category-scroll {
  display: flex;
  gap: 8px;
  padding: 10px 16px;
  background: #ffffff;
  border-bottom: 1px solid #edf2f7;
  overflow-x: auto;
}

.category-chip {
  padding: 6px 14px;
  border-radius: 18px;
  border: 1px solid #e2e8f0;
  background: #ffffff;
  color: #64748b;
  font-size: 12px;
  font-weight: 700;
  cursor: pointer;
  white-space: nowrap;
}

.category-chip.active {
  background: #f97316;
  color: white;
  border-color: #f97316;
}

.products-container { padding: 12px 16px; }

.products-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
  gap: 12px;
}

.food-card {
  background: #ffffff;
  border-radius: 16px;
  border: 1px solid #e2e8f0;
  overflow: hidden;
  display: flex;
  flex-direction: column;
  cursor: pointer;
}

.img-wrapper {
  position: relative;
  height: 120px;
}

.img-wrapper img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.time-tag {
  position: absolute;
  top: 6px;
  left: 6px;
  background: rgba(0,0,0,0.65);
  color: white;
  font-size: 10px;
  font-weight: 700;
  padding: 2px 6px;
  border-radius: 4px;
}

.qty-badge {
  position: absolute;
  top: 6px;
  right: 6px;
  background: #f97316;
  color: white;
  font-size: 11px;
  font-weight: 900;
  padding: 2px 8px;
  border-radius: 999px;
}

.food-info { padding: 10px 12px; flex: 1; display: flex; flex-direction: column; }
.food-title { font-size: 13px; font-weight: 800; margin: 0 0 2px 0; }
.food-desc { font-size: 11px; color: #64748b; margin-bottom: 8px; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; }

.food-bottom {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-top: auto;
  padding-top: 6px;
  border-top: 1px solid #f1f5f9;
}

.food-price { font-size: 15px; font-weight: 900; color: #f97316; }
.add-btn {
  background: #fff7ed;
  border: 1px solid #ffedd5;
  color: #ea580c;
  width: 28px;
  height: 28px;
  border-radius: 8px;
  font-weight: 900;
  font-size: 16px;
  cursor: pointer;
}

.bottom-checkout-bar {
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  background: #ffffff;
  border-top: 1px solid #e2e8f0;
  padding: 12px 16px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  z-index: 90;
}

.items-count-badge {
  background: #fff7ed;
  color: #ea580c;
  font-size: 11px;
  font-weight: 800;
  padding: 4px 8px;
  border-radius: 6px;
}

.total-price-text { display: flex; flex-direction: column; }
.total-price-text .label { font-size: 10px; color: #64748b; }
.total-price-text .val { font-size: 16px; font-weight: 900; color: #0f172a; }

.checkout-btn {
  background: linear-gradient(135deg, #f97316 0%, #ea580c 100%);
  color: #ffffff;
  border: none;
  padding: 10px 18px;
  border-radius: 12px;
  font-size: 14px;
  font-weight: 800;
  display: flex;
  align-items: center;
  gap: 6px;
  cursor: pointer;
}

.pos-lang-sheet { padding: 16px 20px 24px 20px; }
.lang-items-list { display: flex; flex-direction: column; gap: 8px; margin-top: 12px; }
.lang-item-row {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 10px;
  border-radius: 10px;
  border: 1px solid #e2e8f0;
  cursor: pointer;
}
.lang-item-row.active { border-color: #f97316; background: #fff7ed; }
.dot { width: 8px; height: 8px; border-radius: 50%; background: #f97316; }
</style>
