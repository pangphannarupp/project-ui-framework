<template>
  <ion-page>
    <ion-content>
      <div class="user-management-container">
        
        <!-- Header Section -->
        <div class="page-header">
          <div>
            <h1 class="page-title">Student Management</h1>
            <p class="page-subtitle">Manage student records, grades, and enrollments.</p>
          </div>
          <PPButton variant="primary">
            <template #iconLeft>
              <ion-icon :icon="personAddOutline" />
            </template>
            Add New Student
          </PPButton>
        </div>

        <!-- Filter Section -->
        <div class="filter-section">
          <div class="search-box">
            <PPSearch placeholder="Search by student name or ID..." v-model="searchQuery" />
          </div>
          <div class="select-box">
            <PPSelect 
              v-model="gradeFilter" 
              :options="gradeOptions"
              placeholder="All Grades"
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
          :data="filteredStudents" 
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
const gradeFilter = ref('');
const statusFilter = ref('');

// Options
const gradeOptions = [
  { label: 'All Grades', value: '' },
  { label: 'Grade 9', value: 'Grade 9' },
  { label: 'Grade 10', value: 'Grade 10' },
  { label: 'Grade 11', value: 'Grade 11' },
  { label: 'Grade 12', value: 'Grade 12' },
];

const statusOptions = [
  { label: 'All Statuses', value: '' },
  { label: 'Active', value: 'Active' },
  { label: 'Inactive', value: 'Inactive' },
  { label: 'Graduated', value: 'Graduated' },
];

// Table Columns
const columns = [
  { key: 'id', title: 'Student ID', width: '100px' },
  { key: 'name', title: 'Full Name', sortable: true },
  { key: 'email', title: 'Email Address', sortable: true },
  { key: 'grade', title: 'Grade' },
  { key: 'status', title: 'Status' },
  { key: 'actions', title: 'Actions', width: '220px', align: 'center' as const },
];

// Mock Data
const students = ref([
  { id: 'S1001', name: 'Alice Smith', email: 'alice.smith@student.edu', grade: 'Grade 10', status: 'Active' },
  { id: 'S1002', name: 'Bob Johnson', email: 'bob.j@student.edu', grade: 'Grade 11', status: 'Active' },
  { id: 'S1003', name: 'Charlie Brown', email: 'charlie.b@student.edu', grade: 'Grade 9', status: 'Active' },
  { id: 'S1004', name: 'Diana Prince', email: 'diana.p@student.edu', grade: 'Grade 12', status: 'Graduated' },
  { id: 'S1005', name: 'Ethan Hunt', email: 'ethan.h@student.edu', grade: 'Grade 10', status: 'Inactive' },
  { id: 'S1006', name: 'Fiona Gallagher', email: 'fiona.g@student.edu', grade: 'Grade 11', status: 'Active' },
]);

// Computed: Filtered Students
const filteredStudents = computed(() => {
  return students.value.filter(student => {
    const matchesSearch = student.name.toLowerCase().includes(searchQuery.value.toLowerCase()) || 
                          student.id.toLowerCase().includes(searchQuery.value.toLowerCase());
    const matchesGrade = gradeFilter.value === '' || student.grade === gradeFilter.value;
    const matchesStatus = statusFilter.value === '' || student.status === statusFilter.value;
    return matchesSearch && matchesGrade && matchesStatus;
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
}
.status-badge.active {
  background: rgba(16, 185, 129, 0.1);
  color: #10b981;
}
.status-badge.inactive {
  background: rgba(239, 68, 68, 0.1);
  color: #ef4444;
}
.status-badge.graduated {
  background: rgba(59, 130, 246, 0.1);
  color: #3b82f6;
}

/* Action Buttons */
.action-buttons {
  display: flex;
  gap: 8px;
  justify-content: flex-end;
}
</style>
