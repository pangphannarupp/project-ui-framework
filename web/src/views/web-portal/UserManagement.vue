<template>
  <ion-page>
    <ion-content>
    <div class="user-management-container">
        
        <!-- Header Section -->
        <div class="page-header">
          <div>
            <h1 class="page-title">User Management</h1>
            <p class="page-subtitle">Manage system users, roles, and access.</p>
          </div>
          <PPButton variant="primary" @click="openRegisterModal">
            <template #iconLeft>
              <ion-icon :icon="personAddOutline" />
            </template>
            Register New User
          </PPButton>
        </div>

        <!-- Filter Section -->
        <div class="filter-section">
          <div class="search-box">
            <PPSearch placeholder="Search by name or email..." v-model="searchQuery" />
          </div>
          <div class="select-box">
            <PPSelect 
              v-model="roleFilter" 
              :options="roleOptions"
              placeholder="All Roles"
            />
          </div>
          <div class="select-box">
            <PPSelect 
              v-model="statusFilter" 
              :options="statusOptions"
              placeholder="All Statuses"
            />
          </div>
        </div>

        <!-- Table Section -->
        <PPTable 
          :columns="columns" 
          :data="filteredUsers" 
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
              <PPButton variant="outline" size="small" @click="openEditModal(row)">
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


    <!-- Register/Edit Modal has been extracted to a separate screen -->

    <!-- Delete Confirmation -->
    <PPConfirm 
      v-model="isConfirmOpen"
      title="Delete User"
      :message="`Are you sure you want to delete ${userToDelete?.name}? This action cannot be undone.`"
      confirmText="Delete"
      confirmVariant="primary"
      @confirm="deleteUser"
    />
  </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';
import { useRouter } from 'vue-router';
import { IonPage, IonIcon, IonContent } from '@ionic/vue';
import { 
  personAddOutline, 
  searchOutline, 
  createOutline, 
  trashOutline,
  closeOutline
} from 'ionicons/icons';
import { 
  PPButton, 
  PPSearch, 
  PPSelect, 
  PPTable, 
  PPTextField, 
  PPConfirm 
} from '@phanna/ui-framework';

// State
const router = useRouter();
const searchQuery = ref('');
const roleFilter = ref('');
const statusFilter = ref('');
const isConfirmOpen = ref(false);
const userToDelete = ref<any>(null);

// Options
const roleOptions = [
  { label: 'All Roles', value: '' },
  { label: 'Admin', value: 'Admin' },
  { label: 'Manager', value: 'Manager' },
  { label: 'User', value: 'User' },
];

const statusOptions = [
  { label: 'All Statuses', value: '' },
  { label: 'Active', value: 'Active' },
  { label: 'Inactive', value: 'Inactive' },
  { label: 'Pending', value: 'Pending' },
];

// Table Columns
const columns = [
  { key: 'id', title: 'ID', width: '80px' },
  { key: 'name', title: 'Full Name', sortable: true },
  { key: 'email', title: 'Email Address', sortable: true },
  { key: 'role', title: 'Role' },
  { key: 'status', title: 'Status' },
  { key: 'actions', title: 'Actions', width: '220px', align: 'center' as const },
];

// Mock Data
const users = ref([
  { id: 101, name: 'Alex Johnson', email: 'alex.j@example.com', role: 'Admin', status: 'Active' },
  { id: 102, name: 'Sarah Miller', email: 'sarah.m@example.com', role: 'Manager', status: 'Active' },
  { id: 103, name: 'Michael Chen', email: 'm.chen@example.com', role: 'User', status: 'Inactive' },
  { id: 104, name: 'Emily Davis', email: 'emily.d@example.com', role: 'User', status: 'Pending' },
  { id: 105, name: 'David Wilson', email: 'david.w@example.com', role: 'Manager', status: 'Active' },
  { id: 106, name: 'Jessica Taylor', email: 'j.taylor@example.com', role: 'User', status: 'Active' },
]);

// Computed: Filtered Users
const filteredUsers = computed(() => {
  return users.value.filter(user => {
    const matchesSearch = user.name.toLowerCase().includes(searchQuery.value.toLowerCase()) || 
                          user.email.toLowerCase().includes(searchQuery.value.toLowerCase());
    const matchesRole = roleFilter.value === '' || user.role === roleFilter.value;
    const matchesStatus = statusFilter.value === '' || user.status === statusFilter.value;
    return matchesSearch && matchesRole && matchesStatus;
  });
});

// Actions
const openRegisterModal = () => {
  router.push('/web-portal/users/new');
};

const openEditModal = (user: any) => {
  router.push(`/web-portal/users/edit/${user.id}`);
};

const confirmDelete = (user: any) => {
  userToDelete.value = user;
  isConfirmOpen.value = true;
};

const deleteUser = () => {
  if (userToDelete.value) {
    users.value = users.value.filter(u => u.id !== userToDelete.value.id);
    userToDelete.value = null;
  }
};
</script>

<style scoped>
ion-content {
  --background: transparent;
}

.user-management-container {
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
  margin: 0 0 8px 0;
  color: #1e293b;
}

.page-subtitle {
  font-size: 16px;
  color: #64748b;
  margin: 0;
}

.filter-section {
  display: flex;
  gap: 16px;
  margin-bottom: 24px;
  flex-wrap: wrap;
}

.search-box {
  flex: 1;
  min-width: 250px;
}

.select-box {
  width: 200px;
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
.status-badge.pending {
  background: rgba(245, 166, 35, 0.1);
  color: #f5a623;
}

/* Action Buttons */
.action-buttons {
  display: flex;
  gap: 8px;
  justify-content: flex-end;
}





</style>
