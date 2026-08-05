<template>
  <ion-page>
    <ion-content>
      <div class="user-management-container">
        
        <!-- Header Section -->
        <div class="page-header">
          <div>
            <h1 class="page-title">Transcripts & Reports</h1>
            <p class="page-subtitle">View and generate academic reports for students.</p>
          </div>
          <PPButton variant="primary">
            <template #iconLeft>
              <ion-icon :icon="documentTextOutline" />
            </template>
            Generate Batch Report
          </PPButton>
        </div>

        <!-- Filter Section -->
        <div class="filter-section">
          <div class="search-box">
            <PPSearch placeholder="Search student by name or ID..." v-model="searchQuery" />
          </div>
          <div class="select-box">
            <PPSelect 
              v-model="yearFilter" 
              :options="yearOptions"
              placeholder="Academic Year"
            />
          </div>
        </div>

        <!-- Main Content -->
        <div class="transcripts-layout">
          
          <!-- Student List (Left sidebar) -->
          <div class="student-list-card">
            <div class="list-header">Students</div>
            <div class="student-list">
              <div 
                v-for="student in filteredStudents" 
                :key="student.id"
                class="student-item"
                :class="{ active: selectedStudent?.id === student.id }"
                @click="selectedStudent = student"
              >
                <div class="student-avatar">{{ student.name.charAt(0) }}</div>
                <div class="student-info">
                  <div class="student-name">{{ student.name }}</div>
                  <div class="student-meta">{{ student.id }} • {{ student.grade }}</div>
                </div>
              </div>
            </div>
          </div>

          <!-- Transcript View (Right panel) -->
          <div class="transcript-view-card" v-if="selectedStudent">
            
            <div class="transcript-header">
              <div class="student-profile">
                <div class="profile-avatar">{{ selectedStudent.name.charAt(0) }}</div>
                <div>
                  <h2 class="profile-name">{{ selectedStudent.name }}</h2>
                  <div class="profile-details">
                    <span><strong>ID:</strong> {{ selectedStudent.id }}</span>
                    <span><strong>Grade:</strong> {{ selectedStudent.grade }}</span>
                    <span><strong>Year:</strong> {{ yearFilter }}</span>
                  </div>
                </div>
              </div>
              <PPButton variant="outline">
                <template #iconLeft><ion-icon :icon="printOutline" /></template>
                Print
              </PPButton>
            </div>

            <div class="gpa-summary">
              <div class="gpa-card">
                <div class="gpa-label">Cumulative GPA</div>
                <div class="gpa-value">3.84</div>
              </div>
              <div class="gpa-card">
                <div class="gpa-label">Term GPA</div>
                <div class="gpa-value">3.92</div>
              </div>
              <div class="gpa-card">
                <div class="gpa-label">Total Credits</div>
                <div class="gpa-value">24</div>
              </div>
              <div class="gpa-card">
                <div class="gpa-label">Rank</div>
                <div class="gpa-value">12 / 350</div>
              </div>
            </div>

            <h3 class="term-title">Term 1 Results</h3>
            <table class="report-table">
              <thead>
                <tr>
                  <th>Subject</th>
                  <th>Credits</th>
                  <th>Grade</th>
                  <th>Points</th>
                  <th>Teacher Remarks</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="course in selectedStudent.courses" :key="course.subject">
                  <td><strong>{{ course.subject }}</strong></td>
                  <td>{{ course.credits }}</td>
                  <td>
                    <span class="grade-badge" :class="course.grade[0].toLowerCase()">{{ course.grade }}</span>
                  </td>
                  <td>{{ course.points }}</td>
                  <td class="remarks">{{ course.remarks }}</td>
                </tr>
              </tbody>
            </table>
          </div>

          <div class="empty-state" v-else>
            <ion-icon :icon="documentTextOutline" class="empty-icon" />
            <h3>No Student Selected</h3>
            <p>Select a student from the list to view their transcript and academic report.</p>
          </div>

        </div>

      </div>
    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';
import { IonPage, IonContent, IonIcon } from '@ionic/vue';
import { documentTextOutline, printOutline } from 'ionicons/icons';
import { PPButton, PPSearch, PPSelect } from '@phanna/ui-framework';

// State
const searchQuery = ref('');
const yearFilter = ref('2023-2024');
const selectedStudent = ref<any>(null);

// Options
const yearOptions = [
  { label: '2023-2024', value: '2023-2024' },
  { label: '2022-2023', value: '2022-2023' },
];

