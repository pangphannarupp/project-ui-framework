<script setup lang="ts">
import AdminLayout from '../layouts/AdminLayout.vue'
import { useDashboardViewModel } from '../viewmodels/useDashboardViewModel'
import DashboardKpiGrid from '../components/dashboard/DashboardKpiGrid.vue'

const {
  isLoading,
  kpis,
  recentApps,
  recentLogs,
  selectedTimeRange,
  getChipColor
} = useDashboardViewModel()
</script>

<template>
  <AdminLayout>
    <div class="dashboard-view">
      <!-- Top Banner -->
      <div class="welcome-banner glass-panel">
        <div class="banner-text">
          <h1>Welcome to Mini Portal Command Center</h1>
          <p>Real-time cluster telemetry, gateway settlements, and decentralized mini-application operations.</p>
        </div>
        <div class="banner-actions">
          <RouterLink to="/mini-apps" style="text-decoration: none;">
            <PPButton variant="primary" size="small">
              <svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" style="margin-right:6px;"><polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"></polygon></svg>
              <span>Explore Mini Apps</span>
            </PPButton>
          </RouterLink>
          <RouterLink to="/logs" style="text-decoration: none;">
            <PPButton variant="outline" size="small">
              <svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" style="margin-right:6px;"><polyline points="4 17 10 11 4 5"></polyline><line x1="12" y1="19" x2="20" y2="19"></line></svg>
              <span>Live Audit Logs</span>
            </PPButton>
          </RouterLink>
        </div>
      </div>

      <!-- PPSkeleton Loading State for Dashboard Content -->
      <PPSkeleton :loading="isLoading" :animated="true">
        <template #template>
          <!-- Skeleton KPI Grid -->
          <div class="kpi-grid">
            <div v-for="i in 4" :key="i" class="skeleton-card" style="padding: 20px;">
              <div style="display: flex; justify-content: space-between;">
                <PPSkeletonItem variant="rect" width="40px" height="40px" style="border-radius: 10px;" />
                <PPSkeletonItem variant="rect" width="60px" height="22px" style="border-radius: 12px;" />
              </div>
              <PPSkeletonItem variant="text" width="55%" height="24px" />
              <PPSkeletonItem variant="text" width="75%" height="13px" />
            </div>
          </div>

          <!-- Skeleton Chart and Side Block -->
          <div class="content-grid" style="margin-top: 24px;">
            <div class="skeleton-card" style="height: 320px; padding: 24px;">
              <PPSkeletonItem variant="text" width="40%" height="20px" />
              <PPSkeletonItem variant="text" width="25%" height="12px" />
              <PPSkeletonItem variant="rect" height="160px" style="border-radius: 10px; margin-top: 16px;" />
            </div>
            <div class="skeleton-card" style="height: 320px; padding: 24px;">
              <PPSkeletonItem variant="text" width="60%" height="20px" />
              <div v-for="j in 3" :key="j" style="display: flex; align-items: center; gap: 12px; margin-top: 14px;">
                <PPSkeletonItem variant="circle" width="36px" height="36px" />
                <div style="flex: 1; display: flex; flex-direction: column; gap: 4px;">
                  <PPSkeletonItem variant="text" width="70%" />
                  <PPSkeletonItem variant="text" width="40%" height="12px" />
                </div>
              </div>
            </div>
          </div>
        </template>

        <div>
          <!-- Stateless KPI Metric Grid -->
          <DashboardKpiGrid :kpis="kpis" />

          <!-- Charts & Visual Section -->
          <div class="content-grid" style="margin-top: 24px;">
            <!-- Main Performance Block -->
            <div class="card glass-panel chart-card">
              <div class="card-header">
                <div>
                  <h3>Daily Traffic & Conversion Analytics</h3>
                  <small>Aggregated across all 30 mini application instances</small>
                </div>
                <div class="card-segment-wrapper">
                  <PPSegment v-model="selectedTimeRange" variant="pill">
                    <PPSegmentButton value="7 Days">7 Days</PPSegmentButton>
                    <PPSegmentButton value="30 Days">30 Days</PPSegmentButton>
                    <PPSegmentButton value="Quarter">Quarter</PPSegmentButton>
                  </PPSegment>
                </div>
              </div>
              
              <div class="chart-mock">
                <div class="bar-chart-visual">
                  <div class="bar-col" style="--h: 65%;"><span>Mon</span></div>
                  <div class="bar-col" style="--h: 80%;"><span>Tue</span></div>
                  <div class="bar-col" style="--h: 55%;"><span>Wed</span></div>
                  <div class="bar-col" style="--h: 90%;"><span>Thu</span></div>
                  <div class="bar-col active-bar" style="--h: 100%;"><span>Fri</span></div>
                  <div class="bar-col" style="--h: 75%;"><span>Sat</span></div>
                  <div class="bar-col" style="--h: 85%;"><span>Sun</span></div>
                </div>
              </div>

              <div class="chart-footer">
                <div class="stat-item">
                  <span class="dot blue"></span>
                  <div>
                    <strong>348,200</strong>
                    <small>Total Page Hits</small>
                  </div>
                </div>
                <div class="stat-item">
                  <span class="dot green"></span>
                  <div>
                    <strong>89.4%</strong>
                    <small>Conversion to Pay</small>
                  </div>
                </div>
                <div class="stat-item">
                  <span class="dot purple"></span>
                  <div>
                    <strong>1.2s</strong>
                    <small>Average Cold Launch</small>
                  </div>
                </div>
              </div>
            </div>

            <!-- Top Featured Apps -->
            <div class="card glass-panel">
              <div class="card-header">
                <h3>Top Active Mini Apps</h3>
                <RouterLink to="/mini-apps" class="view-all">View all →</RouterLink>
              </div>
              <div class="app-list">
                <div v-for="app in recentApps" :key="app.id" class="app-item">
                  <img :src="app.icon" class="app-avatar-img" :alt="app.name" />
                  <div class="app-details">
                    <strong>{{ app.name }}</strong>
                    <small>{{ app.category }} • {{ (app.usersCount).toLocaleString() }} MAU</small>
                  </div>
                  <div class="app-meta">
                    <PPChip
                      :label="app.status"
                      :color="app.status === 'active' ? 'success' : 'warning'"
                      variant="soft"
                      size="sm"
                    />
                    <a :href="`https://pangphannarupp.github.io/project-ui-framework${app.path}`" target="_blank" class="launch-btn" title="Launch Demo">
                      ↗
                    </a>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </PPSkeleton>

      <!-- Realtime Audit Activity -->
      <div class="card glass-panel logs-card">
        <div class="card-header">
          <div>
            <h3>Recent Telemetry & Audit Stream</h3>
            <small>Live system events from gateway and portal controllers</small>
          </div>
          <RouterLink to="/logs" class="view-all">Open Console →</RouterLink>
        </div>
        <div class="table-container">
          <table class="portal-table">
            <thead>
              <tr>
                <th>TIMESTAMP</th>
                <th>EVENT TYPE</th>
                <th>OPERATOR</th>
                <th>TARGET</th>
                <th>IP ORIGIN</th>
                <th>DETAILS</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="log in recentLogs" :key="log.id">
                <td class="font-mono text-muted">{{ log.timestamp }}</td>
                <td>
                  <PPChip
                    :label="log.action"
                    :color="getChipColor(log.level)"
                    variant="soft"
                    size="sm"
                  />
                </td>
                <td class="font-medium">{{ log.actor }}</td>
                <td class="text-blue">{{ log.target }}</td>
                <td class="font-mono text-muted">{{ log.ip }}</td>
                <td class="text-secondary">{{ log.details }}</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </AdminLayout>
