<script setup lang="ts">
import { ref, computed } from 'vue';
import { useRouter } from 'vue-router';
import ZooHeader from '../components/ZooHeader.vue';
import TicketSelector from '../components/TicketSelector.vue';
import AddonSelector from '../components/AddonSelector.vue';
import { TIME_SLOTS } from '../data/tickets';
import { useZooStore } from '../store/zooStore';

const store = useZooStore();

const promoInput = ref('');
const showAddonsSection = ref(true);

const hasSelectedTickets = computed(() => store.totalTicketsCount.value > 0);

// Calendar shortcuts (Today, Tomorrow, Weekend)
const setQuickDate = (daysFromNow: number) => {
  const target = new Date(Date.now() + daysFromNow * 86400000);
  store.state.selectedVisitDate = target.toISOString().split('T')[0];
};

const handleApplyPromo = () => {
  if (!promoInput.value) return;
  store.applyPromoCode(promoInput.value);
};

const goToCheckout = () => {
  if (!hasSelectedTickets.value) {
    store.showToast('Please select at least 1 ticket to proceed', 'warning');
    return;
  }
  router.push('/checkout');
};
</script>

<template>
  <div class="booking-page">
    <ZooHeader />

    <!-- Booking Hero Banner -->
    <div class="booking-header-banner">
      <div class="max-container banner-content">
        <div>
          <span class="banner-tag">OFFICIAL TICKET DESK</span>
          <h1 class="banner-title">Select Tickets & Date</h1>
          <p class="banner-desc">Instant confirmation • Free mobile digital barcode passes • 100% Guaranteed admission</p>
        </div>
      </div>
    </div>

    <div class="max-container booking-layout">
      <!-- Left / Main Column: Steps Selection -->
      <div class="booking-steps-col">
        <!-- Step 1: Visit Date & Time Slot -->
        <section class="step-card">
          <div class="step-badge-row">
            <div class="step-number">1</div>
            <div>
              <h2 class="step-title">Select Visit Date & Entry Slot</h2>
              <span class="step-sub">Tickets valid for the selected date and time slot</span>
            </div>
          </div>

          <!-- Quick Date Pills -->
          <div class="date-quick-pills">
            <button 
              type="button" 
              class="quick-pill-btn"
              @click="setQuickDate(0)"
            >
              ⚡ Today
            </button>
            <button 
              type="button" 
              class="quick-pill-btn"
              @click="setQuickDate(1)"
            >
              📅 Tomorrow
            </button>
            <button 
              type="button" 
              class="quick-pill-btn"
              @click="setQuickDate(2)"
            >
              🎈 This Weekend
            </button>
          </div>

          <div class="date-time-grid">
            <!-- Native date picker styled nicely with UI Framework integration -->
            <div class="form-group">
              <label class="input-label">Visit Date (YYYY-MM-DD)</label>
              <div class="date-input-wrap">
                <span class="input-icon">📅</span>
                <input 
                  type="date" 
                  v-model="store.state.selectedVisitDate"
                  class="custom-date-field"
                  :min="new Date().toISOString().split('T')[0]"
                />
              </div>
            </div>

            <!-- Time slot selector -->
            <div class="form-group">
              <label class="input-label">Preferred Entry Window</label>
              <div class="slot-select-wrap">
                <span class="input-icon">⏰</span>
                <select v-model="store.state.selectedTimeSlot" class="custom-select-field">
                  <option v-for="slot in TIME_SLOTS" :key="slot.id" :value="slot.label">
                    {{ slot.icon }} {{ slot.label }}
                  </option>
                </select>
              </div>
            </div>
          </div>
        </section>

        <!-- Step 2: Choose Admission Passes -->
        <section class="step-card">
          <div class="step-badge-row">
            <div class="step-number">2</div>
            <div>
              <h2 class="step-title">Choose Admission Tickets</h2>
              <span class="step-sub">Select visitor passes suitable for your party</span>
            </div>
          </div>

          <TicketSelector />
        </section>

        <!-- Step 3: Add-on Experiences -->
        <section class="step-card">
          <div class="step-badge-row step-header-toggle" @click="showAddonsSection = !showAddonsSection">
            <div class="flex-align">
              <div class="step-number">3</div>
              <div>
                <h2 class="step-title">Add-on Safari Experiences (Optional)</h2>
                <span class="step-sub">Tram passes, feeding tokens, and photo packages</span>
              </div>
            </div>
            <button type="button" class="btn-toggle-accordion">
              {{ showAddonsSection ? '▲ Hide' : '▼ Expand' }}
            </button>
          </div>

          <div v-show="showAddonsSection" class="addons-content-wrap">
            <AddonSelector />
          </div>
        </section>
      </div>

      <!-- Right Column: Live Order Summary Card (Sticky) -->
      <div class="summary-col">
        <div class="summary-card glass-panel">
          <h3 class="summary-heading">Booking Summary</h3>

          <div class="summary-date-badge">
            <span>📅 {{ store.state.selectedVisitDate }}</span>
            <span class="summary-time">{{ store.state.selectedTimeSlot.split(' ')[0] }}</span>
          </div>

          <!-- Empty State -->
          <div v-if="!hasSelectedTickets" class="empty-summary-box">
            <span class="empty-icon">🎟️</span>
            <p class="empty-text">No tickets selected yet. Add passes from the list.</p>
          </div>

          <!-- Items List -->
          <div v-else class="summary-items-box">
            <!-- Tickets Breakdown -->
            <div class="summary-group-title">Admission Tickets ({{ store.totalTicketsCount.value }})</div>
            <div v-for="item in store.selectedTicketsList.value" :key="item.ticket.id" class="summary-item-row">
              <div class="item-name-col">
                <span class="item-qty">{{ item.quantity }}x</span>
                <span class="item-title">{{ item.ticket.name }}</span>
              </div>
              <span class="item-price">${{ (item.ticket.price * item.quantity).toFixed(2) }}</span>
            </div>

            <!-- Addons Breakdown -->
            <template v-if="store.selectedAddonsList.value.length > 0">
              <div class="summary-group-title addon-title">Special Add-ons</div>
              <div v-for="item in store.selectedAddonsList.value" :key="item.addon.id" class="summary-item-row">
                <div class="item-name-col">
                  <span class="item-qty addon-qty">{{ item.quantity }}x</span>
                  <span class="item-title">{{ item.addon.name }}</span>
                </div>
                <span class="item-price">${{ (item.addon.price * item.quantity).toFixed(2) }}</span>
              </div>
            </template>
          </div>

          <!-- Promo Code Section -->
          <div class="promo-input-box">
            <label class="promo-label">Have a Promo Voucher?</label>
            <div class="promo-row" v-if="!store.state.appliedPromoCode">
              <input 
                type="text" 
                v-model="promoInput" 
                placeholder="e.g. ZOOFUN10" 
                class="promo-field"
              />
              <button type="button" class="btn-apply-promo" @click="handleApplyPromo">
                Apply
              </button>
            </div>
            <div v-else class="promo-applied-tag">
              <div>
                <span class="promo-code-badge">{{ store.state.appliedPromoCode }}</span>
                <span class="promo-discount-text">(-{{ store.state.promoDiscountPercent }}%)</span>
              </div>
              <button type="button" class="btn-remove-promo" @click="store.removePromoCode">✕</button>
            </div>
            <div class="promo-hints">Try codes: <code>ZOOFUN10</code>, <code>SAFARI20</code></div>
          </div>

          <!-- Price Calculation Lines -->
          <div class="price-calculations">
            <div class="calc-row">
              <span>Subtotal</span>
              <span>${{ store.subtotal.value.toFixed(2) }}</span>
            </div>

            <div v-if="store.discountAmount.value > 0" class="calc-row discount-row">
              <span>Promo Discount ({{ store.state.promoDiscountPercent }}%)</span>
              <span>-${{ store.discountAmount.value.toFixed(2) }}</span>
            </div>

            <div class="calc-row">
              <span>VAT / Service Tax (10%)</span>
              <span>${{ store.taxAmount.value.toFixed(2) }}</span>
            </div>

            <div class="calc-divider"></div>

            <div class="calc-row total-row">
              <span class="total-label">Total Amount</span>
              <div class="total-amount-box">
                <span class="tot-curr">USD</span>
                <span class="tot-val">${{ store.grandTotal.value.toFixed(2) }}</span>
              </div>
            </div>
          </div>

          <!-- Checkout Button -->
          <button 
            type="button" 
            class="btn-proceed-checkout" 
            :disabled="!hasSelectedTickets"
            @click="goToCheckout"
          >
            <span>Proceed to Visitor Details & Pay</span>
            <span class="arrow-icon">→</span>
          </button>
          
          <p class="guarantee-note">🔒 SSL Encrypted • Instant Digital Pass Delivery</p>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.booking-page {
  min-height: 100vh;
  background-color: #f8fafc;
  padding-bottom: 5rem;
}

