<script setup lang="ts">
import { ref } from 'vue'
import AdminLayout from '../layouts/AdminLayout.vue'
import { mockMiniApps, mockLogs } from '../data/mockData'

const kpis = [
  { title: 'Registered Mini Apps', value: '30 Apps', change: '+4 this month', icon: '📱', positive: true },
  { title: 'Monthly Active Users', value: '168,420', change: '+18.2%', icon: '👥', positive: true },
  { title: 'Payment Volume (Bakong/PayWay)', value: '$1.42M', change: '+24.5%', icon: '💳', positive: true },
  { title: 'Push Delivery Rate', value: '98.8%', change: '-0.2%', icon: '⚡', positive: false }
]

const recentApps = ref(mockMiniApps.slice(0, 4))
const recentLogs = ref(mockLogs.slice(0, 4))

const getLevelBadgeClass = (level: string) => {
  switch (level) {
    case 'success': return 'badge-success'
    case 'warn': return 'badge-warning'
    case 'error': return 'badge-danger'
    default: return 'badge-info'
  }
}
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
          <RouterLink to="/mini-apps" class="btn btn-primary">
            <span>🚀 Explore Mini Apps</span>
          </RouterLink>
          <RouterLink to="/logs" class="btn btn-secondary">
            <span>💻 Live Audit Logs</span>
          </RouterLink>
        </div>
      </div>

      <!-- KPI Metric Grid -->
      <div class="kpi-grid">
        <div v-for="kpi in kpis" :key="kpi.title" class="kpi-card glass-panel">
          <div class="kpi-header">
            <span class="kpi-icon">{{ kpi.icon }}</span>
            <span class="kpi-change" :class="{ 'positive': kpi.positive, 'negative': !kpi.positive }">
              {{ kpi.change }}
            </span>
          </div>
          <div class="kpi-body">
            <h3>{{ kpi.value }}</h3>
            <p>{{ kpi.title }}</p>
          </div>
        </div>
      </div>

      <!-- Charts & Visual Section -->
      <div class="content-grid">
        <!-- Main Performance Block -->
        <div class="card glass-panel chart-card">
          <div class="card-header">
            <div>
              <h3>Daily Traffic & Conversion Analytics</h3>
              <small>Aggregated across all 30 mini application instances</small>
            </div>
            <div class="card-pills">
              <span class="pill active">7 Days</span>
              <span class="pill">30 Days</span>
              <span class="pill">Quarter</span>
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
              <div class="app-avatar">{{ app.name.slice(0, 1) }}</div>
              <div class="app-details">
                <strong>{{ app.name }}</strong>
                <small>{{ app.category }} • {{ (app.usersCount).toLocaleString() }} MAU</small>
              </div>
              <div class="app-meta">
                <span class="status-pill" :class="app.status">{{ app.status }}</span>
                <a :href="`https://pangphannarupp.github.io/project-ui-framework${app.path}`" target="_blank" class="launch-btn" title="Launch Demo">
                  ↗
                </a>
              </div>
            </div>
          </div>
        </div>
      </div>

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
                  <span class="badge" :class="getLevelBadgeClass(log.level)">
                    {{ log.action }}
                  </span>
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

/* Welcome Banner */
.welcome-banner {
  padding: 32px;
  background: linear-gradient(135deg, rgba(30, 41, 59, 0.9), rgba(15, 23, 42, 0.95));
  border-radius: 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  border: 1px solid rgba(59, 130, 246, 0.2);
}

.banner-text h1 {
  font-size: 26px;
  font-weight: 800;
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

.btn {
  padding: 12px 20px;
  border-radius: 10px;
  font-size: 14px;
  font-weight: 600;
  text-decoration: none;
  display: flex;
  align-items: center;
  transition: all 0.2s ease;
}

.btn-primary {
  background: linear-gradient(135deg, #2563eb, #4f46e5);
  color: #fff;
  box-shadow: 0 4px 15px rgba(37, 99, 235, 0.4);
}

.btn-primary:hover {
  transform: translateY(-2px);
}

.btn-secondary {
  background: #1e293b;
  border: 1px solid #334155;
  color: #cbd5e1;
}

.btn-secondary:hover {
  background: #334155;
  color: #fff;
}

/* KPI Grid */
.kpi-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 20px;
}

.kpi-card {
  padding: 24px;
  background: #111827;
  border: 1px solid #1f2937;
  border-radius: 16px;
}

.kpi-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 16px;
}

.kpi-icon {
  font-size: 24px;
  background: #1f2937;
  width: 44px;
  height: 44px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 12px;
}

.kpi-change {
  font-size: 12px;
  font-weight: 600;
  padding: 4px 8px;
  border-radius: 20px;
}

.kpi-change.positive {
  background: rgba(16, 185, 129, 0.15);
  color: #10b981;
}

.kpi-change.negative {
  background: rgba(239, 68, 68, 0.15);
  color: #ef4444;
}

.kpi-body h3 {
  font-size: 26px;
  font-weight: 800;
  color: #fff;
  margin-bottom: 4px;
}

