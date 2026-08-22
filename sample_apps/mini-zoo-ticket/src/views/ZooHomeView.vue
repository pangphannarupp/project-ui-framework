<template>
  <div class="mini-zoo-app">
    <!-- Top Greeting Area with Language Selector and Exit -->
    <div class="greeting-area">
      <div class="top-row-header">
        <div class="user-greeting">
          <div class="zoo-avatar">🦁</div>
          <div class="chat-bubbles">
            <div class="bubble small">{{ t.appName }}</div>
            <div class="bubble large">{{ userName }}</div>
            <div class="bubble small" v-if="userPhone">{{ userPhone }}</div>
          </div>
        </div>

        <div class="header-right-actions">
          <!-- Passes Wallet Shortcut -->
          <button class="wallet-btn" @click="$router.push('/my-tickets')" aria-label="My Passes">
            <span>🎟️</span>
            <span v-if="confirmedTicketsCount > 0" class="wallet-count-badge">{{ confirmedTicketsCount }}</span>
          </button>

          <!-- Language Selector Button -->
          <button class="lang-switch-btn" @click="showLangSheet = true" aria-label="Change Language">
            <span class="flag-icon">{{ currentLangObj.flag }}</span>
            <span class="lang-text">{{ currentLangObj.name }}</span>
            <svg viewBox="0 0 24 24" width="14" height="14" stroke="currentColor" stroke-width="2.5" fill="none">
              <polyline points="6 9 12 15 18 9"></polyline>
            </svg>
          </button>

          <!-- Native MiniApp Exit button -->
          <button class="exit-icon-btn" @click="showExitConfirm = true" aria-label="Exit Mini App">
            <svg viewBox="0 0 24 24" width="18" height="18" stroke="currentColor" stroke-width="2.5" fill="none">
              <line x1="18" y1="6" x2="6" y2="18"></line>
              <line x1="6" y1="6" x2="18" y2="18"></line>
            </svg>
          </button>
        </div>
      </div>

      <!-- Visit Date & Slot Bar (Quick Kiosk selector) -->
      <div class="date-slot-strip">
        <div class="date-pill-select">
          <span class="strip-icon">📅</span>
          <select v-model="store.state.selectedVisitDate" class="strip-select">
            <option :value="todayStr">{{ t.today }} ({{ todayStr }})</option>
            <option :value="tomorrowStr">{{ t.tomorrow }} ({{ tomorrowStr }})</option>
            <option :value="weekendStr">{{ t.weekend }} ({{ weekendStr }})</option>
          </select>
        </div>

        <div class="date-pill-select slot-pill">
          <span class="strip-icon">⏰</span>
          <select v-model="store.state.selectedTimeSlot" class="strip-select">
            <option v-for="slot in TIME_SLOTS" :key="slot.id" :value="slot.label">
              {{ slot.icon }} {{ slot.label.split(' ')[0] }}
            </option>
          </select>
        </div>
      </div>

      <!-- Search Input -->
      <div class="search-box">
        <svg class="search-icon" viewBox="0 0 24 24" width="18" height="18" stroke="currentColor" stroke-width="2" fill="none">
          <circle cx="11" cy="11" r="8"></circle>
          <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
        </svg>
        <input v-model="searchQuery" :placeholder="t.searchPlaceholder" />
        <button v-if="searchQuery" class="clear-search-btn" @click="searchQuery = ''">✕</button>
      </div>
    </div>

    <!-- Category Tabs -->
    <div class="category-scroll">
      <button 
        v-for="catKey in categoriesList" 
        :key="catKey"
        class="category-chip"
        :class="{ active: selectedCategory === catKey }"
        @click="selectedCategory = catKey"
      >
        {{ t.categories[catKey] || catKey }}
      </button>
    </div>

    <!-- Main Tickets & Passes Grid -->
    <div class="products-container">
      <div class="tickets-grid" v-if="filteredTickets.length > 0">
        <div 
          v-for="ticket in filteredTickets" 
          :key="ticket.id"
          class="ticket-card"
          :style="{ '--tier-color': ticket.color }"
          @click="store.addTicket(ticket.id)"
        >
          <div class="card-top-tag">
            <span class="tag-emoji">{{ ticket.icon }}</span>
            <span v-if="ticket.badge" class="tag-pill">{{ ticket.badge }}</span>
          </div>

          <div class="ticket-center-info">
            <h4 class="ticket-title">{{ ticket.name }}</h4>
            <span class="ticket-age">{{ ticket.ageLimit }}</span>
            <p class="ticket-desc">{{ ticket.description }}</p>
          </div>

          <div class="ticket-bottom">
            <div class="price-col">
              <span class="price-val">${{ ticket.price.toFixed(2) }}</span>
              <span v-if="ticket.originalPrice" class="orig-price">${{ ticket.originalPrice.toFixed(2) }}</span>
            </div>

            <div class="action-btn-wrap">
              <div v-if="getTicketQty(ticket.id) > 0" class="qty-controller" @click.stop>
                <button class="mini-qty-btn" @click="store.removeTicket(ticket.id)">−</button>
                <span class="mini-qty-val">{{ getTicketQty(ticket.id) }}</span>
                <button class="mini-qty-btn" @click="store.addTicket(ticket.id)">+</button>
              </div>
              <button v-else class="add-btn" @click.stop="store.addTicket(ticket.id)">
                <svg viewBox="0 0 24 24" width="18" height="18" stroke="currentColor" stroke-width="2.5" fill="none">
                  <line x1="12" y1="5" x2="12" y2="19"></line>
                  <line x1="5" y1="12" x2="19" y2="12"></line>
                </svg>
              </button>
            </div>
          </div>
        </div>
      </div>

      <!-- No Result State -->
      <div v-else class="no-result">
        <div class="no-result-icon">🦁</div>
        <p>No tickets found matching "{{ searchQuery }}"</p>
      </div>

      <!-- Optional Addons Bar in Mini App -->
      <div class="addons-section-banner" v-if="selectedCategory === 'All'">
        <div class="addons-section-title">
          <span>✨ {{ t.specialAddons }}</span>
          <span class="addons-sub">Hop-on Tram, Animal Feeding, Photo Pass</span>
        </div>

        <div class="addons-horizontal-scroll">
          <div v-for="addon in AVAILABLE_ADDONS" :key="addon.id" class="addon-chip-card">
            <div class="addon-left">
              <span class="addon-emoji">{{ addon.icon }}</span>
              <div class="addon-text">
                <span class="addon-name">{{ addon.name }}</span>
                <span class="addon-price">${{ addon.price.toFixed(2) }} / {{ addon.unit }}</span>
              </div>
            </div>

            <div class="addon-action">
              <div v-if="getAddonQty(addon.id) > 0" class="qty-controller">
                <button class="mini-qty-btn" @click="store.removeAddon(addon.id)">−</button>
                <span class="mini-qty-val">{{ getAddonQty(addon.id) }}</span>
                <button class="mini-qty-btn" @click="store.addAddon(addon.id)">+</button>
              </div>
              <button v-else class="add-addon-btn" @click="store.addAddon(addon.id)">
                + Add
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Sticky Cart Summary Bar at Bottom (matching mini-pos style) -->
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
        <svg viewBox="0 0 24 24" width="20" height="20" stroke="currentColor" stroke-width="2" fill="none">
          <line x1="5" y1="12" x2="19" y2="12"></line>
          <polyline points="12 5 19 12 12 19"></polyline>
        </svg>
      </button>
    </div>

    <!-- 3-Language Selector Bottom Sheet (English / Khmer / Korean) -->
    <PPBottomSheet v-model="showLangSheet">
      <div class="zoo-lang-sheet">
        <div class="zoo-lang-header">
          <h3 class="zoo-lang-title">{{ t.selectLanguage }}</h3>
          <p class="zoo-lang-subtitle">{{ t.languageSubtitle }}</p>
        </div>

        <div class="zoo-lang-list">
          <div 
            v-for="lang in supportedLanguages" 
            :key="lang.code"
            class="zoo-lang-item"
            :class="{ 'is-active': currentLanguage === lang.code }"
            @click="onLanguageChange(lang.code)"
          >
            <div class="zoo-lang-left">
              <span class="zoo-lang-flag">{{ lang.flag }}</span>
              <div class="zoo-lang-name-wrap">
                <span class="zoo-lang-name">{{ lang.name }}</span>
                <span class="zoo-lang-subname">{{ lang.subname }}</span>
              </div>
            </div>
            <div class="zoo-lang-radio">
              <div class="radio-dot" v-if="currentLanguage === lang.code"></div>
            </div>
          </div>
        </div>
      </div>
    </PPBottomSheet>

    <!-- UI-Framework Confirmation Dialog for Exit App -->
    <PPConfirm
      v-model="showExitConfirm"
      :title="t.exitTitle"
      :message="t.exitMessage"
      :confirmText="t.yesExit"
      :cancelText="t.stay"
      confirmVariant="primary"
      @confirm="confirmExit"
    />
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import { PPBottomSheet, PPConfirm } from '@phanna/ui-framework'
import { useZooStore } from '../store/zooStore'
import { AVAILABLE_TICKETS, AVAILABLE_ADDONS, TIME_SLOTS } from '../data/tickets'
import { useI18n, LanguageCode } from '../i18n'
import '@/lib/mini.app.lib.js'

