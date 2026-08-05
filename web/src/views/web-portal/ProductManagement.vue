<template>
  <ion-page>
    <ion-content>
    <div class="product-management-container">
        
        <!-- Header Section -->
        <div class="page-header">
          <div>
            <h1 class="page-title">Product Management</h1>
            <p class="page-subtitle">Manage catalog products, pricing, and inventory.</p>
          </div>
          <PPButton variant="primary" @click="openCreateProduct">
            <template #iconLeft>
              <ion-icon :icon="addOutline" />
            </template>
            Create New Product
          </PPButton>
        </div>

        <!-- Filter Section -->
        <div class="filter-section">
          <div class="search-box">
            <PPSearch placeholder="Search by product name or SKU..." v-model="searchQuery" />
          </div>
          <div class="select-box">
            <PPSelect 
              v-model="categoryFilter" 
              :options="categoryOptions"
              placeholder="All Categories"
            />
          </div>
        </div>

        <!-- Table Section -->
        <PPTable 
          :columns="columns" 
          :data="filteredProducts" 
          :pagination="true" 
          :page-size="5"
          hover
        >
          <!-- Custom slot for Status column -->
          <template #status="{ row }">
            <span class="status-badge" :class="row.status.toLowerCase()">
              {{ row.status }}
            </span>
          </template>

          <!-- Custom slot for Price column -->
          <template #price="{ row }">
            <span class="price-text">
              ${{ Number(row.price).toFixed(2) }}
            </span>
          </template>

          <!-- Custom slot for Actions column -->
          <template #actions="{ row }">
            <div class="action-buttons">
              <PPButton variant="outline" size="small" @click="openEditProduct(row)">
                <template #iconLeft><ion-icon :icon="createOutline" /></template>
                Edit
              </PPButton>
              <PPButton variant="outline-danger" size="small" @click="confirmDelete(row)">
                <template #iconLeft><ion-icon :icon="trashOutline" /></template>
                Delete
              </PPButton>
            </div>
          </template>
        </PPTable>

      </div>

    <!-- Delete Confirmation -->
    <PPConfirm 
      v-model="isConfirmOpen"
      title="Delete Product"
      :message="`Are you sure you want to delete the product '${productToDelete?.name}'? This action cannot be undone.`"
      confirmText="Delete"
      confirmVariant="primary"
      @confirm="deleteProduct"
    />
  </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';
import { useRouter } from 'vue-router';
import { IonPage, IonIcon, IonContent } from '@ionic/vue';
import { 
  createOutline, 
  trashOutline,
  addOutline
} from 'ionicons/icons';
import { 
  PPButton, 
  PPSearch,
  PPSelect,
  PPTable, 
  PPConfirm 
} from '@phanna/ui-framework';

// State
const router = useRouter();
const searchQuery = ref('');
const categoryFilter = ref('');
const isConfirmOpen = ref(false);
const productToDelete = ref<any>(null);

// Table Columns
const columns = [
  { key: 'id', title: 'ID', width: '80px' },
  { key: 'sku', title: 'SKU', width: '120px' },
  { key: 'name', title: 'Product Name', sortable: true },
  { key: 'category', title: 'Category', sortable: true },
  { key: 'price', title: 'Price', sortable: true, width: '120px' },
  { key: 'stock', title: 'Stock', sortable: true, width: '100px' },
  { key: 'status', title: 'Status', width: '120px' },
  { key: 'actions', title: 'Actions', width: '220px', align: 'center' as const },
];

const categoryOptions = [
  { label: 'All Categories', value: '' },
  { label: 'Beverages', value: 'Beverages' },
  { label: 'Condiments', value: 'Condiments' },
  { label: 'Confections', value: 'Confections' },
  { label: 'Dairy Products', value: 'Dairy Products' },
  { label: 'Grains/Cereals', value: 'Grains/Cereals' },
];

// Mock Data
const products = ref([
  { id: 1, sku: 'BEV-001', name: 'Chai', category: 'Beverages', price: 18.00, stock: 39, status: 'Active' },
  { id: 2, sku: 'BEV-002', name: 'Chang', category: 'Beverages', price: 19.00, stock: 17, status: 'Active' },
  { id: 3, sku: 'CON-001', name: 'Aniseed Syrup', category: 'Condiments', price: 10.00, stock: 13, status: 'Active' },
  { id: 4, sku: 'CON-002', name: 'Chef Anton\'s Cajun Seasoning', category: 'Condiments', price: 22.00, stock: 53, status: 'Active' },
  { id: 5, sku: 'DAI-001', name: 'Queso Cabrales', category: 'Dairy Products', price: 21.00, stock: 22, status: 'Active' },
  { id: 6, sku: 'GRA-001', name: 'Gustaf\'s Knäckebröd', category: 'Grains/Cereals', price: 21.00, stock: 104, status: 'Active' },
]);

// Computed: Filtered Products
const filteredProducts = computed(() => {
  return products.value.filter(product => {
    const matchesSearch = product.name.toLowerCase().includes(searchQuery.value.toLowerCase()) || 
                          product.sku.toLowerCase().includes(searchQuery.value.toLowerCase());
    const matchesCategory = categoryFilter.value === '' || product.category === categoryFilter.value;
    
    return matchesSearch && matchesCategory;
  });
});

// Actions
const openCreateProduct = () => {
  router.push('/web-portal/products/new');
};

const openEditProduct = (product: any) => {
  router.push(`/web-portal/products/edit/${product.id}`);
};

const confirmDelete = (product: any) => {
  productToDelete.value = product;
  isConfirmOpen.value = true;
};

const deleteProduct = () => {
  if (productToDelete.value) {
    products.value = products.value.filter(p => p.id !== productToDelete.value.id);
    productToDelete.value = null;
  }
};
</script>

<style scoped>
ion-content {
  --background: transparent;
}

.product-management-container {
  padding: clamp(16px, 3vw, 40px);
  width: 100%;
}

.page-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
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

.filter-section {
  display: flex;
  gap: 16px;
  margin-bottom: 24px;
}

.search-box {
  flex: 1;
  max-width: 400px;
}

.select-box {
  width: 240px;
}


.price-text {
  font-weight: 600;
  color: #334155;
}

/* Status Badge */
.status-badge {
  display: inline-block;
  padding: 4px 12px;
  border-radius: 20px;
  font-size: 12px;
  font-weight: 600;
}
.status-badge.active {
  background: rgba(16, 185, 129, 0.1);
  color: #10b981;
}
.status-badge.inactive {
  background: rgba(239, 68, 68, 0.1);
  color: #ef4444;
}

.action-buttons {
  display: flex;
  gap: 8px;
  justify-content: flex-end;
}




</style>
