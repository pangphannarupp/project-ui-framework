<template>
  <ion-page>
    <ion-content>
      <div class="page-container">
        <div class="header-section">
          <div class="header-left">
            <h1 class="page-title">Discounts & Coupons</h1>
            <p class="page-subtitle">Manage promotional campaigns and discount codes.</p>
          </div>
          <div class="header-right">
            <PPButton variant="primary">Create Discount</PPButton>
          </div>
        </div>

        <!-- Table Section -->
        <PPTable
          :data="discounts"
          :columns="columns"
          rowKey="code"
          :pagination="true"
          :page-size="10"
          hover
        >
          <template #status="{ row }">
            <PPChip :color="row.status === 'Active' ? 'success' : 'default'" size="sm">
              {{ row.status }}
            </PPChip>
          </template>
          <template #actions="{ row }">
            <div class="action-buttons">
              <PPButton variant="outline" size="small">
                <template #iconLeft><ion-icon :icon="createOutline" /></template>
                Edit
              </PPButton>
              <PPButton variant="outline-danger" size="small">
                <template #iconLeft><ion-icon :icon="trashOutline" /></template>
                Delete
              </PPButton>
            </div>
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
import { createOutline, trashOutline } from 'ionicons/icons';

const columns = [
  { key: 'code', title: 'Promo Code' },
  { key: 'type', title: 'Type' },
  { key: 'value', title: 'Value' },
  { key: 'usage', title: 'Usage' },
  { key: 'expiry', title: 'Expires On' },
  { key: 'status', title: 'Status' },
  { key: 'actions', title: '', align: 'right' as const }
];

const discounts = ref([
  { code: 'SUMMER20', type: 'Percentage', value: '20%', usage: '145 / 500', expiry: 'Aug 31, 2024', status: 'Active' },
  { code: 'WELCOME50', type: 'Fixed Amount', value: '$50.00', usage: '12 / ∞', expiry: 'No Expiry', status: 'Active' },
  { code: 'WINTER10', type: 'Percentage', value: '10%', usage: '500 / 500', expiry: 'Jan 15, 2024', status: 'Expired' }
]);
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

.action-buttons {
  display: flex;
  gap: 8px;
  justify-content: flex-end;
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
