<template>
  <ion-page>
    <ion-content>
      <div class="page-container">
        <div class="header-section">
          <div class="header-left">
            <PPButton variant="ghost" @click="goBack" class="back-btn">
              &larr; Back to Orders
            </PPButton>
            <h1 class="page-title">Order #{{ orderId }}</h1>
            <p class="page-subtitle">Placed on Oct 24, 2023 at 10:23 AM</p>
          </div>
          <div class="header-right">
            <PPButton variant="primary">Fulfill Order</PPButton>
          </div>
        </div>

        <div class="content-grid">
          <!-- Left Column -->
          <div class="main-column">
            <!-- Order Status Timeline -->
            <div class="content-card">
              <h2 class="card-title">Order Journey</h2>
              <div class="timeline-container">
                <PPTimeline>
                  <PPTimelineItem timestamp="Oct 24, 10:23 AM" active type="primary">
                    <div class="timeline-title">Order Placed</div>
                    <div class="timeline-desc">Customer successfully placed the order.</div>
                  </PPTimelineItem>
                  <PPTimelineItem timestamp="Oct 24, 10:25 AM" active type="success">
                    <div class="timeline-title">Payment Confirmed</div>
                    <div class="timeline-desc">Credit card payment of $120.00 was successful.</div>
                  </PPTimelineItem>
                  <PPTimelineItem timestamp="Oct 24, 11:00 AM" active type="warning">
                    <div class="timeline-title">Processing</div>
                    <div class="timeline-desc">Order is being packed.</div>
                  </PPTimelineItem>
                  <PPTimelineItem timestamp="Pending" type="info">
                    <div class="timeline-title">Shipped</div>
                    <div class="timeline-desc">Order handed over to delivery partner.</div>
                  </PPTimelineItem>
                  <PPTimelineItem timestamp="Pending" type="info">
                    <div class="timeline-title">Delivered</div>
                    <div class="timeline-desc">Customer received the package.</div>
                  </PPTimelineItem>
                </PPTimeline>
              </div>
            </div>

            <!-- Ordered Items -->
            <div class="content-card">
              <h2 class="card-title">Items</h2>
              <PPTable
                :data="items"
                :columns="columns"
                rowKey="id"
              />
              <div class="order-totals">
                <div class="total-row"><span>Subtotal:</span> <span>$100.00</span></div>
                <div class="total-row"><span>Shipping:</span> <span>$20.00</span></div>
                <div class="total-row grand-total"><span>Total:</span> <span>$120.00</span></div>
              </div>
            </div>
          </div>

          <!-- Right Column -->
          <div class="side-column">
            <PPInfoCard title="Customer">
              <div class="info-content">
                <strong>John Doe</strong>
                <p>john.doe@example.com</p>
                <p>+1 234 567 890</p>
              </div>
            </PPInfoCard>

            <PPInfoCard title="Shipping Address" style="margin-top: 24px;">
              <div class="info-content">
                <p>123 Main Street</p>
                <p>Apt 4B</p>
                <p>New York, NY 10001</p>
                <p>United States</p>
              </div>
            </PPInfoCard>
          </div>
        </div>
      </div>
    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import { computed } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import { IonPage, IonContent } from '@ionic/vue';
import { PPButton, PPTimeline, PPTimelineItem, PPTable, PPInfoCard } from '@phanna/ui-framework';

const route = useRoute();
const router = useRouter();

const orderId = computed(() => route.params.id);

const columns = [
  { key: 'name', title: 'Product' },
  { key: 'price', title: 'Price' },
  { key: 'qty', title: 'Quantity' },
  { key: 'total', title: 'Total', align: 'right' as const }
];

const items = [
  { id: 1, name: 'Wireless Headphones', price: '$50.00', qty: 1, total: '$50.00' },
  { id: 2, name: 'Mechanical Keyboard', price: '$50.00', qty: 1, total: '$50.00' }
];

const goBack = () => {
  router.push('/web-portal/orders');
};
</script>

<style scoped>
ion-content {
  --background: transparent;
}

.page-container {
  padding: 40px;
  width: 100%;
}

.header-section {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 32px;
}

.back-btn {
  margin-bottom: 16px;
  margin-left: -16px;
}

.page-title {
  font-size: 28px;
  font-weight: 700;
  color: #1e293b;
  margin: 0 0 8px 0;
}

.page-subtitle {
  font-size: 15px;
  color: #64748b;
  margin: 0;
}

.content-grid {
  display: grid;
  grid-template-columns: 2fr 1fr;
  gap: 24px;
}

.content-card {
  background: white;
  border-radius: 16px;
  border: 1px solid #e2e8f0;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
  margin-bottom: 24px;
  padding: 24px;
}

.card-title {
  font-size: 18px;
  font-weight: 600;
  color: #334155;
  margin: 0 0 24px 0;
}

.timeline-container {
  padding-left: 16px;
}

.order-totals {
  margin-top: 24px;
  padding-top: 24px;
  border-top: 1px solid #e2e8f0;
  display: flex;
  flex-direction: column;
  gap: 12px;
  align-items: flex-end;
}

.total-row {
  display: flex;
  justify-content: space-between;
  width: 250px;
  color: #64748b;
}

.grand-total {
  font-weight: 700;
  color: #1e293b;
  font-size: 18px;
  border-top: 1px dashed #cbd5e1;
  padding-top: 12px;
}

.info-content p {
  margin: 0;
  color: #64748b;
  font-size: 14px;
}

.timeline-title {
  font-weight: 600;
  color: #1e293b;
  margin-bottom: 4px;
}

.timeline-desc {
  color: #64748b;
  font-size: 14px;
}

@media (max-width: 1024px) {
  .content-grid {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 768px) {
  .page-container {
    padding: 20px;
  }
}
</style>
