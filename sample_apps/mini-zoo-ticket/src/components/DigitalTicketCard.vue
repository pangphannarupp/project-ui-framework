<script setup lang="ts">
import { BookedTicketRecord } from '../types/zoo';

const props = defineProps<{
  booking: BookedTicketRecord;
}>();

const emit = defineEmits<{
  (e: 'show-scan-modal', booking: BookedTicketRecord): void;
}>();

const getStatusColor = (status: string) => {
  switch (status) {
    case 'CONFIRMED': return '#10b981';
    case 'USED': return '#64748b';
    case 'CANCELLED': return '#ef4444';
    default: return '#3b82f6';
  }
};
</script>

<template>
  <div class="e-ticket-container">
    <!-- Ticket Card Top Section -->
    <div class="ticket-header-strip">
      <div class="header-brand">
        <span class="header-logo">🦁</span>
        <div>
          <h4 class="brand-heading">WildSafari Pass</h4>
          <span class="booking-sub">ID: {{ booking.bookingCode }}</span>
        </div>
      </div>
      <div 
        class="status-pill" 
        :style="{ background: getStatusColor(booking.status) + '18', color: getStatusColor(booking.status), borderColor: getStatusColor(booking.status) }"
      >
        ● {{ booking.status }}
      </div>
    </div>

    <!-- Ticket Main Body -->
    <div class="ticket-body">
      <div class="guest-info-block">
        <div class="info-cell">
          <span class="cell-label">LEAD VISITOR</span>
          <span class="cell-val">{{ booking.visitor.fullName }}</span>
        </div>
        <div class="info-cell">
          <span class="cell-label">VISIT DATE</span>
          <span class="cell-val highlight-val">📅 {{ booking.visitDate }}</span>
        </div>
      </div>

      <div class="info-cell full-width">
        <span class="cell-label">ENTRY TIME SLOT</span>
        <span class="cell-val">{{ booking.timeSlot }}</span>
      </div>

      <div class="ticket-breakdown">
        <div class="breakdown-title">Items Included:</div>
        <div class="ticket-items-list">
          <div v-for="(t, idx) in booking.tickets" :key="'t-'+idx" class="item-tag">
            <span class="tag-qty">{{ t.quantity }}x</span>
            <span class="tag-name">{{ t.ticket.name }}</span>
          </div>
          <div v-for="(a, idx) in booking.addons" :key="'a-'+idx" class="item-tag addon-tag">
            <span class="tag-qty">{{ a.quantity }}x</span>
            <span class="tag-name">{{ a.addon.name }}</span>
          </div>
        </div>
      </div>
    </div>

    <!-- Perforation Cutout with Dotted Line -->
    <div class="ticket-perforation">
      <div class="cutout left-cutout"></div>
      <div class="dotted-line"></div>
      <div class="cutout right-cutout"></div>
    </div>

    <!-- Ticket Footer / QR Barcode Section -->
    <div class="ticket-barcode-section">
      <div class="qr-preview-box">
        <!-- Builtin UI Framework PPQRCode component -->
        <PPQRCode 
          :value="booking.qrValue"
          :size="130"
          foreground="#0f172a"
          background="#ffffff"
        />
      </div>
      <div class="qr-instructions">
        <span class="gate-hint">Show at Main Gate or Safari Turnstile</span>
        <span class="qr-code-text">{{ booking.id }}</span>
        <button 
          v-if="booking.status === 'CONFIRMED'" 
          type="button" 
          class="btn-simulate-scan"
          @click="emit('show-scan-modal', booking)"
        >
          🔍 Simulate Gate Scanner
        </button>
      </div>
    </div>
  </div>
</template>

<style scoped>
.e-ticket-container {
  background: #ffffff;
  border-radius: 24px;
  overflow: hidden;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
  border: 1px solid #e2e8f0;
  position: relative;
  transition: transform 0.2s ease;
}

.e-ticket-container:hover {
  transform: translateY(-2px);
  box-shadow: 0 14px 36px rgba(0, 0, 0, 0.12);
}

