<script setup lang="ts">
import { ref, computed } from 'vue'
import AdminLayout from '../layouts/AdminLayout.vue'
import { mockLogs, type AuditLog } from '../data/mockData'

const logs = ref<AuditLog[]>([...mockLogs])
const filterLevel = ref('all')
const searchQuery = ref('')
const isStreaming = ref(true)

const levels = ['all', 'info', 'warn', 'error', 'success']

const filteredLogs = computed(() => {
  return logs.value.filter(l => {
    const matchLevel = filterLevel.value === 'all' || l.level === filterLevel.value
    const matchSearch = l.action.toLowerCase().includes(searchQuery.value.toLowerCase()) ||
                        l.actor.toLowerCase().includes(searchQuery.value.toLowerCase()) ||
                        l.target.toLowerCase().includes(searchQuery.value.toLowerCase()) ||
                        l.details.toLowerCase().includes(searchQuery.value.toLowerCase()) ||
                        l.ip.includes(searchQuery.value)
    return matchLevel && matchSearch
  })
})

const getBadgeClass = (lvl: string) => {
  if (lvl === 'success') return 'badge-success'
  if (lvl === 'warn') return 'badge-warn'
  if (lvl === 'error') return 'badge-error'
  return 'badge-info'
}

const clearLogs = () => {
  logs.value = []
}

const generateSampleLog = () => {
  const sampleActions = ['TOKEN_REFRESH', 'SANDBOX_RELOAD', 'CACHE_PURGE', 'RATE_LIMIT_HIT']
  const sampleActors = ['SYSTEM_DAEMON', 'Phanna Pang', 'Cron Worker', 'Gateway Router']
  const sampleTargets = ['mini-cinema', 'smart-mini-app', 'Payment Proxy', 'Auth Server']
  const sampleLevels: ('info' | 'warn' | 'error' | 'success')[] = ['info', 'warn', 'success', 'error']

  const randomIdx = Math.floor(Math.random() * 4)

  logs.value.unshift({
    id: `log-${Date.now()}`,
    timestamp: new Date().toISOString().replace('T', ' ').slice(0, 19),
    action: sampleActions[randomIdx],
    actor: sampleActors[randomIdx],
    target: sampleTargets[randomIdx],
    level: sampleLevels[randomIdx],
    details: 'Auto-generated telemetry heartbeat snapshot',
    ip: '10.244.0.8'
  })
}
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

          <div class="level-filters">
            <button
              v-for="lvl in levels"
              :key="lvl"
              class="lvl-btn"
              :class="{ 'active': filterLevel === lvl }"
              @click="filterLevel = lvl"
            >
              {{ lvl.toUpperCase() }}
            </button>
          </div>
        </div>

        <div class="toolbar-right">
          <div class="search-box">
            <span>🔍</span>
            <input type="text" v-model="searchQuery" placeholder="Filter audit stream..." />
          </div>

          <button @click="generateSampleLog" class="btn btn-secondary">
            + Emit Event
          </button>
          <button @click="clearLogs" class="btn btn-danger">
            Clear Buffer
          </button>
        </div>
      </div>

      <!-- Console Log Terminal Container -->
      <div class="terminal-container glass-panel">
        <div class="terminal-header">
          <div class="dots">
            <span class="dot red"></span>
            <span class="dot yellow"></span>
            <span class="dot green"></span>
          </div>
          <span class="terminal-title">mini-portal-cluster-edge-tail: /var/log/audit.json</span>
          <span class="counter font-mono">{{ filteredLogs.length }} events</span>
        </div>

        <div class="terminal-body font-mono">
          <div v-if="filteredLogs.length === 0" class="empty-logs">
            [No telemetry records matched current criteria]
          </div>

          <div v-for="log in filteredLogs" :key="log.id" class="log-line">
            <span class="time">{{ log.timestamp }}</span>
            <span class="lvl-badge" :class="getBadgeClass(log.level)">{{ log.level.toUpperCase() }}</span>
            <span class="action">[{{ log.action }}]</span>
            <span class="actor">&lt;{{ log.actor }}&gt;</span>
            <span class="target">{{ log.target }}</span>
            <span class="ip text-muted">({{ log.ip }})</span>
            <span class="details">{{ log.details }}</span>
          </div>
        </div>
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
}

