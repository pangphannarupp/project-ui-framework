<script setup lang="ts">
import { computed } from 'vue';
import { useRouter, useRoute } from 'vue-router';
import { useZooStore } from '../store/zooStore';

const route = useRoute();
const store = useZooStore();

const activeRouteName = computed(() => route.name as string);
const bookedCount = computed(() => store.state.bookedTickets.filter(b => b.status === 'CONFIRMED').length);
const currentCartTotalCount = computed(() => store.totalTicketsCount.value);
</script>

<template>
  <header class="zoo-navbar glass-panel">
    <div class="navbar-container">
      <!-- Brand Logo -->
      <div class="nav-brand" @click="router.push('/')">
        <div class="logo-badge">
          <span class="logo-emoji">🦁</span>
        </div>
        <div class="brand-text">
          <span class="brand-title">WildSafari</span>
          <span class="brand-sub">Mini Zoo & Eco Park</span>
        </div>
      </div>

      <!-- Navigation Links -->
      <nav class="nav-links">
        <button 
          class="nav-link" 
          :class="{ active: activeRouteName === 'home' }"
          @click="router.push('/')"
        >
          <span class="link-icon">🌿</span>
          <span>Home</span>
        </button>

        <button 
          class="nav-link" 
          :class="{ active: activeRouteName === 'attractions' }"
          @click="router.push('/attractions')"
        >
          <span class="link-icon">🗺️</span>
          <span>Attractions & Shows</span>
        </button>

        <button 
          class="nav-link" 
          :class="{ active: activeRouteName === 'book-tickets' || activeRouteName === 'checkout' }"
          @click="router.push('/book')"
        >
          <span class="link-icon">🎟️</span>
          <span>Tickets</span>
          <span v-if="currentCartTotalCount > 0" class="cart-pill">{{ currentCartTotalCount }}</span>
        </button>

        <button 
          class="nav-link" 
          :class="{ active: activeRouteName === 'my-tickets' }"
          @click="router.push('/my-tickets')"
        >
          <span class="link-icon">📱</span>
          <span>My Passes</span>
          <span v-if="bookedCount > 0" class="pass-count-badge">{{ bookedCount }}</span>
        </button>
      </nav>

      <!-- Action Button -->
      <div class="nav-actions">
        <button class="btn-book-now" @click="router.push('/book')">
          <span>⚡ Book Tickets</span>
          <span class="pulse-dot"></span>
        </button>
      </div>
    </div>
  </header>
</template>

<style scoped>
.zoo-navbar {
  position: sticky;
  top: 0;
  z-index: 999;
  border-bottom: 1px solid rgba(226, 232, 240, 0.8);
  box-shadow: 0 4px 20px -2px rgba(0, 0, 0, 0.05);
}

.navbar-container {
  max-width: 1240px;
  margin: 0 auto;
  padding: 0.75rem 1.25rem;
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 1rem;
}

.nav-brand {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  cursor: pointer;
  user-select: none;
}

.logo-badge {
  width: 44px;
  height: 44px;
  border-radius: 14px;
  background: linear-gradient(135deg, #10b981 0%, #047857 100%);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 24px;
  box-shadow: 0 4px 12px rgba(16, 185, 129, 0.3);
  transition: transform 0.2s ease;
}

.nav-brand:hover .logo-badge {
  transform: scale(1.06) rotate(-4deg);
}

.brand-text {
  display: flex;
  flex-direction: column;
}

.brand-title {
  font-family: 'Outfit', sans-serif;
  font-weight: 800;
  font-size: 1.25rem;
  line-height: 1.1;
  color: #0f172a;
  letter-spacing: -0.02em;
}

.brand-sub {
  font-size: 0.75rem;
  color: #059669;
  font-weight: 600;
}

.nav-links {
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.nav-link {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.5rem 0.9rem;
  border-radius: 10px;
  font-size: 0.9rem;
  font-weight: 600;
  color: #475569;
  background: transparent;
  border: none;
  cursor: pointer;
  transition: all 0.2s ease;
  position: relative;
}

.nav-link:hover {
  color: #0f172a;
  background-color: rgba(241, 245, 249, 0.8);
}

.nav-link.active {
  color: #047857;
  background-color: #ecfdf5;
}

.link-icon {
  font-size: 1.1rem;
}

.cart-pill {
  background-color: #f59e0b;
  color: #ffffff;
  font-size: 11px;
  font-weight: 700;
  padding: 1px 7px;
  border-radius: 999px;
}

.pass-count-badge {
  background-color: #10b981;
  color: #ffffff;
  font-size: 11px;
  font-weight: 700;
  padding: 1px 7px;
  border-radius: 999px;
}

.nav-actions {
  display: flex;
  align-items: center;
}

.btn-book-now {
  background: linear-gradient(135deg, #10b981 0%, #059669 100%);
  color: white;
  border: none;
  font-weight: 700;
  font-size: 0.9rem;
  padding: 0.6rem 1.25rem;
  border-radius: 999px;
  display: flex;
  align-items: center;
  gap: 0.5rem;
  cursor: pointer;
  box-shadow: 0 4px 14px rgba(16, 185, 129, 0.35);
  transition: all 0.2s ease;
}

.btn-book-now:hover {
  transform: translateY(-2px);
  box-shadow: 0 6px 18px rgba(16, 185, 129, 0.45);
}

.pulse-dot {
  width: 8px;
  height: 8px;
  background-color: #fef08a;
  border-radius: 50%;
  animation: pulse 1.8s infinite;
}

@keyframes pulse {
  0% { transform: scale(0.95); box-shadow: 0 0 0 0 rgba(254, 240, 138, 0.7); }
  70% { transform: scale(1.1); box-shadow: 0 0 0 6px rgba(254, 240, 138, 0); }
  100% { transform: scale(0.95); box-shadow: 0 0 0 0 rgba(254, 240, 138, 0); }
}

@media (max-width: 768px) {
  .nav-links {
    display: none;
  }
  .brand-sub {
    display: none;
  }
}
</style>
