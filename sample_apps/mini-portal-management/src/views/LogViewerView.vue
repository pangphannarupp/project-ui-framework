<script setup lang="ts">
import AdminLayout from '../layouts/AdminLayout.vue'
import { useLogViewerViewModel } from '../viewmodels/useLogViewerViewModel'

const {
  isLoading,
  filterLevel,
  searchQuery,
  isStreaming,
  currentPage,
  pageSize,
  totalFilteredLogs,
  levels,
  filteredLogs,
  paginatedLogs,
  getBadgeVariant,
  clearLogs,
  generateSampleLog
} = useLogViewerViewModel()
</script>

<template>
  <AdminLayout>
    <div class="log-viewer-view">
      <div class="toolbar glass-panel">
        <div class="toolbar-left">
          <div class="live-pill" :class="{ 'pulse': isStreaming }">
            <span class="live-dot"></span>
            <span>{{ isStreaming ? 'Live Stream Active' : 'Stream Paused' }}</span>
          </div>

          <div class="level-segment-wrapper">
            <PPSegment v-model="filterLevel" variant="pill">
              <PPSegmentButton
                v-for="lvl in levels"
                :key="lvl"
                :value="lvl"
              >
                {{ lvl.toUpperCase() }}
              </PPSegmentButton>
            </PPSegment>
          </div>
        </div>

        <div class="toolbar-right">
          <div class="search-box">
            <PPInput v-model="searchQuery" placeholder="Filter audit stream..." />
          </div>

          <PPButton size="small" variant="primary" @click="generateSampleLog">
            <span>+ Emit Event</span>
          </PPButton>
          <PPButton size="small" variant="outline" @click="clearLogs">
            <span>Clear Buffer</span>
          </PPButton>
        </div>
      </div>

      <!-- Console Log Terminal Container with PPSkeleton -->
      <div class="terminal-container glass-panel">
        <div class="terminal-header">
          <div class="dots">
            <span class="dot red"></span>
            <span class="dot yellow"></span>
            <span class="dot green"></span>
          </div>
          <span class="terminal-title">cluster-telemetry-output.log — /dev/pts/1</span>
          <span class="terminal-counter">{{ totalFilteredLogs }} events</span>
        </div>

        <PPSkeleton :loading="isLoading" :animated="true">
          <template #template>
            <div class="skeleton-table" style="background: transparent; padding: 16px 20px;">
              <div v-for="i in 6" :key="i" style="display: flex; align-items: center; justify-content: space-between; gap: 14px;">
                <PPSkeletonItem variant="text" width="140px" />
                <PPSkeletonItem variant="rect" width="70px" height="22px" style="border-radius: 6px;" />
                <PPSkeletonItem variant="text" width="130px" />
                <PPSkeletonItem variant="text" width="100px" />
                <PPSkeletonItem variant="text" width="120px" />
                <PPSkeletonItem variant="text" width="90px" />
                <PPSkeletonItem variant="text" width="30%" />
              </div>
            </div>
          </template>

          <div class="table-wrapper">
            <table class="log-table">
              <thead>
                <tr>
                  <th>TIMESTAMP</th>
                  <th>LEVEL</th>
                  <th>ACTION</th>
                  <th>ACTOR</th>
                  <th>TARGET COMPONENT</th>
                  <th>IP ORIGIN</th>
                  <th>EVENT DETAILS</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="log in paginatedLogs" :key="log.id" class="log-row">
                  <td class="font-mono text-dim">{{ log.timestamp }}</td>
                  <td>
                    <PPChip
                      :label="log.level.toUpperCase()"
                      :color="getBadgeVariant(log.level)"
                      size="sm"
                      variant="soft"
                    />
                  </td>
                  <td class="font-bold text-accent">{{ log.action }}</td>
                  <td class="text-white">{{ log.actor }}</td>
                  <td class="text-cyan">{{ log.target }}</td>
                  <td class="font-mono text-dim">{{ log.ip }}</td>
                  <td class="text-muted">{{ log.details }}</td>
                </tr>
                <tr v-if="filteredLogs.length === 0">
                  <td colspan="7" class="empty-terminal">
                    No log records match the current stream criteria.
                  </td>
                </tr>
              </tbody>
            </table>
          </div>

          <!-- Log Pagination Bar -->
          <div v-if="totalFilteredLogs > pageSize" class="log-pagination-bar">
            <span class="pagination-summary">
              Showing <strong>{{ ((currentPage - 1) * pageSize) + 1 }}</strong> to
              <strong>{{ Math.min(currentPage * pageSize, totalFilteredLogs) }}</strong> of
              <strong>{{ totalFilteredLogs }}</strong> log entries
            </span>
            <PPPagination
              :total="totalFilteredLogs"
              :page-size="pageSize"
              :current-page="currentPage"
              variant="outline"
              shape="rounded"
              size="normal"
              @update:current-page="(page: number) => currentPage = page"
            />
          </div>
        </PPSkeleton>
      </div>
    </div>
  </AdminLayout>