const MiniApp = (window as any).MiniApp
const store = useZooStore()
const { t, currentLanguage, currentLangObj, supportedLanguages, setLanguage } = useI18n()

const userName = ref('VISITOR GUEST')
const userPhone = ref('012 345 678')
const searchQuery = ref('')
const selectedCategory = ref('All')

const showLangSheet = ref(false)
const showExitConfirm = ref(false)

const todayStr = new Date().toISOString().split('T')[0]
const tomorrowStr = new Date(Date.now() + 86400000).toISOString().split('T')[0]
const weekendStr = new Date(Date.now() + 172800000).toISOString().split('T')[0]

const categoriesList = ['All', 'Standard', 'Combo', 'VIP', 'Night']

const confirmedTicketsCount = computed(() => {
  return store.state.bookedTickets.filter(b => b.status === 'CONFIRMED').length
})

onMounted(async () => {
  try {
    if (MiniApp && typeof MiniApp.getUserProfile === 'function') {
      const profile = await MiniApp.getUserProfile()
      if (profile) {
        if (profile.name) {
          userName.value = profile.name
          store.state.visitor.fullName = profile.name
        }
        if (profile.phoneNumber) {
          userPhone.value = profile.phoneNumber
          store.state.visitor.phone = profile.phoneNumber
        }
        if (profile.email) {
          store.state.visitor.email = profile.email
        }
      }
    }
  } catch (e) {
    console.warn('MiniApp profile error:', e)
  }
})

