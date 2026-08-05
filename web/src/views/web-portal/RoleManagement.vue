<template>
  <ion-page>
    <ion-content>
    <div class="role-management-container">
        
        <!-- Header Section -->
        <div class="page-header">
          <div>
            <h1 class="page-title">Role Management</h1>
            <p class="page-subtitle">Manage system roles and their permissions.</p>
          </div>
          <PPButton variant="primary" @click="openCreateRole">
            <template #iconLeft>
              <ion-icon :icon="addOutline" />
            </template>
            Create New Role
          </PPButton>
        </div>

        <!-- Filter Section -->
        <div class="filter-section">
          <div class="search-box">
            <PPSearch placeholder="Search by role name or description..." v-model="searchQuery" />
          </div>
        </div>

        <!-- Table Section -->
        <div class="table-card">
          <PPTable 
            :columns="columns" 
            :data="filteredRoles" 
            :pagination="true" 
            :page-size="5"
            hover
          >
            <!-- Custom slot for Actions column -->
            <template #actions="{ row }">
              <div class="action-buttons">
                <PPButton variant="outline" size="small" @click="openEditRole(row)" class="edit-btn">
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

      </div>

    <!-- Delete Confirmation -->
    <PPConfirm 
      v-model="isConfirmOpen"
      title="Delete Role"
      :message="`Are you sure you want to delete the role '${roleToDelete?.name}'? This action cannot be undone.`"
      confirmText="Delete"
      confirmVariant="primary"
      @confirm="deleteRole"
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
const roleToDelete = ref<any>(null);

// Table Columns
const columns = [
  { key: 'id', title: 'ID', width: '80px' },
  { key: 'name', title: 'Role Name', sortable: true },
  { key: 'description', title: 'Description', sortable: true },
  { key: 'userCount', title: 'Users Assigned', sortable: true, width: '150px' },
  { key: 'actions', title: 'Actions', width: '220px', align: 'center' as const },
];

// Mock Data
const roles = ref([
  { id: 1, name: 'Admin', description: 'Full access to all system features', userCount: 2 },
  { id: 2, name: 'Manager', description: 'Can manage users and view reports', userCount: 5 },
  { id: 3, name: 'User', description: 'Basic access to application', userCount: 120 },
  { id: 4, name: 'Guest', description: 'Limited read-only access', userCount: 15 },
]);

// Computed: Filtered Roles
const filteredRoles = computed(() => {
  return roles.value.filter(role => {
    return role.name.toLowerCase().includes(searchQuery.value.toLowerCase()) || 
           role.description.toLowerCase().includes(searchQuery.value.toLowerCase());
  });
});

// Actions
const openCreateRole = () => {
  router.push('/web-portal/roles/new');
};

const openEditRole = (role: any) => {
  router.push(`/web-portal/roles/edit/${role.id}`);
};

const confirmDelete = (role: any) => {
  roleToDelete.value = role;
  isConfirmOpen.value = true;
};

const deleteRole = () => {
  if (roleToDelete.value) {
    roles.value = roles.value.filter(r => r.id !== roleToDelete.value.id);
    roleToDelete.value = null;
  }
};
</script>

<style scoped>
ion-content {
  --background: transparent;
}

.role-management-container {
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

.table-card {
  background: white;
  border-radius: 16px;
  border: 1px solid #e2e8f0;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05), 0 2px 4px -2px rgba(0, 0, 0, 0.025);
  padding: 24px;
}

.action-buttons {
  display: flex;
  gap: 8px;
  justify-content: center;
}




</style>