</template>

<style scoped>
.log-viewer-view {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.toolbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px 20px;
  background: #111827;
  border: 1px solid #1f2937;
  border-radius: 14px;
  flex-wrap: wrap;
  gap: 16px;
}

.toolbar-left {
  display: flex;
  align-items: center;
  gap: 16px;
  flex-wrap: wrap;
}

.live-pill {
  display: flex;
  align-items: center;
  gap: 8px;
  background: rgba(16, 185, 129, 0.15);
  border: 1px solid #10b981;
  color: #10b981;
  padding: 6px 14px;
  border-radius: 20px;
  font-size: 12px;
  font-weight: 600;
}

.live-dot {
  width: 8px;
  height: 8px;
  background: #10b981;
  border-radius: 50%;
}

.live-pill.pulse .live-dot {
  box-shadow: 0 0 0 rgba(16, 185, 129, 0.6);
  animation: pulse 1.8s infinite;
}

@keyframes pulse {
  0% { box-shadow: 0 0 0 0 rgba(16, 185, 129, 0.7); }
  70% { box-shadow: 0 0 0 8px rgba(16, 185, 129, 0); }
  100% { box-shadow: 0 0 0 0 rgba(16, 185, 129, 0); }
}

.level-segment-wrapper :deep(.pp-segment) {
  background-color: #0f172a !important;
  border: 1px solid #1f2937 !important;
  padding: 3px !important;
}

.level-segment-wrapper :deep(.pp-segment-button) {
  padding: 5px 12px !important;
  font-size: 11px !important;
  font-weight: 700 !important;
  color: #94a3b8 !important;
  border-radius: 20px !important;
  letter-spacing: 0.5px !important;
}

.level-segment-wrapper :deep(.pp-segment-button--active) {
  color: #ffffff !important;
  font-weight: 700 !important;
}

.level-segment-wrapper :deep(.pp-segment-indicator) {
  background-color: #2563eb !important;
  border-radius: 20px !important;
  box-shadow: 0 2px 8px rgba(37, 99, 235, 0.4) !important;
}

.toolbar-right {
  display: flex;
  align-items: center;
  gap: 12px;
}

.search-box {
  width: 220px;
}

.terminal-container {
  background: #090d16;
  border: 1px solid #1f2937;
  border-radius: 16px;
  overflow: hidden;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
}

.terminal-header {
  background: #0f172a;
  padding: 12px 18px;
  border-bottom: 1px solid #1f2937;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.dots {
  display: flex;
  gap: 6px;
}

.dot {
  width: 10px;
  height: 10px;
  border-radius: 50%;
}

.dot.red { background: #ef4444; }
.dot.yellow { background: #f59e0b; }
.dot.green { background: #10b981; }

.terminal-title {
  font-family: 'JetBrains Mono', monospace;
  font-size: 12px;
  color: #94a3b8;
}

.terminal-counter {
  font-size: 11px;
  color: #64748b;
  font-family: 'JetBrains Mono', monospace;
}

.table-wrapper {
  overflow-x: auto;
  max-height: 600px;
}

.log-table {
  width: 100%;
  border-collapse: collapse;
  text-align: left;
  font-size: 13px;
}

.log-table th {
  background: #0f172a;
  color: #64748b;
  font-size: 11px;
  letter-spacing: 0.5px;
  padding: 12px 16px;
  border-bottom: 1px solid #1f2937;
}

.log-row td {
  padding: 12px 16px;
  border-bottom: 1px solid rgba(31, 41, 55, 0.5);
}

.log-row:hover {
  background: rgba(30, 41, 59, 0.4);
}

.text-dim { color: #64748b; }
.text-accent { color: #818cf8; }
.text-cyan { color: #38bdf8; }
.text-white { color: #f8fafc; font-weight: 500; }
.text-muted { color: #94a3b8; }
.empty-terminal {
  text-align: center;
  padding: 40px;
  color: #64748b;
  font-style: italic;
}

.log-pagination-bar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 14px 20px;
  background: #0f172a;
  border-top: 1px solid #1f2937;
  flex-wrap: wrap;
  gap: 12px;
}

.pagination-summary {
  font-size: 12px;
  color: #94a3b8;
}

.pagination-summary strong {
  color: #f8fafc;
}
</style>
