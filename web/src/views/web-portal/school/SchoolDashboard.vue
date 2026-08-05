<template>
  <ion-page>
    <ion-content>
      <div class="dashboard-container">
        <div class="page-header">
          <div>
            <h1 class="page-title">School Overview</h1>
            <p class="page-subtitle">Key metrics and statistics for your institution.</p>
          </div>
        </div>

        <div class="stats-grid">
          <div class="stat-card">
            <div class="stat-label">Total Students</div>
            <div class="stat-value">1,245</div>
            <div class="stat-change positive">
              <ion-icon :icon="trendingUpOutline" />
              +5% from last month
            </div>
          </div>
          <div class="stat-card">
            <div class="stat-label">Active Teachers</div>
            <div class="stat-value">84</div>
            <div class="stat-change positive">
              <ion-icon :icon="trendingUpOutline" />
              +2 new hires
            </div>
          </div>
          <div class="stat-card">
            <div class="stat-label">Active Classes</div>
            <div class="stat-value">156</div>
            <div class="stat-change neutral">
              <ion-icon :icon="removeOutline" />
              No change
            </div>
          </div>
          <div class="stat-card">
            <div class="stat-label">Avg Attendance</div>
            <div class="stat-value">94.2%</div>
            <div class="stat-change negative">
              <ion-icon :icon="trendingDownOutline" />
              -1.5% this week
            </div>
          </div>
        </div>

        <div class="charts-grid">
          <div class="chart-card wide">
            <h2 class="section-title">Enrollment Trends</h2>
            <div style="height: 300px">
              <PPLineChart :data="enrollmentData" :labels="enrollmentLabels" />
            </div>
          </div>
          <div class="chart-card">
            <h2 class="section-title">Students by Grade</h2>
            <div style="height: 300px">
              <PPBarChart :data="gradeData" />
            </div>
          </div>
        </div>
      </div>
    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import { IonPage, IonContent, IonIcon } from '@ionic/vue';
import { trendingUpOutline, trendingDownOutline, removeOutline } from 'ionicons/icons';
import { PPLineChart, PPBarChart } from '@phanna/ui-framework';

const enrollmentLabels = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul'];
const enrollmentData = [1100, 1150, 1180, 1200, 1220, 1240, 1245];

const gradeData = [
  { label: 'Grade 9', value: 350, color: '#3b82f6' },
  { label: 'Grade 10', value: 320, color: '#10b981' },
  { label: 'Grade 11', value: 300, color: '#f59e0b' },
  { label: 'Grade 12', value: 275, color: '#8b5cf6' },
];
</script>

<style scoped>
ion-content {
  --background: transparent;
}

.dashboard-container {
  padding: clamp(16px, 3vw, 40px);
  width: 100%;
  display: flex;
  flex-direction: column;
  gap: 24px;
}

.page-header {
  margin-bottom: 8px;
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

.stats-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
  gap: 24px;
}

.stat-card {
  background: white;
  border-radius: 16px;
  padding: 24px;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05), 0 2px 4px -2px rgba(0, 0, 0, 0.025);
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.stat-label {
  font-size: 14px;
  font-weight: 500;
  color: #64748b;
}

.stat-value {
  font-size: 32px;
  font-weight: 700;
  color: #0f172a;
}

.stat-change {
  display: flex;
  align-items: center;
  gap: 4px;
  font-size: 13px;
  font-weight: 500;
}

.stat-change.positive { color: #10b981; }
.stat-change.negative { color: #ef4444; }
.stat-change.neutral { color: #64748b; }

.charts-grid {
  display: grid;
  grid-template-columns: 2fr 1fr;
  gap: 24px;
}

@media (max-width: 1024px) {
  .charts-grid {
    grid-template-columns: 1fr;
  }
}

.chart-card {
  background: white;
  border-radius: 16px;
  padding: 24px;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05), 0 2px 4px -2px rgba(0, 0, 0, 0.025);
}

.section-title {
  font-size: 18px;
  font-weight: 600;
  color: #1e293b;
  margin: 0 0 24px 0;
}
</style>