.max-container {
  max-width: 1240px;
  margin: 0 auto;
  padding: 0 1.25rem;
}

.booking-header-banner {
  background: linear-gradient(135deg, #064e3b 0%, #047857 60%, #0f172a 100%);
  color: white;
  padding: 2.5rem 0;
  margin-bottom: 2rem;
}

.banner-tag {
  font-size: 0.75rem;
  font-weight: 800;
  color: #34d399;
  letter-spacing: 0.1em;
  display: block;
  margin-bottom: 4px;
}

.banner-title {
  font-size: 2.2rem;
  font-weight: 900;
  margin-bottom: 0.5rem;
}

.banner-desc {
  font-size: 0.95rem;
  color: #cbd5e1;
}

.booking-layout {
  display: grid;
  grid-template-columns: 1fr 380px;
  gap: 2rem;
  align-items: flex-start;
}

.booking-steps-col {
  display: flex;
  flex-direction: column;
  gap: 2rem;
}

.step-card {
  background: #ffffff;
  border-radius: 24px;
  padding: 2rem;
  border: 1px solid #e2e8f0;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.03);
}

.step-badge-row {
  display: flex;
  align-items: center;
  gap: 1rem;
  margin-bottom: 1.5rem;
}

.step-header-toggle {
  cursor: pointer;
  justify-content: space-between;
  margin-bottom: 1rem;
}

.flex-align {
  display: flex;
  align-items: center;
  gap: 1rem;
}

.btn-toggle-accordion {
  background: #f1f5f9;
  border: none;
  font-weight: 700;
  font-size: 0.85rem;
  color: #475569;
  padding: 6px 12px;
  border-radius: 8px;
  cursor: pointer;
}

.step-number {
  width: 38px;
  height: 38px;
  border-radius: 12px;
  background: linear-gradient(135deg, #10b981 0%, #047857 100%);
  color: white;
  font-family: 'Outfit', sans-serif;
  font-size: 1.2rem;
  font-weight: 800;
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 0 4px 10px rgba(16, 185, 129, 0.3);
  flex-shrink: 0;
}

.step-title {
  font-size: 1.25rem;
  font-weight: 800;
  color: #0f172a;
}

.step-sub {
  font-size: 0.85rem;
  color: #64748b;
}

/* Date & Time Step */
.date-quick-pills {
  display: flex;
  gap: 0.6rem;
  margin-bottom: 1.25rem;
  flex-wrap: wrap;
}

.quick-pill-btn {
  background: #f1f5f9;
  border: 1px solid #e2e8f0;
  padding: 6px 14px;
  border-radius: 999px;
  font-size: 0.85rem;
  font-weight: 700;
  color: #334155;
  cursor: pointer;
  transition: all 0.15s ease;
}

.quick-pill-btn:hover {
  background: #e2e8f0;
}

.date-time-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 1.25rem;
}

.form-group {
  display: flex;
  flex-direction: column;
  gap: 6px;
}

.input-label {
  font-size: 0.825rem;
  font-weight: 700;
  color: #334155;
}

.date-input-wrap, .slot-select-wrap {
  position: relative;
  display: flex;
  align-items: center;
}

.input-icon {
  position: absolute;
  left: 12px;
  font-size: 1.1rem;
  pointer-events: none;
}

.custom-date-field, .custom-select-field {
  width: 100%;
  padding: 0.75rem 1rem 0.75rem 2.75rem;
  border-radius: 12px;
  border: 1.5px solid #cbd5e1;
  font-family: inherit;
  font-size: 0.95rem;
  font-weight: 600;
  color: #0f172a;
  background: #ffffff;
  outline: none;
  transition: border-color 0.2s ease;
}

.custom-date-field:focus, .custom-select-field:focus {
  border-color: #10b981;
  box-shadow: 0 0 0 3px rgba(16, 185, 129, 0.15);
}

/* Summary Card */
.summary-col {
  position: sticky;
  top: 80px;
}

.summary-card {
  border-radius: 24px;
  padding: 1.75rem;
  border: 1px solid #e2e8f0;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.06);
}

.summary-heading {
  font-size: 1.3rem;
  font-weight: 800;
  color: #0f172a;
  margin-bottom: 0.85rem;
}

.summary-date-badge {
  background: #ecfdf5;
  color: #047857;
  padding: 6px 12px;
  border-radius: 10px;
  font-size: 0.85rem;
  font-weight: 700;
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 1.25rem;
}

.empty-summary-box {
  background: #f8fafc;
  border: 1px dashed #cbd5e1;
  border-radius: 14px;
  padding: 1.5rem;
  text-align: center;
  margin-bottom: 1.25rem;
}

.empty-icon {
  font-size: 28px;
  display: block;
  margin-bottom: 6px;
}

.empty-text {
  font-size: 0.85rem;
  color: #64748b;
}

.summary-items-box {
  margin-bottom: 1.25rem;
}

.summary-group-title {
  font-size: 0.75rem;
  font-weight: 800;
  color: #64748b;
  text-transform: uppercase;
  margin-bottom: 6px;
  letter-spacing: 0.05em;
}

.summary-group-title.addon-title {
  margin-top: 10px;
}

.summary-item-row {
  display: flex;
  align-items: center;
  justify-content: space-between;
  font-size: 0.875rem;
  padding: 4px 0;
}

.item-name-col {
  display: flex;
  align-items: center;
  gap: 6px;
}

.item-qty {
  font-weight: 800;
  color: #10b981;
}

.item-qty.addon-qty {
  color: #d97706;
}

.item-title {
  color: #334155;
  font-weight: 600;
}

.item-price {
  font-weight: 700;
  color: #0f172a;
}

/* Promo Code Box */
.promo-input-box {
  background: #f8fafc;
  padding: 1rem;
  border-radius: 14px;
  margin-bottom: 1.25rem;
  border: 1px solid #e2e8f0;
}

.promo-label {
  font-size: 0.75rem;
  font-weight: 700;
  color: #475569;
  display: block;
  margin-bottom: 6px;
}

.promo-row {
  display: flex;
  gap: 6px;
}

.promo-field {
  flex-grow: 1;
  padding: 6px 10px;
  border-radius: 8px;
  border: 1px solid #cbd5e1;
  font-size: 0.85rem;
  font-weight: 700;
  text-transform: uppercase;
  outline: none;
}

.btn-apply-promo {
  background: #0f172a;
  color: white;
  border: none;
  font-weight: 700;
  padding: 6px 14px;
  border-radius: 8px;
  font-size: 0.8rem;
  cursor: pointer;
}

.promo-applied-tag {
  display: flex;
  align-items: center;
  justify-content: space-between;
  background: #ecfdf5;
  border: 1px solid #a7f3d0;
  padding: 6px 10px;
  border-radius: 8px;
}

.promo-code-badge {
  font-weight: 800;
  color: #047857;
  font-size: 0.85rem;
}

.promo-discount-text {
  font-size: 0.8rem;
  color: #059669;
  font-weight: 700;
  margin-left: 4px;
}

.btn-remove-promo {
  background: none;
  border: none;
  color: #ef4444;
  font-weight: 800;
  cursor: pointer;
  font-size: 0.9rem;
}

.promo-hints {
  font-size: 0.7rem;
  color: #94a3b8;
  margin-top: 6px;
}

.promo-hints code {
  background: #e2e8f0;
  padding: 1px 4px;
  border-radius: 4px;
  color: #0f172a;
}

/* Price Calculations */
.price-calculations {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
  margin-bottom: 1.5rem;
  font-size: 0.875rem;
  color: #64748b;
}

.calc-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.discount-row {
  color: #059669;
  font-weight: 700;
}

.calc-divider {
  height: 1px;
  background: #e2e8f0;
  margin: 6px 0;
}

.total-row {
  color: #0f172a;
  margin-top: 4px;
}

.total-label {
  font-weight: 800;
  font-size: 1rem;
}

.total-amount-box {
  display: flex;
  align-items: baseline;
  gap: 4px;
}

.tot-curr {
  font-size: 0.8rem;
  font-weight: 700;
  color: #64748b;
}

.tot-val {
  font-family: 'Outfit', sans-serif;
  font-size: 1.75rem;
  font-weight: 900;
  color: #0f172a;
}

.btn-proceed-checkout {
  width: 100%;
  background: linear-gradient(135deg, #10b981 0%, #047857 100%);
  color: white;
  border: none;
  font-size: 1rem;
  font-weight: 800;
  padding: 1rem;
  border-radius: 14px;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
  box-shadow: 0 6px 20px rgba(16, 185, 129, 0.35);
  transition: all 0.2s ease;
}

.btn-proceed-checkout:hover:not(:disabled) {
  transform: translateY(-2px);
  box-shadow: 0 10px 25px rgba(16, 185, 129, 0.45);
}

.btn-proceed-checkout:disabled {
  background: #cbd5e1;
  box-shadow: none;
  cursor: not-allowed;
}

.guarantee-note {
  font-size: 0.725rem;
  color: #94a3b8;
  text-align: center;
  margin-top: 0.85rem;
}

@media (max-width: 960px) {
  .booking-layout {
    grid-template-columns: 1fr;
  }
  .summary-col {
    position: static;
  }
}

@media (max-width: 600px) {
  .date-time-grid {
    grid-template-columns: 1fr;
  }
}
</style>