</template>

<style scoped>
.dashboard-view {
  display: flex;
  flex-direction: column;
  gap: 24px;
}

.welcome-banner {
  padding: 32px 28px;
  background: linear-gradient(135deg, rgba(30, 41, 59, 0.9), rgba(15, 23, 42, 0.95));
  border: 1px solid #1f2937;
  border-radius: 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
  gap: 20px;
}

.banner-text h1 {
  font-size: 22px;
  font-weight: 700;
  color: #fff;
  margin-bottom: 6px;
}

.banner-text p {
  color: #94a3b8;
  font-size: 14px;
}

.banner-actions {
  display: flex;
  gap: 12px;
}

.content-grid {
  display: grid;
  grid-template-columns: 2fr 1fr;
  gap: 24px;
}

@media (max-width: 1024px) {
  .content-grid {
    grid-template-columns: 1fr;
  }
}

.card {
  background: #111827;
  border: 1px solid #1f2937;
  border-radius: 16px;
  padding: 24px;
  display: flex;
  flex-direction: column;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 20px;
}

.card-header h3 {
  font-size: 16px;
  color: #fff;
  margin-bottom: 4px;
}

.card-header small {
  color: #94a3b8;
}

.card-segment-wrapper :deep(.pp-segment) {
  background-color: #0f172a !important;
  border: 1px solid #1f2937 !important;
  padding: 3px !important;
}

