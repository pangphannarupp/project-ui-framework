<template>
  <ion-page>
    <ion-content>
    <div class="product-form-container">
      <div class="header-section">
        <div class="breadcrumb-wrapper">
          <PPBreadcrumb :items="breadcrumbItems" @click="handleBreadcrumbClick" />
        </div>
        <h1 class="page-title">{{ isEditing ? 'Edit Product' : 'Create New Product' }}</h1>
        <p class="page-subtitle">{{ isEditing ? 'Update product details, pricing, and inventory.' : 'Add a new product to the catalog.' }}</p>
      </div>

      <div class="form-card">
        <div class="form-grid">
          <!-- Column 1 & 2 -->
          <div class="form-group">
            <PPTextField 
              v-model="formData.name" 
              label="Product Name" 
              placeholder="Enter product name" 
              required 
            />
          </div>
          <div class="form-group">
            <PPTextField 
              v-model="formData.sku" 
              label="SKU" 
              placeholder="e.g. BEV-001" 
              required 
            />
          </div>
          
          <div class="form-group">
            <PPSelect 
              v-model="formData.category" 
              label="Category" 
              :options="categoryOptions"
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

          <div class="form-group">
            <PPTextField 
              v-model="formData.price" 
              label="Price ($)" 
              type="number"
              placeholder="0.00" 
              required 
            />
          </div>
          <div class="form-group">
            <PPTextField 
              v-model="formData.stock" 
              label="Stock Quantity" 
              type="number"
              placeholder="0" 
              required 
            />
          </div>

          <div class="form-group full-width">
            <PPTextField 
              v-model="formData.description" 
              label="Description" 
              placeholder="Enter product description" 
            />
          </div>

          <div class="form-group full-width">
            <label class="section-label">Product Images</label>
            <PPFileUpload 
              accept="image/*" 
              multiple 
              :files="uploadedFiles"
              @select="onFileSelect"
              @remove="onFileRemove"
              @preview="onFilePreview"
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
          <PPButton variant="primary" @click="saveProduct">
            <template #iconLeft>
              <ion-icon :icon="saveOutline" />
            </template>
            Save Product
          </PPButton>
        </div>
      </div>
    </div>

    <!-- File Preview Component -->
    <PPFilePreview v-model="previewModalOpen" :file="previewFile || {}" />
  </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import { ref, onMounted, computed } from 'vue';
import { useRouter, useRoute } from 'vue-router';
import { IonPage, IonIcon, IonContent } from '@ionic/vue';
import { PPTextField, PPSelect, PPButton, PPBreadcrumb, PPFileUpload, PPFilePreview } from '@phanna/ui-framework';
import type { PPFileItem } from '@phanna/ui-framework/src/components/PPFileUpload.vue';
import { saveOutline, closeOutline } from 'ionicons/icons';

const router = useRouter();
const route = useRoute();

const isEditing = ref(false);
const formData = ref({
  name: '',
  sku: '',
  category: '',
  price: '',
  stock: '',
  status: 'Active',
  description: ''
});

const statusOptions = [
  { label: 'Active', value: 'Active' },
  { label: 'Inactive', value: 'Inactive' }
];

const categoryOptions = [
  { label: 'Beverages', value: 'Beverages' },
  { label: 'Condiments', value: 'Condiments' },
  { label: 'Confections', value: 'Confections' },
  { label: 'Dairy Products', value: 'Dairy Products' },
  { label: 'Grains/Cereals', value: 'Grains/Cereals' }
];

onMounted(() => {
  if (route.params.id) {
    isEditing.value = true;
    // Mock loading product data
    formData.value = {
      name: 'Chai',
      sku: 'BEV-001',
      category: 'Beverages',
      price: '18.00',
      stock: '39',
      status: 'Active',
      description: 'A soothing traditional tea blend.'
    };
  }
});

const goBack = () => {
  router.push('/web-portal/products');
};

const handleBreadcrumbClick = ({ index }: any) => {
  if (index === 0) {
    goBack();
  }
};

const breadcrumbItems = computed(() => [
  { label: 'Products', href: '#' },
  { label: isEditing.value ? 'Edit Product' : 'Create New Product' }
]);

const uploadedFiles = ref<PPFileItem[]>([]);
const previewModalOpen = ref(false);
const previewFile = ref<PPFileItem | null>(null);

const onFilePreview = (fileItem: PPFileItem) => {
  if (fileItem.file) {
    previewFile.value = fileItem;
    previewModalOpen.value = true;
  }
};

const onFileSelect = (files: File[]) => {
  files.forEach(file => {
    uploadedFiles.value.push({
      id: Math.random().toString(36).substring(7),
      name: file.name,
      size: file.size,
      progress: 100,
      status: 'success',
      file: file
    });
  });
};

const onFileRemove = (id: string | number) => {
  uploadedFiles.value = uploadedFiles.value.filter(f => f.id !== id);
};

const saveProduct = () => {
  if (!formData.value.name || !formData.value.sku || !formData.value.price) return;
  // Mock save action
  console.log('Saving product:', formData.value, 'Images:', uploadedFiles.value);
  goBack();
};
</script>

<style scoped>
ion-content {
  --background: transparent;
}



.product-form-container {
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

.section-label {
  font-size: 14px;
  font-weight: 600;
  color: #334155;
  margin-bottom: 8px;
  display: block;
}

.form-actions {
  display: flex;
  justify-content: flex-end;
  gap: 16px;
  border-top: 1px solid #e2e8f0;
  padding-top: 24px;
}
</style>
