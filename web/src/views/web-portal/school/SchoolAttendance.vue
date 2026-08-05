<template>
  <ion-page>
    <ion-content>
      <div class="user-management-container">
        
        <!-- Header Section -->
        <div class="page-header">
          <div>
            <h1 class="page-title">Attendance Tracking</h1>
            <p class="page-subtitle">Mark and review daily student attendance.</p>
          </div>
          <PPButton variant="primary">
            <template #iconLeft>
              <ion-icon :icon="checkmarkDoneOutline" />
            </template>
            Save Attendance
          </PPButton>
        </div>

        <!-- Filter Section -->
        <div class="filter-section">
          <div class="select-box">
            <PPSelect 
              v-model="classFilter" 
              :options="classOptions"
              placeholder="Select Class"
            />
          </div>
          <div class="select-box">
            <input type="date" class="date-picker" v-model="dateFilter" />
          </div>
          <div class="search-box">
            <PPSearch placeholder="Search student..." v-model="searchQuery" />
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
            <div class="attendance-toggles">
              <button 
                class="toggle-btn" 
                :class="{ active: row.status === 'Present', present: row.status === 'Present' }"
                @click="row.status = 'Present'"
              >P</button>
              <button 
                class="toggle-btn" 
                :class="{ active: row.status === 'Absent', absent: row.status === 'Absent' }"
                @click="row.status = 'Absent'"
              >A</button>
              <button 
                class="toggle-btn" 
                :class="{ active: row.status === 'Late', late: row.status === 'Late' }"
                @click="row.status = 'Late'"
              >L</button>
              <button 
                class="toggle-btn" 
                :class="{ active: row.status === 'Excused', excused: row.status === 'Excused' }"
                @click="row.status = 'Excused'"
              >E</button>
            </div>
          </template>

          <!-- Custom slot for Remarks column -->
          <template #remarks="{ row }">
            <input type="text" class="remark-input" v-model="row.remarks" placeholder="Add remark..." />
          </template>
        </PPTable>

      </div>
    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';
import { IonPage, IonContent, IonIcon } from '@ionic/vue';
import { checkmarkDoneOutline } from 'ionicons/icons';
import { PPButton, PPSearch, PPSelect, PPTable } from '@phanna/ui-framework';

// State
const searchQuery = ref('');
const classFilter = ref('Grade 10 - Biology');
const dateFilter = ref(new Date().toISOString().split('T')[0]);

// Options
const classOptions = [
  { label: 'Grade 10 - Biology', value: 'Grade 10 - Biology' },
  { label: 'Grade 11 - Algebra', value: 'Grade 11 - Algebra' },
  { label: 'Grade 9 - Literature', value: 'Grade 9 - Literature' },
];

// Table Columns
const columns = [
  { key: 'id', title: 'ID', width: '80px' },
  { key: 'name', title: 'Student Name', sortable: true },
  { key: 'status', title: 'Attendance (P/A/L/E)', width: '220px' },
  { key: 'remarks', title: 'Remarks' },
];

// Mock Data
const students = ref([
  { id: 'S1001', name: 'Alice Smith', status: 'Present', remarks: '' },
  { id: 'S1002', name: 'Bob Johnson', status: 'Present', remarks: '' },
  { id: 'S1003', name: 'Charlie Brown', status: 'Absent', remarks: 'Sick leave' },
  { id: 'S1004', name: 'Diana Prince', status: 'Late', remarks: 'Traffic' },
  { id: 'S1005', name: 'Ethan Hunt', status: 'Present', remarks: '' },
]);

// Computed
const filteredStudents = computed(() => {
  return students.value.filter(student => {
    return student.name.toLowerCase().includes(searchQuery.value.toLowerCase()) || 
           student.id.toLowerCase().includes(searchQuery.value.toLowerCase());
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
  min-width: 200px;
}

.select-box {
  width: 220px;
}

.date-picker {
  width: 100%;
  height: 40px;
  border-radius: 8px;
  border: 1px solid #cbd5e1;
  padding: 0 12px;
  font-family: inherit;
  color: #1e293b;
  outline: none;
}

.date-picker:focus {
  border-color: #3b82f6;
  box-shadow: 0 0 0 2px rgba(59, 130, 246, 0.1);
}

.attendance-toggles {
  display: flex;
  gap: 4px;
}

.toggle-btn {
  width: 32px;
  height: 32px;
  border-radius: 6px;
  border: 1px solid #cbd5e1;
  background: white;
  color: #64748b;
  font-weight: 600;
  font-size: 13px;
  cursor: pointer;
  transition: all 0.2s;
}

.toggle-btn:hover {
  background: #f1f5f9;
}

.toggle-btn.active.present {
  background: #10b981;
  color: white;
  border-color: #10b981;
}

.toggle-btn.active.absent {
  background: #ef4444;
  color: white;
  border-color: #ef4444;
}

.toggle-btn.active.late {
  background: #f59e0b;
  color: white;
  border-color: #f59e0b;
}

.toggle-btn.active.excused {
  background: #3b82f6;
  color: white;
  border-color: #3b82f6;
}

.remark-input {
  width: 100%;
  padding: 6px 12px;
  border: 1px solid transparent;
  border-radius: 4px;
  background: transparent;
  transition: all 0.2s;
  outline: none;
}

.remark-input:hover, .remark-input:focus {
  background: white;
  border-color: #cbd5e1;
}
</style>
