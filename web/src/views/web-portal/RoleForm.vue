<template>
  <ion-page>
    <ion-content>
    <div class="role-form-container">
      <div class="header-section">
        <div class="breadcrumb-wrapper">
          <PPBreadcrumb :items="breadcrumbItems" @click="handleBreadcrumbClick" />
        </div>
        <h1 class="page-title">{{ isEditing ? 'Edit Role' : 'Create New Role' }}</h1>
        <p class="page-subtitle">{{ isEditing ? 'Update role details and permissions.' : 'Define a new role and its permissions.' }}</p>
      </div>

      <div class="form-card">
        <div class="form-grid">
          <div class="form-group">
            <PPTextField 
              v-model="formData.name" 
              label="Role Name" 
              placeholder="Enter role name" 
              required 
            />
          </div>
          <div class="form-group">
            <PPTextField 
              v-model="formData.description" 
              label="Description" 
              placeholder="Enter role description" 
              required 
            />
          </div>
          <div class="form-group full-width">
            <label class="section-label">Permissions</label>
            <div class="permissions-list">
              <PPCheckboxGroup v-model="formData.permissions" vertical>
                <PPCheckbox 
                  v-for="perm in availablePermissions" 
                  :key="perm.id" 
                  :value="perm.id"
                  :label="perm.label"
                />
              </PPCheckboxGroup>
            </div>
          </div>
        </div>

        <div class="form-actions">
          <PPButton variant="outline" @click="goBack">
            <template #iconLeft>
              <ion-icon :icon="closeOutline" />
            </template>
            Cancel
          </PPButton>
          <PPButton variant="primary" @click="saveRole">
            <template #iconLeft>
              <ion-icon :icon="saveOutline" />
            </template>
            Save Role
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
import { PPTextField, PPButton, PPBreadcrumb, PPCheckbox, PPCheckboxGroup } from '@phanna/ui-framework';
import { saveOutline, closeOutline } from 'ionicons/icons';

const router = useRouter();
const route = useRoute();

const isEditing = ref(false);
const formData = ref({
  name: '',
  description: '',
  permissions: [] as string[]
});

const availablePermissions = [
  { id: 'users.view', label: 'View Users' },
  { id: 'users.edit', label: 'Edit Users' },
  { id: 'users.delete', label: 'Delete Users' },
  { id: 'roles.manage', label: 'Manage Roles' },
  { id: 'settings.manage', label: 'Manage Settings' },
];

onMounted(() => {
  if (route.params.id) {
    isEditing.value = true;
    // Mock loading role data
    formData.value = {
      name: 'Manager',
      description: 'Can manage users and view reports',
      permissions: ['users.view', 'users.edit']
    };
  }
});

const goBack = () => {
  router.push('/web-portal/roles');
};

const handleBreadcrumbClick = ({ index }: any) => {
  if (index === 0) {
    goBack();
  }
};

const breadcrumbItems = computed(() => [
  { label: 'Roles', href: '#' },
  { label: isEditing.value ? 'Edit Role' : 'Create New Role' }
]);

const saveRole = () => {
  if (!formData.value.name || !formData.value.description) return;
  // Mock save action
  console.log('Saving role:', formData.value);
  goBack();
};
</script>

<style scoped>
ion-content {
  --background: transparent;
}



.role-form-container {
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
  border-radius: 12px;
  border: 1px solid #e2e8f0;
  padding: 32px;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
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
  color: #475569;
  margin-bottom: 12px;
}

.permissions-list {
  background: #f8fafc;
  padding: 20px;
  border-radius: 8px;
  border: 1px solid #e2e8f0;
}

.form-actions {
  display: flex;
  justify-content: flex-end;
  gap: 16px;
  margin-top: 40px;
  padding-top: 24px;
  border-top: 1px solid #e2e8f0;
}
</style>
