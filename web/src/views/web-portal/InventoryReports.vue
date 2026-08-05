<template>
  <ion-page>
    <ion-content>
      <div class="page-container">
        <div class="header-section">
          <div class="header-left">
            <h1 class="page-title">Inventory Reports</h1>
            <p class="page-subtitle">Monitor stock levels and identify products that need reordering.</p>
          </div>
          <div class="header-right">
            <PPButton variant="outline" color="danger">Download Low Stock CSV</PPButton>
          </div>
        </div>

        <!-- Table Section -->
        <PPTable
          :data="inventory"
          :columns="columns"
          rowKey="sku"
          :pagination="true"
          :page-size="10"
          hover
        >
          <template #stock="{ row }">
            <PPChip :color="getStockVariant(row.stock)" size="sm">
              {{ row.stock }} units
            </PPChip>
          </template>
          <template #actions="{ row }">
            <PPButton variant="outline" size="small">
              <template #iconLeft><ion-icon :icon="syncOutline" /></template>
              Reorder
            </PPButton>
          </template>
        </PPTable>
      </div>
    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { IonPage, IonContent, IonIcon } from '@ionic/vue';
import { PPTable, PPChip, PPButton } from '@phanna/ui-framework';
import { syncOutline } from 'ionicons/icons';

const columns = [
  { key: 'sku', title: 'SKU' },
  { key: 'product', title: 'Product Name' },
  { key: 'category', title: 'Category' },
  { key: 'stock', title: 'Current Stock' },
  { key: 'actions', title: '', align: 'right' as const }
];

const inventory = ref([
  { sku: 'HDPH-01', product: 'Wireless Noise-Canceling Headphones', category: 'Electronics', stock: 2 },
  { sku: 'KEYB-M2', product: 'Mechanical Keyboard (Red Switches)', category: 'Electronics', stock: 15 },
  { sku: 'MUG-CFE', product: 'Ceramic Coffee Mug', category: 'Home', stock: 0 },
  { sku: 'TSHT-BL', product: 'Basic Cotton T-Shirt (Black, L)', category: 'Clothing', stock: 120 },
]);

const getStockVariant = (stock: number) => {
  if (stock === 0) return 'danger';
  if (stock < 10) return 'warning';
  return 'success';
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
  .page-container {
    padding: 20px;
  }
}
</style>
