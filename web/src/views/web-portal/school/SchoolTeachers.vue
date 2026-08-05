<template>
  <ion-page>
    <ion-content>
      <div class="user-management-container">
        
        <!-- Header Section -->
        <div class="page-header">
          <div>
            <h1 class="page-title">Teacher Management</h1>
            <p class="page-subtitle">Manage teaching staff and department assignments.</p>
          </div>
          <PPButton variant="primary">
            <template #iconLeft>
              <ion-icon :icon="personAddOutline" />
            </template>
            Add New Teacher
          </PPButton>
        </div>

        <!-- Filter Section -->
        <div class="filter-section">
          <div class="search-box">
            <PPSearch placeholder="Search by name or email..." v-model="searchQuery" />
          </div>
          <div class="select-box">
            <PPSelect 
              v-model="departmentFilter" 
              :options="departmentOptions"
              placeholder="All Departments"
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
          :data="filteredTeachers" 
          :pagination="true" 
          :page-size="10"
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
import { ref, computed } from 'vue';
import { IonPage, IonContent, IonIcon } from '@ionic/vue';
import { 
  personAddOutline, 
  createOutline, 
  trashOutline
} from 'ionicons/icons';
import { 
  PPButton, 
  PPSearch, 
  PPSelect, 
  PPTable
} from '@phanna/ui-framework';

// State
const searchQuery = ref('');
const departmentFilter = ref('');
const statusFilter = ref('');

// Options
const departmentOptions = [
  { label: 'All Departments', value: '' },
  { label: 'Science', value: 'Science' },
  { label: 'Mathematics', value: 'Mathematics' },
  { label: 'Languages', value: 'Languages' },
  { label: 'Arts', value: 'Arts' },
  { label: 'Physical Education', value: 'Physical Education' }
];

const statusOptions = [
  { label: 'All Statuses', value: '' },
  { label: 'Active', value: 'Active' },
  { label: 'On Leave', value: 'On Leave' },
  { label: 'Inactive', value: 'Inactive' },
];

// Table Columns
const columns = [
  { key: 'id', title: 'Teacher ID', width: '100px' },
  { key: 'name', title: 'Full Name', sortable: true },
  { key: 'email', title: 'Email Address', sortable: true },
  { key: 'department', title: 'Department' },
  { key: 'status', title: 'Status' },
  { key: 'actions', title: 'Actions', width: '220px', align: 'center' as const },
];

// Mock Data
const teachers = ref([
  { id: 'T101', name: 'Dr. Gregory House', email: 'g.house@school.edu', department: 'Science', status: 'Active' },
  { id: 'T102', name: 'Walter White', email: 'w.white@school.edu', department: 'Science', status: 'Inactive' },
  { id: 'T103', name: 'Will Schuester', email: 'w.schuester@school.edu', department: 'Arts', status: 'Active' },
  { id: 'T104', name: 'Sue Sylvester', email: 's.sylvester@school.edu', department: 'Physical Education', status: 'Active' },
  { id: 'T105', name: 'John Keating', email: 'j.keating@school.edu', department: 'Languages', status: 'On Leave' },
  { id: 'T106', name: 'Jaime Escalante', email: 'j.escalante@school.edu', department: 'Mathematics', status: 'Active' },
]);

// Computed: Filtered Teachers
const filteredTeachers = computed(() => {
  return teachers.value.filter(teacher => {
    const matchesSearch = teacher.name.toLowerCase().includes(searchQuery.value.toLowerCase()) || 
                          teacher.email.toLowerCase().includes(searchQuery.value.toLowerCase());
    const matchesDept = departmentFilter.value === '' || teacher.department === departmentFilter.value;
    const matchesStatus = statusFilter.value === '' || teacher.status === statusFilter.value;
    return matchesSearch && matchesDept && matchesStatus;
  });
});
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
  white-space: nowrap;
}
.status-badge.active {
  background: rgba(16, 185, 129, 0.1);
  color: #10b981;
}
.status-badge.inactive {
  background: rgba(239, 68, 68, 0.1);
  color: #ef4444;
}
.status-badge.on,
.status-badge[class*="leave"] {
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
