<template>
  <ion-page>
    <ion-content>
    <div class="category-management-container">
        
        <!-- Header Section -->
        <div class="page-header">
          <div>
            <h1 class="page-title">Category Management</h1>
            <p class="page-subtitle">Manage catalog categories and their statuses.</p>
          </div>
          <PPButton variant="primary" @click="openCreateCategory">
            <template #iconLeft>
              <ion-icon :icon="addOutline" />
            </template>
            Create New Category
          </PPButton>
        </div>

        <!-- Filter Section -->
        <div class="filter-section">
          <div class="search-box">
            <PPSearch placeholder="Search by category name or description..." v-model="searchQuery" />
          </div>
        </div>

        <!-- Table Section -->
        <PPTable 
          :columns="columns" 
          :data="filteredCategories" 
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

          <!-- Custom slot for Actions column -->
          <template #actions="{ row }">
            <div class="action-buttons">
              <PPButton variant="outline" size="small" @click="openEditCategory(row)">
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
      title="Delete Category"
      :message="`Are you sure you want to delete the category '${categoryToDelete?.name}'? This action cannot be undone.`"
      confirmText="Delete"
      confirmVariant="primary"
      @confirm="deleteCategory"
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
  PPTable, 
  PPConfirm 
} from '@phanna/ui-framework';

// State
const router = useRouter();
const searchQuery = ref('');
const isConfirmOpen = ref(false);
const categoryToDelete = ref<any>(null);

// Table Columns
const columns = [
  { key: 'id', title: 'ID', width: '80px' },
  { key: 'name', title: 'Category Name', sortable: true },
  { key: 'description', title: 'Description', sortable: true },
  { key: 'status', title: 'Status', width: '120px' },
  { key: 'itemCount', title: 'Items', sortable: true, width: '120px' },
  { key: 'actions', title: 'Actions', width: '220px', align: 'center' as const },
];

// Mock Data
const categories = ref([
  { id: 1, name: 'Beverages', description: 'Soft drinks, coffees, teas, and beers', status: 'Active', itemCount: 42 },
  { id: 2, name: 'Condiments', description: 'Sweet and savory sauces, relishes, spreads', status: 'Active', itemCount: 18 },
  { id: 3, name: 'Confections', description: 'Desserts, candies, and sweet breads', status: 'Inactive', itemCount: 12 },
  { id: 4, name: 'Dairy Products', description: 'Cheeses, milk, and eggs', status: 'Active', itemCount: 25 },
  { id: 5, name: 'Grains/Cereals', description: 'Breads, crackers, pasta, and cereal', status: 'Active', itemCount: 33 },
]);

// Computed: Filtered Categories
const filteredCategories = computed(() => {
  return categories.value.filter(category => {
    return category.name.toLowerCase().includes(searchQuery.value.toLowerCase()) || 
           category.description.toLowerCase().includes(searchQuery.value.toLowerCase());
  });
});

// Actions
const openCreateCategory = () => {
  router.push('/web-portal/categories/new');
};

const openEditCategory = (category: any) => {
  router.push(`/web-portal/categories/edit/${category.id}`);
};

const confirmDelete = (category: any) => {
  categoryToDelete.value = category;
  isConfirmOpen.value = true;
};

const deleteCategory = () => {
  if (categoryToDelete.value) {
    categories.value = categories.value.filter(c => c.id !== categoryToDelete.value.id);
    categoryToDelete.value = null;
  }
};
</script>

<style scoped>
ion-content {
  --background: transparent;
}

.category-management-container {
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
