<template>
  <ion-page>
    <ion-content>
      <div class="page-container">
        <div class="header-section">
          <div class="header-left">
            <h1 class="page-title">Orders</h1>
            <p class="page-subtitle">Manage customer orders and fulfillments.</p>
          </div>
          <div class="header-right">
            <PPSearch placeholder="Search by Order ID or Customer Name" style="width: 300px;" />
          </div>
        </div>

        <!-- Table Section -->
        <PPTable
          :data="orders"
          :columns="columns"
          rowKey="id"
          :pagination="true"
          :page-size="10"
          hover
        >
          <template #status="{ row }">
            <PPChip :color="getFulfillmentVariant(row.status)" size="sm">
              {{ row.status }}
            </PPChip>
          </template>
          <template #payment="{ row }">
            <PPChip :color="getPaymentVariant(row.payment)" size="sm">
              {{ row.payment }}
            </PPChip>
          </template>
          <template #actions="{ row }">
            <PPButton variant="outline" size="small" @click="viewOrder(row.id)">
              <template #iconLeft><ion-icon :icon="eyeOutline" /></template>
              View
            </PPButton>
          </template>
        </PPTable>
      </div>
    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import { IonPage, IonContent, IonIcon } from '@ionic/vue';
import { PPTable, PPChip, PPButton, PPSearch } from '@phanna/ui-framework';
import { eyeOutline } from 'ionicons/icons';

const router = useRouter();

const columns = [
  { key: 'id', title: 'Order ID' },
  { key: 'date', title: 'Date' },
  { key: 'customer', title: 'Customer' },
  { key: 'total', title: 'Total' },
  { key: 'payment', title: 'Payment' },
  { key: 'status', title: 'Fulfillment' },
  { key: 'actions', title: '', align: 'right' as const }
];

const orders = ref([
  { id: 'ORD-1001', date: 'Oct 24, 2023', customer: 'John Doe', total: '$120.00', payment: 'Paid', status: 'Shipped' },
  { id: 'ORD-1002', date: 'Oct 25, 2023', customer: 'Jane Smith', total: '$45.00', payment: 'Pending', status: 'Processing' },
  { id: 'ORD-1003', date: 'Oct 26, 2023', customer: 'Alice Johnson', total: '$210.50', payment: 'Failed', status: 'Cancelled' },
  { id: 'ORD-1004', date: 'Oct 26, 2023', customer: 'Bob Brown', total: '$89.99', payment: 'Paid', status: 'Delivered' },
]);

const getFulfillmentVariant = (status: string) => {
  switch (status) {
    case 'Shipped': return 'primary';
    case 'Processing': return 'warning';
    case 'Delivered': return 'success';
    case 'Cancelled': return 'danger';
    default: return 'default';
  }
};

const getPaymentVariant = (status: string) => {
  switch (status) {
    case 'Paid': return 'success';
    case 'Pending': return 'warning';
    case 'Failed': return 'danger';
    default: return 'default';
  }
};

const viewOrder = (id: string) => {
  router.push(`/web-portal/orders/${id}`);
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


@media (max-width: 768px) {
  .header-section {
    flex-direction: column;
    gap: 16px;
  }
  .header-right {
    width: 100%;
  }
  .header-right .pp-search {
    width: 100% !important;
  }
  .page-container {
    padding: 20px;
  }
}
</style>