const filteredTickets = computed(() => {
  return AVAILABLE_TICKETS.filter(ticket => {
    // Category match
    let matchCat = true
    if (selectedCategory.value === 'Standard') matchCat = ticket.tier === 'standard' && ticket.category !== 'combo'
    else if (selectedCategory.value === 'Combo') matchCat = ticket.category === 'combo'
    else if (selectedCategory.value === 'VIP') matchCat = ticket.tier === 'vip-safari'
    else if (selectedCategory.value === 'Night') matchCat = ticket.tier === 'safari-night'

    // Search query match
    const q = searchQuery.value.toLowerCase().trim()
    const matchSearch = !q || ticket.name.toLowerCase().includes(q) || ticket.description.toLowerCase().includes(q)

    return matchCat && matchSearch
  })
})

const getTicketQty = (ticketId: string) => {
  return store.state.ticketQuantities[ticketId] || 0
}

const getAddonQty = (addonId: string) => {
  return store.state.addonQuantities[addonId] || 0
}

const onLanguageChange = (code: LanguageCode) => {
  setLanguage(code)
  showLangSheet.value = false
}

const confirmExit = () => {
  if (MiniApp && typeof MiniApp.exit === 'function') {
    MiniApp.exit(false)
  } else {
    window.history.back()
  }
}
</script>

<style scoped>
.mini-zoo-app {
  display: flex;
  flex-direction: column;
  min-height: 100vh;
  background-color: var(--zoo-bg);
  padding-bottom: 84px; /* Space for sticky bottom checkout */
}