.ticket-header-strip {
  background: linear-gradient(135deg, #064e3b 0%, #047857 50%, #059669 100%);
  color: white;
  padding: 1.25rem 1.5rem;
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.header-brand {
  display: flex;
  align-items: center;
  gap: 0.75rem;
}

.header-logo {
  font-size: 28px;
  background: rgba(255, 255, 255, 0.15);
  width: 44px;
  height: 44px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 12px;
}

.brand-heading {
  font-family: 'Outfit', sans-serif;
  font-size: 1.15rem;
  font-weight: 800;
  margin: 0;
}

.booking-sub {
  font-size: 0.75rem;
  opacity: 0.85;
  letter-spacing: 0.05em;
}

.status-pill {
  font-size: 0.75rem;
  font-weight: 800;
  padding: 4px 10px;
  border-radius: 999px;
  border: 1px solid;
  letter-spacing: 0.05em;
}

.ticket-body {
  padding: 1.5rem;
  background: #ffffff;
}

.guest-info-block {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 1rem;
  margin-bottom: 1rem;
}

.info-cell {
  display: flex;
  flex-direction: column;
  gap: 2px;
}

.info-cell.full-width {
  margin-bottom: 1rem;
}

.cell-label {
  font-size: 0.7rem;
  font-weight: 800;
  color: #94a3b8;
  letter-spacing: 0.06em;
}

.cell-val {
  font-size: 0.95rem;
  font-weight: 700;
  color: #0f172a;
}

.highlight-val {
  color: #047857;
}

.ticket-breakdown {
  background: #f8fafc;
  border-radius: 12px;
  padding: 0.85rem 1rem;
  border: 1px dashed #cbd5e1;
}

.breakdown-title {
  font-size: 0.75rem;
  font-weight: 700;
  color: #64748b;
  margin-bottom: 6px;
}

.ticket-items-list {
  display: flex;
  flex-wrap: wrap;
  gap: 6px;
}

.item-tag {
  display: inline-flex;
  align-items: center;
  gap: 4px;
  background: #ffffff;
  border: 1px solid #e2e8f0;
  padding: 3px 8px;
  border-radius: 8px;
  font-size: 0.8rem;
}

.tag-qty {
  font-weight: 800;
  color: #059669;
}

.tag-name {
  color: #334155;
  font-weight: 600;
}

.item-tag.addon-tag {
  background: #fffbeb;
  border-color: #fde68a;
}

.item-tag.addon-tag .tag-qty {
  color: #d97706;
}

/* Perforation cutouts */
.ticket-perforation {
  position: relative;
  height: 20px;
  background: #ffffff;
  display: flex;
  align-items: center;
  justify-content: center;
}

.cutout {
  position: absolute;
  width: 24px;
  height: 24px;
  border-radius: 50%;
  background: #f1f5f9;
  border: 1px solid #e2e8f0;
}

.left-cutout {
  left: -12px;
}

.right-cutout {
  right: -12px;
}

.dotted-line {
  width: 86%;
  height: 1px;
  border-top: 2px dashed #cbd5e1;
}

/* QR and Barcode */
.ticket-barcode-section {
  padding: 1.25rem 1.5rem 1.5rem 1.5rem;
  background: #fafafa;
  display: flex;
  align-items: center;
  gap: 1.25rem;
}

.qr-preview-box {
  background: #ffffff;
  padding: 8px;
  border-radius: 12px;
  border: 1px solid #e2e8f0;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
}

.qr-instructions {
  display: flex;
  flex-direction: column;
  gap: 4px;
  flex-grow: 1;
}

.gate-hint {
  font-size: 0.8rem;
  color: #64748b;
  line-height: 1.3;
}

.qr-code-text {
  font-family: monospace;
  font-weight: 800;
  font-size: 1rem;
  color: #0f172a;
  letter-spacing: 0.1em;
}

.btn-simulate-scan {
  margin-top: 6px;
  background: #ffffff;
  border: 1px solid #059669;
  color: #059669;
  font-size: 0.8rem;
  font-weight: 700;
  padding: 5px 10px;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.2s ease;
  width: fit-content;
}

.btn-simulate-scan:hover {
  background: #059669;
  color: #ffffff;
}

@media (max-width: 500px) {
  .ticket-barcode-section {
    flex-direction: column;
    text-align: center;
  }
  .btn-simulate-scan {
    width: 100%;
  }
}
</style>
