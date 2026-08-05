<template>
  <ion-page>
    <ion-content>
      <div class="user-management-container">
        
        <!-- Header Section -->
        <div class="page-header">
          <div>
            <h1 class="page-title">Gradebook</h1>
            <p class="page-subtitle">Manage student scores, assignments, and exams.</p>
          </div>
          <div class="header-actions">
            <PPButton variant="outline">Export to CSV</PPButton>
            <PPButton variant="primary">
              <template #iconLeft>
                <ion-icon :icon="saveOutline" />
              </template>
              Save Grades
            </PPButton>
          </div>
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
            <PPSelect 
              v-model="termFilter" 
              :options="termOptions"
              placeholder="Select Term"
            />
          </div>
          <div class="search-box">
            <PPSearch placeholder="Search student..." v-model="searchQuery" />
          </div>
        </div>

        <!-- Gradebook Table Section -->
        <div class="gradebook-table-container">
          <table class="gradebook-table">
            <thead>
              <tr>
                <th class="sticky-col">Student Name</th>
                <th>Quiz 1 (10%)</th>
                <th>Quiz 2 (10%)</th>
                <th>Midterm (30%)</th>
                <th>Final (50%)</th>
                <th>Final Grade</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="student in filteredStudents" :key="student.id">
                <td class="sticky-col student-info">
                  <div class="student-name">{{ student.name }}</div>
                  <div class="student-id">{{ student.id }}</div>
                </td>
                <td><input type="number" class="grade-input" v-model.number="student.q1" min="0" max="100" /></td>
                <td><input type="number" class="grade-input" v-model.number="student.q2" min="0" max="100" /></td>
                <td><input type="number" class="grade-input" v-model.number="student.midterm" min="0" max="100" /></td>
                <td><input type="number" class="grade-input" v-model.number="student.final" min="0" max="100" /></td>
                <td class="final-grade" :class="getGradeColor(calculateFinal(student))">
                  {{ calculateFinal(student) }}%
                </td>
              </tr>
            </tbody>
          </table>
        </div>

      </div>
    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';
import { IonPage, IonContent, IonIcon } from '@ionic/vue';
import { saveOutline } from 'ionicons/icons';
import { PPButton, PPSearch, PPSelect } from '@phanna/ui-framework';

// State
const searchQuery = ref('');
const classFilter = ref('Grade 10 - Biology');
const termFilter = ref('Term 1');

// Options
const classOptions = [
  { label: 'Grade 10 - Biology', value: 'Grade 10 - Biology' },
  { label: 'Grade 11 - Algebra', value: 'Grade 11 - Algebra' },
];

const termOptions = [
  { label: 'Term 1', value: 'Term 1' },
  { label: 'Term 2', value: 'Term 2' },
];

// Mock Data
const students = ref([
  { id: 'S1001', name: 'Alice Smith', q1: 85, q2: 90, midterm: 88, final: 92 },
  { id: 'S1002', name: 'Bob Johnson', q1: 70, q2: 65, midterm: 75, final: 72 },
  { id: 'S1003', name: 'Charlie Brown', q1: 95, q2: 100, midterm: 96, final: 98 },
  { id: 'S1004', name: 'Diana Prince', q1: 100, q2: 100, midterm: 100, final: 95 },
  { id: 'S1005', name: 'Ethan Hunt', q1: 60, q2: 50, midterm: 65, final: 58 },
]);

// Computed
const filteredStudents = computed(() => {
  return students.value.filter(student => {
    return student.name.toLowerCase().includes(searchQuery.value.toLowerCase()) || 
           student.id.toLowerCase().includes(searchQuery.value.toLowerCase());
  });
});

const calculateFinal = (student: any) => {
  const q1 = student.q1 || 0;
  const q2 = student.q2 || 0;
  const midterm = student.midterm || 0;
  const final = student.final || 0;
  
  const score = (q1 * 0.1) + (q2 * 0.1) + (midterm * 0.3) + (final * 0.5);
  return score.toFixed(1);
};

const getGradeColor = (scoreStr: string) => {
  const score = parseFloat(scoreStr);
  if (score >= 90) return 'text-green';
  if (score >= 75) return 'text-blue';
  if (score >= 60) return 'text-orange';
  return 'text-red';
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

.header-actions {
  display: flex;
  gap: 12px;
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

/* Gradebook Table */
.gradebook-table-container {
  background: white;
  border-radius: 12px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
  overflow-x: auto;
  border: 1px solid #e2e8f0;
}

.gradebook-table {
  width: 100%;
  border-collapse: collapse;
  text-align: left;
}

.gradebook-table th,
.gradebook-table td {
  padding: 12px 16px;
  border-bottom: 1px solid #e2e8f0;
  border-right: 1px solid #e2e8f0;
}

.gradebook-table th {
  background: #f8fafc;
  font-weight: 600;
  color: #475569;
  font-size: 14px;
}

.gradebook-table .sticky-col {
  position: sticky;
  left: 0;
  background: white;
  z-index: 10;
  border-right: 2px solid #e2e8f0;
}

.gradebook-table th.sticky-col {
  background: #f8fafc;
}

.student-info {
  min-width: 200px;
}

.student-name {
  font-weight: 500;
  color: #0f172a;
}

.student-id {
  font-size: 12px;
  color: #64748b;
  margin-top: 2px;
}

.grade-input {
  width: 80px;
  padding: 8px;
  border: 1px solid #cbd5e1;
  border-radius: 6px;
  text-align: right;
  font-family: inherit;
  font-size: 14px;
  outline: none;
  transition: all 0.2s;
}

.grade-input:focus {
  border-color: #3b82f6;
  box-shadow: 0 0 0 2px rgba(59, 130, 246, 0.1);
}

.grade-input::-webkit-inner-spin-button, 
.grade-input::-webkit-outer-spin-button { 
  -webkit-appearance: none; 
  margin: 0; 
}

.final-grade {
  font-weight: 700;
  font-size: 16px;
  text-align: center;
}

.text-green { color: #10b981; }
.text-blue { color: #3b82f6; }
.text-orange { color: #f59e0b; }
.text-red { color: #ef4444; }
</style>
