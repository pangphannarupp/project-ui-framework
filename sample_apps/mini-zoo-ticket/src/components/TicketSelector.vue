<script setup lang="ts">
import { useZooStore } from '../store/zooStore';
import { AVAILABLE_TICKETS } from '../data/tickets';
import { TicketType } from '../types/zoo';

const store = useZooStore();

const getQty = (ticketId: string) => {
  return store.state.ticketQuantities[ticketId] || 0;
};

const increment = (ticket: TicketType) => {
  const current = getQty(ticket.id);
  store.setTicketQuantity(ticket.id, current + 1);
};

const decrement = (ticket: TicketType) => {
  const current = getQty(ticket.id);
  if (current > 0) {
    store.setTicketQuantity(ticket.id, current - 1);
  }
};
</script>

<template>
  <div class="tickets-grid">
    <div 
      v-for="ticket in AVAILABLE_TICKETS" 
      :key="ticket.id" 
      class="ticket-card"
      :class="{ 'has-selected': getQty(ticket.id) > 0 }"
      :style="{ '--ticket-accent': ticket.color }"
    >
      <!-- Badge if available -->
      <div v-if="ticket.badge" class="ticket-badge">
        {{ ticket.badge }}
      </div>

      <div class="card-header">
        <div class="ticket-icon-box">
          <span class="ticket-icon">{{ ticket.icon }}</span>
        </div>
        <div class="ticket-header-info">
          <h3 class="ticket-name">{{ ticket.name }}</h3>
          <span class="ticket-limit">{{ ticket.ageLimit }}</span>
        </div>
      </div>

      <p class="ticket-desc">{{ ticket.description }}</p>

      <!-- Features list -->
      <ul class="ticket-features">
        <li v-for="(feat, idx) in ticket.features" :key="idx">
          <span class="check-icon">✓</span>
          <span>{{ feat }}</span>
        </li>
      </ul>

      <!-- Card Footer: Price & Spinner Counter -->
      <div class="card-footer">
        <div class="price-container">
          <span class="currency">$</span>
          <span class="amount">{{ ticket.price.toFixed(2) }}</span>
          <span v-if="ticket.originalPrice" class="original-price">${{ ticket.originalPrice.toFixed(2) }}</span>
        </div>

        <div class="qty-counter">
          <button 
            type="button" 
            class="counter-btn minus-btn" 
            :disabled="getQty(ticket.id) <= 0"
            @click="decrement(ticket)"
          >
            -
          </button>
          <span class="counter-value">{{ getQty(ticket.id) }}</span>
          <button 
            type="button" 
            class="counter-btn plus-btn"
            @click="increment(ticket)"
          >
            +
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.tickets-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
  gap: 1.5rem;
}

.ticket-card {
  position: relative;
  background: #ffffff;
  border-radius: 20px;
  padding: 1.5rem;
  border: 2px solid #f1f5f9;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.04);
  transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
  display: flex;
  flex-direction: column;
}

.ticket-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 12px 28px rgba(0, 0, 0, 0.08);
  border-color: #cbd5e1;
}

.ticket-card.has-selected {
  border-color: var(--ticket-accent);
  background: linear-gradient(180deg, rgba(255, 255, 255, 1) 0%, rgba(248, 250, 252, 0.7) 100%);
  box-shadow: 0 8px 24px rgba(16, 185, 129, 0.15);
}

.ticket-badge {
  position: absolute;
  top: 14px;
  right: 14px;
  background: var(--ticket-accent);
  color: white;
  font-size: 11px;
  font-weight: 800;
  text-transform: uppercase;
  padding: 4px 10px;
  border-radius: 999px;
  letter-spacing: 0.05em;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
}

.card-header {
  display: flex;
  align-items: center;
  gap: 0.85rem;
  margin-bottom: 0.75rem;
}

.ticket-icon-box {
  width: 48px;
  height: 48px;
  border-radius: 14px;
  background: #f8fafc;
  border: 1px solid #e2e8f0;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 24px;
  flex-shrink: 0;
}

.ticket-header-info {
  display: flex;
  flex-direction: column;
  padding-right: 2rem;
}

.ticket-name {
  font-size: 1.15rem;
  font-weight: 700;
  color: #0f172a;
  line-height: 1.25;
}

.ticket-limit {
  font-size: 0.8rem;
  color: #64748b;
  font-weight: 500;
}

.ticket-desc {
  font-size: 0.875rem;
  color: #475569;
  line-height: 1.45;
  margin-bottom: 1rem;
  min-height: 38px;
}

.ticket-features {
  list-style: none;
  display: flex;
  flex-direction: column;
  gap: 0.45rem;
  margin-bottom: 1.5rem;
  flex-grow: 1;
}

.ticket-features li {
  display: flex;
  align-items: flex-start;
  gap: 0.5rem;
  font-size: 0.825rem;
  color: #334155;
  line-height: 1.35;
}

.check-icon {
  color: #10b981;
  font-weight: 800;
  font-size: 0.85rem;
  flex-shrink: 0;
}

.card-footer {
  display: flex;
  align-items: center;
  justify-content: space-between;
  border-top: 1px solid #f1f5f9;
  padding-top: 1rem;
  margin-top: auto;
}

.price-container {
  display: flex;
  align-items: baseline;
  gap: 2px;
}

.currency {
  font-size: 1rem;
  font-weight: 700;
  color: #0f172a;
}

.amount {
  font-family: 'Outfit', sans-serif;
  font-size: 1.6rem;
  font-weight: 800;
  color: #0f172a;
}

.original-price {
  font-size: 0.85rem;
  color: #94a3b8;
  text-decoration: line-through;
  margin-left: 6px;
}

.qty-counter {
  display: flex;
  align-items: center;
  background: #f1f5f9;
  border-radius: 999px;
  padding: 4px;
  gap: 6px;
}

.counter-btn {
  width: 32px;
  height: 32px;
  border-radius: 50%;
  border: none;
  background: #ffffff;
  color: #0f172a;
  font-size: 1.1rem;
  font-weight: 700;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
  transition: all 0.15s ease;
}

.counter-btn:hover:not(:disabled) {
  background: var(--ticket-accent, #10b981);
  color: #ffffff;
}

.counter-btn:disabled {
  opacity: 0.35;
  cursor: not-allowed;
}

.counter-value {
  font-family: 'Outfit', sans-serif;
  font-weight: 700;
  font-size: 1rem;
  min-width: 22px;
  text-align: center;
  color: #0f172a;
}
</style>