.kpi-body p {
  font-size: 13px;
  color: #9ca3af;
}

/* Content Grid */
.content-grid {
  display: grid;
  grid-template-columns: 2fr 1fr;
  gap: 24px;
}

.card {
  background: #111827;
  border: 1px solid #1f2937;
  border-radius: 16px;
  padding: 24px;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.card-header h3 {
  font-size: 16px;
  font-weight: 700;
  color: #fff;
}

.card-header small {
  color: #94a3b8;
  font-size: 12px;
}

.card-pills {
  display: flex;
  gap: 6px;
  background: #1f2937;
  padding: 4px;
  border-radius: 8px;
}

.pill {
  font-size: 12px;
  color: #94a3b8;
  padding: 4px 10px;
  border-radius: 6px;
  cursor: pointer;
}

.pill.active {
  background: #3b82f6;
  color: #fff;
  font-weight: 600;
}

.view-all {
  font-size: 13px;
  color: #60a5fa;
  text-decoration: none;
}

/* Chart Visual */
.chart-mock {
  height: 220px;
  display: flex;
  align-items: flex-end;
  padding-bottom: 12px;
}

.bar-chart-visual {
  width: 100%;
  height: 100%;
  display: flex;
  justify-content: space-between;
  align-items: flex-end;
  gap: 16px;
  padding: 0 12px;
}

.bar-col {
  flex: 1;
  height: var(--h);
  background: linear-gradient(180deg, #3b82f6 0%, rgba(59, 130, 246, 0.2) 100%);
  border-radius: 8px 8px 0 0;
  position: relative;
  transition: all 0.3s;
}

.bar-col.active-bar {
  background: linear-gradient(180deg, #6366f1 0%, rgba(99, 102, 241, 0.3) 100%);
}

.bar-col:hover {
  opacity: 0.85;
}

.bar-col span {
  position: absolute;
  bottom: -24px;
  left: 50%;
  transform: translateX(-50%);
  font-size: 11px;
  color: #64748b;
}

.chart-footer {
  display: flex;
  justify-content: space-around;
  margin-top: 36px;
  padding-top: 20px;
  border-top: 1px solid #1f2937;
}

.stat-item {
  display: flex;
  align-items: center;
  gap: 10px;
}

.dot {
  width: 10px;
  height: 10px;
  border-radius: 50%;
}
.dot.blue { background: #3b82f6; }
.dot.green { background: #10b981; }
.dot.purple { background: #6366f1; }

.stat-item strong {
  display: block;
  font-size: 15px;
  color: #fff;
}
.stat-item small {
  font-size: 11px;
  color: #94a3b8;
}

/* App list */
.app-list {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.app-item {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 12px;
  background: #1e293b;
  border-radius: 12px;
}

.app-avatar {
  width: 38px;
  height: 38px;
  background: linear-gradient(135deg, #4f46e5, #06b6d4);
  border-radius: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 700;
  color: #fff;
}

.app-details {
  flex: 1;
}
.app-details strong {
  font-size: 14px;
  color: #fff;
  display: block;
}
.app-details small {
  font-size: 11px;
  color: #94a3b8;
}

.app-meta {
  display: flex;
  align-items: center;
  gap: 10px;
}

.status-pill {
  font-size: 11px;
  padding: 2px 8px;
  border-radius: 12px;
  text-transform: capitalize;
}
.status-pill.active { background: rgba(16, 185, 129, 0.15); color: #10b981; }
.status-pill.staging { background: rgba(245, 158, 11, 0.15); color: #f59e0b; }

.launch-btn {
  background: #334155;
  color: #fff;
  width: 28px;
  height: 28px;
  border-radius: 6px;
  display: flex;
  align-items: center;
  justify-content: center;
  text-decoration: none;
  font-size: 14px;
}

/* Table */
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
  padding: 12px;
  border-bottom: 1px solid #1f2937;
}

.portal-table td {
  padding: 14px 12px;
  font-size: 13px;
  border-bottom: 1px solid #1f2937;
  color: #e2e8f0;
}

.font-mono { font-family: 'JetBrains Mono', monospace; }
.text-muted { color: #64748b; }
.text-secondary { color: #94a3b8; }
.text-blue { color: #60a5fa; }
.font-medium { font-weight: 500; }

.badge {
  font-size: 11px;
  padding: 3px 8px;
  border-radius: 6px;
  font-weight: 600;
}

.badge-success { background: rgba(16, 185, 129, 0.15); color: #10b981; }
.badge-warning { background: rgba(245, 158, 11, 0.15); color: #f59e0b; }
.badge-danger { background: rgba(239, 68, 68, 0.15); color: #ef4444; }
.badge-info { background: rgba(59, 130, 246, 0.15); color: #60a5fa; }

@media (max-width: 1100px) {
  .kpi-grid { grid-template-columns: repeat(2, 1fr); }
  .content-grid { grid-template-columns: 1fr; }
}
</style>
