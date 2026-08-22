<script setup lang="ts">
import { useZooStore } from '../store/zooStore';
import { AVAILABLE_ADDONS } from '../data/tickets';
import { AddonItem } from '../types/zoo';

const store = useZooStore();

const getAddonQty = (addonId: string) => {
  return store.state.addonQuantities[addonId] || 0;
};

const incrementAddon = (addon: AddonItem) => {
  const current = getAddonQty(addon.id);
  store.setAddonQuantity(addon.id, current + 1);
};

const decrementAddon = (addon: AddonItem) => {
  const current = getAddonQty(addon.id);
  if (current > 0) {
    store.setAddonQuantity(addon.id, current - 1);
  }
};
</script>

<template>
  <div class="addons-grid">
    <div 
      v-for="addon in AVAILABLE_ADDONS" 
      :key="addon.id" 
      class="addon-card"
      :class="{ 'is-active': getAddonQty(addon.id) > 0 }"
    >
      <div class="addon-left">
        <div class="addon-icon-box">
          <span class="addon-icon">{{ addon.icon }}</span>
        </div>
        <div class="addon-details">
          <div class="addon-title-row">
            <h4 class="addon-name">{{ addon.name }}</h4>
            <span v-if="addon.recommendedFor" class="rec-badge">{{ addon.recommendedFor }}</span>
          </div>
          <p class="addon-desc">{{ addon.description }}</p>
          <div class="addon-price-tag">
            <span class="price-val">${{ addon.price.toFixed(2) }}</span>
            <span class="price-unit">/ {{ addon.unit }}</span>
          </div>
        </div>
      </div>

      <div class="addon-right">
        <div class="qty-counter">
          <button 
            type="button" 
            class="counter-btn minus-btn" 
            :disabled="getAddonQty(addon.id) <= 0"
            @click="decrementAddon(addon)"
          >
            -
          </button>
          <span class="counter-value">{{ getAddonQty(addon.id) }}</span>
          <button 
            type="button" 
            class="counter-btn plus-btn"
            @click="incrementAddon(addon)"
          >
            +
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.addons-grid {
  display: flex;
  flex-direction: column;
  gap: 0.9rem;
}

.addon-card {
  display: flex;
  align-items: center;
  justify-content: space-between;
  background: #ffffff;
  border-radius: 16px;
  padding: 1.1rem 1.25rem;
  border: 1.5px solid #e2e8f0;
  transition: all 0.2s ease;
  gap: 1rem;
}

.addon-card:hover {
  border-color: #94a3b8;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
}

.addon-card.is-active {
  border-color: #10b981;
  background-color: #f0fdf4;
}

.addon-left {
  display: flex;
  align-items: center;
  gap: 1rem;
  flex-grow: 1;
}

.addon-icon-box {
  width: 44px;
  height: 44px;
  border-radius: 12px;
  background: #f8fafc;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 22px;
  flex-shrink: 0;
  border: 1px solid #e2e8f0;
}

.addon-card.is-active .addon-icon-box {
  background: #ffffff;
}

.addon-details {
  display: flex;
  flex-direction: column;
  gap: 2px;
}

.addon-title-row {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  flex-wrap: wrap;
}

.addon-name {
  font-size: 0.975rem;
  font-weight: 700;
  color: #0f172a;
}

.rec-badge {
  font-size: 11px;
  font-weight: 700;
  color: #059669;
  background: #d1fae5;
  padding: 2px 8px;
  border-radius: 999px;
}

.addon-desc {
  font-size: 0.8rem;
  color: #64748b;
  margin: 2px 0 4px 0;
}

.addon-price-tag {
  display: flex;
  align-items: baseline;
  gap: 4px;
}

.price-val {
  font-family: 'Outfit', sans-serif;
  font-size: 1.1rem;
  font-weight: 800;
  color: #0f172a;
}

.price-unit {
  font-size: 0.75rem;
  color: #94a3b8;
}

.qty-counter {
  display: flex;
  align-items: center;
  background: #f1f5f9;
  border-radius: 999px;
  padding: 4px;
  gap: 6px;
}

.addon-card.is-active .qty-counter {
  background: #dcfce7;
}

.counter-btn {
  width: 30px;
  height: 30px;
  border-radius: 50%;
  border: none;
  background: #ffffff;
  color: #0f172a;
  font-size: 1.05rem;
  font-weight: 700;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.08);
  transition: all 0.15s ease;
}

.counter-btn:hover:not(:disabled) {
  background: #10b981;
  color: #ffffff;
}

.counter-btn:disabled {
  opacity: 0.35;
  cursor: not-allowed;
}

.counter-value {
  font-family: 'Outfit', sans-serif;
  font-weight: 700;
  font-size: 0.95rem;
  min-width: 20px;
  text-align: center;
  color: #0f172a;
}

@media (max-width: 600px) {
  .addon-card {
    flex-direction: column;
    align-items: flex-start;
  }
  .addon-right {
    width: 100%;
    display: flex;
    justify-content: flex-end;
  }
}
</style>