// Mock Data
const students = ref([
  { 
    id: 'S1001', name: 'Alice Smith', grade: 'Grade 10',
    courses: [
      { subject: 'Algebra II', credits: 3, grade: 'A', points: 4.0, remarks: 'Excellent progress.' },
      { subject: 'Biology', credits: 4, grade: 'A-', points: 3.7, remarks: 'Very attentive.' },
      { subject: 'World History', credits: 3, grade: 'B+', points: 3.3, remarks: 'Good participation.' },
      { subject: 'English Lit', credits: 3, grade: 'A', points: 4.0, remarks: 'Great analytical skills.' },
      { subject: 'Physical Ed', credits: 1, grade: 'A', points: 4.0, remarks: 'Outstanding effort.' }
    ]
  },
  { 
    id: 'S1002', name: 'Bob Johnson', grade: 'Grade 11',
    courses: [
      { subject: 'Pre-Calculus', credits: 3, grade: 'B-', points: 2.7, remarks: 'Needs to complete homework.' },
      { subject: 'Chemistry', credits: 4, grade: 'C+', points: 2.3, remarks: 'Struggles with lab work.' },
      { subject: 'US History', credits: 3, grade: 'B', points: 3.0, remarks: 'Solid understanding.' },
      { subject: 'American Lit', credits: 3, grade: 'B+', points: 3.3, remarks: 'Good essays.' },
    ]
  },
  { 
    id: 'S1003', name: 'Charlie Brown', grade: 'Grade 9',
    courses: [
      { subject: 'Algebra I', credits: 3, grade: 'A', points: 4.0, remarks: 'Perfect scores.' },
      { subject: 'Earth Science', credits: 4, grade: 'A+', points: 4.0, remarks: 'Top of the class.' },
    ]
  },
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
  height: 100%;
  display: flex;
  flex-direction: column;
}

.page-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 24px;
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
}

.search-box {
  flex: 1;
  max-width: 400px;
}

.select-box {
  width: 200px;
}

/* Layout */
.transcripts-layout {
  display: flex;
  gap: 24px;
  flex: 1;
  min-height: 0; /* for flex shrinking */
}

/* Left Sidebar */
.student-list-card {
  width: 320px;
  background: white;
  border-radius: 12px;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
  display: flex;
  flex-direction: column;
  overflow: hidden;
  border: 1px solid #e2e8f0;
}

.list-header {
  padding: 16px;
  font-weight: 600;
  color: #1e293b;
  border-bottom: 1px solid #e2e8f0;
  background: #f8fafc;
}

.student-list {
  flex: 1;
  overflow-y: auto;
}

.student-item {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 16px;
  border-bottom: 1px solid #f1f5f9;
  cursor: pointer;
  transition: all 0.2s;
}

.student-item:hover {
  background: #f8fafc;
}

.student-item.active {
  background: #eff6ff;
  border-left: 3px solid #3b82f6;
}

.student-avatar {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background: #e2e8f0;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 600;
  color: #475569;
}

.student-item.active .student-avatar {
  background: #bfdbfe;
  color: #1d4ed8;
}

.student-name {
  font-weight: 600;
  color: #0f172a;
}

.student-meta {
  font-size: 13px;
  color: #64748b;
  margin-top: 4px;
}

/* Right Panel */
.transcript-view-card {
  flex: 1;
  background: white;
  border-radius: 12px;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
  padding: 32px;
  overflow-y: auto;
  border: 1px solid #e2e8f0;
}

.empty-state {
  flex: 1;
  background: rgba(255, 255, 255, 0.5);
  border-radius: 12px;
  border: 2px dashed #cbd5e1;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  color: #64748b;
  text-align: center;
}

.empty-icon {
  font-size: 64px;
  color: #94a3b8;
  margin-bottom: 16px;
}

.transcript-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 32px;
  padding-bottom: 24px;
  border-bottom: 1px solid #e2e8f0;
}

.student-profile {
  display: flex;
  align-items: center;
  gap: 20px;
}

.profile-avatar {
  width: 80px;
  height: 80px;
  border-radius: 16px;
  background: #f1f5f9;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 32px;
  font-weight: 700;
  color: #3b82f6;
}

.profile-name {
  font-size: 24px;
  font-weight: 700;
  margin: 0 0 8px 0;
  color: #0f172a;
}

.profile-details {
  display: flex;
  gap: 24px;
  font-size: 14px;
  color: #475569;
}

.gpa-summary {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 16px;
  margin-bottom: 40px;
}

.gpa-card {
  background: #f8fafc;
  padding: 16px;
  border-radius: 8px;
  border: 1px solid #e2e8f0;
}

.gpa-label {
  font-size: 13px;
  color: #64748b;
  font-weight: 500;
  margin-bottom: 8px;
}

.gpa-value {
  font-size: 24px;
  font-weight: 700;
  color: #0f172a;
}

.term-title {
  font-size: 18px;
  font-weight: 600;
  margin-bottom: 16px;
  color: #1e293b;
}

.report-table {
  width: 100%;
  border-collapse: collapse;
}

.report-table th,
.report-table td {
  padding: 12px 16px;
  border-bottom: 1px solid #e2e8f0;
  text-align: left;
}

.report-table th {
  background: #f8fafc;
  font-weight: 600;
  color: #475569;
  font-size: 14px;
}

.grade-badge {
  display: inline-block;
  width: 32px;
  height: 32px;
  line-height: 32px;
  text-align: center;
  border-radius: 8px;
  font-weight: 700;
  font-size: 14px;
}

.grade-badge.a { background: rgba(16, 185, 129, 0.1); color: #10b981; }
.grade-badge.b { background: rgba(59, 130, 246, 0.1); color: #3b82f6; }
.grade-badge.c { background: rgba(245, 158, 11, 0.1); color: #f59e0b; }
.grade-badge.d { background: rgba(239, 68, 68, 0.1); color: #ef4444; }
.grade-badge.f { background: #ef4444; color: white; }

.remarks {
  color: #64748b;
  font-style: italic;
}
</style>
