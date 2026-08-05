<template>
  <ion-page>
    <ion-content>
      <div class="user-management-container">
        
        <!-- Header Section -->
        <div class="page-header">
          <div>
            <h1 class="page-title">Class Management</h1>
            <p class="page-subtitle">Manage class schedules, subject assignments, and rosters.</p>
          </div>
          <PPButton variant="primary">
            <template #iconLeft>
              <ion-icon :icon="bookOutline" />
            </template>
            Create New Class
          </PPButton>
        </div>

        <!-- Filter Section -->
        <div class="filter-section">
          <div class="search-box">
            <PPSearch placeholder="Search by class name or subject..." v-model="searchQuery" />
          </div>
          <div class="select-box">
            <PPSelect 
              v-model="gradeFilter" 
              :options="gradeOptions"
              placeholder="All Grades"
            />
          </div>
        </div>

        <!-- Table Section -->
        <PPTable 
          :columns="columns" 
          :data="filteredClasses" 
          :pagination="true" 
          :page-size="10"
          hover
        >
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
  bookOutline, 
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

// Options
const gradeOptions = [
  { label: 'All Grades', value: '' },
  { label: 'Grade 9', value: 'Grade 9' },
  { label: 'Grade 10', value: 'Grade 10' },
  { label: 'Grade 11', value: 'Grade 11' },
  { label: 'Grade 12', value: 'Grade 12' },
];

// Table Columns
const columns = [
  { key: 'code', title: 'Class Code', width: '120px' },
  { key: 'name', title: 'Class Name', sortable: true },
  { key: 'subject', title: 'Subject', sortable: true },
  { key: 'grade', title: 'Grade' },
  { key: 'teacher', title: 'Teacher' },
  { key: 'room', title: 'Room' },
  { key: 'capacity', title: 'Students' },
  { key: 'actions', title: 'Actions', width: '220px', align: 'center' as const },
];

// Mock Data
const classes = ref([
  { code: 'SCI101', name: 'Intro to Biology', subject: 'Science', grade: 'Grade 9', teacher: 'Dr. Gregory House', room: 'Lab 1', capacity: '24/30' },
  { code: 'MAT201', name: 'Algebra II', subject: 'Mathematics', grade: 'Grade 10', teacher: 'Jaime Escalante', room: 'Room 204', capacity: '28/30' },
  { code: 'ENG301', name: 'World Literature', subject: 'Languages', grade: 'Grade 11', teacher: 'John Keating', room: 'Room 105', capacity: '20/25' },
  { code: 'ART101', name: 'Glee Club', subject: 'Arts', grade: 'Grade 10', teacher: 'Will Schuester', room: 'Auditorium', capacity: '15/20' },
  { code: 'PHY201', name: 'Varsity Athletics', subject: 'Physical Education', grade: 'Grade 12', teacher: 'Sue Sylvester', room: 'Gym', capacity: '30/30' },
  { code: 'CHE301', name: 'AP Chemistry', subject: 'Science', grade: 'Grade 12', teacher: 'Walter White', room: 'Lab 3', capacity: '25/25' },
]);

// Computed: Filtered Classes
const filteredClasses = computed(() => {
  return classes.value.filter(cls => {
    const matchesSearch = cls.name.toLowerCase().includes(searchQuery.value.toLowerCase()) || 
                          cls.subject.toLowerCase().includes(searchQuery.value.toLowerCase()) ||
                          cls.code.toLowerCase().includes(searchQuery.value.toLowerCase());
    const matchesGrade = gradeFilter.value === '' || cls.grade === gradeFilter.value;
    return matchesSearch && matchesGrade;
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

/* Action Buttons */
.action-buttons {
  display: flex;
  gap: 8px;
  justify-content: flex-end;
}
</style>