.card-segment-wrapper :deep(.pp-segment-button) {
  padding: 4px 12px !important;
  font-size: 12px !important;
  font-weight: 600 !important;
  color: #94a3b8 !important;
  border-radius: 20px !important;
}

.card-segment-wrapper :deep(.pp-segment-button--active) {
  color: #ffffff !important;
}

.card-segment-wrapper :deep(.pp-segment-indicator) {
  background-color: #2563eb !important;
  border-radius: 20px !important;
  box-shadow: 0 2px 8px rgba(37, 99, 235, 0.4) !important;
}

.view-all {
  color: #60a5fa;
  font-size: 13px;
  text-decoration: none;
  font-weight: 500;
}

.chart-mock {
  flex: 1;
  display: flex;
  align-items: flex-end;
  min-height: 180px;
  padding-bottom: 16px;
}

.bar-chart-visual {
  display: flex;
  justify-content: space-between;
  align-items: flex-end;
  width: 100%;
  height: 140px;
  gap: 12px;
}

.bar-col {
  flex: 1;
  height: var(--h);
  background: rgba(59, 130, 246, 0.25);
  border-radius: 6px 6px 0 0;
  display: flex;
  align-items: flex-end;
  justify-content: center;
  padding-bottom: 8px;
  position: relative;
  transition: all 0.3s ease;
}

.bar-col:hover,
.bar-col.active-bar {
  background: linear-gradient(180deg, #3b82f6, #6366f1);
  box-shadow: 0 0 12px rgba(59, 130, 246, 0.4);
}

.bar-col span {
  font-size: 11px;
  color: #94a3b8;
  position: absolute;
  bottom: -20px;
}

.chart-footer {
  display: flex;
  justify-content: space-around;
  padding-top: 16px;
  border-top: 1px solid #1f2937;
  margin-top: 16px;
}

.stat-item {
  display: flex;
  align-items: center;
  gap: 10px;
}

.dot {
  width: 8px;
  height: 8px;
  border-radius: 50%;
}

.dot.blue { background: #3b82f6; }
.dot.green { background: #10b981; }
.dot.purple { background: #8b5cf6; }

.stat-item strong {
  display: block;
  font-size: 14px;
  color: #fff;
}

.stat-item small {
  font-size: 11px;
  color: #94a3b8;
}

.app-list {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.app-item {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 10px 12px;
  border-radius: 12px;
  background: #0f172a;
  border: 1px solid #1f2937;
}

.app-avatar-img {
  width: 36px;
  height: 36px;
  border-radius: 8px;
  object-fit: cover;
}

.app-details {
  flex: 1;
}

.app-details strong {
  display: block;
  font-size: 13px;
  color: #fff;
}

.app-details small {
  font-size: 11px;
  color: #94a3b8;
}

.app-meta {
  display: flex;
  align-items: center;
  gap: 8px;
}

.launch-btn {
  color: #60a5fa;
  text-decoration: none;
  font-size: 14px;
}

.table-container {
  overflow-x: auto;
}

.portal-table {
  width: 100%;
  border-collapse: collapse;
  text-align: left;
}

.portal-table th {
  font-size: 11px;
  letter-spacing: 0.5px;
  color: #64748b;
  padding: 12px 16px;
  border-bottom: 1px solid #1f2937;
}

.portal-table td {
  padding: 14px 16px;
  font-size: 13px;
  border-bottom: 1px solid #1f2937;
  color: #cbd5e1;
}

.text-blue { color: #60a5fa; }
.text-secondary { color: #94a3b8; }
</style>