/* Greeting Header Area */
.greeting-area {
  background-color: var(--zoo-card-bg);
  padding: 14px 16px 12px 16px;
  border-bottom: 1px solid #edf2f7;
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.top-row-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.user-greeting {
  display: flex;
  align-items: center;
  gap: 10px;
}

.zoo-avatar {
  font-size: 26px;
  background: linear-gradient(135deg, #10b981 0%, #047857 100%);
  width: 44px;
  height: 44px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 12px;
  box-shadow: 0 4px 10px rgba(16, 185, 129, 0.25);
}

.chat-bubbles {
  display: flex;
  flex-direction: column;
  gap: 1px;
}

.bubble.small {
  font-size: 11px;
  color: var(--text-secondary);
  font-weight: 500;
}

.bubble.large {
  font-size: 15px;
  font-weight: 800;
  color: var(--text-main);
  letter-spacing: -0.01em;
}

.header-right-actions {
  display: flex;
  align-items: center;
  gap: 8px;
}

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

.wallet-count-badge {
  position: absolute;
  top: -4px;
  right: -4px;
  background: #10b981;
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
  gap: 5px;
  background: #f1f5f9;
  border: 1px solid #e2e8f0;
  padding: 6px 10px;
  border-radius: 18px;
  font-size: 12px;
  font-weight: 600;
  color: var(--text-main);
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

/* Date & Slot Strip */
.date-slot-strip {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 8px;
}

.date-pill-select {
  background: #f8fafc;
  border: 1px solid #e2e8f0;
  border-radius: 10px;
  padding: 6px 8px;
  display: flex;
  align-items: center;
  gap: 6px;
}

.strip-icon {
  font-size: 14px;
}

.strip-select {
  background: transparent;
  border: none;
  font-size: 12px;
  font-weight: 700;
  color: var(--text-main);
  width: 100%;
  outline: none;
}

/* Search Box */
.search-box {
  position: relative;
  display: flex;
  align-items: center;
}

.search-box input {
  width: 100%;
  padding: 9px 34px 9px 36px;
  border-radius: 12px;
  border: 1.5px solid #e2e8f0;
  background-color: #f8fafc;
  font-size: 13px;
  outline: none;
}

.search-box input:focus {
  border-color: var(--zoo-primary);
  background-color: #ffffff;
}

.search-icon {
  position: absolute;
  left: 12px;
  color: var(--text-muted);
}

.clear-search-btn {
  position: absolute;
  right: 10px;
  background: #cbd5e1;
  border: none;
  border-radius: 50%;
  width: 18px;
  height: 18px;
  font-size: 10px;
  color: #ffffff;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
}

/* Category Chips */
.category-scroll {
  display: flex;
  gap: 8px;
  overflow-x: auto;
  padding: 10px 16px;
  background-color: var(--zoo-card-bg);
  border-bottom: 1px solid #edf2f7;
  scrollbar-width: none;
}
.category-scroll::-webkit-scrollbar {
  display: none;
}

.category-chip {
  padding: 6px 14px;
  border-radius: 18px;
  border: 1px solid #e2e8f0;
  background-color: #ffffff;
  color: var(--text-secondary);
  font-size: 13px;
  font-weight: 600;
  white-space: nowrap;
  cursor: pointer;
  transition: all 0.2s ease;
}

.category-chip.active {
  background-color: var(--zoo-primary);
  color: #ffffff;
  border-color: var(--zoo-primary);
  box-shadow: 0 2px 8px rgba(16, 185, 129, 0.3);
}

/* Tickets Grid */
.products-container {
  padding: 12px 16px;
  flex: 1;
}

.tickets-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
  gap: 12px;
}

.ticket-card {
  background: var(--zoo-card-bg);
  border-radius: 16px;
  padding: 14px;
  border: 1.5px solid #e2e8f0;
  display: flex;
  flex-direction: column;
  cursor: pointer;
  transition: all 0.2s ease;
  position: relative;
}

.ticket-card:hover {
  border-color: var(--tier-color, #10b981);
  box-shadow: 0 4px 14px rgba(0, 0, 0, 0.05);
}

.card-top-tag {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 8px;
}

.tag-emoji {
  font-size: 24px;
}

.tag-pill {
  font-size: 10px;
  font-weight: 800;
  background: var(--tier-color, #10b981);
  color: white;
  padding: 2px 8px;
  border-radius: 999px;
  text-transform: uppercase;
}

.ticket-center-info {
  flex-grow: 1;
  margin-bottom: 10px;
}

.ticket-title {
  font-size: 14px;
  font-weight: 800;
  color: var(--text-main);
  margin-bottom: 2px;
}

.ticket-age {
  font-size: 11px;
  color: var(--text-secondary);
  font-weight: 600;
  display: block;
  margin-bottom: 4px;
}

.ticket-desc {
  font-size: 11.5px;
  color: #64748b;
  line-height: 1.35;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.ticket-bottom {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding-top: 8px;
  border-top: 1px solid #f1f5f9;
}

.price-col {
  display: flex;
  align-items: baseline;
  gap: 4px;
}

.price-val {
  font-size: 16px;
  font-weight: 900;
  color: var(--text-main);
}

.orig-price {
  font-size: 11px;
  color: var(--text-muted);
  text-decoration: line-through;
}

.action-btn-wrap {
  display: flex;
  align-items: center;
}

.add-btn {
  background: #ecfdf5;
  border: 1px solid #a7f3d0;
  color: var(--zoo-primary-dark);
  width: 32px;
  height: 32px;
  border-radius: 8px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
}

.qty-controller {
  display: flex;
  align-items: center;
  background: #f1f5f9;
  border-radius: 8px;
  padding: 2px;
  gap: 4px;
}

.mini-qty-btn {
  background: #ffffff;
  border: 1px solid #cbd5e1;
  border-radius: 6px;
  width: 26px;
  height: 26px;
  font-weight: 800;
  font-size: 14px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
}

.mini-qty-val {
  font-size: 12px;
  font-weight: 800;
  min-width: 18px;
  text-align: center;
}

/* Addons Section Banner */
.addons-section-banner {
  margin-top: 20px;
  background: #ffffff;
  border-radius: 16px;
  padding: 14px;
  border: 1px solid #e2e8f0;
}

.addons-section-title {
  display: flex;
  flex-direction: column;
  margin-bottom: 10px;
  font-weight: 800;
  font-size: 13px;
}

.addons-sub {
  font-size: 11px;
  color: var(--text-secondary);
  font-weight: 500;
}

.addons-horizontal-scroll {
  display: flex;
  gap: 10px;
  overflow-x: auto;
  padding-bottom: 4px;
}

.addon-chip-card {
  background: #f8fafc;
  border: 1px solid #e2e8f0;
  border-radius: 12px;
  padding: 10px 12px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 12px;
  min-width: 240px;
}

.addon-left {
  display: flex;
  align-items: center;
  gap: 8px;
}

.addon-emoji {
  font-size: 20px;
}

.addon-text {
  display: flex;
  flex-direction: column;
}

.addon-name {
  font-size: 12px;
  font-weight: 700;
  color: var(--text-main);
}

.addon-price {
  font-size: 11px;
  font-weight: 700;
  color: var(--zoo-primary-dark);
}

.add-addon-btn {
  background: #ffffff;
  border: 1px solid #cbd5e1;
  font-size: 11px;
  font-weight: 700;
  padding: 4px 8px;
  border-radius: 6px;
  cursor: pointer;
}

/* No result */
.no-result {
  text-align: center;
  padding: 40px 20px;
  color: var(--text-muted);
}
.no-result-icon {
  font-size: 40px;
  margin-bottom: 8px;
}

/* Sticky Bottom Checkout Bar (matching mini-pos) */
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
  box-shadow: 0 -4px 16px rgba(0, 0, 0, 0.08);
  z-index: 90;
}

.cart-info {
  display: flex;
  align-items: center;
  gap: 10px;
}

.items-count-badge {
  background: #ecfdf5;
  color: var(--zoo-primary-dark);
  font-size: 12px;
  font-weight: 800;
  padding: 6px 10px;
  border-radius: 8px;
}

.total-price-text {
  display: flex;
  flex-direction: column;
}

.total-price-text .label {
  font-size: 10px;
  color: var(--text-secondary);
}

.total-price-text .val {
  font-size: 16px;
  font-weight: 900;
  color: var(--text-main);
}

.checkout-btn {
  background: linear-gradient(135deg, #10b981 0%, #047857 100%);
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
  box-shadow: 0 4px 12px rgba(16, 185, 129, 0.3);
}

/* Language Sheet */
.zoo-lang-sheet {
  padding: 16px 20px 28px 20px;
}

.zoo-lang-header {
  margin-bottom: 16px;
}

.zoo-lang-title {
  font-size: 16px;
  font-weight: 800;
  margin: 0 0 4px 0;
}

.zoo-lang-subtitle {
  font-size: 12px;
  color: var(--text-secondary);
  margin: 0;
}

.zoo-lang-list {
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.zoo-lang-item {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 12px 14px;
  border-radius: 12px;
  border: 1.5px solid #e2e8f0;
  background: #ffffff;
  cursor: pointer;
}

.zoo-lang-item.is-active {
  border-color: var(--zoo-primary);
  background: #f0fdf4;
}

.zoo-lang-left {
  display: flex;
  align-items: center;
  gap: 12px;
}

.zoo-lang-flag {
  font-size: 24px;
}

.zoo-lang-name-wrap {
  display: flex;
  flex-direction: column;
}

.zoo-lang-name {
  font-size: 14px;
  font-weight: 700;
}

.zoo-lang-subname {
  font-size: 11px;
  color: var(--text-secondary);
}

.zoo-lang-radio {
  width: 20px;
  height: 20px;
  border-radius: 50%;
  border: 2px solid #cbd5e1;
  display: flex;
  align-items: center;
  justify-content: center;
}

.zoo-lang-item.is-active .zoo-lang-radio {
  border-color: var(--zoo-primary);
}

.radio-dot {
  width: 10px;
  height: 10px;
  border-radius: 50%;
  background: var(--zoo-primary);
}
</style>
