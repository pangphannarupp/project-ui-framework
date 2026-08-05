<template>
  <ion-page>
    <ion-content>
      <div class="user-management-container">
        
        <!-- Header Section -->
        <div class="page-header">
          <div>
            <h1 class="page-title">Class Schedule</h1>
            <p class="page-subtitle">View and manage the weekly school timetable.</p>
          </div>
          <div class="header-actions">
            <PPButton variant="outline">
              <template #iconLeft><ion-icon :icon="calendarOutline" /></template>
              Today
            </PPButton>
            <PPButton variant="primary">
              <template #iconLeft><ion-icon :icon="addOutline" /></template>
              Add Class Session
            </PPButton>
          </div>
        </div>

        <!-- Filter Section -->
        <div class="filter-section">
          <div class="select-box">
            <PPSelect 
              v-model="viewFilter" 
              :options="viewOptions"
              placeholder="View Mode"
            />
          </div>
          <div class="select-box">
            <PPSelect 
              v-model="teacherFilter" 
              :options="teacherOptions"
              placeholder="All Teachers"
            />
          </div>
          <div class="select-box">
            <PPSelect 
              v-model="roomFilter" 
              :options="roomOptions"
              placeholder="All Rooms"
            />
          </div>
        </div>

        <!-- Schedule Grid -->
        <div class="schedule-container">
          <table class="schedule-table">
            <thead>
              <tr>
                <th class="time-col">Time</th>
                <th>Monday</th>
                <th>Tuesday</th>
                <th>Wednesday</th>
                <th>Thursday</th>
                <th>Friday</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="timeSlot in timeSlots" :key="timeSlot">
                <td class="time-col">{{ timeSlot }}</td>
                <td v-for="day in days" :key="day" class="schedule-cell">
                  <div 
                    v-if="getSchedule(day, timeSlot)"
                    class="class-block"
                    :class="getSchedule(day, timeSlot)?.color"
                  >
                    <div class="class-title">{{ getSchedule(day, timeSlot)?.subject }}</div>
                    <div class="class-details">
                      <span>{{ getSchedule(day, timeSlot)?.grade }}</span>
                      <span>•</span>
                      <span>{{ getSchedule(day, timeSlot)?.room }}</span>
                    </div>
                  </div>
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
import { ref } from 'vue';
import { IonPage, IonContent, IonIcon } from '@ionic/vue';
import { calendarOutline, addOutline } from 'ionicons/icons';
import { PPButton, PPSelect } from '@phanna/ui-framework';

// State
const viewFilter = ref('Teacher');
const teacherFilter = ref('Dr. Gregory House');
const roomFilter = ref('');

// Options
const viewOptions = [
  { label: 'By Teacher', value: 'Teacher' },
  { label: 'By Room', value: 'Room' },
  { label: 'By Grade', value: 'Grade' },
];

const teacherOptions = [
  { label: 'All Teachers', value: '' },
  { label: 'Dr. Gregory House', value: 'Dr. Gregory House' },
  { label: 'Walter White', value: 'Walter White' },
];

const roomOptions = [
  { label: 'All Rooms', value: '' },
  { label: 'Lab 1', value: 'Lab 1' },
  { label: 'Room 204', value: 'Room 204' },
];

const timeSlots = ['08:00 AM', '09:00 AM', '10:00 AM', '11:00 AM', '12:00 PM', '01:00 PM', '02:00 PM', '03:00 PM'];
const days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];

// Mock Schedule Data (filtered for Dr. House)
const scheduleData = [
  { day: 'Monday', time: '08:00 AM', subject: 'Biology 101', grade: 'Grade 10', room: 'Lab 1', color: 'bg-blue' },
  { day: 'Monday', time: '09:00 AM', subject: 'Biology 101', grade: 'Grade 10', room: 'Lab 1', color: 'bg-blue' },
  { day: 'Monday', time: '11:00 AM', subject: 'AP Biology', grade: 'Grade 12', room: 'Lab 1', color: 'bg-indigo' },
  { day: 'Tuesday', time: '10:00 AM', subject: 'Anatomy', grade: 'Grade 11', room: 'Lab 2', color: 'bg-purple' },
  { day: 'Tuesday', time: '01:00 PM', subject: 'Biology 101', grade: 'Grade 10', room: 'Lab 1', color: 'bg-blue' },
  { day: 'Wednesday', time: '08:00 AM', subject: 'AP Biology', grade: 'Grade 12', room: 'Lab 1', color: 'bg-indigo' },
  { day: 'Wednesday', time: '02:00 PM', subject: 'Anatomy', grade: 'Grade 11', room: 'Lab 2', color: 'bg-purple' },
  { day: 'Thursday', time: '09:00 AM', subject: 'Biology 101', grade: 'Grade 10', room: 'Lab 1', color: 'bg-blue' },
  { day: 'Friday', time: '10:00 AM', subject: 'AP Biology', grade: 'Grade 12', room: 'Lab 1', color: 'bg-indigo' },
  { day: 'Friday', time: '11:00 AM', subject: 'Anatomy', grade: 'Grade 11', room: 'Lab 2', color: 'bg-purple' },
];

const getSchedule = (day: string, time: string) => {
  return scheduleData.find(s => s.day === day && s.time === time);
};
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

.header-actions {
  display: flex;
  gap: 12px;
}

.filter-section {
  display: flex;
  gap: 16px;
  margin-bottom: 24px;
}

.select-box {
  width: 200px;
}

/* Schedule Table */
.schedule-container {
  background: white;
  border-radius: 12px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
  overflow: auto;
  border: 1px solid #e2e8f0;
  flex: 1;
}

.schedule-table {
  width: 100%;
  border-collapse: collapse;
  min-width: 800px;
}

.schedule-table th,
.schedule-table td {
  border: 1px solid #e2e8f0;
}

.schedule-table th {
  background: #f8fafc;
  padding: 16px;
  font-weight: 600;
  color: #475569;
  text-align: center;
  position: sticky;
  top: 0;
  z-index: 10;
}

.time-col {
  width: 100px;
  background: #f8fafc;
  font-weight: 600;
  color: #64748b;
  font-size: 13px;
  text-align: center;
  padding: 16px 8px;
}

.schedule-cell {
  height: 100px;
  width: calc((100% - 100px) / 5);
  padding: 8px;
  vertical-align: top;
}

.class-block {
  height: 100%;
  border-radius: 8px;
  padding: 8px 12px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  transition: transform 0.2s;
  cursor: pointer;
}

.class-block:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
}

.class-title {
  font-weight: 600;
  font-size: 14px;
  margin-bottom: 4px;
}

.class-details {
  display: flex;
  gap: 6px;
  font-size: 12px;
  opacity: 0.9;
}

/* Colors */
.bg-blue { background: #eff6ff; border-left: 4px solid #3b82f6; color: #1e3a8a; }
.bg-indigo { background: #eef2ff; border-left: 4px solid #6366f1; color: #312e81; }
.bg-purple { background: #faf5ff; border-left: 4px solid #a855f7; color: #581c87; }
</style>
