<template>
  <ion-page>
    <ion-content>
    <div class="user-form-container">
    <div class="header-section">
      <div class="breadcrumb-wrapper">
        <PPBreadcrumb :items="breadcrumbItems" @click="handleBreadcrumbClick" />
      </div>
      <h1 class="page-title">{{ isEditing ? 'Edit User' : 'Register New User' }}</h1>
      <p class="page-subtitle">{{ isEditing ? 'Update user details and permissions.' : 'Add a new user to the system.' }}</p>
    </div>

    <div class="form-card">
      <div class="form-grid">
        <div class="form-group">
          <PPTextField 
            v-model="formData.name" 
            label="Full Name" 
            placeholder="Enter full name" 
            required 
          />
        </div>
        <div class="form-group">
          <PPTextField 
            v-model="formData.email" 
            label="Email Address" 
            placeholder="Enter email address" 
            type="email"
            required 
          />
        </div>
        <div class="form-group">
          <PPSelect 
            v-model="formData.role" 
            label="Role" 
            :options="roleOptions"
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
      </div>

      <div class="form-actions">
        <PPButton variant="outline" @click="goBack">
          <template #iconLeft>
            <ion-icon :icon="closeOutline" />
          </template>
          Cancel
        </PPButton>
        <PPButton variant="primary" @click="saveUser">
          <template #iconLeft>
            <ion-icon :icon="isEditing ? saveOutline : personAddOutline" />
          </template>
          {{ isEditing ? 'Save Changes' : 'Register User' }}
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
import { arrowBackOutline, closeOutline, saveOutline, personAddOutline } from 'ionicons/icons';

const router = useRouter();
const route = useRoute();

const isEditing = ref(false);

const formData = ref({
  id: 0,
  name: '',
  email: '',
  role: 'User',
  status: 'Active'
});

const roleOptions = [
  { label: 'Admin', value: 'Admin' },
  { label: 'Manager', value: 'Manager' },
  { label: 'User', value: 'User' },
];

const statusOptions = [
  { label: 'Active', value: 'Active' },
  { label: 'Inactive', value: 'Inactive' },
  { label: 'Pending', value: 'Pending' },
];

onMounted(() => {
  if (route.params.id) {
    isEditing.value = true;
    // Mock fetch user data
    formData.value = {
      id: Number(route.params.id),
      name: 'Sample User',
      email: 'sample@example.com',
      role: 'User',
      status: 'Active'
    };
  }
});

const goBack = () => {
  router.push('/web-portal/users');
};

const handleBreadcrumbClick = ({ item, index }: any) => {
  if (index === 0) {
    goBack();
  }
};

const breadcrumbItems = computed(() => [
  { label: 'Users', href: '#' },
  { label: isEditing.value ? 'Edit User' : 'Register New User' }
]);

const saveUser = () => {
  if (!formData.value.name || !formData.value.email) return;
  // Mock save action
  console.log('Saving user:', formData.value);
  router.push('/web-portal/users');
};
</script>

<style scoped>
ion-content {
  --background: transparent;
}



.user-form-container {
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
  margin: 0 0 8px 0;
  color: #1e293b;
}

.page-subtitle {
  font-size: 16px;
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

.form-actions {
  display: flex;
  justify-content: flex-end;
  gap: 16px;
  border-top: 1px solid #e2e8f0;
  padding-top: 24px;
}

@media (max-width: 640px) {
  .form-grid {
    grid-template-columns: 1fr;
  }
}
</style>
