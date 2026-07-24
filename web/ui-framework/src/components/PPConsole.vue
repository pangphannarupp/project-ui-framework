<template>
  <div class="pp-console-wrapper">
    <!-- Floating Toggle Button -->
    <button 
      v-if="!isOpen" 
      class="pp-console-toggle" 
      @click="isOpen = true"
    >
      vConsole
    </button>

    <!-- Console Panel -->
    <transition name="slide-up">
      <div v-if="isOpen" class="pp-console-panel">
        <div class="pp-console-header">
          <div class="pp-console-tabs">
            <button 
              class="pp-console-tab" 
              :class="{ 'is-active': activeTab === 'all' }"
              @click="activeTab = 'all'"
            >
              All
            </button>
            <button 
              class="pp-console-tab" 
              :class="{ 'is-active': activeTab === 'error' }"
              @click="activeTab = 'error'"
            >
              Errors
            </button>
          </div>
          <div class="pp-console-actions">
            <button class="pp-console-btn" @click="clearLogs">Clear</button>
            <button class="pp-console-btn" @click="isOpen = false">Hide</button>
          </div>
        </div>

        <div class="pp-console-body" ref="logsContainer">
          <div 
            v-for="(log, index) in filteredLogs" 
            :key="index"
            class="pp-console-row"
            :class="`log-${log.type}`"
          >
            <span class="pp-console-time">{{ formatTime(log.timestamp) }}</span>
            <span class="pp-console-type">[{{ log.type }}]</span>
            <span class="pp-console-message">{{ formatArgs(log.args) }}</span>
          </div>
          <div v-if="filteredLogs.length === 0" class="pp-console-empty">
            No logs to display
          </div>
        </div>
      </div>
    </transition>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted, onUnmounted, nextTick } from 'vue';

interface LogEntry {
  type: 'log' | 'info' | 'warn' | 'error' | 'debug';
  args: any[];
  timestamp: Date;
}

const isOpen = ref(false);
const activeTab = ref<'all' | 'error'>('all');
const logs = ref<LogEntry[]>([]);
const logsContainer = ref<HTMLElement | null>(null);

const originalConsole: Record<string, any> = {};

const formatTime = (date: Date) => {
  const pad = (n: number) => n.toString().padStart(2, '0');
  return `${pad(date.getHours())}:${pad(date.getMinutes())}:${pad(date.getSeconds())}`;
};

const formatArgs = (args: any[]) => {
  return args.map(arg => {
    if (typeof arg === 'object') {
      try {
        return JSON.stringify(arg, null, 2);
      } catch (e) {
        return String(arg);
      }
    }
    return String(arg);
  }).join(' ');
};

const filteredLogs = computed(() => {
  if (activeTab.value === 'error') {
    return logs.value.filter(log => log.type === 'error');
  }
  return logs.value;
});

const clearLogs = () => {
  logs.value = [];
};

const setupConsoleIntercept = () => {
  const types: Array<'log' | 'info' | 'warn' | 'error' | 'debug'> = ['log', 'info', 'warn', 'error', 'debug'];
  
  types.forEach(type => {
    originalConsole[type] = console[type];
    
    console[type] = (...args: any[]) => {
      // Call original first
      originalConsole[type](...args);
      
      // Store log
      logs.value.push({
        type,
        args,
        timestamp: new Date()
      });
      
      // Auto-scroll
      if (isOpen.value) {
        nextTick(() => {
          if (logsContainer.value) {
            logsContainer.value.scrollTop = logsContainer.value.scrollHeight;
          }
        });
      }
    };
  });
};

const restoreConsole = () => {
  Object.keys(originalConsole).forEach(type => {
    (console as any)[type] = originalConsole[type];
  });
};

onMounted(() => {
  setupConsoleIntercept();
});

onUnmounted(() => {
  restoreConsole();
});
</script>

<style scoped>
.pp-console-wrapper {
  position: fixed;
  z-index: 99999;
  bottom: 0;
  right: 0;
}

.pp-console-toggle {
  position: fixed;
  bottom: 20px;
  right: 20px;
  background-color: #047857;
  color: white;
  border: none;
  padding: 8px 16px;
  border-radius: 20px;
  font-size: 14px;
  font-weight: 600;
  cursor: pointer;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
  transition: transform 0.2s, background-color 0.2s;
}

.pp-console-toggle:hover {
  background-color: #059669;
  transform: scale(1.05);
}

.pp-console-toggle:active {
  transform: scale(0.95);
}

.pp-console-panel {
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  height: 40vh;
  min-height: 250px;
  background-color: #f8fafc;
  display: flex;
  flex-direction: column;
  border-top: 1px solid #cbd5e1;
  box-shadow: 0 -4px 6px -1px rgba(0, 0, 0, 0.1);
  font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", "Courier New", monospace;
}

.pp-console-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  background-color: #e2e8f0;
  padding: 0 8px;
  border-bottom: 1px solid #cbd5e1;
}

.pp-console-tabs {
  display: flex;
}

.pp-console-tab {
  background: none;
  border: none;
  padding: 8px 16px;
  font-size: 13px;
  color: #64748b;
  cursor: pointer;
  font-weight: 600;
  border-bottom: 2px solid transparent;
}

.pp-console-tab.is-active {
  color: #0f172a;
  border-bottom-color: #3b82f6;
}

.pp-console-actions {
  display: flex;
  gap: 8px;
}

.pp-console-btn {
  background: #f1f5f9;
  border: 1px solid #cbd5e1;
  border-radius: 4px;
  padding: 4px 12px;
  font-size: 12px;
  cursor: pointer;
  color: #475569;
}

.pp-console-btn:hover {
  background: #e2e8f0;
}

.pp-console-body {
  flex: 1;
  overflow-y: auto;
  padding: 8px 0;
  background-color: #ffffff;
}

.pp-console-row {
  padding: 4px 12px;
  font-size: 12px;
  border-bottom: 1px solid #f1f5f9;
  display: flex;
  gap: 8px;
  align-items: flex-start;
  word-break: break-all;
  white-space: pre-wrap;
}

.pp-console-time {
  color: #94a3b8;
  flex-shrink: 0;
}

.pp-console-type {
  font-weight: bold;
  text-transform: uppercase;
  font-size: 11px;
  flex-shrink: 0;
  width: 50px;
}

.pp-console-message {
  color: #334155;
  flex: 1;
}

/* Log Types */
.log-log .pp-console-type { color: #3b82f6; }
.log-info .pp-console-type { color: #0ea5e9; }
.log-info { background-color: #f0f9ff; }
.log-warn .pp-console-type { color: #f59e0b; }
.log-warn { background-color: #fffbeb; }
.log-warn .pp-console-message { color: #b45309; }
.log-error .pp-console-type { color: #ef4444; }
.log-error { background-color: #fef2f2; }
.log-error .pp-console-message { color: #b91c1c; }
.log-debug .pp-console-type { color: #8b5cf6; }

.pp-console-empty {
  padding: 24px;
  text-align: center;
  color: #94a3b8;
  font-size: 13px;
}

/* Animations */
.slide-up-enter-active,
.slide-up-leave-active {
  transition: transform 0.3s ease-out;
}
.slide-up-enter-from,
.slide-up-leave-to {
  transform: translateY(100%);
}
</style>