.toolbar-left, .toolbar-right {
  display: flex;
  align-items: center;
  gap: 12px;
}

.live-pill {
  display: flex;
  align-items: center;
  gap: 8px;
  background: rgba(16, 185, 129, 0.15);
  border: 1px solid rgba(16, 185, 129, 0.3);
  color: #10b981;
  padding: 6px 12px;
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
  animation: pulse 1.5s infinite;
}

@keyframes pulse {
  0% { transform: scale(0.95); opacity: 0.7; }
  50% { transform: scale(1.3); opacity: 1; }
  100% { transform: scale(0.95); opacity: 0.7; }
}

.level-filters {
  display: flex;
  gap: 6px;
}

.lvl-btn {
  background: #1f2937;
  border: 1px solid #374151;
  color: #9ca3af;
  padding: 6px 10px;
  border-radius: 6px;
  font-size: 11px;
  font-weight: 600;
  cursor: pointer;
}

.lvl-btn.active {
  background: #3b82f6;
  color: #fff;
  border-color: #3b82f6;
}

.search-box {
  display: flex;
  align-items: center;
  gap: 8px;
  background: #0f172a;
  border: 1px solid #374151;
  padding: 6px 12px;
  border-radius: 8px;
}

.search-box input {
  background: transparent;
  border: none;
  color: #fff;
  font-size: 13px;
  outline: none;
}

.btn {
  padding: 6px 14px;
  border-radius: 6px;
  font-size: 12px;
  font-weight: 600;
  cursor: pointer;
  border: none;
}

.btn-secondary {
  background: #1f2937;
  border: 1px solid #374151;
  color: #cbd5e1;
}

.btn-danger {
  background: rgba(239, 68, 68, 0.2);
  border: 1px solid rgba(239, 68, 68, 0.4);
  color: #fca5a5;
}

/* Terminal */
.terminal-container {
  background: #090d16;
  border: 1px solid #1f2937;
  border-radius: 14px;
  overflow: hidden;
}

.terminal-header {
  background: #111827;
  padding: 12px 16px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  border-bottom: 1px solid #1f2937;
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
  font-size: 12px;
  color: #94a3b8;
}

.counter {
  font-size: 12px;
  color: #64748b;
}

.terminal-body {
  padding: 16px;
  min-height: 480px;
  max-height: 600px;
  overflow-y: auto;
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.log-line {
  display: flex;
  align-items: center;
  gap: 10px;
  font-size: 12px;
  padding: 4px 8px;
  border-radius: 6px;
  transition: background 0.15s;
}

.log-line:hover {
  background: rgba(255, 255, 255, 0.03);
}

.time { color: #64748b; }
.action { color: #60a5fa; font-weight: 600; }
.actor { color: #e2e8f0; }
.target { color: #c084fc; }
.ip { color: #475569; }
.details { color: #cbd5e1; flex: 1; }

.lvl-badge {
  font-size: 10px;
  padding: 1px 6px;
  border-radius: 4px;
  font-weight: 700;
}
.badge-success { background: rgba(16, 185, 129, 0.2); color: #10b981; }
.badge-warn { background: rgba(245, 158, 11, 0.2); color: #f59e0b; }
.badge-error { background: rgba(239, 68, 68, 0.2); color: #ef4444; }
.badge-info { background: rgba(59, 130, 246, 0.2); color: #60a5fa; }

.empty-logs {
  color: #475569;
  text-align: center;
  margin-top: 40px;
}
</style>
