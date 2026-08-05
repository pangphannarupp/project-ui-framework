<template>
  <ion-page>
    <ion-content>
    <div class="category-form-container">
      <div class="header-section">
        <div class="breadcrumb-wrapper">
          <PPBreadcrumb :items="breadcrumbItems" @click="handleBreadcrumbClick" />
        </div>
        <h1 class="page-title">{{ isEditing ? 'Edit Category' : 'Create New Category' }}</h1>
        <p class="page-subtitle">{{ isEditing ? 'Update category details and status.' : 'Define a new catalog category.' }}</p>
      </div>

      <div class="form-card">
        <div class="form-grid">
          <div class="form-group">
            <PPTextField 
              v-model="formData.name" 
              label="Category Name" 
              placeholder="Enter category name" 
              required 
            />
          </div>
          <div class="form-group">
            <PPSelect 
              v-model="formData.status" 
              label="Status" 
              :options="statusOptions"
              required 
            />
          </div>
          <div class="form-group full-width">
            <PPTextField 
              v-model="formData.description" 
              label="Description" 
              placeholder="Enter category description" 
              required 
            />
          </div>
        </div>

        <div class="form-actions">
          <PPButton variant="outline" @click="goBack">
            <template #iconLeft>
              <ion-icon :icon="closeOutline" />
            </template>
            Cancel
          </PPButton>
          <PPButton variant="primary" @click="saveCategory">
            <template #iconLeft>
              <ion-icon :icon="saveOutline" />
            </template>
            Save Category
          </PPButton>
        </div>
      </div>
    </div>
  </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import { ref, onMounted, computed } from 'vue';
import { useRouter, useRoute } from 'vue-router';
import { IonPage, IonIcon, IonContent } from '@ionic/vue';
import { PPTextField, PPSelect, PPButton, PPBreadcrumb } from '@phanna/ui-framework';
import { saveOutline, closeOutline } from 'ionicons/icons';

const router = useRouter();
const route = useRoute();

const isEditing = ref(false);
const formData = ref({
  name: '',
  description: '',
  status: 'Active'
});

const statusOptions = [
  { label: 'Active', value: 'Active' },
  { label: 'Inactive', value: 'Inactive' }
];

onMounted(() => {
  if (route.params.id) {
    isEditing.value = true;
    // Mock loading category data
    formData.value = {
      name: 'Beverages',
      description: 'Soft drinks, coffees, teas, and beers',
      status: 'Active'
    };
  }
});

const goBack = () => {
  router.push('/web-portal/categories');
};

const handleBreadcrumbClick = ({ index }: any) => {
  if (index === 0) {
    goBack();
  }
};

const breadcrumbItems = computed(() => [
  { label: 'Categories', href: '#' },
  { label: isEditing.value ? 'Edit Category' : 'Create New Category' }
]);

const saveCategory = () => {
  if (!formData.value.name || !formData.value.description) return;
  // Mock save action
  console.log('Saving category:', formData.value);
  goBack();
};
</script>

<style scoped>
ion-content {
  --background: transparent;
}



.category-form-container {
  padding: 40px;
  width: 100%;
}

.header-section {
  margin-bottom: 32px;
}

.breadcrumb-wrapper {
  margin-bottom: 16px;
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

.form-card {
  background: white;
  border-radius: 16px;
  border: 1px solid #e2e8f0;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05), 0 2px 4px -2px rgba(0, 0, 0, 0.025);
  padding: 32px;
}

.form-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 24px;
  margin-bottom: 32px;
}

@media (max-width: 640px) {
  .form-grid {
    grid-template-columns: 1fr;
  }
}

.form-group {
  display: flex;
  flex-direction: column;
}

.form-group.full-width {
  grid-column: 1 / -1;
}

.form-actions {
  display: flex;
  justify-content: flex-end;
  gap: 16px;
  border-top: 1px solid #e2e8f0;
  padding-top: 24px;
}
</style>
